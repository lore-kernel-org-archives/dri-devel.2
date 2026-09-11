Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D8DC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C719510E237;
	Fri, 11 Sep 2026 09:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mSI3rvXJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E192610E237
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:09:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A63134080E;
 Fri, 11 Sep 2026 09:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C931F00898;
 Fri, 11 Sep 2026 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789117797;
 bh=yhcT9DVCms/R9Gf6VCkcTCqnS/Dzfca5zAxP7CtteL8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mSI3rvXJl8AofQRy82dqnzOJT/wTATVcVFszDx+ednFiQVLZvp0qCkIfpOwwPugrE
 y8gJB9ZREnkTKzQQonoWoasJ/EC8XFIG83BJ+oj+WDf1FGXAQjAdXTqC1uVCqvat9J
 tWs/rPt+KS5RYeB+DFMi9Yzjv8hx33SNPvSzHSy851+ot4qY9cWi0tvPNSdAaDfNU9
 X/EYNaQVJ+TPMYWmQmkvjnSP4rdtlyWJqzO388+Q9KZ3geG04QCX3WvK31gV8Yj6Ap
 51vk1WdFd0vEA7s5ty10Dxs0/5oXrieQLYLZgwc2NivknhsS9/p5npf6HDUR8yX6uW
 LfXx7ElCxPL0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/10] drm/panel: novatek-nt36672a: add Tianma FHD+
 video mode panel
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org,
 linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-4-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-4-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:09:56 +0000
Message-Id: <20260911090957.12C931F00898@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware initialization and teardown sequence reversal
- [Low] Unconditional delay on error path due to bypassing `mipi_dsi_msleep=
()`
--

commit 3b4bbeb999e6951e81e05057ded69945b990ecb4
Author: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

drm/panel: novatek-nt36672a: add Tianma FHD+ video mode panel

This commit adds support for the 1080x2340 Tianma video mode panel with
Novatek NT36672A driver IC. It adds display mode timings, DCS initialization
sequences, and standard DRM panel enable and disable callbacks to coordinate
display commands with the active DSI video stream.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu=
/drm/panel/panel-novatek-nt36672a.c
> index 464d9ce47d87d..b69213790441f 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -92,18 +92,12 @@ static int nt36672a_panel_unprepare(struct drm_panel =
*panel)
>  	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D pinfo->link };
> =20
>  	/* send off cmds */
>  	if (pinfo->desc->send_deinit_cmds)
>  		pinfo->desc->send_deinit_cmds(&dsi_ctx);

[Severity: High]
Does this sequence execute deinitialization commands after the panel is alr=
eady
turned off? The new disable callback will turn off the display before the
unprepare callback runs, meaning the panel might not be able to process the=
se
deinitialization commands correctly.

[ ... ]
> @@ -146,19 +139,41 @@ static int nt36672a_panel_prepare(struct drm_panel =
*panel)
> =20
>  	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> =20
> -	/* 0x46 =3D 70 ms delay */
> -	mipi_dsi_msleep(&dsi_ctx, 70);
> -
> -	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	/* 80 ms delay as per DCS spec / downstream timing */
> +	msleep(80);

[Severity: Low]
Does this unconditional msleep() cause unnecessary delays on error paths?
Because this replaces mipi_dsi_msleep(), if the preceding DCS commands
fail, dsi_ctx.accum_err is set, but this code will still unconditionally
sleep for 80ms.

> =20
>  	/* Send rest of the init cmds */
>  	if (pinfo->desc->send_init_cmds_2)
>  		pinfo->desc->send_init_cmds_2(&dsi_ctx);

[Severity: High]
Will the panel properly handle these secondary initialization commands whil=
e=20
the display is still off? Since this patch moves the set display on command
into the enable callback, these post-on brightness settings are being sent
before the display is turned on, which might cause initialization failures =
or
visual artifacts.

[ ... ]
> +static int nt36672a_panel_enable(struct drm_panel *panel)
> +{
> +	struct nt36672a_panel *pinfo =3D to_nt36672a_panel(panel);
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D pinfo->link };
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	/* Frame settling delay */
> +	msleep(20);

[Severity: Low]
Does this msleep() also need to check for preceding errors? This creates an
unconditional sleep that ignores potential errors from the preceding=20
mipi_dsi_dcs_set_display_on_multi() call.

> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt36672a_panel_disable(struct drm_panel *panel)
> +{
> +	struct nt36672a_panel *pinfo =3D to_nt36672a_panel(panel);
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D pinfo->link };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +
> +	/* 120ms delay as per DCS spec */
> +	msleep(120);

[Severity: Low]
Similar to the enable path, is this unconditional sleep intended? It ignores
potential errors from the preceding mipi_dsi_dcs_set_display_off_multi() ca=
ll,
causing unnecessary delays during teardown failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D4
