Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82A9C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0069410E75C;
	Fri, 11 Sep 2026 22:45:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="cb+cJpXX";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C7410E75C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789166700; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TVmJwjDXKu7XvDQkCtHz5fSEMl+M6y1FQbkax5ITK0tt20oUzdhHsuvVwUMUhIwulziitRVkM+7ZFOWKN2srVq4TLnx4EEs8mRNObIOTxfUgEmFZv1dSa81qx2wiR/Hlrro2/JhSnEw9XV4SfDd6i4dA1W6Hl82MEPW1CabYjw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789166700;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QdS5qyMI92g3N45bro12eNhZdejtndrhxZwLiharhI4=; 
 b=TV6o0wP4k2t6ya+uMNQx0kM75Qwq8TiWGF6qFfcAjvsSJ+05bKLXlc0T0QLzbhWS/pOAUJgzkJ56iq2Y0Hhlc7sgm59PiVCdnT4xk366trwYJWwP5NtY6/glkQRwZGzg0Q8rZqAXO+rgPQg7rFhiNGMWPQ6fu64qZ4BzmUqEH+Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789166700; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=QdS5qyMI92g3N45bro12eNhZdejtndrhxZwLiharhI4=;
 b=cb+cJpXXCghOh8kjYVqdB8QN38c+UUS40KLVu7bxDDZn+2Gu0UlY/wzI7Netc5wx
 O3wxLQfTMdbJ9LF5sBcRnhteoxTEzihZ9Ua4+A+36TTbPrFWVqLd4LMrD9pnPsspaza
 nmRhIWyVkR+gtIlC3a+VUT/GXPaUYVEg2C7Jbqlw=
Received: by mx.zohomail.com with SMTPS id 1789166699437560.81300959032;
 Fri, 11 Sep 2026 15:44:59 -0700 (PDT)
Date: Fri, 11 Sep 2026 23:44:55 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/18] drm/panthor: Fix the unplug logic
Message-ID: <aqRXJMCsiu3DC0_S@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-17-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826-panthor-unplug-fixes-v4-17-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.144.59
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

On 26.08.2026 16:56, Boris Brezillon wrote:
> The current unplug logic is broken in multiple subtle ways:
> 
> 1. it assumes that the HW is still accessible in multiple places,
>    which goes against the very concept of hot-unplug
> 2. it doesn't take into account the fact the stop is a failible

On a related note, this made me wonder whether it's the same in Panfrost.
It seems panfrost_gpu_power_off() can fail, leaving the GPU running after
the driver has been removed.

>    operation, and that we theoretically have no guarantee that the HW
>    is actually stopped after we've released the resources
> 
> Those issues are hard to reason about because Mali GPUs are on a
> platform bus, which is not hot-pluggable, so they are in practice
> always accessible as long as we can enable their dependencies (clocks,
> power-domain, ...). The problem is, if the GPU is in such a bad state
> it can't properly reset/resume, there are various operations that can't
> be done properly, and the unplug logic is clearly not ready for that.
> And more importantly, if we can't guarantee the reset was effective,
> we have to assume the HW still has access to the resource we passed to
> it, meaning we can't return these resources to the system without
> risking a UAF.
> 
> This patch does several things:
> 
> - it resets the GPU before calling the <component>_unplug() functions
> - it drops the pm_get/put that around the sub-component unplug calls
                           Nit: remove 'that'?                                

>   (no longer needed if we assume the HW is gone and can't be accessed
>   anymore)
> - it changes the _unplug() implementations to not touch the HW anymore
> - it let's each component know whether it should leak resources the HW
      Nit: lets
