Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3BCCD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 22:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D359310E17A;
	Wed, 20 May 2026 22:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nxh5XkO3";
	dkim-atps=neutral
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6D810E17A
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 22:16:08 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-7bdec52f48dso48318227b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779315367; cv=none;
 d=google.com; s=arc-20240605;
 b=hAMH/ibosb01hxzXbngUtFvDRbWM/j6HOTZhyfmYgI8MmzIPRyqkb8gGCHH91WQ2IQ
 0ldHRlR8O2JkDTAaXmSPY0v4SUZuFVYIA/x4J6/lunxJypsr3gn+5tO5PtJCitaFuJRD
 st7EFyqteSVgItRD2R4MXlQGYS/QnqSEuZCy9pSl2IHy8zJAMqX1wGfTfLAoRqnTfVdu
 SOBiyHXArEGRTyuIVF5eClBfuRzYW4Pj/ble42jfSbqYvUt9w58TpJ7bDqV3Vl08Lpcs
 gIyFd8W8PnH0MgXx10S+HQAOj3IhTjIon2xSpxsc/b9fMHxLgDt0VYzjrgKEqLCPLr6T
 0bkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7FfukSYEl7ya2WI5gPyICfJR6jZQ25mMEOdfstk91og=;
 fh=CXocQbiJNMab3oGr9c7BVQVDDKAqmF2KFKrlS7qd2Aw=;
 b=AK4jitmZsg6HSDdfiVlmSJI6/ReqlS/J2qK2eV0eUF/yTCtucssjDy8a2GQPguvr8o
 6O8WHq/5Zx+4zdCQ54YyUTNFoLpTRJxBOP+vplEM3S09XoTfkDBhnVlIONcJnXO6Neub
 29VcPJwuqQG5dNlYmdFRevxU78Jkoou7+YMMz/CPx3ag386nAmRFKsbgjasGfBdmErOY
 q9xeujw9WMIA3cUTxPbr/2yQdc75ovDKSqlqoo9+nwKmgmdMVzJhCdIcn9dYIpnMZtoI
 tbTlnT6Jv1W8n8LtPSCKrlGEuNSzWJ0vMcoyrm9BvoeRQWUVZrKJV/1zFChHqeqxzYWZ
 GpnA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779315367; x=1779920167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FfukSYEl7ya2WI5gPyICfJR6jZQ25mMEOdfstk91og=;
 b=Nxh5XkO3qLMhJO/oFnHt7t1LFzzWs9QLb/09OSpin646EAC7Jnga629ZGivz/icVTa
 5nTkrYYFKqrov7X0Rq71sIVhpoJ4H2ncBcH/L+7eu4jftyNlSKkzxvOYHsjc7Y5jHzwC
 episUmUJ5cSRfrA0w+5OaFVUYw8mPKQL2RFqyOTFT7p+Hf/OncLWA+U9hjsUpeTC/me9
 WveArp6Hy5OkhyzQXAcrZvzWoAFIa55V+ealwA0DjUQsz3XO42BIPuPOECkbwUPMnyBm
 hZYu6wJu98J4Tkw8/RSnPhuxnU0Yq5YZoWc4DVCbOTL39SrdB5AsPGVSmV2DKcEjFfWD
 R5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779315367; x=1779920167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7FfukSYEl7ya2WI5gPyICfJR6jZQ25mMEOdfstk91og=;
 b=LFQB0kr9jTOdAMwD5V6Qkj2rMTH3WoVvk4DiQJZFTbp5zHxqLyDJLiopIcp5C9qKi/
 GAYw67GPRO13JNI7ivENPLHZq/YJfbfXZ6urKXMnnQtt1xoiIgTpY6T7gnhKeGvVEmfo
 wgoDL5bFGEZr6cIzQ6AvvzXzjFUjwm3UbYlyYmQqB2i5DgmPYNc6xJbT1Wscdc9MUD12
 fG69SPLtXsljnCyip3XFQE5ec7Sb1xxUKxGbd02Rwim4YiuxaG4ecRmdLFGyaol/JVH+
 OV0xeObMmCLT49pvTPRaXi4Vkuoj4pXZW+hrY+pdUjF6nk4kTd+v1/XWpHHXtgMyyjyC
 CaUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AihAfuNyHm5xkeWjaoy4r/JtOoQ7BjrhR5B+PwpV7cJN2YNVsOckP3FdKLvIIRlxPh7XnqKnhMgs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzA9vG9T57sCXaA9XiwsW8jBeDaCG543IVNxitdyVNBwOp3sjTQ
 Osk0ulWUZjWxcrh3urjN6MYhLVPkO4oeyvqAP/3HcogeuGgCO/mVcCMoRWHz1+T2UGBVaS3VyD9
 bvbYoiBx7rb+bSY/T/ShNCUrW3VoTr7o=
