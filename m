Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD10CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788A110EF49;
	Wed, 20 May 2026 08:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mLcu2kK1";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FEE710EF5C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779264590;
 bh=3Pzi6mPyzYIlsvz4GOUuBtF694sERXtAIfdszm4jzSk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mLcu2kK1RtEOq8Got2e7o1hhRTYxbBF2QKSHXM9a95UHccAPFqPTFnFL1q+7Gl5j8
 IS70kuiwj8nujHZK5SzPScEnmSHneGTpNhad5gI4nlA+RSZmZ8RInr0pfCT79dVRbx
 hevhjawnRiKsKn0UUR+lckyb0gWeI2uHpVQVYebA/PyQjqqJMSop5I15T97FG3UiKQ
 5F8TuW2C2c5k+yYb/hkePSBL1zcAwlQRQ6HM92wx2tFFWBdXVAuOrlQHdOy1nEzZt8
 MtBAkUawpqTo8R8DgCWtExtkVQNVImgKEJ+kKw/3d08c9daSZ2q8z51fQqx7ILd1AE
 7QAVlDmE4lp2Q==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A083E17E0504;
 Wed, 20 May 2026 10:09:49 +0200 (CEST)
Date: Wed, 20 May 2026 10:09:46 +0200
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
Message-ID: <20260520100946.398c5282@fedora>
In-Reply-To: <CAPaKu7ToQmHHhTyb-az_b7EG2iRpc23=AJOYQ5P=HgrG29bS1A@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
 <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
 <20260513102941.7321cbc3@fedora>
 <CAPaKu7SJbeRwN7_S5_ciC6sSf_MM_4s7-iJS8aqh=ispBZBf2w@mail.gmail.com>
 <20260518154516.65ba8592@fedora>
 <CAPaKu7RL5Hs2jXcj_v0F99xsM1Vo-U5iTzBvQ3Sev=dRiwBcuw@mail.gmail.com>
 <20260519095354.123f8b61@fedora>
 <CAPaKu7Se1jLiZ+6VNY=Ykf+nkMzu-q2r3UOdQ9Qf2DzpGNiCCQ@mail.gmail.com>
 <20260519202629.76bcc3a3@fedora>
 <CAPaKu7TUmZcAJLmub0Xu-wsFOGeQp0zwrhXKLavBo9E=83kSdA@mail.gmail.com>
 <CAPaKu7ToQmHHhTyb-az_b7EG2iRpc23=AJOYQ5P=HgrG29bS1A@mail.gmail.com>
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

On Tue, 19 May 2026 14:04:47 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Tue, May 19, 2026 at 1:45=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wro=
te:
> >
> > On Tue, May 19, 2026 at 11:26=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote: =20
> > >
> > > On Tue, 19 May 2026 10:16:26 -0700
> > > Chia-I Wu <olvaffe@gmail.com> wrote:
> > > =20
> > > > On Tue, May 19, 2026 at 12:53=E2=80=AFAM Boris Brezillon
> > > > <boris.brezillon@collabora.com> wrote: =20
> > > > >
> > > > > On Mon, 18 May 2026 16:33:20 -0700
> > > > > Chia-I Wu <olvaffe@gmail.com> wrote:
> > > > >
> > > > > =20
> > > > > > > >
> > > > > > > > =20
> > > > > > > > > =20
> > > > > > > > > > =20
> > > > > > > > > > >         if (!ptdev->scheduler)
> > > > > > > > > > >                 return;
> > > > > > > > > > >
> > > > > > > > > > > -       atomic_or(events, &ptdev->scheduler->fw_event=
s);
> > > > > > > > > > > -       sched_queue_work(ptdev->scheduler, fw_events);
> > > > > > > > > > > +       guard(spinlock_irqsave)(&ptdev->scheduler->ev=
ents_lock);
> > > > > > > > > > > +
> > > > > > > > > > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > > > > > > > > > +               sched_process_global_irq_locked(ptdev=
);
> > > > > > > > > > > +               events &=3D ~JOB_INT_GLOBAL_IF;
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       while (events) {
> > > > > > > > > > > +               u32 csg_id =3D ffs(events) - 1;
> > > > > > > > > > > +
> > > > > > > > > > > +               sched_process_csg_irq_locked(ptdev, c=
sg_id);
> > > > > > > > > > > +               events &=3D ~BIT(csg_id);
> > > > > > > > > > > +       } =20
> > > > > > > > > > This handles all fw events in the irq context. Are ther=
e concerns that
> > > > > > > > > > it may take too long? I might be wrong, but it seems po=
ssible to
> > > > > > > > > > handle only CSG_SYNC_UPDATE and defer the rest as befor=
e. =20
> > > > > > > > >
> > > > > > > > > I started with just the SYNC_UPDATE processing done in th=
e hard-irq
> > > > > > > > > context, but after auditing the other stuff done in the h=
andler, I
> > > > > > > > > realized it's basically just deferring all actual process=
ing to work
> > > > > > > > > items. Yes, there's the overhead of demuxing the events f=
rom the
> > > > > > > > > ack/req regs, but part of this is already done to get to =
SYNC_UPDATE
> > > > > > > > > anyway, so at this point we're probably better off demuxi=
ng everything
> > > > > > > > > and scheduling works for all kind of events.
> > > > > > > > >
> > > > > > > > > I also compared the perfs between the two approaches (tho=
ugh I didn't
> > > > > > > > > do as much testing as I did with the new version, so I mi=
ght have
> > > > > > > > > missed something), and it didn't seem to matter at all, b=
ecause the
> > > > > > > > > interrupts we receive the most are SYNC_UPDATE and IDLE e=
vents, and
> > > > > > > > > those are at the same level. =20
> > > > > > > > Looking at ftrace irq events, when there is one active csg,
> > > > > > > > panthor-job takes 6us (median) / 17us (95%) / 27us (slowest=
).
> > > > > > > >
> > > > > > > > I don't have a good sense if that's considered normal in ha=
rdirq. But
> > > > > > > > if that is ever an issue, and if the majority of the time i=
s spent in
> > > > > > > > CSG_SYNC_UPDATE anyway, we can always revert the last patch=
 to move
