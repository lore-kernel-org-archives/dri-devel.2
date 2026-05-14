Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5998CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE2A10F2EC;
	Thu, 14 May 2026 18:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F0YCM/zL";
	dkim-atps=neutral
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA67D10F2EC
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:36:09 +0000 (UTC)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-65dd9b25829so4819879d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778783769; cv=none;
 d=google.com; s=arc-20240605;
 b=a/77yhvPKFNLhI7YAJpXV2OKVmNXoa+gYe1p5zUqgCg+r2EzlamCa9OjOAtPPBLh67
 uj38Otx7qlhViWYQ/z+2toQLT2jX1rwt90+Qm1bN/gehEgT+wJKwbm3C4dhNI0s3Zg6j
 xr81JGKOySniGXGV8PmdwECE42M0BBWJWNuwSM+rKGem30RAmRZTrrGInfMaKOPrpuM2
 zHQHs+nNvMYqygdGDfp/86SQofJaumhzJYSYujRJYkSKor5xBKKYv9sljlzYXdgUIiYX
 OAk/tSR/UTUXjY9ElPNsNez/QR4bufRIb/En7GHdxrow28nUlNN33ivSe6RBAzGlfjRm
 /+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gr66I4EbYeT/UuRyaffQxl03WvTdMurTInphDstZDZs=;
 fh=RcKkr97dzEeYVW41JhRODkuHT3Sq5IiwuUQ/qFEaapw=;
 b=D37Gp+nQs5C9+VUG8J7FjtAdTx9O5UsnAAllTd6D0135D0Nb8hVZCbHVGfW7zA5v1h
 +8jr3T5Pkyi0G7iqu7rRtGYyuEi+05wD3ByLzWnghGd7jUrDiKPomJLHpVeKcIFcDVKK
 qblXZxb5TjdvByG1eHxx5FBe6Coza6SGn9O/WGFR2sf918rMRvhl+xP27g7x7NIcYrfC
 HC7iKrUPVhLhOc2WeRSb8vpr/djMyS8UaLWMa68AcFY6L2hbHj0OdKuC8STXAVn6vk3g
 TRwfdhI0HNpM9Ca5KKzMlpZI3syBNezyCSqL+trdQPtauZB3J0U4VjBMuni52D4AnbuS
 mo/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778783769; x=1779388569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gr66I4EbYeT/UuRyaffQxl03WvTdMurTInphDstZDZs=;
 b=F0YCM/zLn0UuA9UrON7nuMNKeK0Pi1vCq3j4dtyZ6qqJqSCCILaItivbCRO+EDmW/l
 UeGWxW9wx5lkoXwzrx/LcIgCZ2FzWocdUTdMuoTtR7kugVP2aDJv81V1DEV2O0U52T+g
 FzJGDlE4/TPL3FUCopzNA9qjKWmf1v3hjixV6hbzNy3d7pKogCIuSpKn8ZNAqoXMcvj3
 eB25Pv3efP2Khzyp1Prd+MMBFchLdqS+vMIUuAn7W1xTGXgaG2YHbuIVWJm5mu+cIhFm
 isKszWNsvGQFOQxEP4ON2Af3C0na+Ieomz2XjpLcdLU1qHT0DIhvUFIW25ZoWmvEuylJ
 XPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778783769; x=1779388569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gr66I4EbYeT/UuRyaffQxl03WvTdMurTInphDstZDZs=;
 b=EOyrVCObociiBEmmFV6/zZalsqdhi2Z7z4HIhtrUcBZQpQn1PEDP/MyZvO8a383m5D
 HUlc/rKfOfHeNoFt5+98pNdkHzY2oa+6ilSGgIkr3Bwgerlb4SLCKmyeB7QvjQ+OLrQZ
 zSQ/6heCzbYOa8S8alKw2lDEvSNHwkSwFXuqhkarodtagKzbqgd/zqg7j+eFdwODRpiY
 l+KABU83k9hYe0rNzfCEvzokX/ZIznKh/mmeWQLMqBSHv8emf7EksrYfi+pgirOayIyb
 L8R1D0lGRUpGNeC4etddX2oybxTb5TCAPLMYXirlvYmtj65GMEhesKYBLzBBHiNXdHIJ
 QsVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qmOdoU7bnLQbTWOqxgriUMT35Tu3DCzXfS9as36WnwYbwUd9imTGaOjNHYbmrVv1MIzn044xY86U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+yL3TsuQzraoXTXAYQkfXQg1oWw+Se8RELxiVmp9AvyUjg3+T
 mY1nqESma/SO4aDbk/I1+SsdvzNKYpZFsLqEm/IolSoPB8efUDu23MDaNzouLJzDGyOukXuOoSI
 PlVN+Rg/p020ENrVDwZZF2rpVyNx6/o4=
