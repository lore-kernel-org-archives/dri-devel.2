Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A68C88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 06:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BAF10E308;
	Sat, 12 Sep 2026 06:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nz1M03I0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC6510E308
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 06:27:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E93E40085;
 Sat, 12 Sep 2026 06:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DF51F000FF;
 Sat, 12 Sep 2026 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789194467;
 bh=K9XotTqdYIG6hbxk3de9/pYldzfEm7W9+qnNcL/5dEo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nz1M03I0JeYJY8yyxAmaRiHr948ZDGZktFQ3bOCGxxQLmschrY3ErQk9rPNyPZz2k
 vVxsSO6ASsOCTdOu5PZKaH5TZLpYVrl3zo+hNA75M1IIzxQFb8ohjh3Y8Rwwc3sW8p
 7NY3CuhUXoZv6Pax8GEhM50rhk8oLD2Ex9xq0sUhAGZgzjS4XN/7l4gnCYmY9WJvOJ
 1+gSrvXyfzYOez+W8oyiUF7WRoTBcCuOWc7pjAd3rcUNLrLA7hw+z9v5XEyAG2XhYC
 BxM9V8q+QoP31Wi8AHWLkz0K2f/D+oiN0zU/ghZI1l07forlVI0OtuaQUitIZQs2Kl
 yYbFmN2z/d4RQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] arm64: allwinner: add TrimUI Smart Pro (A133) board
 support
To: leow149 <leow149@lucidmail.xyz>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260912060249.80035-1-leow149@lucidmail.xyz>
References: <20260912060249.80035-1-leow149@lucidmail.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 06:27:46 +0000
Message-Id: <20260912062747.55DF51F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:

New issues:
- [Critical] Missing timer cancellation on CRTC disable causes a fatal bus =
hang.
- [Critical] Vblank interrupts are permanently broken for all non-DSI panel=
s because the TCON IRQ is never enabled.
- [Critical] Moving the HS clock enable (DSI_START_HSC) before drm_panel_pr=
epare() breaks DCS initialization for existing panels.
- [High] Using regmap_update_bits() on a Write-1-to-Clear (W1C) register si=
lently fails to clear status bits.
- [High] Manually modifying the TCON TOP DSI gate bypasses the clock framew=
ork, causing clk_disable_unused to wedge the display.
- [High] Contradictory retriggering configuration creates dead code and gua=
rantees a stalled transfer.
- [High] Acknowledging FSYNC_INT in the interrupt handler inadvertently tri=
ggers spurious vblank and page-flip events.
- [Medium] Unbalanced IRQ Enable causes warning and stack dump on subsequen=
t mode sets.
- [Medium] Missing synchronization for read-modify-write on shared PWM regi=
sters.
- [Medium] Setting a 100% duty cycle on the PWM results in a 0% duty cycle =
due to a 16-bit integer truncation.
- [Low] The A133 TCON TOP compatible string lacks an if-then block in the D=
T binding, causing schema validation to fail.

Pre-existing issues:
- [High] Division by zero occurs if the requested display mode pixel clock =
is less than 1 MHz.
--

commit 99fbb5d85e5546f268568ad90dca77472cfb738d
Author: leow149 <leow149@lucidmail.xyz>
Subject: arm64: allwinner: add TrimUI Smart Pro (A133) board support

This commit introduces board support for the TrimUI Smart Pro handheld. It =
adds
a new device tree, a driver for the OTM1289A DSI panel, a new A133 PWM driv=
er,
and modifies sun4i DRM drivers to support the display pipeline. It also adds
TCON TOP quirks and alters the DSI initialization sequence.

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
Because the base schema unconditionally requires HDMI ports that the A133
does not have, will this cause device tree schema validation to fail when
dt_binding_check runs? The new A133 compatible string is missing from the
allOf conditional blocks to relax these constraints.

[ ... ]
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -498,6 +498,11 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tc=
on *tcon,
>  	regmap_write(tcon->regs, SUN4I_TCON0_CPU_IF_REG,
>  		     SUN4I_TCON0_CPU_IF_MODE_DSI |
>  		     SUN4I_TCON0_CPU_IF_TRI_FIFO_FLUSH |
>  		     SUN4I_TCON0_CPU_IF_TRI_FIFO_EN |
>  		     SUN4I_TCON0_CPU_IF_TRI_EN);

