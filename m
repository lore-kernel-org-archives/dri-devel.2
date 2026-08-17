Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36041C5DF7A
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8843A10E7AA;
	Mon, 17 Aug 2026 12:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nWzM16Ge";
	dkim-atps=neutral
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE5410E7AA
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:56:53 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-836c87fa3a9so1984797b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786971413; cv=none;
 d=google.com; s=arc-20260327;
 b=swN5Jykn5szaoMW/R6YS7XnM5nbZp9tYh5ADqtUQVdBmrwP+EraNUMxYQyhB+KXEsh
 a2fiyKfK6xeisVlj7ulRSJxuZZpnbUhIOuw93yiTUMIF0keKSZq2rmi6tuNtrHxhi40V
 FzQXcC7gjjmAlKBnZSbf7IbjEPtQb6tML8KmlOPYYars2Gzqk16Kcn/USECbRn0q8Asj
 1BoQ8swyLBTLYrgiyX9OhIO6QJ2Z8F4tTHbn1nbis4vWsOuwJwJJI1ro3obyoQpGni0s
 1CrNelSc6vofGMlCaABKFkcYtA0f2+uOWERh5a82pjfQ9fHd0tZK1fCPsRhp/yrHwgto
 d1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+sWYGz5XT9OAhWSz7+RnTv94A8j0P9pbFdVtTXC675o=;
 fh=uWJ5k36RUJVXUseoZuTnUkaKbr7Ns9o421yUTrBFZtU=;
 b=Ds/eMH+cgcrebYoaaNE9i746clIQ939FZAsYpYN0juPag8AXAhrch158fbyU7SbTes
 mcBzlgOs5wIqGPkjcKbA/Gc3F9YpPnjZAFw8fKwmIfx/rGjVM8H3TXU0ouyr9t1Gqn+Z
 zyIR+b16ngQhpTGN0wULpl6f+kK4w2VCH2nOSuwts9WQ0WUeoGXmWyFgqC84hNMibmcT
 rSTnq+bKfE2bWSmPduqp3k8cFqatUWcBFNykgJcpSh+ev4axYEG+luS8e3QFz4l54nZz
 B1a5PRQidsScuHHwMDlUzJkDPxpYITP6/EiRRiSc/9RVJDabCSfm1A5QU1XZKewAwOw5
 OlHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786971413; x=1787576213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+sWYGz5XT9OAhWSz7+RnTv94A8j0P9pbFdVtTXC675o=;
 b=nWzM16GegNbak5otkAB5ekZYwFcZCD6/kU2Ed3EJLGK4lglJN7TriQ+auNDzE2KUUT
 ZJydjl/KXWuDyZni4Bm9VT7qpdmahnOzOSoe1S2F6BJH3M0/Jpue83i/H0bGV43i9atJ
 P3ItZH0k6vP/H7o0jgywDC306XX/BNQPaTnjplM0EOh1Wlkp49orlUaSf/5enSRBuQkB
 D6GgasUwtDz9Cv4+TPoi/qnGfwZ8AKtig1wfogNqHJIDaT6PDu3SHIqLoo7Agf7FNg7m
 lNJAu6kcDkW2kKVM9zl7sZ7cc2rNoznb4QlkFP+B2apCmnyK2SbB4aspWc3EEBmZRJ+S
 hMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786971413; x=1787576213;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+sWYGz5XT9OAhWSz7+RnTv94A8j0P9pbFdVtTXC675o=;
 b=RaDGSabjk6Gwf/Q0alwx+n2AEKSRfQyHzQu6WcqDMDlwF2h3tswsaHpwXRRek1nQdx
 MVvT2vF5RiqFHcI+2yjqPlC80XB68+5erVBVpkoBTN1swVW7ifyRWNMzzWUjf4hw0/s6
 Oa3v3QAyHvIsmiKmX1ErEDp/ra79KrOCtREKpdsIcsqieEhsOZvBlub43Op5f7JDS4sg
 CdmGdCWstzs+eDCJZBh455Fdp7Zf6AcD+idHjLy02IZtcp0u3vSrUFWpXRdOoHApoUus
 yQgVYQb9gCczYeNWc7kewVDogBsjN7g+NOTF/6qoZ0CM6ILj6RarE+qFr+1yJA4IUJRy
 XioA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqaVbiLJf/4uI26ntuqQN9ayqjb4433RLq+JzHzTQYRQCq88O/2U1VrpdTNJSBWPsT4AX9koITydLg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywz/jhtFpiikcjKN5oAXWkWEO3d8Hr0XSkKXW4Rx/tnut8tUtdt
 hq4m3lptVumdrvwYVh6R8SIgI1Nc3Bi/IG1VEvNLHInnSORXBOnimEnanHeDnR0Wkh+Pz8XoZBV
 ++FiPegG/RVRWgzRR4iOcjb7VpxqFwUU=
