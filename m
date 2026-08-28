Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3112C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503F910F3E0;
	Fri, 28 Aug 2026 14:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OAxWSrun";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3E110F3E2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:19:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53189601FD;
 Fri, 28 Aug 2026 14:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5F81F00A3A;
 Fri, 28 Aug 2026 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787926764;
 bh=ZrfJoAqnzToUnaZRmCo0rBGl4IzoiTcV7PLOMTYOgig=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OAxWSrunmc9YH9CS19mL2dlDtNblWdy+/OUSFt+Tf6mcml4rcEY7PCfWJAWREwdUk
 UjtGAjlQN4/fQS8GtGIg004qdv2sN7ZnezcvXyKTa+K/yEcllHTcqUl0wIE0sg5Ssd
 t257IGyVUJnFakIBCQPQOPROrsknzf95bb0uRjlSPiAC9JHMW+6m0Cy6TIBgCtQKeZ
 5yohLJqBFVxK4BLgRftyOiRIc94Sbzod9sjjyFknSnYR4iWXr33EHR1I8UBtnfVgm/
 PyMYtsSup0xKt7fp+73lRiyJkt0X2IaazKd8cDXc2fJ1heOlfY8PvDl79Cr5dYP04u
 AHYwXLoU5Qx3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC/DO NOT MERGE 10/12] drm/msm/hdmi_phy_eliza: Add
 support for Synopsys-based HDMI phy on Eliza
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org, robh@kernel.org,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org, olteanv@gmail.com,
 vkoul@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-10-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-10-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:19:23 +0000
Message-Id: <20260828141923.8E5F81F00A3A@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Silent truncation of 64-bit integers passed to `gcd()` on 32-bit a=
rchitectures leads to incorrect clock calculations.
- [High] 32-bit integer overflow during PHY bit rate calculation causes inc=
orrect hardware configuration for high-bandwidth displays.
- [High] Deterministic division by zero during CCF clock registration due t=
o uninitialized configuration.
- [High] Severe CPU soft lockup risk due to excessive 3-second busy-wait lo=
op using `readl_poll_timeout_atomic`.
- [High] Premature integer division causes precision loss yielding incorrec=
t hardware PLL parameters.
- [Medium] Data race on PLL configuration state by bypassing Common Clock F=
ramework (CCF) synchronization.
- [Low] 64-bit division using '/' and standard division macros causes build=
 failure on 32-bit platforms.
- [Low] Unsupported floating-point literals used in integer calculations.
- [Low] Use of `mdelay(8)` wastes CPU resources in a sleepable context.
- [Low] Fragile design conflates the presence of PHY regulators with the na=
me format of device tree memory resources.
--

commit 9c53defce3c459b1740fbff4f2434baad5c70aee
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: drm/msm/hdmi_phy_eliza: Add support for Synopsys-based HDMI phy on=
 Eliza

Add driver for HDMI phy block from Synopsys used on Eliza SoC. Adjust core
parts for handling HDMI phy initialization sequence.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hd=
mi/hdmi_phy.c
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> @@ -168,13 +171,17 @@ static int msm_hdmi_phy_probe(struct platform_devic=
e *pdev)
>  	if (!phy->cfg)
>  		return -ENODEV;
> =20
> -	phy->mmio =3D msm_ioremap(pdev, "hdmi_phy");
> +	if (phy->cfg->num_regs)
> +		phy->mmio =3D msm_ioremap(pdev, "hdmi_phy");
> +	else
> +		phy->mmio =3D msm_ioremap(pdev, NULL);

