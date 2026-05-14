Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1681CD37AC
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 422BC10F2F5;
	Thu, 14 May 2026 18:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kW3mcS2x";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C57910F2F5
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:40:06 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-651bf695701so10690210d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 11:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778784005; cv=none;
 d=google.com; s=arc-20240605;
 b=BUNu7kM23DVkRnDi4LcmjJhKVxkPHbLRmLTgBd5R+gpsL2VYIvAA/yyiUalNpT5orC
 MMYB/V14tRfnXJeHns7Bn3krf13QIu6h4INgXy2YgeqH4yPdYtC5CuqUqFghVTeeUgQk
 rdTYUHiatRboxqJxE8gKLnQyMUciCLNYAlhR5wsi6b/fCKVO4sXMwZfXrOryPgZYVxS0
 ZSc6tV0vh3YGRdD31iEiO+VgPkEQHqkO1dgwviWgoJYwdflTWEiH+JH23ZzqAbBYELlJ
 3DDt31FUPxuXoZo3ZlzzPEyHz1J7n135O007YYt0KSEwMSSiUahs9kih3X403T40RkK8
 Qnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FpoaXEJLcSJc84yZ2vARDAmkfQwqX2rRItHaBW+mwvI=;
 fh=6pMM5WhjySkqSYBdKeuHCFziXoPrj7aRI2f6lDrVZSE=;
 b=hxBZn5EUwWaeb0uDEirjriS25DkpK/CY79UTBksSiIJo8O9KCTIykjEtzr4Ax3v3xZ
 J1PX4vWQvHbYZWJ9lgIb8VEOjDLvk2ingA7R8AwDkwy/hHOf7AHnZltbYrBM5sBY3W0C
 vH9TzUpqefacUcsKMXB6KI+pc+7FEsyKeL0bq5S1ciqvELstBFOwrSwIrliyhKYsMQBP
 YKGGbNCfPkrkgRvuoj2i5ymYtZxEMUgCFbMcsjlB2XymQeK78VzIuYpLkdboByt6Nkxj
 sQpHkF1oWMgxyQ+VIRTrGliH1iW/ffZ7THfvtKAbHpkBYRa1fJPBMejp1FVmSRfIq5EE
 xgZQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778784005; x=1779388805; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpoaXEJLcSJc84yZ2vARDAmkfQwqX2rRItHaBW+mwvI=;
 b=kW3mcS2xK+va+GAsziw39zcPRdPsGOLprIBOg/iujS9PdqVbZScAaUTzxKKBPN76kN
 PnEGfxV9OUawaSWPZixOWAwxUx2gMUVUs0aaAZHzDUKTRyVH9VF7gWNkZOJzrwk0QzwN
 4E3GdfgA0cb7rBISUATo916+KW2VNlpUG3vEE6ExR7PM7Qa4tmLQuL+xBCrgPUdldNEZ
 MM7r3znaU9Fm6qixuSKljnqNXsAMhAK0Si/wo3kKHlTMIvugqhAYNKRnoUW2OCnqgQ8h
 8aqegmIo/7y3gEX/Jh5xWCkc0EzHaqvqjpfV+jigZJ8huRLV0uksKG1rxvXBv9kH5OZX
 d6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778784005; x=1779388805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FpoaXEJLcSJc84yZ2vARDAmkfQwqX2rRItHaBW+mwvI=;
 b=BrXiaTLCKx9Cxkv5QBqwmEC0bWKjThPCTmTYmby22lpX5d2OBLyYwMRnfM4wbdjetI
 TskbQXF+mvI+qX7bTUYNHPiIl57L46W71H1xL76R/5U9H7v8jR5SAeswRVJwyMIQpnyw
 rCii6eRD4XATMERaUcJwXl0qGIweHt2VSY70dtdeUQNf5zWrgEeICuc03buSAV0L5WN8
 rebVLV0WAqu4MaxlS+iDxZRPXW5yWebs4Kogt2wJKs12AKLOGZpfIOY4pkUr3hJK0Mc6
 y3ROFlnhYFY4brHxzK5ZKH4ihFL06IvzyzNmYS1PrXstUn/UbL8jxcBbflFoFsfduuUu
 Rr7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qPcGcULR0dc1ZvyGcn4Agh3hF7+LBKZ61cMZDUWFmkCXN5M4iDKAOYbR/LjfAE8zGIVyeJTz2t6k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxu+eCn6rKXMl/Wthca9J7qYmtDCy6pjA2WyxXQj/n+TbyX1kAd
 jeKa7R+Mb7XOmbR5WqFjPLXwxWJT6+GUKgQvXnjUIUKetRxcMxNww5cuwwGRrhlyjFjjr+YQvEF
 x4buBASAPi4lMszHVJkX/AR1MuBw9Rmw=
