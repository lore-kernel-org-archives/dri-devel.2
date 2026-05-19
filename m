Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F04CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 17:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9488010E3BF;
	Tue, 19 May 2026 17:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b9FUDoJ+";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490F810E3BF
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 17:16:39 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-7cb345cb5bfso27573457b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779210998; cv=none;
 d=google.com; s=arc-20240605;
 b=Vhm6Zpoolrv4RWe0lEv+kGoswXTKmASs9jNzp3SrzwCM2owzwRRfb1B6Z8d7vamvVZ
 /FR3dMJdU1yaWygictezKqu5xZa8BHp85YMzGGBHqGBK/cVSihL30cMdyuQGhy42/7q6
 knkTSIlXS6mfjyDVoVaic3J1n1ztjyr2qWhUu3eYf2SoimdzqMkQgLzQgLorXV1N5Yy+
 0/xYzA/seSfkoJwTKBOD6UWmMPz2CE9dbajGBw06UZLAhkrbPV6OfWMu8XAU0v/qHnF2
 5aFD4bDtXCmQCaZ8hemQeqp9j0vGzzVoBsLOxbj6B82NprWz76aXrz0AanlixAjcbdTj
 YoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pHmPXA9ApACBU8ebt0yfK2wXBnpmikH2aI+26huFIS4=;
 fh=UsOCl1aBYONm559CECMvI3RrXbfRHVXSISol2HpH2e8=;
 b=MhJn3XtU3zQutpaRCtFHaBpWDvsFLltsMygsGMTA7ZkabpGrTnW3tXCmWB/LSKpeTw
 eEPmy7J9mD2HFZy+x4qGJ8PI+NsjQm0ZkDEyJ65NTDmD8RsUY2lylA5QBuPd8j8y2HKx
 2rSovwXS7EBHvdMTD8M+WL03ipjCRSvJOMIKTd0Qg+l31HGaQtxWjUQ27j8lbcgTVOIp
 mssQXLNpalx5HCaWOnjVaK+Ni1SxsNy7OaaIBPyArM1xL9H+s9Ty4+kuiBrsBUIzU1qB
 DV9niP2sofv79UIee3vZrcDIaW5sPkN2WdZ6Mw2pkHRaNZHecCt204rJMcAcPVkM1BWm
 Lzfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779210998; x=1779815798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHmPXA9ApACBU8ebt0yfK2wXBnpmikH2aI+26huFIS4=;
 b=b9FUDoJ+95cjdrnolrlcWL7ImfS+G77XGAftB8NwEDaA4J3ADZTdQBBVg+ka4N+o5Y
 yXxgLX2JMHuWZaTHhge9T0yj83750h9sFRD6CmDLP71UjXMhEWMwI0JUYexlE0gPOTDx
 MAouQEhVtM/xQ5P/qcOhdsFWsQC57uKTDabe5nd7OYF1P7SceFiDlAhs3agYjGXSEZQS
 emBTpq2naiaOg+WFo9iJ4MN31slH3C0cBfDHAhMlZVTpMqf/alv+dCiHwvUf+QDZWQfI
 elbCJ5GBtAecV1YFRe5WD//Kdbhjn2+IFM11V3ZB5doA5xkrBwxneV4RmOzZvhHmggjU
 09kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779210998; x=1779815798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pHmPXA9ApACBU8ebt0yfK2wXBnpmikH2aI+26huFIS4=;
 b=hIrsX4RVS3wbWPuKWx7+sshk7g8wDDIQFKXIzUzu1GhGzdXi9ZivhYwEKw3U58k2n9
 NAEAADcq6cEkZm3unOZ3eE7ygFvAnaDKb34RhlgQznjg7P1nrcW8ipwNvo+0QVSuA3vs
 ZB6AvWXKYGoHdJ5S3Nzn6lK/vdebvkWiTphKE3AlZymA3bpsMGUo+CDZmTf+k+7Gb2tU
 UGQi5a58OpZaMfEeDjsFYLTq/BZNSYb1gh6TXIApPBW0c1bwGOduRswAVEh3nq8Qwac/
 8jcE4mhhtrqTD9eat1Y8tOGtof9+g9qybpnC6Ox5VczeGtcnuNEYkYn493kiT99I1gO/
 0dQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/39CWfxfnrH6oGnQBYKQ7xAKRc6INttY7a1eLRldjkhhobN2J3BDpy0DWN8g/nrpbyYifWAPh0LmE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxuxOD9BHQOj5dxTtkG0YuPiPUdvYXKVUHeIU02v5YmGlYxsPr
 k4NcrZFWVbpC50hD68vHmoWkBqCyuWcZ6z1IjLUK5Q5z8diRaoLxuNNuTp0yV2ZI3Go53ARTtCE
 abcbz4RH0c9TxmCVeyTK1CrXwUYkBD1s=
