Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C137C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE6A10F1B3;
	Fri, 31 Jul 2026 08:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Y0DdUCmh";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1688110F1B3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:00:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63972204C;
 Fri, 31 Jul 2026 01:00:49 -0700 (PDT)
Received: from [10.57.87.104] (unknown [10.57.87.104])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08EDB3F7B4;
 Fri, 31 Jul 2026 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785484853; bh=oHxrxlX9Yhq/hsWqViZgQ5F5mIqW9tciBJjzE6eoKS0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y0DdUCmhmFrqL8c7BS/c/fHNiakbouEO5VOUHkgaXuZ0kBAZqhBcTwVL5OzGfxiB+
 yCIbXlrY0SqsSp9tmn768yBO0aGwxPB1he5qmgSisZiEMYz/loiM1gArXzy73VgjQl
 szx0L8WxMjONZq/jeq/TjFu4/D+f2lrQ57egJxiM=
Message-ID: <5e3a84a2-fd4c-4f7d-9bb0-0b0d07e574b2@arm.com>
Date: Fri, 31 Jul 2026 09:00:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] wait: Introduce non-irq variants of
 wait_event_lock_timeout
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
 <20260730-panthor-cache-flush-fix-v2-1-28790478bfff@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-1-28790478bfff@collabora.com>
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

On 30/07/2026 12:45, Nicolas Frattaroli wrote:
> For locks that are never acquired in an interrupt context, the non-irq
> variants for spin_lock()/spin_unlock() are more efficient. However, so
> far, wait.h only provided wait_event_lock_irq_timeout and
> wait_event_interruptible_lock_irq_timeout, both of which use
> spin_lock_irq()/spin_unlock_irq().
> 
> Rectify this by adding new non-irq variants of these two macros.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

There's a documentation bug below...

> ---
>  include/linux/wait.h | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index dce055e6add3..cd9b989c120e 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -1174,6 +1174,13 @@ do {										\
>  		      __ret = schedule_timeout(__ret);				\
>  		      spin_lock_irq(&lock));
>  
> +#define __wait_event_lock_timeout(wq_head, condition, lock, timeout, state)	\
> +	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
> +		      state, 0, timeout,					\
> +		      spin_unlock(&lock);					\
> +		      __ret = schedule_timeout(__ret);				\
> +		      spin_lock(&lock))
> +
>  /**
>   * wait_event_interruptible_lock_irq_timeout - sleep until a condition gets
>   *		true or a timeout elapses. The condition is checked under
> @@ -1219,6 +1226,83 @@ do {										\
>  	__ret;									\
>  })
>  
> +/**
> + * wait_event_interruptible_lock_timeout - sleep until a condition gets
> + *		true or a timeout elapses. The condition is checked under
> + *		the lock with IRQs enabled. This is expected to be called
> + *		with the lock taken.
> + * @wq_head: the waitqueue to wait on
> + * @condition: a C expression for the event to wait for
> + * @lock: a spinlock_t that has been locked with spin_lock(), which will be
> + *	  released before schedule() and reacquired afterwards.
> + * @timeout: timeout, in jiffies
> + *
> + * The process is put to sleep (TASK_INTERRUPTIBLE) until the
> + * @condition evaluates to true or signal is received. The @condition is
> + * checked each time the waitqueue @wq_head is woken up.
> + *
> + * wake_up() has to be called after changing any variable that could
> + * change the result of the wait condition.
> + *
> + * This is supposed to be called while holding the lock. The lock is
> + * dropped before going to sleep using spin_unlock() and is reacquired
> + * using spin_lock() afterwards, but without globally disabling IRQs.
> + * This is in contrast to wait_event_interruptible_lock_irq_timeout(),
> + * which uses the spin_lock_irq() and spin_unlock_irq() functions instead.
> + *
> + * The function returns 0 if the @timeout elapsed, -ERESTARTSYS if it
> + * was interrupted by a signal, and the remaining jiffies otherwise
> + * if the condition evaluated to true before the timeout elapsed.
> + */
> +#define wait_event_interruptible_lock_timeout(wq_head, condition, lock,		\
> +					      timeout)				\
> +({										\
> +	long __ret = timeout;							\
> +	if (!___wait_cond_timeout(condition))					\
> +		__ret = __wait_event_lock_timeout(				\
> +					wq_head, condition, lock, timeout,	\
> +					TASK_INTERRUPTIBLE);			\
> +	__ret;									\
> +})
> +
> +/**
> + * wait_event_lock_timeout - sleep until a condition gets true or a timeout
> + *		elapses. The condition is checked under the lock with IRQs
> + *		enabled. This is expected to be called with the lock taken.
> + * @wq_head: the waitqueue to wait on
> + * @condition: a C expression for the event to wait for
> + * @lock: a spinlock_t that has been locked with spin_lock(), which will be
> + *	  released before schedule() and reacquired afterwards.
> + * @timeout: timeout, in jiffies
> + *
> + * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
> + * @condition evaluates to true or signal is received. The @condition is
                                   ^^^^^^^^^^^^^^^^^^^^^
UNINTERRUPTIBLE means that a signal doesn't wake it - that text should
be removed.

With that fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> + * checked each time the waitqueue @wq_head is woken up.
> + *
> + * wake_up() has to be called after changing any variable that could
> + * change the result of the wait condition.
> + *
> + * This is supposed to be called while holding the lock. The lock is
> + * dropped before going to sleep using spin_unlock() and is reacquired
> + * using spin_lock() afterwards, but without globally disabling IRQs.
> + * This is in contrast to wait_event_lock_irq_timeout(), which uses the
> + * spin_lock_irq() and spin_unlock_irq() functions instead. Compared to
> + * wait_event_interruptible_lock_timeout(), it uses the %TASK_UNINTERRUPTIBLE
> + * instead of allowing the task to be interrupted.
> + *
> + * The function returns 0 if the @timeout elapsed, or the remaining jiffies
> + * otherwise if the condition evaluated to true before the timeout elapsed.
> + */
> +#define wait_event_lock_timeout(wq_head, condition, lock, timeout)		\
> +({										\
> +	long __ret = timeout;							\
> +	if (!___wait_cond_timeout(condition))					\
> +		__ret = __wait_event_lock_timeout(				\
> +					wq_head, condition, lock, timeout,	\
> +					TASK_UNINTERRUPTIBLE);			\
> +	__ret;									\
> +})
> +
>  /*
>   * Waitqueues which are removed from the waitqueue_head at wakeup time
>   */
> 

