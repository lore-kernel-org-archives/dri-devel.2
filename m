Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642B606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ImTBEUX9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4528310E316;
	Sat, 31 Oct 2026 16:44:55 +0000 (UTC)
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FB510E330
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:44:49 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-67a6cc9acbeso805954d50.3
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 09:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793465088; cv=none;
 d=google.com; s=arc-20260327;
 b=kIdOziKyHByFxF3MbK4p5ROCF2shkPwyySQHfUpm53/NYB0Gp5HW9/qWq19NYgtZtc
 E7ifi3RfhTxIDFOgMksM05rCBWj+KxGLVpZT5cpzSCVxOxGoqlnAJf0osJYMY7sFPSva
 FdhC7PikBB5jtyQlXXrlxI33Wwi2p/JhPCWfrWQntr/UcUx3mcjiNuVXZRm5L9wYB0aj
 E0hB5Q6vdgPLQof17Nf3+8Uoj1O98j7JSbWDS6xapyMFILwQ6KNYKAzu8o6HGg9A9ROw
 x60W3G1N1Gm+x1q1tk9gYa/l7c3sQxvRmq1MWAur0Z+cJhyrUu/So+WXVMqM71/Z8/Ca
 Akpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FmRm6q9MEV9UKITnMhmLtqnLP8UqkbAMA4l+VFtEM/w=;
 fh=8U2jhOgg4zNkXP0qlpnkVI5QNi3dcsL+R00XRzpNLIY=;
 b=r1Turof0BvC48IasxUcZkVn2b0a92eh/USOoKQQ8MwEQzEyU23zWLpDzV/BaiOHvf5
 kJdUB+vnKyazorXp7a4pUiM9uJAlnkDLw5U04J9OQGYmmvL1+sw33ADMJQksfz1aOXaG
 FytkzA4rKXaCAyklZ7LnUNwV6WKnYmQYiHNmmr+2OSmxNRPJ/cCKdeDqtFae6XE3leJl
 1PKQEi4cXd3j4IPi60WQkIZxdcWF2tbjlPuCUA6odC2JnCewd6u1wVANZHlbm8rl/cC3
 xLqIalr4WPt8617pS0J/IZWzRACTgr+GMb/GQmZPpHr27JuR7NWzyQDBHADmuOF3LGBU
 K4gg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793465088; x=1794069888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FmRm6q9MEV9UKITnMhmLtqnLP8UqkbAMA4l+VFtEM/w=;
 b=ImTBEUX9TovkyOKjkFQ+np1rlW1KsHiOLcD03MNvbe89IrrrD7VOXtLOVKVehuTp/h
 yHZEbADsnl10VRYrBcbcl7rEdp3c6Xgt2CM7VziYFTRuWL4C/3BH/ybE8B9d496ogaut
 n/WNSNxYjqKmLIV3rr3zAuSXGEQ22BH2DHV/qHk9+ObAwQT/xBj/XrZaCfMCdj1JGXTZ
 uXDBOheWRDBuu7yOz5JKo+xXXJt3mJ1k9ERn3Re9Gi6GJLJ0O0nUiCsi0KItor0VVd4J
 D3JaVSDcFrXLwM/k2oLNGs9ICTV4n3/lyoaCXGiwi1OlX9acoeTHaxCGZJGRckMm6H5w
 gp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793465088; x=1794069888;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FmRm6q9MEV9UKITnMhmLtqnLP8UqkbAMA4l+VFtEM/w=;
 b=khkLCHPqaZvnzMCVa0uRfPnKzAHm1md5h2Eo5LPfeK5b4ZcolhKNPGv/yBzc1fu2AU
 MrmsfQUiariVsjzfB0nrV6V6AvEnnSK1l1k3OdCm/XhPu683QdX7vizXrUS0kZ8yH/Us
 x8+YjDLUB9nCdh8pccf4dU9N2dYM0hY4YYjB9WmWDZj/yOj8yg3mtZ5tR3PZQrgygZ+7
 OfE05mCPS5oZJ1evO061dm7EFToaQR9stBAgHm4Kv8IkGZCmP9GwXgaXEhczKDHMvVj0
 I5WgjtA9TX3KfQOfJb+pJNraWm+gaMIyVWedp5pcSKP0duQsg1QeQ6aHIQNvscqWBG30
 4taA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOT801ljEG5LY7icCbNwixHjRtCdk1zzZovEHo7PT7vIQf5JiGrDmQlK+KW7KB5q2sdO6de35GBlE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ksF7One/xSJ1Ix23prDYXzaWzND4vz27ENWyYI4hrHUmYllgb
 5hYY5habRLvZKCV8W+olEPA6NZTLFJbFoTCcRQFJ6zBMvi2kyX2fD7OuO3qx96jsgxl7P3BsGVd
 R76KJDt75Y9nsulJwLF+2yVciVUYYPYE=
