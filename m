Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45124C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 11:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5546E10E4A3;
	Sat, 12 Sep 2026 11:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T87mua0D";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAEF10E4AA
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 11:58:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CDBA40B28;
 Sat, 12 Sep 2026 11:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EE21F00893;
 Sat, 12 Sep 2026 11:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789214300;
 bh=WHKlvMhfOWbH7E6kBGGRIvYxtXQ+6q9Q3GaejYZ3VF8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T87mua0DAWWDbl88PoTrzykWaJUGHmcc/QwStzRCPlmLv6Empwq/23JjOCWzJeYSY
 t/3iAH+kV8kznK6/h9CXwKH9gagdH8/Z0BznY30DYSmH9WLpQ64sNABihOsI5YNUnu
 tFBq6fGE2HXdlFQeM3zEsp5CzuAcA21nMkttoq+yZka0J8awNNxf2ohfGka63eIGNn
 SXpQeQYvMUC/HvTk+KMmelFoN5I28JFLOSTJKgxppFa24W4XG0m19keec/qthEDU91
 8BQ1+2hyGWChOBnSOYdJoVyqUWhSx/qZovmqzc0XT472An5qSqZCLv+xYU7vCqPG+Y
 wLtySsUYQAYXw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4] arm64: allwinner: add TrimUI Smart Pro (A133)
 board support
To: leow149 <leow149@lucidmail.xyz>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260912114331.92956-1-leow149@lucidmail.xyz>
References: <20260912103139.90657-1-leow149@lucidmail.xyz>
 <20260912114331.92956-1-leow149@lucidmail.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 11:58:19 +0000
Message-Id: <20260912115820.33EE21F00893@smtp.kernel.org>
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
- [High] Unconditional application of the A133-specific manual DSI re-trigg=
ering logic breaks all existing sun4i-drm DSI users.
- [High] The DSI retrigger timer continues to poll DSI registers after the =
DSI module's clocks are gated and its reset is asserted during display disa=
ble, which will cause a fatal bus fault.
- [Medium] Unconditional reordering of `DSI_START_HSC` before `drm_panel_pr=
epare()` applies to all sun6i MIPI DSI panels and may break existing panels.
- [Medium] Infinite IRQ storm due to unconditionally bypassing IRQ_NONE wit=
hout clearing all potential interrupt bits.

Pre-existing issues:
- [High] Unbinding the `sun8i_tcon_top` driver via sysfs clears its `drvdat=
a`, leading to a NULL pointer dereference in `sun8i_tcon_top_set_dsi_gate()=
` and `sun8i_tcon_top_set_de0_port()` during subsequent DRM mode settings.
--

commit 96d666dd56ce81b6cc9bf2aaa319e6ee6a48457c
Author: leow149 <leow149@lucidmail.xyz>
Subject: arm64: allwinner: add TrimUI Smart Pro (A133) board support

