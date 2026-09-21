Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BE6C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C774310EBE6;
	Tue, 22 Sep 2026 08:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="REzEIPp0";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1399210E646
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 20:28:35 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4aae314aso2678691d50.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790022514; cv=none;
 d=google.com; s=arc-20260327;
 b=DHgqs9HTMNeksvWbdWUL93J0rNiFOLUGkiRFcWcM3CYe7rZTwIhqN/+Ydrp7ke+pwk
 5WUPECzc1dG1IN3HKtaa7nBdC29u98Vfd4Q9CHVtCodD2NwqjK3GGYuqNk/B1wE7PvQ4
 xf1kRD0guVYYqUw1rKXI25DKzMNrqMOhv1JIh4efaFh01U3k52JgYx0WoRAnHCRX7636
 DSFQldvwDbxXdQkg6ZgfZ50q9Ih5a5L2rZGBhFeCE8psc3xbAzJyOmfGKTfK//VVGG89
 i3eK/qM/arMI422ZQe3NB0itES/5H9u2nWUrQWYQpxywBH0A9t2n/uSt0J/V1qySi66b
 rQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6elqDrf3QFm09b3Lgqg9C9aUdeLszZ6hCtMVrCJuCT8=;
 fh=LIqjvKLTBa2SW1RJjCd8GCJhCcTi6l6Iz2T7narnqBE=;
 b=D+le7xzA8sFOeHLhhIaV3Zm4h8k+5vEYszXl5NSKlnxXa/8HZ2mhNngsmEwtyo06xr
 pzmLeOrhnT0+VLw2vxDz+fJXUAQ/AfpV2ZZeps8w6wPXWT7FaoEyVG8iRz+yw+ASZyH7
 IR8LNf8BnJ8GZJFN3qXCHQGTZ0iE2SzpyOOzOag4hz75W7TMVdPZxzgCsSIyPhRTJDBt
 Y0rN+q53ji7r2FvuKn7X4bvmqR2QZCZd5GBfpAzL/DMyczjoG2dii9UmsR7Z0m2MMcEq
 v2NhRH8Wylh5ciHq8XJuaYv9cAUa9rBIh9M7McaPhHP3L3OdstXmDhyUc4K6E60Bvasg
 Z9Rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790022514; x=1790627314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6elqDrf3QFm09b3Lgqg9C9aUdeLszZ6hCtMVrCJuCT8=;
 b=REzEIPp0PrfLRjOkhZL2Vhbpa8zGKz3vAwrAHDmPBTUIV9aaBKS49lcicB0MEm3OJa
 5njq3vaA7y8HXah3Bh7DOseRYDBMYFGvRRHuGRjPUL6MVDsgZAN2b2qSWRW7yEH0hzH5
 IihpeBqEzMgKqaJYfhzVyVADjnGm7jlwCAqGhgELx/qqGykMhs8dcVKnJ6DHZ8984BnP
 1Xx0RycgOWbmBG9ih8nVQvsl3PH0OkweNXbHm+7uVN5nGZ1Yq764nxvMc/bdYo11GvQn
 cob8te+kmSWTKn9Joan+6yN7MLPaKjfQchGUFWy4B2ihNVcizgNOnosy+DMRJVlhldPu
 gqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790022514; x=1790627314;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6elqDrf3QFm09b3Lgqg9C9aUdeLszZ6hCtMVrCJuCT8=;
 b=NurW0OSK6VBZSMOkHm4odBbwriH0V4hEs7zxk1NSwF6N1gbyNzZwo968CqzgOskb4l
 1Rozbj2j8l548g/SeHBJgB2KJeSdFfAuRr4SeTofgI41fo7XvZkzK5eWG78D9LrMr/e1
 ZtuK619TqzpQdA+h3ti/QikXFD6t5eMhjhsiwNbhZ4q1uMqaJrUtztf//j0wmuYwO3HY
 NbTud6PWyznaak3k83AHscFHPujrSarKaGj+bWZJIru6T6oDwcIbGUpoaSvmAJX6Qb/b
 onGRnFgpcniCGtDuKtKouqLazQ7vzVfyS33J8aFp1SPYpFzACWOPegEEetf295QZlDZ9
 ivYw==
