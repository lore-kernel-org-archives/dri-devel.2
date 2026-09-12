Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27728C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF86C10E6F0;
	Sat, 12 Sep 2026 10:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oC/Z1x/d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1E889289
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 10:46:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 675BC43D55;
 Sat, 12 Sep 2026 10:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB2E1F00893;
 Sat, 12 Sep 2026 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789209988;
 bh=ArrIPbXrk94Bb9HsXMdz8pQrx5D67wJkHPf/JN44kT0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oC/Z1x/dxtDuQvd7gWPAaynyjUsNKt8StT/yP14DPhnpwDnuCQLZCVIXPk6zqcIo3
 PZMGGM3Q3542t9hx2TMWjsuCd3ZTZzOmXmfQcY/UQoWuPkOSch/bjBEamMQJELQtEH
 R8N/s/DFBkUTphk1DGqvVMwC6yGOjP+YXAFPa5W38l5o86jC7v9IKlGhT6Ng7wdmND
 JFNmbZWj2BQXMUkDC3i/YMUgwBKAhhArjxiOvAE5VPRjgVuap9SxBBIaw3ELMytD85
 kuIv5lHT4TBM8ZUWedgSXaQxp/nccrLMkvmyc6TmRhUUQLKjmGX17MjNvbF/MhBt4C
 fyvZD927DeYKA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3] arm64: allwinner: add TrimUI Smart Pro (A133)
 board support
To: leow149 <leow149@lucidmail.xyz>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260912103139.90657-1-leow149@lucidmail.xyz>
References: <20260912075706.86857-1-leow149@lucidmail.xyz>
 <20260912103139.90657-1-leow149@lucidmail.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 10:46:27 +0000
Message-Id: <20260912104628.1EB2E1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Sleeping functions used in CRTC and encoder atomic callbacks (Subs=
ystem Guide Violation)
- [High] Vblank interrupts are permanently disabled for non-DSI boards afte=
r DPMS cycle
- [High] hrtimer callback attempts to acquire sleepable spinlock on PREEMPT=
_RT
- [High] TCON interrupt storm causes severe CPU hog by unconditionally retu=
rning IRQ_HANDLED
- [Medium] CLK_IS_CRITICAL on tcon-top-dsi gate causes power management reg=
ression
- [Low] Missing EXPORT_SYMBOL for sun6i_mipi_dsi functions causes module li=
nkage failure
--

commit 5d94a8dca17c72188e51f01e2e6fb28930a6a4da
Author: leow149 <leow149@lucidmail.xyz>

arm64: allwinner: add TrimUI Smart Pro (A133) board support
   =20
Board bring-up for the TrimUI Smart Pro handheld (Allwinner A133 Plus).
This includes a new board DTS, a new OTM1289A/ER68576 DSI panel driver,
a new PWM driver for the A133, and display pipeline support.

> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm1289a.c b/drivers/g=
pu/drm/panel/panel-orisetech-otm1289a.c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm1289a.c
[ ... ]
> +static int otm1289a_init_sequence_send(struct otm1289a *ctx)
> +{
[ ... ]
> +	ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret < 0)
> +		return ret;
> +	msleep(50);

[Severity: High]
Does this msleep() introduce a sleep in atomic context? The panel
initialization is invoked from the encoder atomic enable callback, which is=
 an
atomic context where sleeping is forbidden. This can lead to kernel panics =
and
deadlocks during display atomic commits.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
[ ... ]
> @@ -221,6 +221,34 @@ void sun4i_tcon_set_status(struct sun4i_tcon *tcon,
[ ... ]
> +		if (tcon->irq_enabled) {
> +			disable_irq(tcon->irq);

[Severity: High]
Could this disable_irq() call cause issues by sleeping in atomic context? T=
his
is executed within the CRTC atomic disable path, which shouldn't contain
sleepable functions.

[ ... ]
> @@ -713,11 +948,31 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
[ ... ]
> +	if (!tcon->dsi_cpu_mode && tcon->irq && !tcon->irq_enabled) {
> +		enable_irq(tcon->irq);
> +		tcon->irq_enabled =3D true;
> +	}
>  }

[Severity: High]
Will vblank interrupts stay permanently disabled for non-DSI boards after a
DPMS off/on cycle? Because standard DPMS unblanking doesn't invoke the
mode_set_nofb hook, placing the IRQ enable logic here means it is skipped
during DPMS cycles, leaving the IRQ disabled.

[ ... ]
> @@ -759,30 +1030,173 @@ static irqreturn_t sun4i_tcon_handler(int irq, vo=
id *private)
[ ... ]
> +	handled =3D tcon->dsi_cpu_mode ||
> +		  (status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
> +			     SUN4I_TCON_GINT0_VBLANK_INT(1) |
> +			     SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT |
> +			     SUN4I_TCON_GINT0_TCON0_FSYNC_INT));
> +
> +	if (!handled)
>  		return IRQ_NONE;

