Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D4C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA5A10F4D7;
	Thu,  9 Jul 2026 10:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="IHq9u1iL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qu64wuzF";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E74410F4D5;
 Thu,  9 Jul 2026 10:58:01 +0000 (UTC)
Date: Thu, 9 Jul 2026 12:57:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1783594675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26FJV7cjx48XgvbFrZjYdsbkT1r51opYw8MIa0Bm5Eg=;
 b=IHq9u1iLo6dtgZTwgJxWAJ50UGIh+m9ngRAPue+UJLkI6eVFKClgs15hjdPnr8CcZY9ypy
 SlzvRaQ1nMFfQwvs6gKAyFyQW0aIBu1hLsYgXW7uwdKSviC1blhbdpvQrJr1yLftxI4wLW
 C4HHd5nYzaFsLaSo6t/vXkhLK9NLDEB2ORKdLwvo1b0jCpvOun69FjgCR0dADa613dPPj0
 PO2vAcOlOSA8RtB49pSV2dbYLLRBfLD8y/PrSKl7+8X1pFL1oFE33QE5gAKWLPZBRwPwWR
 UixeSs4qHh6FaP+1Cy2s1YW3J6EzWgfLAEBy24lzog8VEvG10Uz3sd7rS8Ibrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1783594675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26FJV7cjx48XgvbFrZjYdsbkT1r51opYw8MIa0Bm5Eg=;
 b=qu64wuzFzehc8lPi+dzEe7pETqZ/xP4P7maHHBZIsBbTRtPH6m+/Ui6wa2yHKevb8mvhww
 Rwvbqd3buZ1t3FAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 7/7] drm/i915/gt: Use signalers_lock to prevent
 starvation of irq_work.
Message-ID: <20260709105754.WJvT6s22@linutronix.de>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-8-dev@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706114823.752313-8-dev@lankhorst.se>
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

On 2026-07-06 13:48:23 [+0200], Maarten Lankhorst wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> IRQ-Work (FIFO-1) will be preempted by the threaded-interrupt (FIFO-50)
> and the interrupt will poll on signaler_active while the irq-work can't
> make progress.
> 
> Solve this by adding a global spinlock to prevent starvation and force
> completion.
> 
> The existing RCU handling gets in the way on PREEMPT_RT, and would likely
> require conversion to raw spinlock to take them inside a
> rcu_read_lock(), so remove RCU as well.

You require both locks and a try-lock since the ordering is wrong. And
you replace the RCU-section with a lock. Understood.

You probably want to make yourself as the author and make me
Co-developed-by or something or nothing. This would fix the Sob order
below.

> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>

Sebastian
