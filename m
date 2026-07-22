Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0185C531CD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4244610EFE4;
	Thu, 23 Jul 2026 07:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mjqtW/tG";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A8910E358
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:29:07 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-80bb41f7f3cso745277b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 16:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784762946; cv=none;
 d=google.com; s=arc-20260327;
 b=d/J8eOix0hy54XhM9xoTpLuaHgD76LJASlXbNZpfHs1KY3gtSkghuNnJ7oyiz8Cjnz
 hBj9H3rvcnUjGmmkGzcj7rGX2f7h5uD4KoSPQFDE4018DH1yoRtlkFuI2XnnzkNwK+HR
 bRRTXmybF6NNMCfTtk+r5PQ9S49ZWnKdfdHyoephg2JvwUasvLZKLsOVkVfO/JmNTeEC
 5H5NBe6ic7C7cJ2TId+vJwQ20xOzCgyq0iEE7sAe9cn+Xy/hW/cXaqHEAEDWzJNrGIW1
 /VVUD/I1/9MMX1/vsWh8OPSaZVJf0RK/YhEuWi2TCT52GV3w9BgMQ8TVRVdZsfb0b6u5
 f5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r/+tVIQa+UduMGfrWB40bPaCPG6RGoDkheXVQ+bMeMo=;
 fh=NO560NvT8j2tDCLQ3YY1SVvAK+qqM+ofswwe4BOpZNA=;
 b=nZ1GjGJi5/HtfolfjhpM8s5iBVPBKckoCZ2/KNSPB+VcvWzku5juq5ewViNJvV9hVy
 ktJQC9OlGLNyrBxhS1XbAU0vW/K7rp/bJ8Vb8ADjH5wjPXx3z6VyZ6MsCa4aGjUehBZe
 5HJZ15pYeKDOCIHNGUI8FDQNe5amJTG5B0empYLz8BZagBTTXKxA9p/XNFG9A85ADGT8
 eBpulUxy/fZktR7FCHk+TPMEhCpDij+7bsi6jtJswSVyB0JLeYAacxX14eLisz/ebHM/
 gwEe6KfewIj/0OYX6zdmAZZrJfYpAxmMg9WqEx1/Us3Raj/iEcrZPFTPyWSrOgvDVtx5
 T1+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784762946; x=1785367746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r/+tVIQa+UduMGfrWB40bPaCPG6RGoDkheXVQ+bMeMo=;
 b=mjqtW/tGdoF6ubGVlsPLFdD5Jy8G1YqKQSNlxz14emTa2okOnd/vTlwCLQP4kQjpBn
 CRyly8trI2MBV6mKfjjLsacuympgjytFHSkxSMHIXDaN9/BrLmxNCRF6Sht4mB9/puot
 O0kaGVCDE0167Hx2pQIUo5zYOYScnXGbQk8S4NxlemOf3oU9MLPd+saXx3wEsK9OjCSL
 d7xKuoiURCp1qb24uzx2QZ+AsJeXt/bO4Rs8dd4uv5MEU3FL7Hh9biW9pHA3Y88Plq0X
 JSpX8VeQK+QcYrCaynm0BuZDpwu8N1nKqL/W5oQ6WcESAim0bUYhhbzg7OG6myDBzbQV
 xGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784762946; x=1785367746;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r/+tVIQa+UduMGfrWB40bPaCPG6RGoDkheXVQ+bMeMo=;
 b=UdxBgDIqAU0tWMShfgi1EIQvTjjaoEqRZoRMGUG0nP1kMtaeSasO3l+zdNfy+Ql2Fl
 u6QqNnjdGReyJefZY3URqxywSYsWoszrME6/6+F9j1OYkvdgaeTL8FefGNuqs39735CQ
 /RL1WmHkq0qp1EqBN9+VDf+XJ+NKrOEU8y0TqsUh+/onxmbiGDCPQ6z29lNZZS0olUEL
 4WyIyRTMFJN99Z4yNisQMbJ68wijgO/UiQaCL10sDGGLO3J0iVpC5ehXWWWb3dZ2iB7O
 CPvsX5wgvCelzzbxfQUTbmb4QpeDQlvDdmDw9cRKkETzyc0Cz0L23biuVPYg8/BLJ1gi
 8cWw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqk6E77Uqic+M/lBiw3+Z0Ij1NPERO3wLUMkRXYWCvSH07FQYgMJyhedcZczeNAZadXRWYzzPj5OgY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZFVLOONRINzANNmyGaOaC1BgVnBCz6keHlTrluuSjBaNcrizb
 VooTYynqu3IQLAj+UEdQ2YeQMZtt6y1i7eWDdEEVdW00oJtiu9YGwXE4rtj78Srn/6BMQbZ4vTZ
 RPkhLTU2pSwWL7nxz0CDryklOw5DqbUc=