X-Gm-Gg: Acq92OGlhmDo0aethXS4JzAfCfdnwx+3a7ubDziMTCP3E3rUk3scBGtaBWOHeXhM56D
 nITHFjlL706vIP42VyBAJYC8bT2Rr+maISbS9eP31tMuhoSEWex9BQO7GCJSxly+V7FOef5UAcF
 qqiFPPwjgMgZLntOiIdXaT1y04fMRY1A7YGLdAUXR5awIFhytvR/M1yV4qX4mfE1O3WzMHNFI5C
 zXH1G7ldEIdNy1pk+k2l/y5ooocrohlbJGWXt/crXWhyrlpzFPVNgiZ3U8pQSt1AJfDYsW4jzKR
 B/8YVBaJRXlCOPv5uqUd6qTEphEh9QeXyPpl5gOXiqfyGc0zjQVbt2mC7x2etNIMWbml/m1z
X-Received: by 2002:a05:690c:7681:b0:7b4:2bbb:441e with SMTP id
 00721157ae682-7c95a07f293mr209868297b3.22.1779210998144; Tue, 19 May 2026
 10:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
 <CAPaKu7RjHvRAYZDehSF9R_8T-uTrC9-NfsAPSOX0n=-2phunpg@mail.gmail.com>
 <20260513102941.7321cbc3@fedora>
 <CAPaKu7SJbeRwN7_S5_ciC6sSf_MM_4s7-iJS8aqh=ispBZBf2w@mail.gmail.com>
 <20260518154516.65ba8592@fedora>
 <CAPaKu7RL5Hs2jXcj_v0F99xsM1Vo-U5iTzBvQ3Sev=dRiwBcuw@mail.gmail.com>
 <20260519095354.123f8b61@fedora>
In-Reply-To: <20260519095354.123f8b61@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 19 May 2026 10:16:26 -0700
X-Gm-Features: AVHnY4I4cs-fZwnFRtplBoNkxaj6Ov5dVvLImyGZokcBXzQgzRhH4pjZ1aTGr7M
Message-ID: <CAPaKu7Se1jLiZ+6VNY=Ykf+nkMzu-q2r3UOdQ9Qf2DzpGNiCCQ@mail.gmail.com>
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

On Tue, May 19, 2026 at 12:53=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Mon, 18 May 2026 16:33:20 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
>
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > >         if (!ptdev->scheduler)
> > > > > > >                 return;
> > > > > > >
> > > > > > > -       atomic_or(events, &ptdev->scheduler->fw_events);
> > > > > > > -       sched_queue_work(ptdev->scheduler, fw_events);
> > > > > > > +       guard(spinlock_irqsave)(&ptdev->scheduler->events_loc=
k);
> > > > > > > +
> > > > > > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > > > > > +               sched_process_global_irq_locked(ptdev);
> > > > > > > +               events &=3D ~JOB_INT_GLOBAL_IF;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       while (events) {
> > > > > > > +               u32 csg_id =3D ffs(events) - 1;
> > > > > > > +
> > > > > > > +               sched_process_csg_irq_locked(ptdev, csg_id);
> > > > > > > +               events &=3D ~BIT(csg_id);
> > > > > > > +       }
> > > > > > This handles all fw events in the irq context. Are there concer=
ns that
> > > > > > it may take too long? I might be wrong, but it seems possible t=
o
> > > > > > handle only CSG_SYNC_UPDATE and defer the rest as before.
> > > > >
> > > > > I started with just the SYNC_UPDATE processing done in the hard-i=
rq
> > > > > context, but after auditing the other stuff done in the handler, =
I
> > > > > realized it's basically just deferring all actual processing to w=
ork
> > > > > items. Yes, there's the overhead of demuxing the events from the
> > > > > ack/req regs, but part of this is already done to get to SYNC_UPD=
ATE
> > > > > anyway, so at this point we're probably better off demuxing every=
thing
> > > > > and scheduling works for all kind of events.
> > > > >
> > > > > I also compared the perfs between the two approaches (though I di=
dn't
> > > > > do as much testing as I did with the new version, so I might have
> > > > > missed something), and it didn't seem to matter at all, because t=
he
> > > > > interrupts we receive the most are SYNC_UPDATE and IDLE events, a=
nd
> > > > > those are at the same level.
> > > > Looking at ftrace irq events, when there is one active csg,
> > > > panthor-job takes 6us (median) / 17us (95%) / 27us (slowest).
> > > >
> > > > I don't have a good sense if that's considered normal in hardirq. B=
ut
> > > > if that is ever an issue, and if the majority of the time is spent =
in
> > > > CSG_SYNC_UPDATE anyway, we can always revert the last patch to move
> > > > processing to threaded handler.
> > >
> > > Actually, the threaded -> hard transition (patch 9) is where the perf
> > > gain is.
> > hardirq is even more timely for sure. For our use case, the threaded
> > handler is RT and is also good enough.
>
> Yeah, true. I forgot you were forcing RT priority on threaded handlers.
> Anyway, let's stick to hardirqs for now, and revisit it if it proves to
> be too much work done in irq context.
Just want to clarify that irq_thread calls sched_set_fifo to make the
task RT. The behavior is universal and is not specific to any
downstream kernel.
