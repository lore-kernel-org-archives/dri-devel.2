Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA4FC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DB910FA76;
	Tue, 15 Sep 2026 07:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="SqhrE50w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MOj9iq8y";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CA210FA76;
 Tue, 15 Sep 2026 07:36:18 +0000 (UTC)
Date: Tue, 15 Sep 2026 09:36:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1789457776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F0XPnkxyinHuP6LWNm97uEI7J3FDxX79bdkqFiNYciE=;
 b=SqhrE50w1ocVlf7bpgeaWolWTp4TlALhfikJd77/9fAbpZv3jROrX6RuHe9ozTKinQTlVq
 5TL3T2e73jZY6BqX+6zCJotxa//4hJoq5worZy947B/ZdP3qeGxu4eV71Gox5uBqhKt58n
 U9LTKCkF8GdliiYdGg3N+fJZqP6lhkX0P2tEOoJfh15/E/oNw5XFsTX/mtOgScEEpz9BYZ
 gydy3OCdv00ONKP0zc3wkRS+joc9Nwov2QqA9lbMGpxEaW4pQznJcVIKvKACQxcqUntEIA
 JiHWGgwyOtbw834tsScsMXkZCFA0+M9mRg3i6E9LGYKJvhfBbw7SLs6mGciJAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1789457776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F0XPnkxyinHuP6LWNm97uEI7J3FDxX79bdkqFiNYciE=;
 b=MOj9iq8y1HteeIVav02abiLPFsuHVtarPN2TFD7jA7YzWZT9Dij7UoMpx12ZDRoQydWGhe
 CrGKmIpDqkbjOuAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Sravanthi Kollukuduru <skolluku@codeaurora.org>,
 Archit Taneja <architt@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Chandan Uddaraju <chandanu@codeaurora.org>,
 Rajesh Yadav <ryadav@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 venkata.valluru@oss.qualcomm.com,
 Naman S Thaker <namathak@qti.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm: split DPU core IRQ handler under
 CONFIG_PREEMPT_RT
Message-ID: <20260915073614.nvT9zW3S@linutronix.de>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
 <20260910064723.pbZP3vic@linutronix.de>
 <aqP3lDjzzsbFNly5@hu-vishsain-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqP3lDjzzsbFNly5@hu-vishsain-blr.qualcomm.com>
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

On 2026-09-11 18:14:04 [+0530], Vishnu Saini wrote:
> On Thu, Sep 10, 2026 at 08:47:23AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-09-09 14:22:16 [+0530], vishnu.saini@oss.qualcomm.com wrote:
> > > From: Naman S Thaker <namathak@qti.qualcomm.com>
> > > 
> > > On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,
> > 
> > *why* is this the case. The code you replaces adds some ifdefs around
> > request_irq() with 0 as flags. This does not make it run has hardirq.
> You are right, the statement is incorrect, i will update the commit msg.
> On RT kernel, the dpu_core_irq() runs in threaded context by default.
> This behavior is changed in the commit by calling devm_request_threaded_irq with
> IRQ_ONESHOT flag only for RT kernel using the ifdefs.

The why would be interesting. Usually things stay threaded to avoid
locking issues down the road.

> The irq is now split into two parts for RT,
> 1: primary handler which does not use sleeping locks, and
> 2: secondary threaded handler which can use sleepable locks.
> For normal kernels, the request_irq() with 0 flag is still used as-is.

If the split is properly done for RT, the non-RT variant should be able
to use the same without any ifdefs.

>  
> > > but it dispatches per-encoder callbacks that take sleepable locks
> > > (spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
> > > through vblank/CRC/writeback handling are sleepable as well). Sleeping
> > > inside a hardirq handler is not allowed and eventually crashes the
> > > display, which is what happens after running GLMark2 for a while.
> > 
> > That is correct. That is the irq handler are threaded by default and
> > only non-threaded if explicitly requested.
> > 
> > I suggest to stick with non-threaded by default.
> > There is only one request_threaded_irq() as far as I can tell and this
> > msm_dp_display_request_irq():
> > 
> > |         rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
> > |                                        msm_dp_display_irq_handler,
> > |                                        msm_dp_display_irq_thread,
> > |                                        IRQ_TYPE_LEVEL_HIGH,
> > |                                        "dp_display_isr", dp);
> > 
> > and its primary handler will be threaded on PREEMPT_RT, too. So you end
> > up with two threads here.
> You are correct about the primary handler in msm_dp_display_request_irq() being threaded.
> But the request_threaded_irq function in msm_dp_display_request_irq() is not modified in this commit.
> The issue fixed by the current commit relates to msm_mdss_irq crash stack below.

Why is it the way it is? What is the issue in the stack trace below?
This is not described, is it? Your cleared the top of the report.
Now, msm_dp_display_irq_handler() ors the return value which is wrong.
You can't return IRQ_WAKE_THREAD | IRQ_HANDLED and expect the thread is
woken up. It appears the handler is fires over and over which implies
that something is wrong with your primary handler.

The way this is requested you supposed to have threaded handler and a
secondary-threaded handler. While msm_dp_display_irq_handler() is
invoked as threaded the IRQ chip masks the interrupt source. If it
returns IRQ_WAKE_THREAD it supposed to mask the interrupt source because
the IRQ-chip unmasks the interrupt while the secondary-threaded handler
is run. It seems this does not work as intended.

> [  152.108462] Call trace:
> [  152.108465]  show_stack+0x18/0x30 (C)
> [  152.108477]  dump_stack_lvl+0x60/0x80
> [  152.108484]  dump_stack+0x18/0x24
> [  152.108489]  __report_bad_irq+0x4c/0xec
> [  152.108496]  note_interrupt+0x340/0x394
> [  152.108502]  handle_irq_event+0x94/0xa0
> [  152.108508]  handle_level_irq+0xd8/0x16c
> [  152.108513]  handle_irq_desc+0x34/0x5c
> [  152.108518]  generic_handle_domain_irq+0x1c/0x28
> [  152.108522]  msm_mdss_irq+0x68/0x144 [msm]
> [  152.108654]  handle_irq_desc+0x34/0x5c
> [  152.108660]  generic_handle_domain_irq+0x1c/0x28
> [  152.108664]  gic_handle_irq+0x4c/0x140
> [  152.108669]  call_on_irq_stack+0x30/0x48
> [  152.108673]  do_interrupt_handler+0x80/0x84
> [  152.108678]  el1_interrupt+0x38/0x58
> [  152.108685]  el1h_64_irq_handler+0x18/0x24
> [  152.108690]  el1h_64_irq+0x70/0x74
> [  152.108694]  __schedule+0x6c/0xc9c (P)
> [  152.108701]  schedule_idle+0x20/0x40
> [  152.108705]  do_idle+0x17c/0x2c0
> [  152.108710]  cpu_startup_entry+0x38/0x40
> [  152.108714]  rest_init+0xd8/0xe0
> [  152.108719]  console_on_rootfs+0x0/0x6c
> [  152.108726]  __primary_switched+0x88/0x90
> [  152.108732] handlers:
> [  152.108734] [<000000000cabe59c>] irq_default_primary_handler threaded [<00000000779fd542>] msm_irq [msm]
> [  152.108859] Disabling IRQ #246

Sebastian