X-Gm-Gg: AR+sD13elJi6U3xIH7fgrcuNe2NyAPaO+gpm9OLNcPcymJLNX9b+n5d+N8R+HzVMsB/
 4bakcXCld8Fa0SLfedWx3LNON/VjKcPQb9zIJsnmCxRVs1LE3qutig6tnZw9PyP+Iqg8s3I7c9l
 dExVh5o2C9Ap7PVKDHfSmXZL9n+wmpI/FblsBfgUiregYmJW5c+ZXYOpAgGNtq9RdJ9Gdw816lt
 Z/a28AzKBDrrPdm1abYdGUHy+tJ+F8Okr1NuMAfe6rlbZOhVwcGilIXyHp9QjzhFQN6v3niGLgM
 LEfDeeGuKlkfWQCbPiYM4qo+rGPeWy4l7r754IPfQd+w2SL3
X-Received: by 2002:a05:690c:c458:b0:81e:8985:aa9 with SMTP id
 00721157ae682-81f4c2daf3dmr1946697b3.50.1784762946180; Wed, 22 Jul 2026
 16:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-4-talesam@gmail.com>
 <amExusdY0Qhs3LIx@gsse-cloud1.jf.intel.com>
 <amE+Ltrb8qKNKWd2@gsse-cloud1.jf.intel.com>
In-Reply-To: <amE+Ltrb8qKNKWd2@gsse-cloud1.jf.intel.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Wed, 22 Jul 2026 20:28:54 -0300
X-Gm-Features: AUfX_mwQwgPDcODL-DrlUpYlLjj-DlLsoD2FXc69mgh26Py5BQr-Sc2jsyjkWfQ
Message-ID: <CAHBRX4HbDnpiEqgFauZNMWPq+Wtp6RhYYLKMW=zNbTphAB_xgw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushing it
 in timeout paths
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

Hi Matt,

Thanks for the detailed look - and you're right about the framing.
Later instrumentation on this system (sampling G2H CTB head/tail in
the TDR *before* the flush) refuted the lost-wakeup theory from my
commit message: in every observed timeout (30+ events across two ARL
machines, 7d51 and 7dd1) the CTB is empty at timeout time (head =3D=3D
tail, 0 pending dwords), and the ack lands 5-475ms (median ~22ms)
later via the normal path. So the flush recovers nothing - the ack
simply hasn't been posted yet by the GuC at that point. The stall
appears to be firmware-side (GuC 70.53.0); I'm preparing a report with
the full data.

That also means I agree with dropping this patch, and the data is
consistent with your suspicion that LNL_FLUSH_WORK papers over nothing
here.

I'll test your series from
https://patchwork.freedesktop.org/series/170939/ on both ARL machines
(daily-driver workloads that reproduce the timeouts at ~1.5/h) and
report back.

 Thanks,
 Tales

