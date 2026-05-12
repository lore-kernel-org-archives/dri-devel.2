Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559E9CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 21:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06E610E0CA;
	Tue, 12 May 2026 21:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VCZNZLa1";
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4481810E0CA
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 21:04:56 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-7bd87e5d8ffso75875567b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778619895; cv=none;
 d=google.com; s=arc-20240605;
 b=NsrHAX0wV/vARjDx32Uqj4joC/wLwXKu+d8tU76hbBckqj4VoY8ruZndJ7Rvc2dn8x
 BLw5j17nzygTHgp1xgAfoy84AMs6eSQ6wY87Kc1mUtLk38gO+OCJ6G34H+kiZohS1dCI
 F5hBg2twSi3uHiOTA3SHmHmd9UFzCpa0PsrJhNj8zUtNGx7OSNmQbdC5N/+qDubhqn71
 8SU6O2b+F28vsp2xCO8g+1rnfK/8FCHUCzelKs598XjufCjRamKxvUz+mDjNsoqI8DdZ
 GRynM2m1y//JAQIE4ZyZCypPaWodjCWosACyLAMGIhNRAp5eJ2Cz2kBNPCgwvQ2+O621
 VXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4YxdBYoJcw/c1Uir/C5tNz/NbCSv95QucMJy+blYUic=;
 fh=sUbYeuY77aU0jEcSmTkp2lLPXKKjP5lwc3BkRE1j//0=;
 b=XSaedDpSz6fckEUOik2YYa5L9FB+DRd50oxZc85EX/RSNLwTR0SZu/AcHlZLjm4eaA
 5gt3rqJDxBbuySAuZtYeOdwmIsDDGm2wLO632NA7/xN7WxXLP9zxYr/ZUBrmPSy6bTPn
 XXgJZpcPYUg2vP/TFciK95ZUxQ/OOC8c/3yv5ClgyKW7QoSbCj+QvGeSshH6BZQK9y7F
 2CiHudltWGi3Pt4sJct2iAFPhgauahS2t2JYHzBS6VomGfGjSMv0oI3Yq72YlUdP61uM
 AfDcrP0dHWBXabvW6uFFnAraXDvwWEv4RkUBR+buhnuJy6+HIks7bWCupIb3OqsxJCKE
 CDLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778619895; x=1779224695; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YxdBYoJcw/c1Uir/C5tNz/NbCSv95QucMJy+blYUic=;
 b=VCZNZLa1rXBvrzGk3pIPbIb02vCVaMwfuYyDphZHRP+92KJ4e018JHgj4+SP+UgmTl
 UuRxxg/ZOKJ20ZL4tuGCpN5l0w9YKOO1bML8tOHA90itXQLDOrAn3rY0Y+jKIGGscn+q
 UkiAulXojthCwafBem8yQR1Hor1HLG+LzBxZkYWfC+BOuNcw68P/fkX+8FALjNsHHuwe
 jQC/U00XGdEi+eKOnJ5mNyUltEiqDYJ/wiGmrkkY4HToiUNFW811Go+WIrFPGk/TdGZv
 hnuMBmG7u7AvWdgRuDd77Re3H20OueRvK0hsxdw9YBV4n/4B3xaOrrpO6Nv0XH/+hgtB
 +dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778619895; x=1779224695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4YxdBYoJcw/c1Uir/C5tNz/NbCSv95QucMJy+blYUic=;
 b=juy2dR2rH5LmnqeV2Q3iw3ZMwk8PYrB47LKqfh4AGOeIUBBjgJxJsh8BM3xDfxGlnm
 FbSWn35m9kjhIY1CEL7rJstpLczbysKFSSFF4exYHasj1LITyku7GaEAFiQaGd5XtW7S
 IzYt8jTwXTJDpYnQr8DTJ4EkXoJCHdeLyxXISL5LUoXe9/18Uvtmb5FotCvkbeZ7xKpJ
 F/vug422sXnricmDQsdXUl+C6fe0qdIlVI37oz0AaOl9C7vCXVY2Xnwy/JGbIuOlk3nj
 jgj8FUeGA01d9878hK+68pBbvdAdBJ0AggAG2EMfy4pjXskB2wU5KwoHzpZuTmZsWgAZ
 0ODQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8j59GpWJRRP3SfNPvV09TGskUTxhEivxUn9Wf4ERV1m3/z4bAkabK4empm4JQj/hEktnP+sg0qkRI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEhyf4kg4A4mjv2dbmcMQPvir17CCwJ2hKKBcSI3uCpKrI/Zz0
 B1Oqw/c63Q2vE37rBVh0IFbxHIMRYILIYgkBJuOCa1Yh9ooU9ZLaViHJ2mUEd36OMPgeAl4aFej
 7eoHosiJosI2Juk86HwMJB1K6JdbvAgk=
