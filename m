Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3238DC79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDAF10E08E;
	Thu, 10 Sep 2026 17:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hr/sddX/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656A910E08E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 17:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 368C4435E2;
 Thu, 10 Sep 2026 17:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C321F00899;
 Thu, 10 Sep 2026 17:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789062559;
 bh=03S1XkLvqh/YIsPKA6PZ+aKl8gmYl0vJW5L6ezr7I5s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hr/sddX/e13s65NhNActR38IBTQQ9JC4vt7wEO2d3l1jXYpSm4C/Qk8fmPyFz6wfD
 /HAvtv2G1kKsPT8rN/Xalaexe4gcqRVlv3KipBN1CU7/lBuA07lKKzOvNVJEhL8Wtp
 oRdEz70bdqhgbOK+WWaMdC+P3+g+eLLBIiHxgOhSk20eZ8nzy1YeSsjlQ+w53RaxcO
 z71IruEZf5v9/7cLHTUFENxPTGTjW1tkdjTy/T44BEhBRA1wafn+Z1Prf6qGpC/Stm
 8cqS8P89MFQfe9TD1rnvMeIsnX76QvSivIyeV4NyZssEji96z/reUDCRI67PMUfa9O
 9TBHgd49K2toA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/vmwgfx: Don't leak a GEM handle when
 referencing a surface by fd
To: "Michal TOMA" <michaltoma@sicoop.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260910165221.7558-4-michaltoma@sicoop.com>
References: <20260910165221.7558-1-michaltoma@sicoop.com>
 <20260910165221.7558-4-michaltoma@sicoop.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:49:18 +0000
Message-Id: <20260910174918.E1C321F00899@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Unsynchronized rbtree and xarray traversal in vmw_bo_surface()=
 can lead to crashes or UAF.
- [High] Kernel stack memory leak in `vmw_gb_surface_reference_internal` er=
ror path.
--

commit 6ca6707ae183fa071e8ebb217050fe9e1947a0b2
Author: Michal TOMA <michaltoma@sicoop.com>

drm/vmwgfx: Don't leak a GEM handle when referencing a surface by fd

This commit prevents a GEM handle leak by looking up a surface buffer
through its dma-buf directly instead of importing the fd into the DRM file.
It rejects buffers not exported by the device and simplifies object
reference cleanup.

Cc: stable@vger.kernel.org # v6.11+

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index bd0563741e89d..27f68fd9c22bd 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c

[ ... ]

> @@ -931,33 +934,37 @@ u32 vmw_lookup_surface_handle_for_buffer(struct vmw=
_private *vmw,
> =20
>  static int vmw_buffer_prime_to_surface_base(struct vmw_private *dev_priv,
>  					    struct drm_file *file_priv,
> -					    u32 fd, u32 *handle,
> +					    u32 fd,
>  					    struct ttm_base_object **base_p)
>  {

[ ... ]

> -	user_srf =3D vmw_lookup_user_surface_for_buffer(dev_priv, bo, *handle);
> -	if (WARN_ON(!user_srf)) {
> -		drm_warn(&dev_priv->drm,
> -			 "User surface fd %d (handle %d) is null.\n", fd, *handle);
> +	user_srf =3D vmw_lookup_user_surface_for_buffer(dev_priv,
> +						      to_vmw_bo(dma_buf->priv),
> +						      fd);

[Severity: Critical]
This is a pre-existing issue, but does this lockless lookup risk a
use-after-free or kernel crash?

When vmw_lookup_user_surface_for_buffer() is called here, it calls
vmw_bo_surface() which iterates over the detached_resources xarray and
res_tree rbtree without holding the dma_resv lock or an RCU read lock:

drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:vmw_bo_surface() {
        ...
        xa_for_each(&vbo->detached_resources, index, res) {
                if (res->func->res_type =3D=3D vmw_res_surface)
                        goto out;
        }
        ...
        for (rb_itr =3D rb_first(&vbo->res_tree); rb_itr;
             rb_itr =3D rb_next(rb_itr)) {
        ...
}

If another thread concurrently modifies these structures (for example, by
adding or removing resources), this lockless traversal could access freed
nodes. Should this lookup take the buffer object's dma_resv lock?

> +	if (!user_srf) {
> +		drm_dbg_driver(&dev_priv->drm,
> +			       "No user surface for buffer fd %d.\n", fd);
>  		ret =3D -EINVAL;
>  		goto out;
>  	}

[ ... ]

[Severity: High]
As an additional observation in this file, this is a pre-existing issue,
but does vmw_gb_surface_reference_internal() leak kernel stack memory to
userspace in its error path?

If srf->res.guest_memory_bo is NULL, the error path skips setting a
negative error code and jumps directly to out_bad_resource:

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_reference_internal()=
 {
        ...
        if (!srf->res.guest_memory_bo) {
                DRM_ERROR("Shared GB surface is missing a backup buffer.\n"=
);
                goto out_bad_resource;
        }
        ...
out_bad_resource:
        ...
        return ret;
}

Because ret is still 0 at this point, the caller
vmw_gb_surface_reference_ioctl() assumes success and copies the
uninitialized stack variable rep_ext into the user-visible rep pointer:

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_reference_ioctl() {
        struct drm_vmw_gb_surface_ref_ext_rep rep_ext;
        int ret;

        ret =3D vmw_gb_surface_reference_internal(dev, req, &rep_ext, file_=
priv);

        if (unlikely(ret !=3D 0))
                return ret;

        rep->creq =3D rep_ext.creq.base;
        rep->crep =3D rep_ext.crep;
}

Could this be fixed by explicitly setting ret =3D -EINVAL before jumping to
out_bad_resource in vmw_gb_surface_reference_internal()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910165221.7558=
-1-michaltoma@sicoop.com?part=3D3