Em qua., 22 de jul. de 2026 =C3=A0s 19:03, Matthew Brost
<matthew.brost@intel.com> escreveu:
>
> On Wed, Jul 22, 2026 at 02:10:18PM -0700, Matthew Brost wrote:
> > On Tue, Jul 21, 2026 at 09:46:53PM -0300, Tales A. Mendon=C3=A7a wrote:
> > > Timeout-recovery paths flush the G2H worker to pick up a response tha=
t
> > > may have been posted by the GuC but not yet processed:
> > >
> > >  - guc_ct_send_recv() after the 1s wait for a G2H response fails
> > >  - the TLB invalidation backend's .flush() hook, called by
> > >    xe_tlb_inval_fence_timeout() before declaring a fence timed out
> > >
> > > However flush_work() on a work item that is neither queued nor runnin=
g
> > > is a no-op. If the GUC2HOST interrupt for the response was lost or
> >
> > GUC2HOST messages getting lost are a different issue and would be
> > catastrophic for a variety of reasons. I'd like to dig into that if it
> > occurs on a POR platform (i.e., LNL+).
> >
> > > coalesced, the G2H worker was never queued: the flush does not read t=
he
> > > G2H CTB and the response sits there unprocessed until an unrelated G2=
H
> > > interrupt arrives. For TLB invalidations this results in
> > >
> > >   TLB invalidation fence timeout, seqno=3DN recv=3DN-1
> > >
> > > with the fence force-signalled with -ETIME even though the ack may
> > > already be present in the CTB. Observed sporadically on ARL-H under C=
PU
> > > load, always with recv =3D=3D seqno - 1 and self-recovering on the ne=
xt G2H
> > > interrupt, which is consistent with a lost wakeup rather than a
> > > GuC-side failure.
> > >
> > > Add xe_guc_ct_flush_g2h(), which queues the worker before flushing it=
,
> > > guaranteeing the flush always drains the CTB, and use it in both
> > > timeout paths. A spurious worker run is safe: g2h_read() returns no
> > > data under fast_lock, and receive_g2h() copes with runtime-PM state a=
nd
> > > disabled CT communication.
> > >
> > > After this change the fence-timeout error only fires when the ack is
> > > genuinely absent from the CTB, making the message a reliable indicato=
r
> > > of a GuC-side stall.
> > >
> > > Signed-off-by: Tales A. Mendon=C3=A7a <talesam@gmail.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_guc_ct.c        | 23 ++++++++++++++++++++++-
> > >  drivers/gpu/drm/xe/xe_guc_ct.h        |  1 +
> > >  drivers/gpu/drm/xe/xe_guc_tlb_inval.c |  2 +-
> > >  3 files changed, 24 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_g=
uc_ct.c
> > > index fe70c0fd85c..11a05c2b8c7 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> > > @@ -1377,7 +1377,7 @@ static int guc_ct_send_recv(struct xe_guc_ct *c=
t, const u32 *action, u32 len,
> > >  wait_again:
> > >     ret =3D wait_event_timeout(ct->g2h_fence_wq, READ_ONCE(g2h_fence.=
done), HZ);
> > >     if (!ret) {
> > > -           LNL_FLUSH_WORK(&ct->g2h_worker);
> > > +           xe_guc_ct_flush_g2h(ct);
> > >             if (READ_ONCE(g2h_fence.done)) {
> > >                     xe_gt_warn(gt, "G2H fence %u, action %04x, done\n=
",
> > >                                g2h_fence.seqno, action[0]);
> > > @@ -2046,6 +2046,27 @@ static void g2h_worker_func(struct work_struct=
 *w)
> > >     receive_g2h(ct);
> > >  }
> > >
> > > +/**
> > > + * xe_guc_ct_flush_g2h() - Force processing of pending G2H messages
> > > + * @ct: GuC CT object
> > > + *
> > > + * The GUC2HOST interrupt for a G2H message may be lost or coalesced=
. When
> > > + * that happens the G2H worker is never queued and flushing it is a =
no-op
> > > + * that does not read the G2H CTB, leaving messages the GuC has alre=
ady
> > > + * posted unprocessed until the next interrupt arrives. Queue the wo=
rker
> > > + * before flushing it so the flush always drains the G2H CTB. A spur=
ious
> > > + * worker run is safe: it returns without side effects if the CTB is=
 empty
> > > + * or CT communication is disabled.
> > > + */
> > > +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct)
> > > +{
> > > +   if (!xe_guc_ct_enabled(ct))
> > > +           return;
> > > +
> > > +   queue_work(ct->g2h_wq, &ct->g2h_worker);
> >
> > If the original queued work gets lost or is never submitted, then there
> > is a bug somewhere else in the kernel, as mentioned above.
> >
> > As for the flush part, yes, it's possible that this could take a while
> > if the scheduler goes out to lunch, but it shouldn't happen with a
> > sufficiently large timeout. Have you tried making the GuC CT worker hig=
h
> > priority? We could also consider making the G2H handlers RT once those
> > land upstream.
> >
> > In general, I'm quite unhappy with the existing LNL_FLUSH_WORK, and we
> > never determined the root cause of the original issue. In retrospect, w=
e
> > probably should never have merged that code. Looking at it now, the LNL
> > flush code isn't even scoped to LNL, which makes this even worse than I
> > initially thought, as it can paper over bugs. I'm going to post a patch
> > to scope the existing workaround to LNL and earlier platforms (or maybe
> > just removing it completely) and see what happens in our CI over the
> > next several months before it makes its way into a kernel release.
> >
> > With that said, the patch as proposed is a no from me. If you want to
> > pursue my suggestion of scoping this change to LNL and earlier
> > platforms, we can discuss that separately.
>
> This is roughly what I had in mind:
>
> https://patchwork.freedesktop.org/series/170939/
>
> Compile tested only, so if you could give it try and see what pops up, I
> think that would be helpful. Fell free to use the code in anyway and
> give me feedback.
>
> Matt
>
> >
> > Matt
> >
> > > +   flush_work(&ct->g2h_worker);
> > > +}
> > > +
> > >  static struct xe_guc_ct_snapshot *guc_ct_snapshot_alloc(struct xe_gu=
c_ct *ct, bool atomic,
> > >                                                     bool want_ctb)
> > >  {
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_g=
uc_ct.h
> > > index 767365a33de..4e0338953f1 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_ct.h
> > > +++ b/drivers/gpu/drm/xe/xe_guc_ct.h
> > > @@ -22,6 +22,7 @@ void xe_guc_ct_runtime_suspend(struct xe_guc_ct *ct=
);
> > >  void xe_guc_ct_stop(struct xe_guc_ct *ct);
> > >  void xe_guc_ct_flush_and_stop(struct xe_guc_ct *ct);
> > >  void xe_guc_ct_fast_path(struct xe_guc_ct *ct);
> > > +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct);
> > >
> > >  struct xe_guc_ct_snapshot *xe_guc_ct_snapshot_capture(struct xe_guc_=
ct *ct);
> > >  void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot, s=
truct drm_printer *p);
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/=
xe/xe_guc_tlb_inval.c
> > > index 046d0655122..91960dc4ba9 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> > > @@ -327,7 +327,7 @@ static void tlb_inval_flush(struct xe_tlb_inval *=
tlb_inval)
> > >  {
> > >     struct xe_guc *guc =3D tlb_inval->private;
> > >
> > > -   LNL_FLUSH_WORK(&guc->ct.g2h_worker);
> > > +   xe_guc_ct_flush_g2h(&guc->ct);
> > >  }
> > >
> > >  static long tlb_inval_timeout_delay(struct xe_tlb_inval *tlb_inval)
> > > --
> > > 2.55.0
> > >



--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
