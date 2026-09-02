Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C189C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6610D10E94A;
	Thu,  3 Sep 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRSd5nzW";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA13C10F0D4
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:57:40 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so1577927a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 02:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788343059; cv=none;
 d=google.com; s=arc-20260327;
 b=QomLHPO+9QLEfExq577H1CQF0dUytZlbrw59JWxepkBPxHM5/dlpRbu6B7cygV6Gjl
 jh+5MZtgRC3eCl89Swi0GHezUtmP7F/7VtwW6872qY2v5FNqQ6cGbLpnGOkKV6zQPHmQ
 YM48kKse/kYBDeEfVyYuK5NKMuhoipV2DLj7VQzAeoQtmpl1wwCrVEyE/7RjoD4yFhvc
 IZOOFP4XOqp2V9r3UaYKy3MZJTKIWcn8RB8w1n3Vs2GsYs52IiZ5F03XXVU3Ou+lZfm+
 ya9tPIsK6yaR7kW0h469nd937wPSW2/uy9NShqN0b7esrwlzetNDnuDW+ZM1C3PJbjm5
 R0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=HMq2KXEsa4xrE5GkpQ4iRFzBjuYxTsGVzCrkCJ4J1pc=;
 fh=33kpMo9ofhPyqI0Dtk8JxmdYlZ+V8s8JJPRnh5eHIoQ=;
 b=pE1PvBihvA5VTJtdRefMVXr/OEkSDWZRI07Zm+HOj7t1zmX4XK+BUFKVAuNg37I2Cz
 J9gQ/eEEBa6IP1122D12zm3yFSUYy8OyFIQ5z3QQgheaByVYAhElYyhlAGXSgTjYErAN
 n9GMllGvCLiNwFCTlANM5wBptxzlTpZVhoku3xNDipD8cqqXBWbLPNrDVw8aOpYiS+0q
 eOjx7Te+D9uEE/YbuWC8DPGO4MND9Ko40oMT/9+rdW3Oix5cHj5hM2KmDu+YOfhg/s4A
 I18WdpdsZXMFH0aqCTWZup0yXJZCwSRbXoRdrBoXlp2ET5ZppOXrcbTUQnzAO089vOia
 ZdNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788343059; x=1788947859; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HMq2KXEsa4xrE5GkpQ4iRFzBjuYxTsGVzCrkCJ4J1pc=;
 b=gRSd5nzWNgUfLOzokkqn3ad80wyjkVn7iPjazgwnQUOjJIsgKrYSsMnU3v3yRTQtD1
 99SQTuLw1i8ED65NVe0O4LlaOffvOrVZ9CrmR53nKYBoA0BhVHx/XFxUyCnnF3V+1FHr
 UW6tJ6FT2xPmX7zbak4HFmAu7fN44/KvgTw/DpXTcUe+6rIqRVaBpCB4r7kJVNA419X8
 xF2vtUti6yT5mSpZWhetQDgz1yOG19QnENopN1h/rgkPOcEacuWzkZgtJLv6B57vCM/A
 3+426QzllrZuvnVMo4pR1xvFaSQleANKOi4z7NcHM0JFFSdVR4WJVU/RT0f4JXrIIWVk
 OPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788343059; x=1788947859;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HMq2KXEsa4xrE5GkpQ4iRFzBjuYxTsGVzCrkCJ4J1pc=;
 b=PoUzV1O3t/xz/E6E3RCA0nvPDA+wPEsC+2Cr3+2T0K8G4dj+5qeE5jUWBMu0rCNiJz
 OZDvc2iwn9RhP9mc/zWeKKA5XaTQf2wC3yMNLs3W+DAkNOw2xQgxX3iINX+7/QwnW3Ue
 euIrzS9Az4PCzH4AlXljh8C9ud9ZkLZW/XiY3nxLOQegHvIID1FX7DclBwfxvYZw+4jg
 /HzFpwT3WJlVfP+dyQsJoM3EFTYYmyu8+9O+w/6Mp2/7zJLjt2UCCGR4yHn55BRKXl7z
 gyzwkQ27QNZR47vFAsATzDv+qKWAUB60cl3X+0Ig5YmJ8i4DGh0dGj7mK5416h9sRu4n
 U/0g==
X-Forwarded-Encrypted: i=1;
 AKwUvByIksuJXqr4agLbJM0x2e8jcGIP2cJ9SUjg3IojMgzw6OZ9N9hXZJMWxXVBGOqXZtPjggCp0sWIp0Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l+ovnDLwTq/iSS42fB6LQUzCih6NUbPLmXxP+mx6thoUuMfVuK
 4CM60TQHdFE3CHEK5mKchnub8K2VVGA7juUnWOlRQHm4lFWydqDI8Eo9SP1Rb3jcvAA6cZVMi3i
 pgCCQl5mGZkyaKzFCM/orOhraUs0ubQ==