This commit introduces board support for the TrimUI Smart Pro handheld. It
adds the required device tree, panel driver, and PWM driver, while adapting
the sun4i display pipeline (TCON, DSI, mixer, TCON TOP) to support the A133
Plus SoC's CPU/8080 DSI routing.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/s=
un4i_tcon.c
> index bf405a2aa3249..71000e7d700c6 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -221,6 +221,52 @@ void sun4i_tcon_set_status(struct sun4i_tcon *tcon,
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

[Severity: High]
Does the DSI retrigger timer continue to poll DSI registers after the DSI
module's clocks are gated?

The DRM atomic commit sequence calls encoder->disable before crtc->disable.
sun6i_dsi_encoder_disable() disables dsi->mod_clk and asserts dsi->reset,
but the 2ms dsi_retrigger_timer is only cancelled here during the CRTC
disable phase.

If the timer fires in the window between encoder disable and CRTC disable
(or runs continuously if TRIGGER_START never clears),
sun4i_tcon_dsi_retrigger_timer_fn() will call sun6i_dsi_read_int_status()
and attempt to read powered-down registers, causing a fatal bus fault.

[ ... ]
> @@ -229,6 +275,26 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tco=
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
> +	 *
> +	 * This also means SUN4I_TCON_GINT0_TCON0_TRI_FINISH_ENABLE is never
> +	 * set, so it's fair to ask whether TRI_FINISH_INT's status bit can
> +	 * assert at all without its own enable bit -- the same live vendor
> +	 * dump answers this directly: TCON0_GINT0 read 0x00000a00 on that
> +	 * reference system (TRI_FINISH_INT and FSYNC_INT both set) with every
> +	 * enable bit at 0. Both status bits assert regardless of their own
> +	 * enable, confirmed on real working hardware, not assumed.
> +	 */
> +	if (tcon->dsi_cpu_mode)
> +		return;
> +

[Severity: High]
Does this unconditional early return break VBLANK interrupts and page flips
for all existing DSI boards?

Because sun4i_tcon0_mode_set_cpu() now sets tcon->dsi_cpu_mode =3D true for
all DRM_MODE_ENCODER_DSI encoders, this causes the hardware VBLANK interrupt
to never be enabled for older TCONs.

[ ... ]
> @@ -375,6 +525,32 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tc=
on *tcon,
>  			   SUN4I_TCON0_CTL_IF_MASK,
>  			   SUN4I_TCON0_CTL_IF_8080);
> =20
> +	/* Arm the per-frame TRIGGER_START re-assertion in the IRQ handler. */
> +	tcon->dsi_cpu_mode =3D true;
> +	tcon->dsi =3D encoder_to_sun6i_dsi(encoder);
> +	/*
> +	 * Back-reference so sun6i_dsi_encoder_enable() can arm the retrigger
> +	 * timer itself once it actually finishes -- see the comment on
> +	 * sun4i_tcon_dsi_start_retrigger() for why this replaced a wall-clock
> +	 * guess made from here.
> +	 */
> +	tcon->dsi->tcon =3D tcon;

[Severity: High]
Can this unconditional application of the A133-specific manual DSI
re-triggering logic override the normal free-running hardware state for
other boards?

This enables the manual DSI CPU mode unconditionally for all DSI interfaces
without checking a quirk or SoC version, which introduces a regression for
existing sun4i-drm DSI users (e.g., A64, A83T).

[ ... ]
> @@ -759,30 +1045,187 @@ static irqreturn_t sun4i_tcon_handler(int irq, vo=
id *private)
>  	struct sun4i_crtc *scrtc =3D tcon->crtc;
>  	struct sunxi_engine *engine =3D scrtc->engine;
>  	unsigned int status;
> +	bool handled;
> =20
>  	regmap_read(tcon->regs, SUN4I_TCON_GINT0_REG, &status);
> =20
> -	if (!(status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
> -			SUN4I_TCON_GINT0_VBLANK_INT(1) |
> -			SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT)))
> +	/*
> +	 * FSYNC_INT (bit 9) reads unconditionally set on this board -- a
> +	 * confirmed vendor register dump on a genuinely working reference
> +	 * system shows the exact same bit persistently set too (stable
> +	 * across 5 rapid samples), so this is real, expected hardware
> +	 * behavior in DSI/CPU mode, not a bug. What IS a real, measured
> +	 * problem: it toggles far faster than a single regmap_read() can
> +	 * reliably catch (live testing shows genirq's "nobody cared"
> +	 * unhandled-IRQ storm protection tripping and permanently disabling
> +	 * this line within 60-100s, based on this exact read occasionally
> +	 * landing between pulses and seeing status=3D0). Once disabled,
> +	 * sun4i_tcon_handler()'s own TRI_FINISH-based backstop retrigger
> +	 * (see below) is gone for the rest of the boot, for good.
> +	 *
> +	 * In DSI/CPU mode, this driver is the only thing wired to this GIC
> +	 * line -- there is no other legitimate source that this interrupt
> +	 * could be "not for us", unlike the general shared-IRQ case genirq's
> +	 * heuristic is meant to protect against. So in that mode, treat
> +	 * every firing as ours unconditionally rather than trusting a single
> +	 * status snapshot; non-DSI boards sharing this same driver are
> +	 * unaffected and keep the normal status-based check.
> +	 *
> +	 * This is a real trade-off, not a free fix: a line genuinely
> +	 * re-firing this fast means real, ongoing CPU time spent servicing
> +	 * it for as long as this board is in this state, since each call is
> +	 * still a full IRQ entry/exit even though the work inside is cheap.
> +	 * The alternative -- letting genirq disable the line -- is worse:
> +	 * empirically confirmed to permanently kill this handler's own
> +	 * TRI_FINISH-based backstop for the rest of the boot, not just this
> +	 * one noisy source. Moving to DSI's own interrupt (GIC SPI 100,
> +	 * currently unrequested by any driver -- see the comment on
> +	 * SUN6I_DSI_INT_REG in sun6i_mipi_dsi.c) was considered, but there's
> +	 * no evidence that line wouldn't exhibit the same behavior, and
> +	 * requesting an interrupt no other mainline user has ever wired up
> +	 * for this purpose is its own real risk. Left as-is.
> +	 */
> +	handled =3D tcon->dsi_cpu_mode ||
> +		  (status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
> +			     SUN4I_TCON_GINT0_VBLANK_INT(1) |
> +			     SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT |
> +			     SUN4I_TCON_GINT0_TCON0_FSYNC_INT));
> +
> +	if (!handled)
>  		return IRQ_NONE;

