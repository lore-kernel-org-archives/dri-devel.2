Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58B1CD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 14:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391E210E55A;
	Fri,  1 May 2026 14:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rGReEUTJ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7898310E55A
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 14:20:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 634832C1C;
 Fri,  1 May 2026 07:20:16 -0700 (PDT)
Received: from [10.1.29.19] (e122027.cambridge.arm.com [10.1.29.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1EF3F7B4;
 Fri,  1 May 2026 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777645221; bh=jVJIe1otIUt5m0RD5lP7NCJyTZiZSJ3+3BJy47KOlMo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rGReEUTJWw2mTXuIq6dPm4kxKyRDkjkAJ6jfCAFJMyZx35hopJlZSIloTG9fVabxJ
 sFPhHS78TzkcfvcUBDaPeGLAiG3Vec4YR780s0XP6VUADaqrj9gpchpwF/L50IEtTL
 /au+rCiWuRxvrbASKFWak9UjlaFOh2hWeGVcv9Cs=
Message-ID: <446e9d1f-b6be-42fa-bd2b-f4fcbc130f70@arm.com>
Date: Fri, 1 May 2026 15:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] drm/panthor: Automatically enable interrupts in
 panthor_fw_wait_acks()
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-8-4b92ae4142d2@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260429-panthor-signal-from-irq-v1-8-4b92ae4142d2@collabora.com>
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
> Rather than assuming an interrupt is always expected for request
> acks, temporarily enable the relevant interrupts when the polling-wait
> failed. This should hopefully reduce the number of interrupts the CPU
> has to process.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

It seems to work, although I'm lightly uneasy about this because I'm not
entirely sure whether the FW will immediately see the updates to
ack_irq_mask and therefore whether there's a possibility to miss an
event and be stuck waiting for the timeout.

Memory models are not my strong point, OpenAI tells me the sequence
should be something like:

  scoped_guard(spinlock_irqsave, lock) {
  	u32 ack_irq_mask = READ_ONCE(*ack_irq_mask_ptr);

  	WRITE_ONCE(*ack_irq_mask_ptr, ack_irq_mask | req_mask);
  }

  /*
   * The FW interface can be mapped write-combine/Normal-NC. Make sure the
   * IRQ mask update is visible to the FW before sleeping waiting for
the IRQ.
   */
  wmb();

Which seems plausible. But I've long ago learnt that plausible doesn't
mean much when dealing with memory models!

Thanks,
Steve

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
> index 601a9bff1485..2edba335f22d 100644
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

