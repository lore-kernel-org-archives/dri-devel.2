Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993E8C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067AC10F609;
	Fri, 17 Jul 2026 21:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gZxV2A/o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593B310F609
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:02:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9EA860051;
 Fri, 17 Jul 2026 21:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278A71F00A3A;
 Fri, 17 Jul 2026 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784322148;
 bh=fBRV6Xu0oMd169LICk7wRNzW+HqAbss6lOzThgHmGkg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gZxV2A/oY7ChjLbSjB3Kzy+Txxltjz/YdHMk1G4nAjFtYl9hSXh7XvIHrdVxi9ODI
 VtFK0Je4uoxpvmsvo/x6v806DNCpnk8Tj2rT6C+no803ypKIPHd1V5yXiick5hMYJX
 W+yJtQloBFlflcozi5u+rK5rGedr9BA42z9ETVZXbtQ1tW0tNRMkGNX4IHCrVhMMBB
 o5o4QJqQVr6S0z7cwv5fPChexR7v0jWKp2Me61ysGyFLy7D5KXkSS1rPV9d1ps7uVe
 h9RQSkDOj4znDgJjNKsBR4R3uJqoYMucPxQ9uGXfSVPMk117Yo1H6jk6pkdqnAcoQr
 asl6O0snR2vFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/16] drm/msm/gem: Remove useless locking in GEM import
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-10-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-10-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:02:27 +0000
Message-Id: <20260717210228.278A71F00A3A@smtp.kernel.org>
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
- [High] Pre-existing error path vulnerability in `msm_gem_import` causes a=
 double-free of the exporter's `sgt`, NULL pointer dereference, and wild po=
inter dereferences during cleanup.
--

--- Patch [9]: [PATCH v6 09/16] drm/msm/gem: Remove useless locking in GEM =
import ---
commit 19246e79feb40c4e0066b56b3385fea83fcc3d75
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Remove useless locking in GEM import
   =20
This patch removes unnecessary locking during the GEM object import process
in msm_gem_import().

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 2cb3ab04f1250..a358fb5ca6d73 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1302,23 +1302,18 @@ struct drm_gem_object *msm_gem_import(struct drm_=
device *dev,
>  	npages =3D size / PAGE_SIZE;
> =20
>  	msm_obj =3D to_msm_bo(obj);
> -	msm_gem_lock(obj);
>  	msm_obj->sgt =3D sgt;
>  	msm_obj->pages =3D kvmalloc_objs(struct page *, npages);
>  	if (!msm_obj->pages) {
> -		msm_gem_unlock(obj);
>  		ret =3D -ENOMEM;
>  		goto fail;
>  	}
> =20
>  	ret =3D drm_prime_sg_to_page_array(sgt, msm_obj->pages, npages);
>  	if (ret) {
> -		msm_gem_unlock(obj);
>  		goto fail;

[Severity: High]
This is a pre-existing issue, but does this error path lead to a NULL
pointer dereference and a double-free?

When msm_gem_import() jumps to fail, it calls drm_gem_object_put(obj).
At this point, obj->import_attach has not yet been set (it is assigned
later by the caller drm_gem_prime_import_dev() on success).

During cleanup, msm_gem_free_object() checks drm_gem_is_imported(obj).
Since import_attach is NULL, this evaluates to false, causing the cleanup
to fall through to the native path:

msm_gem_free_object() ->
    put_pages(obj)

In put_pages(), the code incorrectly frees the exporter-owned sgt (leading
to a double-free) and then calls drm_gem_put_pages().

Finally, drm_gem_put_pages() unconditionally accesses
file_inode(obj->filp)->i_mapping. Because obj->filp is NULL for imported
objects, this causes a NULL pointer dereference.

>  	}
> =20
> -	msm_gem_unlock(obj);
> -
>  	drm_gem_lru_move_tail(&priv->lru.pinned, obj);
> =20
>  	mutex_lock(&priv->obj_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D9
