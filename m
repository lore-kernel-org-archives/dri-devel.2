Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4FAC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C44A10F3EE;
	Fri, 24 Jul 2026 14:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="i2LOWNlQ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 82F5C10F3EE
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:58:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABC61477;
 Fri, 24 Jul 2026 07:58:05 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9D5A3F66F;
 Fri, 24 Jul 2026 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784905089; bh=7orsCuhqJecRjsGlZVUL0BCmqWohlGE+vvfJB9Owihk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=i2LOWNlQDkayfaLmyyOLPRGY0kM3nCgTlo8ujSWjJw968aD7Pwid1YeqcAoAp7KhA
 IvrZFHvRiiIVQbPha5TlQ3XH35gkJcwgEiWy5HYMJP689npN6+ClVxNfl0hs3qoS1l
 dHDrbXXd8XfbkUMsCXZESZt/HbRkkNUwuJGhmbQc=
Message-ID: <66b80482-dc76-426c-93bd-c30a54ac2e94@arm.com>
Date: Fri, 24 Jul 2026 15:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/panthor: Minor scheduler refactoring
To: Ketil Johnsen <ketil.johnsen@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Florent Tomasin <florent.tomasin@arm.com>
References: <20260712135439.1546950-1-ketil.johnsen@arm.com>
 <20260712135439.1546950-3-ketil.johnsen@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260712135439.1546950-3-ketil.johnsen@arm.com>
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