X-Gm-Gg: Acq92OFWMRU/Dhjn0sLKULOh8aZnKF1ozwtUZ18jBYfeCxe/kXMwbsqivJCcT7IJRaf
 IjcbglJRCubKRCggECm5agq+yx40HoQfJLuDtLF1wfs1yFIkd+LFgGIDRMLxdOCOy0J0YOlRBeH
 IegPcl7WRx+6c5/SYUrC4l4mh675bnzcaIyxnsiWW0d3ORpEJ3XDpr0Uy1wTj3tEl5bhvrPzNi9
 PnNUtK1+aJbOX1eW/dRCY2FUXbaYvsQnTRNhouvvDOzzr1nXLW4izWlMwTLQsxhLiNW/RurCgxS
 aee0BlQDxiHvhdD/CLewVNTPgABVsh2E7w+trkkc8v8liSJnwhCDh/ZWgPiI50wZvVwaEOw=
X-Received: by 2002:a05:690c:397:b0:7bd:a6ea:c50c with SMTP id
 00721157ae682-7d20c241306mr3081327b3.15.1779315366842; Wed, 20 May 2026
 15:16:06 -0700 (PDT)
MIME-Version: 1.0
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
 <20260520100946.398c5282@fedora>
In-Reply-To: <20260520100946.398c5282@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 20 May 2026 15:15:54 -0700
X-Gm-Features: AVHnY4LG1GabS27O_OrJu5yztVjmFojZzQRAP2SzFjH7Xj9VquBuWG28KCNp_s4
Message-ID: <CAPaKu7T_J3Om=rJB-ShF9Kyusdk+P6kXAk=W7S1dxim-OmAukA@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] drm/panthor: Prepare the scheduler logic for FW
 events in IRQ context
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
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

On Wed, May 20, 2026 at 1:09=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 19 May 2026 14:04:47 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > On Tue, May 19, 2026 at 1:45=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> w=
rote:
> > >
> > > On Tue, May 19, 2026 at 11:26=E2=80=AFAM Boris Brezillon
> > > <boris.brezillon@collabora.com> wrote:
> > > >
> > > > On Tue, 19 May 2026 10:16:26 -0700
> > > > Chia-I Wu <olvaffe@gmail.com> wrote:
> > > >
> > > > > On Tue, May 19, 2026 at 12:53=E2=80=AFAM Boris Brezillon
> > > > > <boris.brezillon@collabora.com> wrote:
> > > > > >
> > > > > > On Mon, 18 May 2026 16:33:20 -0700
> > > > > > Chia-I Wu <olvaffe@gmail.com> wrote:
> > > > > >
> > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >         if (!ptdev->scheduler)
> > > > > > > > > > > >                 return;
> > > > > > > > > > > >
> > > > > > > > > > > > -       atomic_or(events, &ptdev->scheduler->fw_eve=
nts);
> > > > > > > > > > > > -       sched_queue_work(ptdev->scheduler, fw_event=
s);
> > > > > > > > > > > > +       guard(spinlock_irqsave)(&ptdev->scheduler->=
events_lock);
> > > > > > > > > > > > +
> > > > > > > > > > > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > > > > > > > > > > +               sched_process_global_irq_locked(ptd=
ev);
> > > > > > > > > > > > +               events &=3D ~JOB_INT_GLOBAL_IF;
> > > > > > > > > > > > +       }
> > > > > > > > > > > > +
> > > > > > > > > > > > +       while (events) {
> > > > > > > > > > > > +               u32 csg_id =3D ffs(events) - 1;
> > > > > > > > > > > > +
> > > > > > > > > > > > +               sched_process_csg_irq_locked(ptdev,=
 csg_id);
> > > > > > > > > > > > +               events &=3D ~BIT(csg_id);
> > > > > > > > > > > > +       }
> > > > > > > > > > > This handles all fw events in the irq context. Are th=
ere concerns that
> > > > > > > > > > > it may take too long? I might be wrong, but it seems =
possible to
> > > > > > > > > > > handle only CSG_SYNC_UPDATE and defer the rest as bef=
ore.
> > > > > > > > > >
> > > > > > > > > > I started with just the SYNC_UPDATE processing done in =
the hard-irq
> > > > > > > > > > context, but after auditing the other stuff done in the=
 handler, I
> > > > > > > > > > realized it's basically just deferring all actual proce=
ssing to work
> > > > > > > > > > items. Yes, there's the overhead of demuxing the events=
 from the
> > > > > > > > > > ack/req regs, but part of this is already done to get t=
o SYNC_UPDATE
> > > > > > > > > > anyway, so at this point we're probably better off demu=
xing everything
> > > > > > > > > > and scheduling works for all kind of events.
> > > > > > > > > >
> > > > > > > > > > I also compared the perfs between the two approaches (t=
hough I didn't
> > > > > > > > > > do as much testing as I did with the new version, so I =
might have
> > > > > > > > > > missed something), and it didn't seem to matter at all,=
 because the