>   might have its hands on at the time the unplug happens
> - it releases all resources at unplug time even if open FDs exist. This
>   is needed otherwise we could have deferred cleanup work accessing
>   objects that have been freed
> 
> Unfortunately, I couldn't find a way to break things into multiple
> commits while preserving bisectability.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  50 +++++++++----
>  drivers/gpu/drm/panthor/panthor_drv.c    | 122 ++++++++++++++++++++++++-------
>  drivers/gpu/drm/panthor/panthor_fw.c     |   9 +--
>  drivers/gpu/drm/panthor/panthor_gpu.c    |   2 +-
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  72 +++++++++++-------
>  drivers/gpu/drm/panthor/panthor_pwr.c    |   2 +-
>  drivers/gpu/drm/panthor/panthor_sched.c  |  90 +++++++++++++++++++++--
>  7 files changed, 267 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 817312f598f3..328e601d80e8 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -83,13 +83,28 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	/* Make sure we're not interrupted by resets while we're unplugging. */
>  	disable_work_sync(&ptdev->reset.work);
>  
> -	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
> +	/* Disable RPM callbacks early, so we're sure external RPM calls won't
> +	 * interfere with our unplug logic.
> +	 */
> +	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
> +	pm_runtime_disable(ptdev->base.dev);

If a sysfs or debugfs knob was executing at the time device_unplug() kicks in, and they had
taken a PM reference, wouldn't the previous statement mean when they try to release that
reference they wouldn't be able to? And maybe leave the RPM reference count unbalanced.

