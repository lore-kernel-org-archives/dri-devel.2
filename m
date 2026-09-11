Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CAEC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8884110E3EF;
	Fri, 11 Sep 2026 14:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Z32wAgTM";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3BF10E3EF
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789136599;
 bh=7qErcdwlDroFhxjOYc7NmzR5Gu7OsLJ9/XniaMUdOc0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z32wAgTM/pdcaGUoYt0tZHrb97Bmg9aIBaMTEG3gDhADh4VNELoTxDvHMir/BM8ON
 ZjWKULk3lFX2dJoV5sSRKG72SkgVfJBcPhPPJcfn0UvYmZpIws64NTMm+gHVYQ/XCe
 8Ft48aeK1gLTa7XW84pH2m82r5lqxdPJaA3OwpsrBsBod3KZjr1nYE7+36mOAtn829
 +F1a+3mJd6kJvXMED0cQveSdvGXh2QN89lCCi5Ktf+p88P5ZJhb7DVEc6J3ACkyBjk
 JW1Jjhvtwg7PRL8FKtvmq92KBzAFdDyGpBtiGQUoZ1HW9Du/EVAzgS3iLkA3qQoN/a
 cMESsWQM3wxpA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3918517E0803;
 Fri, 11 Sep 2026 16:23:19 +0200 (CEST)
Date: Fri, 11 Sep 2026 16:23:14 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Florent
 Tomasin <florent.tomasin@arm.com>
Subject: Re: [PATCH v3 2/6] drm/panthor: Minor scheduler refactoring
Message-ID: <20260911162314.0957730f@fedora-21.home>
In-Reply-To: <20260911114014.79139-3-ketil.johnsen@arm.com>
References: <20260911114014.79139-1-ketil.johnsen@arm.com>
 <20260911114014.79139-3-ketil.johnsen@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 11 Sep 2026 13:40:10 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> 
> ---
> 
> v3:
> - Use panthor_fw_csg_endpoint_req_update() (was rebase mistake)
> - Function rename to tick_ctx_update_group_prio()
> 
> v2:
> - Moved option to ding only the CSG doorbell to later patch
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 131 ++++++++++++++----------
>  1 file changed, 79 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 60b2417deb81b..1123cf36a7bca 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2344,12 +2344,81 @@ tick_ctx_cleanup(struct panthor_scheduler *sched,
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
> +tick_ctx_update_group_prio(struct panthor_scheduler *sched,
> +			   struct panthor_csg_slots_upd_ctx *upd_ctx,
> +			   struct panthor_group *group,
> +			   int new_csg_prio)
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
> +		panthor_fw_csg_endpoint_req_update(ptdev, csg_iface,
> +						   CSG_EP_REQ_PRIORITY(new_csg_prio),
> +						   CSG_EP_REQ_PRIORITY_MASK);
> +		csgs_upd_ctx_queue_reqs(ptdev, upd_ctx, group->csg_id,
> +					csg_iface->output->ack ^ CSG_ENDPOINT_CONFIG,
> +					CSG_ENDPOINT_CONFIG);
> +	}
> +}
> +
> +static int
> +tick_ctx_schedule_group(struct panthor_scheduler *sched,
> +			struct panthor_csg_slots_upd_ctx *upd_ctx,
> +			struct panthor_group *group,
> +			int csg_id, int csg_prio)
> +{
> +	struct panthor_device *ptdev = sched->ptdev;
> +	struct panthor_fw_csg_iface *csg_iface =
> +		panthor_fw_get_csg_iface(ptdev, csg_id);
> +	int ret;
> +
> +	ret = group_bind_locked(group, csg_id);
> +	if (ret)
> +		return ret;
> +
> +	csg_slot_prog_locked(ptdev, csg_id, csg_prio);
> +
> +	csgs_upd_ctx_queue_reqs(ptdev, upd_ctx, csg_id,
> +				group->state == PANTHOR_CS_GROUP_SUSPENDED ?
> +					CSG_STATE_RESUME : CSG_STATE_START,
> +				CSG_STATE_MASK);
> +	csgs_upd_ctx_queue_reqs(ptdev, upd_ctx, csg_id,
> +				csg_iface->output->ack ^ CSG_ENDPOINT_CONFIG,
> +				CSG_ENDPOINT_CONFIG);
> +
> +	return 0;
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
> @@ -2359,44 +2428,13 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
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
> +			tick_ctx_update_group_prio(sched, &upd_ctx, group,
> +						   new_csg_prio--);
>  	}
>  
>  	ret = csgs_upd_ctx_apply_locked(ptdev, &upd_ctx);
> @@ -2424,34 +2462,23 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
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
> -			ret = group_bind_locked(group, csg_id);
> +			ret = tick_ctx_schedule_group(sched, &upd_ctx, group,
> +						      csg_id, csg_prio);
>  			if (ret) {
>  				panthor_device_schedule_reset(ptdev);
>  				ctx->csg_upd_failed_mask |= BIT(csg_id);
>  				return;
>  			}
>  
> -			csg_slot_prog_locked(ptdev, csg_id, new_csg_prio--);
> -			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
> -						group->state == PANTHOR_CS_GROUP_SUSPENDED ?
> -						CSG_STATE_RESUME : CSG_STATE_START,
> -						CSG_STATE_MASK);
> -			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
> -						csg_iface->output->ack ^ CSG_ENDPOINT_CONFIG,
> -						CSG_ENDPOINT_CONFIG);
>  			free_csg_slots &= ~BIT(csg_id);
>  		}
>  	}

