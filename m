Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AA5C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D268010EC16;
	Tue, 30 Jun 2026 11:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LEE7kntH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBE310EC16
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:00:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D59A7600FF;
 Tue, 30 Jun 2026 11:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634D41F000E9;
 Tue, 30 Jun 2026 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782817234;
 bh=Cyj8b8W+fJe8W4rVh37tiOwIBeLVPM582EUfWMxtxeE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LEE7kntHKQkWSefEiq8HdmHHMzeBK9SqVFx3k/9DYaaCECkiweMvaHGQe7GJlilFD
 NfO1rgHVhL/tbZ97RqnBdw/fdrW3p9m6fN4xrwk72LBr/eO6+GkewD5wSKVezNwAdq
 Lu/xQoszKIn1dh4dLEaldcMsY1WPcGOywZ8hR3rtup6uPpFZ5SEnZaw54RrJPfVVYy
 8PGsmqTvSetpjU+2kKQvW3Pr4Zdl3hg8r/AplMPWoLxySSWgMXVIyeoKh76qakeMm5
 NWBV/yZCPRBAwtIQWFscPdm8cpWESu+bX1X4V/GSW3XU0RfrDFkpDVbqwIxUDtiaCz
 o7aNE6V8SjV4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tidss: Fix synclost issue while disabling layer due
 to erratum i2097
To: "Yashas D" <y-d@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630103802.1853564-1-y-d@ti.com>
References: <20260630103802.1853564-1-y-d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:00:33 +0000
Message-Id: <20260630110034.634D41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The newly added `fclk_rate` field is never populated, causing the =
hardware delay computation to unconditionally fall back to a hardcoded defa=
ult.
- [High] Deferring layer disable writes to `dispc_vp_go()` breaks CRTC tear=
down and modesets, leaving layers persistently enabled in hardware.
- [Low] The AM62L specific workaround in `dispc_ovr_enable_layer()` incorre=
ctly hardcodes both the videoport and layer indices to `0`.
--

commit 6082951d3123b46199528652dff5e8564f311738
Author: Yashas D <y-d@ti.com>
drm/tidss: Fix synclost issue while disabling layer due to erratum i2097

A gap beyond a frame duration for disabling the layer in overlay manager
and go bit setting on the corresponding video port may lead to SYNC_LOST.
Fix by moving the layer to the non-visible area and deferring the ENABLE=3D0
write, immediately before the GO bit, guaranteeing both occur within the
same frame window.

Link: https://www.ti.com/lit/pdf/sprz530

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 58d5eb033bdbb..6cbf9dfc38b87 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -467,6 +469,8 @@ struct dispc_device {
> =20
>  	struct clk *fclk;
> =20
> +	unsigned long fclk_rate;
> +

[ ... ]

> @@ -1233,6 +1246,38 @@ void dispc_vp_go(struct dispc_device *dispc, u32 h=
w_videoport)
>  {
>  	WARN_ON(VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL,
>  			   DISPC_VP_CONTROL_GOBIT_MASK));
> +
> +	if (dispc->errata.i2097 &&
> +	    dispc->pending_disable_layers[hw_videoport]) {
> +		u32 layer;
> +		u32 delay_ns;
> +
> +		/* WA for erratum i2097: set GO bit #1 to latch position
> +		 * changes into the DSS pipeline, wait 10 DSS functional clock
> +		 * cycles, then write ENABLE=3D0.
> +		 */
> +		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
> +			       DISPC_VP_CONTROL_GOBIT_MASK);
> +
> +		if (dispc->fclk_rate)
> +			delay_ns =3D DIV_ROUND_UP_ULL((u64)10 * NSEC_PER_SEC,
> +						    dispc->fclk_rate);
> +		else
> +			delay_ns =3D 500;

[Severity: High]
Does fclk_rate ever get initialized?

The newly added fclk_rate field in struct dispc_device does not appear to be
populated anywhere in the driver.

This causes the hardware delay computation to unconditionally fall back to
the hardcoded 500ns default. If the DSS functional clock is slower than 20M=
Hz,
500ns is less than the 10 clock cycles strictly required by the hardware er=
ratum
workaround.

Will this cause the driver to write ENABLE=3D0 too early and potentially tr=
igger
the SYNC_LOST bug it intends to fix?

[ ... ]

> @@ -1503,6 +1548,63 @@ void dispc_ovr_enable_layer(struct dispc_device *d=
ispc,
>  	if (dispc->feat->subrev =3D=3D DISPC_K2G)
>  		return;
> =20
> +	if (dispc->errata.i2097 && !enable) {
> +		/*
> +		 * WA for erratum i2097:
> +		 *
> +		 * Do not write ENABLE=3D0 directly. Instead move the layer to
> +		 * the non-visible area so it contributes no pixels.
> +		 *
> +		 * Position register layout differs per SoC:
> +		 *   J721E : DISPC_OVR_ATTRIBUTES2, X[13:0],  Y[29:16] (14-bit)
> +		 *   Others: DISPC_OVR_ATTRIBUTES,  X[17:6],  Y[30:19] (12-bit)
> +		 */
> +		switch (dispc->feat->subrev) {
> +		case DISPC_J721E:
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES2(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSX_MASK),
> +					DISPC_OVR_ATTRIBUTES2_POSX_MASK);
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES2(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSY_MASK),
> +					DISPC_OVR_ATTRIBUTES2_POSY_MASK);
> +			break;
> +		case DISPC_AM62L:
> +			OVR_REG_FLD_MOD(dispc, 0,
> +					DISPC_OVR_ATTRIBUTES(0),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSX_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSX_MASK);
> +			OVR_REG_FLD_MOD(dispc, 0,
> +					DISPC_OVR_ATTRIBUTES(0),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSY_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSY_MASK);
> +			break;

[Severity: Low]
Is it intentional to hardcode 0 for the videoport and layer indices here
instead of using the function arguments hw_videoport and layer?

While AM62L hardware currently only defines one videoport and one layer, th=
is
hardcoding creates a disconnect where the tracking update below uses the
function arguments (dispc->pending_disable_layers[hw_videoport] |=3D BIT(la=
yer))
while the hardware writes to VP 0.

Does this specific switch case need to exist, given that the default case
handles the exact same registers but correctly utilizes the function argume=
nts?

> +		default:
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSX_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSX_MASK);
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSY_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSY_MASK);
> +			break;
> +		}
> +
> +		dispc->pending_disable_layers[hw_videoport] |=3D BIT(layer);
> +		return;
> +	}

[Severity: High]
Does deferring this layer disable write break CRTC teardown?

During CRTC disable, tidss_crtc_atomic_disable() attempts to disable all
layers, which now sets pending_disable_layers and returns early. The deferr=
ed
write is supposedly handled in dispc_vp_go().

However, during a CRTC disable, tidss_crtc_atomic_flush() explicitly skips
calling dispc_vp_go():

drivers/gpu/drm/tidss/tidss_crtc.c:tidss_crtc_atomic_flush() {
    ...
    if (drm_atomic_crtc_needs_modeset(crtc->state))
        return;
    ...
}

Because of this, the ENABLE=3D0 write appears to be lost, leaving layers en=
abled
in the hardware registers when the videoport is disabled.=20

Will this break the existing hardware workaround documented in
tidss_crtc_atomic_disable() that warns against leaving a layer enabled while
its videoport is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630103802.1853=
564-1-y-d@ti.com?part=3D1