X-Gm-Message-State: AFuF++lLj2XYyxbk2fLIPvFOCX7R6YsvsYT76WV0bWSiTymqKSDEBN8I
 vZmfre7nX50+8tjQ5lxESdbXQsSUPETsmASAO1UGRf7s2h/S37hWNYKeqcmt8sjOTKPvHhmwAR1
 U1Z5kOBg+VDgMxJ+EjRg5hjTRj+RTnUK4VU6i
X-Gm-Gg: AYBFou1eEDImZkprLP0kqgAel9aA8o9VJNk1Ze0UNBbsmVJMDGSF9MrerjaKTyoELU7
 4q67G4GtUg+XYT3HUPfWwSGHBeoJxhSRg2UfISiucmYekRU1TuvApIYyNtjLNEt9q0kMs+yVohA
 XwZ52L2P9zaqgsFOrNHTYrLGhanRUEHMeNjvQquJHvJs3C/SCMUE4Ncp35Z3gBem9QMET165dx4
 RkIQ5s5D4SVDiWDbuz5aWMyGk5WFXnMjHe/KrvniB5EibpjoKlgIK569OIWSc8YhRe1OOaw2Ig3
 oxLaXBk+iSuslVLyM3q46TIygb6T6XHwvGjhRpZ4CUMG9YBh9VJJf+hkcnLDI3bh9Whb7L6MMNo
 ejpbo1Lvh4dSGJZDxwAgwnBDgXPgcrljc8fwr5ubu0Q==
X-Received: by 2002:a05:690e:d58:b0:671:70d1:d6cb with SMTP id
 956f58d0204a3-6717fdfbb04mr3479210d50.61.1790022513841; Mon, 21 Sep 2026
 13:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260921182121.308217-1-talesam@gmail.com>
 <20260921182121.308217-2-talesam@gmail.com>
 <20260921183324.0DDD11F000FF@smtp.kernel.org>
In-Reply-To: <20260921183324.0DDD11F000FF@smtp.kernel.org>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Mon, 21 Sep 2026 17:28:22 -0300
X-Gm-Features: AcwNN1V18IxPBVX3MzwrIoIOApanVqkrrqNT5qAIi1tEp5iC7OalFNrUEHsOrIk
Message-ID: <CAHBRX4GqGrA-JhPct0K1GO+fO-uwPm+jJDiQcAQ9FBvBENcOjw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 Matthew Brost <matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

On Mon, Sep 21, 2026 at 03:33:00PM -0300, sashiko-bot@kernel.org wrote:
> [High] drm/xe: MMIO access without PM reference in devcoredump on TLB tim=
eout

Correct on both counts, and it is my patch that introduces it.

Tracing it: every pending invalidation fence holds a runtime PM
reference, taken by xe_pm_runtime_get_noresume() in
xe_tlb_inval_fence_init(). xe_tlb_inval_fence_signal() calls
xe_tlb_inval_fence_fini(), which drops it. The timeout loop signals all
the expired fences and only then, after dropping pending_lock, calls
xe_devcoredump_gt(). devcoredump_snapshot() acquires forcewake without
taking a PM reference of its own - it has always relied on the caller
holding one, which the existing job-timeout caller does. The new
GT-level caller may have just released the last one, so the device can
begin autosuspending before the snapshot touches the hardware.

Fixed for v6 by holding a reference across the capture, taken while the
pending fences still guarantee the device is awake:

      if (!timedout_seqno) {
              /*
               * Hold a PM reference across the capture below. Every
               * pending fence holds one, so the device is awake
               * here, but signalling them may drop the last
               * reference and let it autosuspend before the
               * snapshot touches the hardware.
               */
              xe_pm_runtime_get_noresume(xe);
      }

and released after xe_devcoredump_gt() returns.

