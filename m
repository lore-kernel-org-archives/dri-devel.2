Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52FECD37AC
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC0D10F308;
	Thu, 14 May 2026 18:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IVjiIb5R";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A338C10F309
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:36:52 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-65dead17c24so4707366d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778783812; cv=none;
 d=google.com; s=arc-20240605;
 b=JyoeWGmQg/Ypb7eK1ZkOeSJyk8oGXwaaZc6jGRtB2fUyCEiLq26mjQoJBrlqUMr9+E
 7Y+u1Gn6KvPcqqZKtqCA3p3cnsv4avn6aG7KXOV2cFL2mMSSSJzSLqUbiOScbDo/ALaD
 IUzt1n7E0FbjPGGLH9/SoZeqp3znC7cMDd1e1APi6xKFZt6EffYwCN8ywL+/BWbdtN1F
 PgmSsq2MOtY08daXoMaqztWVvLjxAOq7KQnfWDFT8TBXrG3xWu3LuetTh0Kg8s8J+BmM
 2mKYPTTdvQBRM0ajyMcRSZ2OsX126T0r3kVtpNvZOjmQ1J42bm6UKGhsRgPPd8GiAIvm
 CnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ofLQ0WZkULXfMuSqkbcmkllFaI6VJgcrCFzwzW8gdh0=;
 fh=r5qek+etdLL/VHsqJY09GIQFc+pPUuuYASusMG0Y6/A=;
 b=AycOtM5ikfbw1jOU92TDmcwi7cz224TN8LXJhB26L2BVxM0e7EaA/2Oj6j2D68B7Wd
 lLC85TdhlYJrcG8Wo6Zh7nvAqoK7xAZJKghE4Z9yt9frH5JV5LhqhizTvw4yLVJ+SBfy
 T6zXBa/CCwpDNxcDoJFIpRY77zCgQPlwVS3tlPglq0hE5rttXTPqiuQc52Rs9hANK/u3
 jdPeGH7oYAMYnIN6NfGcN46tT4hhWFIpo//qJn8bSv4U2+snF0/BZaS/BC4SDItsd4kC
 NOD45FCHDOoVYjpIDxwLj2a93nYiVbmXnNmdQiIEabntPV+Lq8pnn7vxCHL/ILUfxVZ1
 EALg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778783812; x=1779388612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofLQ0WZkULXfMuSqkbcmkllFaI6VJgcrCFzwzW8gdh0=;
 b=IVjiIb5Rd3gptI6/jF+jCYidtiJXAeOFHJNPLahAXDFcDFM8GxMVMcJVuybDnx5vB/
 cE7NJEF4ItmRLM/jxmm+/oi4Ivrxwh5/t+8F/LaH4HK2KeZkxUP2OUcP67u4XXoHMjdq
 tlPUUADxWM5F1WTI2754pCiWOilhLHI9yOvuGkali8RjD6wJqsZ+1bLMI+ilP4f9Cjmt
 voR4Fi7RIStlfY37Ad502ac2TCk+noGLOZ8f4mchwXNaWu98mQVUHDzu75i9SyUbyCaT
 5NlCPm7SZMB/fKZER6UF0VLKa/rDrx8ee5HlmuufboVlLI/bOwvHtHT67sOmMycIInkZ
 9KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778783812; x=1779388612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ofLQ0WZkULXfMuSqkbcmkllFaI6VJgcrCFzwzW8gdh0=;
 b=NZ+hM7yAWQl2wqWDdVikX7yOwd69JdKm50oAYOG7fUv95Qm+mnUgY6SUPicKbYvMHQ
 2V1SkeNsLuiGSfFbs3vNdyLR2fDwsAeNsMXA58sBxA7mxVBbVT/jLWyh+dlOd8useo7h
 RNLclFsf3tlVVz2I8kuFsuuNPLm5KX0L0LBfn2bgsjCpfkpK8Y2wSB/lLy34sVLywuXJ
 p6aOo8mnjztjGA7qWrRpzr4iZpcWmxToTvI3W6VaY9qk+ARpNal0VDIYBGkc+xzWc2Lr
 ZrwEqtWKU91FGSzo9rqvB/jXl028+IlNF+zIKC1zGoQDAE6mk4hU6osuYFqrrM3xpPsm
 LCiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RfkafHYuijwHNLxmS+G1XSGGdOBxch2/LEhLBl/iS7+0OtKqGF7OSDC9WS8FN4p740oOs7Buu2bc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjCQ2yiZ+zuoiu6AVPhS/Baz2KGk7uZT5t9SBxiUkLtUqO1/Em
 h7lKO2FJHsvrRPmB9PYTQSRxQyj/1q3cQdgVflgpaYZfkdWTsk3nyMOVwNBN5SjV87AB4Xmn3Wv
 dvo5A6tUfX+fw84W0HT7kZqsObg5Lwmw=
