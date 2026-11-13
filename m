Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12A606A882
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tItyIGcx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694C610E677;
	Fri, 13 Nov 2026 02:24:37 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A186610E677
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 02:24:30 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-67c58f18765so341770d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 18:24:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794536669; cv=none;
 d=google.com; s=arc-20260327;
 b=QDnqL2QTc//GB3peUJk1huLCiWhtgoS0/pbib8UKISFRcL080ZMzPtHe0Cq3nOqwpV
 G4mKL2bVKoUS3hSrezYdZmOtR6bUwmMfZydwEUCqXKhlVJUxhMiSPD59KRwWPN8MuGIz
 b2bPa2MQSvskcdke3tB5dJThzRxF9d7iYIb1a04s+pgN14vuPpT9D9m0vZLF5YJBrCgD
 YzQbdESP2Mkl1BPb70X+tuL7zf4stD+pJnoI8PNFiAPy13BuusoACoCZ4/qTUQ/xJV5r
 xzX3CmYdmoMyA50qkOOw1qf3z44ywWbstoVT4LKX7h/OtI+8B5ClW3zQB3F2XBpe963s
 O86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oWzMkP8XjVIWFgDnL4ZI/gXC/s+5pEfVFpM+tbO5lhY=;
 fh=KW9rizO8qUPlyfE05DP3smU3yBKUg13zqRPxiWFETTE=;
 b=FM34eJ6tyguImfrAcUj1OC/cBsh5xVefSsReBKXG0QG3C9Xw6O9VFOHFs90z/6DkvI
 YH0vufwBNEbhERrJbD4D2BN3OuZQfN1MfD6msl7SSAnDyE46TntMs6V2gHchouIE1z4v
 frKEzEQcFAt+RdWxuJzhOrnAcq5xWwC4hT2bi0n6qAcpdr4DdSA0x7JWPIoWIecDWQO2
 Yv/zA0cshzdw3eh72TU5N3sd83Y4zvF2IyP6/TZc9M0I/aYGM+2CU3LGJbnB+Mzo4qFK
 3PZE5uYH01FSrh3uBhtA/X4pUnHicE+yiFk8CpgL4JcGk8F2vuAW+oCFT6Cpcu4Q6YsS
 RJuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794536669; x=1795141469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oWzMkP8XjVIWFgDnL4ZI/gXC/s+5pEfVFpM+tbO5lhY=;
 b=tItyIGcxJLJ4JELYtmP+frVHfcvO4OpLODzfArocIw8anT3ozz8cFtfaJE7M0KDsyJ
 LOVfjMJ+xMB2xDDCUE+HxxknfKsABKTl5VpZ+SltVHc9du9AMX+rlPmQOY2LvNbWu3sL
 xoFIDRom+YQzZSE1dpoWT54cCnjtw53XLFt0JDSkDUHl+b2adZ2/yuB9Okbb3ax2XtFC
 7wIrotIRJvsjA1FRrZRaXCpZaja6Wat3imKbB1SlMr1ID5qMGzuWOROhSfBOw0RL6qI2
 C0YevmtVZdEdmRyjwmzlpQGvKAMHMPwDGnpawBJ53/V+yzXWBw6rXLrqXFS9zAcZqhn/
 pHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794536669; x=1795141469;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oWzMkP8XjVIWFgDnL4ZI/gXC/s+5pEfVFpM+tbO5lhY=;
 b=fJXLNnb5lD6ORgpCI3uk/qmfyVtaycPKxj43WrYi7MCH9d9f5rZm8FHtFBLQgjlE+F
 19l0Ub8eAVXLcP7t/ZSKK3/k/J5DueQl7CHubZCyImp3C/AiD8rj4Z8cgAKwl8cxD8DI
 7rt0Upyec4D8mNgfelxmKxkZh9jeSzgSvIRkBL+Qv8KxhiHYrZ8Fex31tleci9iAhj8g
 avg58BB/eAx0c7ROUl49CEXDyD1Zryr9UtVjOoPMKtDlK1K2unXyjAx0nb6JNqvgOWZm
 WTKv3/yBKoV2wvKSQYs9jLzVupf3qSr449RZB9cTxWORbVA3uReXUd4vVQB6Pr7+et7N
 lZtg==