X-Gm-Gg: AYBFou03EshwRDmdOUyFvLaqCV1HKYAc+/bYIjUVUA/8mN4cSahIDD2W0E60glIcBPr
 7c46pxj+HwPiYEpmOE3YMq/IbA4sY17yXBOZTnhn+th4HIUBztaLdRcGw7XJP5P34phwrd2pse8
 hTX4jbV7afv0c6/bXwkMLW07Yc+Nj70orhQNX3hzRlpE8Ka1i397nGkGKzmcrUbDhlWQUKScpQY
 Jn+7pd4gwZMMdbjp3Q1Y/RdIHx94V/GVxNE4dc7VmySTx93jglrFq1nDOhijlRxv0iCwX0flMDP
 q1DTYXXf4KXvfDCy9Uz8wVht6kB0o25PBQWWK1kle0E5zyv3osy2mPuDW1HhrE9u/f4uGO7PSLo
 v8TDNc1nGtDCGcm2r534Wexkfrf49dNlwgk6bvS0=
X-Received: by 2002:a05:6402:218a:b0:6a6:1719:3f42 with SMTP id
 4fb4d7f45d1cf-6a68257c26dmr2790432a12.6.1788343058771; Wed, 02 Sep 2026
 02:57:38 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 02:57:37 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 02:57:37 -0700
From: =?UTF-8?B?6rmA7KKF7ZiB?= <malhyuk97@gmail.com>
In-Reply-To: <8c2a4df5-37a4-414e-81e2-cd97218e5355@ursulin.net>
References: <8c2a4df5-37a4-414e-81e2-cd97218e5355@ursulin.net>
MIME-Version: 1.0
Date: Wed, 2 Sep 2026 02:57:37 -0700
X-Gm-Features: AcwNN1XCZByMlzp0aL_uUxHazC1_xjxezcVb-o2ARV0BJr5sZPivwGowSbyymhE
Message-ID: <CADQRuqtjBu7wR4kKVDcS42KLKQTr+7SBtRn24mgZ+ApettMr1A@mail.gmail.com>
Subject: Re: Re: [PATCH v1 1/2] drm/sched: cache the timeline name to fix a
 use-after-free
To: tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org, 
 phasta@kernel.org
Cc: christian.koenig@amd.com, ckoenig.leichtzumerken@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000c131ed065a7d10bb"
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

--000000000000c131ed065a7d10bb
Content-Type: text/plain; charset="UTF-8"

On 02/09/2026 10:46, Tvrtko Ursulin wrote:
> It is not guaranteed in the documented contract that the name passed to
> drm_sched_init has to outlive the scheduler.

Right. Caching the bare pointer only works because every in-tree driver
passes a string literal today - xe's q->name (freed with the exec queue,
hence 299bc6d50b1b) is the counter-example where v1 would still dangle.

> Hm, that might be overkill.. how about we just keep a copy of the name
> in the scheduler object?

The catch is the scheduler object is itself freed on context teardown, so
a copy that lives there dangles for the exported fence just the same. To
actually stop dereferencing ->sched the copy has to live in the fence -
kstrdup in drm_sched_fence_init(), freed from the fence release. That's an
alloc per fence on the submit path though.

If that overhead isn't wanted, the lighter option is to keep the pointer
and document in gpu_scheduler.h that the drm_sched_init() name must follow
the dma-fence safe access rules (outlive any exported fence). That matches
what the already-fixed drivers do and leaves the submit path untouched.

Either one fixes amdxdna/nouveau/msm in the core. I'd lean to the
documented-pointer version unless you'd rather pay the kstrdup - let me know
which and I'll respin as a core-only series (fix + the kunit test).

Thanks for the 6bd90e700b42/299bc6d50b1b context, that clears up what the
half-fix missed.

Jonghyuk Kim(MalHyuk)

On Wed, Sep 02, 2026 06:46 PM, Tvrtko Ursulin <tursulin@ursulin.net> wrote:

