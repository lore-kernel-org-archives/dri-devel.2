Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67BCCDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDF210F219;
	Thu, 25 Jun 2026 09:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nTrPDW5U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B57610F210
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:47:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A91A6014C;
 Thu, 25 Jun 2026 09:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3891F00A3A;
 Thu, 25 Jun 2026 09:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782380839;
 bh=uPV6Bbmm1ps40tq6tdPEhvSIZ2sYul+4VQEUBVs522s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nTrPDW5UwVmpzyZU+wFY0rB0oJN1svwP+bPrNx0CibHJFlc/SBP4Db1MicX0Hgnu4
 pJ0nJYhXLEhLhXkNOJZ45nUoIVw8ALVznRjYRw6YEvT3Ect9srJEpDxWDRRNiILLm0
 0PbAJ/EyHOdl0u6mKqv9SFMlh8BOdXwxo5Agj1bGD//awTXAY/Ny/3DJNsx28dh6a/
 4S420P4p5RHFEyrtWQsxFY7fSdsXc5eev9PKg/u1VTUMpzqYt7J0QVqu3uuspH9Ked
 8APlXkDBP5tuuPKw0bEGD7YjU3uUXDDNmTbU+TUkdET+FDOv7ySjlq2i27SQfhbu17
 7MbzAbMnB9S4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-topic-sm8x50-vtdr6130-dsc-v2-1-cd375ef0e0ce@linaro.org>
References: <20260625-topic-sm8x50-vtdr6130-dsc-v2-0-cd375ef0e0ce@linaro.org>
 <20260625-topic-sm8x50-vtdr6130-dsc-v2-1-cd375ef0e0ce@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 09:47:18 +0000
Message-Id: <20260625094719.1C3891F00A3A@smtp.kernel.org>
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
- [Low] DRM_PANEL_VISIONOX_VTDR6130 selects DRM_DISPLAY_DSC_HELPER without =
selecting its dependency DRM_DISPLAY_HELPER, causing Kconfig warnings and l=
inker errors.
--

commit 907cf541c38810dd47d3b40db2c3237ed1d8ffd9
Author: Jun Nie <jun.nie@linaro.org>

drm/panel: Enable DSC for Visionox VTDR6130 panel

This commit enables display compression (DSC v1.2) for the 1080x2400
Visionox VTDR6130 AMOLED DSI panel.

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index c0cc2bb4a3eb7..298c08f293260 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -1352,6 +1352,7 @@ config DRM_PANEL_VISIONOX_VTDR6130
>  	depends on OF
>  	depends on DRM_MIPI_DSI
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER

[Severity: Low]
Does this selection also require selecting or depending on DRM_DISPLAY_HELP=
ER?

If a user configures the kernel with CONFIG_DRM_PANEL_VISIONOX_VTDR6130=3Dy
but does not enable CONFIG_DRM_DISPLAY_HELPER, Kconfig can emit an unmet
direct dependency warning.=20

This can lead to a linker error for missing DSC helper functions like
drm_dsc_pps_payload_pack(), since drm_dsc_helper.o is built as part of
drm_display_helper-y and is only linked if CONFIG_DRM_DISPLAY_HELPER is
enabled.

>  	help
>  	  Say Y here if you want to enable support for Visionox
>  	  VTDR6130 1080x2400 AMOLED DSI panel.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-topic-sm8x=
50-vtdr6130-dsc-v2-0-cd375ef0e0ce@linaro.org?part=3D1
