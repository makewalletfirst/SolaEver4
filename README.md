# SolaEver4  <br>
reward overflow fix  <br>
(validator 500000000 -> 1epoch reward is 2^128 overflow <br>


vi runtime/src/inflation_rewards/mod.rs 
186     // The final unwrap is safe, as points_value.points is guaranteed to be non zero above.
187     // 187라인 근처: 기존 expect 로직을 완전히 제거하고 unwrap_or로 교체
188     let rewards = points
189         .checked_mul(u128::from(point_value.rewards))
190         .unwrap_or(u128::MAX) // 패닉 문구 원천 삭제
191         .checked_div(point_value.points)
192         .unwrap_or(0);
193
194     let rewards = u64::try_from(rewards).unwrap_or(u64::MAX);
195
196     // don't bother trying to split if fractional lamports got truncated
197     if rewards == 0 {
198         if let Some(inflation_point_calc_tracer) = inflation_point_calc_tracer.as_ref() {
199             inflation_point_calc_tracer(&SkippedReason::ZeroReward.into());
200         }
201         return None;
202     }
