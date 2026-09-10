Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE96DC79FB6
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A84310E22A;
	Thu, 10 Sep 2026 01:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="H7rx5XIm";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0910A10E22A
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789002786; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bejGOkFwk0gMKjPZLgIhBB81SmCmuuydU282fP+0rXGROgzV+W6Q4NFhvTgIGh0ovfSVCwTG2ugMdJJt/RFtt+Ieys3fuhcajLjmUj+duvslqkamWhNE/4JQTnJ+JjjJ6547RACov2g4bTS4RlCyujbJsF0h720a4dnm1iNyvA0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789002786;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=QEv3v0xnE9BespRyrtj0H9AtABtlOh89d2viTit7VeE=; 
 b=TkhHvXnxFgL3VTAWVxt3ZbQq8eAO9Y2zhynSZXAhr+zKdB/JGmTNNhGnSPHLxG5qb7ZwsLimJUOwjkXh+clSbQ3aT0txSwLWJcRsu47YdgyoPZl/BxJtgHc7jla67TrvZKaS2nt83L94HjVoTgGwU4XqjwBJ+bjOGrti9fAwcXk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789002786; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=QEv3v0xnE9BespRyrtj0H9AtABtlOh89d2viTit7VeE=;
 b=H7rx5XImoakEVEI5RxN3OsPjEHqnyHT0sf/3ucCiXRrJZT85h8iR/6sx3jSK4W6R
 2X68I+4a/KNcQ5Po/VKPJ4f8/vWBpAmhDw0dI+bzzbz3CLxYNDwc5JGHVPkK3mMSg0T
 SR8RYLxuJsFFCl9R8vRijSV4oN/7AR/WpK/3eLtg=
Received: by mx.zohomail.com with SMTPS id 1789002784299626.7674218763597;
 Wed, 9 Sep 2026 18:13:04 -0700 (PDT)
Date: Thu, 10 Sep 2026 02:12:58 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/18] drm/panthor: Disable reset work before unplug
Message-ID: <aqEiOy6Fe2NMu0Wo@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-1-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-1-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.982.46
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 26.08.2026 16:56, Boris Brezillon wrote:
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
 
Adrian Larumbe