X-Gm-Gg: Acq92OFW9J+/gY/DdFfofUx2HAhAVLQzcQLPTrw743xZQEZYLkl/wtLXov8uEuvQMfx
 OHYC9cvJuUvuWaRZEVRUdDjhjqJkyZI/imNu0jjP9bBMR0dKmQBgCp5RmE1P3H0K0PXF7EwF4WV
 aWZ86MGYrzZsNMHQGL2en3t33ou6LYc/vvWB+nmUQVrev41EbtM17jCvgiTrgFErPeeaYnoA9GJ
 rQKHprLoIQl8eavl4SYortaZ2VNDnZ/ibnkKMo15JDoyGqLPZlKach5xc/7tHXmi8haD39FE2hN
 7+zOzFOINV19rRRHmY7GRpOWzd4/GI3pffpq7Ecmnq0tCWgPK8bkUKCY7Gb6xGIGfUUQJQKr9fv
 0Y4O/NkCB
X-Received: by 2002:a05:690c:c504:b0:7b8:926e:3ef4 with SMTP id
 00721157ae682-7c9599a3c98mr6741257b3.17.1778784005522; Thu, 14 May 2026
 11:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-6-f2d8c15a97ce@collabora.com>
In-Reply-To: <20260513-panthor-guard-refactor-v1-6-f2d8c15a97ce@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 14 May 2026 11:39:54 -0700
X-Gm-Features: AVHnY4K0-CnWJWVhrI1GvcjAaDfSNRBL6O_alT4g9naFYZIyIVIX0tJzKPjAXlk
Message-ID: <CAPaKu7Sttfu4xapUwnk6WzskHVEqNuc8NOfpZch-Yp-OGd6bww@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/panthor: Add a new guard for our custom
 resume_and_get() PM helper
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

On Wed, May 13, 2026 at 9:59=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Overload the already existing pm_runtime_active_auto_try_enabled guard
> with our custom guard that force the state to suspened (and thus clear
> the runtime_error) in case the resume fails.
>
> Once done, we can replace the existing places where manual
> panthor_device_resume_and_get()+pm_runtime_put_autosuspend() were
> done by guards.
This patch also replaces a pm_runtime_put call by
pm_runtime_put_autosuspend, and removes redundant
pm_runtime_mark_last_busy calls. Can we add another patch for the
functionality change first?

