Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A77CD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 14:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AA910E1D4;
	Fri,  1 May 2026 14:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Zld5nRtd";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8E44710E1D4
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 14:57:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90C1A2C1C;
 Fri,  1 May 2026 07:57:33 -0700 (PDT)
Received: from [10.1.29.19] (e122027.cambridge.arm.com [10.1.29.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E09FC3F7B4;
 Fri,  1 May 2026 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777647459; bh=JiK0saQFsgDy0K0KD5X8al8tkehFg36i3uTn714fvJY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Zld5nRtd3RKpkQHgY4HxJt+lZSzYs/uFgxQA0R9WcHG+Kp8ndNe4sHzjoYaLLcvOo
 To2fpoz+wWSwdnAtnf69yIOhljZccGGBPPHvEkafd1F33aqSB8xiLCZCWNRaOv26dm
 aJV+I6C+UQp6KC+dh5JTLsFvk4xc+gJUUYZGtHvA=
Message-ID: <c6560418-fc24-4f8f-9b46-fd34d8d72b5a@arm.com>
Date: Fri, 1 May 2026 15:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] drm/panthor: Introduce interrupt coalescing support
 for job IRQs
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-10-4b92ae4142d2@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260429-panthor-signal-from-irq-v1-10-4b92ae4142d2@collabora.com>
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
> Dealing with interrupts from the raw IRQ handler is good for latency,
> but might be detrimental for the overall throughput, because the system
> keeps being interrupted to process job interrupts.
> 
> Try to mitigate that with some interrupt coalescing infrastructure,
> where we wake up the IRQ thread if close enough interrupts gets
> detected.
> 
> It's still experimental, which explains why the feature is off by
> default, and can be enabled through a debugfs knob.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

I think we need some more serious benchmarking to decide whether this is
a good idea. We've experimented with coalescing interrupts in the past
and it generally regressed some important benchmark of the day. But I'm
not in the loop of "benchmark of the day" any more (although I do know
that glmark hasn't been for years...) so it might have changed. From
what I hear AI workloads "benefit"[1] from spinning a CPU waiting for
jobs to finish.

[1] AI workloads don't tend to care so much about power... at least from
the CPU.

One typo I spotted below. And I'm not awfully keen on the debugfs
interface (but for testing it's obviously fine).

> ---
>  drivers/gpu/drm/panthor/panthor_device.h |  83 +++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_drv.c    |   1 +
>  drivers/gpu/drm/panthor/panthor_fw.c     | 150 +++++++++++++++++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_fw.h     |   2 +
>  4 files changed, 231 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 1c130b8394ab..e90f251f75e2 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -109,6 +109,48 @@ struct panthor_irq {
>  	enum panthor_irq_state state;
>  };
>  
> +/**
> + * struct panthor_irq_coalescing - IRQ coalescing info
> + */
> +struct panthor_irq_coalescing {
> +	/**
> +	 * @max_us: Maximum time in microseconds between two consecutive
> +	 * interrupts to consider coalescing.
> +	 *
> +	 * It being a u16 means we can't encode more than 65-ish msecs, but
> +	 * if we have to poll status for more than a few hundreds usecs it's
> +	 * going to make the IRQ thread consume more CPU than we want.
> +	 */
> +	u16 max_us;
> +
> +	/**
> +	 * @poll_perios_us: Rate at which status polling happens.

NIT: Typo: s/perios/period/

Thanks,
Steve

> +	 *
> +	 * It being a u16 means we can't encode more than 65-ish msecs, but
> +	 * if we have to delay each status check by more than a few usecs
> +	 * it's going to add latency we don't want.
> +	 */
> +	u16 poll_period_us;
> +
> +	/**
> +	 * @inbounds_cnt_threshold: Minimum of consecutive interrupts with no
> +	 * more than max_us between them to wake up the thread handler.
> +	 */
> +	u16 inbounds_cnt_threshold;
> +
> +	/**
> +	 * @inbounds_cnt: Current number of consecutive interrupts with no more
> +	 * than max_us between.
> +	 */
> +	u16 inbounds_cnt;
> +
> +	/** @coalesced_cnt: Total number of interrupts coalesced. */
> +	u64 coalesced_cnt;
> +
> +	/** @last_ts: Timestamp of the last IRQ. */
> +	ktime_t last_ts;
> +};
> +
>  /**
>   * enum panthor_device_profiling_mode - Profiling state
>   */
> @@ -571,6 +613,47 @@ static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
>  #define INT_MASK    0x8
>  #define INT_STAT    0xc
>  
> +static inline bool
> +panthor_irq_coalescing_wake_thread(struct panthor_irq_coalescing *coalescing)
> +{
> +	ktime_t ts;
> +	s64 diff_ns;
> +
> +	if (!coalescing->inbounds_cnt_threshold)
> +		return false;
> +
> +	ts = ktime_get();
> +	diff_ns = ktime_to_ns(ktime_sub(ts, coalescing->last_ts));
> +	if (diff_ns > coalescing->max_us * 1000) {
> +		coalescing->inbounds_cnt = 1;
> +		return false;
> +	}
> +
> +	if (coalescing->inbounds_cnt < U16_MAX)
> +		coalescing->inbounds_cnt++;
> +
> +	return coalescing->inbounds_cnt >= coalescing->inbounds_cnt_threshold;
> +}
> +
> +static inline void
> +panthor_irq_coalescing_update_ts(struct panthor_irq_coalescing *coalescing)
> +{
> +	if (coalescing->inbounds_cnt_threshold)
> +		coalescing->last_ts = ktime_get();
> +}
> +
> +static inline void
> +panthor_irq_coalescing_init(struct panthor_irq_coalescing *coalescing,
> +			     u16 max_us, u16 poll_period_us, u16 inbounds_cnt_threshold)
> +{
> +	coalescing->inbounds_cnt = 0;
> +	coalescing->coalesced_cnt = 0;
> +	coalescing->max_us = max_us;
> +	coalescing->poll_period_us = poll_period_us;
> +	coalescing->inbounds_cnt_threshold = inbounds_cnt_threshold;
> +	coalescing->last_ts = ktime_set(0, 0);
> +}
> +
>  static inline irqreturn_t panthor_irq_default_raw_handler(int irq, void *data)
>  {
>  	struct panthor_irq *pirq = data;
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 66996c9147c2..2fac5ba57f9d 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1760,6 +1760,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>  {
>  	panthor_mmu_debugfs_init(minor);
>  	panthor_gem_debugfs_init(minor);
> +	panthor_fw_debugfs_init(minor);
>  }
>  #endif
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 05c632913359..cbb7d00f0e6e 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -6,6 +6,7 @@
>  #endif
>  
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/firmware.h>
>  #include <linux/iopoll.h>
> @@ -15,6 +16,7 @@
>  #include <linux/pm_runtime.h>
>  
>  #include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_print.h>
>  
> @@ -271,6 +273,9 @@ struct panthor_fw {
>  
>  	/** @irq: Job irq data. */
>  	struct panthor_irq irq;
> +
> +	/** @irq_coalescing: Job IRQ coalescing. */
> +	struct panthor_irq_coalescing irq_coalescing;
>  };
>  
>  struct panthor_vm *panthor_fw_vm(struct panthor_device *ptdev)
> @@ -1090,6 +1095,8 @@ static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
>  static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
>  {
>  	struct panthor_irq *pirq = data;
> +	struct panthor_device *ptdev = pirq->ptdev;
> +	irqreturn_t ret = IRQ_HANDLED;
>  
>  	if (!gpu_read(pirq->iomem, INT_STAT))
>  		return IRQ_NONE;
> @@ -1101,6 +1108,9 @@ static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
>  		pirq->state = PANTHOR_IRQ_STATE_PROCESSING;
>  	}
>  
> +	if (panthor_irq_coalescing_wake_thread(&ptdev->fw->irq_coalescing))
> +		ret = IRQ_WAKE_THREAD;
> +
>  	panthor_job_irq_handler(pirq, gpu_read(pirq->iomem, INT_RAWSTAT));
>  
>  	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> @@ -1108,17 +1118,58 @@ static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
>  			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
>  	}
>  
> -	return IRQ_HANDLED;
> +	panthor_irq_coalescing_update_ts(&ptdev->fw->irq_coalescing);
> +	return ret;
>  }
>  
>  static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
>  {
>  	struct panthor_irq *pirq = data;
> +	struct panthor_device *ptdev = pirq->ptdev;
> +	irqreturn_t ret = IRQ_NONE;
> +	u32 processed_count = 0;
>  
> -	/* We never return IRQ_WAKE_THREAD, so we're not supposed to be called. */
> -	drm_WARN_ON_ONCE(&pirq->ptdev->base,
> -			 "threaded IRQ handler should never be called.");
> -	return IRQ_NONE;
> +	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> +		if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)
> +			return IRQ_NONE;
> +
> +		gpu_write(pirq->iomem, INT_MASK, 0);
> +		pirq->state = PANTHOR_IRQ_STATE_PROCESSING;
> +	}
> +
> +	while (true) {
> +		u32 status;
> +
> +		/* It's safe to access pirq->mask without the lock held here. If a new
> +		 * event gets added to the mask and the corresponding IRQ is pending,
> +		 * we'll process it right away instead of adding an extra raw -> threaded
> +		 * round trip. If an event is removed and the status bit is set, it will
> +		 * be ignored, just like it would have been if the mask had been adjusted
> +		 * right before the HW event kicks in. TLDR; it's all expected races we're
> +		 * covered for.
> +		 */
> +		if (readl_poll_timeout_atomic(pirq->iomem + INT_RAWSTAT,
> +					      status, status & pirq->mask,
> +					      ptdev->fw->irq_coalescing.poll_period_us,
> +					      ptdev->fw->irq_coalescing.max_us))
> +			break;
> +
> +		panthor_job_irq_handler(pirq, status);
> +		ret = IRQ_HANDLED;
> +		processed_count++;
> +	}
> +
> +	if (processed_count > 1)
> +		ptdev->fw->irq_coalescing.coalesced_cnt += processed_count - 1;
> +
> +	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> +		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING) {
> +			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
> +			gpu_write(pirq->iomem, INT_MASK, pirq->mask);
> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  static int panthor_fw_start(struct panthor_device *ptdev)
> @@ -1516,6 +1567,11 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	if (irq <= 0)
>  		return -ENODEV;
>  
> +	/* Start with IRQ coalescing disabled, until we have enough proof it's
> +	 * useful and doesn't have a too big CPU overhead. Those parameters can
> +	 * be tweaked with the debugfs knobs.
> +	 */
> +	panthor_irq_coalescing_init(&fw->irq_coalescing, 0, 0, 0);
>  	ret = panthor_irq_request(ptdev, &fw->irq, irq, 0,
>  				  ptdev->iomem + JOB_INT_BASE, "job",
>  				  panthor_job_irq_raw_handler,
> @@ -1563,6 +1619,90 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	return ret;
>  }
>  
> +static ssize_t job_irq_coalescing_props_read(struct file *file,
> +					     char __user *ubuf,
> +					     size_t ubuf_size,
> +					     loff_t *ppos)
> +{
> +	struct panthor_device *ptdev = container_of(file->private_data,
> +						    struct panthor_device, base);
> +	char kbuf[256] = {};
> +	int kbuf_size;
> +
> +	kbuf_size = snprintf(kbuf, sizeof(kbuf) - 1,
> +			     "max_us=%u poll_period_us=%u inbounds_cnt_threshold=%u\n",
> +			     ptdev->fw->irq_coalescing.max_us,
> +			     ptdev->fw->irq_coalescing.poll_period_us,
> +			     ptdev->fw->irq_coalescing.inbounds_cnt_threshold);
> +	if (kbuf_size > sizeof(kbuf) - 1)
> +		kbuf_size = sizeof(kbuf) - 1;
> +
> +	return simple_read_from_buffer(ubuf, ubuf_size, ppos, kbuf, kbuf_size);
> +}
> +
> +static ssize_t job_irq_coalescing_props_write(struct file *file,
> +					      const char __user *ubuf,
> +					      size_t ubuf_size, loff_t *ppos)
> +{
> +	struct panthor_device *ptdev = container_of(file->private_data,
> +						    struct panthor_device, base);
> +	unsigned int max_us = 0, poll_period_us = 0, inbounds_cnt_threshold = 0;
> +	char kbuf[256] = {};
> +	int ret;
> +
> +	simple_write_to_buffer(kbuf, sizeof(kbuf) - 1, ppos, ubuf, ubuf_size);
> +	ret = sscanf(kbuf,
> +		     "max_us=%u poll_period_us=%u inbounds_cnt_threshold=%u",
> +		     &max_us, &poll_period_us, &inbounds_cnt_threshold);
> +	if (ret != 3)
> +		return -EINVAL;
> +
> +	if (max_us > U16_MAX || poll_period_us > U16_MAX || inbounds_cnt_threshold > U16_MAX)
> +		return -EINVAL;
> +
> +	panthor_irq_coalescing_init(&ptdev->fw->irq_coalescing, max_us,
> +				    poll_period_us, inbounds_cnt_threshold);
> +	return ubuf_size;
> +}
> +
> +static const struct debugfs_short_fops job_irq_coalescing_props_fops = {
> +	.read = job_irq_coalescing_props_read,
> +	.write = job_irq_coalescing_props_write,
> +};
> +
> +static ssize_t job_irq_coalescing_stats_read(struct file *file,
> +					     char __user *ubuf,
> +					     size_t ubuf_size,
> +					     loff_t *ppos)
> +{
> +	struct panthor_device *ptdev = container_of(file->private_data,
> +						    struct panthor_device, base);
> +	char kbuf[256] = {};
> +	int kbuf_size;
> +
> +	kbuf_size = snprintf(kbuf, sizeof(kbuf) - 1,
> +			     "inbounds_cnt=%u coalesced_cnt=%llu last_ts=%llu\n",
> +			     ptdev->fw->irq_coalescing.inbounds_cnt,
> +			     ptdev->fw->irq_coalescing.coalesced_cnt,
> +			     ktime_to_ns(ptdev->fw->irq_coalescing.last_ts));
> +	if (kbuf_size > sizeof(kbuf) - 1)
> +		kbuf_size = sizeof(kbuf) - 1;
> +
> +	return simple_read_from_buffer(ubuf, ubuf_size, ppos, kbuf, kbuf_size);
> +}
> +
> +static const struct debugfs_short_fops job_irq_coalescing_stats_fops = {
> +	.read = job_irq_coalescing_stats_read,
> +};
> +
> +void panthor_fw_debugfs_init(struct drm_minor *minor)
> +{
> +	debugfs_create_file("job_irq_coalescing_props", 0600, minor->debugfs_root,
> +			    minor->dev, &job_irq_coalescing_props_fops);
> +	debugfs_create_file("job_irq_coalescing_stats", 0400, minor->debugfs_root,
> +			    minor->dev, &job_irq_coalescing_stats_fops);
> +}
> +
>  MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index e56b7fe15bb3..2643bd9e4ef9 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -526,4 +526,6 @@ static inline int panthor_fw_resume(struct panthor_device *ptdev)
>  int panthor_fw_init(struct panthor_device *ptdev);
>  void panthor_fw_unplug(struct panthor_device *ptdev);
>  
> +void panthor_fw_debugfs_init(struct drm_minor *minor);
> +
>  #endif
> 

