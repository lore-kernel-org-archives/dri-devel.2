Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8A4CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D920810E0A1;
	Wed, 13 May 2026 08:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bT1ziAC7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3F010E4CB
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778660986;
 bh=J4GmWp8+bAqKCfXO4jRo/eL+JP5ct0uQ3Mnev8kKU8U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bT1ziAC7o6p/Muk7CK5w23D0DWe9FYQ5TgmYQ5YrpXqUh353M5SF5cm8FYyBGJgsX
 hL93h8Vk9gXbp+LnJubBWIuca0Puz94Rlzg7a7UFCLreOsvaru8bFIvtuYhYP6inwh
 I5ft2lESwNhe+5FOEUnKzXHzF8wOdEDhYJM0KSEd3zgJqhmJ4r3mxgqrUtzI4mKLpV
 2tjjidEYSiteuINteFpCtnsNrwbkkJv7RKEAsOSwtXixb371PlS5ejjt0ayegXh2U4
 aKRpA3947bTPsWIQx320v2kjLB97qZhp1LWwKO0eZlVYsQt+hYJikCqDFgINvx0zdE
 CvMT3gpAeagCw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7482017E1318;
 Wed, 13 May 2026 10:29:46 +0200 (CEST)
Date: Wed, 13 May 2026 10:29:41 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] drm/panthor: Prepare the scheduler logic for
 FW events in IRQ context
Message-ID: <20260513102941.7321cbc3@fedora>
In-Reply-To: <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
 <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 12 May 2026 14:04:43 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Tue, May 12, 2026 at 5:14=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > Add a specific spinlock for events processing, and force processing
> > of events in the panthor_sched_report_fw_events() path rather than
> > deferring it to a work item. We also fast-track fence signalling by
> > making the job completion logic IRQ-safe.
> >
> > Note that it requires changing a couple spin_lock() into
> > spin_lock_irqsave() when those are taken inside a events_lock section.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_sched.c | 332 +++++++++++++++---------=
--------
> >  1 file changed, 155 insertions(+), 177 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/=
panthor/panthor_sched.c
> > index 5b34032deff8..fbf76b59b7ef 100644
> > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > @@ -177,18 +177,6 @@ struct panthor_scheduler {
> >          */
> >         struct work_struct sync_upd_work;
> >
> > -       /**
> > -        * @fw_events_work: Work used to process FW events outside the =
interrupt path.
> > -        *
> > -        * Even if the interrupt is threaded, we need any event process=
ing
> > -        * that require taking the panthor_scheduler::lock to be proces=
sed
> > -        * outside the interrupt path so we don't block the tick logic =
when
> > -        * it calls panthor_fw_{csg,wait}_wait_acks(). Since most of the
> > -        * event processing requires taking this lock, we just delegate=
 all
> > -        * FW event processing to the scheduler workqueue.
> > -        */
> > -       struct work_struct fw_events_work;
> > -
> >         /**
> >          * @fw_events: Bitmask encoding pending FW events.
> >          */ =20
> If we process all fw events in the irq context, we can remove
> fw_events as well. More on this below.

Oops, forgot to remove this field, indeed.

> > @@ -254,6 +242,15 @@ struct panthor_scheduler {
> >                 struct list_head waiting;
> >         } groups;
> >
> > +       /**
> > +        * @events_lock: Lock taken when processing events.
> > +        *
> > +        * This also needs to be taken when csg_slots are updated, to m=
ake sure
> > +        * the event processing logic doesn't touch groups that have le=
ft the CSG
> > +        * slot.
> > +        */
> > +       spinlock_t events_lock;
> > +
> >         /**
> >          * @csg_slots: FW command stream group slots. =20
> It looks like read access can use either lock (process context) or
> events_lock (irq context), while write access must use events_lock
> (process context). Can we put that into the comment, or if makes
> sense, enforce that with accessor functions?

You're right. I'll mention that updates to csg_slots[] must be done
with both the ::lock and ::events_lock held, while reads can be done
with any of them held.

>=20
>=20
> >          */
> > @@ -676,9 +673,6 @@ struct panthor_group {
> >          */
> >         struct panthor_kernel_bo *protm_suspend_buf;
> >
> > -       /** @sync_upd_work: Work used to check/signal job fences. */
> > -       struct work_struct sync_upd_work;
> > - =20
> Can we make this a preparatory commit, where group_sync_upd_work is
> replaced by group_check_job_completion?

I'll try to split that up.

>=20
> Multiple things happen in this commit. I try to identify things that
> can be separate commits. If this does not make sense, feel free to
> ignore.
>=20
> >         /** @tiler_oom_work: Work used to process tiler OOM events happ=
ening on this group. */
> >         struct work_struct tiler_oom_work;
> >

[...]

> >  /**
> >   * panthor_sched_report_fw_events() - Report FW events to the schedule=
r.
> >   * @ptdev: Device.
> > @@ -1902,8 +1953,19 @@ void panthor_sched_report_fw_events(struct panth=
or_device *ptdev, u32 events) =20
> This can be renamed to panthor_sched_handle_fw_events.

It's not quite handling events though. For most of them, it's really
just deferring the processing to work items, SYNC_UPDATE is the
exception.

>=20
> >         if (!ptdev->scheduler)
> >                 return;
> >
> > -       atomic_or(events, &ptdev->scheduler->fw_events);
> > -       sched_queue_work(ptdev->scheduler, fw_events);
> > +       guard(spinlock_irqsave)(&ptdev->scheduler->events_lock);
> > +
> > +       if (events & JOB_INT_GLOBAL_IF) {
> > +               sched_process_global_irq_locked(ptdev);
> > +               events &=3D ~JOB_INT_GLOBAL_IF;
> > +       }
> > +
> > +       while (events) {
> > +               u32 csg_id =3D ffs(events) - 1;
> > +
> > +               sched_process_csg_irq_locked(ptdev, csg_id);
> > +               events &=3D ~BIT(csg_id);
> > +       } =20
> This handles all fw events in the irq context. Are there concerns that
> it may take too long? I might be wrong, but it seems possible to
> handle only CSG_SYNC_UPDATE and defer the rest as before.

I started with just the SYNC_UPDATE processing done in the hard-irq
context, but after auditing the other stuff done in the handler, I
realized it's basically just deferring all actual processing to work
items. Yes, there's the overhead of demuxing the events from the
ack/req regs, but part of this is already done to get to SYNC_UPDATE
anyway, so at this point we're probably better off demuxing everything
and scheduling works for all kind of events.

I also compared the perfs between the two approaches (though I didn't
do as much testing as I did with the new version, so I might have
missed something), and it didn't seem to matter at all, because the
interrupts we receive the most are SYNC_UPDATE and IDLE events, and
those are at the same level.
