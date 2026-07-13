Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD955C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A8310E58A;
	Mon, 13 Jul 2026 08:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AN4K0NJq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64BBE10E58A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783931906;
 bh=VVDfYLqjULkUiK72pDBc/EMW/5VzZAyF9GRLKhKXR6w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AN4K0NJqxllTOPqUDnQ7LdLYx2YmrSRqFAycnx2mQWndOYSaaUlL57dGrcJLpXANe
 XjFspsN+LrfqUGhmS1zMpzFW6Q0xJXkrLFw0dowipvz3I8eTP7QGer0AgphBjYUTfK
 9KUVnLZlvoTxwbz6QqmasGnRxvN3X0n4+P2c365rrAGsD6fk46bXuAQ1Z+2cwi/10W
 dYcNlMSuGMpmhmXj8jv7I62gwK627Yg/q2evXF5BLIqs0tOqVjDCdGe1/jByr7OcLd
 nRsSFaP/bV8fpY8ROiJFXK2wyD1YAAas9eYFQOoutYbsp2CuaEHfthCkRn+k+FzNTd
 OLh+7QxX6rZ2A==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5FBAA17E05D3;
 Mon, 13 Jul 2026 10:38:26 +0200 (CEST)
Date: Mon, 13 Jul 2026 10:37:56 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Florent
 Tomasin <florent.tomasin@arm.com>, Paul Toadere <paul.toadere@arm.com>,
 Samuel Percival <samuel.percival@arm.com>
Subject: Re: [PATCH v2 6/7] drm/panthor: Add support for entering and
 exiting protected mode
Message-ID: <20260713103756.759f353c@fedora-2.home>
In-Reply-To: <20260712135439.1546950-7-ketil.johnsen@arm.com>
References: <20260712135439.1546950-1-ketil.johnsen@arm.com>
 <20260712135439.1546950-7-ketil.johnsen@arm.com>
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

Hi Ketil,

