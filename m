Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2067CD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 20:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE9B10E5EA;
	Tue, 19 May 2026 20:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bvfsOnsX";
	dkim-atps=neutral
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8127810E5EA
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:45:40 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-7cb343d343fso35415057b3.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779223539; cv=none;
 d=google.com; s=arc-20240605;
 b=XnLt1up31lsQvI27NTkXSvELgwh6KFNhB4E9gRN9fP5SyT7l8TA1tClCjxDtQCwEix
 SqzmlSlltyjMEjChFuAwBfoqRrGryK3LGy647bGXvcsDJG41/rHz4RRlrBOAP8DK8qWB
 bDMu6jyNBY6RrH/qrgX6FV+HhfRi6dlLXJ6G/v9/NQGLveb0ib9gEzyhJKf3C8WouYYc
 X56rxZfg1ikR5DWh+2hm7Avs3MCobElSbAyapDah7DGAMeO9xSI44kTnsAYtlnhZiI/M
 OlenmG0iBeyJlTH5DW/ZPKs/X/CB+q3Ui87+76jjUT+mgAQeJCFX9syO0HVwUaZRaq2g
 Zptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bU5IcyZ0sUG4w6bjmWzNsv142TlY2wP3ViXDEampQMA=;
 fh=lGyRNCio8bgMjzG5DUWPMflq9DfrkNO6iGCZVwolrCs=;
 b=C1qZd2LLDjYgFfDDyHNZaW1f8YD+GJwK4liP2zm+PDvFZRLt7KmZd4Keo45GQ9Mejw
 GQGKwbfO8lqG6lCKSMKP09icAhrhFNghSDjkzs8E0HzKEF4dIRI4mtRyVDxIdu/oRXMh
 KF72FdZUdGMxiMhFSFs2mAuTfZWj+cNTwwwlljJpWWnUkbprEUaNK731c16mRprUqTtE
 58rKmPeXHxeX3CGhi3gWEwawRM5af3SgvXoFaWNb93pWI9O7lJwjjrNZtmP7EtyuqDvK
 UOLBTcWNdUDX5X5s0Vd2oA7pU/Qidv4tYy9yTx66K04pqdPamISeslKhgzPmcCzARCop
 Hzlw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779223539; x=1779828339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bU5IcyZ0sUG4w6bjmWzNsv142TlY2wP3ViXDEampQMA=;
 b=bvfsOnsXaaJVIE5tOW1CjkeDJ2m3K7U6x78YjP+gOlzqLNInAdO5GSArmHevmBtWxf
 5d0skBNr/4z3cpVPLxvdmmBi9/fMqb8KCKi0UbvgQ+ovOsESbbQEk0sFF2OMjxSW5r/r
 U/hzYaRGna3Gip+OMqMqu6Y97V5sCrC9RytZCQmSvCk/4lkBual1kVVsnTw24KlONPFZ
 mnR8vENui4uux6XKaYGkFfNfZNSS/gveMUv4gGN5OBZBPhx3xFqSAo1UT7Guwf/1rbFJ
 glieLIa4B9GNUlTsYJcL7mlWQVK6hi9552OpmWHT55pVaydB50AQNBoFd397+tCi9/s3
 NJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779223539; x=1779828339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bU5IcyZ0sUG4w6bjmWzNsv142TlY2wP3ViXDEampQMA=;
 b=Wy0xld3ZAHQsTMWaHpvNHM5cFv08+n/f9XKMNumrrtu2WnWsqmc2nQulB1sJ2bNNxx
 K/npccrLCl3QK64ObS1ntfXx8R2tGbu+wJWqsBYDmfJTSjsZOUxVxDOGwmvfl4mU4cmZ
 ZswhzR54EGDfPq5CyK4rchAGvVoNM4ISz7eVL+WhxlMVBoXl2fzTHGejP6ncU4mWp495
 WYhHZrzeIb5aGqNWtn/R35ELTCYjlWIWwdfFtq1tzOUkvzuomErGZgvudCatzngFWXzs
 JRAauJtDVYaw/WE8LyWJ9k36WxZ5JJDv0UJrRrp7QIkmywm5oO3iQIadqxJPISy5/ZQ7
 LSBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Y5gOUgOPUewKoAQgUZ0XtA3xGwai8y+NTJ3lEnAqsfM5qijuNskJbmW6Hm/TWOeTUm+C9m0fZ4MY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6FJ5b6SLeOLC3rWK/dePsjG2rV7YP6ZKTBaYThnvZKUUtqsIB
 wM7fIW2uXR/OdpE2GcoIWF9kJ9osPdiQXm0j9cNjFaEethy8ZYM9ZlAEQ1BnpPk30aIQ+P6w6Rj
 SU5Fw/SkaIg5DI+1hSK53WsatSYbIR9Q=
X-Gm-Gg: Acq92OEc8e8I3mLnjx0USyXZXzmMKi5f4ZFlV11rBG1oIDt7dBh3an/fUHRCmprBD/p
 /ljGxCA+XWbKceAJGaUP1fWTCtn1ChhrZBazIuht4Yy99Wa8XGDrFOUBLaXC73fRx612Donvm++
 9njPnm6BEqgJfqp6NnH8ff53OarLn8BYSOwQGc8kyhFU8hMIcrQcGkX546PRLB7ijTayoUuMyuV
 nKl90WGQ2d4nhmL/jYmtO5jGrj+Q9l7/dlV1WBvHbRBhuzqRv/R6ZlboJyxePogctkLTsYmmQM2
 E6bn4K1B4kmf9A48sgCjgSDLwzkhFx6DBNaUvufhuzEpY88DWjdPpVHMx18PPkkGv1nzNpvE