>  	/* Call drm_dev_unplug() so any access to HW blocks happening after
>  	 * that point get rejected.
>  	 */
>  	drm_dev_unplug(&ptdev->base);
>  
> +	/* If the device is suspended we know for sure the device is idle and
> +	 * we can proceed with the rest of the unplug without issuing a
> +	 * SOFT_RESET.
> +	 */
> +	if (!pm_runtime_status_suspended(ptdev->base.dev)) {
> +		/* A soft-reset should guarantee that all components of the HW
> +		 * are off, meaning we can proceed with the rest of the unplug.
> +		 */
> +		panthor_hw_soft_reset(ptdev);
> +	}
> +
>  	/* We do the rest of the unplug with the unplug lock released,
>  	 * future callers will wait on ptdev->unplug.done anyway.
>  	 */
> @@ -112,13 +127,21 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	panthor_gpu_unplug(ptdev);
>  	panthor_pwr_unplug(ptdev);
>  
> -	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
> -	pm_runtime_put_sync_suspend(ptdev->base.dev);
> -
> -	/* If PM is disabled, we need to call the suspend handler manually. */
> -	if (!IS_ENABLED(CONFIG_PM))
> +	/* If the device is not suspended, suspend it now. Note that it covers
> +	 * the !CONFIG_PM case because pm_runtime_status_suspended() always
> +	 * returns false in that case.
> +	 */
> +	if (!pm_runtime_status_suspended(ptdev->base.dev)) {
> +		/* RPM callbacks were disabled at the beginning of this function,
> +		 * so we need to call the suspend hook manually to return the
> +		 * clks/regulators refs we still own.
> +		 */
>  		panthor_device_suspend(ptdev->base.dev);
>  
> +		/* Make sure the device is considered suspended by the PM core. */
> +		pm_runtime_set_suspended(ptdev->base.dev);
> +	}
> +
>  	/* Report the unplug operation as done to unblock concurrent
>  	 * panthor_device_unplug() callers.
>  	 */
> @@ -280,13 +303,6 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	 * will vanish.
>  	 */
>  	disable_work(&ptdev->reset.work);
> -	ret = devm_pm_runtime_enable(ptdev->base.dev);
> -	if (ret)
> -		return ret;
> -
> -	ret = pm_runtime_resume_and_get(ptdev->base.dev);
> -	if (ret)
> -		return ret;
>  
>  	/* If PM is disabled, we need to call panthor_device_resume() manually. */
>  	if (!IS_ENABLED(CONFIG_PM)) {
> @@ -295,6 +311,11 @@ int panthor_device_init(struct panthor_device *ptdev)
>  			return ret;
>  	}
>  
> +	pm_runtime_enable(ptdev->base.dev);
> +	ret = pm_runtime_resume_and_get(ptdev->base.dev);
> +	if (ret)
> +		goto err_rpm_disable;
> +
>  	ret = panthor_hw_init(ptdev);
>  	if (ret)
>  		goto err_rpm_put;
> @@ -364,6 +385,9 @@ int panthor_device_init(struct panthor_device *ptdev)
>  
>  err_rpm_put:
>  	pm_runtime_put_sync_suspend(ptdev->base.dev);
> +
> +err_rpm_disable:
> +	pm_runtime_disable(ptdev->base.dev);
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 3993e1a81495..f34050aae3fe 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1025,11 +1025,21 @@ static int panthor_ioctl_vm_destroy(struct drm_device *ddev, void *data,
>  {
>  	struct panthor_file *pfile = file->driver_priv;
>  	struct drm_panthor_vm_destroy *args = data;
> +	int cookie, ret;
>  
> -	if (args->pad)
> -		return -EINVAL;
> +	if (!drm_dev_enter(ddev, &cookie))
> +		return -ENODEV;
>  
> -	return panthor_vm_pool_destroy_vm(pfile->vms, args->id);
> +	if (args->pad) {
> +		ret = -EINVAL;
> +		goto out_dev_exit;
> +	}
> +
> +	ret = panthor_vm_pool_destroy_vm(pfile->vms, args->id);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
> +	return ret;
>  }
>  
>  #define PANTHOR_BO_FLAGS		(DRM_PANTHOR_BO_NO_MMAP | \
> @@ -1219,11 +1229,21 @@ static int panthor_ioctl_group_destroy(struct drm_device *ddev, void *data,
>  {
>  	struct panthor_file *pfile = file->driver_priv;
>  	struct drm_panthor_group_destroy *args = data;
> +	int cookie, ret;
>  
> -	if (args->pad)
> -		return -EINVAL;
> +	if (!drm_dev_enter(ddev, &cookie))
> +		return -ENODEV;
>  
> -	return panthor_group_destroy(pfile, args->group_handle);
> +	if (args->pad) {
> +		ret = -EINVAL;
> +		goto out_dev_exit;
> +	}
> +
> +	ret = panthor_group_destroy(pfile, args->group_handle);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
> +	return ret;
>  }
>  
>  static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
> @@ -1232,27 +1252,36 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
>  	struct panthor_file *pfile = file->driver_priv;
>  	struct drm_panthor_group_create *args = data;
>  	struct drm_panthor_queue_create *queue_args;
> -	int ret;
> +	int cookie, ret;
>  
> -	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
> -		return -EINVAL;
> +	if (!drm_dev_enter(ddev, &cookie))
> +		return -ENODEV;
> +
> +	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG) {
> +		ret = -EINVAL;
> +		goto out_dev_exit;
> +	}
>  
>  	ret = PANTHOR_UOBJ_GET_ARRAY(queue_args, &args->queues);
>  	if (ret)
> -		return ret;
> +		goto out_dev_exit;
>  
>  	ret = group_priority_permit(file, args->priority);
>  	if (ret)
> -		goto out;
> +		goto out_free_args;
>  
>  	ret = panthor_group_create(pfile, args, queue_args, file->client_id);
>  	if (ret < 0)
> -		goto out;
> +		goto out_free_args;
> +
>  	args->group_handle = ret;
>  	ret = 0;
>  
> -out:
> +out_free_args:
>  	kvfree(queue_args);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
>  	return ret;
>  }
>  
> @@ -1261,8 +1290,15 @@ static int panthor_ioctl_group_get_state(struct drm_device *ddev, void *data,
>  {
>  	struct panthor_file *pfile = file->driver_priv;
>  	struct drm_panthor_group_get_state *args = data;
> +	int cookie, ret;
>  
> -	return panthor_group_get_state(pfile, args);
> +	if (!drm_dev_enter(ddev, &cookie))
> +		return -ENODEV;
> +
> +	ret = panthor_group_get_state(pfile, args);
> +
> +	drm_dev_exit(cookie);
> +	return ret;
>  }
>  
>  static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
> @@ -1272,11 +1308,16 @@ static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
>  	struct drm_panthor_tiler_heap_create *args = data;
>  	struct panthor_heap_pool *pool;
>  	struct panthor_vm *vm;
> -	int ret;
> +	int cookie, ret;
> +
> +	if (!drm_dev_enter(ddev, &cookie))
> +		return -ENODEV;
>  
>  	vm = panthor_vm_pool_get_vm(pfile->vms, args->vm_id);
> -	if (!vm)
> -		return -EINVAL;
> +	if (!vm) {
> +		ret = -EINVAL;
> +		goto out_dev_exit;
> +	}
>  
>  	pool = panthor_vm_get_heap_pool(vm, true);
>  	if (IS_ERR(pool)) {
> @@ -1305,6 +1346,9 @@ static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
>  
>  out_put_vm:
>  	panthor_vm_put(vm);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
>  	return ret;
>  }
>  
> @@ -1315,14 +1359,21 @@ static int panthor_ioctl_tiler_heap_destroy(struct drm_device *ddev, void *data,
>  	struct drm_panthor_tiler_heap_destroy *args = data;
>  	struct panthor_heap_pool *pool;
>  	struct panthor_vm *vm;
> -	int ret;
> +	int cookie, ret;
>  
> -	if (args->pad)
> -		return -EINVAL;
> +	if (!drm_dev_enter(ddev, &cookie))
> +		return -ENODEV;
> +
> +	if (args->pad) {
> +		ret = -EINVAL;
> +		goto out_dev_exit;
> +	}
>  
>  	vm = panthor_vm_pool_get_vm(pfile->vms, args->handle >> 16);
> -	if (!vm)
> -		return -EINVAL;
> +	if (!vm) {
> +		ret = -EINVAL;
> +		goto out_dev_exit;
> +	}
>  
>  	pool = panthor_vm_get_heap_pool(vm, false);
>  	if (IS_ERR(pool)) {
> @@ -1335,6 +1386,9 @@ static int panthor_ioctl_tiler_heap_destroy(struct drm_device *ddev, void *data,
>  
>  out_put_vm:
>  	panthor_vm_put(vm);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
>  	return ret;
>  }
>  
> @@ -1466,10 +1520,16 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
>  	struct panthor_file *pfile = file->driver_priv;
>  	struct drm_panthor_vm_get_state *args = data;
>  	struct panthor_vm *vm;
> +	int cookie, ret;
> +
> +	if (!drm_dev_enter(ddev, &cookie))
> +		return -ENODEV;
>  
>  	vm = panthor_vm_pool_get_vm(pfile->vms, args->vm_id);
> -	if (!vm)
> -		return -EINVAL;
> +	if (!vm) {
> +		ret = -EINVAL;
> +		goto out_dev_exit;
> +	}
>  
>  	if (panthor_vm_is_unusable(vm))
>  		args->state = DRM_PANTHOR_VM_STATE_UNUSABLE;
> @@ -1477,7 +1537,11 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
>  		args->state = DRM_PANTHOR_VM_STATE_USABLE;
>  
>  	panthor_vm_put(vm);
> -	return 0;
> +	ret = 0;
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
> +	return ret;
>  }
>  
>  static int panthor_ioctl_bo_set_label(struct drm_device *ddev, void *data,
> @@ -1730,9 +1794,13 @@ static void panthor_show_internal_memory_stats(struct drm_printer *p, struct drm
>  	char *drv_name = file->minor->dev->driver->name;
>  	struct panthor_file *pfile = file->driver_priv;
>  	struct drm_memory_stats stats = {0};
> +	int cookie;
>  
> -	panthor_fdinfo_gather_group_mem_info(pfile, &stats);
> -	panthor_vm_heaps_sizes(pfile, &stats);
> +	if (drm_dev_enter(&pfile->ptdev->base, &cookie)) {
> +		panthor_fdinfo_gather_group_mem_info(pfile, &stats);
> +		panthor_vm_heaps_sizes(pfile, &stats);
> +		drm_dev_exit(cookie);
> +	}
>  
>  	drm_fdinfo_print_size(p, drv_name, "resident", "memory", stats.resident);
>  	drm_fdinfo_print_size(p, drv_name, "active", "memory", stats.active);
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 731da736e372..aafe0a7daac1 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1290,11 +1290,9 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
>  
>  	disable_delayed_work_sync(&ptdev->fw->watchdog.ping_work);
>  
> -	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
> -		/* Make sure the IRQ handler cannot be called after that point. */
> +	/* Make sure the IRQ handler cannot be called after that point. */
> +	if (!pm_runtime_status_suspended(ptdev->base.dev))
>  		panthor_irq_suspend(&ptdev->fw->irq);
> -		panthor_fw_stop(ptdev);
> -	}
>  
>  	list_for_each_entry(section, &ptdev->fw->sections, node)
>  		panthor_kernel_bo_destroy(section->mem);
> @@ -1306,9 +1304,6 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
>  	 */
>  	panthor_vm_put(ptdev->fw->vm);
>  	ptdev->fw->vm = NULL;
> -
> -	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> -		drm_WARN_ON(&ptdev->base, panthor_hw_l2_power_off(ptdev));
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 09ebe0294691..1cd19a02d2f2 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -132,7 +132,7 @@ void panthor_gpu_unplug(struct panthor_device *ptdev)
>  	unsigned long flags;
>  
>  	/* Make sure the IRQ handler is not running after that point. */
> -	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> +	if (!pm_runtime_status_suspended(ptdev->base.dev))
>  		panthor_irq_suspend(&ptdev->gpu->irq);
>  
>  	/* Wake-up all waiters. */
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 6368bf57b8f5..429aa96d699f 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1799,17 +1799,27 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
>   */
>  void panthor_vm_pool_destroy(struct panthor_file *pfile)
>  {
> +	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_vm *vm;
>  	unsigned long i;
> +	int cookie;
>  
>  	if (!pfile->vms)
>  		return;
>  
> -	xa_for_each(&pfile->vms->xa, i, vm)
> -		panthor_vm_pool_destroy_vm(pfile->vms, i);
> +	/* If device is gone VMs have been destroyed already, and the XArray
> +	 * contains pointers to objects that have been freed.
> +	 */
> +	if (drm_dev_enter(&ptdev->base, &cookie)) {
> +		xa_for_each(&pfile->vms->xa, i, vm)
> +			panthor_vm_pool_destroy_vm(pfile->vms, i);
> +
> +		drm_dev_exit(cookie);
> +	}
>  
>  	if (pfile->vms->dummy)
>  		drm_gem_object_put(&pfile->vms->dummy->base);
> +
>  	xa_destroy(&pfile->vms->xa);
>  	kfree(pfile->vms);
>  }
> @@ -2243,6 +2253,11 @@ static bool vm_prep_for_cleanup(struct panthor_vm *vm)
>  	}
>  
>  	if (!drm_dev_enter(&ptdev->base, &cookie)) {
> +		/* Device is gone, take the unplug lock to make sure
> +		 * panthor_device_stop_before_unplug() has run and
> +		 * ::leak_active_resources is valid.
> +		 */

This looks like a holdover from a previous revision.

> +		guard(mutex)(&ptdev->unplug.lock);
>  		guard(mutex)(&ptdev->mmu->as.slots_lock);
>  
>  		/* If we're still on a slot after an unplug, it means
> @@ -3616,6 +3631,20 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  	return freed;
>  }
>  
> +static struct panthor_vm *
> +pop_user_owned_vm(struct panthor_device *ptdev)
> +{
> +	struct panthor_vm *vm;
> +
> +	guard(mutex)(&ptdev->mmu->vm.lock);
> +	vm = list_first_entry_or_null(&ptdev->mmu->vm.user_owned,
> +				      struct panthor_vm, user_node);
> +	if (vm)
> +		list_del_init(&vm->user_node);
> +
> +	return vm;
> +}
> +
>  /**
>   * panthor_mmu_unplug() - Unplug the MMU logic
>   * @ptdev: Device.
> @@ -3625,32 +3654,21 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>   */
>  void panthor_mmu_unplug(struct panthor_device *ptdev)
>  {
> -	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> -		panthor_irq_suspend(&ptdev->mmu->irq);
> -
> -	mutex_lock(&ptdev->mmu->as.slots_lock);
> -	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
> -		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
> -		int ret;
> -
> -		if (!as)
> -			continue;
> -
> -		ret = panthor_mmu_as_disable(ptdev, i, false);
> -		drm_WARN_ON(&ptdev->base, ret);
> -
> -		/* Drop the unmap restriction if the disabled worked, so we
> -		 * don't leak resources in the normal situation.
> -		 */
> -		if (!ret)
> -			atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
> -
> -		panthor_as_release_hw_slot_locked(as);
> +	/* Collect non-destroyed user VMs so we can return the ref owned by the
> +	 * XArray. If we don't do that, we leak all user VMs that were still
> +	 * alive at the point drm_dev_unplug() was called, because
> +	 * panthor_ioctl_vm_destroy() bails out early if the device is
> +	 * unplugged.
> +	 */
> +	for (struct panthor_vm *vm = pop_user_owned_vm(ptdev); vm;
> +	     vm = pop_user_owned_vm(ptdev)) {
> +		panthor_vm_destroy(vm);
>  	}
>  
> -	if (!list_empty(&ptdev->mmu->as.cleanup_list))
> -		queue_work(ptdev->cleanup_wq, &ptdev->mmu->vm.cleanup_work);
> -	mutex_unlock(&ptdev->mmu->as.slots_lock);
> +	if (!pm_runtime_status_suspended(ptdev->base.dev))
> +		panthor_irq_suspend(&ptdev->mmu->irq);
> +
> +	mmu_post_reset_cleanup(ptdev);
>  
>  	/* Make sure pending VM cleanups are processed before leaving. Those
>  	 * cleanups might schedule vm_bind_job cleanups, so keep this
> @@ -3658,6 +3676,8 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
>  	 */
>  	flush_work(&ptdev->mmu->vm.cleanup_work);
>  	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->as.cleanup_list));
> +	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->vm.list));
> +	drm_WARN_ON(&ptdev->base, !list_empty(&ptdev->mmu->vm.user_owned));