[Severity: High]
With SUN4I_TCON0_CPU_IF_AUTO explicitly omitted here, does this make the
fallback logic in the interrupt handler unreachable? sun4i_tcon_enable_vbla=
nk()
returns early for DSI CPU mode, meaning TRI_FINISH_ENABLE is never written.
It seems this prevents any frames from being sent after the first kick.

[ ... ]
> @@ -547,6 +547,8 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tco=
n *tcon,
>  	 */
>  	start_delay =3D (mode->crtc_vtotal - mode->crtc_vdisplay - 9);
>  	start_delay =3D start_delay * mode->crtc_htotal * 300;
>  	start_delay =3D start_delay / (mode->crtc_clock / 1000) / 8;

[Severity: High]
This is a pre-existing issue, but if userspace passes a custom mode with a
pixel clock less than 1 MHz, mode->crtc_clock / 1000 evaluates to zero. Can
this trigger a kernel panic due to division by zero?

[ ... ]
> @@ -572,6 +572,8 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tco=
n *tcon,
>  	 */
>  	tcon->dsi_retrigger_ticks =3D 0;
>  	hrtimer_start(&tcon->dsi_retrigger_timer, ms_to_ktime(1000),
>  		      HRTIMER_MODE_REL);

[Severity: Critical]
Is this timer explicitly canceled via hrtimer_cancel() when the CRTC is
disabled? If the display goes to sleep and the DSI clocks are gated off,
the timer will eventually attempt to read the DSI interrupt register, which
could cause a fatal synchronous external abort.

[ ... ]
> @@ -956,6 +956,11 @@ static irqreturn_t sun4i_tcon_handler(int irq, void =
*private)
>  	 * clearing it below) keeps the line alive.
>  	 */
>  	handled =3D status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
>  			     SUN4I_TCON_GINT0_VBLANK_INT(1) |
>  			     SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT |
>  			     SUN4I_TCON_GINT0_TCON0_FSYNC_INT);
> =20
>  	if (!handled)
>  		return IRQ_NONE;
> =20
>  	drm_crtc_handle_vblank(&scrtc->crtc);

[Severity: High]
If the interrupt fires solely due to FSYNC_INT, the handler will incorrectly
proceed to call drm_crtc_handle_vblank() and sun4i_tcon_finish_page_flip().
Given that FSYNC_INT is described as constantly asserted, won't this transl=
ate
into a storm of spurious vblank events that disrupts display timing and con=
fuses
userspace compositors?