X-Received: by 2002:a05:690c:9b07:b0:7d0:6155:480d with SMTP id
 00721157ae682-7d061555a2amr16377187b3.5.1779223539141; Tue, 19 May 2026
 13:45:39 -0700 (PDT)
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
In-Reply-To: <20260519202629.76bcc3a3@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 19 May 2026 13:45:28 -0700
X-Gm-Features: AVHnY4IIAFiq3WaQCxo6ED_kTKqmca1JmV_wzlkYKj6GbdDmQ9qWjZcc-AK6c0s
Message-ID: <CAPaKu7TUmZcAJLmub0Xu-wsFOGeQp0zwrhXKLavBo9E=83kSdA@mail.gmail.com>
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

On Tue, May 19, 2026 at 11:26=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 19 May 2026 10:16:26 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > On Tue, May 19, 2026 at 12:53=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > On Mon, 18 May 2026 16:33:20 -0700
> > > Chia-I Wu <olvaffe@gmail.com> wrote:
> > >
> > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >         if (!ptdev->scheduler)
> > > > > > > > >                 return;
> > > > > > > > >
> > > > > > > > > -       atomic_or(events, &ptdev->scheduler->fw_events);
> > > > > > > > > -       sched_queue_work(ptdev->scheduler, fw_events);
> > > > > > > > > +       guard(spinlock_irqsave)(&ptdev->scheduler->events=
_lock);
> > > > > > > > > +
> > > > > > > > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > > > > > > > +               sched_process_global_irq_locked(ptdev);
> > > > > > > > > +               events &=3D ~JOB_INT_GLOBAL_IF;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       while (events) {
> > > > > > > > > +               u32 csg_id =3D ffs(events) - 1;
> > > > > > > > > +
> > > > > > > > > +               sched_process_csg_irq_locked(ptdev, csg_i=
d);
> > > > > > > > > +               events &=3D ~BIT(csg_id);
> > > > > > > > > +       }
> > > > > > > > This handles all fw events in the irq context. Are there co=
ncerns that
> > > > > > > > it may take too long? I might be wrong, but it seems possib=
le to
> > > > > > > > handle only CSG_SYNC_UPDATE and defer the rest as before.
> > > > > > >
> > > > > > > I started with just the SYNC_UPDATE processing done in the ha=
rd-irq
> > > > > > > context, but after auditing the other stuff done in the handl=
er, I
> > > > > > > realized it's basically just deferring all actual processing =
to work
> > > > > > > items. Yes, there's the overhead of demuxing the events from =
the
> > > > > > > ack/req regs, but part of this is already done to get to SYNC=
_UPDATE
> > > > > > > anyway, so at this point we're probably better off demuxing e=
verything
> > > > > > > and scheduling works for all kind of events.
> > > > > > >
> > > > > > > I also compared the perfs between the two approaches (though =
I didn't
> > > > > > > do as much testing as I did with the new version, so I might =
have
> > > > > > > missed something), and it didn't seem to matter at all, becau=
se the
> > > > > > > interrupts we receive the most are SYNC_UPDATE and IDLE event=
s, and
> > > > > > > those are at the same level.
> > > > > > Looking at ftrace irq events, when there is one active csg,
> > > > > > panthor-job takes 6us (median) / 17us (95%) / 27us (slowest).
> > > > > >
> > > > > > I don't have a good sense if that's considered normal in hardir=
q. But
> > > > > > if that is ever an issue, and if the majority of the time is sp=
ent in
> > > > > > CSG_SYNC_UPDATE anyway, we can always revert the last patch to =
move
> > > > > > processing to threaded handler.
> > > > >
> > > > > Actually, the threaded -> hard transition (patch 9) is where the =
perf
> > > > > gain is.
> > > > hardirq is even more timely for sure. For our use case, the threade=
d
> > > > handler is RT and is also good enough.
> > >
> > > Yeah, true. I forgot you were forcing RT priority on threaded handler=
s.
> > > Anyway, let's stick to hardirqs for now, and revisit it if it proves =
to
> > > be too much work done in irq context.
> > Just want to clarify that irq_thread calls sched_set_fifo to make the
> > task RT. The behavior is universal and is not specific to any
> > downstream kernel.
>
> Hm, interesting. In my testing, any of the changes before patch 9
> didn't make a huge difference in term of perf, patch 9 is where the perf
> gains happen. For the record, patch 6 is where we get rid of the
> threaded -> work round-trip for job completion/fence signaling, and it
> didn't seem to reflect in the benchmark results, but I'll do another
> round of tests before posting v3, just to confirm.
We care the most about signaling latency for this series. I collected
some numbers with baseline, with this series, and with patch 9
reverted at https://gitlab.freedesktop.org/panfrost/linux/-/work_items/85#n=
ote_3481308.
Reposting the numbers here for reference

|                    | baseline | entire series | patch 9 reverted |
| -                  | -        | -             | -                |
| frag job median    | 2.8ms    | 2.2ms         | 2.2ms            |
| frag job 95%       | 4.5ms    | 2.8ms         | 2.8ms            |
| frag job 99%       | 4.9ms    | 2.8ms         | 2.8ms            |
| panthor-job median | 0.8us    | 6.2us         | 0.9us            |
| panthor-job 95%    | 1.5us    | 16.6us        | 1.5us            |
| panthor-job 99%    | 1.6us    | 28.0us        | 1.8us            |