Here I understand that vm.user_owned must be empty by now, but vm's are only taken off
the vm.list at VM release time, either in vm_prep_for_cleanup() or when disabling its
HW AS fails and release is delayed until the next reset. So this assumes that for every
user facing VM that we destroy at the beginning of this function, its refcount was 1.
But I'm not sure when we've made it this far we're certain no more vmbind jobs are
targetting those VM's, all of which take VM reference.

>  	/* Ensure any pending job cleanup work are executed before returning,
>  	 * otherwise those might access objects that are gone if the work is
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index c81e2cc053db..49eb6ff47620 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -458,7 +458,7 @@ void panthor_pwr_unplug(struct panthor_device *ptdev)
>  		return;
>  
>  	/* Make sure the IRQ handler is not running after that point. */
> -	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> +	if (!pm_runtime_status_suspended(ptdev->base.dev))
>  		panthor_irq_suspend(&ptdev->pwr->irq);
>  
>  	/* Wake-up all waiters. */
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index bd5dcf4cb580..7d2815b4db0f 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2548,7 +2548,7 @@ static void tick_work(struct work_struct *work)
>  		return;
>  
>  	ret = panthor_device_resume_and_get(ptdev);
> -	if (drm_WARN_ON(&ptdev->base, ret))
> +	if (ret)

