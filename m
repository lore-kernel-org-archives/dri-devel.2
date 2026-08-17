Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94EEC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F222910E41D;
	Mon, 17 Aug 2026 15:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jQ6RxW0R";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 949B010E861
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:35:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4080C143D;
 Mon, 17 Aug 2026 08:35:30 -0700 (PDT)
Received: from [10.57.6.69] (unknown [10.57.6.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19C9C3F673;
 Mon, 17 Aug 2026 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786980934; bh=jmqfRF9aGjlFe7kuPvZ/oMuppf1q7tJzzRJD3CCia5c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jQ6RxW0RITBrxpJ5eMJ3kZP95O54K18QLosFVfRN4hmhaxuzXl2+Yvz74Eop+Ncir
 /ypJXW7V0eZdDvoXuw888GPJF98jdretvySfLvga1/ue3FIw4BjWLUYdL9udIfxOUS
 c5hybE5wpPGFggVWzUUpwVMQA5BOFWf2B1r5p9h0=
Message-ID: <936bfeb7-23d3-4202-8322-536d646064d7@arm.com>
Date: Mon, 17 Aug 2026 16:35:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] drm/panthor: Don't defer FW event processing
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-8-12f2ab53d735@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260811-panthor-signal-from-irq-v6-8-12f2ab53d735@collabora.com>
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

On 11/08/2026 12:23, Boris Brezillon wrote:
> Avoid a workqueue roundtrip and process things immediately from
> panthor_sched_report_fw_events().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

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

