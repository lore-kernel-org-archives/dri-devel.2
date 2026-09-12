Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E03C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 23:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E3810E64C;
	Sat, 12 Sep 2026 23:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dCsQQSfp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5749210E64C
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 23:45:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E92B540E57;
 Sat, 12 Sep 2026 23:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02681F000FF;
 Sat, 12 Sep 2026 23:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789256724;
 bh=hLzeBUso7Jt93By2QwzLAPcpUiYX7xQ8cqjRxArLq04=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dCsQQSfpOW97D0ZGqyZ8fD0AxBid6vd7ovDRya2pCTkto8tFsjXcGUGovhAYpS60Y
 knrzlPs7RY+RvGvhxN49DYru1CYPcD4wkuDENjLdDt8b+Cw9w2KUQ1rMDCNbgNWKvM
 7mTGbEcyEkdydjgH31snwnf5Oj2dNI/bhUv5qXmEXndyuuwO2o9xqm2C0qKDKZO338
 OraOfm8Y6JOlr5M7KrxYihaHX7UGaNFWOZFkA6GT3oeBT4IbShLjbKxe69lkZpYpwU
 4DOL4h1CBFDA0uknId+Vgbq/WMWf9PyXnplElrY86bI4zwqsYk3Cj89ReKmXF77g0h
 nA4jgBC9+vVYQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v8] arm64: allwinner: add TrimUI Smart Pro (A133)
 board support
To: leow149 <leow149@lucidmail.xyz>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260912233238.110960-1-leow149@lucidmail.xyz>
References: <20260912230131.109229-1-leow149@lucidmail.xyz>
 <20260912233238.110960-1-leow149@lucidmail.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 23:45:24 +0000
Message-Id: <20260912234524.A02681F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Sleeping in Atomic Context Violation during DRM encoder callbacks.
- [High] Unbalanced DSI clock gate lifecycle during DPMS ON/OFF cycle perma=
nently disables the display.
- [High] Denial of Service (CPU Hog) from defeating unhandled IRQ storm pro=
tection.

Pre-existing issues:
- [High] TOCTOU race condition causing lost interrupts due to RMW on a Writ=
e-0-to-Clear (W0C) register.
- [High] TOCTOU Use-After-Free race condition in TCON TOP driver data acces=
s.
--

commit 739730d576ddf8a50358b7451672c4a7b9d896ed
Author: leow149 <leow149@lucidmail.xyz>

arm64: allwinner: add TrimUI Smart Pro (A133) board support

Board bring-up for the TrimUI Smart Pro handheld (Allwinner A133 Plus). Thi=
s=20
adds the new DTS, an OTM1289A DSI panel driver, a new PWM driver, and DRM=20
display pipeline configurations.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index bf405a2aa3249..9d916efa8566b 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -226,20 +226,40 @@ void sun4i_tcon_set_status(struct sun4i_tcon *tcon,
> =20
>  	sun4i_tcon_channel_set_status(tcon, channel, enabled);
> =20
> +	/*
> +	 * On disable, stop the DSI/CPU-mode retrigger timer/IRQ. This is a
> +	 * backstop for boards where sun6i_dsi_encoder_disable() itself
> +	 * already did this (see sun4i_tcon_dsi_stop_retrigger()'s comment
> +	 * for why that earlier call site is the one that actually matters)
> +	 * -- harmless and idempotent to also do it here.
> +	 */
> +	if (!enabled) {
> +		sun4i_tcon_dsi_stop_retrigger(tcon);
> +		/*
> +		 * sun4i_tcon0_mode_set() only ever calls
> +		 * sun4i_tcon0_set_dsi_gate(tcon, true) -- there was no
> +		 * matching false call anywhere, leaking this gate (and, via
> +		 * CLK_IGNORE_UNUSED, its CLK_MIPI_DSI parent) permanently on
> +		 * past this TCON's own disable. Ungate here instead; this
> +		 * call is a safe no-op on boards without a matching TCON TOP
> +		 * remote node (see its own comment), so it's fine to call
> +		 * unconditionally on every disable, not just DSI ones.
> +		 */
> +		sun4i_tcon0_set_dsi_gate(tcon, false);
> +	} else if (!tcon->dsi_cpu_mode && tcon->irq && !tcon->irq_enabled) {
> +		/*
> +		 * Non-DSI boards: tcon->irq was requested IRQF_NO_AUTOEN for
> +		 * every board using this driver (needed for the DSI/CPU-mode
> +		 * path's delayed enable -- see the comment on
> +		 * sun4i_tcon_init_irq()), so it needs an explicit enable_irq()
> +		 * somewhere for boards that never take that path at all. This
> +		 * runs on every CRTC enable -- both a real modeset (paired
> +		 * with sun4i_tcon_mode_set() in the same commit) and a plain
> +		 * DPMS off/on cycle, which does NOT call mode_set_nofb/
> +		 * sun4i_tcon_mode_set() again.
> +		 */
> +		enable_irq(tcon->irq);
> +		tcon->irq_enabled =3D true;
> +	}
>  }

