Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C6606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwhuTHHB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A50110F180;
	Mon, 26 Oct 2026 21:43:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0816610F180
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:42:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D7CC405A7;
 Mon, 26 Oct 2026 21:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAA61F01825;
 Mon, 26 Oct 2026 21:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793050974;
 bh=Sk7a7NVwevrwEC2GKh9cmNIbt/vu4oy1y9V2Si3eK2M=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=nwhuTHHBTZNMdJsx8MsTdTJIYYw3BVGsakRyGh0HX0tZWBaE6GjXjU9F1X8W2t7ew
 wJtT35htx04UN+Q6njmKpCdUPQXg7BJPfnjPxxP4aevXrJZFmuk+gydJGLYadil2Of
 5AJcijaxeKNjhMNCFY85UBsqiLIbzURid/cqW72qIGa6dSctnNo0WDcIldwahOePJ2
 f0fR+g8f8yigiDfEqu+0Fty0b+fC8ra5rF3Nq4kk2wYTQxHbzhVR+4vnjZjc4s2M2O
 FqsIYQHG4PQIMSuyeuOejHFiK8DjALXLL9QeMhdVYxD2padHaVz/Ax2TJm4vTvh+l8
 4IWv1WQJylStA==
Message-ID: <sashiko-outbox-185763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/gem: Add some cleanup.h
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261026213701.22126-1-robin.clark@oss.qualcomm.com>
References: <20261026213701.22126-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:42:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm: uninitialized return value in msm_ioctl_gem_info_get_meta=
data()
--

commit 26d3997a404e96c83bc421df7eb395c717c9751f
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Add some cleanup.h

This commit converts msm_gem_lock() and related locking helpers to use
scope-based cleanup from cleanup.h, while also fixing a lock leak in
msm_ioctl_gem_info_set_metadata().

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 5e8f3ce26b32c..42381db0c4686 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c

[ ... ]

> @@ -607,21 +600,14 @@ static int msm_ioctl_gem_info_get_metadata(struct d=
rm_gem_object *obj,
>  		return 0;
>  	}
> =20
> -	ret =3D msm_gem_lock_interruptible(obj);
> -	if (ret)
> -		return ret;
> -
> -	/* Avoid copy_to_user() under gem obj lock: */
> -	len =3D msm_obj->metadata_size;
> -	buf =3D kmemdup(msm_obj->metadata, len, GFP_KERNEL);
> -
> -	if (!buf) {
> -		msm_gem_unlock(obj);
> -		return -ENOMEM;
> +	scoped_cond_guard (gem_lock_intr, return -EINTR, obj) {
> +		/* Avoid copy_to_user() under gem obj lock by making a copy: */
> +		len =3D msm_obj->metadata_size;
> +		buf =3D kmemdup(msm_obj->metadata, len, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
>  	}
> =20
> -	msm_gem_unlock(obj);
> -
>  	if (*metadata_size < len) {
>  		ret =3D -ETOOSMALL;
>  	} else if (copy_to_user(metadata, buf, len)) {

[Severity: High]
Does msm_ioctl_gem_info_get_metadata() return an uninitialized ret on the
success path?

Previously, ret was initialized to 0 by:

    ret =3D msm_gem_lock_interruptible(obj);

With that replaced by scoped_cond_guard, when *metadata_size >=3D len and
copy_to_user() succeeds, execution takes the final else branch without
assigning ret:

drivers/gpu/drm/msm/msm_drv.c:msm_ioctl_gem_info_get_metadata() {
    ...
	int ret, len;
    ...
	if (*metadata_size < len) {
		ret =3D -ETOOSMALL;
	} else if (copy_to_user(metadata, buf, len)) {
		ret =3D -EFAULT;
	} else {
		*metadata_size =3D len;
	}

	kfree(buf);

	return ret;
}

Should ret be initialized to 0 (or set to 0 in the else branch)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026213701.2212=
6-1-robin.clark@oss.qualcomm.com?part=3D1
