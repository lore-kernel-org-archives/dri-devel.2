Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023E6C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591AC10E3F7;
	Thu, 27 Aug 2026 13:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="koaATxDb";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6912910E3F7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 13:00:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1441E169E
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 06:00:48 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 968DF3F85F
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787835651; bh=g25jzuf+eqcO/IIS8eTk7Cr9RLtw+eho1T/tyqHvaUM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=koaATxDbptsIrh0bTYqNFQdxI5p0O1ZB2EYWT6FxnZZHvDIZMYwZuWkFRmGJ1jb2u
 aMsXhMT58pR7KovLHWTKHWXtegdlxRlNAQMIaVM6aJq05Wt4k+iX2EaQzH4kAKZ5Bp
 WtjkllzxDh5ysB4q0tdVMYr2rbGJvwSmagvkSUKs=
Date: Thu, 27 Aug 2026 14:00:42 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/18] drm/panthor: Disable reset work before unplug
Message-ID: <apA0-ph6OBxUp6CW@e142607>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-1-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-1-982cc8f4234b@collabora.com>
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

On Wed, Aug 26, 2026 at 04:56:00PM +0200, Boris Brezillon wrote:
> Unplug is supposed to be the end of the road, so we need to make sure
> reset works won't execute while we're cleaning up everything as part
> of the unplug, otherwise it would mess up the internal state.
> 
> In order to be able to call disable_work_sync() in the unplug
> path, we need to defer the unplug triggered by the reset logic,
> otherwise we would deadlock.
> 
> Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 21 ++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_device.h |  3 +++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 0b25abebb803..7c55d0c45cfd 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -79,6 +79,9 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  		return;
>  	}
>  
> +	/* Make sure we're not interrupted by resets while we're unplugging. */
> +	disable_work_sync(&ptdev->reset.work);
> +
>  	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
>  
>  	/* Call drm_dev_unplug() so any access to HW blocks happening after
> @@ -91,6 +94,13 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	 */
>  	mutex_unlock(&ptdev->unplug.lock);
>  
> +	/* Unplug triggered by a device removal might race with the deferred
> +	 * one queued by the reset work. The function covers this concurrent
> +	 * unplug situation, but if we can disable the work before its
> +	 * execution, that's still better.
> +	 */
> +	disable_work(&ptdev->unplug.work);
> +

That's being super cautious and I'm not convinced it is necessary. Anything
queued at this moment should end up waiting for unplug.done.

With the above call removed, I'm OK with the rest of the patch.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


>  	/* Now, try to cleanly shutdown the GPU before the device resources
>  	 * get reclaimed.
>  	 */
> @@ -114,6 +124,13 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	complete_all(&ptdev->unplug.done);
>  }
>  
> +static void panthor_device_unplug_work(struct work_struct *work)
> +{
> +	struct panthor_device *ptdev = container_of(work, struct panthor_device, unplug.work);
> +
> +	panthor_device_unplug(ptdev);
> +}
> +
>  static void panthor_device_reset_cleanup(struct drm_device *ddev, void *data)
>  {
>  	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
> @@ -148,8 +165,9 @@ static void panthor_device_reset_work(struct work_struct *work)
>  	drm_dev_exit(cookie);
>  
>  	if (ret) {
> -		panthor_device_unplug(ptdev);
> +		disable_work(&ptdev->reset.work);
>  		drm_err(&ptdev->base, "Failed to boot MCU after reset, making device unusable.");
> +		queue_work(ptdev->reset.wq, &ptdev->unplug.work);
>  	}
>  }
>  
> @@ -206,6 +224,7 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	 */
>  	*dummy_page_virt = 1;
>  
> +	INIT_WORK(&ptdev->unplug.work, panthor_device_unplug_work);
>  	INIT_WORK(&ptdev->reset.work, panthor_device_reset_work);
>  	disable_work(&ptdev->reset.work);
>  	ptdev->reset.wq = alloc_ordered_workqueue("panthor-reset-wq", 0);
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index b55a3f9edd41..6529e01e838d 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -268,6 +268,9 @@ struct panthor_device {
>  		 * operation is done.
>  		 */
>  		struct completion done;
> +
> +		/** @work: Unplug work. */
> +		struct work_struct work;
>  	} unplug;
>  
>  	/** @reset: Reset related fields. */
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