Taking it inside pending_lock is safe: xe_pm_runtime_get_noresume() goes
through pm_runtime_get_if_in_use(), and its "Missing outer runtime PM
protection" warning cannot fire here, because the fence reference is
still held at that point.

Tales

Em seg., 21 de set. de 2026 =C3=A0s 15:33, <sashiko-bot@kernel.org> escreve=
u:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] drm/xe: MMIO access without PM reference in devcoredump on TLB t=
imeout
> --
>
> commit a463de937c804fe9be7ed86bfbfa297e4f35c466
> Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>
>
> drm/xe: Capture devcoredump on TLB invalidation timeout
>
> This commit adds xe_devcoredump_gt() to capture the GuC log and CT state
> for GT-level hangs that are not tied to a specific queue or job. It then
> hooks this capture mechanism into the TLB invalidation timeout path. This
> helps in diagnosing firmware stalls where the invalidation request was
> consumed but the ack was delayed.
>
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>
> > diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/x=
e_devcoredump.c
> > --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> > +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> [ ... ]
> > @@ -323,40 +318,44 @@ static void devcoredump_snapshot(struct xe_devcor=
edump *coredump,
> >                                struct xe_gt *gt,
> >                                struct xe_exec_queue *q,
> >                                struct xe_sched_job *job)
> >  {
> [ ... ]
> >       /* keep going if fw fails as we still want to save the memory and=
 SW data */
> > -     CLASS(xe_force_wake, fw_ref)(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
> > +     CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FORCEWAKE_ALL);
>
> [Severity: High]
> If this capture path is reached without holding a PM runtime reference, d=
oes
> acquiring the forcewake here attempt MMIO accesses while the device is in=
 a
> low-power state? Accessing MMIO registers when the device has entered
> autosuspend (D3cold) typically causes unhandled PCIe errors or system
> crashes.
>
> [ ... ]
> > diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_=
tlb_inval.c
> > --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> > +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> [ ... ]
> > @@ -90,13 +98,27 @@ static void xe_tlb_inval_fence_timeout(struct work_=
struct *work)
> >                       "TLB invalidation fence timeout, seqno=3D%d recv=
=3D%d",
> >                       fence->seqno, tlb_inval->seqno_recv);
> >
> > +             timedout_seqno =3D fence->seqno;
> > +
> >               fence->base.error =3D -ETIME;
> >               xe_tlb_inval_fence_signal(fence);
>
> [Severity: High]
> Can this sequence drop the last PM runtime reference before the devcoredu=
mp
> is captured?
>
> Looking at xe_tlb_inval_fence_signal(), it calls xe_tlb_inval_fence_fini(=
)
> which drops the PM runtime reference (xe_pm_runtime_put). If this was the
> last active reference, the device could begin autosuspending.
>
> >       }
> >       if (!list_empty(&tlb_inval->pending_fences))
> >               queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->fen=
ce_tdr,
> >                                  timeout_delay);
> > +     seqno_recv =3D tlb_inval->seqno_recv;
> >       spin_unlock_irq(&tlb_inval->pending_lock);
> > +
> > +     /*
> > +      * Capture the GuC log and CT state so the firmware side of the h=
ang
> > +      * can be inspected; there is no queue or job to blame here. Must=
 be
> > +      * outside pending_lock as the capture takes sleeping locks, henc=
e
> > +      * @seqno_recv is sampled above while the lock is still held.
> > +      */
> > +     if (timedout_seqno)
> > +             xe_devcoredump_gt(tlb_inval_to_gt(tlb_inval),
> > +                               "TLB invalidation fence timeout, seqno=
=3D%d recv=3D%d",
> > +                               timedout_seqno, seqno_recv);
>
> Since the PM reference was dropped earlier in the loop, would this call t=
o
> xe_devcoredump_gt() proceed without holding one? If the thread gets
> preempted long enough for the autosuspend delay to expire, the forcewake
> operation inside devcoredump_snapshot() might hit the hardware while it i=
s
> unpowered.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921182121.30=
8217-1-talesam@gmail.com?part=3D1



--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
