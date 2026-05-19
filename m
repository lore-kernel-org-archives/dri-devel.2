Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D929CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A6310E36D;
	Tue, 19 May 2026 07:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SxO7UfFG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2959810E36D
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779177238;
 bh=vClakjfLpeKfPX+t8Mbbx6mqbu6pS2+qipfmFfQCr24=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SxO7UfFGDPEbOKZwrvX5FjF0/PigBaYrTj1DWHrAWDvIjZrYI+kHn1wDG8rWxwV+P
 K0pnfdS54BTnddZvYQOUx7btRCfqyyVStrssqUV/3j0AKy7R87L0f3yALTqo/Uv20u
 R2bGgFT9m2De0tiRXqt8wHbAnQlaEAp/2F2CJIDHDpZwGA8ZTgS3lUMO8Ox3nnzDCX
 aVA4e4moOtBzQf9mb7KvEEf0NLla7lmbaQ1/if7iBEbC9poMIrUMtX2TroYHSCHzHt
 erYaZ0fucP93SCsOmTSm441BH3Fa1TAv7RCDwlRiryEeXKh0sHPUQjxaQYPXe3P0Qv
 RzOV4O9UWiBWw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5DDBF17E02A3;
 Tue, 19 May 2026 09:53:58 +0200 (CEST)
Date: Tue, 19 May 2026 09:53:54 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] drm/panthor: Prepare the scheduler logic for
 FW events in IRQ context
Message-ID: <20260519095354.123f8b61@fedora>
In-Reply-To: <CAPaKu7RL5Hs2jXcj_v0F99xsM1Vo-U5iTzBvQ3Sev=dRiwBcuw@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
 <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
 <20260513102941.7321cbc3@fedora>
 <CAPaKu7SJbeRwN7_S5_ciC6sSf_MM_4s7-iJS8aqh=ispBZBf2w@mail.gmail.com>
 <20260518154516.65ba8592@fedora>
 <CAPaKu7RL5Hs2jXcj_v0F99xsM1Vo-U5iTzBvQ3Sev=dRiwBcuw@mail.gmail.com>
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

On Mon, 18 May 2026 16:33:20 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:


> > >
> > >  
> > > >  
> > > > >  
> > > > > >         if (!ptdev->scheduler)
> > > > > >                 return;
> > > > > >
> > > > > > -       atomic_or(events, &ptdev->scheduler->fw_events);
> > > > > > -       sched_queue_work(ptdev->scheduler, fw_events);
> > > > > > +       guard(spinlock_irqsave)(&ptdev->scheduler->events_lock);
> > > > > > +
> > > > > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > > > > +               sched_process_global_irq_locked(ptdev);
> > > > > > +               events &= ~JOB_INT_GLOBAL_IF;
> > > > > > +       }
> > > > > > +
> > > > > > +       while (events) {
> > > > > > +               u32 csg_id = ffs(events) - 1;
> > > > > > +
> > > > > > +               sched_process_csg_irq_locked(ptdev, csg_id);
> > > > > > +               events &= ~BIT(csg_id);
> > > > > > +       }  
> > > > > This handles all fw events in the irq context. Are there concerns that
> > > > > it may take too long? I might be wrong, but it seems possible to
> > > > > handle only CSG_SYNC_UPDATE and defer the rest as before.  
> > > >
> > > > I started with just the SYNC_UPDATE processing done in the hard-irq
> > > > context, but after auditing the other stuff done in the handler, I
> > > > realized it's basically just deferring all actual processing to work
> > > > items. Yes, there's the overhead of demuxing the events from the
> > > > ack/req regs, but part of this is already done to get to SYNC_UPDATE
> > > > anyway, so at this point we're probably better off demuxing everything
> > > > and scheduling works for all kind of events.
> > > >
> > > > I also compared the perfs between the two approaches (though I didn't
> > > > do as much testing as I did with the new version, so I might have
> > > > missed something), and it didn't seem to matter at all, because the
> > > > interrupts we receive the most are SYNC_UPDATE and IDLE events, and
> > > > those are at the same level.  
> > > Looking at ftrace irq events, when there is one active csg,
> > > panthor-job takes 6us (median) / 17us (95%) / 27us (slowest).
> > >
> > > I don't have a good sense if that's considered normal in hardirq. But
> > > if that is ever an issue, and if the majority of the time is spent in
> > > CSG_SYNC_UPDATE anyway, we can always revert the last patch to move
> > > processing to threaded handler.  
> >
> > Actually, the threaded -> hard transition (patch 9) is where the perf
> > gain is.  
> hardirq is even more timely for sure. For our use case, the threaded
> handler is RT and is also good enough.

Yeah, true. I forgot you were forcing RT priority on threaded handlers.
Anyway, let's stick to hardirqs for now, and revisit it if it proves to
be too much work done in irq context.
