Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF25DCDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C95410F22B;
	Thu, 25 Jun 2026 10:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mZES0BhR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12AF510F229
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:22:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1483440D8;
 Thu, 25 Jun 2026 10:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777AD1F00A3A;
 Thu, 25 Jun 2026 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782382928;
 bh=yLJeep5IuhycEZg2kBNl+sQC2H+Q7PjuP10Kajolifo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mZES0BhRVJ/NFHUuTyRSLjFfL5lLOUgMveGEwBV+UFZ+up0UkSjtfAcIje3wk4LCN
 FvjNZA1GFX4jNPS5Z7zrRobU0LNUAZ8s+vsG/IopbALvWh3j7hQvdvzEr/TvtAVCdw
 mrPfQovHlTYjbLG9SRTpcDrQa7D2uXfMvzuO2eG0OKqJEkHFWZHyngDFQL4TkYRAgd
 3rJVoj2JvLn9fweotQDq8qOkzSQ8OdmDaWq+4gY/brOc4wdcQH7mmWRMsoKLaUdSSs
 bvTGf8tbx5Rv9XyBxHcXBENV3rFNMzjOPeuMfYYBtiiHuhFmIBpPYY7DTKFgCiVw3x
 jXkfqdcV+u9HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] drm/verisilicon: add DCUltraLite chip identity
 to HWDB
To: "Joey Lu" <a0987203069@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260625094449.708386-7-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-7-a0987203069@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:22:07 +0000
Message-Id: <20260625102208.777AD1F00A3A@smtp.kernel.org>
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
- [High] The newly added DCUltraLite chip restricts the max cursor size to =
32x32, but the driver does not configure `drm->mode_config.cursor_width` or=
 `cursor_height`. DRM core defaults to 64x64 when these fields are 0. This =
incorrectly exposes a `DRM_CAP_CURSOR_WIDTH` of 64 to userspace, causing at=
omic commits with 64x64 hardware cursors to be rejected with `-EINVAL`, bre=
aking display compositors.
--

commit a3c0d8a714c977c54ec25009535f44e9ded7c881
Author: Joey Lu <a0987203069@gmail.com>

drm/verisilicon: add DCUltraLite chip identity to HWDB

The Nuvoton MA35D1 chip contains a DCUltraLite display controller with
model number 0x0 (sic, the model name contains no number either),
revision 0x5560 and customer ID 0x305.  It has a similar register map
with DC8000, only one display output and only 32x32 cursor supported.

> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/veri=
silicon/vs_hwdb.c
> index 91524d16f7785..7d630a667a3f0 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> @@ -129,6 +129,16 @@ static struct vs_chip_identity vs_chip_identities[] =
=3D {
>  		.max_cursor_size =3D 64,
>  		.formats =3D &vs_formats_no_yuv444,
>  	},
> +	{
> +		.model =3D 0x0,		/* DCUltraLite */
> +		.revision =3D 0x5560,
> +		.customer_id =3D 0x305,
> +
> +		.generation =3D VSDC_GEN_DC8000,
> +		.display_count =3D 1,
> +		.max_cursor_size =3D 32,

[Severity: High]
Does this code expose an incorrect DRM_CAP_CURSOR_WIDTH to userspace?

Looking at vs_mode_config_init() in drivers/gpu/drm/verisilicon/vs_drm.c,
the driver does not seem to configure drm->mode_config.cursor_width or
cursor_height:

drivers/gpu/drm/verisilicon/vs_drm.c:vs_mode_config_init() {
    ...
    drm->mode_config.helper_private =3D &vs_mode_config_helper_funcs;
}

When these fields are 0, the DRM core defaults to 64x64. This means userspa=
ce
compositors might query the capability, receive 64x64, and attempt to commit
a 64x64 hardware cursor.

If this new chip restricts the max cursor size to 32x32, will the driver's
atomic check reject the 64x64 state and break display compositors?

> +		.formats =3D &vs_formats_no_yuv444,
> +	},
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625094449.7083=
86-1-a0987203069@gmail.com?part=3D6
