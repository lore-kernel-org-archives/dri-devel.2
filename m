Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F9ACD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 13:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6034510F525;
	Fri,  1 May 2026 13:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="oIq+LRJ+";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0583E10F525
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 13:53:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18509176A;
 Fri,  1 May 2026 06:53:21 -0700 (PDT)
Received: from [10.1.29.19] (e122027.cambridge.arm.com [10.1.29.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161E33F62B;
 Fri,  1 May 2026 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777643606; bh=SZfQfvfB893c/szbx0R1lDb1u6Zv2iOvj852tH7skoc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oIq+LRJ+5gUbLjzK6hNRxdO4qRWR4tVvdMR9D5959gWHRR0Liqu/fp7ViliGDQKbs
 CDoub1a460Qzq0JB0/kxdOQ1G8kahKEOcnS6VhFfZOlFYHeYhN4u7eiiGrxFxCiWpQ
 6JT3qcFour7FwoGqrcJhNK3db6ZilmMRvv2RfCGs=
Message-ID: <e5c9763b-87c1-405d-9fda-f3f324d6bdfe@arm.com>
Date: Fri, 1 May 2026 14:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] drm/panthor: Automate CSG IRQ processing at group
 unbind time
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-7-4b92ae4142d2@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260429-panthor-signal-from-irq-v1-7-4b92ae4142d2@collabora.com>
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

On 29/04/2026 10:38, Boris Brezillon wrote:
> Make the sched_process_csg_irq_locked() call part of
> group_unbind_locked() so we don't have to manually call it in
> tick_ctx_apply()/panthor_sched_suspend().
> 
> This implies moving group_[un]bind_locked() around to avoid a
> forward declaration.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 178 +++++++++++++++-----------------
>  1 file changed, 82 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index c197bdc4b2c7..601a9bff1485 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -982,86 +982,6 @@ group_get(struct panthor_group *group)
>  	return group;
>  }
>  
> -/**
> - * group_bind_locked() - Bind a group to a group slot
> - * @group: Group.
> - * @csg_id: Slot.
> - *
> - * Return: 0 on success, a negative error code otherwise.
> - */
> -static int
> -group_bind_locked(struct panthor_group *group, u32 csg_id)
> -{
> -	struct panthor_device *ptdev = group->ptdev;
> -	int ret;
> -
> -	lockdep_assert_held(&ptdev->scheduler->lock);
> -
> -	if (drm_WARN_ON(&ptdev->base, group->csg_id != -1 || csg_id >= MAX_CSGS ||
> -			ptdev->scheduler->csg_slots[csg_id].group))
> -		return -EINVAL;
> -
> -	ret = panthor_vm_active(group->vm);
> -	if (ret)
> -		return ret;
> -
> -	group_get(group);
> -
> -	/* Dummy doorbell allocation: doorbell is assigned to the group and
> -	 * all queues use the same doorbell.
> -	 *
> -	 * TODO: Implement LRU-based doorbell assignment, so the most often
> -	 * updated queues get their own doorbell, thus avoiding useless checks
> -	 * on queues belonging to the same group that are rarely updated.
> -	 */
> -	for (u32 i = 0; i < group->queue_count; i++)
> -		group->queues[i]->doorbell_id = csg_id + 1;
> -
> -	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> -		ptdev->scheduler->csg_slots[csg_id].group = group;
> -		group->csg_id = csg_id;
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * group_unbind_locked() - Unbind a group from a slot.
> - * @group: Group to unbind.
> - *
> - * Return: 0 on success, a negative error code otherwise.
> - */
> -static int
> -group_unbind_locked(struct panthor_group *group)
> -{
> -	struct panthor_device *ptdev = group->ptdev;
> -
> -	lockdep_assert_held(&ptdev->scheduler->lock);
> -
> -	if (drm_WARN_ON(&ptdev->base, group->csg_id < 0 || group->csg_id >= MAX_CSGS))
> -		return -EINVAL;
> -
> -	if (drm_WARN_ON(&ptdev->base, group->state == PANTHOR_CS_GROUP_ACTIVE))
> -		return -EINVAL;
> -
> -	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> -		ptdev->scheduler->csg_slots[group->csg_id].group = NULL;
> -		group->csg_id = -1;
> -	}
> -
> -	panthor_vm_idle(group->vm);
> -
> -	/* Tiler OOM events will be re-issued next time the group is scheduled. */
> -	atomic_set(&group->tiler_oom, 0);
> -	cancel_work(&group->tiler_oom_work);
> -
> -	for (u32 i = 0; i < group->queue_count; i++)
> -		group->queues[i]->doorbell_id = -1;
> -
> -	group_put(group);
> -	return 0;
> -}
> -
>  static bool
>  group_is_idle(struct panthor_group *group)
>  {
> @@ -1968,6 +1888,88 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
>  	}
>  }
>  
> +/**
> + * group_bind_locked() - Bind a group to a group slot
> + * @group: Group.
> + * @csg_id: Slot.
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +static int
> +group_bind_locked(struct panthor_group *group, u32 csg_id)
> +{
> +	struct panthor_device *ptdev = group->ptdev;
> +	int ret;
> +
> +	lockdep_assert_held(&ptdev->scheduler->lock);
> +
> +	if (drm_WARN_ON(&ptdev->base, group->csg_id != -1 || csg_id >= MAX_CSGS ||
> +			ptdev->scheduler->csg_slots[csg_id].group))
> +		return -EINVAL;
> +
> +	ret = panthor_vm_active(group->vm);
> +	if (ret)
> +		return ret;
> +
> +	group_get(group);
> +
> +	/* Dummy doorbell allocation: doorbell is assigned to the group and
> +	 * all queues use the same doorbell.
> +	 *
> +	 * TODO: Implement LRU-based doorbell assignment, so the most often
> +	 * updated queues get their own doorbell, thus avoiding useless checks
> +	 * on queues belonging to the same group that are rarely updated.
> +	 */
> +	for (u32 i = 0; i < group->queue_count; i++)
> +		group->queues[i]->doorbell_id = csg_id + 1;
> +
> +	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> +		ptdev->scheduler->csg_slots[csg_id].group = group;
> +		group->csg_id = csg_id;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * group_unbind_locked() - Unbind a group from a slot.
> + * @group: Group to unbind.
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +static int
> +group_unbind_locked(struct panthor_group *group)
> +{
> +	struct panthor_device *ptdev = group->ptdev;
> +
> +	lockdep_assert_held(&ptdev->scheduler->lock);
> +
> +	if (drm_WARN_ON(&ptdev->base, group->csg_id < 0 || group->csg_id >= MAX_CSGS))
> +		return -EINVAL;
> +
> +	if (drm_WARN_ON(&ptdev->base, group->state == PANTHOR_CS_GROUP_ACTIVE))
> +		return -EINVAL;
> +
> +	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
> +		/* Process all pending IRQs before returning the slot. */
> +		sched_process_csg_irq_locked(ptdev, group->csg_id);
> +		ptdev->scheduler->csg_slots[group->csg_id].group = NULL;
> +		group->csg_id = -1;
> +	}
> +
> +	panthor_vm_idle(group->vm);
> +
> +	/* Tiler OOM events will be re-issued next time the group is scheduled. */
> +	atomic_set(&group->tiler_oom, 0);
> +	cancel_work(&group->tiler_oom_work);
> +
> +	for (u32 i = 0; i < group->queue_count; i++)
> +		group->queues[i]->doorbell_id = -1;
> +
> +	group_put(group);
> +	return 0;
> +}
> +
>  static const char *fence_get_driver_name(struct dma_fence *fence)
>  {
>  	return "panthor";
> @@ -2396,15 +2398,6 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
>  	/* Unbind evicted groups. */
>  	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
>  		list_for_each_entry(group, &ctx->old_groups[prio], run_node) {
> -			/* This group is gone. Process interrupts to clear
> -			 * any pending interrupts before we start the new
> -			 * group.
> -			 */
> -			if (group->csg_id >= 0) {
> -				guard(spinlock_irqsave)(&sched->events_lock);
> -				sched_process_csg_irq_locked(ptdev, group->csg_id);
> -			}
> -
>  			group_unbind_locked(group);
>  		}
>  	}
> @@ -2970,8 +2963,6 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
>  
>  			if (flush_caches_failed)
>  				csg_slot->group->state = PANTHOR_CS_GROUP_TERMINATED;
> -			else
> -				csg_slot_sync_update_locked(ptdev, csg_id);

The justification for this change doesn't seem to be included in the
commit message and looks suspicious. Although AFAICT the events_lock
wouldn't be held here so it could trigger a lockdep assert before this
change...

Thanks,
Steve

>  
>  			slot_mask &= ~BIT(csg_id);
>  		}
> @@ -2986,11 +2977,6 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
>  
>  		group_get(group);
>  
> -		if (group->csg_id >= 0) {
> -			guard(spinlock_irqsave)(&sched->events_lock);
> -			sched_process_csg_irq_locked(ptdev, group->csg_id);
> -		}
> -
>  		group_unbind_locked(group);
>  
>  		drm_WARN_ON(&group->ptdev->base, !list_empty(&group->run_node));
> 

