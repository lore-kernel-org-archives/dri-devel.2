Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D1AC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 22:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB52710E4E7;
	Sat, 12 Sep 2026 22:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X6geoXl3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A667910E4E7
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 22:01:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 726EC60142;
 Sat, 12 Sep 2026 22:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA7E1F000FF;
 Sat, 12 Sep 2026 22:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789250464;
 bh=EatkiM1A12Ll7lp9zCpPxIIn7SRWTf0oNDnWeqkLBpA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X6geoXl39TUtv4I2dmfpHLuaGbUDwnS+eMDhs4Nw79CPeIg9q9AibOL37sGn/1VYc
 1k+dAI1BWJLJf6+lgx9rdxQgET1RRadsn9cFQgMaLU++mbwtGnkFvObgyTrBY6OcZC
 D8pVsvNmZzjgTS7DbsR9NLTQmUdehRSeWCufkjpKK78UiHexlfQp2LFQrHR1M67WIZ
 4ODgAr+NPXREVV7XQ3qQORIk/zQjRNzsFkinNGBUswkT/oIRSqnUX8rB2i81tYNEYV
 Lx2luxKyTNAIdFC89Kxc26hBKAtFnAGxLVKnLL69aTqIJCQ0X9j8IE+cGQFk/JDbVf
 WWfv7dMnxNw6Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5] arm64: allwinner: add TrimUI Smart Pro (A133)
 board support
To: leow149 <leow149@lucidmail.xyz>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260912214317.106150-1-leow149@lucidmail.xyz>
References: <20260912114331.92956-1-leow149@lucidmail.xyz>
 <20260912214317.106150-1-leow149@lucidmail.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 22:01:03 +0000
Message-Id: <20260912220104.0BA7E1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Sleeping functions called from atomic encoder callbacks, violating=
 display subsystem rules.
- [High] TOCTOU race condition causing concurrent DSI retriggering during I=
RQ re-enable.
- [High] Integer underflow when computing `start_delay` with adversarial or=
 edge-case DRM display modes.
- [Medium] Resource leak in PWM driver: channel clock gate left permanently=
 enabled on disable.
- [Low] The 'allwinner,sun50i-a133-tcon-top' compatible string breaks devic=
e tree binding schema validation.

Pre-existing issues:
- [High] Use-After-Free (TOCTOU) in TCON TOP register access due to lack of=
 synchronization with device unbind.
- [High] Division by zero if the hardware DCLK divider register reads as ze=
ro.
--

commit 5601bade2c59d4b26ab64fee73a2b3036bf1fb38
Author: leow149 <leow149@lucidmail.xyz>

arm64: allwinner: add TrimUI Smart Pro (A133) board support

This commit adds board support for the TrimUI Smart Pro handheld. It
introduces new DTS configurations, a panel driver for the OTM1289A/ER68576,
a PWM driver, and modifies TCON/DSI code to support the A133 SoC's display
and PWM pipelines.

> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun8i-r4=
0-tcon-top.yaml b/Documentation/devicetree/bindings/display/allwinner,sun8i=
-r40-tcon-top.yaml
> --- a/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-=
top.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-=
top.yaml
> @@ -43,6 +43,7 @@ properties:
>        - allwinner,sun8i-r40-tcon-top
>        - allwinner,sun20i-d1-tcon-top
>        - allwinner,sun50i-h6-tcon-top
> +      - allwinner,sun50i-a133-tcon-top

[Severity: Low]
Does adding the A133 compatible here break dtbs_check validation for valid
device trees?

The A133 hardware lacks an HDMI mux and only uses port@0 and port@1. Howeve=
r,
the base schema unconditionally requires port@4 and port@5 across all
compatibles. This would cause a correct A133 device tree to be rejected
as invalid.

> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm1289a.c b/drivers/g=
pu/drm/panel/panel-orisetech-otm1289a.c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm1289a.c
> @@ -0,0 +1,424 @@
[ ... ]
> +static int otm1289a_prepare(struct drm_panel *panel)
> +{
> +	struct otm1289a *ctx =3D panel_to_otm1289a(panel);
> +	int ret;
> +
> +	ret =3D regulator_enable(ctx->supply);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to enable supply: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ctx->reset_gpio) {
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		msleep(20);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +		msleep(100);
> +	}

[Severity: High]
Can these msleep() calls execute in an atomic context?

