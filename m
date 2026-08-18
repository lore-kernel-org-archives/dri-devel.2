Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A87C5DF86
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4414F10EC1F;
	Tue, 18 Aug 2026 17:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="KSzIEWQg";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A034310EC1F
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:21:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 338011A32
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:21:04 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 D170D3F763
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787073668; bh=u7NwgLoY6NY88YpZ+JZgH16CPXWmG7Z7bfK5rJnxa6w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KSzIEWQg2Ko2RlrGBdo41sJh0dcn3Ve7ju5e1iLobc39otPuXaf42l3SPBHEA57Rg
 KCLijSkPb6zYq/zsDh6u2ijPxB+UZvfirGb7GBuJ9T+tsjTr9iWbtLtWjyKzqJsEP1
 1/fD+S08KG6XoUBM1GmVzvKfRJ79OcFYoxpzq88c=
Date: Tue, 18 Aug 2026 18:20:58 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] drm/panthor: Automate CSG IRQ processing at group
 unbind time
Message-ID: <aoSUeu6WdYo6bwLX@e142607>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-9-12f2ab53d735@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811-panthor-signal-from-irq-v6-9-12f2ab53d735@collabora.com>
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

On Tue, Aug 11, 2026 at 01:23:43PM +0200, Boris Brezillon wrote:
> Make the sched_process_csg_irq_locked() call part of
> group_unbind_locked() so we don't have to manually call it in
> tick_ctx_apply()/panthor_sched_suspend().
> 
> This implies moving group_[un]bind_locked() around to avoid a
> forward declaration.

Not sure why group_bind_locked() had to move. Aestethics?

Makes the patch a bit harder to review as one function is copied
verbatim while the other gets a line added. Minor sigh in the
end, so please ignore.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 182 +++++++++++++++-----------------
>  1 file changed, 84 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 8016b0a55173..57308cd90e96 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -989,87 +989,6 @@ group_get(struct panthor_group *group)
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
> -	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
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
> -	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
> -		ptdev->scheduler->csg_slots[group->csg_id].group = NULL;
> -		group->csg_id = -1;
> -	}
> -
> -	panthor_vm_idle(group->vm);
> -
> -	/* Tiler OOM events will be re-issued next time the group is scheduled. */
> -	atomic_set(&group->tiler_oom, 0);
> -	if (cancel_work(&group->tiler_oom_work))
> -		group_put(group);
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
> @@ -1979,6 +1898,89 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
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
> +	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
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
> +	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
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
> +	if (cancel_work(&group->tiler_oom_work))
> +		group_put(group);
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
> @@ -2405,18 +2407,8 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
>  
>  	/* Unbind evicted groups. */
>  	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
> -		list_for_each_entry(group, &ctx->old_groups[prio], run_node) {
> -			/* This group is gone. Process interrupts to clear
> -			 * any pending interrupts before we start the new
> -			 * group.
> -			 */
> -			if (group->csg_id >= 0) {
> -				guard(spinlock)(&sched->events_lock);
> -				sched_process_csg_irq_locked(ptdev, group->csg_id);
> -			}
> -
> +		list_for_each_entry(group, &ctx->old_groups[prio], run_node)
>  			group_unbind_locked(group);
> -		}
>  	}
>  
>  	for (i = 0; i < sched->csg_slot_count; i++) {
> @@ -3010,12 +3002,6 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
>  			continue;
>  
>  		group_get(group);
> -
> -		if (group->csg_id >= 0) {
> -			guard(spinlock)(&sched->events_lock);
> -			sched_process_csg_irq_locked(ptdev, group->csg_id);
> -		}
> -
>  		group_unbind_locked(group);
>  
>  		drm_WARN_ON(&group->ptdev->base, !list_empty(&group->run_node));
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
