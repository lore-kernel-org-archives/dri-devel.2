Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49243C88E4D
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF3810E432;
	Sat, 12 Sep 2026 08:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JJmGWQbh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A47910E432
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:14:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1848242A0A;
 Sat, 12 Sep 2026 08:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44891F000FF;
 Sat, 12 Sep 2026 08:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789200896;
 bh=cK61tf0ITAekm2pHZHiAgMpkoh+sGvnCq5X3PzwfkN0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JJmGWQbhdU0LCILvWytjxhtzuanjwCjKnHC4TeXJ7NVuBF2Fv3Hb7/I2zxW4uNVlR
 uyVbehal/VY6l9UCLho3Vp62akOtKIc6+qOaJTZqpqri1S/RGD3dWHY0q0iUmeJAdr
 9VTH1acTzVN5UxnZaEBbn86cR5h09ASzLGvJBsPYIsJi2YElYw4BX+IChYnnT+Qcqm
 ooViUZX0fwi50+6UFhlZIqWmysWsNMdQ0CftIA6jvAR5hhwYFgbKZnNNtNDYdsVWTI
 gxSx1qw9XEjItKozLFaTFt0mt5lDIl6V584X8XVkO8UndPIb+V8n9rlaVRafQvGLgJ
 rm2vzNLKB0O3A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] arm64: allwinner: add TrimUI Smart Pro (A133)
 board support
To: leow149 <leow149@lucidmail.xyz>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260912075706.86857-1-leow149@lucidmail.xyz>
References: <20260912060249.80035-1-leow149@lucidmail.xyz>
 <20260912075706.86857-1-leow149@lucidmail.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:14:55 +0000
Message-Id: <20260912081455.C44891F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] DPMS off/on cycles permanently disable the TCON VBLANK interrupt d=
ue to unbalanced enable/disable logic.
- [High] TRI_FINISH_ENABLE is explicitly disabled, making the hardware inca=
pable of triggering subsequent frames without an interrupt storm.
- [High] The driver relies on a 1000ms wall-clock timer to sequence the ini=
tial DSI hardware trigger, creating a race condition against encoder initia=
lization.
- [High] Sleeping functions (msleep, mutex_lock, disable_irq) are called fr=
om display driver atomic commit paths, violating subsystem rules.
--

commit 80c8d8e264d674c3f29098c9376ede5cd167b9ab
Author: leow149 <leow149@lucidmail.xyz>
arm64: allwinner: add TrimUI Smart Pro (A133) board support

This commit adds board support for the TrimUI Smart Pro handheld based
on the Allwinner A133 Plus SoC. It introduces a new device tree, a new
DSI panel driver, a new PWM driver, and modifies sun4i_tcon and=20
sun6i_mipi_dsi to support the CPU/8080-interface DSI path.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
[ ... ]
> @@ -221,6 +221,23 @@ void sun4i_tcon_set_status(struct sun4i_tcon *tcon,
>  		sun4i_tcon_lvds_set_status(tcon, encoder, true);
> =20
>  	sun4i_tcon_channel_set_status(tcon, channel, enabled);
> +
> +	/*
> +	 * On disable, stop the DSI/CPU-mode retrigger timer before anything
> +	 * downstream (clocks, D-PHY) gets gated off. Left running, it keeps
> +	 * touching tcon->regs/dsi->regs every 2ms regardless of the CRTC's
> +	 * state; hitting gated hardware from there is a real bus-abort risk,
> +	 * not just wasted work. hrtimer_cancel() on an already-inactive timer
> +	 * is a safe no-op, so this is fine to call unconditionally rather
> +	 * than gating it on dsi_cpu_mode.
> +	 */
> +	if (!enabled) {
> +		hrtimer_cancel(&tcon->dsi_retrigger_timer);
> +		if (tcon->irq_enabled) {
> +			disable_irq(tcon->irq);
> +			tcon->irq_enabled =3D false;

[Severity: High]
Is it safe to call disable_irq() here?

This function is reached from atomic disable paths like
sun4i_crtc_atomic_disable. Since disable_irq() can sleep, calling it from
atomic context violates display driver rules and could cause deadlocks or
kernel warnings.

[Severity: High]
Does this disable path lead to permanently disabled VBLANK interrupts after
DPMS off/on cycles?

Because the IRQ is explicitly disabled and tcon->irq_enabled cleared here,
it needs to be re-enabled on resume. However, enable_irq() is only present
in sun4i_tcon_mode_set().=20

During a simple DPMS ON cycle (which only changes active state, not the
mode), DRM skips mode_set_nofb, bypassing sun4i_tcon_mode_set() entirely.
Could this leave the IRQ and timer permanently stopped after the display is
turned back on?

> +		}
> +	}
>  }
> =20
>  void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
> @@ -229,6 +246,18 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tco=
n, bool enable)
> =20
>  	DRM_DEBUG_DRIVER("%sabling VBLANK interrupt\n", enable ? "En" : "Dis");
> =20
> +	/*
> +	 * The DSI/CPU-interface path never touches TCON0's own GINT0
> +	 * enable bits: for this panel, the vendor implementation dispatches
> +	 * IRQ enable/query entirely to DSI's own interrupt register instead
> +	 * (confirmed against a live working reference system, where GINT0's
> +	 * enable bits read zero). The real per-frame retrigger source is
> +	 * SUN6I_DSI_INT_REG -- see sun6i_mipi_dsi.c and
> +	 * sun4i_tcon_dsi_retrigger_timer_fn() below.
> +	 */
> +	if (tcon->dsi_cpu_mode)
> +		return;