X-Gm-Gg: AR+sD11WwCSSfw/9HarovV6+9DOn3dMpqogkGMdjoTkVSfESGG5K8u4WH122U5uNmm0
 /4eiWmiSzVUeXvH0eRiPSV1xFykg5mKJWAoYVkCHWMMEePidqf2buWz6QpmjMbY6QteRf7TwSoA
 O6Z2184oWRRNTveORRd3XFnvFbdIMmMdbskRTwJLQEeoLxmgRAWZ8sVK5uYRKz4BhoA3CQGeLzj
 42kJHp6tdp2Na4Fs6P6OudQr1vrmAyblNboKVmDEnR06obGsV5Y2CxdMNTyMQag4eYxbuQ0p9OX
 FdoRNog2ZtdVBRuKpftCPU3B3mdRnMhib4CFYWDRZc/Jr3qs89F2HRDO3f3xsC+MSAJYQgVXxNu
 zLJE=
X-Received: by 2002:a05:690c:4c07:b0:7f0:9099:daed with SMTP id
 00721157ae682-837081dbb86mr86189087b3.0.1786971412607; Mon, 17 Aug 2026
 05:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-3-gahing@gahingwoo.com>
In-Reply-To: <20260817113603.1436067-3-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Mon, 17 Aug 2026 14:56:40 +0200
X-Gm-Features: AcwNN1V-5NLT5_FLJWlZREIascUsv5ajt7d1tsDmiA1E2hxh05iV2LoVrZcqDUw
Message-ID: <CAEWPSH7tM9WQUJ0H13ghkiHGzDcdycC1syTuO5B8DpC6cUSnfg@mail.gmail.com>
Subject: Re: [PATCH v8 02/12] accel/rocket: wait for a running IRQ handler
 before resetting a core
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
 ogabbay@kernel.org, zhangqing@rock-chips.com, chaoyi.chen@rock-chips.com, 
 diederik@cknow-tech.com, alchark@flipper.net, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Jiaxing,

I have not run v8 on hardware yet. Everything below is source review.
My Tested-by on 1/12 is from the v7 run and I am not extending it to
this patch yet; the last section says why, and what I will run instead.
Line numbers are next-20260814.

The patch is right and the reasoning in the message is right.
synchronize_irq() is the correct one of the pair: __synchronize_irq()
does the hardirq spin and then waits on desc->wait_for_threads
(kernel/irq/manage.c), so it fences the threaded handler, which is the
one that takes job_lock. synchronize_hardirq() would not have. Worth
adding to your placement argument: the deadlock you avoided would have
been a silent hang rather than a lockdep splat, because that wait is on
a waitqueue and not on a lock, so lockdep does not model it at all.
Nothing would have told you.

Two questions, both about what the reset path does not do.

1. Would you also mask the block before the sync?

rocket_reset() is descended from panfrost_reset(), and the comment this
patch replaces is inherited from it word for word. In panfrost that
comment is earned, because three things happen before it:

    job_write(pfdev, JOB_INT_MASK, 0);
    synchronize_irq(pfdev->js->irq);
    ... soft-stop ...
    panfrost_jm_handle_irqs(pfdev);