On Sun, 12 Jul 2026 15:54:38 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> From: Florent Tomasin <florent.tomasin@arm.com>
> 
> This patch modifies the Panthor driver code to allow handling
> of the GPU HW protected mode enter and exit.
> 
> The logic added by this patch includes:
> - the mechanisms needed for entering and exiting protected mode.
> - the handling of protected mode IRQs and FW interactions.
> - the scheduler changes needed to decide when to enter
>   protected mode based on CSG scheduling.
> - GPU fault handling during protected mode execution.
> 
> Note that the submission of a protected mode jobs are done
> from the user space.
> 
> The following is a summary of how protected mode is entered
> and exited:
> - When the GPU detects a protected mode job needs to be
>   executed, an IRQ is sent to the CPU to notify the kernel
>   driver that the job is blocked until the GPU has entered
>   protected mode. The entering of protected mode is controlled
>   by the kernel driver.
> - The Mali Panthor CSF driver will schedule a tick and evaluate
>   which CS in the CSG to schedule on slot needs protected mode.
>   If the priority of the CSG is not sufficiently high, the
>   protected mode job will not progress until the CSG is
>   scheduled at top priority.
> - The Panthor scheduler notifies the GPU that the blocked
>   protected jobs will soon be able to progress.
> - Once all CSG and CS slots are updated, the scheduler
>   requests the GPU to enter protected mode and waits for
>   it to be acknowledged.
> - If successful, all protected mode jobs will resume execution
>   while normal mode jobs block until the GPU exits
>   protected mode, or the kernel driver rotates the CSGs
>   and forces the GPU to exit protected mode.
> - If unsuccessful, the scheduler will request a GPU reset.
> - Faults during protected mode are reported GPU wide, and not as
>   CSG/CS errors. We allow only one CSG to run in protected mode at a
>   time so we know which CSG to blame for the fault.
> - All faults during protected mode are handled with a GPU reset.
> - When a protected mode job is suspended as a result of
>   the CSGs rotation, the GPU will send an IRQ to the CPU
>   to notify that the protected mode job needs to resume.
> 
> This sequence will continue so long the user space is
> submitting protected mode jobs.
> 
> Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
> Co-developed-by: Paul Toadere <paul.toadere@arm.com>
> Signed-off-by: Paul Toadere <paul.toadere@arm.com>
> Co-developed-by: Samuel Percival <samuel.percival@arm.com>
> Signed-off-by: Samuel Percival <samuel.percival@arm.com>
> Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |   1 +
>  drivers/gpu/drm/panthor/panthor_device.h |  33 +++
>  drivers/gpu/drm/panthor/panthor_fw.c     |  90 +++++-
>  drivers/gpu/drm/panthor/panthor_fw.h     |   5 +
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  53 +++-
>  drivers/gpu/drm/panthor/panthor_gpu.h    |   4 +
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  29 +-
>  drivers/gpu/drm/panthor/panthor_sched.c  | 333 ++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_sched.h  |   4 +
>  9 files changed, 533 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index bd417d6ae8c00..c0cdefd330799 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -172,6 +172,7 @@ int panthor_device_init(struct panthor_device *ptdev)
>  
>  	ptdev->soc_data = of_device_get_match_data(ptdev->base.dev);
>  
> +	init_rwsem(&ptdev->protm.lock);
>  	init_completion(&ptdev->unplug.done);
>  	ret = drmm_mutex_init(&ptdev->base, &ptdev->unplug.lock);
>  	if (ret)
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 35679bfa1f3a6..e5df42f095717 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -332,6 +332,26 @@ struct panthor_device {
>  		struct list_head node;
>  	} gems;
>  #endif
> +	/** @protm: Protected mode related data. */
> +	struct {
> +		/**
> +		 * @lock: Lock to prevent MMU operations during protected mode.
> +		 *
> +		 * The MMU HW will silently ignore commands issued when the
> +		 * GPU is in protected mode. It is important that we handle this
> +		 * for some of the MMU HW interactions.
> +		 *
> +		 * panthor_vm_lock_region() will down this as a reader, and
> +		 * this will prevent any new transition into protected mode.
> +		 * panthor_vm_lock_region() will then wait for GPU to return
> +		 * to normal mode before proceeding.
> +		 * It is now safe to carry out page table modifications.
> +		 * Only the switch into protected mode itself will down this
> +		 * as a writer. The wait for GPU to leave protected mode
> +		 * in panthor_vm_lock_region() will ensure this is enough.
> +		 */
> +		struct rw_semaphore lock;
> +	} protm;
>  };
>  
>  struct panthor_gpu_usage {
> @@ -628,6 +648,19 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
>  		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
>  }
>  
> +/**
> + * PANTHOR_IRQ_HANDLER_DECL() - Forward declare interrupt handlers helpers
> + *
> + * Exposes the IRQ helper functions panthor_xxx_irq_enable_events() and
> + * panthor_xxx_disable_events(), so these can be used from within the
> + * IRQ handler itself.
> + */
> +#define PANTHOR_IRQ_HANDLER_DECL(__name)				     \
> +static inline void panthor_ ## __name ## _irq_enable_events(		     \
> +					struct panthor_irq *pirq, u32 mask); \
> +static inline void panthor_ ## __name ## _irq_disable_events(		     \
> +					struct panthor_irq *pirq, u32 mask);
> +

This should all be gone when [1] lands, but for the time being, and
assuming the IRQ handler overhaul doesn't make it before this PROTM
series, I think I'd prefer if those were manually defined where needed.

>  extern struct workqueue_struct *panthor_cleanup_wq;
>  
>  static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 389f9182fac16..76792f9175b57 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1035,7 +1035,9 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
>  					 GLB_CFG_PROGRESS_TIMER |
>  					 GLB_CFG_POWEROFF_TIMER |
>  					 GLB_IDLE_EN |
> -					 GLB_IDLE;
> +					 GLB_IDLE |
> +					 GLB_PROTM_ENTER |
> +					 GLB_PROTM_EXIT;
>  
>  	if (panthor_fw_has_glb_state(ptdev))
>  		glb_iface->input->ack_irq_mask |= GLB_STATE_MASK;
> @@ -1441,6 +1443,92 @@ static void panthor_fw_ping_work(struct work_struct *work)
>  	}
>  }
>  
> +static int panthor_fw_protm_enter_wait(struct panthor_device *ptdev,
> +				       u32 timeout_ms)

Looks like this is only used in one place, so I'd inline the content
of this function in panthor_fw_protm_enter().

