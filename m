Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F48FCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 13:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CF310E0CD;
	Mon, 18 May 2026 13:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CPpkdV/k";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF3610E0CD
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779111921;
 bh=3fXGzUFVcsGwRV30ExI0hcHMvtmIxeOvqjIIjwODIwI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CPpkdV/kE+otX3aHzBhIWCNLFoQN7pvKPnk3ASp+IJpKVnG2LjLQ8eDAMMcfg6Tem
 cSzalqlWvBFSdKDjcTOGTpNDBLJhhNZi/ssV2EkzrJbhvQAcPB2aDgOP63zMzEsE3O
 xCRPz1PJkXLq5XzCaaIFIKffLNP9VlG27O5u0ND5YKQVFHFMsvMZ1AujfYXFZom5X+
 SuIa9mhfWlDdRWd7U3plYZmSMjlPILd/YFL/cY/ME3aQInRaStdk9+CAkd4jmWSXkY
 myalBE63bacXEeHoIHGbWglcGQtXI5dSStXkQQWHRB2PP7LQ0KUFUn56zwbvsmqy0C
 AGx97Av5kyCzA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 50C5C17E0234;
 Mon, 18 May 2026 15:45:21 +0200 (CEST)
Date: Mon, 18 May 2026 15:45:16 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] drm/panthor: Prepare the scheduler logic for
 FW events in IRQ context
Message-ID: <20260518154516.65ba8592@fedora>
In-Reply-To: <CAPaKu7SJbeRwN7_S5_ciC6sSf_MM_4s7-iJS8aqh=ispBZBf2w@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
 <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
 <20260513102941.7321cbc3@fedora>
 <CAPaKu7SJbeRwN7_S5_ciC6sSf_MM_4s7-iJS8aqh=ispBZBf2w@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 13 May 2026 10:47:28 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> > >
> > > Multiple things happen in this commit. I try to identify things that
> > > can be separate commits. If this does not make sense, feel free to
> > > ignore.
> > >  
> > > >         /** @tiler_oom_work: Work used to process tiler OOM events happening on this group. */
> > > >         struct work_struct tiler_oom_work;
> > > >  
> >
> > [...]
> >  
> > > >  /**
> > > >   * panthor_sched_report_fw_events() - Report FW events to the scheduler.
> > > >   * @ptdev: Device.
> > > > @@ -1902,8 +1953,19 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)  
> > > This can be renamed to panthor_sched_handle_fw_events.  
> >
> > It's not quite handling events though. For most of them, it's really
> > just deferring the processing to work items, SYNC_UPDATE is the
> > exception.  
> panthor_sched_report_fw_events no longer just queues
> process_fw_events_work. It processes fw events immediately. If
> "handle" is not the right verb, perhaps we can go with "process".

I guess "demux" would be more accurate, but do we need to rename this
function in the first place? I mean, panthor_sched_report_fw_events()
doesn't imply that events are processed/handled, it just reflects the
fact FW events are reported to the scheduler. Up to the scheduler to
do what it wants with this piece of information (process some of them
immediately, defer the processing for others, etc).

> 
> 
> >  
> > >  
> > > >         if (!ptdev->scheduler)
> > > >                 return;
> > > >
> > > > -       atomic_or(events, &ptdev->scheduler->fw_events);
> > > > -       sched_queue_work(ptdev->scheduler, fw_events);
> > > > +       guard(spinlock_irqsave)(&ptdev->scheduler->events_lock);
> > > > +
> > > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > > +               sched_process_global_irq_locked(ptdev);
> > > > +               events &= ~JOB_INT_GLOBAL_IF;
> > > > +       }
> > > > +
> > > > +       while (events) {
> > > > +               u32 csg_id = ffs(events) - 1;
> > > > +
> > > > +               sched_process_csg_irq_locked(ptdev, csg_id);
> > > > +               events &= ~BIT(csg_id);
> > > > +       }  
> > > This handles all fw events in the irq context. Are there concerns that
> > > it may take too long? I might be wrong, but it seems possible to
> > > handle only CSG_SYNC_UPDATE and defer the rest as before.  
> >
> > I started with just the SYNC_UPDATE processing done in the hard-irq
> > context, but after auditing the other stuff done in the handler, I
> > realized it's basically just deferring all actual processing to work
> > items. Yes, there's the overhead of demuxing the events from the
> > ack/req regs, but part of this is already done to get to SYNC_UPDATE
> > anyway, so at this point we're probably better off demuxing everything
> > and scheduling works for all kind of events.
> >
> > I also compared the perfs between the two approaches (though I didn't
> > do as much testing as I did with the new version, so I might have
> > missed something), and it didn't seem to matter at all, because the
> > interrupts we receive the most are SYNC_UPDATE and IDLE events, and
> > those are at the same level.  
> Looking at ftrace irq events, when there is one active csg,
> panthor-job takes 6us (median) / 17us (95%) / 27us (slowest).
> 
> I don't have a good sense if that's considered normal in hardirq. But
> if that is ever an issue, and if the majority of the time is spent in
> CSG_SYNC_UPDATE anyway, we can always revert the last patch to move
> processing to threaded handler.

Actually, the threaded -> hard transition (patch 9) is where the perf
gain is.
