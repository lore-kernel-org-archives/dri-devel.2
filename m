Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346A5C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D6C10E144;
	Thu, 30 Jul 2026 12:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ao9yLGhr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187A610E144
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:34:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22CF9600B0;
 Thu, 30 Jul 2026 12:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58451F000E9;
 Thu, 30 Jul 2026 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785414849;
 bh=RcVlh16Xb70ffb0A4zbhp389azlKrQ/xchXXFJbAMbA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ao9yLGhrXT4wG+uu68ataCtDhJc1VnvPVj7mDu8aYJuKu3yde46jh8hdKxAnirIk0
 EtOTPU75wsHWHtlOqhoiTnaONHLs4npPkKeA4+CYrOkM27LXUNjdPfntdhxMlw+BBr
 KNWeoYvujJz46+4skwMplvcrosj8qev8lvXl9bQdjH7bsO3VgaY2EeO5swMuEwHLJV
 xSEtFS0emo2hLG9HIlxFI/p6pS3t5Xgp9YYEORMhg3b9QnI6XDPpQ641zEvDKga+Ns
 FWKRGdMNfm7bmdigAD3MM9dvitOCGez4bFbmz2QU2/rf0NX99mvklfTCzfuKK06Z9O
 K7U0rOZp3GmAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drivers: drm: remove drm_simple_encoder_init then
 inline with drm_encoder_init
To: junsungpark774@gmail.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730084908.109270-1-junsungpark774@gmail.com>
References: <20260730084908.109270-1-junsungpark774@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:34:09 +0000
Message-Id: <20260730123409.A58451F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The return value of drm_connector_init() is ignored, leading to po=
tential use of a partially initialized connector object on failure.
--

--- Patch [1]: [PATCH] drivers: drm: remove drm_simple_encoder_init then in=
line with drm_encoder_init ---
commit fb41dbd1014b2770b1e9b17f944e26382c1aa83c
Author: Park Junsung <junsungpark774@gmail.com>

drivers: drm: remove drm_simple_encoder_init then inline with drm_encoder_i=
nit

This commit removes the unnecessary intermediate layer drm_simple_encoder_i=
nit
and inlines it directly into drm_encoder_init. It also introduces a static
drm_encoder_funcs struct to handle encoder cleanup.

> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
> index a026bd35ef485..52d9bb46ea959 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
[ ... ]
> @@ -1169,10 +1173,11 @@ static int qdev_output_init(struct drm_device *de=
v, int num_output)
>  	drm_connector_init(dev, &qxl_output->base,
>  			   &qxl_connector_funcs, DRM_MODE_CONNECTOR_VIRTUAL);
> =20

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the return value of
drm_connector_init() here in qdev_output_init()?=20

If drm_connector_init() fails, for example due to an IDA allocation failure
under memory pressure, and the subsequent call to drm_encoder_init() succee=
ds,
could this result in using a partially initialized connector object? It see=
ms
this might lead to undefined behavior or a kernel panic when the connector =
is
later accessed by the DRM core.

> -	ret =3D drm_simple_encoder_init(dev, &qxl_output->enc,
> -				      DRM_MODE_ENCODER_VIRTUAL);
> +	ret =3D drm_encoder_init(dev, &qxl_output->enc,
> +			       &drm_encoder_funcs_cleanup,
> +			       DRM_MODE_ENCODER_VIRTUAL, NULL);
>  	if (ret) {
> -		drm_err(dev, "drm_simple_encoder_init() failed, error %d\n",
> +		drm_err(dev, "drm_encoder_init() failed, error %d\n",
>  			ret);
>  		goto err_drm_connector_cleanup;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730084908.1092=
70-1-junsungpark774@gmail.com?part=3D1
