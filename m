Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DB5CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 12:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D17E10E1C9;
	Sun, 11 Oct 2026 12:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cwaUiF8R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8758A10E1C9
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 12:03:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C365C600AA;
 Sun, 11 Oct 2026 12:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1661F0089B;
 Sun, 11 Oct 2026 12:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791720219;
 bh=EzOSn6ZJbap8JCOwDrueEfQiP20vyQ1KvpGltDogKSA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cwaUiF8Rhc5UB76XRdLZv5fF2mIGD4g/I7q2SwfVs1YKhql/tkDFIUftn0PBGb/XW
 0uItH5aYENX3Btauyny6L3NJ7sCUNtLuZ7E3IeHb3Bd8EIkzatxbU2s8nCobPzLnrN
 Fbgk0GUSz6r4Nbn8Ke8oayyFi/RqeiEM1WyGd6emcg5PJ3uBlanCbcG1/7tBwrZnQr
 cU5i18eW34qLC0CgrS5kNC0U/GupihWmSkHrmGoM8DrNb18ZgFbnHWF1FMM5zm9zkV
 GBeVshux7ZmhvbqSyKmliRqefUoJTA47q56GImBKDn9ExGuKxJsyxAJf0WM1ZoFtax
 2ooyD4VgbjeHw==
Message-ID: <sashiko-outbox-167208@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] drm/panel: novatek-nt36672a: Add panel for Asus
 Zenfone Max Pro M1
To: "Alexey Minnekhanov" <alexeymin@minlexx.ru>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261011-nt36672a-panels-v3-8-9ea238627f8a@minlexx.ru>
References: <20261011-nt36672a-panels-v3-0-9ea238627f8a@minlexx.ru>
 <20261011-nt36672a-panels-v3-8-9ea238627f8a@minlexx.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 12:03:38 +0000
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
- [Medium] drm/panel: skipped deinit delays on DSI command failure
--

commit 3072360323238f49eea2657047c2842ee3b0aa0f
Author: Alexey Minnekhanov <alexeymin@minlexx.ru>

drm/panel: novatek-nt36672a: Add panel for Asus Zenfone Max Pro M1

This commit adds support for the TXD TXDI600YANPA-43V3 video mode panel bas=
ed
on Novatek NT36672A, used in the Asus Zenfone Max Pro M1 smartphone.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu=
/drm/panel/panel-novatek-nt36672a.c
> index 48dff2279b0e9..7d7c79d2502d2 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
[ ... ]
> +static void txd_x00td_deinit_cmds(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 50);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 120);

[Severity: Medium]
If a preceding DSI command fails, dsi_ctx->accum_err will be set, which cau=
ses
mipi_dsi_msleep() to completely skip its delay:

#define mipi_dsi_msleep(ctx, delay) \
	do { \
		if (!(ctx)->accum_err) \
			msleep(delay); \
	} while (0)

Could this result in the regulators being prematurely powered off while the
panel is still active or transitioning?=20

Safe power-down sequences typically require hardware delays regardless of
whether the sleep commands successfully transmitted. Should this code either
reset dsi_ctx->accum_err prior to sleeping, or use an unconditional msleep()
instead to guarantee the hardware settles?

> +}
> +
>  static const struct drm_display_mode tianma_fhd_video_panel_default_mode=
 =3D {
>  	.clock		=3D 161331,
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-nt36672a-p=
anels-v3-0-9ea238627f8a@minlexx.ru?part=3D8
