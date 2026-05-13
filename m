Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645C5CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C550310E0C4;
	Wed, 13 May 2026 17:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bmidRSrK";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214AC10E0C4
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:47:42 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-64e87a81639so7980342d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778694461; cv=none;
 d=google.com; s=arc-20240605;
 b=PaObuef01FJzHYKbmRU8a84AJ/sI620GIY8mluVg2azsK0gAosMv/bKXMoNJzl9g59
 Bpj8Rr43Njk0d4VQ60HPiZKvETh+NcRmYZl4FIa5CjMg7zZ0dqalde3BJ2/G7z0YZXA6
 ZYE5Oqyi2y8ldo3Lw8PcWcVtvopd/W6KoiuYiMonBg/t6rrJpRqlB/180WxZyQlTHC0T
 y15AFUjBAhbYwl3CRmSE4AwoymlxuDxR6Q9v8Y10LbuUmre70aPsnS3/HiOQm4hxlTsy
 d1ZIJuVbyRqklO+AOWXN7/KYyD29lDYkAOBSvgkI5mKaIcBtxDCkp6e9xrI8tkK6sC+/
 1nXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E8yuX59kfejnIRJt26SZjWAS5h3QbQ7AdPxaul2qld0=;
 fh=xeFhDjFcYqMOtpXKXECcVZA/ARUluBtUzRoG6ajwze8=;
 b=LuDo3Z3DCwqFGfKmOpGnkrrvcw3hkaZfyp5ZLXOgU48oPMrWIUyKAzc666mVegPDYU
 N+hQlaJX/HCmVTgYqizq4l8QmXTTHIDJ82WRfgkfsFNtiPALlq4jnaky2VPPdakAD6JD
 iY+p1cQbX5dH7vvwylIC+wGBqaHyxysU8r6T2sb5D8QOckGEImuLH4MzkjeYyEKRMeGf
 wXBeBDB7k410Ot0kNqSutJCQ8QdCRIOoZKMSItqe9ffBNnVDA7YTcHeqLnDoY9T209qh
 PQDfZyqdnkwO3O4I1P7DOqCIm6Vy8BmwSfZ1V+CfsZA4fFZYJnABCuBQMznfCg2KcNxh
 25Sw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778694461; x=1779299261; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8yuX59kfejnIRJt26SZjWAS5h3QbQ7AdPxaul2qld0=;
 b=bmidRSrKYk10PeXkmR22NR/MK03tpug82s90A+n8trc4QJgf3W2nAVUcDLiDb/+mkd
 +pu+WXBTPKiDuEEaW1bX/vYoB9tBdHFZ3iW2DOqlf3/wxQXHIRdG3un5MeajdsX4+Rqn
 I+33TwggJTpa7/7ddosP1ORrBgK2D4+GUwNLg8xc1RdOMQBeXkOUSReAt0YRWOjaRFp4
 fRGYEKeb7UW71WqWi49Q/OQKRw9pXyL4MKLvWtK0feUE2n9ZA6LZATaa63Tvh2FZAh2t
 LQI14+EnGs03hn96KTy+/uVWQHDMQuXJ10wQTm0oZ45xxQfGDg33SHruGRvHpDgb2zQO
 vSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694461; x=1779299261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E8yuX59kfejnIRJt26SZjWAS5h3QbQ7AdPxaul2qld0=;
 b=FAxkJ4L67pwEqL7vgGhFdK+6uSwdbgfa3SmpRY0EXebtCyiTtpXG29bK9JKPxUW93y
 ca9rZ9QGVx21Icsy6lkLOv8+mHkIwHhZtsFpA5nFe2tnIczc/6iB3dPf33zDCFu7P1ti
 UKLyTInA9Oaoy/uWAiCouAhbZnTaQTU434kRUFksmb9hdpfh/dJU5jSNOkZOdgRm0B4O
 mVnaYHaxgRxzcFzE4obFLep1gByr8xNYV2np7N7dIW3UpdB7eu7pyxIAeZBS1sF7ok1f
 9hHPoa1a9FjINKTSDQsxgMm3QBKqgqZQLBf+1KSJlI/LQV8S08nk3Oz6+qYVb7J3WJ43
 O48g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4Irg6nHWzv4AsDJ+jdWwymX/qFVXTBe3LQ2bSwQbfD7ln7yJs7+qevSm5GkWb49jjOHSnJBsw310=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgXUGHg4J7bBaTwFCG7VY/5eDxasse7ba4lDV1X70d5IHu0a19
 K8ULmKTp/2IiVb+x8N9FD2iY3wL+NZF5jonPCrqL6WVfsGeLkeNcIvgi9P3Shb+3KhctrfvWaUr
 fTcN2jmAtcChpSVMQjaXZ2965Z1ZuZF8=