On 12/07/2026 14:54, Ketil Johnsen wrote:
> From: Florent Tomasin <florent.tomasin@arm.com>
> 
> Refactor parts of the group scheduling logic into new helper functions.
> This will simplify addition of the protected mode feature.
> 
> Remove redundant assignments of csg_slot.
> 
> Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
> Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 126 ++++++++++++++----------
>  1 file changed, 74 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5b34032deff81..465f1b86249f8 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2267,12 +2267,75 @@ tick_ctx_cleanup(struct panthor_scheduler *sched,
>  	}
>  }
>  
> +static void
> +tick_ctx_evict_group(struct panthor_scheduler *sched,
> +		     struct panthor_csg_slots_upd_ctx *upd_ctx,
> +		     struct panthor_group *group)
> +{
> +	struct panthor_device *ptdev = sched->ptdev;
> +
> +	if (drm_WARN_ON(&ptdev->base, group->csg_id < 0))
> +		return;
> +
> +	csgs_upd_ctx_queue_reqs(ptdev, upd_ctx, group->csg_id,
> +				group_can_run(group) ?
> +				CSG_STATE_SUSPEND : CSG_STATE_TERMINATE,
> +				CSG_STATE_MASK);
> +}
> +
> +static void
> +tick_ctx_reschedule_group(struct panthor_scheduler *sched,
> +			  struct panthor_csg_slots_upd_ctx *upd_ctx,
> +			  struct panthor_group *group,
> +			  int new_csg_prio)
> +{
> +	struct panthor_device *ptdev = sched->ptdev;
> +	struct panthor_fw_csg_iface *csg_iface;
> +	struct panthor_csg_slot *csg_slot;
> +
> +	if (group->csg_id < 0)
> +		return;
> +
> +	csg_iface = panthor_fw_get_csg_iface(ptdev, group->csg_id);
> +	csg_slot = &sched->csg_slots[group->csg_id];
> +
> +	if (csg_slot->priority != new_csg_prio) {
> +		panthor_fw_update_reqs(csg_iface, endpoint_req,
> +				       CSG_EP_REQ_PRIORITY(new_csg_prio),
> +				       CSG_EP_REQ_PRIORITY_MASK);

Shouldn't this use panthor_fw_csg_endpoint_req_update() like the
previous code? Otherwise this breaks on hardware with
panthor_fw_has_64bit_ep_req().

Thanks,
Steve

> +		csgs_upd_ctx_queue_reqs(ptdev, upd_ctx, group->csg_id,
> +					csg_iface->output->ack ^ CSG_ENDPOINT_CONFIG,
> +					CSG_ENDPOINT_CONFIG);
> +	}
> +}
> +
> +static void
> +tick_ctx_schedule_group(struct panthor_scheduler *sched,
> +			struct panthor_csg_slots_upd_ctx *upd_ctx,
> +			struct panthor_group *group,
> +			int csg_id, int csg_prio)
> +{
> +	struct panthor_device *ptdev = sched->ptdev;
> +	struct panthor_fw_csg_iface *csg_iface =
> +		panthor_fw_get_csg_iface(ptdev, csg_id);
> +
> +	group_bind_locked(group, csg_id);
> +	csg_slot_prog_locked(ptdev, csg_id, csg_prio);
> +
> +	csgs_upd_ctx_queue_reqs(ptdev, upd_ctx, csg_id,
> +				group->state == PANTHOR_CS_GROUP_SUSPENDED ?
> +				CSG_STATE_RESUME : CSG_STATE_START,
> +				CSG_STATE_MASK);
> +	csgs_upd_ctx_queue_reqs(ptdev, upd_ctx, csg_id,
> +				csg_iface->output->ack ^ CSG_ENDPOINT_CONFIG,
> +				CSG_ENDPOINT_CONFIG);
> +}
> +
>  static void
>  tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *ctx)
>  {
>  	struct panthor_group *group, *tmp;
>  	struct panthor_device *ptdev = sched->ptdev;
> -	struct panthor_csg_slot *csg_slot;
>  	int prio, new_csg_prio = MAX_CSG_PRIO, i;
>  	u32 free_csg_slots = 0;
>  	struct panthor_csg_slots_upd_ctx upd_ctx;
> @@ -2282,44 +2345,13 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
>  
>  	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
>  		/* Suspend or terminate evicted groups. */
> -		list_for_each_entry(group, &ctx->old_groups[prio], run_node) {
> -			bool term = !group_can_run(group);
> -			int csg_id = group->csg_id;
> -
> -			if (drm_WARN_ON(&ptdev->base, csg_id < 0))
> -				continue;
> -
> -			csg_slot = &sched->csg_slots[csg_id];
> -			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
> -						term ? CSG_STATE_TERMINATE : CSG_STATE_SUSPEND,
> -						CSG_STATE_MASK);
> -		}
> +		list_for_each_entry(group, &ctx->old_groups[prio], run_node)
> +			tick_ctx_evict_group(sched, &upd_ctx, group);
>  
>  		/* Update priorities on already running groups. */
> -		list_for_each_entry(group, &ctx->groups[prio], run_node) {
> -			struct panthor_fw_csg_iface *csg_iface;
> -			int csg_id = group->csg_id;
> -
> -			if (csg_id < 0) {
> -				new_csg_prio--;
> -				continue;
> -			}
> -
> -			csg_slot = &sched->csg_slots[csg_id];
> -			csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
> -			if (csg_slot->priority == new_csg_prio) {
> -				new_csg_prio--;
> -				continue;
> -			}
> -
> -			panthor_fw_csg_endpoint_req_update(ptdev, csg_iface,
> -							   CSG_EP_REQ_PRIORITY(new_csg_prio),
> -							   CSG_EP_REQ_PRIORITY_MASK);
> -			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
> -						csg_iface->output->ack ^ CSG_ENDPOINT_CONFIG,
> -						CSG_ENDPOINT_CONFIG);
> -			new_csg_prio--;
> -		}
> +		list_for_each_entry(group, &ctx->groups[prio], run_node)
> +			tick_ctx_reschedule_group(sched, &upd_ctx, group,
> +						  new_csg_prio--);
>  	}
>  
>  	ret = csgs_upd_ctx_apply_locked(ptdev, &upd_ctx);
> @@ -2355,28 +2387,18 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
>  	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
>  		list_for_each_entry(group, &ctx->groups[prio], run_node) {
>  			int csg_id = group->csg_id;
> -			struct panthor_fw_csg_iface *csg_iface;
> +			int csg_prio = new_csg_prio--;
>  
> -			if (csg_id >= 0) {
> -				new_csg_prio--;
> +			if (csg_id >= 0)
>  				continue;
> -			}
>  
>  			csg_id = ffs(free_csg_slots) - 1;
>  			if (drm_WARN_ON(&ptdev->base, csg_id < 0))
>  				break;
>  
> -			csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
> -			csg_slot = &sched->csg_slots[csg_id];
> -			group_bind_locked(group, csg_id);
> -			csg_slot_prog_locked(ptdev, csg_id, new_csg_prio--);
> -			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
> -						group->state == PANTHOR_CS_GROUP_SUSPENDED ?
> -						CSG_STATE_RESUME : CSG_STATE_START,
> -						CSG_STATE_MASK);
> -			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
> -						csg_iface->output->ack ^ CSG_ENDPOINT_CONFIG,
> -						CSG_ENDPOINT_CONFIG);
> +			tick_ctx_schedule_group(sched, &upd_ctx, group, csg_id,
> +						csg_prio);
> +
>  			free_csg_slots &= ~BIT(csg_id);
>  		}
>  	}