> +{
> +	struct panthor_fw_global_iface *glb_iface =
> +		panthor_fw_get_glb_iface(ptdev);
> +	int ret;
> +
> +	/* Poll for the entry of protected mode.
> +	 * GLB_PROTM_EXIT is also checked as it may happen that FW enters and
> +	 * exits protected mode very quickly and so the GPU_STATUS_PROTM_ACTIVE
> +	 * bit is seen as 0 throughout the polling.

Is there a risk that PROTM_EXIT is acknowledged before we had a chance
to check it, or do we hold the scheduler lock when protm_enter_wait()
is called? If the race exists, I'd be tempted to rework the thing so it can't
happen, maybe with some sort of atomic counter counting the number of times
PROTM was entered, which would turn the check into something like

	old_protm_entered_count < atomic_read(fw->protm.entered_count)

That implies reading the counter before the PROTM_ENTER request is sent,
of course. I also see this protm.entered_count as a useful metric to
expose through debugfs.

> +	 */
> +	ret = wait_event_timeout(ptdev->fw->req_waitqueue,
> +				 (panthor_gpu_status(ptdev) &
> +					GPU_STATUS_PROTM_ACTIVE) ||

Why not simply use the PROTM_ENTER event in GLB_ACK_IRQ_MASK for that?
It looks like it would give us exactly what we want, instead of this
transient PROTM_ACTIVE bit in the GPU_STATUS reg, and we're in control
of when we acknowledge the event, so no risk of losing it.

As mentioned above, we probably want a counter so the IRQ handler can
report the progress without the risk of losing the event because it
got acknowledged before we had a chance to see it.

> +				((glb_iface->input->req ^ glb_iface->output->ack) &
> +					 GLB_PROTM_EXIT),

For multi-conditionals like that, I tend to prefer helper functions
to keep the code readable.

static bool protm_entered(struct panthor_device *ptdev)
{
	struct panthor_fw_global_iface *glb_iface;

	if (panthor_gpu_status(ptdev) &	GPU_STATUS_PROTM_ACTIVE)
		return true;

	glb_iface = panthor_fw_get_glb_iface(ptdev);
	if ((glb_iface->input->req ^ glb_iface->output->ack) & GLB_PROTM_EXIT)
		return true;

	return false;
}

> +				 msecs_to_jiffies(timeout_ms));
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +int panthor_fw_protm_enter(struct panthor_device *ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface =
> +		panthor_fw_get_glb_iface(ptdev);
> +	u32 acked;
> +	int ret;
> +
> +	/* Restart the watchdog timer, so it doesn't hit immediately
> +	 * after entering protected mode, since this will cause GPU
> +	 * to exit protected mode to respond to the ping request.
> +	 */
> +	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
> +		msecs_to_jiffies(PING_INTERVAL_MS));

nit:

	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
			 msecs_to_jiffies(PING_INTERVAL_MS));

> +
> +	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PROTM_ENTER);
> +	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
> +
> +	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PROTM_ENTER, &acked, 4000);

Are you sure you meant 4000ms? Looks unexpectedly high to me.

> +	if (ret) {
> +		drm_err(&ptdev->base,
> +			"Wait for FW protected mode acknowledge timed out");
> +		return ret;
> +	}
> +
> +	/* Wait for the GPU to actually enter protected mode.
> +	 * There would be some time gap between FW sending the
> +	 * ACK for GLB_PROTM_ENTER and GPU entering protected mode.

Oh, that explains why you're using GPU_STATUS and not PROTM_ENTER ack,
my bad. I think I'd still prefer entered/exited_count counters to keep
track of those, and then the GPU_STATUS check on top.

> +	 */
> +	ret = panthor_fw_protm_enter_wait(ptdev, 500);

500ms to enter PROTM sounds quite high too, no?