X-Gm-Gg: Acq92OHK5s//2RSUVE8BZg/RAa+EewM6ZcpO/NWQUjdvSlWMOGW9OItyNjM3JOPRdE8
 juLgYOccxTLC0iQijkhLU0uVRYcxXpHDrLfdy4QdGyCJ6Bk2oIMNlM9v57fSwz8lPALQtTMGb0s
 fZisY7ZbPplu4fQ53UVwVgP5bDtyVkngSyS2IYtcTkVwqrIUOnUYNSTv4l4IilnQo4WUEKOGCH1
 NRJrKmhs+xi2mYoFNrI3nj3OOZFzsfzTR/udtGX/WprKWYc3jXAonGNt2ah8OvU1HXxniHi2q72
 kLru/0XGrRECrLcrKKTujE2IONDA2BNo2TaYA3r49Osf3oV/OuUKJTrF3hgLhDEMpTwpPUfTKA=
 =
X-Received: by 2002:a05:690c:13:b0:7b3:b0a6:2c60 with SMTP id
 00721157ae682-7c50db32344mr49920477b3.1.1778619894807; Tue, 12 May 2026
 14:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 14:04:43 -0700
X-Gm-Features: AVHnY4L9z4EhRpbl9XQVzSyQoqVNXFWB0q3sqKtLlVqQnZeTFwf_YCQwOf-UrhE
Message-ID: <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] drm/panthor: Prepare the scheduler logic for FW
 events in IRQ context
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

