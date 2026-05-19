Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0494FCD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 21:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4E410E3DC;
	Tue, 19 May 2026 21:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ABG9WtTa";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDAB10E3DC
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 21:04:59 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7cd35604a95so30658807b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779224699; cv=none;
 d=google.com; s=arc-20240605;
 b=MZBvqqVeUJofS7/K3jETl4CxfFZZzwwZFyYqZc1EcraXiP2PBMM31em79nvJmwbXVV
 gKNZmw36mwRcVDanpp6CrIugnP75TyPoM9cZbqWWH0qPKeAxxp8YB2hJQavw9qux4TeR
 6hA/HNBZ9PueL4KOK62KxFFYAMzdiVlzQ49tl/pA9XhtMOwQ9BzZ8iWW+14dZVYiwwIx
 +aCE6pXccmYIosgOSqJwsNfqm63kG7nMr+JPIXT6qe/DJ8tlWeZUIKw7VMTNuDOAY/ve
 2DHJ3yPGdvvTq/YBDPgcDl68rCpu07JZihuH1Ga6BSGqohUq+n3z0+jVTpLly9fGlHvM
 uy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZX3/5w0E+ZsFrn8cOcVB2J1HZOEsbltniJtchDF/dOA=;
 fh=WADU9SXf2Ph7oEV8cQh+dDGyDaEjv8kHSpFno1CqvgE=;
 b=D2SPGH52LaiWC3rioxoZZKWzWP/b8KCXj6okqyFfM0LAuc2ASYRHHzytuXaJY/QRJb
 759/bDbDoM+fqy0ze12yukRle+7QeN153GCQigCfpdJOkUcJfeq3op9SK7pmxON51h/g
 YNZWQ+gRcnQFebCGQXBW0QA1DeM9mKINFTRvI7zxMoh4UGGTJ9EdI+jxYNNJzhZaSrU3
 SWZiM6PdLSjs7EKz7Pz5KlyFdu1omktFF3eEAocnzvw8WLAR8BGjD7y3InANUc0Tu9xn
 Sifnw/NMF4T15oyzc31ycd1FzFbmPJcevB3tMPkEuTeG3UuKMF5EqEgru+kwxl0zIK4n
 zY8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779224699; x=1779829499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZX3/5w0E+ZsFrn8cOcVB2J1HZOEsbltniJtchDF/dOA=;
 b=ABG9WtTaSWVgtdXvy7AOqjL6iNvVkukQpGVKaPsbCXMo7RsiTp9dpevddJ9DYgbXrW
 x4jBtapOPN7KrRF5+3DF+Wr7dPVyjKnjKTFUkigqwBaYaB45daBrU3h5SdCyxM5Yl5kn
 VcNpzfEaTFGQ1+X4wbIKlvX/POlyFFAcoV6Gw+dhbhG4NpgAJugfYVNVUpfscRm+uEL8
 IxHTlibk12U8uB+C/vLXvPCPlNyD015imcRcmK52FqgIGpnCfS5YRwKN3TWjci97jFsF
 IIx6BJPJtGahgrFuQ3VSE3rb42UDhpZ22AyQVp3XdVPkEFztPmAuT0amTD8lKEbjOJcf
 ZVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779224699; x=1779829499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZX3/5w0E+ZsFrn8cOcVB2J1HZOEsbltniJtchDF/dOA=;
 b=l/ole6WJkewy81zfMtKNaGHod7vl/U+9/p7UyAZHLwPcVTPgIFt+ODjlT7XIyivxnc
 YdNYGeomYkPf5/ne3PZFBjv/c8uQWgFHCxa+V0vJualBbjr1mEd9/eRifshA2W3AoZ+O
 2EzjFfw+JS7Gc2KiMhlMwMg19LuG0UH0UBjEhfpWWp7h5GZ/GmKeeq6VxGoZQi0BQKg7
 xWTw44CT8AJObFsii2y6wmtydFoVdOSltjbn8cRz0Q+T6m/mskfrE8SSzXjHFZqmBazl
 4L+d3ohrLHsDdqDl71/ZrvupG4RJv+UJ7+Fb18GnyGgovI4SGyyp0e0zl09SCol6ynre
 H+Jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZK2yja14HD1O0HxGLulYS6sDOyF7IPJ9DA8ypNeewc1/evsAq+GJobYGeYcplesIqoCdaJhWEFKo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRZG9j8UcdUrZ6izs0lV4umO6Un+Sx/tCD7RHuurV/cqHOLTVp
 5PAsKOJ7hwoHGryfqjdRZSvDp0YrK1ctbZ4lnWGkyN29/v5aQFrAc5oTK+UG3qB7bdrA8Hv7JJj
 1Fuva9a7aQJAOjRRfV1EU9+gOwrlQAL8=