> +	if (ret)
> +		drm_err(&ptdev->base,
> +			"Wait for GPU protected mode enter timed out");
> +
> +	return ret;
> +}
> +
> +int panthor_fw_protm_exit_wait(struct panthor_device *ptdev, u32 timeout_ms)
> +{
> +	int ret;
> +
> +	ret = wait_event_timeout(ptdev->fw->req_waitqueue,
> +				 !(panthor_gpu_status(ptdev) &
> +					GPU_STATUS_PROTM_ACTIVE),

Is there anything preventing PROTM_ENTER requests from being queued while
we're waiting? The protm lock maybe? If that's the case, I'd expect some
lockdep_assert_held() to make sure this is truly the case.

> +				 msecs_to_jiffies(timeout_ms));
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +int panthor_fw_protm_exit(struct panthor_device *ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface =
> +		panthor_fw_get_glb_iface(ptdev);
> +
> +	/* Send PING request to force an exit */
> +	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
> +	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
> +
> +	return panthor_fw_protm_exit_wait(ptdev, 500);
> +}
> +
>  /**
>   * panthor_fw_init() - Initialize FW related data.
>   * @ptdev: Device.
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index a99a9b6f4825c..78658d64b807e 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -529,4 +529,9 @@ static inline int panthor_fw_resume(struct panthor_device *ptdev)
>  int panthor_fw_init(struct panthor_device *ptdev);
>  void panthor_fw_unplug(struct panthor_device *ptdev);
>  
> +int panthor_fw_protm_enter(struct panthor_device *ptdev);
> +int panthor_fw_protm_exit(struct panthor_device *ptdev);
> +int panthor_fw_protm_exit_wait(struct panthor_device *ptdev,
> +			       u32 timeout_ms);
> +
>  #endif
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index e52c5675981f5..9054ac251fd3e 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -46,6 +46,9 @@ struct panthor_gpu {
>  
>  	/** @cache_flush_lock: Lock to serialize cache flushes */
>  	struct mutex cache_flush_lock;
> +
> +	/** @protm_fault: True if a GPU_IRQ_PROTM_FAULT has been raised */
> +	bool protm_fault;

Is this protected with some lock? If it is, it should probably be documented,
if not, I suspect we want an atomic instead.

>  };
>  
>  #define GPU_INTERRUPTS_MASK	\
> @@ -86,10 +89,42 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
>  	gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
>  }
>  
> +PANTHOR_IRQ_HANDLER_DECL(gpu);
> +
>  static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>  {
>  	struct panthor_gpu *gpu = ptdev->gpu;
>  
> +	if (status & GPU_IRQ_PROTM_FAULT) {
> +		/* Make a note of this fault before we clear the interrupt.
> +		 * This ensures panthor_gpu_protm_fault_pending() can always
> +		 * give an accurate answer.
> +		 *
> +		 * There is a race we need to handle between two interrupts,
> +		 * this GPU_IRQ_PROTM_FAULT and JOB_INT_GLOBAL_IF with the
> +		 * GLB_PROTM_EXIT event.
> +		 *
> +		 * Although GPU_IRQ_PROTM_FAULT is always raised first,
> +		 * processing of GLB_PROTM_EXIT could still execute first.
> +		 * The handling of GLB_PROTM_EXIT MUST know if a
> +		 * GPU_IRQ_PROTM_FAULT has been raised or not, otherwise it
> +		 * could incorrectly think everything is fine and resume
> +		 * with normal scheduling to early.
> +		 *
> +		 * We still need to do fault handling (reset) here as well,
> +		 * because some failures during protected mode do not
> +		 * automatically exit protected mode (no GLB_PROTM_EXIT).
> +		 * This means there is a slim chance we do two GPU resets
> +		 * instead of just one. This is not ideal, but should be safe.
> +		 */
> +		WRITE_ONCE(gpu->protm_fault, true);
> +
> +		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
> +		panthor_gpu_irq_disable_events(&ptdev->gpu->irq,
> +					       GPU_IRQ_PROTM_FAULT);
> +		panthor_device_schedule_reset(ptdev);
> +	}
> +
>  	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
>  
>  	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
> @@ -106,8 +141,6 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>  			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
>  			 address);
>  	}
> -	if (status & GPU_IRQ_PROTM_FAULT)
> -		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
>  
>  	spin_lock(&ptdev->gpu->reqs_lock);
>  	if (status & ptdev->gpu->pending_reqs) {
> @@ -118,6 +151,13 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>  }
>  PANTHOR_IRQ_HANDLER(gpu, panthor_gpu_irq_handler);
>  
> +bool panthor_gpu_protm_fault_pending(struct panthor_device *ptdev)
> +{
> +	return READ_ONCE(ptdev->gpu->protm_fault) ||
> +		gpu_read(ptdev->gpu->irq.iomem, INT_RAWSTAT) &
> +			GPU_IRQ_PROTM_FAULT;

Why do we need both? Is this not enough to check for GPU_IRQ_PROTM_FAULT
in INT_RAWSTAT? Is too slow to go all the way through the peripheral bus
to read the reg?

> +}
> +
>  /**
>   * panthor_gpu_unplug() - Called when the GPU is unplugged.
>   * @ptdev: Device to unplug.
> @@ -380,6 +420,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> +
> +	WRITE_ONCE(ptdev->gpu->protm_fault, false);
> +	panthor_gpu_irq_enable_events(&ptdev->gpu->irq,	GPU_IRQ_PROTM_FAULT);
> +
>  	if (!drm_WARN_ON(&ptdev->base,
>  			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
>  		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
> @@ -480,3 +524,8 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
>  	drm_err(&ptdev->base, "Coherency not supported by the device");
>  	return -ENOTSUPP;
>  }
> +
> +u32 panthor_gpu_status(struct panthor_device *ptdev)
> +{
> +	return gpu_read(ptdev->gpu->iomem, GPU_STATUS);
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
> index f615feb056094..00ec9a8c5d7fd 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.h
> @@ -60,4 +60,8 @@ u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev);
>  
>  int panthor_gpu_coherency_init(struct panthor_device *ptdev);
>  
> +u32 panthor_gpu_status(struct panthor_device *ptdev);
> +
> +bool panthor_gpu_protm_fault_pending(struct panthor_device *ptdev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index ed2ae5a6008d1..75c484118f6ba 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1794,11 +1794,30 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	if (drm_WARN_ON(&ptdev->base, vm->locked_region.size))
>  		return -EINVAL;
>  
> +	/* Prevent GPU from entering protected mode */
> +	panthor_sched_protm_block(ptdev);
> +
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && size) {
> -		u64 region = pack_region_range(ptdev, &start, &size);
> +		mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
> -		ret = panthor_vm_apply_as_lock(vm, region);
> +		/* Wait for GPU to exit protected mode.
> +		 * There is a slim chance that the GPU has faulted in protected
> +		 * mode. Such failures are handled with a GPU reset.
> +		 * That is why we temporary release the as.slots_lock, while we
> +		 * wait for protected mode to exit, since the same lock will
> +		 * be acquired during the GPU reset procedure.

This gets tricky if we start having to wait for the reset to be effective
in the panthor_vm_lock_region() path. Until now, what was expected was:
if the AS command fails/times-out, we schedule a reset, and fail the operation.

This relates back to another comment I made in the previous revision, where
I didn't quite get how the VM operation was prevented while the GPU is
in PROTM. I'd really like us to prevent any VM update on a resident AS for the
whole time the GPU is in PROTM. Which implies taking the protm lock in read
mode **and** waiting for the PROTM_EXIT event (or
protm.entered_count == protm.exited_count if you track those with counters)
before anything else. This is basically what you do here, but I don't like the
fact this lock+wait-protm-exit is mixed with the concept of AS locking instead
of being its own thing, and leaving the responsibility to acquire+wait+release
to panthor_vm_exec_op(). With that changed, I don't think we'd need
panthor_vm_expand_locked_region() (though it might be good to have regardless).

If it's something you need to do in multiple places, we might want to make it
its own DEFINE_GUARD_COND (basically overloading the existing rwsem one).

> +		 */
> +

nit: you can drop this extra blank line.

> +		panthor_sched_protm_exit(ptdev);
> +
> +		mutex_lock(&ptdev->mmu->as.slots_lock);
> +
> +		if (vm->as.id >= 0 && size) {
> +			u64 region = pack_region_range(ptdev, &start, &size);
> +
> +			ret = panthor_vm_apply_as_lock(vm, region);
> +		}
>  	}
>  
>  	if (!ret) {
> @@ -1807,6 +1826,9 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
> +	if (ret)
> +		panthor_sched_protm_unblock(ptdev);
> +
>  	return ret;
>  }
>  
> @@ -1890,6 +1912,9 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
>  	vm->locked_region.start = 0;
>  	vm->locked_region.size = 0;
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
> +
> +	/* Let scheduler know it is safe to enter protected mode again */
> +	panthor_sched_protm_unblock(ptdev);
>  }

I'm stopping here for now, but I'll try to finish the review before the end of
the week.

Regards,

Boris

[1]https://lore.kernel.org/dri-devel/20260625-panthor-signal-from-irq-v5-10-8836a74e0ef9@collabora.com/