[Severity: High]
Does bypassing this hardware enable prevent frames from triggering without a
storm?

This early return prevents SUN4I_TCON_GINT0_TCON0_TRI_FINISH_ENABLE from be=
ing
set in SUN4I_TCON_GINT0_REG. However, the timer callback=20
sun4i_tcon_dsi_retrigger_timer_fn() eventually stops itself when
TRIGGER_START self-clears, delegating continuous retriggering to the IRQ
handler.=20

Since the hardware interrupt enable bit is skipped here, the TCON will never
assert the interrupt line when a frame finishes. Could the retrigger loop
only be functioning right now because of the unintended FSYNC_INT hardware
storm keeping the IRQ line asserted?

> +
>  	mask =3D SUN4I_TCON_GINT0_VBLANK_ENABLE(0) |
>  		SUN4I_TCON_GINT0_VBLANK_ENABLE(1) |
>  		SUN4I_TCON_GINT0_TCON0_TRI_FINISH_ENABLE;
[ ... ]
> @@ -402,24 +556,61 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_t=
con *tcon,
>  	regmap_write(tcon->regs, SUN4I_TCON0_CPU_TRI1_REG,
>  		     SUN4I_TCON0_CPU_TRI1_BLOCK_NUM(mode->vdisplay));
> =20
[ ... ]
> +	/*
> +	 * This timer's first tick fires the real first TRIGGER_START, once
> +	 * sun6i_dsi_encoder_enable() has actually finished rather than just
> +	 * started -- its drm_panel_prepare() call alone (reset pulse + DCS
> +	 * init) totals close to 300ms of msleep() for this panel. 1000ms
> +	 * gives ample margin over that as a one-time cost at boot.
> +	 */
> +	tcon->dsi_retrigger_ticks =3D 0;
> +	hrtimer_start(&tcon->dsi_retrigger_timer, ms_to_ktime(1000),
> +		      HRTIMER_MODE_REL);

[Severity: High]
Could this wall-clock timer race against encoder initialization?

sun4i_tcon0_mode_set_cpu() arms this timer to fire in 1000ms, while the
encoder's atomic_enable hook (sun6i_dsi_encoder_enable) prepares the panel.
If the process-context encoder initialization takes longer than 1000ms due
to system load, scheduler delays, or slow panel interactions, this timer
callback will fire in hardirq context concurrently.=20

This would cause the timer to call sun6i_dsi_tri_start(), overwriting
SUN6I_DSI_INST_JUMP_SEL_REG while the process context is actively writing
to the same register during DCS transfers. Can this corrupt the DSI
controller's instruction state machine?

> +
> +	/*
> +	 * enable_irq(tcon->irq) is deliberately not called here:
[ ... ]
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

[Severity: High]
Are these sleeping delays safe to call from atomic context?

Subsystem guidelines forbid sleeping in CRTC, plane, and encoder atomic
callbacks during non-blocking commits. This panel driver's prepare() uses
msleep() directly.=20

It is invoked from sun6i_dsi_encoder_enable() via drm_panel_prepare(),
which runs in atomic commit paths. Could this trigger kernel warnings or
system instability by sleeping where it isn't allowed?

> +	}
> +
> +	ret =3D otm1289a_init_sequence_send(ctx);
> +	if (ret) {
[ ... ]
> diff --git a/drivers/pwm/pwm-sun50i-a133.c b/drivers/pwm/pwm-sun50i-a133.c
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun50i-a133.c
> @@ -0,0 +1,317 @@
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
> +
> +	ret =3D pwm_a133_calc(state->period, state->duty_cycle, &entire_cycle,
> +			    &act_cycle, &prescale_k);
> +	if (ret) {
> +		dev_err(pwmchip_parent(chip), "period exceeds the maximum value\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * PWM_A133_PCCR01_REG/PCCR23_REG (shared by a channel pair) and
> +	 * PWM_A133_PCGR_REG/PWM_A133_PER_REG (shared by all 16 channels) are
> +	 * each read-modify-written below; the PWM core doesn't serialize
> +	 * .apply() calls across different channels on the same chip, so this
> +	 * whole sequence needs its own lock against a concurrent apply() on
> +	 * another channel racing on the same register.
> +	 */
> +	mutex_lock(&pc->lock);

[Severity: High]
Is it safe to acquire a mutex in this PWM apply callback?

When used as a backlight, pwm_a133_apply() can be reached from the display
driver's atomic commit tail: sun6i_dsi_encoder_enable() ->
drm_panel_enable() -> backlight_enable().=20

Because encoder atomic callbacks run in atomic context where sleeping is
forbidden, taking a mutex here could lead to deadlocks or scheduling while
atomic errors.

> +
> +	/* Clock source: OSC24M for the whole pair this channel belongs to. */
> +	val =3D pwm_a133_readl(pc, pccr_reg);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912075706.8685=
7-1-leow149@lucidmail.xyz?part=3D1
