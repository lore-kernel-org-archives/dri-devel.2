Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0D3C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F3A10E692;
	Thu, 30 Jul 2026 15:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SKi44bRE";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id F3F6F10E692
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 15:08:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 113A81688
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:08:52 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 E0AF83F7B4
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785424136; bh=fm4PjR752KJiisTfelUMEAqvjekxRc5KLt39VpvDn60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SKi44bREAgY447utZpMCp2Ni3ljtv/TwB5tWxFJXdGBK40w5qPmFV3YfrxLq5E5/+
 6QzqHpbIdRcAgPEF35Yi8W2BHacquFpdsuBjdG1ukyeuwGqOow4B5roAZrtw7VqP2t
 1CHvnoOwDMbPE+LJM0GRvrouQD8i01oK1GRSnhNE=
Date: Thu, 30 Jul 2026 16:08:29 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/3] wait: Introduce non-irq variants of
 wait_event_lock_timeout
Message-ID: <amto7SDfCYaIIjXa@e142607>
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
 <20260730-panthor-cache-flush-fix-v2-1-28790478bfff@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-1-28790478bfff@collabora.com>
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

On Thu, Jul 30, 2026 at 01:45:14PM +0200, Nicolas Frattaroli wrote:
> For locks that are never acquired in an interrupt context, the non-irq
> variants for spin_lock()/spin_unlock() are more efficient. However, so
> far, wait.h only provided wait_event_lock_irq_timeout and
> wait_event_interruptible_lock_irq_timeout, both of which use
> spin_lock_irq()/spin_unlock_irq().
> 
> Rectify this by adding new non-irq variants of these two macros.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
> -- 
> 2.55.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