> > > > > > > > > > interrupts we receive the most are SYNC_UPDATE and IDLE=
 events, and
> > > > > > > > > > those are at the same level.
> > > > > > > > > Looking at ftrace irq events, when there is one active cs=
g,
> > > > > > > > > panthor-job takes 6us (median) / 17us (95%) / 27us (slowe=
st).
> > > > > > > > >
> > > > > > > > > I don't have a good sense if that's considered normal in =
hardirq. But
> > > > > > > > > if that is ever an issue, and if the majority of the time=
 is spent in
> > > > > > > > > CSG_SYNC_UPDATE anyway, we can always revert the last pat=
ch to move
> > > > > > > > > processing to threaded handler.
> > > > > > > >
> > > > > > > > Actually, the threaded -> hard transition (patch 9) is wher=
e the perf
> > > > > > > > gain is.
> > > > > > > hardirq is even more timely for sure. For our use case, the t=
hreaded
> > > > > > > handler is RT and is also good enough.
> > > > > >
> > > > > > Yeah, true. I forgot you were forcing RT priority on threaded h=
andlers.
> > > > > > Anyway, let's stick to hardirqs for now, and revisit it if it p=
roves to
> > > > > > be too much work done in irq context.
> > > > > Just want to clarify that irq_thread calls sched_set_fifo to make=
 the
> > > > > task RT. The behavior is universal and is not specific to any
> > > > > downstream kernel.
>
> There's a difference in what RT means depending on whether the system
> is configured with PREEMPT or PREEMPT_RT though. But I assume you're
> using PREEMPT not PREEMPT_RT.
Right. What I meant for an RT task is that the task uses an RT
scheduling policy (rt_policy).

>
> > > >
> > > > Hm, interesting. In my testing, any of the changes before patch 9
> > > > didn't make a huge difference in term of perf, patch 9 is where the=
 perf
> > > > gains happen. For the record, patch 6 is where we get rid of the
> > > > threaded -> work round-trip for job completion/fence signaling, and=
 it
> > > > didn't seem to reflect in the benchmark results, but I'll do anothe=
r
> > > > round of tests before posting v3, just to confirm.
> > > We care the most about signaling latency for this series.
>
> Yes, I know. It's just that it also seemed to help the throughput, which
> I initially checked to make sure we were not regressing perfs
> significantly by interrupting the system aggressively. I guess the
> reason for that is that, by reducing the latency, we also unleash the
> job submitter (if you get signaled early, and jobs tend to be
> serialized because of deps, you can submit more).
Yeah, that's likely the case.

Although, if the benchmark is supposed to be GPU-bound and is not
poorly-written, we might also want to check if the userspace driver
adds unncecessary deps between jobs. A trace should give us some
insight.

> > > I collected
> > > some numbers with baseline, with this series, and with patch 9
> > > reverted at https://gitlab.freedesktop.org/panfrost/linux/-/work_item=
s/85#note_3481308.
> > > Reposting the numbers here for reference
> > >
> > > |                    | baseline | entire series | patch 9 reverted |
> > > | -                  | -        | -             | -                |
> > > | frag job median    | 2.8ms    | 2.2ms         | 2.2ms            |
> > > | frag job 95%       | 4.5ms    | 2.8ms         | 2.8ms            |
> > > | frag job 99%       | 4.9ms    | 2.8ms         | 2.8ms            |
> > > | panthor-job median | 0.8us    | 6.2us         | 0.9us            |
> > > | panthor-job 95%    | 1.5us    | 16.6us        | 1.5us            |
> > > | panthor-job 99%    | 1.6us    | 28.0us        | 1.8us            |
> >
> > panthor-job rows are the durations of the raw irq handlers, collected
> > from irq/irq_handler_{entry,exit}.
> >
> > frag job rows are the durations from frag jobs, collected from
> > gpu_scheduler/drm_sched_job_{run,done}.
> >
> > The fence signaling paths of them are
> >
> >  - baseline: raw handler -> rt threaded handler -> wq job -> wq job ->
> > fence signal
> >  - entire series: raw handler -> fence signal
> >  - patch 9 reverted: raw handler -> rt threaded handler -> fence signal
>
> Just did another set of throughput tests, and I confirm the gains are
> noticeable only with patch 9 applied (that's on rk3588, which embeds a
> G610, so not the exact same setup). As an example, on
> gfxbench/gl_manhattan, I get the following score bump 2391 -> 2457.
>
> Now I need to set things up to measure latency like you did and make
> sure I'm observing the same thing: threaded handlers providing roughly
> the same latency as hardirq handlers. If not it probably has to do with
> some config options that differ and change the preemptability of the
> system.
>
> I'll hold off on the submission of v3 until this is done, because if
> threaded handlers are roughly as efficient as hardirq ones, we probably
> want to stick to threaded handlers.
