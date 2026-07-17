Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D9BC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B11510E514;
	Fri, 17 Jul 2026 21:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WWDYNlqu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476B510E514
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:22:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED468439BE;
 Fri, 17 Jul 2026 21:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A653C1F000E9;
 Fri, 17 Jul 2026 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784323357;
 bh=laJaH1NuH0RX4UCkI/n5R/SPfCQJcwbDvRc/5m8dfqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WWDYNlqu4PY1/6ItpV3/aNpqZfUZog5CbqDcQnrZrGCNkEfy2uy1qdBkmBxlo/I6G
 opJfIuoBO9A2xneP1SKeamPd5SPf5Z6EkUEV/uqEVwjVP7FDPism6d7a7yEsP/2Zd5
 k6slmhwnEhq73PsBbXx8+RTvrzK2h12MPt5XpBk/MjvriyHuAfqq7gQgbZ3Bq1/99R
 p3cFy4BnmIZ7H6hxgcCdWGSjxuJCJZfIaI4Gzm9vUzQnVTHi3Ojfu1vcjxY4biZttq
 3Tts9yN0ZjuMYyaTPGdNpemdTiKiw/Qf2w8DiS/mglWB6nhu5vPoXF4+q74GWsHF/n
 3gs/uy7q5BHpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/16] drm/msm/gem: Extract bookkeeping init helper
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-11-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-11-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:22:37 +0000
Message-Id: <20260717212237.A653C1F000E9@smtp.kernel.org>
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

New issues:
- [Low] Imported dma-buf objects are incorrectly placed into the unbacked L=
RU list instead of the pinned LRU list.

Pre-existing issues:
- [Critical] Failure path in `msm_gem_import` incorrectly treats the import=
ed object as a native object, erroneously freeing the exporter's `sg_table`=
 and dropping page references, leading to a NULL pointer dereference.
--

--- Patch [10]: [PATCH v6 10/16] drm/msm/gem: Extract bookkeeping init help=
er ---
commit e9867494af3de09952793735c8d5be5dc88c19a0
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Extract bookkeeping init helper

Clean up duplicated logic between import and new paths.

> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index a358fb5ca6d73..961e22d3c7292 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1233,10 +1233,21 @@ static int msm_gem_new_impl(struct drm_device *de=
v, uint32_t flags,
>  	return 0;
>  }
> =20
> +static int msm_gem_init_bookkeeping(struct drm_gem_object *obj)
> +{
> +	struct msm_drm_private *priv =3D obj->dev->dev_private;
> +
> +	drm_gem_lru_move_tail(&priv->lru.unbacked, obj);

[Severity: Low]
Does this hardcode the unbacked LRU list for all callers?  The previous
code for imported objects placed them in the pinned LRU.  Will this now
route an imported, page-backed object into the unbacked LRU?

> +
> +	mutex_lock(&priv->obj_lock);
> +	list_add_tail(&to_msm_bo(obj)->node, &priv->objects);
> +	mutex_unlock(&priv->obj_lock);
> +
> +	return drm_gem_create_mmap_offset(obj);
> +}

[ ... ]

> @@ -1314,13 +1316,7 @@ struct drm_gem_object *msm_gem_import(struct drm_d=
evice *dev,
>  		goto fail;
>  	}
> =20
> -	drm_gem_lru_move_tail(&priv->lru.pinned, obj);
> -
> -	mutex_lock(&priv->obj_lock);
> -	list_add_tail(&msm_obj->node, &priv->objects);
> -	mutex_unlock(&priv->obj_lock);
> -
> -	ret =3D drm_gem_create_mmap_offset(obj);
> +	ret =3D msm_gem_init_bookkeeping(obj);
>  	if (ret)
>  		goto fail;

[Severity: Critical]
This is a pre-existing issue, but can this failure path lead to a NULL
pointer dereference and double-free?

If msm_gem_init_bookkeeping() fails (e.g. from -ENOSPC) and we take this
goto fail path, drm_gem_object_put(obj) will be called.

Because import_attach is still NULL at this point, msm_gem_free_object()
will see drm_gem_is_imported(obj) as false and treat it as a native
object:

drivers/gpu/drm/msm/msm_gem.c:msm_gem_free_object() {
    if (drm_gem_is_imported(obj)) {
    ...
    } else {
        msm_gem_vunmap(obj);
        put_pages(obj);
    }
}

This would free the exporter's sgt using sg_free_table() and kfree().

It would also call drm_gem_put_pages() which unconditionally dereferences
obj->filp:

drivers/gpu/drm/drm_gem.c:drm_gem_put_pages() {
    mapping =3D file_inode(obj->filp)->i_mapping;
    ...
}

Since this object was initialized with drm_gem_private_object_init(),
obj->filp is NULL, causing a panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D10
