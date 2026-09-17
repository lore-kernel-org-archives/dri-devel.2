Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C92C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBAE10E766;
	Thu, 17 Sep 2026 16:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HngNrs3+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C2510E766
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:55:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66521407C9;
 Thu, 17 Sep 2026 16:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10AF1F00893;
 Thu, 17 Sep 2026 16:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789664105;
 bh=hdMWxFaReQNrBONPks9rCkvr9HbAFCBDYi2fYllmLK0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HngNrs3+7AqsdPTj2xsxgPM08gtyUtsRMirNbMtGLWHLN2yU6zwxXmPum8C96E4em
 q8vfWkIMYGC+o1XaKXppPbG/KIQsmLdwRZMvaCFKDtAdzfqqW0sozBlgmvS184PqpQ
 A0M9dIZ+yQFrPLJZ3YH0n+72oyvpY0cBiheLI0rMQtqbEwk70G2CbdTkegfo6fUVDR
 I57Abrmwi/lKV0AFVYUq3g0jqw7KMVzE56lIWCs+PtUQiNr+2hFFHaIymlHKvMNix/
 ACckVQSLxCfAiWSwKUHPfr/KJr5ZvPxzcC/kOmZfC/EYvWWOP4s5LSPIR/qt3K3nNN
 MZTZ4sXQLBE3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] drm/panel: novatek-nt36672a: Add 3 panels used
 in Xiaomi phones
To: "Alexey Minnekhanov" <alexeymin@minlexx.ru>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260917-nt36672a-panels-v2-6-f8de8be5b86f@minlexx.ru>
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
 <20260917-nt36672a-panels-v2-6-f8de8be5b86f@minlexx.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:55:04 +0000
Message-Id: <20260917165504.F10AF1F00893@smtp.kernel.org>
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
- [Medium] drm/panel: nt36672a: skipped power-down sequence on partial comm=
and failure
--

commit dfbf7416bcb60d153c91f5ee831680912a52282d
Author: Alexey Minnekhanov <alexeymin@minlexx.ru>

drm/panel: novatek-nt36672a: Add 3 panels used in Xiaomi phones

This commit adds support for 3 DSI video mode panels used in Xiaomi Redmi
Note 6 Pro and Note 7, which share the Novatek NT36672A controller. The
panels use a common initialization and de-initialization sequence with
minor variations.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu=
/drm/panel/panel-novatek-nt36672a.c
> index a445c8067aa5f..d356348d39608 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
[ ... ]
> +static void lavender_tulip_deinit_cmds(struct mipi_dsi_multi_context *ds=
i_ctx)
> +{
> +	dsi_ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 20);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 120);

[Severity: Medium]
Does this sequence introduce a regression by skipping the hardware power-do=
wn
commands if the initial display-off command fails?

If mipi_dsi_dcs_set_display_off_multi() encounters an error, it sets
dsi_ctx->accum_err. Because accum_err is not reset to 0 before the following
commands, mipi_dsi_msleep() and mipi_dsi_dcs_enter_sleep_mode_multi() will
immediately return without executing.

Bypassing the panel's sleep sequence and mandatory delays before cutting
regulator power can cause visual artifacts like flashes or fading, and might
violate hardware power sequencing requirements.

Should we reset dsi_ctx->accum_err to 0 after the display-off command to
ensure the sleep mode and delay commands still execute, similar to what is
already done in tianma_fhd_video_send_deinit_cmds()?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-nt36672a-p=
anels-v2-0-f8de8be5b86f@minlexx.ru?part=3D6