[Severity: Medium]
Will this lead to an infinite IRQ storm by unconditionally bypassing
IRQ_NONE?

This logic unconditionally accepts the interrupt as handled if
dsi_cpu_mode is true, preventing the genirq subsystem from disabling
the line on an unhandled storm.

> =20
> -	drm_crtc_handle_vblank(&scrtc->crtc);
> -	sun4i_tcon_finish_page_flip(drm, scrtc);
> +	/*
> +	 * FSYNC_INT alone is not a real vblank/frame-complete event -- it's
> +	 * being acked purely to keep the level interrupt from storming (see
> +	 * the comment above). Firing drm_crtc_handle_vblank()/
> +	 * finish_page_flip() on every FSYNC_INT pulse, unconditionally,
> +	 * generates spurious vblank events and can complete page-flip fences
> +	 * before the frame they're for has actually reached the screen.
> +	 * Only a genuine VBLANK or TRI_FINISH source should do that.
> +	 */
> +	if (status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
> +		      SUN4I_TCON_GINT0_VBLANK_INT(1) |
> +		      SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT)) {
> +		drm_crtc_handle_vblank(&scrtc->crtc);
> +		sun4i_tcon_finish_page_flip(drm, scrtc);
> +	}
> =20
>  	/* Acknowledge the interrupt */
>  	regmap_update_bits(tcon->regs, SUN4I_TCON_GINT0_REG,
>  			   SUN4I_TCON_GINT0_VBLANK_INT(0) |
>  			   SUN4I_TCON_GINT0_VBLANK_INT(1) |
> -			   SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT,
> +			   SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT |
> +			   SUN4I_TCON_GINT0_TCON0_FSYNC_INT,
>  			   0);

[Severity: Medium]
Could this result in an infinite loop if another bit is driving the IRQ lin=
e?

If an unhandled bit (e.g., TRI_COUNTER_INT) is set, it will not be cleared
since this update only targets four specific bits.

Because the handler unconditionally returns IRQ_HANDLED in dsi_cpu_mode,
the GIC will immediately re-fire the level interrupt causing a kernel
hard lockup.

[ ... ]
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index d504ae5832949..20bcfa2ddba19 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
[ ... ]
> @@ -769,29 +910,50 @@ static void sun6i_dsi_encoder_enable(struct drm_enc=
oder *encoder)
>  	phy_configure(dsi->dphy, &opts);
>  	phy_power_on(dsi->dphy);
> =20
> -	if (dsi->panel)
> -		drm_panel_prepare(dsi->panel);
> -
>  	/*
> -	 * FIXME: This should be moved after the switch to HS mode.
> -	 *
> -	 * Unfortunately, once in HS mode, it seems like we're not
> -	 * able to send DCS commands anymore, which would prevent any
> -	 * panel to send any DCS command as part as their enable
> -	 * method, which is quite common.
> -	 *
> -	 * I haven't seen any artifact due to that sub-optimal
> -	 * ordering on the panels I've tested it with, so I guess this
> -	 * will do for now, until that IP is better understood.
> +	 * The HS clock-enable step (DSI_START_HSC) runs before the panel's
> +	 * DCS init sequence rather than after, unlike a previous revision of
> +	 * this driver. Upstream's own comment on this ordering ("this should
> +	 * be moved after the switch to HS mode... I haven't seen any artifact
> +	 * due to that sub-optimal ordering on the panels I've tested it
> +	 * with") already flagged it as suspect without resolving it. The
> +	 * vendor panel driver for this board enables the HS clock as the
> +	 * very first step of its panel-init routine, before sending any DCS
> +	 * command. This doesn't conflict with DCS needing LP mode: HSC only
> +	 * puts the clock lane into its continuous-HS state, and DCS commands
> +	 * use the entirely separate LPTX/LPDT instruction tables.
>  	 *
> -	 */
> -	if (dsi->panel)
> -		drm_panel_enable(dsi->panel);
> -
>  	sun6i_dsi_start(dsi, DSI_START_HSC);
> =20
>  	udelay(1000);
> =20
> +	if (dsi->panel)
> +		drm_panel_prepare(dsi->panel);
> +
> +	if (dsi->panel)
> +		drm_panel_enable(dsi->panel);

