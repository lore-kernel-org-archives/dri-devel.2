Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3E3CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 18:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BB510E0D2;
	Tue, 19 May 2026 18:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="b2C+dnos";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2399410E0D2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779215192;
 bh=oezzTOYADBxwCJu/rst2G5+KJEGRHTz8n6GFTEgHBl0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=b2C+dnosX4j3d1hO1C9GnYgfBdtazkA/lPTCm+WNR9/z0j4lfsKCLPH7uNyEeyrmx
 SP7HebVufVeq9ozk/9sz9XOFTgPhKbwDM961R1ry4cG6fpqDipfN2iVzUyyCGlYdv6
 UmrgmOPTrttVaO8FKnN3cI7j0u/5pMHrqgIrU1GzNdKz0ip1v1oVIyeC24AarBBobD
 b3nR2Gzok5GCFbAdPepkATGMiALd3RA8UU52psP3FfGTqa4J3qLOZ5LTEjSsbjDosL
 jbg64hzSdQDp/Z96HciezmXmXhGo2BMbqJZKxcdDp/TukcfKaO4EGP+WjRRN96nYR+
 T8I/DTMzXsKtw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C99317E02A3;
 Tue, 19 May 2026 20:26:32 +0200 (CEST)
Date: Tue, 19 May 2026 20:26:29 +0200
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
Message-ID: <20260519202629.76bcc3a3@fedora>
In-Reply-To: <CAPaKu7Se1jLiZ+6VNY=Ykf+nkMzu-q2r3UOdQ9Qf2DzpGNiCCQ@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
 <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
 <20260513102941.7321cbc3@fedora>
 <CAPaKu7SJbeRwN7_S5_ciC6sSf_MM_4s7-iJS8aqh=ispBZBf2w@mail.gmail.com>
 <20260518154516.65ba8592@fedora>
 <CAPaKu7RL5Hs2jXcj_v0F99xsM1Vo-U5iTzBvQ3Sev=dRiwBcuw@mail.gmail.com>
 <20260519095354.123f8b61@fedora>
 <CAPaKu7Se1jLiZ+6VNY=Ykf+nkMzu-q2r3UOdQ9Qf2DzpGNiCCQ@mail.gmail.com>
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

On Tue, 19 May 2026 10:16:26 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Tue, May 19, 2026 at 12:53=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Mon, 18 May 2026 16:33:20 -0700
> > Chia-I Wu <olvaffe@gmail.com> wrote:
> >
> > =20
> > > > >
> > > > > =20
> > > > > > =20
> > > > > > > =20
> > > > > > > >         if (!ptdev->scheduler)
> > > > > > > >                 return;
> > > > > > > >
> > > > > > > > -       atomic_or(events, &ptdev->scheduler->fw_events);
> > > > > > > > -       sched_queue_work(ptdev->scheduler, fw_events);
> > > > > > > > +       guard(spinlock_irqsave)(&ptdev->scheduler->events_l=
ock);
> > > > > > > > +
> > > > > > > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > > > > > > +               sched_process_global_irq_locked(ptdev);
> > > > > > > > +               events &=3D ~JOB_INT_GLOBAL_IF;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       while (events) {
> > > > > > > > +               u32 csg_id =3D ffs(events) - 1;
> > > > > > > > +
> > > > > > > > +               sched_process_csg_irq_locked(ptdev, csg_id);
> > > > > > > > +               events &=3D ~BIT(csg_id);
> > > > > > > > +       } =20
> > > > > > > This handles all fw events in the irq context. Are there conc=
erns that
> > > > > > > it may take too long? I might be wrong, but it seems possible=
 to
> > > > > > > handle only CSG_SYNC_UPDATE and defer the rest as before. =20
> > > > > >
> > > > > > I started with just the SYNC_UPDATE processing done in the hard=
-irq
> > > > > > context, but after auditing the other stuff done in the handler=
, I
> > > > > > realized it's basically just deferring all actual processing to=
 work
> > > > > > items. Yes, there's the overhead of demuxing the events from the
> > > > > > ack/req regs, but part of this is already done to get to SYNC_U=
PDATE
> > > > > > anyway, so at this point we're probably better off demuxing eve=
rything
> > > > > > and scheduling works for all kind of events.
> > > > > >
> > > > > > I also compared the perfs between the two approaches (though I =
didn't
> > > > > > do as much testing as I did with the new version, so I might ha=
ve
> > > > > > missed something), and it didn't seem to matter at all, because=
 the
> > > > > > interrupts we receive the most are SYNC_UPDATE and IDLE events,=
 and
> > > > > > those are at the same level. =20
> > > > > Looking at ftrace irq events, when there is one active csg,
> > > > > panthor-job takes 6us (median) / 17us (95%) / 27us (slowest).
> > > > >
> > > > > I don't have a good sense if that's considered normal in hardirq.=
 But
> > > > > if that is ever an issue, and if the majority of the time is spen=
t in
> > > > > CSG_SYNC_UPDATE anyway, we can always revert the last patch to mo=
ve
> > > > > processing to threaded handler. =20
> > > >
> > > > Actually, the threaded -> hard transition (patch 9) is where the pe=
rf
> > > > gain is. =20
> > > hardirq is even more timely for sure. For our use case, the threaded
> > > handler is RT and is also good enough. =20
> >
> > Yeah, true. I forgot you were forcing RT priority on threaded handlers.
> > Anyway, let's stick to hardirqs for now, and revisit it if it proves to
> > be too much work done in irq context. =20
> Just want to clarify that irq_thread calls sched_set_fifo to make the
> task RT. The behavior is universal and is not specific to any
> downstream kernel.

Hm, interesting. In my testing, any of the changes before patch 9
didn't make a huge difference in term of perf, patch 9 is where the perf
gains happen. For the record, patch 6 is where we get rid of the
threaded -> work round-trip for job completion/fence signaling, and it
didn't seem to reflect in the benchmark results, but I'll do another
round of tests before posting v3, just to confirm.
