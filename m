Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798F0C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 15:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C104D10E28D;
	Thu, 10 Sep 2026 15:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZhsR0XqL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29F510E28D
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 15:00:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B566C42B1B;
 Thu, 10 Sep 2026 15:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788AF1F000FF;
 Thu, 10 Sep 2026 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789052435;
 bh=m8yDM+RL0dQ2vS71g73yc0E6WZKkeDcZVCIxj8jlZCY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZhsR0XqL8actWyztZBKqAIzqO/hIMnIq2a9MoqTtJ5cnCM1hfyiZjQbB23nqivHql
 4akc048aTLLqcYOro10lDsIcWr8ExTVwYVo/hC8NyG1zzuOKo8dMQ2TpKJzbV+Bc9B
 ivZsMiUKWSGwE7NwG2OlofTZnFUGK/GpWU8k4LAqMJcWtcX/Fwq1SXvQ2Ev8A0iU8b
 mdG0hu+W69MNXQvmBv33Oa/8Pi+snYGe7HfdY2f8reD3S/5pqMfiG8pD6C+Fqn61MX
 mW1zxAzi6FN/xbFWWoPDXEsgFza2ruAGI2IvZlZi0cZ+hlGH25XHaJ35GihmqsMKmH
 5KyvlHuU/NmhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Release PRIME import in the BO destroy path
To: "Michal TOMA" <michaltoma@sicoop.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910142359.13716-1-michaltoma@sicoop.com>
References: <20260910142359.13716-1-michaltoma@sicoop.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 15:00:34 +0000
Message-Id: <20260910150035.788AF1F000FF@smtp.kernel.org>
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
- [High] Double free of the exporter's sg_table triggered by combining the =
newly added drm_prime_gem_destroy() with a pre-existing incorrect error pat=
h in vmw_ttm_map_dma().

Pre-existing issues:
- [High] NULL pointer dereference in drm_gem_prime_import_dev() because vmw=
_prime_import_sg_table() returns NULL instead of ERR_PTR on failure.
--

commit 9bf7a32b370ca37cb8db240835af8ec49f8b2120
Author: Michal TOMA <michaltoma@sicoop.com>

drm/vmwgfx: Release PRIME import in the BO destroy path

This commit addresses a reference leak for imported dma-buf objects by addi=
ng
a call to drm_prime_gem_destroy() in vmw_bo_free(). This ensures the sg map=
ping,
attachment, and dma-buf reference are properly released when the GEM object
is freed.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index 9c7a73c0b0dc3..56bc94edc30b7 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
[ ... ]
> @@ -69,6 +70,8 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
>  		vmw_surface_unreference(&vbo->dumb_surface);
>  	}
>  	WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
> +	if (drm_gem_is_imported(&vbo->tbo.base))
> +		drm_prime_gem_destroy(&vbo->tbo.base, vbo->tbo.sg);

[Severity: High]
Does this code cause a double free of the exporter's sg_table if mapping fa=
ils?

When an imported PRIME buffer (TTM_TT_FLAG_EXTERNAL) is mapped or bound,
vmw_ttm_map_dma() sets up the sg_table using the exporter's sg_table:

drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c:vmw_ttm_map_dma() {
    ...
    if (vmw_tt->dma_ttm.page_flags & TTM_TT_FLAG_EXTERNAL) {
        vsgt->sgt =3D vmw_tt->dma_ttm.sg;
    } else {
    ...
    }

    ret =3D vmw_ttm_map_for_dma(vmw_tt);
    if (unlikely(ret !=3D 0))
        goto out_map_fail;
    ...
out_map_fail:
    drm_warn(&dev_priv->drm, "VSG table map failed!");
    sg_free_table(vsgt->sgt);
    vsgt->sgt =3D NULL;
    ...
}

In vmw_ttm_map_dma(), vmw_ttm_map_for_dma() attempts to call dma_map_sgtabl=
e()
on an uninitialized inline &vmw_tt->sgt, which predictably fails and jumps =
to
out_map_fail. The error path (as well as vmw_ttm_unmap_dma) incorrectly cal=
ls
sg_free_table() on the exporter's sg_table.

When the buffer object is subsequently destroyed, this newly added call to
drm_prime_gem_destroy() asks the exporter to unmap its attachment, causing =
the
exporter to call sg_free_table() again on the exact same scatterlist.

[Severity: High]
This isn't a bug introduced by this patch, but a pre-existing issue was exp=
osed
by analyzing the error path: can a failure in vmw_bo_create() cause a NULL
pointer dereference?

If a local user imports a dma-buf via DRM_IOCTL_PRIME_FD_TO_HANDLE and
vmw_bo_create() fails (e.g., due to memory pressure),
vmw_prime_import_sg_table() returns NULL instead of propagating an ERR_PTR:

drivers/gpu/drm/vmwgfx/vmwgfx_gem.c:vmw_prime_import_sg_table() {
    ...
    ret =3D vmw_bo_create(dev_priv, &params, &vbo);
    if (ret !=3D 0)
        goto out_no_bo;
    ...
out_no_bo:
    dma_resv_unlock(params.resv);
    return gem;
}

The caller expects an ERR_PTR on failure. Since IS_ERR(NULL) evaluates to
false, it proceeds to unconditionally assign to obj->import_attach,
dereferencing the NULL pointer:

drivers/gpu/drm/drm_prime.c:drm_gem_prime_import_dev() {
    ...
    obj =3D dev->driver->gem_prime_import_sg_table(dev, attach, sgt);
    if (IS_ERR(obj)) {
        ret =3D PTR_ERR(obj);
        goto fail_unmap;
    }

    obj->import_attach =3D attach;
    ...
}

>  	drm_gem_object_release(&vbo->tbo.base);
>  	WARN_ON(vbo->dirty);
>  	kfree(vbo);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142359.1371=
6-1-michaltoma@sicoop.com?part=3D1
