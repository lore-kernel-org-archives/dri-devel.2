Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A63C531D0
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 01:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D653E10E358;
	Tue, 28 Jul 2026 01:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SUSupatv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0F910E308
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 01:08:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A6D860A62;
 Tue, 28 Jul 2026 01:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2D41F00A3D;
 Tue, 28 Jul 2026 01:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785200902;
 bh=h54bUsym0mJ2tkFApisjQj+07k4XqpIXaus5OuOztwg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SUSupatvhmWMfSICBRC2GbaZgr/phA/J5QGahpcbsoH3z9voaWteQAF5dwwo/ReBn
 99+EaFm0Bx+fWtRIYQHwlabyOEAgeOe5Y0aPldoRIsP/5ould9ifWI4mssdkAsikHy
 LkmQiiHZXwxfymFa1vC4f6wwDd+j1qZKvvrzGcpGS9kUdasvcoUelUi05AeH9QjPEW
 zBgP/T6mzFmT7bH2PDU6xDGIc84vpvbScDL2fOZcujOqM+jQ6IGFGRj/V9d1WsFCOn
 R2yA199dj1oP+x9D4trHX3IUWF5DIGUrxmOo/yew8xvT45uFl2nLSYCiL0V3gQHU6j
 9kEvXtwQBbKIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: chipone-icna35xx: Fix picture parameter set
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727-icna35xx-pps-v1-1-691d79d13ee4@gmail.com>
References: <20260727-icna35xx-pps-v1-1-691d79d13ee4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:08:21 +0000
Message-Id: <20260728010821.AC2D41F00A3D@smtp.kernel.org>
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
- [Medium] Direct calls to `mipi_dsi_dcs_write()` bypass the `mipi_dsi_mult=
i_context` error accumulation, ignoring both previous errors and their own =
failures.
--

--- Patch [1]: [PATCH] drm/panel: chipone-icna35xx: Fix picture parameter s=
et ---
commit 5c76e85884612ecbbcfd07cbe14b3a2d283f6c53
Author: Aaron Kling <webgeek1234@gmail.com>

drm/panel: chipone-icna35xx: Fix picture parameter set
   =20
This commit updates the chipone-icna35xx panel driver to send picture
parameter set (PPS) data using vendor-specific DCS writes rather than the
standard MIPI DSI command. This resolves an issue with configuring 10-bit
modes on these panels.

> diff --git a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c b/drivers/gpu=
/drm/panel/panel-chipone-icna35xx.c
> index 2cc16494a4cef..b2422ffc1d1c5 100644
> --- a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
> +++ b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c

[ ... ]

> @@ -91,7 +92,14 @@ static int icna3512_init_sequence(struct panel_info *p=
info)
>  	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x20);
> =20
>  	drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
> -	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xC6, 0x11, 0x88);
> +
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC7, pps_ptr, 32);
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC8, pps_ptr + 32, 32);
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC9, pps_ptr + 64, 24);

[Severity: Medium]
Do these direct mipi_dsi_dcs_write() calls bypass the multi-context error
handling?

Since icna3512_init_sequence() is using mipi_dsi_multi_context, the
_multi() variants will check and update dsi_ctx.accum_err. Calling
mipi_dsi_dcs_write() directly ignores any previous errors and discards
its own return values, which might lead to silent failures if the PPS data
transmission fails.

> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0xA5, 0xA5);
> =20
>  	mipi_dsi_msleep(&dsi_ctx, 20);

[ ... ]

> @@ -133,7 +142,14 @@ static int icna3520_init_sequence(struct panel_info =
*pinfo)
>  	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB2, 0x24);
> =20
>  	drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
> -	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xC0, 0x1A, 0x71);
> +
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC1, pps_ptr, 32);
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC2, pps_ptr + 32, 32);
> +	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC3, pps_ptr + 64, 24);

[Severity: Medium]
Does this sequence in icna3520_init_sequence() also bypass the error
accumulation?

Similar to the above, we might need a multi-aware wrapper or macro here
to ensure errors are caught and execution stops appropriately if a previous
command failed.

> +
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0xA5, 0xA5);
> =20
>  	mipi_dsi_msleep(&dsi_ctx, 20);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-icna35xx-p=
ps-v1-1-691d79d13ee4@gmail.com?part=3D1