X-Gm-Gg: AYBFou11fFdbEDxY0SmeDcl/b4itPRoHAI7YBSe4sAjQ0vXCPMwPhuGYNSgrO3VkIhX
 cDZGZsVqVOv+50qCyvGVHcChUN8ak5b9pailNBs+RQND6GVLCpmB3ryJ+y/iKiRwHNr19VD0VOB
 eIYkrLBleyrD8cLy+Q8a0lyBhLYX7y1wEsasjJf64TrL/WJfXnqyeIkdakMtWkXGzlJoPDgKBii
 URCCZuYPpilcpV2NF/KIbx+5fuN/sbEmLfyIu98vHki96qKXkJ864gKQFoJWO9pUKna4CWDJp7X
 xPMiEoW3f1x5iUcgZ1nNLvJPIj0M+hZlwe1bu+Ng1nFGHTi0Wfkj/wgFP0BzNxIc3tkOlW+g5cw
 6xAmldN+C9/poJiRNxCj3/tGKwiNoYCoBk7EnWZQ=
X-Received: by 2002:a05:690e:440f:b0:676:8974:9788 with SMTP id
 956f58d0204a3-67ba50fc586mr2202215d50.96.1793465088303; Sat, 31 Oct 2026
 09:44:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
 <20261011-pvr-gpuvm-immediate-v2-1-744ddc6644c3@gmail.com>
In-Reply-To: <20261011-pvr-gpuvm-immediate-v2-1-744ddc6644c3@gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 1 Nov 2026 01:44:37 +0900
X-Gm-Features: AclHuK9TWlU8P9Ml10d2T0OXF04K7g-lp1-r1t3qWFHqZqMDpRJwUYAW2fycKsA
Message-ID: <CAKbEznvSrJSN7_x22aWVzwM4otXMfgadurNp9arLcSzaQ9dsJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/imagination: Switch the GPUVM to immediate mode
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>, 
 Frank Binns <frank.binns@imgtec.com>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The infinite loop issue in pvr_vm_unmap_all() reported by Sashiko is not
introduced by this patch; it has existed since commit a5c4c3ba95a5
("drm/imagination: Hold drm_gem_gpuva lock for unmap").

Fixed in a separate patch:
https://lore.kernel.org/r/20261015-pvr-unmap-all-loop-v1-1-54c676d41269@gma=
il.com/