[Severity: High]
What re-enables the DSI gate when the display wakes up from DPMS OFF?

While sun4i_tcon0_set_dsi_gate(tcon, false) is called when enabled is false,
the true branch here lacks a corresponding sun4i_tcon0_set_dsi_gate(tcon, t=
rue).
Since the gate is only enabled in sun4i_tcon_mode_set(), a simple DPMS ON
that doesn't trigger a full modeset might leave the clock gate permanently =
off.

[ ... ]

> @@ -772,12 +772,16 @@ void sun4i_tcon_dsi_stop_retrigger(struct sun4i_tco=
n *tcon)
>  {
>  	hrtimer_cancel(&tcon->dsi_retrigger_timer);
>  	/*
>  	 * disable_irq() (which might_sleep()s internally) is safe here:
>  	 * both call sites run in normal process/workqueue context, not a
>  	 * genuinely atomic section -- see the comment on
>  	 * sun4i_tcon_set_status()'s disable_irq() call for why (this
>  	 * function is called from there too, unchanged reasoning).
>  	 */
>  	if (tcon->irq_enabled) {
>  		disable_irq(tcon->irq);
>  		tcon->irq_enabled =3D false;
>  	}
>  }

[Severity: High]
Is it entirely safe to invoke disable_irq() here?

Because disable_irq() can sleep, and this path can be reached from=20
sun6i_dsi_encoder_disable() during DRM non-blocking atomic commits, executi=
ng=20
it in an atomic context would lead to a scheduling-while-atomic violation.

[ ... ]

> @@ -1151,12 +1151,33 @@ static irqreturn_t sun4i_tcon_handler(int irq, vo=
id *private)
>  {
>  	struct sun4i_tcon *tcon =3D private;
>  	struct drm_device *drm =3D tcon->drm;
>  	struct sun4i_crtc *scrtc =3D tcon->crtc;
>  	struct sunxi_engine *engine =3D scrtc->engine;
>  	unsigned int status;
> +	bool handled;
> =20
>  	regmap_read(tcon->regs, SUN4I_TCON_GINT0_REG, &status);
> =20
> +	handled =3D tcon->dsi_cpu_mode ||
> +		  (status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
> +			     SUN4I_TCON_GINT0_VBLANK_INT(1) |
> +			     SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT |
> +			     SUN4I_TCON_GINT0_TCON0_FSYNC_INT));
> +
> +	if (!handled)
> +		return IRQ_NONE;

[Severity: High]
Could this unconditional handled =3D true assignment in DSI/CPU mode defeat=
=20
the kernel's unhandled IRQ storm protection?

If a hardware glitch causes the line to remain asserted, or if another devi=
ce=20
sharing this IRQ asserts, the kernel will never disable the line, potential=
ly=20
causing an infinite interrupt loop and a complete system lockup.

>  	/* Acknowledge the interrupt */
>  	regmap_update_bits(tcon->regs, SUN4I_TCON_GINT0_REG,
>  			   SUN4I_TCON_GINT0_VBLANK_INT(0) |
>  			   SUN4I_TCON_GINT0_VBLANK_INT(1) |
> -			   SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT,
> +			   SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT |
> +			   SUN4I_TCON_GINT0_TCON0_TRI_COUNTER_INT |
> +			   SUN4I_TCON_GINT0_TCON0_FSYNC_INT,
>  			   0);

