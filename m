Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60960CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C609211A03D;
	Thu,  4 Jun 2026 13:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SX0Cxo8B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD9711A03D
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:03:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F9AD602A8;
 Thu,  4 Jun 2026 13:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE0F1F00893;
 Thu,  4 Jun 2026 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780578229;
 bh=/cQIfDTmPamhUrO7S+CbyCIkxT00gNlbbtKPI4VR8xQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SX0Cxo8Bg+13E+DEjJRhxnFTHQYz/1PAkMinIXBVstSLKWlJVnPOAy+pIwaPDCzlQ
 XYHxCfKRVU5BAWDa0QK93sPGyZYb5WbSZKUj3CtoKGzrUvM8qubR4VYHphC0hJIRxe
 APcvctFHzg2VbJjvJIU0TZXuTGWGaIJ/y9dyXB3qOdtyFOwKhZZwN1PK4HXjAof0nm
 mV4MPmdOhpaVk+C7F+v68XY4aV8t9vZFoplW4bfhnqEr2JNsZW7PlQ3XM2RXiCOJyX
 44qZBQGmZQbVI9TDItak2X6e8YD920rJq0BycpxeK7poeLrcuxEPFFUO82+dAv/QL6
 XCFj5G6/cY3Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-topic-sm8x50-vtdr6130-dsc-v1-1-09bcd1dff1fb@linaro.org>
References: <20260604-topic-sm8x50-vtdr6130-dsc-v1-1-09bcd1dff1fb@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:03:48 +0000
Message-Id: <20260604130349.2BE0F1F00893@smtp.kernel.org>
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
- [Low] The panel driver DRM_PANEL_VISIONOX_VTDR6130 lacks Kconfig dependen=
cies for DSC helpers, causing a linker error when compiled without them.
--

commit 2b76aa2af63143268815713af0dc4f51234d7f43
Author: Jun Nie <jun.nie@linaro.org>

drm/panel: Enable DSC for Visionox VTDR6130 panel

This commit enables display compression (DSC v1.2) for the 1080x2400 Vision=
ox
VTDR6130 AMOLED DSI panel. It sets up the DSC configuration parameters and
sends the picture parameter set during panel initialization.

> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gp=
u/drm/panel/panel-visionox-vtdr6130.c
> index 97a79411e1ecd..0cdcdbbc766da 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
[ ... ]
> @@ -123,6 +128,9 @@ static int visionox_vtdr6130_on(struct visionox_vtdr6=
130 *ctx)
>  	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>  	mipi_dsi_msleep(&dsi_ctx, 20);
> =20
> +	drm_dsc_pps_payload_pack(&pps, dsi->dsc);

[Severity: Low]
Will this cause a linker error if CONFIG_DRM_DISPLAY_DSC_HELPER is not enab=
led?

This adds a call to drm_dsc_pps_payload_pack(), but it doesn't appear to
update the Kconfig entry for DRM_PANEL_VISIONOX_VTDR6130 to select
DRM_DISPLAY_DSC_HELPER and DRM_DISPLAY_HELPER.

Could this lead to undefined reference errors during the build for
configurations where the panel is enabled but the helpers are not?

> +	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +
>  	return dsi_ctx.accum_err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-topic-sm8x=
50-vtdr6130-dsc-v1-0-09bcd1dff1fb@linaro.org?part=3D1