X-Forwarded-Encrypted: i=1;
 AL+hErHMwZyGWI9EweAxY/YvQO629leIyLTMLTEnAAXE5DKzU2HDntHu7ifqgiWC9mIFemMBb41JCAvxmlc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/tEVF2rEZonu3n9QDYWRA/D0+zgptlI+xWXsg0KnD4yq0F8nyS
 ycSLO5G7fTsq07yHCNNBdxwTMdkg5soDQc6T8trFmDc6zGOM6CbSNcyLgHH4THRpvamm6Ic+E6M
 bpFaVbiZiGzvFnkZ+mJahL9ShO1b97/c=
X-Gm-Gg: AYBFou0LhgTUzbtmxX32zaHslhWl58QM5l8V2ptCrlSxjJQyWxADbcDmWz9MiSN++3R
 kEF4jX8vUarVQqRxLnedFLXndxRQO3xK3ZfAPMWGxBhe+4pkHc63U0OyouN7LYBdcEtCHIPge8z
 /hYF9t28FG/gxZWlvRQBstgNEycWTW2ZkExwSoFSdvq4vhy0eQJRqZZunnvnIcOFlXSlLF3JvzQ
 bmxnqsO9zdoLi+Yg+xo1Um652kmcjzaddKXb8jyswPztSncygE1pzch7QVBi/6F8FnICEzz3I50
 w+6LzE3XjSkTKjUKzmc0Yc2UHgoGhGp/iZ4Kb+j4j8/UETc4FVAlLCqqtH0U7XamLjjKX3Q0jy5
 LF3nIaAqxolqvl2GKNJZYMfAeE39dz9cMX4qodg==
X-Received: by 2002:a53:acd4:0:10b0:67b:fce3:45e8 with SMTP id
 956f58d0204a3-67d8978dbf7mr530380d50.94.1794536669230; Thu, 12 Nov 2026
 18:24:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101073700.1261966-1-gye976@gmail.com>
In-Reply-To: <20261101073700.1261966-1-gye976@gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Fri, 13 Nov 2026 11:24:18 +0900
X-Gm-Features: AclHuK-uyrlffIoFjYHTKCRH3SK4kkMQorZdRDw1Xbvlm4EKkbd7IoOWYybBtis
Message-ID: <CAKbEznsZ+rFG+U3Et8rovZUPmpLWnoiB5CQPNMHGmMD9C3J9Sw@mail.gmail.com>
Subject: Re: [PATCH v2] accel/rocket: Fix drm_mm UAF on close vs in-flight job
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sidong Yang <sidong.yang@furiosa.ai>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Gentle ping.

This is hit frequently in testing whenever a process exits
with jobs still in flight.

