Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70513C61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0E710E970;
	Thu, 27 Aug 2026 15:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RKMvXz55";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5804D10E970
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 15:14:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01E6614BF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:14:45 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 9AE4B3F66F
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787843688; bh=De9uxGFkIbvDpbdmV2B0CYxzNS1ilgoGnNj17FYNTcI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RKMvXz55mwMRvqt8V1PyieO2CKrDScM9oi5IKjkgJtGlMQOiCzly4hqCKHZPLRxIl
 +3beL+Nsw/LmpCBJRkND+gBMMA8mRfE53HPHGFzND5ZycsUYcWe/c9r1eQe9x3wiz8
 1t5bm1EGB4ILWJ5zGfzcrXWwv+HdZpvNYtgXMAMM=
Date: Thu, 27 Aug 2026 16:14:39 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/18] drm/panthor: Flush the cleanup_wq in the unplug
 path
Message-ID: <apBUXw3vjSpy9IyA@e142607>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-4-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-4-982cc8f4234b@collabora.com>
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

On Wed, Aug 26, 2026 at 04:56:03PM +0200, Boris Brezillon wrote:
> If we don't do that, we might face various UAFs, because the resource
> referenced by these work items might be gone by the time they get
> executed.
> 
> In each subcomponent making use of the panthor_cleanup_wq, we add a
> flush_workqueue() at the end of the _unplug() function. Note that this
> assumes no more work items from this subcomponent gets queued after
> that point, which is not yet guaranteed, but this will be fixed in
> upcoming changes.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=2
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c   | 6 ++++++
>  drivers/gpu/drm/panthor/panthor_sched.c | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d43ba1c7cd2a..1385ee28bee5 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -3367,6 +3367,12 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
>  		}
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
> +
> +	/* Ensure any pending job cleanup work are executed before returning,
> +	 * otherwise those might access objects that are gone if the work is
> +	 * executed after other components are unplugged.
> +	 */
> +	flush_workqueue(panthor_cleanup_wq);
>  }
>  
>  static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 42adfc76b9e1..a6d57dc1b43e 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -4049,6 +4049,12 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
>  		sched->pm.has_ref = false;
>  	}
>  	mutex_unlock(&sched->lock);
> +
> +	/* Ensure any pending group release work are executed before returning,
> +	 * otherwise those might access objects that are gone if the work is
> +	 * executed after other components are unplugged.
> +	 */
> +	flush_workqueue(panthor_cleanup_wq);
>  }
>  
>  static void panthor_sched_fini(struct drm_device *ddev, void *res)
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
