> 中文翻译 | [English](../../../.claude/rules/shader-code.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。英文版含 paths frontmatter(路径作用域声明),中文版从略。

# 着色器代码标准

`assets/shaders/` 中的所有着色器文件必须遵循以下标准,以保持视觉质量、性能和跨平台兼容性。

## 命名约定
- 文件命名:`[type]_[category]_[name].[ext]`
  - `spatial_env_water.gdshader`(Godot)
  - `SG_Env_Water`(Unity Shader Graph)
  - `M_Env_Water`(Unreal Material)
- 使用能体现材质用途的描述性名称
- 以着色器类型为前缀:`spatial_`、`canvas_`、`particles_`、`post_`

## 代码质量
- 所有 uniform/参数必须有描述性名称和合适的提示(hint)
- 相关参数分组(Godot:`group_uniforms`,Unity:`[Header]`,Unreal:Category)
- 为非显而易见的计算添加注释(尤其是数学密集的部分)
- 不使用魔法数字——使用命名常量或有文档说明的 uniform 值
- 在每个着色器文件顶部包含作者和用途注释

## 性能要求
- 为每个着色器记录目标平台和复杂度预算
- 使用合适的精度:移动端在不需要全精度时使用 `half`/`mediump`
- 尽量减少片元着色器中的纹理采样
- 避免片元着色器中的动态分支——使用 `step()`、`mix()`、`smoothstep()`
- 循环内不做纹理读取
- 模糊效果采用两趟(two-pass)方式(先水平后垂直)

## 跨平台
- 在最低配置目标硬件上测试着色器
- 为较低画质档位提供回退/简化版本
- 记录着色器面向的渲染管线(Forward/Deferred、URP/HDRP、Forward+/Mobile/Compatibility)
- 不要在同一目录混用不同渲染管线的着色器

## 变体管理
- 尽量减少着色器变体——每个变体都是单独编译的着色器
- 记录所有关键字/变体及其用途
- 尽可能使用特性剥离(feature stripping)以减小构建体积
- 记录并监控每个着色器的变体总数
