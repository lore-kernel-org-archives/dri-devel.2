Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AE9CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 21:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF6710EC2A;
	Tue, 12 May 2026 21:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qZOqqvHQ";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD7AF10EC2A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 21:16:37 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-7c52e49d978so16294227b3.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778620597; cv=none;
 d=google.com; s=arc-20240605;
 b=E7o0RtKu4CjdQQD6oS3987UwIafEiY/ucqfSHlRllnyquCuhnHojNGCeTbgXsqwX8w
 vE6VFZSkTZcSylyviK3RIKH4g+ZrkyW0FvK7HTLM0g7AWY8ctyOwDR9ZgMDjRPk/KnM6
 HyfaYIoIIrKipjPg/JLmyGLMW5SJEaNoDwba+iTSoTfUGkKobV7hZ2D1WqHTFJL4if51
 Pr5/CJUVa34TGedZ9zrEt4IVGtUb8giONx4yQxljayW1NvE96osNesMk2VEUQejTREsx
 CTPqc5ogGM06yEXjpF1qWrErDi3GrcL90tAsKoirWIi//qDAmC2YLipHi0duVjsUQ4xn
 obnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TxBqnUuDuiqzlZTnvnagUm76nX17lf+L3SSU4UVWQZ8=;
 fh=Kn068brm5hzpKTkkvCkCEa66SB0lE3wKUKwci7jOJnk=;
 b=NaB2v6sKUqdlec1CjpSlAx8oz7wMfmRvbziBHDBQCbRlS1g+56jQ0TQlSO/fuOsNW/
 +ZsNE5ZDX3eI5SkNiSFQd2V4hu4uolkx10I3lLO6/iAv4207TBNw2Kd2frR44Gq68ALL
 PIUUkjRaOK6RjvzxqGc0bdmydTQHF3QDvO6KJOc0Qp9eERk7YWEfB6HTBeDmlQ/bNJ61
 DrZTJmcvjx2vePZT6jLa7fbJt6j6A8FlYd4IisfpYAI+pOw+/EIqcyyRovRoiKCw4KOt
 3Mt4rJ0QG9DrbOrI2wDHhfpqx6rdU/b4aNs0EhQlT5fzMHYwOcd+VUBj1JhQkguCHbmq
 TeAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778620597; x=1779225397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxBqnUuDuiqzlZTnvnagUm76nX17lf+L3SSU4UVWQZ8=;
 b=qZOqqvHQPDNPY6STb+xSqEGPKRoxQHPOfeUJ3rVplsGsG4whxQ2hutK2kVY5+wzrsl
 orXPyJrpEWk9m59p6M8uzGKdZqxCCqzVjj2blEPKxLJpJhaFuEoJr3O8zD+Bt2GW+mYI
 UGPSJ5eRZp/Ng11cU0XhFz8+FqYDo0umKtCj9OseIM9t3Gx49w3U9hyYEAgeaV8t7Vyr
 jLOtQz5F3OJkz2OBp+dynEx14WDjdtsDAtMHJP2EKLGZ9f/jW7WyW81aR3gME6Z63LJb
 D8qVxi7fwzMjd/mG9ikkZXbdlObYNo2LgEVc3KtE1mihRw7q8yW53afOnPYjbZQRgPzF
 nfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778620597; x=1779225397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TxBqnUuDuiqzlZTnvnagUm76nX17lf+L3SSU4UVWQZ8=;
 b=ZD2/6F/Fm+LOAv/lmxgT+mqGt+hq+qbisquF79dow1LxRVFZm1hLtWt3xRQZ4/FXLZ
 kn9DPSUvsulS0WlTJ8+PyrMcmoYLuDTp4PdWCEAvjIvLBcEVtUSelV8gvGHA05PbAcdz
 y0aY2RHlQEEQhWHIqw+zegpdW5Wy9wGw2hmVE05MqxewfVDQCCJQIHTGhlieH158y267
 eXALqaIKrBW7AR9i6HOJ6/si/nWNkc3FrfY49HlJ3jz3ox/Qc2/KBp1vQ5DRPVMFc5yG
 QcxI4v9D6XOECULv79BVEKlvzCWsCrE1//MrytuGmP+Cj9xtXRHodF0QapULI01gFSJw
 H0FQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ85yC9t1zrq/FuK8ebFfiJRx6z5ItyRaGpPR4Ip7GhiEOpBQJgLQhstfl0ex3OE5oEk3h9xo54HwHw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxdb+nT1qVBWqNJ3pajZ7E+Bdgmth7CFV6CQM4m3LcNkT5XzciX
 CjLrjplIMTrfylNyP1oZYuhW+LrItvc0VnQwN+T7mNOPlsWzK33YhvfRwtx/VCCXmsjEVxX5ADS
 N0Hz04VxUEOV7rwTxzxgUQeI8B+Czn0M=