[Severity: High]
Does unconditionally returning IRQ_HANDLED for DSI/CPU mode leave the system
vulnerable to an unmitigated interrupt storm? By defeating genirq's
protection, the FSYNC_INT storm could cause a severe CPU hog. The DSI block=
's
own interrupt (SPI 100) might be the safer hardware approach here.

[ ... ]
> +static enum hrtimer_restart sun4i_tcon_dsi_retrigger_timer_fn(struct hrt=
imer *timer)
> +{
[ ... ]
> +	regmap_read(tcon->regs, SUN4I_TCON0_CPU_IF_REG, &cpu_if_before);

[Severity: High]
Can this regmap_read() cause a kernel panic on PREEMPT_RT kernels? It attem=
pts
to acquire a sleepable spinlock on an MMIO regmap, but the hrtimer is
initialized with HRTIMER_MODE_REL (hardirq context).

[ ... ]
> @@ -1136,6 +1562,9 @@ static int sun4i_tcon_bind(struct device *dev, stru=
ct device *master,
[ ... ]
> +	hrtimer_setup(&tcon->dsi_retrigger_timer, sun4i_tcon_dsi_retrigger_time=
r_fn,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);

[Severity: High]
Should this timer be configured as HRTIMER_MODE_REL_SOFT instead, so that i=
ts
callback can safely execute sleepable functions in softirq context on
PREEMPT_RT?

> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
[ ... ]
> +void sun6i_dsi_tri_start(struct sun6i_dsi *dsi)
> +{
> +	sun6i_dsi_start(dsi, DSI_START_TRI);
> +}

[Severity: Low]
Is this function missing an EXPORT_SYMBOL macro? Without it, modular builds=
 of
sun4i-tcon.ko depending on this function will fail at the modpost stage.

[ ... ]
> +u32 sun6i_dsi_read_int_status(struct sun6i_dsi *dsi)
> +{
> +	unsigned int val =3D 0;
> +
> +	regmap_read(dsi->regs, SUN6I_DSI_INT_REG, &val);
> +
> +	return val;
> +}

[Severity: Low]
Does this function also need an EXPORT_SYMBOL macro to prevent module linka=
ge
failures?

[ ... ]
> +void sun6i_dsi_clear_int_status(struct sun6i_dsi *dsi)
> +{
> +	unsigned int val =3D 0;
> +
> +	regmap_read(dsi->regs, SUN6I_DSI_INT_REG, &val);
> +	regmap_write_bits(dsi->regs, SUN6I_DSI_INT_REG,
> +			  GENMASK(31, 16), val & GENMASK(31, 16));
> +}

[Severity: Low]
Is an EXPORT_SYMBOL macro required here as well for modular builds?

> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.c
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
[ ... ]
> @@ -241,19 +315,33 @@ static int sun8i_tcon_top_bind(struct device *dev, =
struct device *master,
[ ... ]
>  	if (quirks->has_dsi)
>  		clk_data->hws[CLK_TCON_TOP_DSI] =3D
>  			sun8i_tcon_top_register_gate(dev, "dsi", regs,
>  						     &tcon_top->reg_lock,
> -						     TCON_TOP_TCON_DSI_GATE, i++);
> +						     TCON_TOP_TCON_DSI_GATE, i++,
> +						     CLK_IS_CRITICAL);

[Severity: Medium]
Will using CLK_IS_CRITICAL on this gate cause a power management regression?
This forces the clock to remain permanently enabled, holding references to =
its
parent (CLK_MIPI_DSI) and preventing the PLL from ever powering down.
CLK_IGNORE_UNUSED might be more appropriate to prevent the clock core's
disable_unused sweep.

> diff --git a/drivers/pwm/pwm-sun50i-a133.c b/drivers/pwm/pwm-sun50i-a133.c
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun50i-a133.c
[ ... ]
> +static int pwm_a133_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
[ ... ]
> +	mutex_lock(&pc->lock);

[Severity: High]
Does this use a sleeping mutex inside an atomic context? The PWM apply hook
is reached via backlight_enable() from the encoder atomic enable callback,
which is an atomic context where sleeping is forbidden. This can lead to
kernel panics and deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912103139.9065=
7-1-leow149@lucidmail.xyz?part=3D1