X-Gm-Gg: Acq92OEGNKhiOpAusfqhL4J5NyYuyCWydyF9I0Oz6+i4jMeNbxJuQSuT/8aUPfSgySo
 v/7BqSPRAQKb0FNmats8jvYrW2JiZWE7R1XCCSn0H2kb/EBOGPdUf/orNi18O1pJ8PWdK3ucQLy
 8dDkEfRjTap4AtkCk4Ve8QRkvrvmdETpmCPskX5AbvyGmHVVPDsIv4uq/49Ge7y8vpSvySyV3Q+
 Fcakm6sin4097MkQI49dMdzvN6Q22avaVnK5EYLbxOA54yZ7mliFyfKMaDjrgOKinEjSZ+P4ksr
 qE4OcrGA4bamE687/IezaktaHntYU6SMUj1EGlqKE3L139FWiowebBLzeJ4wCTx6hiKQulxX
X-Received: by 2002:a05:690c:c155:b0:7ba:dcae:14dd with SMTP id
 00721157ae682-7c948ef4cc1mr169130277b3.19.1779224698625; Tue, 19 May 2026
 14:04:58 -0700 (PDT)
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
In-Reply-To: <CAPaKu7TUmZcAJLmub0Xu-wsFOGeQp0zwrhXKLavBo9E=83kSdA@mail.gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 19 May 2026 14:04:47 -0700
X-Gm-Features: AVHnY4KsgINpMyLN-RNwhOem1Zbo48bSE-7QAlWYiZ34UQsGzqqN7D5_yEDIe0Q
Message-ID: <CAPaKu7ToQmHHhTyb-az_b7EG2iRpc23=AJOYQ5P=HgrG29bS1A@mail.gmail.com>
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