[ ... ]
> @@ -1053,6 +1053,8 @@ static enum hrtimer_restart sun4i_tcon_dsi_retrigge=
r_timer_fn(struct hrtimer *ti
>  	 * atomic commit machinery.
>  	 */
>  	if (tick =3D=3D 0 && tcon->irq)
>  		enable_irq(tcon->irq);

[Severity: Medium]
Is there a corresponding disable_irq() call when the CRTC is disabled or
during teardown? If a user triggers a DPMS off/on cycle, the timer will
run again and call enable_irq() a second time, which might decrement the
IRQ depth below zero and trigger a core IRQ subsystem warning and stack dum=
p.

[ ... ]
> @@ -1124,10 +1124,11 @@ static int sun4i_tcon_init_irq(struct device *dev,
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> =20
> -	ret =3D devm_request_irq(dev, irq, sun4i_tcon_handler, 0,
> +	ret =3D devm_request_irq(dev, irq, sun4i_tcon_handler, IRQF_NO_AUTOEN,
>  			       dev_name(dev), tcon);

[Severity: Critical]
Since enable_irq() is only called from the DSI-specific retrigger timer,
won't requesting the interrupt with IRQF_NO_AUTOEN unconditionally for all
TCON instances leave the vblank interrupt permanently disabled for all
existing non-DSI panels (like LVDS, RGB, and HDMI), completely breaking
page flips for those legacy boards?

[ ... ]
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -808,6 +808,10 @@ void sun6i_dsi_clear_int_status(struct sun6i_dsi *ds=
i)
>  {
>  	unsigned int val =3D 0;
> =20
>  	regmap_read(dsi->regs, SUN6I_DSI_INT_REG, &val);
>  	regmap_update_bits(dsi->regs, SUN6I_DSI_INT_REG,
>  			   GENMASK(31, 16), val & GENMASK(31, 16));

[Severity: High]
Since SUN6I_DSI_INT_REG is a write-1-to-clear register, won't
regmap_update_bits() skip the write if it detects that the cached value
matches the new value? This optimization would cause the status bits to
remain uncleared, breaking the edge detection logic in the retrigger timer.

[ ... ]
> @@ -898,12 +898,13 @@ static void sun6i_dsi_encoder_enable(struct drm_enc=
oder *encoder)
>  	 * puts the clock lane into its continuous-HS state, and DCS commands
>  	 * use the entirely separate LPTX/LPDT instruction tables.
>  	 */
>  	sun6i_dsi_start(dsi, DSI_START_HSC);
> =20
>  	udelay(1000);
> =20
>  	if (dsi->panel)
>  		drm_panel_prepare(dsi->panel);

[Severity: Critical]
For legacy panels that require sending DCS commands during their prepare ph=
ase,
won't moving DSI_START_HSC before drm_panel_prepare() cause initialization =
to
fail? The host controller cannot transmit LPTX commands once the clock lane
is forced into continuous HS mode.

[ ... ]
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.c
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -166,6 +166,10 @@ int sun8i_tcon_top_set_dsi_gate(struct device *dev, =
bool enable)
> =20
>  	val =3D readl(tcon_top->regs + TCON_TOP_GATE_SRC_REG);
>  	if (enable)
>  		val |=3D BIT(TCON_TOP_TCON_DSI_GATE);
>  	else
>  		val &=3D ~BIT(TCON_TOP_TCON_DSI_GATE);
>  	writel(val, tcon_top->regs + TCON_TOP_GATE_SRC_REG);

[Severity: High]
Because this bit is also registered as a standard clock with the common clo=
ck
framework, won't the late-init clk_disable_unused() sweep see a reference
count of zero and forcefully turn this gate off, wedging the display pipeli=
ne
shortly after boot?

[ ... ]
> diff --git a/drivers/pwm/pwm-sun50i-a133.c b/drivers/pwm/pwm-sun50i-a133.c
> --- a/drivers/pwm/pwm-sun50i-a133.c
> +++ b/drivers/pwm/pwm-sun50i-a133.c
> @@ -148,6 +148,9 @@ static int pwm_a133_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	pwm_a133_writel(pc, pccr_reg, val);
> =20
>  	/* Gate the channel clock off while changing prescale/period/duty. */
>  	val =3D pwm_a133_readl(pc, PWM_A133_PCGR_REG);
>  	val &=3D ~(PWM_A133_PCGR_GATING(ch) | PWM_A133_PCGR_BYPASS(ch));
>  	pwm_a133_writel(pc, PWM_A133_PCGR_REG, val);

[Severity: Medium]
Since the PWM core only serializes updates per channel, could concurrent
updates to different channels on the same chip race and corrupt the hardware
state here, potentially disabling the wrong channel?

[ ... ]
> @@ -156,6 +156,9 @@ static int pwm_a133_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  		val |=3D PWM_A133_PCR_ACT_STA_HIGH;
>  	pwm_a133_writel(pc, PWM_A133_PCR_REG(ch), val);
> =20
>  	val =3D (entire_cycle << PWM_A133_PPR_ENTIRE_CYCLE_SHIFT) & PWM_A133_PP=
R_ENTIRE_CYCLE_MASK;
>  	val |=3D act_cycle & PWM_A133_PPR_ACT_CYCLE_MASK;
>  	pwm_a133_writel(pc, PWM_A133_PPR_REG(ch), val);

[Severity: Medium]
If a 100 percent duty cycle is requested, act_cycle evaluates to 65536.
Won't this bitwise AND with PWM_A133_PPR_ACT_CYCLE_MASK (which is 0xFFFF)
truncate the value to 0, causing the backlight to turn completely off when
maximum brightness is requested?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912060249.8003=
5-1-leow149@lucidmail.xyz?part=3D1
