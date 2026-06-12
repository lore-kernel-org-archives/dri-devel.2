Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACFECD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DA310E2CC;
	Fri, 12 Jun 2026 07:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cZ2OoU43";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091A010E2CC
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781249076; x=1812785076;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KjCTX/9S7pGihClWf8k7ogpbQw5q2wX9giOL6NSmX4k=;
 b=cZ2OoU43Ygd+74PjKfNMiG3SmZjheGNxxcOdqGuEoeLJpjuwlC5Zu7vy
 xpGzBuO5+r8r/JNtHCjB9EgbJmXfVD/H1j1DU8RoKwxhE88sULi+Fo9Pk
 uwV5NyQ3n6xHYxC1PtQEVdM0cwzCeUNFOHgy5jSzW842L+jY18/D2fkZy
 1u4yd/z5EyhJYTfvtL0vA1RFcdx6Sl58DfepezKYDVvuIdCsH7jIaOSdl
 bKV0gGCZ453Q+y//cHgT52IgQuZTB/FNJQJBTb48WQb3Jrvm9Rs6a/MG4
 UW4ZWPusQ+3OGvQRo/0fxaMaphFsE9f6dnCvuSj3KRx2J9cJFaVpL4E6p w==;
X-CSE-ConnectionGUID: Rdl31B5KSvS/j80TVuJK/A==
X-CSE-MsgGUID: DY/SzhzuSXa00DIrw3fYcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82268768"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="82268768"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 00:24:35 -0700
X-CSE-ConnectionGUID: FO9TSuz+T0WpSiMNgk7w8w==
X-CSE-MsgGUID: 39mNia8hREWjaVjA0ZEUBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="245659180"
Received: from soc-5cg43972ff.clients.intel.com (HELO [10.102.88.80])
 ([10.102.88.80])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 00:24:34 -0700