On Sun, Oct 11, 2026 at 6:45=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> wr=
ote:
>
> Use DRM_GPUVM_IMMEDIATE_MODE so that each GEM's GPUVA list is protected
> by its gpuva.lock instead of its dma_resv. This prepares for
> asynchronous VM_BIND, whose run_job() will update the GPUVA lists
> before signalling its fence. That section imposes three rules:
>
> 1. No dma_resv: another thread may hold it while waiting for the job's
>    fence, directly or through a dependency.
>    -> Protect the lists with gpuva.lock, and take it around
>       drm_gpuva_link().
>
> 2. No allocation under a lock run_job() takes: reclaim may wait for a
>    fence that depends on the job.
>    -> Allocate the vm_bo before taking gpuva.lock:
>       drm_gpuvm_bo_obtain_locked() becomes drm_gpuvm_bo_create() +
>       drm_gpuvm_bo_obtain_prealloc().
>
> 3. No freeing of GEM objects: that takes their dma_resv, and under
>    gpuva.lock would free the held lock too.
>    -> Defer it: drm_gpuva_unlink() and drm_gpuvm_bo_put() become
>       drm_gpuva_unlink_defer() and drm_gpuvm_bo_put_deferred(), and
>       drm_gpuvm_bo_deferred_cleanup() frees once the locks are dropped.
>
> This also fixes an unlocked GPUVA list update: when a map fails,
> pvr_vm_bind_op_fini() drops the last vm_bo reference without holding
> the object's dma_resv.
>
> Failing VM_MAP allocations with fail-nth shows
> it on a lockdep kernel (real allocation failures under memory pressure
> take the same path):
>
>   WARNING: drivers/gpu/drm/drm_gpuvm.c:1661 at drm_gpuvm_bo_put+0x2ec/0x6=
60 [drm_gpuvm]
>   Call trace:
>    drm_gpuvm_bo_put
>    pvr_vm_bind_op_fini
>    pvr_vm_map
>    pvr_ioctl_vm_map
>
> Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  drivers/gpu/drm/imagination/pvr_vm.c | 39 +++++++++++++++++++++++++++---=
------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index cbdd15ed74f..807a01aab1d 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> @@ -214,7 +214,7 @@ static int pvr_vm_bind_op_exec(struct pvr_vm_bind_op =
*bind_op)
>
>  static void pvr_vm_bind_op_fini(struct pvr_vm_bind_op *bind_op)
>  {
> -       drm_gpuvm_bo_put(bind_op->gpuvm_bo);
> +       drm_gpuvm_bo_put_deferred(bind_op->gpuvm_bo);
>
>         kfree(bind_op->new_va);
>         kfree(bind_op->prev_va);
> @@ -255,11 +255,11 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind=
_op,
>
>         bind_op->type =3D PVR_VM_BIND_TYPE_MAP;
>
> -       dma_resv_lock(obj->resv, NULL);
> -       bind_op->gpuvm_bo =3D drm_gpuvm_bo_obtain_locked(&vm_ctx->gpuvm_m=
gr, obj);
> -       dma_resv_unlock(obj->resv);
> -       if (IS_ERR(bind_op->gpuvm_bo))
> -               return PTR_ERR(bind_op->gpuvm_bo);
> +       bind_op->gpuvm_bo =3D drm_gpuvm_bo_create(&vm_ctx->gpuvm_mgr, obj=
);
> +       if (!bind_op->gpuvm_bo)
> +               return -ENOMEM;
> +
> +       bind_op->gpuvm_bo =3D drm_gpuvm_bo_obtain_prealloc(bind_op->gpuvm=
_bo);
>
>         bind_op->new_va =3D kzalloc_obj(*bind_op->new_va);
>         bind_op->prev_va =3D kzalloc_obj(*bind_op->prev_va);
> @@ -293,6 +293,8 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_o=
p,
>
>  err_bind_op_fini:
>         pvr_vm_bind_op_fini(bind_op);
> +       /* Drain what fini() deferred. */
> +       drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
>
>         return err;
>  }
> @@ -366,7 +368,11 @@ pvr_vm_gpuva_map(struct drm_gpuva_op *op, void *op_c=
tx)
>                 return err;
>
>         drm_gpuva_map(&ctx->vm_ctx->gpuvm_mgr, &ctx->new_va->base, &op->m=
ap);
> +
> +       mutex_lock(&op->map.gem.obj->gpuva.lock);
>         drm_gpuva_link(&ctx->new_va->base, ctx->gpuvm_bo);
> +       mutex_unlock(&op->map.gem.obj->gpuva.lock);
> +
>         ctx->new_va =3D NULL;
>
>         return 0;
> @@ -396,7 +402,7 @@ pvr_vm_gpuva_unmap(struct drm_gpuva_op *op, void *op_=
ctx)
>                 return err;
>
>         drm_gpuva_unmap(&op->unmap);
> -       drm_gpuva_unlink(op->unmap.va);
> +       drm_gpuva_unlink_defer(op->unmap.va);
>         kfree(to_pvr_vm_gpuva(op->unmap.va));
>
>         return 0;
> @@ -418,6 +424,7 @@ pvr_vm_gpuva_unmap(struct drm_gpuva_op *op, void *op_=
ctx)
>  static int
>  pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
>  {
> +       struct drm_gem_object *obj =3D op->remap.unmap->va->gem.obj;
>         /* The split parts belong to the object of the mapping being spli=
t. */
>         struct drm_gpuvm_bo *vm_bo =3D op->remap.unmap->va->vm_bo;
>         struct pvr_vm_bind_op *ctx =3D op_ctx;
> @@ -435,16 +442,20 @@ pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *o=
p_ctx)
>         drm_gpuva_remap(&ctx->prev_va->base, &ctx->next_va->base, &op->re=
map);
>
>         if (op->remap.prev) {
> +               mutex_lock(&obj->gpuva.lock);
>                 drm_gpuva_link(&ctx->prev_va->base, vm_bo);
> +               mutex_unlock(&obj->gpuva.lock);
>                 ctx->prev_va =3D NULL;
>         }
>
>         if (op->remap.next) {
> +               mutex_lock(&obj->gpuva.lock);
>                 drm_gpuva_link(&ctx->next_va->base, vm_bo);
> +               mutex_unlock(&obj->gpuva.lock);
>                 ctx->next_va =3D NULL;
>         }
>
> -       drm_gpuva_unlink(op->remap.unmap->va);
> +       drm_gpuva_unlink_defer(op->remap.unmap->va);
>         kfree(to_pvr_vm_gpuva(op->remap.unmap->va));
>
>         return 0;
> @@ -588,7 +599,8 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, boo=
l is_userspace_context)
>         drm_gem_private_object_init(&pvr_dev->base, &vm_ctx->dummy_gem, 0=
);
>         drm_gpuvm_init(&vm_ctx->gpuvm_mgr,
>                        is_userspace_context ? "PowerVR-user-VM" : "PowerV=
R-FW-VM",
> -                      0, &pvr_dev->base, &vm_ctx->dummy_gem,
> +                      DRM_GPUVM_IMMEDIATE_MODE, &pvr_dev->base,
> +                      &vm_ctx->dummy_gem,
>                        0, 1ULL << device_addr_bits, 0, 0, &pvr_vm_gpuva_o=
ps);
>
>         mutex_init(&vm_ctx->lock);
> @@ -622,6 +634,7 @@ pvr_vm_context_release(struct kref *ref_count)
>                 pvr_fw_object_destroy(vm_ctx->fw_mem_ctx_obj);
>
>         pvr_vm_unmap_all(vm_ctx);
> +       drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
>
>         pvr_mmu_context_destroy(vm_ctx->mmu_ctx);
>         drm_gem_private_object_fini(&vm_ctx->dummy_gem);
> @@ -758,7 +771,9 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_=
gem_object *pvr_obj,
>
>  err_cleanup:
>         mutex_unlock(&vm_ctx->lock);
> +
>         pvr_vm_bind_op_fini(&bind_op);
> +       drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
>
>         return err;
>  }
> @@ -840,6 +855,8 @@ pvr_vm_unmap_obj(struct pvr_vm_context *vm_ctx, struc=
t pvr_gem_object *pvr_obj,
>         err =3D pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj, device_addr, siz=
e);
>         mutex_unlock(&vm_ctx->lock);
>
> +       drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> +
>         return err;
>  }
>
> @@ -874,6 +891,8 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 devic=
e_addr, u64 size)
>
>         mutex_unlock(&vm_ctx->lock);
>
> +       drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> +
>         return err;
>  }
>
> @@ -906,6 +925,8 @@ pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
>         }
>
>         mutex_unlock(&vm_ctx->lock);
> +
> +       drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
>  }
>
>  /* Static data areas are determined by firmware. */
>
> --
> 2.43.0
>


--=20
Thanks,
Gyeyoung