X-Gm-Gg: Acq92OFR0jqG09+ZOYLFL6paHc9hjohsN8CyLdOT5lNSrk13k7FRVvL4i3gDQMfkOCO
 a6U6tA+ZsKf9MiwZfRhimB/lw231h2xz0hzCsbMj1kXqCiKbyGDnp/jIvlHCYdA20twP6k0tziG
 30PHoF0q+QRgDDe7DfygO1od1EQXQA4DNouR/fmSCmUv9MVByGG352f2/xRpVkKpOHETeT9OAz3
 0TVzkMP/1jsHUUSZHqPBgkOBWqDjLGHz5pqVPQI1vezM+mRSKafH/BBd0d/RyK+wKfpklO0dOPS
 EHNmdSwvHBxEQ97ZUbcQt8LeVsUeH95anDD0xSTaM4aajAlMjstabjYQsnUMy+0S2vOdGm+MLw=
 =
X-Received: by 2002:a05:690c:e28a:10b0:7ac:ff2:4603 with SMTP id
 00721157ae682-7c6da604661mr28849237b3.20.1778694460761; Wed, 13 May 2026
 10:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
 <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
 <20260513102941.7321cbc3@fedora>
In-Reply-To: <20260513102941.7321cbc3@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 13 May 2026 10:47:28 -0700
X-Gm-Features: AVHnY4L-rdCr_kJCwD8MOeZTdhsuAe6gPGzBMaS-anWZLtVfMvWJRtiRF-cyohs
Message-ID: <CAPaKu7SJbeRwN7_S5_ciC6sSf_MM_4s7-iJS8aqh=ispBZBf2w@mail.gmail.com>
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