Message-ID: <d9c6bcb7-2f18-49ac-a224-7a02622cad0e@linux.intel.com>
Date: Fri, 12 Jun 2026 09:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Use threaded IRQ for IPC callback processing
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com
References: <20260611055201.948726-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20260611055201.948726-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11-Jun-26 7:52 AM, Karol Wachowski wrote:
> Dispatching IPC callbacks from system_percpu_wq adds scheduling latency
> that is neither bounded nor predictable, which hurts job completion
> turnaround. Handle them from a threaded IRQ instead: the hard-IRQ
> handler drains the IPC FIFO and wakes the thread, which runs the
> callback consumers such as job-done processing.
> 
> Job resource teardown can trigger IOMMU unmapping and context teardown,
> which is too slow to run from the IRQ thread. Defer it to a dedicated
> WQ_UNBOUND | WQ_MEM_RECLAIM workqueue via a per-device lockless list.
> UNBOUND keeps the long-running cleanup off the percpu workers and
> MEM_RECLAIM guarantees forward progress because the work frees buffer
> objects. The runtime PM reference taken at submission is released only
> after cleanup completes, otherwise runtime suspend could race the
> pending work and deadlock.
> 
> Because cleanup is now asynchronous, userspace that rapidly recycles
> file descriptors or command queues can momentarily observe stale
> per-context resources and fail with -EMFILE or -EBUSY. Flush the
> cleanup work once and retry before giving up.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.c | 28 ++++++++++++++---
>   drivers/accel/ivpu/ivpu_drv.h |  5 ++-
>   drivers/accel/ivpu/ivpu_hw.c  |  4 +++
>   drivers/accel/ivpu/ivpu_ipc.c |  8 ++---
>   drivers/accel/ivpu/ivpu_ipc.h |  2 +-
>   drivers/accel/ivpu/ivpu_job.c | 59 +++++++++++++++++++++++++++++++----
>   drivers/accel/ivpu/ivpu_job.h |  7 ++++-
>   7 files changed, 96 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 35e506074d5f..6b34c52b1fba 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -307,6 +307,11 @@ static int ivpu_open(struct drm_device *dev, struct drm_file *file)
>   		return -ENODEV;
>   
>   	limits = ivpu_user_limits_get(vdev);
> +	if (IS_ERR(limits) && PTR_ERR(limits) == -EMFILE) {
> +		/* Context limit may be held by jobs pending deferred cleanup */
> +		flush_work(&vdev->job_destroy_work);
> +		limits = ivpu_user_limits_get(vdev);
> +	}
>   	if (IS_ERR(limits)) {
>   		ret = PTR_ERR(limits);
>   		goto err_dev_exit;
> @@ -510,9 +515,9 @@ void ivpu_prepare_for_reset(struct ivpu_device *vdev)
>   {
>   	ivpu_hw_irq_disable(vdev);
>   	disable_irq(vdev->irq);
> -	flush_work(&vdev->irq_ipc_work);
>   	flush_work(&vdev->irq_dct_work);
>   	flush_work(&vdev->context_abort_work);
> +	flush_work(&vdev->job_destroy_work);
>   	ivpu_ipc_disable(vdev);
>   	ivpu_mmu_disable(vdev);
>   }
> @@ -584,6 +589,11 @@ static const struct drm_driver driver = {
>   	.major = 1,
>   };
>   
> +static void ivpu_destroy_workqueue(void *wq)
> +{
> +	destroy_workqueue(wq);
> +}
> +
>   static int ivpu_irq_init(struct ivpu_device *vdev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(vdev->drm.dev);
> @@ -595,16 +605,26 @@ static int ivpu_irq_init(struct ivpu_device *vdev)
>   		return ret;
>   	}
>   
> -	INIT_WORK(&vdev->irq_ipc_work, ivpu_ipc_irq_work_fn);
>   	INIT_WORK(&vdev->irq_dct_work, ivpu_pm_irq_dct_work_fn);
>   	INIT_WORK(&vdev->context_abort_work, ivpu_context_abort_work_fn);
> +	init_llist_head(&vdev->job_destroy_list);
> +	INIT_WORK(&vdev->job_destroy_work, ivpu_job_destroy_work_fn);
> +
> +	vdev->job_destroy_wq = alloc_workqueue("ivpu_job_destroy", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> +	if (!vdev->job_destroy_wq)
> +		return -ENOMEM;
> +
> +	ret = devm_add_action_or_reset(vdev->drm.dev, ivpu_destroy_workqueue, vdev->job_destroy_wq);
> +	if (ret)
> +		return ret;
>   
>   	ivpu_irq_handlers_init(vdev);
>   
>   	vdev->irq = pci_irq_vector(pdev, 0);
>   
> -	ret = devm_request_irq(vdev->drm.dev, vdev->irq, ivpu_hw_irq_handler,
> -			       IRQF_NO_AUTOEN, DRIVER_NAME, vdev);
> +	ret = devm_request_threaded_irq(vdev->drm.dev, vdev->irq, ivpu_hw_irq_handler,
> +					ivpu_ipc_irq_thread_handler, IRQF_NO_AUTOEN | IRQF_ONESHOT,
> +					DRIVER_NAME, vdev);
>   	if (ret)
>   		ivpu_err(vdev, "Failed to request an IRQ %d\n", ret);
>   
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index 9eefbbb7ba11..86d7c9966cac 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -13,6 +13,7 @@
>   #include <drm/drm_print.h>
>   
>   #include <linux/hashtable.h>
> +#include <linux/llist.h>
>   #include <linux/pci.h>
>   #include <linux/xarray.h>
>   #include <uapi/drm/ivpu_accel.h>
> @@ -157,9 +158,11 @@ struct ivpu_device {
>   	struct xa_limit db_limit;
>   	u32 db_next;
>   
> -	struct work_struct irq_ipc_work;
>   	struct work_struct irq_dct_work;
>   	struct work_struct context_abort_work;
> +	struct llist_head job_destroy_list;
> +	struct work_struct job_destroy_work;
> +	struct workqueue_struct *job_destroy_wq;
>   
>   	struct mutex bo_list_lock; /* Protects bo_list */
>   	struct list_head bo_list;
> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
> index d4a9bcda4100..647dc045c231 100644
> --- a/drivers/accel/ivpu/ivpu_hw.c
> +++ b/drivers/accel/ivpu/ivpu_hw.c
> @@ -399,6 +399,10 @@ irqreturn_t ivpu_hw_irq_handler(int irq, void *ptr)
>   		return IRQ_NONE;
>   
>   	pm_runtime_mark_last_busy(vdev->drm.dev);
> +
> +	if (ip_handled)
> +		return IRQ_WAKE_THREAD;
> +
>   	return IRQ_HANDLED;
>   }
>   
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index 9f1ba0c57442..64864e9d8a0a 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -462,13 +462,11 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
>   			ivpu_ipc_rx_mark_free(vdev, ipc_hdr, jsm_msg);
>   		}
>   	}
> -
> -	queue_work(system_percpu_wq, &vdev->irq_ipc_work);
>   }
>   
> -void ivpu_ipc_irq_work_fn(struct work_struct *work)
> +irqreturn_t ivpu_ipc_irq_thread_handler(int irq, void *ptr)
>   {
> -	struct ivpu_device *vdev = container_of(work, struct ivpu_device, irq_ipc_work);
> +	struct ivpu_device *vdev = ptr;
>   	struct ivpu_ipc_info *ipc = vdev->ipc;
>   	struct ivpu_ipc_rx_msg *rx_msg, *r;
>   	struct list_head cb_msg_list;
> @@ -483,6 +481,8 @@ void ivpu_ipc_irq_work_fn(struct work_struct *work)
>   		rx_msg->callback(vdev, rx_msg->ipc_hdr, rx_msg->jsm_msg);
>   		ivpu_ipc_rx_msg_del(vdev, rx_msg);
>   	}
> +
> +	return IRQ_HANDLED;
>   }
>   
>   int ivpu_ipc_init(struct ivpu_device *vdev)
> diff --git a/drivers/accel/ivpu/ivpu_ipc.h b/drivers/accel/ivpu/ivpu_ipc.h
> index b524a1985b9d..1c9cf67f1e5b 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.h
> +++ b/drivers/accel/ivpu/ivpu_ipc.h
> @@ -90,7 +90,7 @@ void ivpu_ipc_disable(struct ivpu_device *vdev);
>   void ivpu_ipc_reset(struct ivpu_device *vdev);
>   
>   void ivpu_ipc_irq_handler(struct ivpu_device *vdev);
> -void ivpu_ipc_irq_work_fn(struct work_struct *work);
> +irqreturn_t ivpu_ipc_irq_thread_handler(int irq, void *ptr);
>   
>   void ivpu_ipc_consumer_add(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>   			   u32 channel, ivpu_ipc_rx_callback_t callback);
> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> index b24f31a8b567..ebb2c865b09a 100644
> --- a/drivers/accel/ivpu/ivpu_job.c
> +++ b/drivers/accel/ivpu/ivpu_job.c
> @@ -535,6 +535,20 @@ static void ivpu_job_destroy(struct ivpu_job *job)
>   	kfree(job);
>   }
>   
> +void ivpu_job_destroy_work_fn(struct work_struct *work)
> +{
> +	struct ivpu_device *vdev = container_of(work, struct ivpu_device, job_destroy_work);
> +	struct ivpu_job *job, *tmp;
> +	struct llist_node *list;
> +
> +	list = llist_del_all(&vdev->job_destroy_list);
> +
> +	llist_for_each_entry_safe(job, tmp, list, destroy_node) {
> +		ivpu_job_destroy(job);
> +		ivpu_rpm_put(vdev);
> +	}
> +}
> +
>   static struct ivpu_job *
>   ivpu_job_create(struct ivpu_file_priv *file_priv, u32 engine_idx, u32 bo_count)
>   {
> @@ -619,7 +633,7 @@ bool ivpu_job_handle_engine_error(struct ivpu_device *vdev, u32 job_id, u32 job_
>   	return false;
>   }
>   
> -static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32 job_status)
> +static struct ivpu_job *ivpu_job_signal(struct ivpu_device *vdev, u32 job_id, u32 job_status)
>   {
>   	struct ivpu_job *job;
>   
> @@ -627,7 +641,7 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
>   
>   	job = xa_load(&vdev->submitted_jobs_xa, job_id);
>   	if (!job)
> -		return -ENOENT;
> +		return NULL;
>   
>   	ivpu_job_remove_from_submitted_jobs(vdev, job_id);
>   
> @@ -646,14 +660,37 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
>   		 job->job_id, job->file_priv->ctx.id, job->cmdq_id, job->engine_idx,
>   		 job->job_status);
>   
> -	ivpu_job_destroy(job);
>   	ivpu_stop_job_timeout_detection(vdev);
>   
> -	ivpu_rpm_put(vdev);
> -
>   	if (!xa_empty(&vdev->submitted_jobs_xa))
>   		ivpu_start_job_timeout_detection(vdev);
>   
> +	return job;
> +}
> +
> +static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32 job_status)
> +{
> +	struct ivpu_job *job = ivpu_job_signal(vdev, job_id, job_status);
> +
> +	if (!job)
> +		return -ENOENT;
> +
> +	ivpu_job_destroy(job);
> +	ivpu_rpm_put(vdev);
> +
> +	return 0;
> +}
> +
> +static int ivpu_job_signal_and_defer_destroy(struct ivpu_device *vdev, u32 job_id, u32 job_status)
> +{
> +	struct ivpu_job *job = ivpu_job_signal(vdev, job_id, job_status);
> +
> +	if (!job)
> +		return -ENOENT;
> +
> +	llist_add(&job->destroy_node, &vdev->job_destroy_list);
> +	queue_work(vdev->job_destroy_wq, &vdev->job_destroy_work);
> +
>   	return 0;
>   }
>   
> @@ -689,6 +726,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
>   	struct ivpu_file_priv *file_priv = job->file_priv;
>   	struct ivpu_device *vdev = job->vdev;
>   	struct ivpu_cmdq *cmdq;
> +	bool flushed = false;
>   	bool is_first_job;
>   	int ret;
>   
> @@ -696,6 +734,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
>   	if (ret < 0)
>   		return ret;
>   
> +retry:
>   	mutex_lock(&vdev->submitted_jobs_lock);
>   	mutex_lock(&file_priv->lock);
>   
> @@ -709,6 +748,14 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
>   	}
>   
>   	ret = ivpu_cmdq_register(file_priv, cmdq);
> +	if (ret == -EBUSY && !flushed) {
> +		/* Doorbell may be held by jobs pending deferred cleanup */
> +		mutex_unlock(&file_priv->lock);
> +		mutex_unlock(&vdev->submitted_jobs_lock);
> +		flush_work(&vdev->job_destroy_work);
> +		flushed = true;
> +		goto retry;
> +	}
>   	if (ret) {
>   		ivpu_err(vdev, "Failed to register command queue: %d\n", ret);
>   		goto err_unlock;
> @@ -1101,7 +1148,7 @@ ivpu_job_done_callback(struct ivpu_device *vdev, struct ivpu_ipc_hdr *ipc_hdr,
>   	mutex_lock(&vdev->submitted_jobs_lock);
>   	if (!ivpu_job_handle_engine_error(vdev, payload->job_id, payload->job_status))
>   		/* No engine error, complete the job normally */
> -		ivpu_job_signal_and_destroy(vdev, payload->job_id, payload->job_status);
> +		ivpu_job_signal_and_defer_destroy(vdev, payload->job_id, payload->job_status);
>   	mutex_unlock(&vdev->submitted_jobs_lock);
>   }
>   
> diff --git a/drivers/accel/ivpu/ivpu_job.h b/drivers/accel/ivpu/ivpu_job.h
> index 3ab61e6a5616..d8dbce82447a 100644
> --- a/drivers/accel/ivpu/ivpu_job.h
> +++ b/drivers/accel/ivpu/ivpu_job.h
> @@ -6,8 +6,10 @@
>   #ifndef __IVPU_JOB_H__
>   #define __IVPU_JOB_H__
>   
> -#include <linux/kref.h>
>   #include <linux/idr.h>
> +#include <linux/kref.h>
> +#include <linux/llist.h>
> +#include <linux/workqueue.h>
>   
>   #include "ivpu_gem.h"
>   
> @@ -47,6 +49,7 @@ struct ivpu_cmdq {
>    * @vdev:                Pointer to the VPU device
>    * @file_priv:           The client context that submitted this job
>    * @done_fence:          Fence signaled when job completes
> + * @destroy_node:        List node for deferred resource cleanup after job completion
>    * @cmd_buf_vpu_addr:    VPU address of the command buffer for this job
>    * @cmdq_id:             Command queue ID used for submission
>    * @job_id:              Unique job ID for tracking and status reporting
> @@ -61,6 +64,7 @@ struct ivpu_job {
>   	struct ivpu_device *vdev;
>   	struct ivpu_file_priv *file_priv;
>   	struct dma_fence *done_fence;
> +	struct llist_node destroy_node;
>   	u64 cmd_buf_vpu_addr;
>   	u32 cmdq_id;
>   	u32 job_id;
> @@ -87,6 +91,7 @@ void ivpu_job_done_consumer_init(struct ivpu_device *vdev);
>   void ivpu_job_done_consumer_fini(struct ivpu_device *vdev);
>   bool ivpu_job_handle_engine_error(struct ivpu_device *vdev, u32 job_id, u32 job_status);
>   void ivpu_context_abort_work_fn(struct work_struct *work);
> +void ivpu_job_destroy_work_fn(struct work_struct *work);
>   
>   void ivpu_jobs_abort_all(struct ivpu_device *vdev);
>   
Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