X-Gm-Gg: Acq92OEZr2auSdP4odu94zWaUxqKVmH5DtZnGlyyxGMG9cSFH7My7BwW86Ad9Ihp3dK
 1BoGTckX3uOldKCAATGxWjH3nnZfodNOPUU2t1PCftF2Oiby0fQ3vG7bEdcKxCvsQVogZxPj4fX
 B6XoiyDJkWCkJoD8bqHqHe/j9VtrULHSEvX80Zno0E/Gj8bSxtS9Mcs41AW3kpIPIDoY/HCKtRo
 8gvYc8oexSor1viNfi4ONNti3d2SXA5qdBoOLYk9ZNV9YLWP/hhVKrsmlY/ltqYosehyzRQ4n+i
 i6mJqqxTgwqmMFNbs93p5ztY0YVOPQ+3/Px6gkkZTDcT7YAInOdQxwIrnEuVI4DW23+r80cSOA=
 =
X-Received: by 2002:a05:690c:e147:10b0:7bd:98c7:abcd with SMTP id
 00721157ae682-7c6ac1bc428mr5189337b3.38.1778620596656; Tue, 12 May 2026
 14:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-7-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-7-95c614a739cb@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 14:16:24 -0700
X-Gm-Features: AVHnY4JBz063WkzD-TLx4rzv2Rixdj6IpEzOnpViST53zCUHvS1ITLN3GvSH21g
Message-ID: <CAPaKu7S0Ci4jgLtg5wcVfJsdagoD4UzTMicfJD8otBpv6P270g@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] drm/panthor: Automate CSG IRQ processing at
 group unbind time
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Make the sched_process_csg_irq_locked() call part of
> group_unbind_locked() so we don't have to manually call it in
> tick_ctx_apply()/panthor_sched_suspend().
>
> This implies moving group_[un]bind_locked() around to avoid a
> forward declaration.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 176 +++++++++++++++-----------=
------
>  1 file changed, 82 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index fbf76b59b7ef..6c5ba747ae45 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -982,86 +982,6 @@ group_get(struct panthor_group *group)
>         return group;
>  }
>
> -/**
> - * group_bind_locked() - Bind a group to a group slot
> - * @group: Group.
> - * @csg_id: Slot.
> - *
> - * Return: 0 on success, a negative error code otherwise.
> - */
> -static int
> -group_bind_locked(struct panthor_group *group, u32 csg_id)
> -{
> -       struct panthor_device *ptdev =3D group->ptdev;
> -       int ret;
> -
> -       lockdep_assert_held(&ptdev->scheduler->lock);
> -
> -       if (drm_WARN_ON(&ptdev->base, group->csg_id !=3D -1 || csg_id >=
=3D MAX_CSGS ||
> -                       ptdev->scheduler->csg_slots[csg_id].group))
> -               return -EINVAL;
> -
> -       ret =3D panthor_vm_active(group->vm);
> -       if (ret)
> -               return ret;
> -
> -       group_get(group);
> -
> -       /* Dummy doorbell allocation: doorbell is assigned to the group a=
nd
> -        * all queues use the same doorbell.
> -        *
> -        * TODO: Implement LRU-based doorbell assignment, so the most oft=
en
> -        * updated queues get their own doorbell, thus avoiding useless c=
hecks
> -        * on queues belonging to the same group that are rarely updated.
> -        */
> -       for (u32 i =3D 0; i < group->queue_count; i++)
> -               group->queues[i]->doorbell_id =3D csg_id + 1;
> -
> -       scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> -               ptdev->scheduler->csg_slots[csg_id].group =3D group;
> -               group->csg_id =3D csg_id;
> -       }
> -
> -       return 0;
> -}
> -
> -/**
> - * group_unbind_locked() - Unbind a group from a slot.
> - * @group: Group to unbind.
> - *
> - * Return: 0 on success, a negative error code otherwise.
> - */
> -static int
> -group_unbind_locked(struct panthor_group *group)
> -{
> -       struct panthor_device *ptdev =3D group->ptdev;
> -
> -       lockdep_assert_held(&ptdev->scheduler->lock);
> -
> -       if (drm_WARN_ON(&ptdev->base, group->csg_id < 0 || group->csg_id =
>=3D MAX_CSGS))
> -               return -EINVAL;
> -
> -       if (drm_WARN_ON(&ptdev->base, group->state =3D=3D PANTHOR_CS_GROU=
P_ACTIVE))
> -               return -EINVAL;
> -
> -       scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> -               ptdev->scheduler->csg_slots[group->csg_id].group =3D NULL=
;
> -               group->csg_id =3D -1;
> -       }
> -
> -       panthor_vm_idle(group->vm);
> -
> -       /* Tiler OOM events will be re-issued next time the group is sche=
duled. */
> -       atomic_set(&group->tiler_oom, 0);
> -       cancel_work(&group->tiler_oom_work);
> -
> -       for (u32 i =3D 0; i < group->queue_count; i++)
> -               group->queues[i]->doorbell_id =3D -1;
> -
> -       group_put(group);
> -       return 0;
> -}
> -
>  static bool
>  group_is_idle(struct panthor_group *group)
>  {
> @@ -1968,6 +1888,88 @@ void panthor_sched_report_fw_events(struct panthor=
_device *ptdev, u32 events)
>         }
>  }
>
> +/**
> + * group_bind_locked() - Bind a group to a group slot
> + * @group: Group.
> + * @csg_id: Slot.
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +static int
> +group_bind_locked(struct panthor_group *group, u32 csg_id)
> +{
> +       struct panthor_device *ptdev =3D group->ptdev;
> +       int ret;
> +
> +       lockdep_assert_held(&ptdev->scheduler->lock);
> +
> +       if (drm_WARN_ON(&ptdev->base, group->csg_id !=3D -1 || csg_id >=
=3D MAX_CSGS ||
> +                       ptdev->scheduler->csg_slots[csg_id].group))
> +               return -EINVAL;
> +
> +       ret =3D panthor_vm_active(group->vm);
> +       if (ret)
> +               return ret;
> +
> +       group_get(group);
> +
> +       /* Dummy doorbell allocation: doorbell is assigned to the group a=
nd
> +        * all queues use the same doorbell.
> +        *
> +        * TODO: Implement LRU-based doorbell assignment, so the most oft=
en
> +        * updated queues get their own doorbell, thus avoiding useless c=
hecks
> +        * on queues belonging to the same group that are rarely updated.
> +        */
> +       for (u32 i =3D 0; i < group->queue_count; i++)
> +               group->queues[i]->doorbell_id =3D csg_id + 1;
> +
> +       scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> +               ptdev->scheduler->csg_slots[csg_id].group =3D group;
> +               group->csg_id =3D csg_id;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * group_unbind_locked() - Unbind a group from a slot.
> + * @group: Group to unbind.
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +static int
> +group_unbind_locked(struct panthor_group *group)
> +{
> +       struct panthor_device *ptdev =3D group->ptdev;
> +
> +       lockdep_assert_held(&ptdev->scheduler->lock);
> +
> +       if (drm_WARN_ON(&ptdev->base, group->csg_id < 0 || group->csg_id =
>=3D MAX_CSGS))
> +               return -EINVAL;
> +
> +       if (drm_WARN_ON(&ptdev->base, group->state =3D=3D PANTHOR_CS_GROU=
P_ACTIVE))
> +               return -EINVAL;
> +
> +       scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> +               /* Process all pending IRQs before returning the slot. */
> +               sched_process_csg_irq_locked(ptdev, group->csg_id);
> +               ptdev->scheduler->csg_slots[group->csg_id].group =3D NULL=
;
> +               group->csg_id =3D -1;
> +       }
> +
> +       panthor_vm_idle(group->vm);
> +
> +       /* Tiler OOM events will be re-issued next time the group is sche=
duled. */
> +       atomic_set(&group->tiler_oom, 0);
> +       cancel_work(&group->tiler_oom_work);
> +
> +       for (u32 i =3D 0; i < group->queue_count; i++)
> +               group->queues[i]->doorbell_id =3D -1;
> +
> +       group_put(group);
> +       return 0;
> +}
> +
>  static const char *fence_get_driver_name(struct dma_fence *fence)
>  {
>         return "panthor";
> @@ -2396,15 +2398,6 @@ tick_ctx_apply(struct panthor_scheduler *sched, st=
ruct panthor_sched_tick_ctx *c
>         /* Unbind evicted groups. */
>         for (prio =3D PANTHOR_CSG_PRIORITY_COUNT - 1; prio >=3D 0; prio--=
) {
>                 list_for_each_entry(group, &ctx->old_groups[prio], run_no=
de) {
> -                       /* This group is gone. Process interrupts to clea=
r
> -                        * any pending interrupts before we start the new
> -                        * group.
> -                        */
> -                       if (group->csg_id >=3D 0) {
> -                               guard(spinlock_irqsave)(&sched->events_lo=
ck);
> -                               sched_process_csg_irq_locked(ptdev, group=
->csg_id);
> -                       }
> -
>                         group_unbind_locked(group);
>                 }
>         }
> @@ -2988,11 +2981,6 @@ void panthor_sched_suspend(struct panthor_device *=
ptdev)
>
>                 group_get(group);
>
> -               if (group->csg_id >=3D 0) {
> -                       guard(spinlock_irqsave)(&sched->events_lock);
> -                       sched_process_csg_irq_locked(ptdev, group->csg_id=
);
> -               }
> -
>                 group_unbind_locked(group);
>
>                 drm_WARN_ON(&group->ptdev->base, !list_empty(&group->run_=
node));
>
> --
> 2.54.0
>