>
> + Christian's AMD email
>
> On 28/08/2026 15:57, Jonghyuk Kim(MalHyuk) wrote:
> > drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
> > drm_sched_fence ops keep a .release callback, so the fence is not
> > ops-detached on signalling (dma_fence_signal_timestamp_locked() only
> > clears ->ops for fences without .release/.wait). The callback therefore
> > stays reachable on a long-signalled, userspace-held finished fence and
> > unconditionally dereferences fence->sched.
> >
> > A driver that allocates a drm_gpu_scheduler at per-context/per-queue/
> > per-VM granularity and frees it on an unprivileged context/fd close,
> while
> > exporting the resulting finished fence to userspace (drm_syncobj /
> > sync_file / dma_resv), leaves fence->sched dangling after the free. A
> > subsequent SYNC_IOC_FILE_INFO ioctl (which calls get_timeline_name())
> > then reads the freed scheduler:
> >
> >    BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name
> >
> > This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
> > (drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm
> > (VM_BIND) are still affected in mainline, so fix it in the core to cover
> > any per-context-scheduler driver at once.
> >
> > Scheduler names are persistent strings (string literals passed to
> > drm_sched_init()), so cache the name pointer in the fence at init time,
> > while the scheduler is guaranteed alive, and return the cached value from
> > get_timeline_name() without dereferencing fence->sched.
>
> It is not guaranteed in the documented contract that the name passed to
> drm_sched_init has to outlive the scheduler.
>
> Case in point is asking "would have this patch fixed CVE-2025-38703" -
> to which I think answer is no. Until recent 299bc6d50b1b ("drm/xe/guc:
> Keep scheduler timeline name alive") my attempt in 6bd90e700b42
> ("drm/xe: Make dma-fences compliant with the safe access rules") only
> half fixed it by adding a RCU grace to the sched object itself, while
> missing the fact timeline name gets freed instantly. I haven't gotten
> round trying to understand why KASAN did not catch this back when I was
> upstreaming 6bd90e700b42.
>
> Anyway, I think the fix will have to be to either add the full RCU grace
> around names in the scheduler object owning modules, or your patch plus
> documenting that the name passed to drm_sched_init must follow the
> dma-fence safe access rules (with kernel-doc cross-link and an
> explanation of the connection between scheduler name and dma-fence
> timeline name).
>
> Hm, that might be overkill.. how about we just keep a copy of the name
> in the scheduler object? If we document that in gpu_scheduler.h it would
> fix the drivers still vulnerable, while the ones which were fixed could
> be simplified.
>
> Regards,
>
> Tvrtko
>
> > Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
> > ---
> >   drivers/gpu/drm/scheduler/sched_fence.c | 16 +++++++++++++++-
> >   include/drm/gpu_scheduler.h             | 11 +++++++++++
> >   2 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/scheduler/sched_fence.c
> b/drivers/gpu/drm/scheduler/sched_fence.c
> > index 85ee3d694dc9..280a2d036ffd 100644
> > --- a/drivers/gpu/drm/scheduler/sched_fence.c
> > +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> > @@ -92,7 +92,13 @@ static const char *drm_sched_fence_get_driver_name(struct
> dma_fence *fence)
> >   static const char *drm_sched_fence_get_timeline_name(struct dma_fence
> *f)
> >   {
> >       struct drm_sched_fence *fence = to_drm_sched_fence(f);
> > -     return (const char *)fence->sched->name;
> > +
> > +     /*
> > +      * Do not dereference fence->sched here: a userspace-held finished
> > +      * fence can outlive a per-context scheduler. Return the name
> cached
> > +      * in drm_sched_fence_init() instead.
> > +      */
> > +     return fence->sched_name;
> >   }
> >
> >   static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
> > @@ -228,6 +234,14 @@ void drm_sched_fence_init(struct drm_sched_fence
> *fence,
> >       unsigned seq;
> >
> >       fence->sched = container_of(entity->rq, typeof(*fence->sched), rq);
> > +     /*
> > +      * Cache the scheduler's timeline name: the finished fence may be
> > +      * exported to userspace and outlive @sched (per-context schedulers
> > +      * are freed on context teardown), so get_timeline_name() must not
> > +      * dereference @sched. Scheduler names are persistent (string
> > +      * literals passed to drm_sched_init()).
> > +      */
> > +     fence->sched_name = fence->sched->name;
> >       seq = atomic_inc_return(&entity->fence_seq);
> >       dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
> >                      &fence->lock, entity->fence_context, seq);
> > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > index d61c19e78182..4f780d70acb6 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -305,6 +305,17 @@ struct drm_sched_fence {
> >            * belongs to.
> >            */
> >       struct drm_gpu_scheduler        *sched;
> > +     /**
> > +      * @sched_name: the timeline name of @sched, cached at init time.
> > +      *
> > +      * &drm_sched_fence.finished may be exported to userspace (via a
> > +      * sync_file or drm_syncobj) and can outlive @sched: a driver
> using a
> > +      * per-context scheduler frees it on context teardown while a
> > +      * userspace-held finished fence still references it. The
> > +      * get_timeline_name() callback must therefore not dereference
> @sched;
> > +      * it returns this cached name instead.
> > +      */
> > +     const char                      *sched_name;
> >           /**
> >            * @lock: the lock used by the scheduled and the finished
> fences.
> >            */
>
>

--000000000000c131ed065a7d10bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">On 02/09/2026 10:46, Tvrtko Ursulin wrote:<br=
>&gt; It is not guaranteed in the documented contract that the name passed =
to<br>&gt; drm_sched_init has to outlive the scheduler.<br><br>Right. Cachi=
ng the bare pointer only works because every in-tree driver<br>passes a str=
ing literal today - xe&#39;s q-&gt;name (freed with the exec queue,<br>henc=
e 299bc6d50b1b) is the counter-example where v1 would still dangle.<br><br>=
&gt; Hm, that might be overkill.. how about we just keep a copy of the name=
<br>&gt; in the scheduler object?<br><br>The catch is the scheduler object =
is itself freed on context teardown, so<br>a copy that lives there dangles =
for the exported fence just the same. To<br>actually stop dereferencing -&g=
t;sched the copy has to live in the fence -<br>kstrdup in drm_sched_fence_i=
nit(), freed from the fence release. That&#39;s an<br>alloc per fence on th=
e submit path though.<br><br>If that overhead isn&#39;t wanted, the lighter=
 option is to keep the pointer<br>and document in gpu_scheduler.h that the =
drm_sched_init() name must follow<br>the dma-fence safe access rules (outli=
ve any exported fence). That matches<br>what the already-fixed drivers do a=
nd leaves the submit path untouched.<br><br>Either one fixes amdxdna/nouvea=
u/msm in the core. I&#39;d lean to the<br>documented-pointer version unless=
 you&#39;d rather pay the kstrdup - let me know<br>which and I&#39;ll respi=
n as a core-only series (fix + the kunit test).<br><br>Thanks for the 6bd90=
e700b42/299bc6d50b1b context, that clears up what the<br>half-fix missed.<b=
r><br>Jonghyuk Kim(MalHyuk)</div></body></html><br><div class=3D"gmail_extr=
a"><div>On Wed, Sep 02, 2026 06:46 PM, Tvrtko Ursulin &lt;<a href=3D"mailto=
:tursulin@ursulin.net">tursulin@ursulin.net</a>&gt; wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><br>
+ Christian&#39;s AMD email<br>
<br>
On 28/08/2026 15:57, Jonghyuk Kim(MalHyuk) wrote:<br>
&gt; drm_sched_fence_get_timeline_n<wbr>ame() returns fence-&gt;sched-&gt;n=
ame, and the<br>
&gt; drm_sched_fence ops keep a .release callback, so the fence is not<br>
&gt; ops-detached on signalling (dma_fence_signal_timestamp_lo<wbr>cked() o=
nly<br>
&gt; clears -&gt;ops for fences without .release/.wait). The callback there=
fore<br>
&gt; stays reachable on a long-signalled, userspace-held finished fence and=
<br>
&gt; unconditionally dereferences fence-&gt;sched.<br>
&gt; <br>
&gt; A driver that allocates a drm_gpu_scheduler at per-context/per-queue/<=
br>
&gt; per-VM granularity and frees it on an unprivileged context/fd close, w=
hile<br>
&gt; exporting the resulting finished fence to userspace (drm_syncobj /<br>
&gt; sync_file / dma_resv), leaves fence-&gt;sched dangling after the free.=
 A<br>
&gt; subsequent SYNC_IOC_FILE_INFO ioctl (which calls get_timeline_name())<=
br>
&gt; then reads the freed scheduler:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 BUG: KASAN: slab-use-after-free in drm_sched_fence_get_ti=
meline_n<wbr>ame<br>
&gt; <br>
&gt; This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302<b=
r>
&gt; (drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm<b=
r>
&gt; (VM_BIND) are still affected in mainline, so fix it in the core to cov=
er<br>
&gt; any per-context-scheduler driver at once.<br>
&gt; <br>
&gt; Scheduler names are persistent strings (string literals passed to<br>
&gt; drm_sched_init()), so cache the name pointer in the fence at init time=
,<br>
&gt; while the scheduler is guaranteed alive, and return the cached value f=
rom<br>
&gt; get_timeline_name() without dereferencing fence-&gt;sched.<br>
<br>
It is not guaranteed in the documented contract that the name passed to <br=
>
drm_sched_init has to outlive the scheduler.<br>
<br>
Case in point is asking &quot;would have this patch fixed CVE-2025-38703&qu=
ot; - <br>
to which I think answer is no. Until recent 299bc6d50b1b (&quot;drm/xe/guc:=
 <br>
Keep scheduler timeline name alive&quot;) my attempt in 6bd90e700b42 <br>
(&quot;drm/xe: Make dma-fences compliant with the safe access rules&quot;) =
only <br>
half fixed it by adding a RCU grace to the sched object itself, while <br>
missing the fact timeline name gets freed instantly. I haven&#39;t gotten <=
br>
round trying to understand why KASAN did not catch this back when I was <br=
>
upstreaming 6bd90e700b42.<br>
<br>
Anyway, I think the fix will have to be to either add the full RCU grace <b=
r>
around names in the scheduler object owning modules, or your patch plus <br=
>
documenting that the name passed to drm_sched_init must follow the <br>
dma-fence safe access rules (with kernel-doc cross-link and an <br>
explanation of the connection between scheduler name and dma-fence <br>
timeline name).<br>
<br>
Hm, that might be overkill.. how about we just keep a copy of the name <br>
in the scheduler object? If we document that in gpu_scheduler.h it would <b=
r>
fix the drivers still vulnerable, while the ones which were fixed could <br=
>
be simplified.<br>
<br>
Regards,<br>
<br>
Tvrtko<br>
<br>
&gt; Signed-off-by: Jonghyuk Kim(MalHyuk) &lt;<a href=3D"mailto:malhyuk97@g=
mail.com" target=3D"_blank">malhyuk97@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/scheduler/sch<wbr>ed_fence.c | 16 ++++++++=
+++++++-<br>
&gt;=C2=A0 =C2=A0include/drm/gpu_scheduler.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 11 +++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 26 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sc<wbr>hed_fence.c b/drivers/gp=
u/drm/scheduler/sc<wbr>hed_fence.c<br>
&gt; index 85ee3d694dc9..280a2d036ffd 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sc<wbr>hed_fence.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sc<wbr>hed_fence.c<br>
&gt; @@ -92,7 +92,13 @@ static const char *drm_sched_fence_get_driver_na<wb=
r>me(struct dma_fence *fence)<br>
&gt;=C2=A0 =C2=A0static const char *drm_sched_fence_get_timeline_<wbr>name(=
struct dma_fence *f)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_sched_fence *fence =3D to_drm_sch=
ed_fence(f);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return (const char *)fence-&gt;sched-&gt;name;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Do not dereference fence-&gt;sched here: a use=
rspace-held finished<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * fence can outlive a per-context scheduler. Ret=
urn the name cached<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * in drm_sched_fence_init() instead.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return fence-&gt;sched_name;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void drm_sched_fence_free_rcu(struc<wbr>t rcu_head =
*rcu)<br>
&gt; @@ -228,6 +234,14 @@ void drm_sched_fence_init(struct drm_sched_fence =
*fence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned seq;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fence-&gt;sched =3D container_of(entity-&gt;=
rq, typeof(*fence-&gt;sched), rq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Cache the scheduler&#39;s timeline name: the f=
inished fence may be<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * exported to userspace and outlive @sched (per-=
context schedulers<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * are freed on context teardown), so get_timelin=
e_name() must not<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * dereference @sched. Scheduler names are persis=
tent (string<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * literals passed to drm_sched_init()).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fence-&gt;sched_name =3D fence-&gt;sched-&gt;name=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0seq =3D atomic_inc_return(&amp;entity-&gt;fe=
n<wbr>ce_seq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_init(&amp;fence-&gt;schedu<wbr>led=
, &amp;drm_sched_fence_ops_scheduled<wbr>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &amp;fence-&gt;lock, entity-&gt;fence_context, seq);<br>
&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h=
<br>
&gt; index d61c19e78182..4f780d70acb6 100644<br>
&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt; @@ -305,6 +305,17 @@ struct drm_sched_fence {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * belongs to.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_gpu_scheduler=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 *sched;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/**<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * @sched_name: the timeline name of @sched, cach=
ed at init time.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * &amp;drm_sched_fence.finished may be exported =
to userspace (via a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * sync_file or drm_syncobj) and can outlive @sch=
ed: a driver using a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * per-context scheduler frees it on context tear=
down while a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * userspace-held finished fence still references=
 it. The<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * get_timeline_name() callback must therefore no=
t dereference @sched;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * it returns this cached name instead.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const char=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *sched_name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * @lock: the lock used by the=
 scheduled and the finished fences.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
<br>
</blockquote></div></div>

--000000000000c131ed065a7d10bb--