[Severity: Medium]
Could this unconditional reordering of DSI_START_HSC before
drm_panel_prepare() break existing panels?

Existing panels that expect the DSI clock lane to remain in Low Power (LP)
mode during their DCS initialization may fail to configure correctly.

The commit message acknowledges this is a global change and was not verified
against other panels sharing the driver.

[ ... ]
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun=
4i/sun8i_tcon_top.c
> index 9cbd655518b20..45913d90d30c8 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -143,12 +143,86 @@ int sun8i_tcon_top_de_config(struct device *dev, in=
t mixer, int tcon)
>  }
>  EXPORT_SYMBOL(sun8i_tcon_top_de_config);
> =20
> +/*
> + * The vendor implementation's DSI configuration path unconditionally
> + * enables this same bit (TCON_TOP_GATE_SRC_REG, TCON_TOP_TCON_DSI_GATE)
> + * for TCON0. Mainline already registers it as a standard clk gate
> + * (CLK_TCON_TOP_DSI, see sun8i_tcon_top_register_gate() above), but
> + * nothing consumes it: wiring it as dsi0's "mod" clock creates a circul=
ar
> + * dependency between TCON TOP's .bind() and dsi0's .probe() (see the DTS
> + * comment on the dsi0 node). This sets the bit directly instead, the sa=
me
> + * way sun8i_tcon_top_set_hdmi_src() and sun8i_tcon_top_de_config() above
> + * already bypass the clk-consumer graph for their own TCON TOP writes.
> + */
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
> +	spin_lock_irqsave(&tcon_top->reg_lock, flags);

[Severity: High]
This is a pre-existing issue, but is it possible for unbinding the
sun8i_tcon_top driver via sysfs to clear its drvdata, leading to a NULL
pointer dereference here?

The sun8i_tcon_top_platform_driver lacks a remove function. If unbound via
sysfs, the device core clears the device's drvdata to NULL.

Because DRM is unaware the component is gone (no component_del is called),
a subsequent modeset calling this function will retrieve a NULL tcon_top
and crash on the spinlock access.

> +
> +	val =3D readl(tcon_top->regs + TCON_TOP_GATE_SRC_REG);
> +	if (enable)
> +		val |=3D BIT(TCON_TOP_TCON_DSI_GATE);
> +	else
> +		val &=3D ~BIT(TCON_TOP_TCON_DSI_GATE);
> +	writel(val, tcon_top->regs + TCON_TOP_GATE_SRC_REG);
> +
> +	spin_unlock_irqrestore(&tcon_top->reg_lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(sun8i_tcon_top_set_dsi_gate);
> +
> +/*
> + * TCON_TOP_PORT_SEL_REG routes each DE's output to one of the 4 TCON
> + * ports. The only existing caller of the read-modify-write helper for
> + * this register (sun8i_tcon_top_de_config()) is wired up exclusively fr=
om
> + * sun8i_r40_tcon_tv_set_mux(), which only runs for TCON quirks tables
> + * that provide a .set_mux callback -- ours doesn't, the same gap
> + * sun8i_tcon_top_set_dsi_gate() above works around for the DSI clock ga=
te
> + * bit. DE0's live PORT_SEL field on a working reference system is 0
> + * (port 0), matching this register's reset default -- written explicitly
> + * here rather than relying on that default, since nothing in mainline
> + * otherwise reaches this register for a .set_mux-less quirks table.
> + */
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
> +	spin_lock_irqsave(&tcon_top->reg_lock, flags);

[Severity: High]
This isn't a bug introduced by this patch, but does this share the exact
same architectural vulnerability as sun8i_tcon_top_set_dsi_gate()?

A sysfs unbind clearing drvdata will cause a NULL pointer dereference here
when tcon_top is accessed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912114331.9295=
6-1-leow149@lucidmail.xyz?part=3D1
