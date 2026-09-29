Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E918CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F9F10F09F;
	Tue, 29 Sep 2026 21:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UIYvOgnz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7EA510F09F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 21:16:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5667C43849;
 Tue, 29 Sep 2026 21:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E5E1F000FF;
 Tue, 29 Sep 2026 21:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790716619;
 bh=wcZOJAZ0xqC2tvbInKGmFgTPy0j/vUktaxMXWJ6TQbY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UIYvOgnzf7GHRZUq5eYwqsHEVMFrvDBGANkgrSBCUH8wWdTTDekQs/gEH63gvMhEs
 pNQWw5n2p175qpyGQQpRG/E5jQEbZq+m4xBasiSmXNqR4m2ouPZRYxq/fW8FqKG5pq
 LGJVShRelGbyVm9SA7JrgTp9SSsiTnfRFgiIUkdD+u4tt0WNRnwXAX5SKZjuoz2/PS
 ldzYKE5du7uFemlK/jmlQYAd3RgVeabJwjMMelqFXGdieOq/jmqBQBftTedhm1nIMa
 S8yaFcMvUidJbLfzdCvoy15eNsjZLuVQaM3J+/idYB6Ph9Zmw/41tPjKoA8z4S0Igi
 HuxB+e3erXBJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: release imported dma-buf when the BO is freed
To: "Adam Lewis" <adam.j.lewis@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929205928.230301-1-adam.j.lewis@gmail.com>
References: <20260929205928.230301-1-adam.j.lewis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 21:16:58 +0000
Message-Id: <20260929211659.18E5E1F000FF@smtp.kernel.org>
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
- [High] drm/vmwgfx: null pointer dereference and double-free in DMA unmap =
on prime import teardown
--

commit 5e0534afee105a8ad6c4fdcc95d44acdb11a1c6c
Author: Adam Lewis <adam.j.lewis@gmail.com>

drm/vmwgfx: release imported dma-buf when the BO is freed

vmw_prime_import_sg_table() creates a BO for a foreign dma-buf through
drm_gem_prime_import_dev(), which attaches to the dma-buf, maps the
attachment and takes a reference on it.  vmw_bo_free() never undoes
this, so each foreign import leaks the attachment, its sg table and the
dma-buf reference.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index 9c7a73c0b0dc3..f226b32312387 100644
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
Does this trigger a null pointer dereference and double-free during DMA unm=
ap?

For imported dma-bufs, ttm_bo_release() first calls
ttm_bo_cleanup_memtype_use(), which calls vmw_ttm_unmap_dma():

drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c:vmw_ttm_unmap_dma() {
    ...
	case vmw_dma_map_bind:
	case vmw_dma_map_populate:
		vmw_ttm_unmap_from_dma(vmw_tt);
		sg_free_table(vmw_tt->vsgt.sgt);
		vmw_tt->vsgt.sgt =3D NULL;
		break;
    ...
}

This frees the exporter's sg_table arrays using sg_free_table(), setting
sgt->sgl to NULL but leaving sgt->nents intact.

Later, vmw_bo_free() calls drm_prime_gem_destroy(), prompting the exporter
to call dma_unmap_sgtable(). The unmap function passes sgt->sgl (which is n=
ow
NULL) to dma_unmap_sg_attrs(), resulting in a guaranteed null pointer
dereference when iterating over the scatterlist.

>  	drm_gem_object_release(&vbo->tbo.base);
>  	WARN_ON(vbo->dirty);
>  	kfree(vbo);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929205928.2303=
01-1-adam.j.lewis@gmail.com?part=3D1
