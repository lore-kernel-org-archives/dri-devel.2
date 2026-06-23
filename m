Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119DDCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DA010ECCA;
	Tue, 23 Jun 2026 21:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cGY6sfw5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5329310ECCA
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:23:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB35760008;
 Tue, 23 Jun 2026 21:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8551F000E9;
 Tue, 23 Jun 2026 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782249817;
 bh=Tvhg2kY0H+iKIFTYKV19SNvDFo+7/lgJR6skeW8oRK4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cGY6sfw5o9iAGvBe+MnXJoN5hccuOcXfPspUXE5VQqtdeJfmLo5f/BXXAaDErAD1o
 uX1R+xloIorpKk+wSaDIc+0genUwC7smf/b2V9IZzLZlFSNbj2AizKG8IOZuwViqN7
 RcBZAH4vGTS9+nQJYIOmAo2ieY0JE5I9G58ExeelC+1UfAXB0/2md9D0u1D8mfmnPb
 jQug6gf2O4FP4duMgFqZlXOm/dtJhTNboS749uCipsCkSNgixs47vgQzsooUMPxQzr
 8OJsJE2FOhVErCKnK4mPq0GCpZqxsV+ew8JOIUVEd51xHEguRZ5AXRlY9HEUT44NwH
 HC5Z1seve1wHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sun4i: Remove dependency on DRM simple helpers
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
References: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:23:36 +0000
Message-Id: <20260623212337.4E8551F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the return value=
 of `drm_encoder_init()` is ignored in `sun8i_dw_hdmi_bind()`, which leads =
to a potential kernel panic on the error path.
--

commit 2d6b8f73fd3be1e78f02ca32197b62b5da0fb174
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/sun4i: Remove dependency on DRM simple helpers

Simple KMS helper are deprecated since they only add an intermediate layer
between drivers and the atomic modesetting. This patch removes the dependen=
cy
on drm simple helpers from sun4i DRM drivers.

> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
> index 96532709c2a7e..9694ad142a7de 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
[ ... ]
> @@ -180,7 +183,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, str=
uct device *master,
>  		goto err_disable_clk_tmds;
> =20
>  	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
> -	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but the return value of
drm_encoder_init() is ignored here in sun8i_dw_hdmi_bind().

If drm_encoder_init() fails, the encoder remains uninitialized. If a
subsequent initialization step like dw_hdmi_bind() then fails, the
execution jumps to the cleanup_encoder error path:

    cleanup_encoder:
            drm_encoder_cleanup(encoder);

Could calling drm_encoder_cleanup() on an uninitialized encoder cause a
kernel panic due to dereferencing NULL pointers (such as encoder->dev or a
zero-initialized list_head)? Should the return code of drm_encoder_init()
be checked and handled here?

> =20
>  	plat_data->mode_valid =3D hdmi->quirks->mode_valid;
>  	plat_data->use_drm_infoframe =3D hdmi->quirks->use_drm_infoframe;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-sun4i_simp=
le-v1-1-fa6696df1fad@gmail.com?part=3D1