(panfrost_job.c:692-693 and :710, with the same sentence rocket carries
at :712-715). Rocket inherited the sentence and none of the three steps,
which is your point, and 2/12 restores one of them.

Without the device level mask a fresh completion interrupt can still
arrive after synchronize_irq() returns. INTERRUPT_MASK is armed on every
submit (rocket_job.c:142) and the only place it is cleared is the
hardirq (:446); rocket_reset() never touches it. In the ordinary
timeout, where no interrupt fired before the job hung, the mask is still
live. So: would you write

    rocket_pc_writel(core, INTERRUPT_MASK, 0x0);

immediately before the synchronize_irq()? It is safe to do, since
hw_submit() re-arms the mask on every submit, so nothing is lost.

I do not think this is a hole. The reset.pending check in hw_submit()
(:116, returning before next_task_idx++ at :123) already stops the
resubmit branch from firing here. It is about making the new comment
literally true. I have no TRM, so I am not claiming that a write landing
on a block under reset is harmful.

2. Should rocket_reset() hold a runtime PM reference?

This one surprised me. drm_sched_stop() zeroes the credit counter and it
is only restored in drm_sched_start(), the last line of rocket_reset().
That counter is the only thing gating suspend: rocket_job_is_idle() is
exactly atomic_read(&core->sched.credit_count) (rocket_job.c:540-543),
and rocket_device_runtime_suspend() returns -EBUSY iff that says busy,
then disables the clocks (rocket_drv.c). So for the whole body of
rocket_reset() the driver is telling runtime PM the core is idle while
holding no reference, and rocket_core_reset() is an assert, udelay(10),
deassert on top of that.

The part that touches this patch: the two puts are not equivalent.
pm_runtime_put_noidle() is a bare decrement with no idle request, so
nothing is armed. put_autosuspend() arms the 50 ms timer. Before 2/12 it
depended on who won the lock. After 2/12, if a completion interrupt was
in flight, the handler is guaranteed to finish its retire first, so
put_autosuspend() runs, the reset finds in_flight_job NULL and skips its
put_noidle, and rocket_core_reset() runs with a live timer. In the plain
hung-job case there is no handler and put_noidle still runs, so this is
only the racing case.

I have not seen it fire, and panfrost has the same
is_idle-on-credit_count shape, so this may be inherited and intended.
But would you bracket the reset with pm_runtime_get_sync() and
pm_runtime_put_autosuspend()? For contrast, panfrost_device_reset()
re-powers the block and re-initialises the MMU; rocket_core_reset()
toggles the reset lines and returns.

On the RK3576 non-recovery in your cover

You wrote that you have not worked out what sits between
rocket_core_reset() and rk_iommu re-enabling the MMU. Three things from
the source that may narrow it. I have no RK3576, so this is a direction,
not a diagnosis.

- That message is rk_iommu_force_reset(), reached only from
  rk_iommu_enable(), via attach or runtime_resume. Never from
  rocket_core_reset(). Since rocket attaches per job, the report is at
  the next job, so the damage precedes it. That matches your "a few
  seconds later".

- The check is a write-then-readback of RK_MMU_DTE_ADDR, and
  rk_iommu_enable_stall() returns 0 silently when paging is not enabled,
  which it decides by reading RK_MMU_STATUS. So a block whose registers
  read back zero produces exactly that message with nothing printed
  before it. It means the MMU is not responding at all, rather than
  being in a wrong state. Worth grepping the same run for "stall request
  timed out" and "paging request timed out"; if they are absent, that
  reading holds.

- Between the reset and the next job the core does not power cycle.
  put_noidle leaves usage_count at 0 with the device still active and no
  idle request pending. So the domain stays up, and on RK3576 the BIU
  reset your 9/12 cycles on power-on never gets cycled. If the MMU needs
  that to come back, it never gets it.

One build would settle it: put_autosuspend() instead of put_noidle() at
the end of rocket_reset(), or force a suspend and resume before the next
job, and see whether the block returns.

