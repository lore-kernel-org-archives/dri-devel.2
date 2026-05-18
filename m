Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79033CD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 23:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6EA10E213;
	Mon, 18 May 2026 23:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="altV7c2C";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5833510E213
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 23:33:32 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7bb0d18c7f9so22176487b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147211; cv=none;
 d=google.com; s=arc-20240605;
 b=RSK/8jUWHIH4FKr8ErE45kN8Xz9IJpxARf39T+tbRFD6pWQmz0t8L4ikVj4vTH5l3q
 3OqNnB1OmIpJhIJFezJbYPFjyOTonus/bX9IghUrzskEwM6YJvAvMTY5rnfbVSJcwRBN
 diW21oZC+/Icl9qzq1v3y8dz0ptc5uZx8dlwYAUibtwyQlXz65tFLReOlVWbjcCN5SVO
 JmNrrYeMcjyEP6uXEaHTdpFGtYmRog9XFm7HU2RWbnJHQ9Clj+iDSlyV5rgkj+I+GiKC
 c5fGQJF3rSvMg3bq3OwD90jkX9q0lSPN/VsL0YlyMi54T/L8ArI8esrnMg+gBB46BU9q
 uXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ldxv8bqI+dSzVq+DQ1STQWmDJwgS7f+ndmxRwB2idE4=;
 fh=8ZKp/IPlH4RMFXPKLf0q6BUWG/KIXFrpGPmV0ESRUHY=;
 b=Mf3K79b8wy+ZBDmsYuZstgX/Qnqz1vNEM+2NZGo5d3U8udQZyJ6P0m76Cjm2sjY97s
 U89fyae67pCfRI+IDxOnH/it5NkqEog30HCH5xV2JwVuxi7PwiMRSPmaAGv2HdkuPLwk
 3EC72Ier1Kb/5EgwWShYjYYWTBaslT3Sas7dCgRdzOJmtE/gX3T4h6QBPIt6B6fBe3UQ
 SIhpJvC0WadLRETikO1qMYlmSnJF+snj1BQsIIYdngnA9O7oxHlKrqgMllkOuxmWvD9n
 cZnbukxycc4nf4qdRyOgqPnfBVCyFlx14nLC5wi1FUC9kkWpb8QStPg6oVMdhwp+gKZ5
 5w3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779147211; x=1779752011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ldxv8bqI+dSzVq+DQ1STQWmDJwgS7f+ndmxRwB2idE4=;
 b=altV7c2CECrFVcfg4QEWqhc5MAJwW/h+iF7ACXmOIfe4xJtwBgYIRVve/v+U4XULCA
 xL40gFjfQyacBM9/ndQ7iTtPBeb6uyN0+mnTLhF4wKuknt/1e3wW4NVyJE1VxSlRdGSN
 Ah1XZKm3hDGWzZDePtw7yRbkJg5wahe936o6z9MAq81GDxTPmyNHa13patf3O5Nu90E7
 XFyN/3CdxjU8hX7NwkrMk/Pzqv3LNc6OeJ/cJqvxhuuBhHS06YyDAknGnyEbDB39p/P8
 1pRmgKByI2O9jvEZuZ6XzKavQco5HBsQoEGfIaTeLaqdZxlNK9bSO8Z6nPjHeSUNAf/p
 27JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779147211; x=1779752011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ldxv8bqI+dSzVq+DQ1STQWmDJwgS7f+ndmxRwB2idE4=;
 b=q4GagP3tRHmjDpXp71F99MHQQdBOx+kxmmd65VDgfYJVqgYzCHc8InC6H8zPuL/9Ay
 UcB3kB8Xqtd3oHssU80LMDqrfaBx58QBwbZIQ7mzAiZ+gWBIJCDLhPeFjbXvx9kkxkBk
 v/vuL4f4DgnBXOr4J+lvl6FZzXzkvB793EPVLwZnfI4yh/nhbBgbRBpHxH2Qqr5y96DM
 amQnfhxnt2wcaxzr25iwfVOe/i4Q9P094e8nC7RrRqp+3owXIQjuK/LObiV7IeOz4hSh
 Z88dC8Ppdkv9aN+ZCh1PK1CkouG5/pYH9vxwwea0mtnEEyzqDeC+n7Qi4Nx06UfU7ibL
 5IUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++UCT/a+xgUDZoBFsoMTnERJAmgPFPugX45X2tzvj/5GyoI4jqXgDZSEM7g2E3XrZmzr3661UtLfg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvuKKKVH6ahcjjCR+jHkVJ1wQy6W3wjodjCKfZKd8hTsAOfMes
 fqIoyhMiODFe4PGKztJRjkIz08BUQ0vmODvIh8Gcjm31rJnqJxqusMKowRltzD8dxroSzbOScTI
 xsUvwJKuhB8fhgmTDPloMaqfxk3jo3DA=
X-Gm-Gg: Acq92OF7LOXzc4lYXVJ6BVu+/ppCCHElrpTT+LNRP3c/q0PE/74Mos//l4OzWWwfocN
 Fs5RdpzJQeJvHwQU3M9iGcpBtrMuZSHyTh1nD8tH/J27BnY1v9qxj0yyrwYLGAXQezlxzLXpIhf
 K+9W8CicSUQZtG8gL4PU39HCFF8YczhXPp1oALEwZ8eXUx7dIuIw3Yj5eWIr0ZzCuMAFLjw1qaE
 R71HIPeLtThF0eK/lGP3yk7VBtieIw/gJ9GF+LRFzhNxLM8PN81CzG1XTyAj9fPggdlETjARNXe
 elNs1BSL4gZd7q5XQOo02WONp0LN7ksbvt/vJnUkqH8gyNNg4+4gQpvhNDJ6rdQC23ZQEh6y