Why have we dropped the warning here?

>  		goto out_dev_exit;
>  
>  	/* If the tick is stopped, calculate when the next tick would be */
> @@ -3100,12 +3100,17 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
>  void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
>  {
>  	struct panthor_group_pool *gpool = pfile->groups;
> +	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_group *group;
>  	unsigned long i;
> +	int cookie;
>  
>  	if (IS_ERR_OR_NULL(gpool))
>  		return;
>  
> +	if (!drm_dev_enter(&ptdev->base, &cookie))
> +		return;
> +
>  	xa_lock(&gpool->xa);
>  	xa_for_each_marked(&gpool->xa, i, group, GROUP_REGISTERED) {
>  		guard(spinlock)(&group->fdinfo.lock);
> @@ -3115,6 +3120,8 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
>  		group->fdinfo.data.time = 0;
>  	}
>  	xa_unlock(&gpool->xa);
> +
> +	drm_dev_exit(cookie);
>  }
>  
>  struct panthor_job_ringbuf_instrs {
> @@ -3320,7 +3327,7 @@ queue_run_job(struct drm_sched_job *sched_job)
>  	}
>  
>  	ret = panthor_device_resume_and_get(ptdev);
> -	if (drm_WARN_ON(&ptdev->base, ret))
> +	if (ret)
>  		return ERR_PTR(ret);
>  
>  	mutex_lock(&sched->lock);
> @@ -3873,14 +3880,23 @@ int panthor_group_pool_create(struct panthor_file *pfile)
>  void panthor_group_pool_destroy(struct panthor_file *pfile)
>  {
>  	struct panthor_group_pool *gpool = pfile->groups;
> +	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_group *group;
>  	unsigned long i;
> +	int cookie;
>  
>  	if (IS_ERR_OR_NULL(gpool))
>  		return;
>  
> -	xa_for_each(&gpool->xa, i, group)
> -		panthor_group_destroy(pfile, i);
> +	/* If device is gone groups have been destroyed already, and the XArray
> +	 * contains pointers to objects that have been freed.
> +	 */

I find this a bit confusing, but probably because I don't fully understand how groups are made
to go away at unplug time. All I can see in panthor_sched_unplug() is that group references are
put, for bound groups, idle ones and then those owned by the user. However, do we know by this time
that there are no more group references taken by extant scheduler jobs at queue entities?

> +	if (drm_dev_enter(&ptdev->base, &cookie)) {
> +		xa_for_each(&gpool->xa, i, group)
> +			panthor_group_destroy(pfile, i);
> +
> +		drm_dev_exit(cookie);
> +	}
>  
>  	xa_destroy(&gpool->xa);
>  	kfree(gpool);
> @@ -3899,11 +3915,16 @@ panthor_fdinfo_gather_group_mem_info(struct panthor_file *pfile,
>  				     struct drm_memory_stats *stats)
>  {
>  	struct panthor_group_pool *gpool = pfile->groups;
> +	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_group *group;
>  	unsigned long i;
> +	int cookie;
> +
> +	if (!drm_dev_enter(&ptdev->base, &cookie))
> +		return;

Do we need drm_dev_enter() here when it's already been checked in the calling function?

>  	if (IS_ERR_OR_NULL(gpool))
> -		return;
> +		goto out_dev_exit;
>  
>  	xa_lock(&gpool->xa);
>  	xa_for_each_marked(&gpool->xa, i, group, GROUP_REGISTERED) {
> @@ -3912,6 +3933,9 @@ panthor_fdinfo_gather_group_mem_info(struct panthor_file *pfile,
>  			stats->active += group->fdinfo.kbo_sizes;
>  	}
>  	xa_unlock(&gpool->xa);
> +
> +out_dev_exit:
> +	drm_dev_exit(cookie);
>  }
>  
>  static void job_release(struct kref *ref)
> @@ -4057,22 +4081,78 @@ void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *sched
>  void panthor_sched_unplug(struct panthor_device *ptdev)
>  {
>  	struct panthor_scheduler *sched = ptdev->scheduler;
> +	struct panthor_group *group, *tmp_group;
> +	LIST_HEAD(groups);
>  
>  	disable_delayed_work_sync(&sched->tick_work);
>  	disable_work_sync(&sched->sync_upd_work);
>  
>  	mutex_lock(&sched->lock);
> +
> +	/* Do a pass on the on-slot groups, and schedule termination. */
> +	for (u32 i = 0; i < sched->csg_slot_count; i++) {
> +		struct panthor_csg_slot *csg_slot = &sched->csg_slots[i];
> +		struct panthor_group *group = csg_slot->group;
> +
> +		if (!group)
> +			continue;
> +
> +		group_get(group);
> +		group->state = PANTHOR_CS_GROUP_TERMINATED;
> +		group_unbind_locked(group);
> +		list_del_init(&group->wait_node);
> +		group_queue_work(group, term);
> +
> +		group_put(group);
> +	}
> +
> +	/* Now take care of the non-resident groups. */
> +	for (u32 i = 0; i < ARRAY_SIZE(sched->groups.runnable); i++)
> +		list_splice_init(&sched->groups.runnable[i], &groups);
> +
> +	for (u32 i = 0; i < ARRAY_SIZE(sched->groups.idle); i++)
> +		list_splice_init(&sched->groups.idle[i], &groups);
> +
> +	list_for_each_entry_safe(group, tmp_group, &groups, run_node) {
> +		list_del_init(&group->run_node);
> +		list_del_init(&group->wait_node);
> +		group_queue_work(group, term);
> +	}
> +
> +	/* All groups that still have a user handle need a group_put()
> +	 * because after drm_dev_unplug() has been called those handles
> +	 * can't be released through the GROUP_DESTROY IOCTL anymore.
> +	 */
> +	list_for_each_entry_safe(group, tmp_group, &sched->groups.user_owned, user_node) {
> +		list_del_init(&group->user_node);
> +		group_put(group);
> +	}
> +
>  	if (sched->pm.has_ref) {
>  		pm_runtime_put(ptdev->base.dev);
>  		sched->pm.has_ref = false;
>  	}
>  	mutex_unlock(&sched->lock);
>  
> +	/* Ensure all term work are done. */
> +	flush_workqueue(sched->wq);
> +
> +	/* Ensure all tiler OOM work are done. */
> +	flush_workqueue(sched->heap_alloc_wq);
> +
>  	/* Ensure any pending group release work are executed before returning,
>  	 * otherwise those might access objects that are gone if the work is
>  	 * executed after other components are unplugged.
>  	 */
>  	flush_workqueue(ptdev->cleanup_wq);
> +
> +	/* After we've flushed the workqueues, all lists should be empty. */
> +	drm_WARN_ON(&ptdev->base, !list_empty(&sched->groups.user_owned));
> +	for (u32 i = 0; i < ARRAY_SIZE(sched->groups.runnable); i++)
> +		drm_WARN_ON(&ptdev->base, !list_empty(&sched->groups.runnable[i]));
> +
> +	for (u32 i = 0; i < ARRAY_SIZE(sched->groups.idle); i++)
> +		drm_WARN_ON(&ptdev->base, !list_empty(&sched->groups.idle[i]));
>  }
>  
>  static void panthor_sched_fini(struct drm_device *ddev, void *res)
> 
> -- 
> 2.55.0


Adrian Larumbe
