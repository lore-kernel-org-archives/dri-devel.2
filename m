Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75386CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 14:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BBD10E389;
	Thu, 14 May 2026 14:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="j46jCVvt";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5660810E389
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 14:25:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 866C81C00;
 Thu, 14 May 2026 07:25:05 -0700 (PDT)
Received: from [10.1.37.28] (e122027.cambridge.arm.com [10.1.37.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD8133F7B4;
 Thu, 14 May 2026 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778768710; bh=l7LotTyfe1YXxHTYaep0pAJ6PentvBrdPtfTlDlMwNc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j46jCVvt6GLlhSl5L7eOJ0RC8mmKqOPIVM47HyMcptJIU2ljZmNKnEVvnXfKfjx3+
 fea5iKUOrzk3QRMzlPAjlEDBoa5Bx6tvG1YiU6Be/NEz4zYNw3DNbnhX0AmjZhA4xA
 3q3Mm8GmPvm/w8rhwhWsplXGL5YDVHj1+nCi6oCo=
Message-ID: <44d8b158-76bd-4ad5-9fd5-616afd432155@arm.com>
Date: Thu, 14 May 2026 15:25:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] drm/panthor: Automatically enable interrupts in
 panthor_fw_wait_acks()
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-8-95c614a739cb@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260512-panthor-signal-from-irq-v2-8-95c614a739cb@collabora.com>
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

On 12/05/2026 12:37, Boris Brezillon wrote:
> Rather than assuming an interrupt is always expected for request
> acks, temporarily enable the relevant interrupts when the polling-wait
> failed. This should hopefully reduce the number of interrupts the CPU
> has to process.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

As mentioned in the other thread[1] it turns out this won't work with
the current firmware.

The firmware checks the interrupt mask before signalling the ACK - so
enabling the bit in the mask just before waiting for it is problematic -
the firmware may not see the addition in the mask and will not trigger
the interrupt.

In practice this will mostly work - the CPU is fast enough that it's
unlikely the firmware will have picked up the request by the time we
become blocked (and hence the firmware's mask read will be after the
host is already in the wait_event_timeout()). But it's not robust.

I'm hoping to get at least a clarification in the spec if not a change
in (later) firmware.

Thanks,
Steve

[1]
https://lore.kernel.org/all/3c721f22-d1a7-474e-8276-f0afc7cd9a0b@arm.com/

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c    | 34 +++++++++++++++++++--------------
>  drivers/gpu/drm/panthor/panthor_sched.c |  5 +++--
>  2 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 8239a6951569..f5e0ceca4130 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1039,16 +1039,10 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
>  	glb_iface->input->progress_timer = PROGRESS_TIMEOUT_CYCLES >> PROGRESS_TIMEOUT_SCALE_SHIFT;
>  	glb_iface->input->idle_timer = panthor_fw_conv_timeout(ptdev, IDLE_HYSTERESIS_US);
>  
> -	/* Enable interrupts we care about. */
> -	glb_iface->input->ack_irq_mask = GLB_CFG_ALLOC_EN |
> -					 GLB_PING |
> -					 GLB_CFG_PROGRESS_TIMER |
> -					 GLB_CFG_POWEROFF_TIMER |
> -					 GLB_IDLE_EN |
> -					 GLB_IDLE;
> -
> -	if (panthor_fw_has_glb_state(ptdev))
> -		glb_iface->input->ack_irq_mask |= GLB_STATE_MASK;
> +	/* Enable interrupts for asynchronous events that are not
> +	 * triggered by request acks.
> +	 */
> +	glb_iface->input->ack_irq_mask = GLB_IDLE;
>  
>  	panthor_fw_update_reqs(glb_iface, req, GLB_IDLE_EN | GLB_COUNTER_EN,
>  			       GLB_IDLE_EN | GLB_COUNTER_EN);
> @@ -1318,8 +1312,8 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
>   * Return: 0 on success, -ETIMEDOUT otherwise.
>   */
>  static int panthor_fw_wait_acks(const u32 *req_ptr, const u32 *ack_ptr,
> -				wait_queue_head_t *wq,
> -				u32 req_mask, u32 *acked,
> +				u32 *ack_irq_mask_ptr, spinlock_t *lock,
> +				wait_queue_head_t *wq, u32 req_mask, u32 *acked,
>  				u32 timeout_ms)
>  {
>  	u32 ack, req = READ_ONCE(*req_ptr) & req_mask;
> @@ -1334,8 +1328,16 @@ static int panthor_fw_wait_acks(const u32 *req_ptr, const u32 *ack_ptr,
>  	if (!ret)
>  		return 0;
>  
> -	if (wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) == req,
> -			       msecs_to_jiffies(timeout_ms)))
> +	scoped_guard(spinlock_irqsave, lock)
> +		*ack_irq_mask_ptr |= req_mask;
> +
> +	ret = wait_event_timeout(*wq, (READ_ONCE(*ack_ptr) & req_mask) == req,
> +				 msecs_to_jiffies(timeout_ms));
> +
> +	scoped_guard(spinlock_irqsave, lock)
> +		*ack_irq_mask_ptr &= ~req_mask;
> +
> +	if (ret)
>  		return 0;
>  
>  	/* Check one last time, in case we were not woken up for some reason. */
> @@ -1369,6 +1371,8 @@ int panthor_fw_glb_wait_acks(struct panthor_device *ptdev,
>  
>  	return panthor_fw_wait_acks(&glb_iface->input->req,
>  				    &glb_iface->output->ack,
> +				    &glb_iface->input->ack_irq_mask,
> +				    &glb_iface->lock,
>  				    &ptdev->fw->req_waitqueue,
>  				    req_mask, acked, timeout_ms);
>  }
> @@ -1395,6 +1399,8 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_slot,
>  
>  	ret = panthor_fw_wait_acks(&csg_iface->input->req,
>  				   &csg_iface->output->ack,
> +				   &csg_iface->input->ack_irq_mask,
> +				   &csg_iface->lock,
>  				   &ptdev->fw->req_waitqueue,
>  				   req_mask, acked, timeout_ms);
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 6c5ba747ae45..a9124bcc7de6 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1110,7 +1110,7 @@ cs_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs_id)
>  	cs_iface->input->ringbuf_output = queue->iface.output_fw_va;
>  	cs_iface->input->config = CS_CONFIG_PRIORITY(queue->priority) |
>  				  CS_CONFIG_DOORBELL(queue->doorbell_id);
> -	cs_iface->input->ack_irq_mask = ~0;
> +	cs_iface->input->ack_irq_mask = CS_FATAL | CS_FAULT | CS_TILER_OOM;
>  	panthor_fw_update_reqs(cs_iface, req,
>  			       CS_IDLE_SYNC_WAIT |
>  			       CS_IDLE_EMPTY |
> @@ -1378,7 +1378,8 @@ csg_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 priority)
>  		csg_iface->input->protm_suspend_buf = 0;
>  	}
>  
> -	csg_iface->input->ack_irq_mask = ~0;
> +	csg_iface->input->ack_irq_mask = CSG_SYNC_UPDATE | CSG_IDLE |
> +					 CSG_PROGRESS_TIMER_EVENT;
>  	panthor_fw_toggle_reqs(csg_iface, doorbell_req, doorbell_ack, queue_mask);
>  	return 0;
>  }
> 