[Severity: Low]
Does this use a fragile heuristic? This logic overloads the presence of
power regulators (num_regs) to guess the format of device tree memory
resources. These two hardware properties are orthogonal, which could break
if future device tree bindings diverge.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_eliza.c b/drivers/gpu/drm/=
msm/hdmi/hdmi_phy_eliza.c
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_eliza.c
[ ... ]
> +static int hdmi_eliza_pll_calculator(struct hdmi_pll_eliza *pll,
> +				     unsigned long rate,
> +				     unsigned long parent_rate,
> +				     struct hdmi_eliza_phy_pll_reg_cfg *cfg)
> +{
[ ... ]
> +	s64 precision3 =3D 1e3;
> +	s64 precision6 =3D 1e6;

[Severity: Low]
Are these floating-point literals supported? Scientific notation defaults
to double literals, which relies on compiler implicit conversion to integer=
s.
The kernel strictly prohibits floating-point types.

[ ... ]
> +	/* expon =3D floor(log2(4.999999e9/base_rate)) */
> +	utemp =3D 4.999999e9;

[Severity: Low]
Are these floating-point literals supported? This is another instance where
scientific notation will evaluate as a double literal.

> +
> +	expon =3D fls64(utemp / base_rate) - 1;

[Severity: Low]
Can this cause a build failure on 32-bit platforms? The direct 64-bit
division operator triggers a dependency on __udivdi3, which is unresolved
on 32-bit architectures. do_div or div64_u64 should be used instead.

[ ... ]
> +	/* multiplier =3D 2*(floor(bit_rate) * 2**expon / ref_clk_int) -16) */
> +	multiplier =3D DIV_ROUND_UP(vco_freq, ref_clk_int);

[Severity: Low]
Could this also trigger a 32-bit build failure? DIV_ROUND_UP performs a
native division, and since vco_freq is a 64-bit value, this requires a 64-b=
it
division routine that is unavailable on 32-bit builds.

[ ... ]
> +	if (aux2 =3D=3D 0) {
> +		cfg->remainder =3D 0;
> +		cfg->denominator =3D 1;
> +	} else {
> +		cfg->remainder =3D DIV_ROUND_UP(aux2, gcd(aux1, aux2));
> +		cfg->denominator =3D DIV_ROUND_UP(aux1, gcd(aux1, aux2));

[Severity: High]
Does this truncate 64-bit values on 32-bit architectures? The gcd function
takes unsigned long parameters, which are 32-bit on 32-bit kernels. Since
aux1 and aux2 can hold values requiring up to 36 bits, they will be silently
truncated when passed into gcd, feeding incorrect fractions into the PLL
configuration.

[ ... ]
> +	/* stemp =3D (REF_CLK_MHZ/2**ref_ana_mpll_div) */
> +	stemp =3D (REF_CLK_HZ / 1000000) * precision3;

[Severity: High]
Does this premature division cause a loss of precision? REF_CLK_HZ is
divided by 1,000,000 first, which drops the remainder before scaling. With
REF_CLK_HZ at 38,400,000, the result truncates to 38 instead of preserving
the 0.4 MHz. The error is then squared later, propagating significant drift
into the PLL analog parameters.

[ ... ]
> +	cfg->cp_int_holder =3D DIV_ROUND_CLOSEST(stemp3, precision6);

[Severity: Low]
Can this result in a build failure on 32-bit architectures?=20
DIV_ROUND_CLOSEST triggers native division on s64 variables, which will fail
to link without __divdi3.

[ ... ]
> +static int hdmi_eliza_pll_prepare(struct clk_hw *hw)
> +{
[ ... ]
> +	/*
> +	 * This Synopsys PLL does not have a PLL lock-like register, thus there
> +	 * is no way to tell when the PLL actually locked.
> +	 * Returning now, would lead to stuck pclk or iface RCG clocks at off
> +	 * (disp_cc_mdss_hdmi_pclk_clk status stuck at 'off'),
> +	 * thus obviously the professional solution is to delay.
> +	 * 8 ms was figured out during tests, not based on any datasheet.
> +	 */
> +	mdelay(8);
> +
> +	return 0;
> +}

[Severity: Low]
Is mdelay strictly necessary here? Busy-waiting the CPU for 8 milliseconds
wastes resources in a context where sleeping is fully permitted. The prepare
callback can safely yield the CPU using msleep or usleep_range.

[ ... ]
> +static u64 hdmi_eliza_pll_vco_freq(u64 ref_clk_hz, u32 multiplier, u32 f=
rac_quot,
> +				   u32 frac_rem, u32 frac_den)
> +{
> +	u64 num;
> +	u64 den;
> +
> +	num =3D 32ULL * 65536ULL * frac_den +
> +		(u64)multiplier * 65536ULL * frac_den +
> +		2ULL * ((u64)frac_quot * frac_den + frac_rem);
> +
> +	den =3D 2ULL * 65536ULL * frac_den;
> +
> +	return mul_u64_u64_div_u64(ref_clk_hz, num, den);
> +}
> +
> +static unsigned long hdmi_eliza_pll_recalc_rate(struct clk_hw *hw,
> +					       unsigned long parent_rate)
> +{
> +	struct hdmi_pll_eliza *pll =3D hw_clk_to_pll(hw);
> +	u64 rate;
> +
> +	rate =3D hdmi_eliza_pll_vco_freq(REF_CLK_HZ, pll->cfg.multiplier,
> +				       pll->cfg.quotient, pll->cfg.remainder,
> +				       pll->cfg.denominator);
[ ... ]
> +int msm_hdmi_pll_eliza_init(struct platform_device *pdev)
> +{
[ ... ]
> +	pll =3D devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
[ ... ]
> +	ret =3D devm_clk_hw_register(dev, &pll->clk_hw);

[Severity: High]
Can this lead to a division by zero during probe?=20

When devm_clk_hw_register is called, the Common Clock Framework immediately
invokes recalc_rate. Because the pll structure is zero-allocated,
pll->cfg.denominator is zero. This zero is passed into
hdmi_eliza_pll_vco_freq, which results in den evaluating to 0 and
triggering a kernel panic in mul_u64_u64_div_u64.

[ ... ]
> +static void hdmi_eliza_phy_tx_lane_config(struct hdmi_phy *phy,
> +					  unsigned long pixclock)
> +{
> +	const unsigned int bpp =3D 24;
[ ... ]
> +	if (pixclock * bpp >=3D HDMI_PHY_MAX_BIT_RATE)
> +		hdmi_phy_update_bits(phy, REG_HDMI_ELIZA_PHY_TX_COMMON_CONTROL_0, BIT(=
2), 0);
> +	else

[Severity: High]
Will this calculation overflow 32-bit bounds before the comparison?=20

The pixclock parameter is typed as unsigned long, which is 32-bit on 32-bit
kernels. For high bandwidth displays, multiplying a high pixclock by 24 will
exceed the 32-bit integer maximum of 4.29 billion. This overflow will result
in a smaller wrapped value, breaking the conditional check and incorrectly
programming the PHY for high-resolution displays.

[ ... ]
> +static int hdmi_eliza_phy_ready_poll(struct hdmi_phy *phy, u32 reg, u32 =
mask, u32 val)
> +{
> +	u32 state;
> +	const u32 sleep_us =3D 2000;
> +	const u32 timeout_us =3D 3000000;
> +
> +	if (readl_poll_timeout_atomic((phy->mmio + reg), state,
> +				      ((state & mask) =3D=3D val),
> +				      sleep_us, timeout_us)) {

[Severity: High]
Does this present a severe CPU soft lockup risk?=20

The readl_poll_timeout_atomic macro disables preemption and spins using a
udelay. Looping a 2000 microsecond delay for up to 3,000,000 microseconds
(3 seconds) violates scheduling rules and is very likely to trigger watchdog
lockups if the hardware fails to respond.

[ ... ]
> +static void hdmi_eliza_phy_init(struct hdmi_phy *phy,
> +				   unsigned long pixclock)
> +{
[ ... ]
> +	hdmi_eliza_pll_configure_pll(phy->pll, 396000000, 19200000);

[Severity: Medium]
Does this bypass the Common Clock Framework synchronization?=20

Directly invoking hdmi_eliza_pll_configure_pll here forcefully mutates the
shared pll->cfg state locklessly. CCF invariants generally mandate that=20
clock state modifications are protected by prepare_lock. Concurrently
reading the clock state from sysfs or debugfs could hit a data race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-drm-msm-hd=
mi-eliza-v1-0-67843277de17@oss.qualcomm.com?part=3D10
