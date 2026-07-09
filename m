Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B96C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F2610E6CC;
	Thu,  9 Jul 2026 11:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="SNIM2Wn0";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A5610E6CB;
 Thu,  9 Jul 2026 11:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1783595721;
 bh=L2Zc8XmdM0Ir2YRcj+EgLUBGDMaC90XyjeJKCzfnZOg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SNIM2Wn0XfT7CQX+SspICURzlag+5yPIf8fjMSNs4ybHjDmufM8BzXr4NbFPq6UWX
 enA689ST3GCOBy1TeQT4/WLyL7mTACLUMGdStzjEwvHdUL7krWqSknK7egGjCgsuoR
 yEo4sULS2Nfty1gMi0nPBQK1R05XvXKF6rOPJCaTaMbUc7gaMxQHKsTI2iCo9m4t4X
 xqSvN5TNEHNqQDFXTFDOsZCp/LO9xjjHzj78KrZ8B+QHwdsOtXWfdthSjKIX4ai9ND
 xm38m8q5FePAGNRqSOGHOscdIUyqnDJ0qPWkAaTO6c3FEQcMpPgsJfFKCwOx0hJG66
 QppQ8Se/iUgwA==
Message-ID: <93032fce-041a-4991-9eec-29dfbb0e5116@lankhorst.se>
Date: Thu, 9 Jul 2026 13:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] drm/i915/gt: Use signalers_lock to prevent
 starvation of irq_work.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-8-dev@lankhorst.se>
 <20260709105754.WJvT6s22@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260709105754.WJvT6s22@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/9/26 12:57, Sebastian Andrzej Siewior wrote:
> On 2026-07-06 13:48:23 [+0200], Maarten Lankhorst wrote:
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> IRQ-Work (FIFO-1) will be preempted by the threaded-interrupt (FIFO-50)
>> and the interrupt will poll on signaler_active while the irq-work can't
>> make progress.
>>
>> Solve this by adding a global spinlock to prevent starvation and force
>> completion.
>>
>> The existing RCU handling gets in the way on PREEMPT_RT, and would likely
>> require conversion to raw spinlock to take them inside a
>> rcu_read_lock(), so remove RCU as well.
> 
> You require both locks and a try-lock since the ordering is wrong. And
> you replace the RCU-section with a lock. Understood.
> 
> You probably want to make yourself as the author and make me
> Co-developed-by or something or nothing. This would fix the Sob order
> below.
> 
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> 
> Sebastian
Yeah, it seems I missed doing --reset-author when amending here.
It likely needs your sob too if I add you as co author, can I reuse it from the original patch?

~Maarten