If otm1289a_prepare() is invoked from an encoder's atomic enable callback
path (such as sun6i_dsi_encoder_enable), explicit sleeps are forbidden
and can cause deadlocks or kernel warnings.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -395,6 +608,18 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tc=
on *tcon,
>  	regmap_read(tcon->regs, SUN4I_TCON0_DCLK_REG, &tcon_div);
>  	tcon_div &=3D GENMASK(6, 0);
>  	block_space =3D mode->htotal * bpp / (tcon_div * lanes);

[Severity: High]
This is a pre-existing issue, but can tcon_div evaluate to 0 and cause a
division-by-zero panic here?

If the clock framework fails to configure the rate in clk_set_rate() earlier
in the function, SUN4I_TCON0_DCLK_REG might retain its reset value of 0.
The subsequent calculation would then divide by zero.

[ ... ]
> +	if (tcon->quirks->dsi_cpu_needs_retrigger) {
> +		start_delay =3D (mode->crtc_vtotal - mode->crtc_vdisplay - 9);
> +		start_delay =3D start_delay * mode->crtc_htotal * 300;

[Severity: High]
Is it possible for this subtraction to underflow if a custom DRM mode is
supplied?

If userspace supplies an edge-case DRM mode where mode->crtc_vtotal is less
than mode->crtc_vdisplay + 9, the subtraction evaluates to a negative numbe=
r.
When assigned to the unsigned start_delay variable, this wraps around to a
massive positive value, which would corrupt SUN4I_TCON0_CPU_TRI2_REG and
break display timings.

[ ... ]
> +static enum hrtimer_restart sun4i_tcon_dsi_retrigger_timer_fn(struct hrt=
imer *timer)
> +{
> +	struct sun4i_tcon *tcon =3D container_of(timer, struct sun4i_tcon,
> +						dsi_retrigger_timer);
> +	unsigned int cpu_if_before;
> +	unsigned int tick =3D tcon->dsi_retrigger_ticks;
> +	u32 dsi_int;
> +	bool busy;
> +
> +	regmap_read(tcon->regs, SUN4I_TCON0_CPU_IF_REG, &cpu_if_before);
> +	busy =3D cpu_if_before & SUN4I_TCON0_CPU_IF_TRI_START;
> +
> +	if (tick && !busy) {
> +		/* TRIGGER_START self-cleared; the IRQ path takes over from here. */
> +		return HRTIMER_NORESTART;
> +	}
> +
> +	dsi_int =3D sun6i_dsi_read_int_status(tcon->dsi);
> +	if (dsi_int & GENMASK(31, 16))
> +		sun6i_dsi_clear_int_status(tcon->dsi);
> +
> +	if (tick =3D=3D 0 && tcon->irq && !tcon->irq_enabled) {
> +		enable_irq(tcon->irq);
> +		tcon->irq_enabled =3D true;
> +	}
> +
> +	if (tick =3D=3D 0 && !busy) {
> +		sun6i_dsi_tri_start(tcon->dsi);
> +		regmap_update_bits(tcon->regs, SUN4I_TCON0_CPU_IF_REG,
> +				   SUN4I_TCON0_CPU_IF_TRI_START,
> +				   SUN4I_TCON0_CPU_IF_TRI_START);
> +	}

[Severity: High]
Can a race condition occur here if the interrupt line is unmasked?

The busy state is cached before calling enable_irq(tcon->irq). Because
SUN4I_TCON_GINT0_REG retains pending interrupts, enable_irq() can unmask the
line and cause the hardirq to fire immediately, preempting this softirq.
The hardirq could kick the DSI transfer and set TRI_START.

When the softirq resumes, it uses the cached !busy value to kick the transf=
er
a second time, writing 1 to TRI_START when it is already 1. Does this
violate the hardware state machine?

> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -720,7 +836,6 @@ static void sun6i_dsi_encoder_enable(struct drm_encod=
er *encoder)
>  	struct mipi_dsi_device *device =3D dsi->device;
>  	union phy_configure_opts opts =3D { };
>  	struct phy_configure_opts_mipi_dphy *cfg =3D &opts.mipi_dphy;

[Severity: High]
Does executing this function in an atomic context violate DRM subsystem rul=
es?

The DRM subsystem defines encoder atomic enable and disable callbacks as
atomic contexts where sleeping is forbidden. Functions like
clk_prepare_enable() are used inside this path, which can sleep and lead to
kernel warnings or potential deadlocks.

[ ... ]
> +static void sun6i_dsi_encoder_disable(struct drm_encoder *encoder)
>  {
> +	struct sun6i_dsi *dsi =3D encoder_to_sun6i_dsi(encoder);
> +
>  	DRM_DEBUG_DRIVER("Disabling DSI output\n");
> =20
> +	if (dsi->tcon)
> +		sun4i_tcon_dsi_stop_retrigger(dsi->tcon);

[Severity: High]
Does calling sun4i_tcon_dsi_stop_retrigger() here trigger a sleep in an
atomic context?

This path eventually calls disable_irq(), which is a sleeping function. Sin=
ce
encoder disable callbacks run in atomic context during non-blocking commits,
this could cause system instability or deadlocks.

> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.c
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -143,12 +143,115 @@ int sun8i_tcon_top_de_config(struct device *dev, i=
nt mixer, int tcon)
>  }
>  EXPORT_SYMBOL(sun8i_tcon_top_de_config);
> =20
> +int sun8i_tcon_top_set_dsi_gate(struct device *dev, bool enable)
> +{
> +	struct sun8i_tcon_top *tcon_top =3D dev_get_drvdata(dev);
> +	unsigned long flags;
> +	u32 val;
> +
> +	if (!sun8i_tcon_top_node_is_tcon_top(dev->of_node)) {
> +		dev_err(dev, "Device is not TCON TOP!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!tcon_top)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&tcon_top->reg_lock, flags);

[Severity: High]
This is a pre-existing issue, but does this pattern leave us vulnerable to a
Use-After-Free?

An atomic commit worker can retrieve tcon_top via dev_get_drvdata(dev).
Concurrently, a sysfs unbind could finish its remove callback and free the
memory backing tcon_top.

Since the !tcon_top check occurs before the lock is acquired, the memory
could be freed immediately after the check but before spin_lock_irqsave(),
leading to a dereference of freed memory.

[ ... ]
> +int sun8i_tcon_top_set_de0_port(struct device *dev, int port)
> +{
> +	struct sun8i_tcon_top *tcon_top =3D dev_get_drvdata(dev);
> +	unsigned long flags;
> +	u32 val;
> +
> +	if (!sun8i_tcon_top_node_is_tcon_top(dev->of_node)) {
> +		dev_err(dev, "Device is not TCON TOP!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!tcon_top)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&tcon_top->reg_lock, flags);

[Severity: High]
This is a pre-existing issue, but is this unprotected access pattern also
susceptible to the same Use-After-Free race mentioned above?

> diff --git a/drivers/pwm/pwm-sun50i-a133.c b/drivers/pwm/pwm-sun50i-a133.c
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun50i-a133.c
> @@ -0,0 +1,322 @@
[ ... ]
> +static int pwm_a133_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
> +	struct pwm_a133 *pc =3D to_pwm_a133(chip);
> +	unsigned int ch =3D pwm->hwpwm;
> +	u32 entire_cycle, act_cycle, prescale_k, val;
> +	u32 pccr_reg =3D (ch < 2) ? PWM_A133_PCCR01_REG : PWM_A133_PCCR23_REG;
> +	int ret;
> +
> +	if (!state->enabled) {
> +		mutex_lock(&pc->lock);
> +		val =3D pwm_a133_readl(pc, PWM_A133_PER_REG);
> +		val &=3D ~PWM_A133_PER_EN(ch);
> +		pwm_a133_writel(pc, PWM_A133_PER_REG, val);
> +		mutex_unlock(&pc->lock);
> +		return 0;
> +	}

[Severity: Medium]
Does returning early here leak the channel clock gate?

By returning 0 immediately, the code skips the PWM_A133_PCGR_GATING clear at
the end of the function, leaving the channel clock gate permanently enabled
after the PWM channel is disabled.

[ ... ]
> +	mutex_lock(&pc->lock);

[Severity: High]
Does acquiring this mutex violate atomic context rules when called from the
backlight driver?

If the backlight update is triggered during the panel prepare phase from an
encoder's atomic enable callback, calling mutex_lock() could sleep and lead
to system instability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912214317.1061=
50-1-leow149@lucidmail.xyz?part=3D1
