Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D5CC9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198DC10E0D0;
	Sat, 26 Sep 2026 18:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gu4tBjkG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6433210E0D0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:40:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E4D843BB2;
 Sat, 26 Sep 2026 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27D31F000FF;
 Sat, 26 Sep 2026 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790448023;
 bh=4q+lcE3zadPvsv9s1myjSQ+aJnJZpxMZ+fJwXknaAJ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gu4tBjkGifsEMc3baUOx06WXqpWf4kiCeFzPf/7Zdrrs8mwpnxZZ4eiYOUoCF+M3B
 7NGFlhR6eCKZFcWVQbfR8XZk24OuqBrVkfewkQl5Qqj8qZzfV3+k1qIlTtKKnw1Kp1
 W4Oi3VLfGOQ1ZGhKx+/rbfMoXBKrJ06g5FcNjhZuFTPzBhW/KMAUPPsmMYtOsGbIbD
 qGbSRW8qsPZ42EbG6t8HU5M0BBLwTZDNCOToPUHyz4lqZAVEQWpAOYlRIEauLjx/db
 XJD9x2HWVtEzyEuzWizMTNVTSORGl//C8eBzTegwleoXY0JssNiyQM2EgHcunz7kWY
 X/uxuhQhpVw8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] drm/msm/gem: Stop exposing a page array
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260926183051.25754-5-robin.clark@oss.qualcomm.com>
References: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
 <20260926183051.25754-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 18:40:22 +0000
Message-Id: <20260926184022.D27D31F000FF@smtp.kernel.org>
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
- [Low] msm: dead code return ret; in msm_gem_prime_pin()
--

commit bed87911e0269b42805b7cb336b30be286c9a63a
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Stop exposing a page array

This commit converts the remaining callers of msm_gem_pin_pages_locked() an=
d=20
msm_gem_get_pages_locked() to directly return an int instead of returning a=
=20
page array. It also renames msm_gem_get_pages_locked() to=20
msm_gem_make_resident_locked() to better reflect its purpose.

> diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/ms=
m_gem_prime.c
> index beb7f22fd6948..b14cda87df4fd 100644
> --- a/drivers/gpu/drm/msm/msm_gem_prime.c
> +++ b/drivers/gpu/drm/msm/msm_gem_prime.c
> @@ -109,7 +109,6 @@ struct dma_buf *msm_gem_prime_export(struct drm_gem_o=
bject *obj, int flags)
> =20
>  int msm_gem_prime_pin(struct drm_gem_object *obj)
>  {
> -	struct page **pages;
>  	int ret =3D 0;
> =20
>  	if (drm_gem_is_imported(obj))
> @@ -118,9 +117,7 @@ int msm_gem_prime_pin(struct drm_gem_object *obj)
>  	if (to_msm_bo(obj)->flags & MSM_BO_NO_SHARE)
>  		return -EINVAL;
> =20
> -	pages =3D msm_gem_pin_pages_locked(obj);
> -	if (IS_ERR(pages))
> -		ret =3D PTR_ERR(pages);
> +	return msm_gem_pin_pages_locked(obj);
> =20
>  	return ret;

[Severity: Low]
Is this return ret statement now completely unreachable?=20

With the direct return of msm_gem_pin_pages_locked() added just above it,=20
this looks like it might be dead code left over from the refactoring. Can t=
his=20
be safely removed?

>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926183051.2575=
4-1-robin.clark@oss.qualcomm.com?part=3D4