X-Received: by 2002:a05:690c:a013:b0:7b3:f33:35e2 with SMTP id
 00721157ae682-7c958fbfc87mr150864637b3.10.1779147211278; Mon, 18 May 2026
 16:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
 <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
 <20260513102941.7321cbc3@fedora>
 <CAPaKu7SJbeRwN7_S5_ciC6sSf_MM_4s7-iJS8aqh=ispBZBf2w@mail.gmail.com>
 <20260518154516.65ba8592@fedora>
In-Reply-To: <20260518154516.65ba8592@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Mon, 18 May 2026 16:33:20 -0700
X-Gm-Features: AVHnY4K9LtrivMX3XWo6Pp_P0NxmdzOwbNRep65H1-1-F0yv9-Z51ERpArUlZvg
Message-ID: <CAPaKu7RL5Hs2jXcj_v0F99xsM1Vo-U5iTzBvQ3Sev=dRiwBcuw@mail.gmail.com>
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

On Mon, May 18, 2026 at 6:45=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Wed, 13 May 2026 10:47:28 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > > >
> > > > Multiple things happen in this commit. I try to identify things tha=
t
> > > > can be separate commits. If this does not make sense, feel free to
> > > > ignore.
> > > >
> > > > >         /** @tiler_oom_work: Work used to process tiler OOM event=
s happening on this group. */
> > > > >         struct work_struct tiler_oom_work;
> > > > >
> > >
> > > [...]
> > >
> > > > >  /**
> > > > >   * panthor_sched_report_fw_events() - Report FW events to the sc=
heduler.
> > > > >   * @ptdev: Device.
> > > > > @@ -1902,8 +1953,19 @@ void panthor_sched_report_fw_events(struct=
 panthor_device *ptdev, u32 events)
> > > > This can be renamed to panthor_sched_handle_fw_events.
> > >
> > > It's not quite handling events though. For most of them, it's really
> > > just deferring the processing to work items, SYNC_UPDATE is the
> > > exception.
> > panthor_sched_report_fw_events no longer just queues
> > process_fw_events_work. It processes fw events immediately. If
> > "handle" is not the right verb, perhaps we can go with "process".
>
> I guess "demux" would be more accurate, but do we need to rename this
> function in the first place? I mean, panthor_sched_report_fw_events()
> doesn't imply that events are processed/handled, it just reflects the
> fact FW events are reported to the scheduler. Up to the scheduler to
> do what it wants with this piece of information (process some of them
> immediately, defer the processing for others, etc).
process_fw_events_work gets inlined into
panthor_sched_report_fw_events. Either report/process/handle should be
fine. Let's drop this comment.

>
> >
> >
> > >
> > > >
> > > > >         if (!ptdev->scheduler)
> > > > >                 return;
> > > > >
> > > > > -       atomic_or(events, &ptdev->scheduler->fw_events);
> > > > > -       sched_queue_work(ptdev->scheduler, fw_events);
> > > > > +       guard(spinlock_irqsave)(&ptdev->scheduler->events_lock);
> > > > > +
> > > > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > > > +               sched_process_global_irq_locked(ptdev);
> > > > > +               events &=3D ~JOB_INT_GLOBAL_IF;
> > > > > +       }
> > > > > +
> > > > > +       while (events) {
> > > > > +               u32 csg_id =3D ffs(events) - 1;
> > > > > +
> > > > > +               sched_process_csg_irq_locked(ptdev, csg_id);
> > > > > +               events &=3D ~BIT(csg_id);
> > > > > +       }
> > > > This handles all fw events in the irq context. Are there concerns t=
hat
> > > > it may take too long? I might be wrong, but it seems possible to
> > > > handle only CSG_SYNC_UPDATE and defer the rest as before.
> > >
> > > I started with just the SYNC_UPDATE processing done in the hard-irq
> > > context, but after auditing the other stuff done in the handler, I
> > > realized it's basically just deferring all actual processing to work
> > > items. Yes, there's the overhead of demuxing the events from the
> > > ack/req regs, but part of this is already done to get to SYNC_UPDATE
> > > anyway, so at this point we're probably better off demuxing everythin=
g
> > > and scheduling works for all kind of events.
> > >
> > > I also compared the perfs between the two approaches (though I didn't
> > > do as much testing as I did with the new version, so I might have
> > > missed something), and it didn't seem to matter at all, because the
> > > interrupts we receive the most are SYNC_UPDATE and IDLE events, and
> > > those are at the same level.
> > Looking at ftrace irq events, when there is one active csg,
> > panthor-job takes 6us (median) / 17us (95%) / 27us (slowest).
> >
> > I don't have a good sense if that's considered normal in hardirq. But
> > if that is ever an issue, and if the majority of the time is spent in
> > CSG_SYNC_UPDATE anyway, we can always revert the last patch to move
> > processing to threaded handler.
>
> Actually, the threaded -> hard transition (patch 9) is where the perf
> gain is.
hardirq is even more timely for sure. For our use case, the threaded
handler is RT and is also good enough.