On Wed, May 13, 2026 at 1:29=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 May 2026 14:04:43 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > On Tue, May 12, 2026 at 5:14=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > Add a specific spinlock for events processing, and force processing
> > > of events in the panthor_sched_report_fw_events() path rather than
> > > deferring it to a work item. We also fast-track fence signalling by
> > > making the job completion logic IRQ-safe.
> > >
> > > Note that it requires changing a couple spin_lock() into
> > > spin_lock_irqsave() when those are taken inside a events_lock section=
.
> > >
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_sched.c | 332 +++++++++++++++-------=
----------
> > >  1 file changed, 155 insertions(+), 177 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/dr=
m/panthor/panthor_sched.c
> > > index 5b34032deff8..fbf76b59b7ef 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > > @@ -177,18 +177,6 @@ struct panthor_scheduler {
> > >          */
> > >         struct work_struct sync_upd_work;
> > >
> > > -       /**
> > > -        * @fw_events_work: Work used to process FW events outside th=
e interrupt path.
> > > -        *
> > > -        * Even if the interrupt is threaded, we need any event proce=
ssing
> > > -        * that require taking the panthor_scheduler::lock to be proc=
essed
> > > -        * outside the interrupt path so we don't block the tick logi=
c when
> > > -        * it calls panthor_fw_{csg,wait}_wait_acks(). Since most of =
the
> > > -        * event processing requires taking this lock, we just delega=
te all
> > > -        * FW event processing to the scheduler workqueue.
> > > -        */
> > > -       struct work_struct fw_events_work;
> > > -
> > >         /**
> > >          * @fw_events: Bitmask encoding pending FW events.
> > >          */
> > If we process all fw events in the irq context, we can remove
> > fw_events as well. More on this below.
>
> Oops, forgot to remove this field, indeed.
>
> > > @@ -254,6 +242,15 @@ struct panthor_scheduler {
> > >                 struct list_head waiting;
> > >         } groups;
> > >
> > > +       /**
> > > +        * @events_lock: Lock taken when processing events.
> > > +        *
> > > +        * This also needs to be taken when csg_slots are updated, to=
 make sure
> > > +        * the event processing logic doesn't touch groups that have =
left the CSG
> > > +        * slot.
> > > +        */
> > > +       spinlock_t events_lock;
> > > +
> > >         /**
> > >          * @csg_slots: FW command stream group slots.
> > It looks like read access can use either lock (process context) or
> > events_lock (irq context), while write access must use events_lock
> > (process context). Can we put that into the comment, or if makes
> > sense, enforce that with accessor functions?
>
> You're right. I'll mention that updates to csg_slots[] must be done
> with both the ::lock and ::events_lock held, while reads can be done
> with any of them held.
>
> >
> >
> > >          */
> > > @@ -676,9 +673,6 @@ struct panthor_group {
> > >          */
> > >         struct panthor_kernel_bo *protm_suspend_buf;
> > >
> > > -       /** @sync_upd_work: Work used to check/signal job fences. */
> > > -       struct work_struct sync_upd_work;
> > > -
> > Can we make this a preparatory commit, where group_sync_upd_work is
> > replaced by group_check_job_completion?
>
> I'll try to split that up.
>
> >
> > Multiple things happen in this commit. I try to identify things that
> > can be separate commits. If this does not make sense, feel free to
> > ignore.
> >
> > >         /** @tiler_oom_work: Work used to process tiler OOM events ha=
ppening on this group. */
> > >         struct work_struct tiler_oom_work;
> > >
>
> [...]
>
> > >  /**
> > >   * panthor_sched_report_fw_events() - Report FW events to the schedu=
ler.
> > >   * @ptdev: Device.
> > > @@ -1902,8 +1953,19 @@ void panthor_sched_report_fw_events(struct pan=
thor_device *ptdev, u32 events)
> > This can be renamed to panthor_sched_handle_fw_events.
>
> It's not quite handling events though. For most of them, it's really
> just deferring the processing to work items, SYNC_UPDATE is the
> exception.
panthor_sched_report_fw_events no longer just queues
process_fw_events_work. It processes fw events immediately. If
"handle" is not the right verb, perhaps we can go with "process".


>
> >
> > >         if (!ptdev->scheduler)
> > >                 return;
> > >
> > > -       atomic_or(events, &ptdev->scheduler->fw_events);
> > > -       sched_queue_work(ptdev->scheduler, fw_events);
> > > +       guard(spinlock_irqsave)(&ptdev->scheduler->events_lock);
> > > +
> > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > +               sched_process_global_irq_locked(ptdev);
> > > +               events &=3D ~JOB_INT_GLOBAL_IF;
> > > +       }
> > > +
> > > +       while (events) {
> > > +               u32 csg_id =3D ffs(events) - 1;
> > > +
> > > +               sched_process_csg_irq_locked(ptdev, csg_id);
> > > +               events &=3D ~BIT(csg_id);
> > > +       }
> > This handles all fw events in the irq context. Are there concerns that
> > it may take too long? I might be wrong, but it seems possible to
> > handle only CSG_SYNC_UPDATE and defer the rest as before.
>
> I started with just the SYNC_UPDATE processing done in the hard-irq
> context, but after auditing the other stuff done in the handler, I
> realized it's basically just deferring all actual processing to work
> items. Yes, there's the overhead of demuxing the events from the
> ack/req regs, but part of this is already done to get to SYNC_UPDATE
> anyway, so at this point we're probably better off demuxing everything
> and scheduling works for all kind of events.
>
> I also compared the perfs between the two approaches (though I didn't
> do as much testing as I did with the new version, so I might have
> missed something), and it didn't seem to matter at all, because the
> interrupts we receive the most are SYNC_UPDATE and IDLE events, and
> those are at the same level.
Looking at ftrace irq events, when there is one active csg,
panthor-job takes 6us (median) / 17us (95%) / 27us (slowest).

I don't have a good sense if that's considered normal in hardirq. But
if that is ever an issue, and if the majority of the time is spent in
CSG_SYNC_UPDATE anyway, we can always revert the last patch to move
processing to threaded handler.