>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 10 +++++++---
>  drivers/gpu/drm/panthor/panthor_drv.c    |  4 ++--
>  drivers/gpu/drm/panthor/panthor_sched.c  | 11 ++++-------
>  3 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index 1aaf06df875b..51527d2e2f77 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -407,9 +407,10 @@ int panthor_device_mmap_io(struct panthor_device *pt=
dev,
>  int panthor_device_resume(struct device *dev);
>  int panthor_device_suspend(struct device *dev);
>
> -static inline int panthor_device_resume_and_get(struct panthor_device *p=
tdev)
> +static inline int panthor_device_resume_and_get(struct device *dev)
>  {
> -       int ret =3D pm_runtime_resume_and_get(ptdev->base.dev);
> +       struct panthor_device *ptdev =3D dev_get_drvdata(dev);
> +       int ret =3D pm_runtime_resume_and_get(dev);
>
>         /* If the resume failed, we need to clear the runtime_error, whic=
h
>          * can done by forcing the RPM state to suspended. If multiple
> @@ -424,11 +425,14 @@ static inline int panthor_device_resume_and_get(str=
uct panthor_device *ptdev)
>          * something we can live with.
>          */
>         if (ret && atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) =3D=
=3D 1)
> -               pm_runtime_set_suspended(ptdev->base.dev);
> +               pm_runtime_set_suspended(dev);
>
>         return ret;
>  }
>
> +DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled_or_suspend,
> +                 panthor_device_resume_and_get(_T), _RET =3D=3D 0)
> +
>  enum drm_panthor_exception_type {
>         DRM_PANTHOR_EXCEPTION_OK =3D 0x00,
>         DRM_PANTHOR_EXCEPTION_TERMINATED =3D 0x04,
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index 789ddc0ff7ef..f2d60ff00896 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -824,7 +824,8 @@ static int panthor_query_timestamp_info(struct pantho=
r_device *ptdev,
>                 (flags & DRM_PANTHOR_TIMESTAMP_DURATION) ||
>                 (timestamp_types >=3D 2);
>
> -       ret =3D panthor_device_resume_and_get(ptdev);
> +       ACQUIRE(pm_runtime_active_auto_try_enabled_or_suspend, pm_guard)(=
ptdev->base.dev);
> +       ret =3D ACQUIRE_ERR(pm_runtime_active_auto_try_enabled_or_suspend=
, &pm_guard);
>         if (ret)
>                 return ret;
>
> @@ -894,7 +895,6 @@ static int panthor_query_timestamp_info(struct pantho=
r_device *ptdev,
>                 arg->cpu_timestamp_nsec =3D 0;
>         }
>
> -       pm_runtime_put(ptdev->base.dev);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 9aa9941d2309..9afa38e87fc9 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2630,13 +2630,12 @@ static void tick_work(struct work_struct *work)
>         if (ACQUIRE_ERR(drm_dev_access, &dev_guard))
>                 return;
>
> -       ret =3D panthor_device_resume_and_get(ptdev);
> +       ACQUIRE(pm_runtime_active_auto_try_enabled_or_suspend, pm_guard)(=
ptdev->base.dev);
> +       ret =3D ACQUIRE_ERR(pm_runtime_active_auto_try_enabled_or_suspend=
, &pm_guard);
>         if (drm_WARN_ON(&ptdev->base, ret))
>                 return;
>
>         tick(sched);
> -       pm_runtime_mark_last_busy(ptdev->base.dev);
> -       pm_runtime_put_autosuspend(ptdev->base.dev);
>  }
>
>  static int panthor_queue_eval_syncwait(struct panthor_group *group, u8 q=
ueue_idx)
> @@ -3359,7 +3358,8 @@ queue_run_job(struct drm_sched_job *sched_job)
>                 return dma_fence_get(job->done_fence);
>         }
>
> -       ret =3D panthor_device_resume_and_get(ptdev);
> +       ACQUIRE(pm_runtime_active_auto_try_enabled_or_suspend, pm_guard)(=
ptdev->base.dev);
> +       ret =3D ACQUIRE_ERR(pm_runtime_active_auto_try_enabled_or_suspend=
, &pm_guard);
>         if (drm_WARN_ON(&ptdev->base, ret))
>                 return ERR_PTR(ret);
>
> @@ -3367,9 +3367,6 @@ queue_run_job(struct drm_sched_job *sched_job)
>                 done_fence =3D queue_run_job_locked(job);
>         }
>
> -       pm_runtime_mark_last_busy(ptdev->base.dev);
> -       pm_runtime_put_autosuspend(ptdev->base.dev);
> -
>         return done_fence;
>  }
>
>
> --
> 2.54.0
>
