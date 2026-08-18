Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32747C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89BC610EC14;
	Tue, 18 Aug 2026 17:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Q1IIJEds";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A25C810EC14
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:15:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 363491A00
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:15:54 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 D6B1A3F763
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787073358; bh=tdHH1KKwxabqc14PyyehMolsFeTdgMHfgXISMC0rs/Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q1IIJEdsKCpiz46tRh7NTyIOqX3vPC3h4gRXML78tHE06j0WRgfZynMbXJzQ6x6E+
 j++aInk7sJwjt09dcSqOxdWSQzeEpMWqJtg+pLltFQwQ4zIpbWLyofc7ieaopwHnnb
 5awOrS+VijSQb7F+lNMoBtcgA+8JUy//JJ8Grda0=
Date: Tue, 18 Aug 2026 18:15:47 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/9] drm/panthor: Don't defer FW event processing
Message-ID: <aoSTQz0X0nTo3CN3@e142607>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-8-12f2ab53d735@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811-panthor-signal-from-irq-v6-8-12f2ab53d735@collabora.com>
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

On Tue, Aug 11, 2026 at 01:23:42PM +0200, Boris Brezillon wrote:
> Avoid a workqueue roundtrip and process things immediately from
> panthor_sched_report_fw_events().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 48 +++++++--------------------------
>  1 file changed, 9 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 1ef9da55030c..8016b0a55173 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -177,23 +177,6 @@ struct panthor_scheduler {
>  	 */
>  	struct work_struct sync_upd_work;
>  
> -	/**
> -	 * @fw_events_work: Work used to process FW events outside the interrupt path.
> -	 *
> -	 * Even if the interrupt is threaded, we need any event processing
> -	 * that require taking the panthor_scheduler::lock to be processed
> -	 * outside the interrupt path so we don't block the tick logic when
> -	 * it calls panthor_fw_{csg,wait}_wait_acks(). Since most of the
> -	 * event processing requires taking this lock, we just delegate all
> -	 * FW event processing to the scheduler workqueue.
> -	 */
> -	struct work_struct fw_events_work;
> -
> -	/**
> -	 * @fw_events: Bitmask encoding pending FW events.
> -	 */
> -	atomic_t fw_events;
> -
>  	/**
>  	 * @resched_target: When the next tick should occur.
>  	 *
> @@ -1971,14 +1954,17 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
>  		sched_process_idle_event_locked(ptdev);
>  }
>  
> -static void process_fw_events_work(struct work_struct *work)
> +/**
> + * panthor_sched_report_fw_events() - Report FW events to the scheduler.
> + * @ptdev: Device.
> + * @events: Bitmask of pending FW events to report.
> + */
> +void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
>  {
> -	struct panthor_scheduler *sched = container_of(work, struct panthor_scheduler,
> -						      fw_events_work);
> -	u32 events = atomic_xchg(&sched->fw_events, 0);
> -	struct panthor_device *ptdev = sched->ptdev;
> +	if (!ptdev->scheduler)
> +		return;
>  
> -	guard(spinlock)(&sched->events_lock);
> +	guard(spinlock)(&ptdev->scheduler->events_lock);
>  
>  	if (events & JOB_INT_GLOBAL_IF) {
>  		sched_process_global_irq_locked(ptdev);
> @@ -1993,20 +1979,6 @@ static void process_fw_events_work(struct work_struct *work)
>  	}
>  }
>  
> -/**
> - * panthor_sched_report_fw_events() - Report FW events to the scheduler.
> - * @ptdev: Device.
> - * @events: Bitmask of pending FW events to report.
> - */
> -void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
> -{
> -	if (!ptdev->scheduler)
> -		return;
> -
> -	atomic_or(events, &ptdev->scheduler->fw_events);
> -	sched_queue_work(ptdev->scheduler, fw_events);
> -}
> -
>  static const char *fence_get_driver_name(struct dma_fence *fence)
>  {
>  	return "panthor";
> @@ -4082,7 +4054,6 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
>  	struct panthor_scheduler *sched = ptdev->scheduler;
>  
>  	disable_delayed_work_sync(&sched->tick_work);
> -	disable_work_sync(&sched->fw_events_work);
>  	disable_work_sync(&sched->sync_upd_work);
>  
>  	mutex_lock(&sched->lock);
> @@ -4167,7 +4138,6 @@ int panthor_sched_init(struct panthor_device *ptdev)
>  	sched->tick_period = msecs_to_jiffies(10);
>  	INIT_DELAYED_WORK(&sched->tick_work, tick_work);
>  	INIT_WORK(&sched->sync_upd_work, sync_upd_work);
> -	INIT_WORK(&sched->fw_events_work, process_fw_events_work);
>  
>  	spin_lock_init(&sched->events_lock);
>  
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