On Sun, Nov 1, 2026 at 4:37=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> wro=
te:
>
> The drm_mm and its mutex live in rocket_file_priv, which
> rocket_postclose() frees on fd close.  But a BO held by an
> in-flight job is only freed after close, from the drm_sched
> free_job worker, and its destructor then accesses the already
> freed drm_mm and mutex.
>
>   BUG: KASAN: slab-use-after-free in __mutex_trylock_common+0x90/0x1e8
>   Workqueue: <NPU>.npu drm_sched_free_job_work [gpu_sched]
>   Call trace:
>     __mutex_lock
>     rocket_gem_bo_free
>     rocket_job_cleanup
>     rocket_job_free
>     drm_sched_free_job_work [gpu_sched]
>
> Move drm_mm and the mutex out of rocket_file_priv into the
> kref-managed rocket_iommu_domain (renamed to rocket_vm).  Their
> lifetime now matches the vm's: as long as a BO or job references
> the vm, the address-space state stays alive.
>
> Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
> Changes in v2:
> - Rebased on drm-misc-fixes and resent. No functional changes.
> - Link to v1: https://lore.kernel.org/r/20260426103758.1373137-1-gye976@g=
mail.com
>
>  drivers/accel/rocket/rocket_drv.c | 74 +++++++++++++++----------------
>  drivers/accel/rocket/rocket_drv.h | 13 +++---
>  drivers/accel/rocket/rocket_gem.c | 31 ++++++-------
>  drivers/accel/rocket/rocket_gem.h |  4 +-
>  drivers/accel/rocket/rocket_job.c |  6 +--
>  drivers/accel/rocket/rocket_job.h |  2 +-
>  6 files changed, 64 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 5d7805c41dc..f58c15131dc 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -26,46 +26,54 @@ static struct platform_device *drm_dev;
>  static struct rocket_device *rdev;
>
>  static void
> -rocket_iommu_domain_destroy(struct kref *kref)
> +rocket_vm_destroy(struct kref *kref)
>  {
> -       struct rocket_iommu_domain *domain =3D container_of(kref, struct =
rocket_iommu_domain, kref);
> +       struct rocket_vm *vm =3D container_of(kref, struct rocket_vm, kre=
f);
>
> -       iommu_domain_free(domain->domain);
> -       domain->domain =3D NULL;
> -       kfree(domain);
> +       drm_mm_takedown(&vm->mm);
> +       mutex_destroy(&vm->lock);
> +       iommu_domain_free(vm->domain);
> +       vm->domain =3D NULL;
> +       kfree(vm);
>  }
>
> -static struct rocket_iommu_domain*
> -rocket_iommu_domain_create(struct device *dev)
> +static struct rocket_vm *
> +rocket_vm_create(struct device *dev)
>  {
> -       struct rocket_iommu_domain *domain =3D kmalloc_obj(*domain);
> +       struct rocket_vm *vm =3D kmalloc_obj(*vm);
> +       u64 start, end;
>         void *err;
>
> -       if (!domain)
> +       if (!vm)
>                 return ERR_PTR(-ENOMEM);
>
> -       domain->domain =3D iommu_paging_domain_alloc(dev);
> -       if (IS_ERR(domain->domain)) {
> -               err =3D ERR_CAST(domain->domain);
> -               kfree(domain);
> +       vm->domain =3D iommu_paging_domain_alloc(dev);
> +       if (IS_ERR(vm->domain)) {
> +               err =3D ERR_CAST(vm->domain);
> +               kfree(vm);
>                 return err;
>         }
> -       kref_init(&domain->kref);
>
> -       return domain;
> +       start =3D vm->domain->geometry.aperture_start;
> +       end =3D vm->domain->geometry.aperture_end;
> +       drm_mm_init(&vm->mm, start, end - start + 1);
> +       mutex_init(&vm->lock);
> +       kref_init(&vm->kref);
> +
> +       return vm;
>  }
>
> -struct rocket_iommu_domain *
> -rocket_iommu_domain_get(struct rocket_file_priv *rocket_priv)
> +struct rocket_vm *
> +rocket_vm_get(struct rocket_file_priv *rocket_priv)
>  {
> -       kref_get(&rocket_priv->domain->kref);
> -       return rocket_priv->domain;
> +       kref_get(&rocket_priv->vm->kref);
> +       return rocket_priv->vm;
>  }
>
>  void
> -rocket_iommu_domain_put(struct rocket_iommu_domain *domain)
> +rocket_vm_put(struct rocket_vm *vm)
>  {
> -       kref_put(&domain->kref, rocket_iommu_domain_destroy);
> +       kref_put(&vm->kref, rocket_vm_destroy);
>  }
>
>  static int
> @@ -73,7 +81,6 @@ rocket_open(struct drm_device *dev, struct drm_file *fi=
le)
>  {
>         struct rocket_device *rdev =3D to_rocket_device(dev);
>         struct rocket_file_priv *rocket_priv;
> -       u64 start, end;
>         int ret;
>
>         if (!try_module_get(THIS_MODULE))
> @@ -86,29 +93,22 @@ rocket_open(struct drm_device *dev, struct drm_file *=
file)
>         }
>
>         rocket_priv->rdev =3D rdev;
> -       rocket_priv->domain =3D rocket_iommu_domain_create(rdev->cores[0]=
.dev);
> -       if (IS_ERR(rocket_priv->domain)) {
> -               ret =3D PTR_ERR(rocket_priv->domain);
> +       rocket_priv->vm =3D rocket_vm_create(rdev->cores[0].dev);
> +       if (IS_ERR(rocket_priv->vm)) {
> +               ret =3D PTR_ERR(rocket_priv->vm);
>                 goto err_free;
>         }
>
>         file->driver_priv =3D rocket_priv;
>
> -       start =3D rocket_priv->domain->domain->geometry.aperture_start;
> -       end =3D rocket_priv->domain->domain->geometry.aperture_end;
> -       drm_mm_init(&rocket_priv->mm, start, end - start + 1);
> -       mutex_init(&rocket_priv->mm_lock);
> -
>         ret =3D rocket_job_open(rocket_priv);
>         if (ret)
> -               goto err_mm_takedown;
> +               goto err_vm_put;
>
>         return 0;
>
> -err_mm_takedown:
> -       mutex_destroy(&rocket_priv->mm_lock);
> -       drm_mm_takedown(&rocket_priv->mm);
> -       rocket_iommu_domain_put(rocket_priv->domain);
> +err_vm_put:
> +       rocket_vm_put(rocket_priv->vm);
>  err_free:
>         kfree(rocket_priv);
>  err_put_mod:
> @@ -122,9 +122,7 @@ rocket_postclose(struct drm_device *dev, struct drm_f=
ile *file)
>         struct rocket_file_priv *rocket_priv =3D file->driver_priv;
>
>         rocket_job_close(rocket_priv);
> -       mutex_destroy(&rocket_priv->mm_lock);
> -       drm_mm_takedown(&rocket_priv->mm);
> -       rocket_iommu_domain_put(rocket_priv->domain);
> +       rocket_vm_put(rocket_priv->vm);
>         kfree(rocket_priv);
>         module_put(THIS_MODULE);
>  }
> diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/roc=
ket_drv.h
> index 2c673bb99cc..2754f46f174 100644
> --- a/drivers/accel/rocket/rocket_drv.h
> +++ b/drivers/accel/rocket/rocket_drv.h
> @@ -11,22 +11,23 @@
>
>  extern const struct dev_pm_ops rocket_pm_ops;
>
> -struct rocket_iommu_domain {
> +struct rocket_vm {
>         struct iommu_domain *domain;
> +       struct drm_mm mm;
> +       /* protects @mm */
> +       struct mutex lock;
>         struct kref kref;
>  };
>
>  struct rocket_file_priv {
>         struct rocket_device *rdev;
>
> -       struct rocket_iommu_domain *domain;
> -       struct drm_mm mm;
> -       struct mutex mm_lock;
> +       struct rocket_vm *vm;
>
>         struct drm_sched_entity sched_entity;
>  };
>
> -struct rocket_iommu_domain *rocket_iommu_domain_get(struct rocket_file_p=
riv *rocket_priv);
> -void rocket_iommu_domain_put(struct rocket_iommu_domain *domain);
> +struct rocket_vm *rocket_vm_get(struct rocket_file_priv *rocket_priv);
> +void rocket_vm_put(struct rocket_vm *vm);
>
>  #endif
> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/roc=
ket_gem.c
> index a5fffa51ff3..057fd82e2a5 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -14,20 +14,20 @@
>  static void rocket_gem_bo_free(struct drm_gem_object *obj)
>  {
>         struct rocket_gem_object *bo =3D to_rocket_bo(obj);
> -       struct rocket_file_priv *rocket_priv =3D bo->driver_priv;
> +       struct rocket_vm *vm =3D bo->vm;
>         size_t unmapped;
>
>         drm_WARN_ON(obj->dev, refcount_read(&bo->base.pages_use_count) > =
1);
>
> -       unmapped =3D iommu_unmap(bo->domain->domain, bo->mm.start, bo->si=
ze);
> +       unmapped =3D iommu_unmap(vm->domain, bo->mm.start, bo->size);
>         drm_WARN_ON(obj->dev, unmapped !=3D bo->size);
>
> -       mutex_lock(&rocket_priv->mm_lock);
> +       mutex_lock(&vm->lock);
>         drm_mm_remove_node(&bo->mm);
> -       mutex_unlock(&rocket_priv->mm_lock);
> +       mutex_unlock(&vm->lock);
>
> -       rocket_iommu_domain_put(bo->domain);
> -       bo->domain =3D NULL;
> +       rocket_vm_put(vm);
> +       bo->vm =3D NULL;
>
>         drm_gem_shmem_free(&bo->base);
>  }
> @@ -64,6 +64,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void=
 *data, struct drm_file *
>         struct drm_gem_shmem_object *shmem_obj;
>         struct rocket_gem_object *rkt_obj;
>         struct drm_gem_object *gem_obj;
> +       struct rocket_vm *vm;
>         struct sg_table *sgt;
>         int ret;
>
> @@ -74,8 +75,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void=
 *data, struct drm_file *
>         gem_obj =3D &shmem_obj->base;
>         rkt_obj =3D to_rocket_bo(gem_obj);
>
> -       rkt_obj->driver_priv =3D rocket_priv;
> -       rkt_obj->domain =3D rocket_iommu_domain_get(rocket_priv);
> +       vm =3D rocket_vm_get(rocket_priv);
> +       rkt_obj->vm =3D vm;
>         rkt_obj->size =3D args->size;
>         rkt_obj->offset =3D 0;
>
> @@ -85,15 +86,15 @@ int rocket_ioctl_create_bo(struct drm_device *dev, vo=
id *data, struct drm_file *
>                 goto err;
>         }
>
> -       mutex_lock(&rocket_priv->mm_lock);
> -       ret =3D drm_mm_insert_node_generic(&rocket_priv->mm, &rkt_obj->mm=
,
> +       mutex_lock(&vm->lock);
> +       ret =3D drm_mm_insert_node_generic(&vm->mm, &rkt_obj->mm,
>                                          rkt_obj->size, PAGE_SIZE,
>                                          0, 0);
> -       mutex_unlock(&rocket_priv->mm_lock);
> +       mutex_unlock(&vm->lock);
>         if (ret)
>                 goto err;
>
> -       ret =3D iommu_map_sgtable(rocket_priv->domain->domain,
> +       ret =3D iommu_map_sgtable(vm->domain,
>                                 rkt_obj->mm.start,
>                                 shmem_obj->sgt,
>                                 IOMMU_READ | IOMMU_WRITE);
> @@ -118,13 +119,13 @@ int rocket_ioctl_create_bo(struct drm_device *dev, =
void *data, struct drm_file *
>         return 0;
>
>  err_unmap:
> -       iommu_unmap(rocket_priv->domain->domain,
> +       iommu_unmap(vm->domain,
>                     rkt_obj->mm.start, rkt_obj->size);
>
>  err_remove_node:
> -       mutex_lock(&rocket_priv->mm_lock);
> +       mutex_lock(&vm->lock);
>         drm_mm_remove_node(&rkt_obj->mm);
> -       mutex_unlock(&rocket_priv->mm_lock);
> +       mutex_unlock(&vm->lock);
>
>  err:
>         drm_gem_shmem_object_free(gem_obj);
> diff --git a/drivers/accel/rocket/rocket_gem.h b/drivers/accel/rocket/roc=
ket_gem.h
> index 24043033450..e1fbbd8cf71 100644
> --- a/drivers/accel/rocket/rocket_gem.h
> +++ b/drivers/accel/rocket/rocket_gem.h
> @@ -9,9 +9,7 @@
>  struct rocket_gem_object {
>         struct drm_gem_shmem_object base;
>
> -       struct rocket_file_priv *driver_priv;
> -
> -       struct rocket_iommu_domain *domain;
> +       struct rocket_vm *vm;
>         struct drm_mm_node mm;
>         size_t size;
>         u32 offset;
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 4bc4f9c8ee4..0de56bb84e3 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -240,7 +240,7 @@ static void rocket_job_cleanup(struct kref *ref)
>                                                 refcount);
>         unsigned int i;
>
> -       rocket_iommu_domain_put(job->domain);
> +       rocket_vm_put(job->vm);
>
>         dma_fence_put(job->done_fence);
>         dma_fence_put(job->inference_done_fence);
> @@ -321,7 +321,7 @@ static struct dma_fence *rocket_job_run(struct drm_sc=
hed_job *sched_job)
>         if (ret < 0)
>                 goto err_put_fences;
>
> -       ret =3D iommu_attach_group(job->domain->domain, core->iommu_group=
);
> +       ret =3D iommu_attach_group(job->vm->domain, core->iommu_group);
>         if (ret < 0)
>                 goto err_put_pm;
>
> @@ -564,7 +564,7 @@ static int rocket_ioctl_submit_job(struct drm_device =
*dev, struct drm_file *file
>         kref_init(&rjob->refcount);
>
>         rjob->rdev =3D rdev;
> -       rjob->domain =3D rocket_iommu_domain_get(file_priv);
> +       rjob->vm =3D rocket_vm_get(file_priv);
>
>         ret =3D drm_sched_job_init(&rjob->base,
>                                  &file_priv->sched_entity,
> diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/roc=
ket_job.h
> index 4ae00feec3b..9373c3d0273 100644
> --- a/drivers/accel/rocket/rocket_job.h
> +++ b/drivers/accel/rocket/rocket_job.h
> @@ -36,7 +36,7 @@ struct rocket_job {
>         /* Fence to be signaled by IRQ handler when the job is complete. =
*/
>         struct dma_fence *done_fence;
>
> -       struct rocket_iommu_domain *domain;
> +       struct rocket_vm *vm;
>
>         struct kref refcount;
>  };
>
> base-commit: f00d7a241f846b053e89c0bb2285ef5988d4cafc
> --
> 2.43.0
>


--=20
Thanks,
Gyeyoung
