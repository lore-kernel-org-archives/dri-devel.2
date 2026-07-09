Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015DAC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6365210F5B2;
	Thu,  9 Jul 2026 12:23:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="zssXTpVz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DyMt0lF0";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD8A10F5A7;
 Thu,  9 Jul 2026 12:23:40 +0000 (UTC)
Date: Thu, 9 Jul 2026 14:23:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783599817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Si8Y/mLJURDSOd/tx3BEaIDrqKf2uDYmkpNC4YSpZk=;
 b=zssXTpVz0csdckDRnXbJAfN3/TxTFx1oHWW4OIdKck3l1yZVNHjqDFwu00uCpGaX5dRk1O
 80ixRuZ61YlblCeDeLKgooutPFvLHWwnpwEc9xgQ9xr1lbHErkcNociEkh+Yy9xU5SBxxg
 0dlBB70l7mdMLyov+igHrMUiixrgZpSNNe9dWtxu7vAQfU7q2pEPPz4I8o/y9+lDqQVLrV
 vA3TIGb7DmYkX3kVxGeAr55l/ZQBGMA93w7v9Rv+1dabc4VPTC/JBNj9V6rzjEzIaYp64F
 QB4wrSlGc5RTOkyM4OmEsFLqx9UBiN7vuJ3zi/uw7oh8dhj8Y+Vcig1g8IelHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783599817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Si8Y/mLJURDSOd/tx3BEaIDrqKf2uDYmkpNC4YSpZk=;
 b=DyMt0lF03xy8fooYJtPlUy8F55YDbsqZEi/nU1jL/8TPyzWXg8pahA+c9hrrAXJUDNC3VB
 zjKjc8Rb/m/yF9BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 4/7] drm/i915/gt: Fix selftests on PREEMPT_RT
Message-ID: <20260709122336.4IUOySJ8@linutronix.de>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-5-dev@lankhorst.se>
 <20260709103650.VxAAiEnx@linutronix.de>
 <89f1eb47-44fb-41bf-bc4b-a3693125e0b2@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89f1eb47-44fb-41bf-bc4b-a3693125e0b2@lankhorst.se>
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

On 2026-07-09 13:03:30 [+0200], Maarten Lankhorst wrote:
> Would the below look good?
> 
> The engine->busyness() callbacks called from the selftests are on PREEMPT_RT
> not safe with preemption disabled, because all spinlocks are converted to
> rt-mutexes.

 "all spinlock_t locks becomes sleeping locks on PREEMPT_RT and must not
 be acquired with disabled preemption."

> This is also a problem for perf events, where we have to disable
> the busyness events on PREEMPT_RT.

perf events as in hardirq or irq_work? If hardirq and spinlock_t then
lockdep might complain.

> Previous attempts to fix this failed, so convert the selftest code to read
> engine->busyness()  with migrate_disable() instead of preempt_disable() to
> prevent selftest failures on PREEMPT_RT.

You might want to describe why this swap is safe or what the requirement
is here. My guess would be that preempt_disable() is here to ensure that
the two reads from intel_engine_get_busy_time() are 100us delay and not
10ms due to a context switch. But then this has no impact on the
returned value since it measures the busy-time of the HW which should
report 0 if idle.

Sebastian