One question only you can answer: did MMU_DTE_ADDR appear on v7 too,
before the rail moved to domain-supply? If it did not, "existing
behaviour rather than something the series introduces" may want another
look.

What I will run, and why no tag yet

I am not putting Tested-by on this patch from an ordinary run, because
an ordinary run cannot reach the code it changes. rocket_reset()
early-returns unless reset.pending (:368), and
atomic_set(&core->reset.pending, 1) appears at exactly one site in the
driver, inside rocket_job_timedout() (:405). No debugfs knob, no sysfs
trigger, no error path. (Separately, rocket_reset_work() is never queued
anywhere, which does not affect your message but is a cleanup
candidate.) At 182 inf/s an RK3588 job is about 5.5 ms against a 500 ms
timeout, so I have never been near it.

So: a test build with JOB_TIMEOUT_MS lowered to 2, which makes healthy
jobs time out with a completion interrupt genuinely in flight, which is
the window 1/12 and 2/12 exist for. Twenty induced resets per core
across all three, with and without 1/12+2/12 for a differential, at
least one inference after each reset and one after an autosuspend and
resume, and PROVE_LOCKING plus DEBUG_ATOMIC_SLEEP on. On RK3588 core 0
sits in PD_NPUTOP, which is the parent of PD_NPU1 and PD_NPU2, so I will
do core 0 with the other two busy and core 1 on its own. Capturing
dmesg, the per-core lines in /proc/interrupts either side of each
timeout, runtime status, the genpd summary, and the output tensor
against my existing bit-exact baseline.

If all three cores come back clean, that says your non-recovery is
RK3576-specific, which is the useful answer. If RK3588 logs the same
MMU_DTE_ADDR, it is rocket-wide and pre-existing, wants its own patch,
and should not hold up v8. Either way I will report it with the lowered
timeout stated in the trailer.

Reviewed-by on 3/12 sent separately.

Regards,
Igor


On Mon, Aug 17, 2026 at 1:36=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_reset() calls drm_sched_stop(), which stops the scheduler and
> returns. It does not wait for a threaded handler that is already
> running, so the comment that follows, "Remaining interrupts have been
> handled", states an assumption rather than something the code arranges.
>
> Call synchronize_irq(core->irq) after drm_sched_stop() and reword the
> comment to say what holds afterwards.
>
> It has to go before the scoped_guard(mutex, &core->job_lock) rather than
> inside it. rocket_job_handle_irq() takes job_lock, so waiting for the
> handler while holding that lock would be waiting for a handler that is
> waiting for us. Nothing is held at that point, and both callers,
> rocket_job_timedout() and rocket_reset_work(), run in process context,
> so sleeping there is allowed.
>
> This does not stop a handler that has already read in_flight_job from
> finishing its work on the job the reset is about to drop. That window
> needs the check and the register writes to be one step under the lock,
> which is what the previous patch does; the two are complementary.
>
> Suggested-by: Igor Paunovic <royalnet026@gmail.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 5f0f9682e..d484a3a6f 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -377,9 +377,17 @@ rocket_reset(struct rocket_core *core, struct drm_sc=
hed_job *bad)
>         drm_sched_stop(&core->sched, bad);
>
>         /*
> -        * Remaining interrupts have been handled, but we might still hav=
e
> -        * stuck jobs. Let's make sure the PM counters stay balanced by
> -        * manually calling pm_runtime_put_noidle().
> +        * drm_sched_stop() returns without waiting for a threaded handle=
r that
> +        * is already running, so wait for one here. This has to stay out=
side
> +        * job_lock: the handler takes that lock, so waiting for it while
> +        * holding it would deadlock instead of fencing anything.
> +        */
> +       synchronize_irq(core->irq);
> +
> +       /*
> +        * No handler is running now, but we might still have stuck jobs.=
 Let's
> +        * make sure the PM counters stay balanced by manually calling
> +        * pm_runtime_put_noidle().
>          */
>         scoped_guard(mutex, &core->job_lock) {
>                 if (core->in_flight_job)
> --
> 2.43.0
>