X-Gm-Gg: Acq92OEVM7yOeyC6bvXaXy8GjG/sdQNKWUuJc8ju5+QzhW+coN8sQBN5exdv/6RF27g
 zUZqN0q6Qndb38+YTlP/9gbbdq7xLpNlXY4Ub8dyF8ioIBP5KFhIVxZtCfrJC2m1LS/pOgcJ9k7
 2TWS/le71ibmvqgJWpoT2PtFVIXFW1lR1B5RusN4l5NFUCzXd0CWZIIaEsSKjFZbGhNXmjJmpxk
 nGM6gTBxaAMAA/I7SIuKWJg/vbH+b8PI4fFutPlOLdgwU7eZL03cbXgaSOkpj6ljeTLfY2NHm1Y
 aXppKe6BxnFOaBkOsJrX213EAQdGEL/yIUXTQ4DVxT8mLSRPm3LyhBm35mCJiMg5R/pXdLv32A=
 =
X-Received: by 2002:a05:690c:c4e3:b0:7b7:de6:3354 with SMTP id
 00721157ae682-7c95c200649mr5551647b3.37.1778783768824; Thu, 14 May 2026
 11:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-4-f2d8c15a97ce@collabora.com>
In-Reply-To: <20260513-panthor-guard-refactor-v1-4-f2d8c15a97ce@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 14 May 2026 11:35:57 -0700
X-Gm-Features: AVHnY4J4cD0AEiTpmvsUklLKRJtAwfvkQDtSEGOv6mvu5PgrUOl4KINCC3wbUDk
Message-ID: <CAPaKu7RBuff70qMFdr4uq-tAzxqG5SGiRfwyc+0Wx8KDrk_D7g@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/panthor: Use guards for resv locking
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, May 13, 2026 at 10:09=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Now that we have guards for resv locks, we can use them to simplify the
> core. The only manual lock/unlock remaining are the ones in
> panthor_gem_try_evict_no_resv_wait(), because the lock/unlock are
> in different for_each() loop scopes.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 77 ++++++++++++-----------------=
------
>  drivers/gpu/drm/panthor/panthor_mmu.c | 16 ++++----
>  2 files changed, 32 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pant=
hor/panthor_gem.c
> index a6fddc380e7d..94facdc8cfe1 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -339,13 +339,9 @@ panthor_gem_dev_map_get_sgt_locked(struct panthor_ge=
m_object *bo)
>  struct sg_table *
>  panthor_gem_get_dev_sgt(struct panthor_gem_object *bo)
>  {
> -       struct sg_table *sgt;
> +       guard(dma_resv)(bo->base.resv);
>
> -       dma_resv_lock(bo->base.resv, NULL);
> -       sgt =3D panthor_gem_dev_map_get_sgt_locked(bo);
> -       dma_resv_unlock(bo->base.resv);
> -
> -       return sgt;
> +       return panthor_gem_dev_map_get_sgt_locked(bo);
>  }
>
>  static void
> @@ -497,7 +493,7 @@ panthor_gem_prime_begin_cpu_access(struct dma_buf *dm=
a_buf,
>         struct panthor_gem_object *bo =3D to_panthor_bo(obj);
>         struct dma_buf_attachment *attach;
>
> -       dma_resv_lock(obj->resv, NULL);
> +       guard(dma_resv)(obj->resv);
>         if (bo->dmap.sgt)
>                 dma_sync_sgtable_for_cpu(drm_dev_dma_dev(dev), bo->dmap.s=
gt, dir);
>
> @@ -510,7 +506,6 @@ panthor_gem_prime_begin_cpu_access(struct dma_buf *dm=
a_buf,
>                 if (sgt)
>                         dma_sync_sgtable_for_cpu(attach->dev, sgt, dir);
>         }
> -       dma_resv_unlock(obj->resv);
>
>         return 0;
>  }
> @@ -524,7 +519,7 @@ panthor_gem_prime_end_cpu_access(struct dma_buf *dma_=
buf,
>         struct panthor_gem_object *bo =3D to_panthor_bo(obj);
>         struct dma_buf_attachment *attach;
>
> -       dma_resv_lock(obj->resv, NULL);
> +       guard(dma_resv)(obj->resv);
>         list_for_each_entry(attach, &dma_buf->attachments, node) {
>                 struct sg_table *sgt =3D attach->priv;
>
> @@ -538,7 +533,6 @@ panthor_gem_prime_end_cpu_access(struct dma_buf *dma_=
buf,
>         if (bo->dmap.sgt)
>                 dma_sync_sgtable_for_device(drm_dev_dma_dev(dev), bo->dma=
p.sgt, dir);
>
> -       dma_resv_unlock(obj->resv);
>         return 0;
>  }
>
> @@ -625,19 +619,15 @@ static void panthor_gem_unpin_locked(struct drm_gem=
_object *obj)
>
>  int panthor_gem_pin(struct panthor_gem_object *bo)
>  {
> -       int ret =3D 0;
> -
>         if (drm_gem_is_imported(&bo->base))
>                 return 0;
>
>         if (refcount_inc_not_zero(&bo->backing.pin_count))
>                 return 0;
>
> -       dma_resv_lock(bo->base.resv, NULL);
> -       ret =3D panthor_gem_backing_pin_locked(bo);
> -       dma_resv_unlock(bo->base.resv);
> +       guard(dma_resv)(bo->base.resv);
>
> -       return ret;
> +       return panthor_gem_backing_pin_locked(bo);
>  }
>
>  void panthor_gem_unpin(struct panthor_gem_object *bo)
> @@ -648,9 +638,8 @@ void panthor_gem_unpin(struct panthor_gem_object *bo)
>         if (refcount_dec_not_one(&bo->backing.pin_count))
>                 return;
>
> -       dma_resv_lock(bo->base.resv, NULL);
> +       guard(dma_resv)(bo->base.resv);
>         panthor_gem_backing_unpin_locked(bo);
> -       dma_resv_unlock(bo->base.resv);
>  }
>
>  int panthor_gem_swapin_locked(struct panthor_gem_object *bo)
> @@ -759,13 +748,12 @@ static int panthor_gem_mmap(struct drm_gem_object *=
obj, struct vm_area_struct *v
>                 return -EINVAL;
>
>         if (!refcount_inc_not_zero(&bo->cmap.mmap_count)) {
> -               dma_resv_lock(obj->resv, NULL);
> +               guard(dma_resv)(obj->resv);
>                 if (!refcount_inc_not_zero(&bo->cmap.mmap_count)) {
>                         refcount_set(&bo->cmap.mmap_count, 1);
>                         guard(mutex)(&bo->base.gpuva.lock);
>                         panthor_gem_update_reclaim_state_locked(bo, NULL)=
;
>                 }
> -               dma_resv_unlock(obj->resv);
>         }
>
>         vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> @@ -814,18 +802,12 @@ static vm_fault_t nonblocking_page_setup(struct vm_=
fault *vmf,
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>         struct panthor_gem_object *bo =3D to_panthor_bo(vma->vm_private_d=
ata);
> -       vm_fault_t ret;
>
> -       if (!dma_resv_trylock(bo->base.resv))
> +       ACQUIRE(dma_resv_try, resv_guard)(bo->base.resv);
> +       if (ACQUIRE_ERR(dma_resv_try, &resv_guard) || !bo->backing.pages)
>                 return VM_FAULT_RETRY;
>
> -       if (bo->backing.pages)
> -               ret =3D insert_page(vmf, order, bo->backing.pages[page_of=
fset]);
> -       else
> -               ret =3D VM_FAULT_RETRY;
> -
> -       dma_resv_unlock(bo->base.resv);
> -       return ret;
> +       return insert_page(vmf, order, bo->backing.pages[page_offset]);
>  }
>
>  static vm_fault_t blocking_page_setup(struct vm_fault *vmf, unsigned int=
 order,
> @@ -835,8 +817,8 @@ static vm_fault_t blocking_page_setup(struct vm_fault=
 *vmf, unsigned int order,
>         vm_fault_t ret;
>         int err;
>
> -       err =3D dma_resv_lock_interruptible(bo->base.resv, NULL);
> -       if (err)
> +       ACQUIRE(dma_resv_intr, resv_guard)(bo->base.resv);
> +       if (ACQUIRE_ERR(dma_resv_intr, &resv_guard))
>                 return mmap_lock_held ? VM_FAULT_NOPAGE : VM_FAULT_RETRY;
>
>         err =3D panthor_gem_backing_get_pages_locked(bo);
> @@ -857,8 +839,6 @@ static vm_fault_t blocking_page_setup(struct vm_fault=
 *vmf, unsigned int order,
>                         ret =3D VM_FAULT_RETRY;
>         }
>
> -       dma_resv_unlock(bo->base.resv);
> -
>         return ret;
>  }
>
> @@ -932,12 +912,12 @@ static void panthor_gem_vm_close(struct vm_area_str=
uct *vma)
>         if (refcount_dec_not_one(&bo->cmap.mmap_count))
>                 goto out;
>
> -       dma_resv_lock(bo->base.resv, NULL);
> -       if (refcount_dec_and_test(&bo->cmap.mmap_count)) {
> -               guard(mutex)(&bo->base.gpuva.lock);
> -               panthor_gem_update_reclaim_state_locked(bo, NULL);
> +       scoped_guard(dma_resv, bo->base.resv) {
> +               if (refcount_dec_and_test(&bo->cmap.mmap_count)) {
> +                       guard(mutex)(&bo->base.gpuva.lock);
> +                       panthor_gem_update_reclaim_state_locked(bo, NULL)=
;
> +               }
>         }
> -       dma_resv_unlock(bo->base.resv);
>
>  out:
>         drm_gem_object_put(&bo->base);
> @@ -1161,21 +1141,18 @@ panthor_gem_sync(struct drm_gem_object *obj, u32 =
type,
>         if (size =3D=3D 0)
>                 return 0;
>
> -       ret =3D dma_resv_lock_interruptible(bo->base.resv, NULL);
> +       ACQUIRE(dma_resv_intr, resv_guard)(bo->base.resv);
> +       ret =3D ACQUIRE_ERR(dma_resv_intr, &resv_guard);
>         if (ret)
>                 return ret;
>
>         /* If there's no pages, there's no point pulling those back, bail=
 out early. */
> -       if (!bo->backing.pages) {
> -               ret =3D 0;
> -               goto out_unlock;
> -       }
> +       if (!bo->backing.pages)
> +               return 0;
>
>         sgt =3D panthor_gem_dev_map_get_sgt_locked(bo);
> -       if (IS_ERR(sgt)) {
> -               ret =3D PTR_ERR(sgt);
> -               goto out_unlock;
> -       }
> +       if (IS_ERR(sgt))
> +               return PTR_ERR(sgt);
>
>         for_each_sgtable_dma_sg(sgt, sgl, count) {
>                 if (size =3D=3D 0)
> @@ -1219,11 +1196,7 @@ panthor_gem_sync(struct drm_gem_object *obj, u32 t=
ype,
>                         dma_sync_single_for_cpu(dma_dev, paddr, len, DMA_=
FROM_DEVICE);
>         }
>
> -       ret =3D 0;
> -
> -out_unlock:
> -       dma_resv_unlock(bo->base.resv);
> -       return ret;
> +       return 0;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 157eef286cb9..ab9a77e6a145 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1118,10 +1118,10 @@ static void panthor_vm_bo_free(struct drm_gpuvm_b=
o *vm_bo)
>         /* We couldn't call this when we unlinked, because the resv lock =
can't
>          * be taken in the dma signalling path, so call it now.
>          */
> -       dma_resv_lock(bo->base.resv, NULL);
> -       scoped_guard(mutex, &bo->base.gpuva.lock)
> +       scoped_guard(dma_resv, bo->base.resv) {
> +               guard(mutex)(&bo->base.gpuva.lock);
>                 panthor_gem_update_reclaim_state_locked(bo, NULL);
> -       dma_resv_unlock(bo->base.resv);
> +       }
>
>         kfree(vm_bo);
>  }
> @@ -1342,16 +1342,14 @@ static int panthor_vm_prepare_map_op_ctx(struct p=
anthor_vm_op_ctx *op_ctx,
>
>         /* Insert BO into the extobj list last, when we know nothing can =
fail. */
>         if (bo->base.resv !=3D panthor_vm_resv(vm)) {
> -               dma_resv_lock(panthor_vm_resv(vm), NULL);
> +               guard(dma_resv)(panthor_vm_resv(vm));
>                 drm_gpuvm_bo_extobj_add(op_ctx->map.vm_bo);
> -               dma_resv_unlock(panthor_vm_resv(vm));
>         }
>
>         /* And finally update the BO state. */
> -       dma_resv_lock(bo->base.resv, NULL);
> -       scoped_guard(mutex, &bo->base.gpuva.lock)
> -               panthor_gem_update_reclaim_state_locked(bo, NULL);
> -       dma_resv_unlock(bo->base.resv);
> +       guard(dma_resv)(bo->base.resv);
> +       guard(mutex)(&bo->base.gpuva.lock);
> +       panthor_gem_update_reclaim_state_locked(bo, NULL);
>
>         return 0;
>
>
> --
> 2.54.0
>