On Tue, May 19, 2026 at 1:45=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote=
:
>
> On Tue, May 19, 2026 at 11:26=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Tue, 19 May 2026 10:16:26 -0700
> > Chia-I Wu <olvaffe@gmail.com> wrote:
> >
> > > On Tue, May 19, 2026 at 12:53=E2=80=AFAM Boris Brezillon
> > > <boris.brezillon@collabora.com> wrote:
> > > >
> > > > On Mon, 18 May 2026 16:33:20 -0700
> > > > Chia-I Wu <olvaffe@gmail.com> wrote:
> > > >
> > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >         if (!ptdev->scheduler)
> > > > > > > > > >                 return;
> > > > > > > > > >
> > > > > > > > > > -       atomic_or(events, &ptdev->scheduler->fw_events)=
;
> > > > > > > > > > -       sched_queue_work(ptdev->scheduler, fw_events);
> > > > > > > > > > +       guard(spinlock_irqsave)(&ptdev->scheduler->even=
ts_lock);
> > > > > > > > > > +
> > > > > > > > > > +       if (events & JOB_INT_GLOBAL_IF) {
> > > > > > > > > > +               sched_process_global_irq_locked(ptdev);
> > > > > > > > > > +               events &=3D ~JOB_INT_GLOBAL_IF;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       while (events) {
> > > > > > > > > > +               u32 csg_id =3D ffs(events) - 1;
> > > > > > > > > > +
> > > > > > > > > > +               sched_process_csg_irq_locked(ptdev, csg=
_id);
> > > > > > > > > > +               events &=3D ~BIT(csg_id);
> > > > > > > > > > +       }
> > > > > > > > > This handles all fw events in the irq context. Are there =
concerns that
> > > > > > > > > it may take too long? I might be wrong, but it seems poss=
ible to
> > > > > > > > > handle only CSG_SYNC_UPDATE and defer the rest as before.
> > > > > > > >
> > > > > > > > I started with just the SYNC_UPDATE processing done in the =
hard-irq
> > > > > > > > context, but after auditing the other stuff done in the han=
dler, I
> > > > > > > > realized it's basically just deferring all actual processin=
g to work
> > > > > > > > items. Yes, there's the overhead of demuxing the events fro=
m the
> > > > > > > > ack/req regs, but part of this is already done to get to SY=
NC_UPDATE
> > > > > > > > anyway, so at this point we're probably better off demuxing=
 everything
> > > > > > > > and scheduling works for all kind of events.
> > > > > > > >
> > > > > > > > I also compared the perfs between the two approaches (thoug=
h I didn't
> > > > > > > > do as much testing as I did with the new version, so I migh=
t have
> > > > > > > > missed something), and it didn't seem to matter at all, bec=
ause the
> > > > > > > > interrupts we receive the most are SYNC_UPDATE and IDLE eve=
nts, and
> > > > > > > > those are at the same level.
> > > > > > > Looking at ftrace irq events, when there is one active csg,
> > > > > > > panthor-job takes 6us (median) / 17us (95%) / 27us (slowest).
> > > > > > >
> > > > > > > I don't have a good sense if that's considered normal in hard=
irq. But
> > > > > > > if that is ever an issue, and if the majority of the time is =
spent in
> > > > > > > CSG_SYNC_UPDATE anyway, we can always revert the last patch t=
o move
> > > > > > > processing to threaded handler.
> > > > > >
> > > > > > Actually, the threaded -> hard transition (patch 9) is where th=
e perf
> > > > > > gain is.
> > > > > hardirq is even more timely for sure. For our use case, the threa=
ded
> > > > > handler is RT and is also good enough.
> > > >
> > > > Yeah, true. I forgot you were forcing RT priority on threaded handl=
ers.
> > > > Anyway, let's stick to hardirqs for now, and revisit it if it prove=
s to
> > > > be too much work done in irq context.
> > > Just want to clarify that irq_thread calls sched_set_fifo to make the
> > > task RT. The behavior is universal and is not specific to any
> > > downstream kernel.
> >
> > Hm, interesting. In my testing, any of the changes before patch 9
> > didn't make a huge difference in term of perf, patch 9 is where the per=
f
> > gains happen. For the record, patch 6 is where we get rid of the
> > threaded -> work round-trip for job completion/fence signaling, and it
> > didn't seem to reflect in the benchmark results, but I'll do another
> > round of tests before posting v3, just to confirm.
> We care the most about signaling latency for this series. I collected
> some numbers with baseline, with this series, and with patch 9
> reverted at https://gitlab.freedesktop.org/panfrost/linux/-/work_items/85=
#note_3481308.
> Reposting the numbers here for reference
>
> |                    | baseline | entire series | patch 9 reverted |
> | -                  | -        | -             | -                |
> | frag job median    | 2.8ms    | 2.2ms         | 2.2ms            |
> | frag job 95%       | 4.5ms    | 2.8ms         | 2.8ms            |
> | frag job 99%       | 4.9ms    | 2.8ms         | 2.8ms            |
> | panthor-job median | 0.8us    | 6.2us         | 0.9us            |
> | panthor-job 95%    | 1.5us    | 16.6us        | 1.5us            |
> | panthor-job 99%    | 1.6us    | 28.0us        | 1.8us            |

panthor-job rows are the durations of the raw irq handlers, collected
from irq/irq_handler_{entry,exit}.

frag job rows are the durations from frag jobs, collected from
gpu_scheduler/drm_sched_job_{run,done}.

The fence signaling paths of them are

 - baseline: raw handler -> rt threaded handler -> wq job -> wq job ->
fence signal
 - entire series: raw handler -> fence signal
 - patch 9 reverted: raw handler -> rt threaded handler -> fence signal

This is a synthetic test with a busy userspace. The higher durations
and variances of the baseline main come from the scheduling latencies
of wq jobs.
