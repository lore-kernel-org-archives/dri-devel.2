Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F59CD98D2
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEB910F64C;
	Fri, 12 Jun 2026 18:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fnkQaaOP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B82B10F64C
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:40:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B23CA601E1;
 Fri, 12 Jun 2026 18:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C75F1F000E9;
 Fri, 12 Jun 2026 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781289619;
 bh=tCkn63qAoicdJlyOr3UNkQ1zU3HhCP+jCj2ha/5a4j0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fnkQaaOPhv5945nMfwpC2q3uIWEVUwJX09wUgthTHghXJfRdgR+CsCp8JjMN1sxy2
 p2J6XtTpmF6b4YYCdDRGYEKTBn+/rzUbYjxL63bmkkGJawqhcNMpOmMRM5+85rnXDW
 W1tWET3kMy1rl7/lN/B38wJTGeWrazWMt11tQpp+U06SWrs9IiAZvzS3C56twznxD9
 d3P/26TRuyfmI9e0NUk5w7GGWzHtytUKmmaAc3IG//eVR69KBt49ExB9K1jJX1SJOY
 jXjpbRr9T+m9v8RE4SHlteBLScbNLjeFwYmdF+7HrqujivXaLOQibTE1zua7UDPPIw
 bl9Hot4g8zRcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] drm/mali: use drmm_writeback_connector_init()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-wb-drop-encoder-v6-5-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-5-9f3a54f81310@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:40:18 +0000
Message-Id: <20260612184019.4C75F1F000E9@smtp.kernel.org>
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
- [Medium] Memory leak of the `formats` array on the encoder allocation err=
or path.
--

commit ca651199ad906493630752bf01737d3dca9cebbd
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
drm/mali: use drmm_writeback_connector_init()

This commit transitions the mali driver to use the managed
drmm_writeback_connector_init() function to ensure proper job queue
cleanup. It also allocates the virtual encoder using the managed
drmm_plain_encoder_alloc() helper.

> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp=
_mw.c
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c

[ ... ]

> @@ -224,11 +219,19 @@ int malidp_mw_connector_init(struct drm_device *drm)
>  	if (!formats)
>  		return -ENOMEM;
> =20
> -	ret =3D drm_writeback_connector_init(drm, &malidp->mw_connector,
> -					   &malidp_mw_connector_funcs,
> -					   &malidp_mw_encoder_helper_funcs,
> -					   formats, n_formats,
> -					   1 << drm_crtc_index(&malidp->crtc));
> +	encoder =3D drmm_plain_encoder_alloc(drm, NULL, DRM_MODE_ENCODER_VIRTUA=
L,
> +					   NULL);
> +	if (IS_ERR(encoder))
> +		return PTR_ERR(encoder);

[Severity: Medium]
The formats array is allocated earlier in this function via
get_writeback_formats(), but it does not appear to be freed on this
error path. Does this code leak the formats array if
drmm_plain_encoder_alloc() fails?

> +
> +	drm_encoder_helper_add(encoder, &malidp_mw_encoder_helper_funcs);
> +
> +	encoder->possible_crtcs =3D drm_crtc_mask(&malidp->crtc);
> +
> +	ret =3D drmm_writeback_connector_init(drm, &malidp->mw_connector,
> +					    &malidp_mw_connector_funcs,
> +					    encoder,
> +					    formats, n_formats);
>  	kfree(formats);
>  	if (ret)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-wb-drop-en=
coder-v6-0-9f3a54f81310@oss.qualcomm.com?part=3D5
