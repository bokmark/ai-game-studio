> 中文翻译 | [English](economy-model.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 经济模型(Economy Model):[System Name]

*创建:[Date]*
*负责人:economy-designer*
*状态:[Draft / Balanced / Live]*

---

## 概览(Overview)

[本经济系统覆盖哪些资源、货币与交换体系?它激励哪些玩家行为?]

---

## 货币(Currencies)

| 货币 | 类型 | 获取速率 | 消耗速率 | 上限 | 备注 |
| ---- | ---- | ---- | ---- | ---- | ---- |
| [Gold] | Soft | [per hour] | [per hour] | [max or none] | [主要交易货币] |
| [Gems] | Premium | [per day F2P] | [varies] | [max] | [付费货币,可购买] |
| [XP] | Progression | [per action] | [level-up cost] | [none] | [不可交易] |

### 货币规则(Currency Rules)
- [Rule 1——例如:「软货币不设上限,但通过消耗出口控制通胀」]
- [Rule 2——例如:「付费货币不可反向兑换为真实货币」]
- [Rule 3]

---

## 来源(Sources / Faucets)

| 来源 | 货币 | 数量 | 频率 | 条件 |
| ---- | ---- | ---- | ---- | ---- |
| [Quest completion] | Gold | [50-200] | [per quest] | [随任务难度浮动] |
| [Enemy drops] | Gold | [1-10] | [per kill] | [受幸运属性修正] |
| [Daily login] | Gems | [5] | [daily] | [连续登录奖励:每连续一天 +1] |
| [Achievement] | XP | [100-500] | [one-time] | [按成就等级] |

---

## 消耗出口(Sinks / Drains)

| 出口 | 货币 | 成本 | 频率 | 用途 |
| ---- | ---- | ---- | ---- | ---- |
| [Equipment purchase] | Gold | [100-5000] | [as needed] | [强度成长] |
| [Repair costs] | Gold | [10-100] | [per death] | [死亡惩罚,金币消耗] |
| [Cosmetic shop] | Gems | [50-500] | [optional] | [装饰性,付费消耗出口] |
| [Respec] | Gold | [1000] | [rare] | [构筑试验税] |

---

## 平衡目标(Balance Targets)

| 指标 | 目标 | 理由 |
| ---- | ---- | ---- |
| 首次有意义购买的时间 | [X minutes] | [玩家应尽早感到有消费力] |
| 每小时金币获取速率(中期) | [X gold/hr] | [基于会话时长与购买节奏] |
| 满级所需天数(F2P) | [X days] | [足以留住玩家,又不长到令人沮丧] |
| 消耗/来源比率 | [0.7-0.9] | [略有盈余让玩家保持富足感] |
| 付费货币 F2P 获取速率 | [X/week] | [够每月买点东西,但买不全] |

---

## 进度曲线(Progression Curves)

### 升级经验需求(Level XP Requirements)
| 等级 | 所需经验 | 累计经验 | 预计时间 |
| ---- | ---- | ---- | ---- |
| 1→2 | [100] | [100] | [10 min] |
| 5→6 | [500] | [1,500] | [2 hrs] |
| 10→11 | [1,500] | [7,500] | [8 hrs] |
| 20→21 | [5,000] | [50,000] | [40 hrs] |

*公式*:`XP(n) = [formula, e.g., 100 * n^1.5]`

### 物品价格递升(Item Price Scaling)
*公式*:`Price(tier) = [formula, e.g., base_price * 2^(tier-1)]`

---

## 掉落表(Loot Tables)

### [Drop Source Name]
| 物品 | 稀有度 | 掉落率 | 保底计数 | 备注 |
| ---- | ---- | ---- | ---- | ---- |
| [Common item] | Common | [60%] | [N/A] | [始终有用,永不让人难受] |
| [Uncommon item] | Uncommon | [25%] | [N/A] | [可感知的提升] |
| [Rare item] | Rare | [12%] | [10 drops] | [令人兴奋,定义构筑] |
| [Legendary item] | Legendary | [3%] | [30 drops] | [改变游戏,值得庆祝的时刻] |

### 保底系统(Pity System)
[描述保底系统如何运作,以防止极端的连续坏运气。]

---

## 经济健康指标(Economy Health Metrics)

| 指标 | 健康区间 | 警告阈值 | 触发后的行动 |
| ---- | ---- | ---- | ---- |
| 玩家平均金币 | [X-Y at level Z] | [>Y or <X] | [调整来源/出口] |
| 金币基尼系数 | [<0.4] | [>0.5] | [财富过度集中] |
| 触及货币上限的玩家占比 | [<5%] | [>10%] | [提高上限或增加出口] |
| 付费转化率 | [2-5%] | [<1% or >10%] | [重新平衡 F2P 获取速率] |
| 两次购买之间的平均时间 | [X minutes] | [>Y minutes] | [没有值得买的东西] |

---

## 伦理护栏(Ethical Guardrails)

- [无付费制胜(pay-to-win):付费货币不能购买玩法强度优势]
- [所有随机掉落均有保底计数:X 次内必出]
- [向玩家公开透明展示掉落率]
- [未成年账号的消费限制]
- [对必需品不施加人为稀缺压力(FOMO 计时器)]

---

## 模拟结果(Simulation Results)

[如有经济模拟结果,请包含在内:玩家财富随时间的分布、消耗出口有效性、通货膨胀率等。]

---

## 依赖(Dependencies)

- 依赖于:[combat balance, quest design, crafting system]
- 影响:[difficulty curve, player retention, monetization]
- 必须协调:`game-designer`、`live-ops-designer`、`analytics-engineer`