> > > > > > > > processing to threaded handler. =20
> > > > > > >
> > > > > > > Actually, the threaded -> hard transition (patch 9) is where =
the perf
> > > > > > > gain is. =20
> > > > > > hardirq is even more timely for sure. For our use case, the thr=
eaded
> > > > > > handler is RT and is also good enough. =20
> > > > >
> > > > > Yeah, true. I forgot you were forcing RT priority on threaded han=
dlers.
> > > > > Anyway, let's stick to hardirqs for now, and revisit it if it pro=
ves to
> > > > > be too much work done in irq context. =20
> > > > Just want to clarify that irq_thread calls sched_set_fifo to make t=
he
> > > > task RT. The behavior is universal and is not specific to any
> > > > downstream kernel. =20

There's a difference in what RT means depending on whether the system
is configured with PREEMPT or PREEMPT_RT though. But I assume you're
using PREEMPT not PREEMPT_RT.

> > >
> > > Hm, interesting. In my testing, any of the changes before patch 9
> > > didn't make a huge difference in term of perf, patch 9 is where the p=
erf
> > > gains happen. For the record, patch 6 is where we get rid of the
> > > threaded -> work round-trip for job completion/fence signaling, and it
> > > didn't seem to reflect in the benchmark results, but I'll do another
> > > round of tests before posting v3, just to confirm. =20
> > We care the most about signaling latency for this series.

Yes, I know. It's just that it also seemed to help the throughput, which
I initially checked to make sure we were not regressing perfs
significantly by interrupting the system aggressively. I guess the
reason for that is that, by reducing the latency, we also unleash the
job submitter (if you get signaled early, and jobs tend to be
serialized because of deps, you can submit more).

> > I collected
> > some numbers with baseline, with this series, and with patch 9
> > reverted at https://gitlab.freedesktop.org/panfrost/linux/-/work_items/=
85#note_3481308.
> > Reposting the numbers here for reference
> >
> > |                    | baseline | entire series | patch 9 reverted |
> > | -                  | -        | -             | -                |
> > | frag job median    | 2.8ms    | 2.2ms         | 2.2ms            |
> > | frag job 95%       | 4.5ms    | 2.8ms         | 2.8ms            |
> > | frag job 99%       | 4.9ms    | 2.8ms         | 2.8ms            |
> > | panthor-job median | 0.8us    | 6.2us         | 0.9us            |
> > | panthor-job 95%    | 1.5us    | 16.6us        | 1.5us            |
> > | panthor-job 99%    | 1.6us    | 28.0us        | 1.8us            | =20
>=20
> panthor-job rows are the durations of the raw irq handlers, collected
> from irq/irq_handler_{entry,exit}.
>=20
> frag job rows are the durations from frag jobs, collected from
> gpu_scheduler/drm_sched_job_{run,done}.
>=20
> The fence signaling paths of them are
>=20
>  - baseline: raw handler -> rt threaded handler -> wq job -> wq job ->
> fence signal
>  - entire series: raw handler -> fence signal
>  - patch 9 reverted: raw handler -> rt threaded handler -> fence signal

Just did another set of throughput tests, and I confirm the gains are
noticeable only with patch 9 applied (that's on rk3588, which embeds a
G610, so not the exact same setup). As an example, on
gfxbench/gl_manhattan, I get the following score bump 2391 -> 2457.

Now I need to set things up to measure latency like you did and make
sure I'm observing the same thing: threaded handlers providing roughly
the same latency as hardirq handlers. If not it probably has to do with
some config options that differ and change the preemptability of the
system.

I'll hold off on the submission of v3 until this is done, because if
threaded handlers are roughly as efficient as hardirq ones, we probably
want to stick to threaded handlers.