On Tue, May 12, 2026 at 5:14=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> Add a specific spinlock for events processing, and force processing
> of events in the panthor_sched_report_fw_events() path rather than
> deferring it to a work item. We also fast-track fence signalling by
> making the job completion logic IRQ-safe.
>
> Note that it requires changing a couple spin_lock() into
> spin_lock_irqsave() when those are taken inside a events_lock section.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 332 +++++++++++++++-----------=
------
>  1 file changed, 155 insertions(+), 177 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 5b34032deff8..fbf76b59b7ef 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -177,18 +177,6 @@ struct panthor_scheduler {
>          */
>         struct work_struct sync_upd_work;
>
> -       /**
> -        * @fw_events_work: Work used to process FW events outside the in=
terrupt path.
> -        *
> -        * Even if the interrupt is threaded, we need any event processin=
g
> -        * that require taking the panthor_scheduler::lock to be processe=
d
> -        * outside the interrupt path so we don't block the tick logic wh=
en
> -        * it calls panthor_fw_{csg,wait}_wait_acks(). Since most of the
> -        * event processing requires taking this lock, we just delegate a=
ll
> -        * FW event processing to the scheduler workqueue.
> -        */
> -       struct work_struct fw_events_work;
> -
>         /**
>          * @fw_events: Bitmask encoding pending FW events.
>          */
If we process all fw events in the irq context, we can remove
fw_events as well. More on this below.
> @@ -254,6 +242,15 @@ struct panthor_scheduler {
>                 struct list_head waiting;
>         } groups;
>
> +       /**
> +        * @events_lock: Lock taken when processing events.
> +        *
> +        * This also needs to be taken when csg_slots are updated, to mak=
e sure
> +        * the event processing logic doesn't touch groups that have left=
 the CSG
> +        * slot.
> +        */
> +       spinlock_t events_lock;
> +
>         /**
>          * @csg_slots: FW command stream group slots.
It looks like read access can use either lock (process context) or
events_lock (irq context), while write access must use events_lock
(process context). Can we put that into the comment, or if makes
sense, enforce that with accessor functions?


>          */
> @@ -676,9 +673,6 @@ struct panthor_group {
>          */
>         struct panthor_kernel_bo *protm_suspend_buf;
>
> -       /** @sync_upd_work: Work used to check/signal job fences. */
> -       struct work_struct sync_upd_work;
> -
Can we make this a preparatory commit, where group_sync_upd_work is
replaced by group_check_job_completion?

Multiple things happen in this commit. I try to identify things that
can be separate commits. If this does not make sense, feel free to
ignore.

>         /** @tiler_oom_work: Work used to process tiler OOM events happen=
ing on this group. */
>         struct work_struct tiler_oom_work;
>
> @@ -999,7 +993,6 @@ static int
>  group_bind_locked(struct panthor_group *group, u32 csg_id)
>  {
>         struct panthor_device *ptdev =3D group->ptdev;
> -       struct panthor_csg_slot *csg_slot;
>         int ret;
>
>         lockdep_assert_held(&ptdev->scheduler->lock);
> @@ -1012,9 +1005,7 @@ group_bind_locked(struct panthor_group *group, u32 =
csg_id)
>         if (ret)
>                 return ret;
>
> -       csg_slot =3D &ptdev->scheduler->csg_slots[csg_id];
>         group_get(group);
> -       group->csg_id =3D csg_id;
>
>         /* Dummy doorbell allocation: doorbell is assigned to the group a=
nd
>          * all queues use the same doorbell.
> @@ -1026,7 +1017,10 @@ group_bind_locked(struct panthor_group *group, u32=
 csg_id)
>         for (u32 i =3D 0; i < group->queue_count; i++)
>                 group->queues[i]->doorbell_id =3D csg_id + 1;
>
> -       csg_slot->group =3D group;
> +       scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> +               ptdev->scheduler->csg_slots[csg_id].group =3D group;
> +               group->csg_id =3D csg_id;
> +       }
>
>         return 0;
>  }
> @@ -1041,7 +1035,6 @@ static int
>  group_unbind_locked(struct panthor_group *group)
>  {
>         struct panthor_device *ptdev =3D group->ptdev;
> -       struct panthor_csg_slot *slot;
>
>         lockdep_assert_held(&ptdev->scheduler->lock);
>
> @@ -1051,9 +1044,12 @@ group_unbind_locked(struct panthor_group *group)
>         if (drm_WARN_ON(&ptdev->base, group->state =3D=3D PANTHOR_CS_GROU=
P_ACTIVE))
>                 return -EINVAL;
>
> -       slot =3D &ptdev->scheduler->csg_slots[group->csg_id];
> +       scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> +               ptdev->scheduler->csg_slots[group->csg_id].group =3D NULL=
;
> +               group->csg_id =3D -1;
> +       }
> +
>         panthor_vm_idle(group->vm);
> -       group->csg_id =3D -1;
>
>         /* Tiler OOM events will be re-issued next time the group is sche=
duled. */
>         atomic_set(&group->tiler_oom, 0);
> @@ -1062,8 +1058,6 @@ group_unbind_locked(struct panthor_group *group)
>         for (u32 i =3D 0; i < group->queue_count; i++)
>                 group->queues[i]->doorbell_id =3D -1;
>
> -       slot->group =3D NULL;
> -
>         group_put(group);
>         return 0;
>  }
> @@ -1151,16 +1145,14 @@ queue_suspend_timeout_locked(struct panthor_queue=
 *queue)
>  static void
>  queue_suspend_timeout(struct panthor_queue *queue)
>  {
> -       spin_lock(&queue->fence_ctx.lock);
> +       guard(spinlock_irqsave)(&queue->fence_ctx.lock);
>         queue_suspend_timeout_locked(queue);
> -       spin_unlock(&queue->fence_ctx.lock);
>  }
>
>  static void
>  queue_resume_timeout(struct panthor_queue *queue)
>  {
> -       spin_lock(&queue->fence_ctx.lock);
> -
> +       guard(spinlock_irqsave)(&queue->fence_ctx.lock);
>         if (queue_timeout_is_suspended(queue)) {
>                 mod_delayed_work(queue->scheduler.timeout_wq,
>                                  &queue->timeout.work,
> @@ -1168,8 +1160,6 @@ queue_resume_timeout(struct panthor_queue *queue)
>
>                 queue->timeout.remaining =3D MAX_SCHEDULE_TIMEOUT;
>         }
> -
> -       spin_unlock(&queue->fence_ctx.lock);
>  }
>
>  /**
> @@ -1484,7 +1474,7 @@ cs_slot_process_fatal_event_locked(struct panthor_d=
evice *ptdev,
>         u32 fatal;
>         u64 info;
>
> -       lockdep_assert_held(&sched->lock);
> +       lockdep_assert_held(&sched->events_lock);
>
>         cs_iface =3D panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
>         fatal =3D cs_iface->output->fatal;
> @@ -1532,7 +1522,7 @@ cs_slot_process_fault_event_locked(struct panthor_d=
evice *ptdev,
>         u32 fault;
>         u64 info;
>
> -       lockdep_assert_held(&sched->lock);
> +       lockdep_assert_held(&sched->events_lock);
>
>         cs_iface =3D panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
>         fault =3D cs_iface->output->fault;
> @@ -1542,7 +1532,7 @@ cs_slot_process_fault_event_locked(struct panthor_d=
evice *ptdev,
>                 u64 cs_extract =3D queue->iface.output->extract;
>                 struct panthor_job *job;
>
> -               spin_lock(&queue->fence_ctx.lock);
> +               guard(spinlock_irqsave)(&queue->fence_ctx.lock);
>                 list_for_each_entry(job, &queue->fence_ctx.in_flight_jobs=
, node) {
>                         if (cs_extract >=3D job->ringbuf.end)
>                                 continue;
> @@ -1552,7 +1542,6 @@ cs_slot_process_fault_event_locked(struct panthor_d=
evice *ptdev,
>
>                         dma_fence_set_error(job->done_fence, -EINVAL);
>                 }
> -               spin_unlock(&queue->fence_ctx.lock);
>         }
>
>         if (group) {
> @@ -1682,7 +1671,7 @@ cs_slot_process_tiler_oom_event_locked(struct panth=
or_device *ptdev,
>         struct panthor_csg_slot *csg_slot =3D &sched->csg_slots[csg_id];
>         struct panthor_group *group =3D csg_slot->group;
>
> -       lockdep_assert_held(&sched->lock);
> +       lockdep_assert_held(&sched->events_lock);
>
>         if (drm_WARN_ON(&ptdev->base, !group))
>                 return;
> @@ -1703,7 +1692,7 @@ static bool cs_slot_process_irq_locked(struct panth=
or_device *ptdev,
>         struct panthor_fw_cs_iface *cs_iface;
>         u32 req, ack, events;
>
> -       lockdep_assert_held(&ptdev->scheduler->lock);
> +       lockdep_assert_held(&ptdev->scheduler->events_lock);
>
>         cs_iface =3D panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
>         req =3D cs_iface->input->req;
> @@ -1731,7 +1720,7 @@ static void csg_slot_process_idle_event_locked(stru=
ct panthor_device *ptdev, u32
>  {
>         struct panthor_scheduler *sched =3D ptdev->scheduler;
>
> -       lockdep_assert_held(&sched->lock);
> +       lockdep_assert_held(&sched->events_lock);
>
>         sched->might_have_idle_groups =3D true;
>
> @@ -1742,16 +1731,102 @@ static void csg_slot_process_idle_event_locked(s=
truct panthor_device *ptdev, u32
>         sched_queue_delayed_work(sched, tick, 0);
>  }
>
> +static void update_fdinfo_stats(struct panthor_job *job)
> +{
> +       struct panthor_group *group =3D job->group;
> +       struct panthor_queue *queue =3D group->queues[job->queue_idx];
> +       struct panthor_gpu_usage *fdinfo =3D &group->fdinfo.data;
> +       struct panthor_job_profiling_data *slots =3D queue->profiling.slo=
ts->kmap;
> +       struct panthor_job_profiling_data *data =3D &slots[job->profiling=
.slot];
> +
> +       scoped_guard(spinlock_irqsave, &group->fdinfo.lock) {
> +               if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES=
)
> +                       fdinfo->cycles +=3D data->cycles.after - data->cy=
cles.before;
> +               if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMEST=
AMP)
> +                       fdinfo->time +=3D data->time.after - data->time.b=
efore;
> +       }
> +}
> +
> +static bool queue_check_job_completion(struct panthor_queue *queue)
> +{
> +       struct panthor_syncobj_64b *syncobj =3D NULL;
> +       struct panthor_job *job, *job_tmp;
> +       bool cookie, progress =3D false;
> +       LIST_HEAD(done_jobs);
> +
> +       cookie =3D dma_fence_begin_signalling();
> +       scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock) {
> +               list_for_each_entry_safe(job, job_tmp, &queue->fence_ctx.=
in_flight_jobs, node) {
> +                       if (!syncobj) {
> +                               struct panthor_group *group =3D job->grou=
p;
> +
> +                               syncobj =3D group->syncobjs->kmap +
> +                                         (job->queue_idx * sizeof(*synco=
bj));
> +                       }
> +
> +                       if (syncobj->seqno < job->done_fence->seqno)
> +                               break;
> +
> +                       list_move_tail(&job->node, &done_jobs);
> +                       dma_fence_signal_locked(job->done_fence);
> +               }
> +
> +               if (list_empty(&queue->fence_ctx.in_flight_jobs)) {
> +                       /* If we have no job left, we cancel the timer, a=
nd reset remaining
> +                        * time to its default so it can be restarted nex=
t time
> +                        * queue_resume_timeout() is called.
> +                        */
> +                       queue_suspend_timeout_locked(queue);
> +
> +                       /* If there's no job pending, we consider it prog=
ress to avoid a
> +                        * spurious timeout if the timeout handler and th=
e sync update
> +                        * handler raced.
> +                        */
> +                       progress =3D true;
> +               } else if (!list_empty(&done_jobs)) {
> +                       queue_reset_timeout_locked(queue);
> +                       progress =3D true;
> +               }
> +       }
> +       dma_fence_end_signalling(cookie);
> +
> +       list_for_each_entry_safe(job, job_tmp, &done_jobs, node) {
> +               if (job->profiling.mask)
> +                       update_fdinfo_stats(job);
> +               list_del_init(&job->node);
> +               panthor_job_put(&job->base);
> +       }
> +
> +       return progress;
> +}
> +
> +static void group_check_job_completion(struct panthor_group *group)
> +{
> +       bool cookie;
> +       u32 queue_idx;
> +
> +       cookie =3D dma_fence_begin_signalling();
> +       for (queue_idx =3D 0; queue_idx < group->queue_count; queue_idx++=
) {
> +               struct panthor_queue *queue =3D group->queues[queue_idx];
> +
> +               if (!queue)
> +                       continue;
> +
> +               queue_check_job_completion(queue);
> +       }
> +       dma_fence_end_signalling(cookie);
> +}
> +
>  static void csg_slot_sync_update_locked(struct panthor_device *ptdev,
>                                         u32 csg_id)
>  {
>         struct panthor_csg_slot *csg_slot =3D &ptdev->scheduler->csg_slot=
s[csg_id];
>         struct panthor_group *group =3D csg_slot->group;
>
> -       lockdep_assert_held(&ptdev->scheduler->lock);
> +       lockdep_assert_held(&ptdev->scheduler->events_lock);
>
>         if (group)
> -               group_queue_work(group, sync_upd);
> +               group_check_job_completion(group);
>
>         sched_queue_work(ptdev->scheduler, sync_upd);
>  }
> @@ -1763,7 +1838,7 @@ csg_slot_process_progress_timer_event_locked(struct=
 panthor_device *ptdev, u32 c
>         struct panthor_csg_slot *csg_slot =3D &sched->csg_slots[csg_id];
>         struct panthor_group *group =3D csg_slot->group;
>
> -       lockdep_assert_held(&sched->lock);
> +       lockdep_assert_held(&sched->events_lock);
>
>         group =3D csg_slot->group;
>         if (!drm_WARN_ON(&ptdev->base, !group)) {
> @@ -1784,7 +1859,7 @@ static void sched_process_csg_irq_locked(struct pan=
thor_device *ptdev, u32 csg_i
>         struct panthor_fw_csg_iface *csg_iface;
>         u32 ring_cs_db_mask =3D 0;
>
> -       lockdep_assert_held(&ptdev->scheduler->lock);
> +       lockdep_assert_held(&ptdev->scheduler->events_lock);
>
>         if (drm_WARN_ON(&ptdev->base, csg_id >=3D ptdev->scheduler->csg_s=
lot_count))
>                 return;
> @@ -1842,7 +1917,7 @@ static void sched_process_idle_event_locked(struct =
panthor_device *ptdev)
>  {
>         struct panthor_fw_global_iface *glb_iface =3D panthor_fw_get_glb_=
iface(ptdev);
>
> -       lockdep_assert_held(&ptdev->scheduler->lock);
> +       lockdep_assert_held(&ptdev->scheduler->events_lock);
>
>         /* Acknowledge the idle event and schedule a tick. */
>         panthor_fw_update_reqs(glb_iface, req, glb_iface->output->ack, GL=
B_IDLE);
> @@ -1858,7 +1933,7 @@ static void sched_process_global_irq_locked(struct =
panthor_device *ptdev)
>         struct panthor_fw_global_iface *glb_iface =3D panthor_fw_get_glb_=
iface(ptdev);
>         u32 req, ack, evts;
>
> -       lockdep_assert_held(&ptdev->scheduler->lock);
> +       lockdep_assert_held(&ptdev->scheduler->events_lock);
>
>         req =3D READ_ONCE(glb_iface->input->req);
>         ack =3D READ_ONCE(glb_iface->output->ack);
> @@ -1868,30 +1943,6 @@ static void sched_process_global_irq_locked(struct=
 panthor_device *ptdev)
>                 sched_process_idle_event_locked(ptdev);
>  }
>
> -static void process_fw_events_work(struct work_struct *work)
> -{
> -       struct panthor_scheduler *sched =3D container_of(work, struct pan=
thor_scheduler,
> -                                                     fw_events_work);
> -       u32 events =3D atomic_xchg(&sched->fw_events, 0);
> -       struct panthor_device *ptdev =3D sched->ptdev;
> -
> -       mutex_lock(&sched->lock);
> -
> -       if (events & JOB_INT_GLOBAL_IF) {
> -               sched_process_global_irq_locked(ptdev);
> -               events &=3D ~JOB_INT_GLOBAL_IF;
> -       }
> -
> -       while (events) {
> -               u32 csg_id =3D ffs(events) - 1;
> -
> -               sched_process_csg_irq_locked(ptdev, csg_id);
> -               events &=3D ~BIT(csg_id);
> -       }
> -
> -       mutex_unlock(&sched->lock);
> -}
> -
>  /**
>   * panthor_sched_report_fw_events() - Report FW events to the scheduler.
>   * @ptdev: Device.
> @@ -1902,8 +1953,19 @@ void panthor_sched_report_fw_events(struct panthor=
_device *ptdev, u32 events)
This can be renamed to panthor_sched_handle_fw_events.

>         if (!ptdev->scheduler)
>                 return;
>
> -       atomic_or(events, &ptdev->scheduler->fw_events);
> -       sched_queue_work(ptdev->scheduler, fw_events);
> +       guard(spinlock_irqsave)(&ptdev->scheduler->events_lock);
> +
> +       if (events & JOB_INT_GLOBAL_IF) {
> +               sched_process_global_irq_locked(ptdev);
> +               events &=3D ~JOB_INT_GLOBAL_IF;
> +       }
> +
> +       while (events) {
> +               u32 csg_id =3D ffs(events) - 1;
> +
> +               sched_process_csg_irq_locked(ptdev, csg_id);
> +               events &=3D ~BIT(csg_id);
> +       }
This handles all fw events in the irq context. Are there concerns that
it may take too long? I might be wrong, but it seems possible to
handle only CSG_SYNC_UPDATE and defer the rest as before.

>  }
>
>  static const char *fence_get_driver_name(struct dma_fence *fence)
> @@ -2136,7 +2198,9 @@ tick_ctx_init(struct panthor_scheduler *sched,
>                  * CSG IRQs, so we can flag the faulty queue.
>                  */
>                 if (panthor_vm_has_unhandled_faults(group->vm)) {
> -                       sched_process_csg_irq_locked(ptdev, i);
> +                       scoped_guard(spinlock_irqsave, &sched->events_loc=
k) {
> +                               sched_process_csg_irq_locked(ptdev, i);
> +                       }
>
>                         /* No fatal fault reported, flag all queues as fa=
ulty. */
>                         if (!group->fatal_queues)
> @@ -2183,13 +2247,13 @@ group_term_post_processing(struct panthor_group *=
group)
>                 if (!queue)
>                         continue;
>
> -               spin_lock(&queue->fence_ctx.lock);
> -               list_for_each_entry_safe(job, tmp, &queue->fence_ctx.in_f=
light_jobs, node) {
> -                       list_move_tail(&job->node, &faulty_jobs);
> -                       dma_fence_set_error(job->done_fence, err);
> -                       dma_fence_signal_locked(job->done_fence);
> +               scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock) {
> +                       list_for_each_entry_safe(job, tmp, &queue->fence_=
ctx.in_flight_jobs, node) {
> +                               list_move_tail(&job->node, &faulty_jobs);
> +                               dma_fence_set_error(job->done_fence, err)=
;
> +                               dma_fence_signal_locked(job->done_fence);
> +                       }
>                 }
> -               spin_unlock(&queue->fence_ctx.lock);
>
>                 /* Manually update the syncobj seqno to unblock waiters. =
*/
>                 syncobj =3D group->syncobjs->kmap + (i * sizeof(*syncobj)=
);
> @@ -2336,8 +2400,10 @@ tick_ctx_apply(struct panthor_scheduler *sched, st=
ruct panthor_sched_tick_ctx *c
>                          * any pending interrupts before we start the new
>                          * group.
>                          */
> -                       if (group->csg_id >=3D 0)
> +                       if (group->csg_id >=3D 0) {
> +                               guard(spinlock_irqsave)(&sched->events_lo=
ck);
>                                 sched_process_csg_irq_locked(ptdev, group=
->csg_id);
> +                       }
>
>                         group_unbind_locked(group);
>                 }
> @@ -2902,10 +2968,12 @@ void panthor_sched_suspend(struct panthor_device =
*ptdev)
>                         u32 csg_id =3D ffs(slot_mask) - 1;
>                         struct panthor_csg_slot *csg_slot =3D &sched->csg=
_slots[csg_id];
>
> -                       if (flush_caches_failed)
> +                       if (flush_caches_failed) {
>                                 csg_slot->group->state =3D PANTHOR_CS_GRO=
UP_TERMINATED;
> -                       else
> +                       } else {
> +                               guard(spinlock_irqsave)(&sched->events_lo=
ck);
>                                 csg_slot_sync_update_locked(ptdev, csg_id=
);
> +                       }
>
>                         slot_mask &=3D ~BIT(csg_id);
>                 }
> @@ -2920,8 +2988,10 @@ void panthor_sched_suspend(struct panthor_device *=
ptdev)
>
>                 group_get(group);
>
> -               if (group->csg_id >=3D 0)
> +               if (group->csg_id >=3D 0) {
> +                       guard(spinlock_irqsave)(&sched->events_lock);
>                         sched_process_csg_irq_locked(ptdev, group->csg_id=
);
> +               }
>
>                 group_unbind_locked(group);
>
> @@ -3005,22 +3075,6 @@ void panthor_sched_post_reset(struct panthor_devic=
e *ptdev, bool reset_failed)
>         }
>  }
>
> -static void update_fdinfo_stats(struct panthor_job *job)
> -{
> -       struct panthor_group *group =3D job->group;
> -       struct panthor_queue *queue =3D group->queues[job->queue_idx];
> -       struct panthor_gpu_usage *fdinfo =3D &group->fdinfo.data;
> -       struct panthor_job_profiling_data *slots =3D queue->profiling.slo=
ts->kmap;
> -       struct panthor_job_profiling_data *data =3D &slots[job->profiling=
.slot];
> -
> -       scoped_guard(spinlock, &group->fdinfo.lock) {
> -               if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES=
)
> -                       fdinfo->cycles +=3D data->cycles.after - data->cy=
cles.before;
> -               if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMEST=
AMP)
> -                       fdinfo->time +=3D data->time.after - data->time.b=
efore;
> -       }
> -}
> -
>  void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
>  {
>         struct panthor_group_pool *gpool =3D pfile->groups;
> @@ -3032,7 +3086,7 @@ void panthor_fdinfo_gather_group_samples(struct pan=
thor_file *pfile)
>
>         xa_lock(&gpool->xa);
>         xa_for_each_marked(&gpool->xa, i, group, GROUP_REGISTERED) {
> -               guard(spinlock)(&group->fdinfo.lock);
> +               guard(spinlock_irqsave)(&group->fdinfo.lock);
>                 pfile->stats.cycles +=3D group->fdinfo.data.cycles;
>                 pfile->stats.time +=3D group->fdinfo.data.time;
>                 group->fdinfo.data.cycles =3D 0;
> @@ -3041,80 +3095,6 @@ void panthor_fdinfo_gather_group_samples(struct pa=
nthor_file *pfile)
>         xa_unlock(&gpool->xa);
>  }
>
> -static bool queue_check_job_completion(struct panthor_queue *queue)
> -{
> -       struct panthor_syncobj_64b *syncobj =3D NULL;
> -       struct panthor_job *job, *job_tmp;
> -       bool cookie, progress =3D false;
> -       LIST_HEAD(done_jobs);
> -
> -       cookie =3D dma_fence_begin_signalling();
> -       spin_lock(&queue->fence_ctx.lock);
> -       list_for_each_entry_safe(job, job_tmp, &queue->fence_ctx.in_fligh=
t_jobs, node) {
> -               if (!syncobj) {
> -                       struct panthor_group *group =3D job->group;
> -
> -                       syncobj =3D group->syncobjs->kmap +
> -                                 (job->queue_idx * sizeof(*syncobj));
> -               }
> -
> -               if (syncobj->seqno < job->done_fence->seqno)
> -                       break;
> -
> -               list_move_tail(&job->node, &done_jobs);
> -               dma_fence_signal_locked(job->done_fence);
> -       }
> -
> -       if (list_empty(&queue->fence_ctx.in_flight_jobs)) {
> -               /* If we have no job left, we cancel the timer, and reset=
 remaining
> -                * time to its default so it can be restarted next time
> -                * queue_resume_timeout() is called.
> -                */
> -               queue_suspend_timeout_locked(queue);
> -
> -               /* If there's no job pending, we consider it progress to =
avoid a
> -                * spurious timeout if the timeout handler and the sync u=
pdate
> -                * handler raced.
> -                */
> -               progress =3D true;
> -       } else if (!list_empty(&done_jobs)) {
> -               queue_reset_timeout_locked(queue);
> -               progress =3D true;
> -       }
> -       spin_unlock(&queue->fence_ctx.lock);
> -       dma_fence_end_signalling(cookie);
> -
> -       list_for_each_entry_safe(job, job_tmp, &done_jobs, node) {
> -               if (job->profiling.mask)
> -                       update_fdinfo_stats(job);
> -               list_del_init(&job->node);
> -               panthor_job_put(&job->base);
> -       }
> -
> -       return progress;
> -}
> -
> -static void group_sync_upd_work(struct work_struct *work)
> -{
> -       struct panthor_group *group =3D
> -               container_of(work, struct panthor_group, sync_upd_work);
> -       u32 queue_idx;
> -       bool cookie;
> -
> -       cookie =3D dma_fence_begin_signalling();
> -       for (queue_idx =3D 0; queue_idx < group->queue_count; queue_idx++=
) {
> -               struct panthor_queue *queue =3D group->queues[queue_idx];
> -
> -               if (!queue)
> -                       continue;
> -
> -               queue_check_job_completion(queue);
> -       }
> -       dma_fence_end_signalling(cookie);
> -
> -       group_put(group);
> -}
> -
>  struct panthor_job_ringbuf_instrs {
>         u64 buffer[MAX_INSTRS_PER_JOB];
>         u32 count;
> @@ -3346,9 +3326,8 @@ queue_run_job(struct drm_sched_job *sched_job)
>         job->ringbuf.end =3D job->ringbuf.start + (instrs.count * sizeof(=
u64));
>
>         panthor_job_get(&job->base);
> -       spin_lock(&queue->fence_ctx.lock);
> -       list_add_tail(&job->node, &queue->fence_ctx.in_flight_jobs);
> -       spin_unlock(&queue->fence_ctx.lock);
> +       scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock)
> +               list_add_tail(&job->node, &queue->fence_ctx.in_flight_job=
s);
>
>         /* Make sure the ring buffer is updated before the INSERT
>          * register.
> @@ -3683,7 +3662,6 @@ int panthor_group_create(struct panthor_file *pfile=
,
>         INIT_LIST_HEAD(&group->wait_node);
>         INIT_LIST_HEAD(&group->run_node);
>         INIT_WORK(&group->term_work, group_term_work);
> -       INIT_WORK(&group->sync_upd_work, group_sync_upd_work);
>         INIT_WORK(&group->tiler_oom_work, group_tiler_oom_work);
>         INIT_WORK(&group->release_work, group_release_work);
>
> @@ -4054,7 +4032,6 @@ void panthor_sched_unplug(struct panthor_device *pt=
dev)
>         struct panthor_scheduler *sched =3D ptdev->scheduler;
>
>         disable_delayed_work_sync(&sched->tick_work);
> -       disable_work_sync(&sched->fw_events_work);
>         disable_work_sync(&sched->sync_upd_work);
>
>         mutex_lock(&sched->lock);
> @@ -4139,7 +4116,8 @@ int panthor_sched_init(struct panthor_device *ptdev=
)
>         sched->tick_period =3D msecs_to_jiffies(10);
>         INIT_DELAYED_WORK(&sched->tick_work, tick_work);
>         INIT_WORK(&sched->sync_upd_work, sync_upd_work);
> -       INIT_WORK(&sched->fw_events_work, process_fw_events_work);
> +
> +       spin_lock_init(&sched->events_lock);
>
>         ret =3D drmm_mutex_init(&ptdev->base, &sched->lock);
>         if (ret)
>
> --
> 2.54.0
>
