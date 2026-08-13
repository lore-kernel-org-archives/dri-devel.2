Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73768C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 23:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9D610E041;
	Thu, 13 Aug 2026 23:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jbduvpIl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5FD10E041
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 23:47:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D16E7403FB;
 Thu, 13 Aug 2026 23:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186AD1F000E9;
 Thu, 13 Aug 2026 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786664824;
 bh=QEzQV2S+Tfz4esfkkryx5cKNEx+qezwKDLILEi+swwM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jbduvpIl7APYt4DmHi+ICcLZ+/mnQ+mzV52E/eFWIdAnRMZQ+M+7oKjCUEln4IsR2
 +VVcklWNn7E8SG/d1V4t2dKYQJM95UhxG4WlwqHH2KeQvnXoHaTjb55YdSS/j96wSM
 eD6KtM9/RVuPgvcshQEKNE2xWBnO4Co5/UiVIsavnK9SxV8h9ceRkB0oaKVbynQAmV
 Y8NlEG/m0krve8qph9IjLJqYx84G7MJFiQx3ESspOru/KwnqAl1KVUn80/bSxc9uyR
 hWwUYF6ls2sSmXi8ZCxwkw024XIHJxg12uzBmD0+NV4WbxiDJZABUGURP/vNOuAyQh
 C4hD9rkRY3NLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/21] drm: renesas: rz-du: Add RZ/G3E support
To: "Tommaso Merciai" <tommaso.merciai.xr@bp.renesas.com>
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org
In-Reply-To: <11313371ef0b31cb5f014e171ba0d9868eb0710d.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
References: <11313371ef0b31cb5f014e171ba0d9868eb0710d.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:47:00 +0000
Message-Id: <20260813234701.186AD1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Strict equality check for `rstate->outputs` fails for dual-link or=
 cloned configurations, causing incorrect clock duty cycle.
--

--- Patch [15]: [PATCH v6 15/21] drm: renesas: rz-du: Add RZ/G3E support ---
commit 93ac2aa593af29d345db6eb285c2df970c9009bd
Author: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

drm: renesas: rz-du: Add RZ/G3E support

This commit adds support for the RZ/G3E SoC to the RZ/G2L DU driver. It
introduces the RZG2L_DU_FEATURE_SMUX2_DSI_CLK feature flag to set the corre=
ct
clock duty cycle based on the selected output (LVDS vs DSI/RGB).

> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/=
drm/renesas/rz-du/rzg2l_du_crtc.c
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
[ ... ]
> @@ -64,11 +64,32 @@
>  static void rzg2l_du_crtc_set_display_timing(struct rzg2l_du_crtc *rcrtc)
>  {
[ ... ]
> +	if (rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_SMUX2_DSI_CLK)) {
> +		struct clk *clk_parent;
> +
> +		clk_parent =3D clk_get_parent(rcrtc->rzg2l_clocks.dclk);
> +
> +		/*
> +		 * Request appropriate duty cycle to let clock driver select
> +		 * the correct parent:
> +		 * - CDIV7_DSIx_CLK (LVDS path) has DUTY H/L=3D4/3, 4/7 duty cycle.
> +		 * - CSDIV_2to16_PLLDSIx (DSI/RGB path) has symmetric 50% duty cycle.
> +		 */
> +		if (rstate->outputs =3D=3D BIT(RZG2L_DU_OUTPUT_LVDS0) ||
> +		    rstate->outputs =3D=3D BIT(RZG2L_DU_OUTPUT_LVDS1))

[Severity: High]
Will this strict equality check fail for dual-link LVDS configurations?

If a dual-channel LVDS panel is configured, the DRM encoder mask may contain
two encoders to drive both links. In that case, rzg2l_du_crtc_atomic_check()
would accumulate both bits, meaning rstate->outputs would have both LVDS0
and LVDS1 bits set.

Because this relies on strict equality rather than a bitwise mask check, do=
es
this condition evaluate to false and incorrectly fall back to the 50% duty
cycle intended for DSI/RGB paths?

> +			clk_set_duty_cycle(clk_parent, 4, 7);
> +		else
> +			clk_set_duty_cycle(clk_parent, 1, 2);
> +	}
> +
>  	clk_set_rate(rcrtc->rzg2l_clocks.dclk, mode_clock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1775636898.gi=
t.tommaso.merciai.xr@bp.renesas.com?part=3D15
