Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C33606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QsMRee4m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63BDF112B10;
	Fri, 27 Nov 2026 14:17:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B6C10E3ED;
 Fri, 27 Nov 2026 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795789047; x=1827325047;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=qt0CQ1SvtkAQ0LnetpX4R/T2bdeVCeqh/9sH90gW4l4=;
 b=QsMRee4mMiCuscRyifbjPlXETHJS+2UpXaLtyuBXy3M+dXg3V9EaokQq
 4NUP5kgm/hdBPJZV+UrUnjX31YnHqlwkyMdJjaxIjLY1ylupy7bzc32wJ
 3N1528LDm+FhiAPwVoj9bZJGzW6L3pKyvxANEClTHerBRneLm1XcgLi32
 QQjkBVON9OIc00z3zYzQj4UbKXPg3bfPqiH1xowLS36VUePtdRttcRh8k
 SBshFhVm5JLvLgYZq+NWIx9sqkZAF53NiIXjpcmPTpgDEjd1OkDELSlRL
 ibgU7nsltSVB9OBh7AY54btLr2C2HF3rKAeqfeW/PAvRP/ECv+4AbQQk3 Q==;
X-CSE-ConnectionGUID: DJx7PgZ4TembrydTj4u4HQ==
X-CSE-MsgGUID: sdQI5zj0QQOZkbMmOoZFmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4604288"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4604288"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 06:17:27 -0800
X-CSE-ConnectionGUID: tXncEY86Rx6WjJiuYy30Wg==
X-CSE-MsgGUID: YlaUFs3GTuiLUjwF5ADF7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12430993"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.90])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 06:17:23 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Bin Luo (University of Electronic Science and Technology of China)"
 <luob87709@gmail.com>, rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/display: hold frontbuffer ref across
 dirtyfb fence callback
In-Reply-To: <20261127133935.1461-1-luob87709@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261127133935.1461-1-luob87709@gmail.com>
Date: Fri, 27 Nov 2026 16:17:21 +0200
Message-ID: <8247d106ca535db291d2f85a3b8bea7956c6ccd8@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 27 Nov 2026, "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com> wrote:
> intel_user_framebuffer_dirty() stores the raw intel_frontbuffer pointer
> in frontbuffer_fence_cb without taking a frontbuffer reference. If the
> framebuffer is destroyed and its owner frontbuffer reference is dropped
> before the reservation dma_fence signals,
> intel_user_framebuffer_fence_wake() passes a freed intel_frontbuffer
> pointer to intel_frontbuffer_queue_flush(), causing a use-after-free.

Please describe a real world scenario where this "if" can happen.

BR,
Jani.

>
> Take a frontbuffer reference via intel_parent_frontbuffer_ref() before
> registering the fence callback, and embed a work_struct in
> frontbuffer_fence_cb so intel_user_framebuffer_fence_wake() only
> schedules the work item and drops the fence reference in atomic
> dma_fence signaling context. Perform intel_frontbuffer_flush(), release
> the frontbuffer reference with intel_parent_frontbuffer_put(), and free
> cb from process context in intel_user_framebuffer_fence_work(). This
> avoids calling intel_parent_frontbuffer_put() in atomic context, where
> dropping the final reference can sleep on xe or deadlock on non-irqsafe
> locks in i915.
>
> Found by static code audit.
>
> Fixes: 1bb2af547a4b ("drm/i915: Handle dma fences in dirtyfb callback")
> Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
> ---
> Changes in v2:
> - Embed struct work_struct in frontbuffer_fence_cb and move
>   intel_frontbuffer_flush(), intel_parent_frontbuffer_put(), and kfree(cb)
>   into intel_user_framebuffer_fence_work() so intel_parent_frontbuffer_put()
>   is never invoked from atomic dma_fence signaling context (fixing the
>   sleeping-in-atomic/deadlock issue flagged on v1).
>
> Testing note:
> Compile-tested on x86_64 with W=1 and KASAN for both i915
> (drivers/gpu/drm/i915/display/intel_fb.o) and xe
> (drivers/gpu/drm/xe/i915-display/intel_fb.o); not runtime-tested on
> Intel display hardware.
>
>  drivers/gpu/drm/i915/display/intel_fb.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
> index 9d71f59..ee0665c 100644
> --- a/drivers/gpu/drm/i915/display/intel_fb.c
> +++ b/drivers/gpu/drm/i915/display/intel_fb.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/dma-fence.h>
>  #include <linux/dma-resv.h>
> +#include <linux/workqueue.h>
>  
>  #include <drm/drm_blend.h>
>  #include <drm/drm_gem.h>
> @@ -2141,16 +2142,26 @@ static int intel_user_framebuffer_create_handle(struct drm_framebuffer *fb,
>  
>  struct frontbuffer_fence_cb {
>  	struct dma_fence_cb base;
> +	struct work_struct work;
>  	struct intel_frontbuffer *front;
>  };
>  
> +static void intel_user_framebuffer_fence_work(struct work_struct *work)
> +{
> +	struct frontbuffer_fence_cb *cb = container_of(work, typeof(*cb), work);
> +	struct intel_frontbuffer *front = cb->front;
> +
> +	intel_frontbuffer_flush(front, ORIGIN_DIRTYFB);
> +	intel_parent_frontbuffer_put(front->display, front);
> +	kfree(cb);
> +}
> +
>  static void intel_user_framebuffer_fence_wake(struct dma_fence *dma,
>  					      struct dma_fence_cb *data)
>  {
>  	struct frontbuffer_fence_cb *cb = container_of(data, typeof(*cb), base);
>  
> -	intel_frontbuffer_queue_flush(cb->front);
> -	kfree(cb);
> +	schedule_work(&cb->work);
>  	dma_fence_put(dma);
>  }
>  
> @@ -2160,6 +2171,7 @@ static int intel_user_framebuffer_dirty(struct drm_framebuffer *fb,
>  					struct drm_clip_rect *clips,
>  					unsigned int num_clips)
>  {
> +	struct intel_display *display = to_intel_display(fb->dev);
>  	struct drm_gem_object *obj = intel_fb_bo(fb);
>  	struct intel_frontbuffer *front = to_intel_frontbuffer(fb);
>  	struct dma_fence *fence;
> @@ -2185,6 +2197,8 @@ static int intel_user_framebuffer_dirty(struct drm_framebuffer *fb,
>  	}
>  
>  	cb->front = front;
> +	INIT_WORK(&cb->work, intel_user_framebuffer_fence_work);
> +	intel_parent_frontbuffer_ref(display, front);
>  
>  	intel_frontbuffer_invalidate(front, ORIGIN_DIRTYFB);

-- 
Jani Nikula, Intel