X-Gm-Gg: Acq92OEZICN53pOBbGIexXE3W4MRp9LZoovYHmV9dLtrBuG8ZcOD51VgAO7FF2wmUn9
 8/LPVxVuy2A6mULcD6JAXgytnxmxyFiRqg/OrWQfCZi7ejVisWWwevU3XOLo/lAGxftV8PRzgBA
 /e6k8bzoIAV5A2+AH9KayTzLyzcz3i4sMFwoAGh40f5jJVlP7g/VDE1oL3GQF1em/xTlKHebTUJ
 MNWqlyPsgEVR5+EDG/msU8eNliGzg+sYz8h5zm485BztVy28Wddd3HCLh9iL6TL62B3hsMjoXlW
 X6vmE2c9pjZ32SJ8ugf9HEWOCuQ+Uq4b2R1Dy7y5Mx5zXaJd4UFno5+04RkjlEt+nHGR7f2buw=
 =
X-Received: by 2002:a05:690c:f06:b0:7bf:107b:e77a with SMTP id
 00721157ae682-7c95c6f3c40mr5657087b3.30.1778783811407; Thu, 14 May 2026
 11:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-5-f2d8c15a97ce@collabora.com>
In-Reply-To: <20260513-panthor-guard-refactor-v1-5-f2d8c15a97ce@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 14 May 2026 11:36:40 -0700
X-Gm-Features: AVHnY4K60r1MCKB_TMfS092NfmTqUOWhT6Z5aVt_4fNBfnWGP3q11PrX_MvwBnU
Message-ID: <CAPaKu7TPe3ohss2=4S=jL=egsbNWxOvu7KW+6mN3arvVmo3r-w@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/panthor: Use the drm_dev_access guard
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
> It simplifies the code in a few places, allowing direct returns instead
> of gotos. It also helps identifying the sections under the dev_access
> guard when scoped_cond_guard() is used.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 127 ++++++++++++++-----------=
------
>  drivers/gpu/drm/panthor/panthor_drv.c    |  58 ++++++--------
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  29 +++----
>  drivers/gpu/drm/panthor/panthor_sched.c  |  10 +--
>  4 files changed, 95 insertions(+), 129 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index cb9cd8d0448b..988a9a34f753 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -123,7 +123,7 @@ static void panthor_device_reset_cleanup(struct drm_d=
evice *ddev, void *data)
>  static void panthor_device_reset_work(struct work_struct *work)
>  {
>         struct panthor_device *ptdev =3D container_of(work, struct pantho=
r_device, reset.work);
> -       int ret =3D 0, cookie;
> +       int ret =3D 0;
>
>         /* If the device is entering suspend, we don't reset. A slow rese=
t will
>          * be forced at resume time instead.
> @@ -131,19 +131,17 @@ static void panthor_device_reset_work(struct work_s=
truct *work)
>         if (atomic_read(&ptdev->pm.state) !=3D PANTHOR_DEVICE_PM_STATE_AC=
TIVE)
>                 return;
>
> -       if (!drm_dev_enter(&ptdev->base, &cookie))
> -               return;
> -
> -       panthor_sched_pre_reset(ptdev);
> -       panthor_fw_pre_reset(ptdev, true);
> -       panthor_mmu_pre_reset(ptdev);
> -       panthor_hw_soft_reset(ptdev);
> -       panthor_hw_l2_power_on(ptdev);
> -       panthor_mmu_post_reset(ptdev);
> -       ret =3D panthor_fw_post_reset(ptdev);
> -       atomic_set(&ptdev->reset.pending, 0);
> -       panthor_sched_post_reset(ptdev, ret !=3D 0);
> -       drm_dev_exit(cookie);
> +       scoped_cond_guard(drm_dev_access, return, &ptdev->base) {
> +               panthor_sched_pre_reset(ptdev);
> +               panthor_fw_pre_reset(ptdev, true);
> +               panthor_mmu_pre_reset(ptdev);
> +               panthor_hw_soft_reset(ptdev);
> +               panthor_hw_l2_power_on(ptdev);
> +               panthor_mmu_post_reset(ptdev);
> +               ret =3D panthor_fw_post_reset(ptdev);
> +               atomic_set(&ptdev->reset.pending, 0);
> +               panthor_sched_post_reset(ptdev, ret !=3D 0);
> +       }
>
>         if (ret) {
>                 panthor_device_unplug(ptdev);
> @@ -394,38 +392,31 @@ static vm_fault_t panthor_mmio_vm_fault(struct vm_f=
ault *vmf)
>         u64 offset =3D (u64)vma->vm_pgoff << PAGE_SHIFT;
>         unsigned long pfn;
>         pgprot_t pgprot;
> -       vm_fault_t ret;
>         bool active;
> -       int cookie;
>
> -       if (!drm_dev_enter(&ptdev->base, &cookie))
> +       ACQUIRE(drm_dev_access, dev_guard)(&ptdev->base);
> +       if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
>                 return VM_FAULT_SIGBUS;
>
> -       scoped_guard(mutex, &ptdev->pm.mmio_lock) {
> -               active =3D atomic_read(&ptdev->pm.state) =3D=3D PANTHOR_D=
EVICE_PM_STATE_ACTIVE;
> +       guard(mutex)(&ptdev->pm.mmio_lock);
> +       active =3D atomic_read(&ptdev->pm.state) =3D=3D PANTHOR_DEVICE_PM=
_STATE_ACTIVE;
>
> -               switch (offset) {
> -               case DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET:
> -                       if (active)
> -                               pfn =3D __phys_to_pfn(ptdev->phys_addr + =
CSF_GPU_LATEST_FLUSH_ID);
> -                       else
> -                               pfn =3D page_to_pfn(ptdev->pm.dummy_lates=
t_flush);
> +       switch (offset) {
> +       case DRM_PANTHOR_USER_FLUSH_ID_MMIO_OFFSET:
> +               if (active)
> +                       pfn =3D __phys_to_pfn(ptdev->phys_addr + CSF_GPU_=
LATEST_FLUSH_ID);
> +               else
> +                       pfn =3D page_to_pfn(ptdev->pm.dummy_latest_flush)=
;
>
> -                       pgprot =3D vma->vm_page_prot;
> -                       if (active)
> -                               pgprot =3D pgprot_noncached(pgprot);
> +               pgprot =3D vma->vm_page_prot;
> +               if (active)
> +                       pgprot =3D pgprot_noncached(pgprot);
>
> -                       ret =3D vmf_insert_pfn_prot(vma, vmf->address, pf=
n, pgprot);
> -                       break;
> +               return vmf_insert_pfn_prot(vma, vmf->address, pfn, pgprot=
);
>
> -               default:
> -                       ret =3D VM_FAULT_SIGBUS;
> -                       break;
> -               }
> +       default:
> +               return VM_FAULT_SIGBUS;
>         }
> -
> -       drm_dev_exit(cookie);
> -       return ret;
>  }
>
>  static const struct vm_operations_struct panthor_mmio_vm_ops =3D {
> @@ -482,7 +473,7 @@ static int panthor_device_resume_hw_components(struct=
 panthor_device *ptdev)
>  int panthor_device_resume(struct device *dev)
>  {
>         struct panthor_device *ptdev =3D dev_get_drvdata(dev);
> -       int ret, cookie;
> +       int ret;
>
>         if (atomic_read(&ptdev->pm.state) !=3D PANTHOR_DEVICE_PM_STATE_SU=
SPENDED)
>                 return -EINVAL;
> @@ -503,28 +494,27 @@ int panthor_device_resume(struct device *dev)
>
>         panthor_devfreq_resume(ptdev);
>
> -       if (panthor_device_is_initialized(ptdev) &&
> -           drm_dev_enter(&ptdev->base, &cookie)) {
> -               /* If there was a reset pending at the time we suspended =
the
> -                * device, we force a slow reset.
> -                */
> -               if (atomic_read(&ptdev->reset.pending)) {
> -                       ptdev->reset.fast =3D false;
> -                       atomic_set(&ptdev->reset.pending, 0);
> -               }
> +       if (panthor_device_is_initialized(ptdev)) {
> +               scoped_cond_guard(drm_dev_access, ret =3D 0, &ptdev->base=
) {
> +                       /* If there was a reset pending at the time we su=
spended the
> +                        * device, we force a slow reset.
> +                        */
> +                       if (atomic_read(&ptdev->reset.pending)) {
> +                               ptdev->reset.fast =3D false;
> +                               atomic_set(&ptdev->reset.pending, 0);
> +                       }
>
> -               ret =3D panthor_device_resume_hw_components(ptdev);
> -               if (ret && ptdev->reset.fast) {
> -                       drm_err(&ptdev->base, "Fast reset failed, trying =
a slow reset");
> -                       ptdev->reset.fast =3D false;
>                         ret =3D panthor_device_resume_hw_components(ptdev=
);
> +                       if (ret && ptdev->reset.fast) {
> +                               drm_err(&ptdev->base, "Fast reset failed,=
 trying a slow reset");
> +                               ptdev->reset.fast =3D false;
> +                               ret =3D panthor_device_resume_hw_componen=
ts(ptdev);
> +                       }
> +
> +                       if (!ret)
> +                               panthor_sched_resume(ptdev);
>                 }
>
> -               if (!ret)
> -                       panthor_sched_resume(ptdev);
> -
> -               drm_dev_exit(cookie);
> -
>                 if (ret)
>                         goto err_suspend_devfreq;
>         }
> @@ -559,7 +549,6 @@ int panthor_device_resume(struct device *dev)
>  int panthor_device_suspend(struct device *dev)
>  {
>         struct panthor_device *ptdev =3D dev_get_drvdata(dev);
> -       int cookie;
>
>         if (atomic_read(&ptdev->pm.state) !=3D PANTHOR_DEVICE_PM_STATE_AC=
TIVE)
>                 return -EINVAL;
> @@ -577,19 +566,19 @@ int panthor_device_suspend(struct device *dev)
>                                     DRM_PANTHOR_USER_MMIO_OFFSET, 0, 1);
>         }
>
> -       if (panthor_device_is_initialized(ptdev) &&
> -           drm_dev_enter(&ptdev->base, &cookie)) {
> -               cancel_work_sync(&ptdev->reset.work);
> +       if (panthor_device_is_initialized(ptdev)) {
> +               scoped_guard(drm_dev_access, &ptdev->base) {
> +                       cancel_work_sync(&ptdev->reset.work);
>
> -               /* We prepare everything as if we were resetting the GPU.
> -                * The end of the reset will happen in the resume path th=
ough.
> -                */
> -               panthor_sched_suspend(ptdev);
> -               panthor_fw_suspend(ptdev);
> -               panthor_mmu_suspend(ptdev);
> -               panthor_gpu_suspend(ptdev);
> -               panthor_pwr_suspend(ptdev);
> -               drm_dev_exit(cookie);
> +                       /* We prepare everything as if we were resetting =
the GPU.
> +                        * The end of the reset will happen in the resume=
 path though.
> +                        */
> +                       panthor_sched_suspend(ptdev);
> +                       panthor_fw_suspend(ptdev);
> +                       panthor_mmu_suspend(ptdev);
> +                       panthor_gpu_suspend(ptdev);
> +                       panthor_pwr_suspend(ptdev);
> +               }
>         }
>
>         panthor_devfreq_suspend(ptdev);
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index e8dc4096c1d2..789ddc0ff7ef 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -997,9 +997,10 @@ static int panthor_ioctl_vm_create(struct drm_device=
 *ddev, void *data,
>         struct panthor_device *ptdev =3D container_of(ddev, struct pantho=
r_device, base);
>         struct panthor_file *pfile =3D file->driver_priv;
>         struct drm_panthor_vm_create *args =3D data;
> -       int cookie, ret;
> +       int ret;
>
> -       if (!drm_dev_enter(ddev, &cookie))
> +       ACQUIRE(drm_dev_access, dev_guard)(ddev);
> +       if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
>                 return -ENODEV;
>
>         ret =3D panthor_vm_pool_create_vm(ptdev, pfile->vms,  args);
> @@ -1008,7 +1009,6 @@ static int panthor_ioctl_vm_create(struct drm_devic=
e *ddev, void *data,
>                 ret =3D 0;
>         }
>
> -       drm_dev_exit(cookie);
>         return ret;
>  }
>
> @@ -1033,38 +1033,30 @@ static int panthor_ioctl_bo_create(struct drm_dev=
ice *ddev, void *data,
>         struct panthor_file *pfile =3D file->driver_priv;
>         struct drm_panthor_bo_create *args =3D data;
>         struct panthor_vm *vm =3D NULL;
> -       int cookie, ret;
> +       int ret;
>
> -       if (!drm_dev_enter(ddev, &cookie))
> +       ACQUIRE(drm_dev_access, dev_guard)(ddev);
> +       if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
>                 return -ENODEV;
>
>         if (!args->size || args->pad ||
> -           (args->flags & ~PANTHOR_BO_FLAGS)) {
> -               ret =3D -EINVAL;
> -               goto out_dev_exit;
> -       }
> +           (args->flags & ~PANTHOR_BO_FLAGS))
> +               return -EINVAL;
>
>         if ((args->flags & DRM_PANTHOR_BO_NO_MMAP) &&
> -           (args->flags & DRM_PANTHOR_BO_WB_MMAP)) {
> -               ret =3D -EINVAL;
> -               goto out_dev_exit;
> -       }
> +           (args->flags & DRM_PANTHOR_BO_WB_MMAP))
> +               return -EINVAL;
>
>         if (args->exclusive_vm_id) {
>                 vm =3D panthor_vm_pool_get_vm(pfile->vms, args->exclusive=
_vm_id);
> -               if (!vm) {
> -                       ret =3D -EINVAL;
> -                       goto out_dev_exit;
> -               }
> +               if (!vm)
> +                       return -EINVAL;
>         }
>
>         ret =3D panthor_gem_create_with_handle(file, ddev, vm, &args->siz=
e,
>                                              args->flags, &args->handle);
>
>         panthor_vm_put(vm);
> -
> -out_dev_exit:
> -       drm_dev_exit(cookie);
>         return ret;
>  }
>
> @@ -1107,17 +1099,18 @@ static int panthor_ioctl_group_submit(struct drm_=
device *ddev, void *data,
>         struct drm_panthor_group_submit *args =3D data;
>         struct drm_panthor_queue_submit *jobs_args;
>         struct panthor_submit_ctx ctx;
> -       int ret =3D 0, cookie;
> +       int ret =3D 0;
>
>         if (args->pad)
>                 return -EINVAL;
>
> -       if (!drm_dev_enter(ddev, &cookie))
> +       ACQUIRE(drm_dev_access, dev_guard)(ddev);
> +       if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
>                 return -ENODEV;
>
>         ret =3D PANTHOR_UOBJ_GET_ARRAY(jobs_args, &args->queue_submits);
>         if (ret)
> -               goto out_dev_exit;
> +               return ret;
>
>         ret =3D panthor_submit_ctx_init(&ctx, file, args->queue_submits.c=
ount);
>         if (ret)
> @@ -1201,8 +1194,6 @@ static int panthor_ioctl_group_submit(struct drm_de=
vice *ddev, void *data,
>  out_free_jobs_args:
>         kvfree(jobs_args);
>
> -out_dev_exit:
> -       drm_dev_exit(cookie);
>         return ret;
>  }
>
> @@ -1438,18 +1429,15 @@ static int panthor_ioctl_vm_bind(struct drm_devic=
e *ddev, void *data,
>                                  struct drm_file *file)
>  {
>         struct drm_panthor_vm_bind *args =3D data;
> -       int cookie, ret;
>
> -       if (!drm_dev_enter(ddev, &cookie))
> +       ACQUIRE(drm_dev_access, dev_guard)(ddev);
> +       if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
>                 return -ENODEV;
>
>         if (args->flags & DRM_PANTHOR_VM_BIND_ASYNC)
> -               ret =3D panthor_ioctl_vm_bind_async(ddev, args, file);
> -       else
> -               ret =3D panthor_ioctl_vm_bind_sync(ddev, args, file);
> +               return panthor_ioctl_vm_bind_async(ddev, args, file);
>
> -       drm_dev_exit(cookie);
> -       return ret;
> +       return panthor_ioctl_vm_bind_sync(ddev, args, file);
>  }
>
>  static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *dat=
a,
> @@ -1671,9 +1659,10 @@ static int panthor_mmap(struct file *filp, struct =
vm_area_struct *vma)
>         struct panthor_device *ptdev =3D pfile->ptdev;
>         u64 offset =3D (u64)vma->vm_pgoff << PAGE_SHIFT;
>         u64 user_mmio_offset;
> -       int ret, cookie;
> +       int ret;
>
> -       if (!drm_dev_enter(file->minor->dev, &cookie))
> +       ACQUIRE(drm_dev_access, dev_guard)(file->minor->dev);
> +       if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
>                 return -ENODEV;
>
>         /* Adjust the user MMIO offset to match the offset used kernel si=
de.
> @@ -1691,7 +1680,6 @@ static int panthor_mmap(struct file *filp, struct v=
m_area_struct *vma)
>                 ret =3D drm_gem_mmap(filp, vma);
>         }
>
> -       drm_dev_exit(cookie);
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index ab9a77e6a145..ff3beb9147e8 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -788,13 +788,13 @@ static int panthor_vm_active_locked(struct panthor_=
vm *vm)
>  int panthor_vm_active(struct panthor_vm *vm)
>  {
>         struct panthor_device *ptdev =3D vm->ptdev;
> -       int ret =3D 0, cookie;
>
> -       if (!drm_dev_enter(&ptdev->base, &cookie))
> +       ACQUIRE(drm_dev_access, dev_guard)(&ptdev->base);
> +       if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
>                 return -ENODEV;
>
>         if (refcount_inc_not_zero(&vm->as.active_cnt))
> -               goto out_dev_exit;
> +               return 0;
>
>         /* As soon as active is called, we place the VM at the end of the=
 VM LRU.
>          * If something fails after that, the only downside is that this =
VM that
> @@ -809,14 +809,10 @@ int panthor_vm_active(struct panthor_vm *vm)
>         /* Make sure we don't race with lock/unlock_region() calls
>          * happening around VM bind operations.
>          */
> -       scoped_guard(mutex, &vm->op_lock) {
> -               guard(mutex)(&ptdev->mmu->as.slots_lock);
> -               ret =3D panthor_vm_active_locked(vm);
> -       }
> +       guard(mutex)(&vm->op_lock);
> +       guard(mutex)(&ptdev->mmu->as.slots_lock);
>
> -out_dev_exit:
> -       drm_dev_exit(cookie);
> -       return ret;
> +       return panthor_vm_active_locked(vm);
>  }
>
>  /**
> @@ -902,16 +898,15 @@ static size_t get_pgsize(u64 addr, size_t size, siz=
e_t *count)
>  static void panthor_vm_declare_unusable(struct panthor_vm *vm)
>  {
>         struct panthor_device *ptdev =3D vm->ptdev;
> -       int cookie;
>
>         if (vm->unusable)
>                 return;
>
>         vm->unusable =3D true;
>         guard(mutex)(&ptdev->mmu->as.slots_lock);
> -       if (vm->as.id >=3D 0 && drm_dev_enter(&ptdev->base, &cookie)) {
> -               panthor_mmu_as_disable(ptdev, vm->as.id, false);
> -               drm_dev_exit(cookie);
> +       if (vm->as.id >=3D 0) {
> +               scoped_guard(drm_dev_access, &ptdev->base)
> +                       panthor_mmu_as_disable(ptdev, vm->as.id, false);
>         }
>  }
>
> @@ -1983,12 +1978,8 @@ static void panthor_vm_free(struct drm_gpuvm *gpuv=
m)
>         scoped_guard(mutex, &vm->op_lock) {
>                 guard(mutex)(&ptdev->mmu->as.slots_lock);
>                 if (vm->as.id >=3D 0) {
> -                       int cookie;
> -
> -                       if (drm_dev_enter(&ptdev->base, &cookie)) {
> +                       scoped_guard(drm_dev_access, &ptdev->base)
>                                 panthor_mmu_as_disable(ptdev, vm->as.id, =
false);
> -                               drm_dev_exit(cookie);
> -                       }
>
>                         ptdev->mmu->as.slots[vm->as.id].vm =3D NULL;
>                         clear_bit(vm->as.id, &ptdev->mmu->as.alloc_mask);
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index d8cadd393fbe..9aa9941d2309 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2624,21 +2624,19 @@ static void tick_work(struct work_struct *work)
>         struct panthor_scheduler *sched =3D container_of(work, struct pan=
thor_scheduler,
>                                                       tick_work.work);
>         struct panthor_device *ptdev =3D sched->ptdev;
> -       int ret, cookie;
> +       int ret;
>
> -       if (!drm_dev_enter(&ptdev->base, &cookie))
> +       ACQUIRE(drm_dev_access, dev_guard)(&ptdev->base);
> +       if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
>                 return;
>
>         ret =3D panthor_device_resume_and_get(ptdev);
>         if (drm_WARN_ON(&ptdev->base, ret))
> -               goto out_dev_exit;
> +               return;
>
>         tick(sched);
>         pm_runtime_mark_last_busy(ptdev->base.dev);
>         pm_runtime_put_autosuspend(ptdev->base.dev);
> -
> -out_dev_exit:
> -       drm_dev_exit(cookie);
>  }
>
>  static int panthor_queue_eval_syncwait(struct panthor_group *group, u8 q=
ueue_idx)
>
> --
> 2.54.0
>