[Severity: High]
This is a pre-existing issue, but using regmap_update_bits() on a=20
Write-0-to-Clear (W0C) register like SUN4I_TCON_GINT0_REG seems to introduc=
e=20
a TOCTOU race condition.

Because it performs a read-modify-write, if a new interrupt bit asserts bet=
ween=20
the read and the write, writing 0 will silently clear it in hardware withou=
t=20
the handler ever processing it.

> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index d504ae5832949..fae312e2ebf55 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c

[ ... ]

> @@ -910,21 +910,34 @@ static void sun6i_dsi_encoder_enable(struct drm_enc=
oder *encoder)
> =20
>  	sun6i_dsi_start(dsi, DSI_START_HSC);
> =20
>  	udelay(1000);
> =20
> +	if (dsi->panel)
> +		drm_panel_prepare(dsi->panel);
> +
> +	if (dsi->panel)
> +		drm_panel_enable(dsi->panel);
> +
>  	sun6i_dsi_start(dsi, DSI_START_HSD);

[Severity: High]
Since DRM encoder enable callbacks can execute in atomic context during=20
non-blocking commits, is it safe to invoke drm_panel_prepare() here?=20

drm_panel_prepare() internally uses sleeping functions like msleep() which=
=20
could lead to scheduling-while-atomic violations.

[ ... ]

> @@ -962,6 +962,21 @@ static void sun6i_dsi_encoder_disable(struct drm_enc=
oder *encoder)
>  {
>  	struct sun6i_dsi *dsi =3D encoder_to_sun6i_dsi(encoder);
> =20
>  	DRM_DEBUG_DRIVER("Disabling DSI output\n");
> =20
> +	if (dsi->tcon)
> +		sun4i_tcon_dsi_stop_retrigger(dsi->tcon);
> +
>  	if (dsi->panel) {
>  		drm_panel_disable(dsi->panel);
>  		drm_panel_unprepare(dsi->panel);
>  	}

[Severity: High]
Does executing drm_panel_disable() here conflict with atomic context=20
requirements?=20

Because this is invoked from the encoder disable path, which may run in ato=
mic=20
context, it will eventually acquire mutexes in the PWM driver, causing the=
=20
process to sleep.

> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.c
> index 9cbd655518b20..3f519df7d97dc 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -157,6 +157,63 @@ int sun8i_tcon_top_set_dsi_gate(struct device *dev, =
bool enable)
>  {
>  	struct sun8i_tcon_top *tcon_top =3D dev_get_drvdata(dev);
>  	unsigned long flags;
>  	u32 val;
> =20
>  	if (!sun8i_tcon_top_node_is_tcon_top(dev->of_node)) {
>  		dev_err(dev, "Device is not TCON TOP!\n");
>  		return -EINVAL;
>  	}
> =20
> +	if (!tcon_top)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&tcon_top->reg_lock, flags);

[Severity: High]
This isn't a bug introduced by this patch, but dereferencing tcon_top here=
=20
contains a TOCTOU Use-After-Free race condition.

If the TCON TOP driver is unbound concurrently, tcon_top might be freed=20
before the spin_lock_irqsave(&tcon_top->reg_lock, flags) call executes.

> diff --git a/drivers/pwm/pwm-sun50i-a133.c b/drivers/pwm/pwm-sun50i-a133.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun50i-a133.c
> @@ -140,6 +140,94 @@ static int pwm_a133_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  			  const struct pwm_state *state)
>  {
>  	struct pwm_a133 *pc =3D to_pwm_a133(chip);
>  	unsigned int ch =3D pwm->hwpwm;
>  	u32 entire_cycle, act_cycle, prescale_k, val;
>  	u32 pccr_reg =3D (ch < 2) ? PWM_A133_PCCR01_REG : PWM_A133_PCCR23_REG;
>  	int ret;
> =20
>  	if (!state->enabled) {
>  		mutex_lock(&pc->lock);

[Severity: High]
Can acquiring a mutex here be safely performed?

This function is invoked from panel disable/enable paths. Since those can=20
run during DRM non-blocking commits, acquiring a sleeping lock could cause=
=20
system deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912233238.1109=
60-1-leow149@lucidmail.xyz?part=3D1
