Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6958EC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C3B10EFBC;
	Thu, 20 Aug 2026 10:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hv2nZ15D";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9234110EFBC
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=1kzBTlf9VLTqOZkw3q1PrVe79Oi764efhhvraAbvMFU=; b=hv2nZ15DKnRpiJY5mLKUmhjqCt
 ik9T1+PuK2KYbUATeaurAYWE2RVkte4Lq5C5uurofd8RyjrnO9fJWxqvSJtu8QLCSna1x1Hjz1Hnj
 3MMtwEn/X8nMUCGHbEQ/2+WMzTe361bYzNKRI/jEQUGAUddlTOGgENDIMAA2IuBfmqPNURmF+is/U
 iUpY4Qapv88yN0aIEOUBydWrzKFXEQt/I1tW2EW774+zWnqe+a6pkgSjLGb9PY43uNJHTf+x6qrdO
 oy+MLXefNTV2cOjxywHQFD14AXkUsI02SqoSMuY+15XEAXFMzrLvItnXan4y7ytq04ivILyt9LSiB
 7a3DVBOw==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=[192.168.1.204]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wwzr6-006XY5-DZ; Thu, 20 Aug 2026 12:18:40 +0200
Message-ID: <b4b7520b-427d-4510-ae74-5592363065b5@igalia.com>
Date: Thu, 20 Aug 2026 12:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Fix drm_pending_vblank_event leak in error path
 for out_fence_ptr
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, sashiko-bot@kernel.org
References: <20260817-drm_pending_vblank_event_leak-v3-1-7582b24447d0@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260817-drm_pending_vblank_event_leak-v3-1-7582b24447d0@igalia.com>
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



On 17/08/2026 23:36, Thadeu Lima de Souza Cascardo wrote:
> When an out_fence_ptr is provided but DRM_MODE_PAGE_FLIP_EVENT is not
> set, a drm_pending_vblank_event will be allocated. If later, there is an
> allocation failure or another failure at setup_out_fence(), that event
> will not have base.fence set and it will not be released at
> complete_signaling().
>
> Release the event and set crtc_state->event to NULL just like in the
> DRM_MODE_PAGE_FLIP_EVENT case when there is a failure at
> drm_event_reserve_init(). That is, prepare_signaling() releases the
> event and there is nothing to be done at complete_signaling(). Use
> drm_event_cancel_free() as that will also undo drm_event_reserve_init()
> in case it has been called.
>
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com?part=1
> Fixes: 92c715fca907 ("drm/atomic: Fix double free in drm_atomic_state_default_clear")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> Changes in v3:
> - Use a label for the common exit pattern.
> - Link to v2: https://patch.msgid.link/20260729-drm_pending_vblank_event_leak-v2-1-a5074aae07df@igalia.com
>
> Changes in v2:
> - Fix UAF when DRM_MODE_PAGE_FLIP_EVENT is used.
> - Link to v1: https://patch.msgid.link/20260728-drm_pending_vblank_event_leak-v1-1-08429b920b16@igalia.com
> ---
>   drivers/gpu/drm/drm_atomic_uapi.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 1050dddadb17..0aba33824595 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1426,6 +1426,7 @@ static int prepare_signaling(struct drm_device *dev,
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_connector *conn;
>   	struct drm_connector_state *conn_state;
> +	struct drm_pending_vblank_event *e;
>   	int i, c = 0, ret;
>   
>   	if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY)
> @@ -1437,8 +1438,6 @@ static int prepare_signaling(struct drm_device *dev,
>   		fence_ptr = get_out_fence_for_crtc(crtc_state->state, crtc);
>   
>   		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT || fence_ptr) {
> -			struct drm_pending_vblank_event *e;
> -
>   			e = create_vblank_event(crtc, arg->user_data);
>   			if (!e)
>   				return -ENOMEM;
> @@ -1447,7 +1446,7 @@ static int prepare_signaling(struct drm_device *dev,
>   		}
>   
>   		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
> -			struct drm_pending_vblank_event *e = crtc_state->event;
> +			e = crtc_state->event;
>   
>   			if (!file_priv)
>   				continue;
> @@ -1464,11 +1463,14 @@ static int prepare_signaling(struct drm_device *dev,
>   		if (fence_ptr) {
>   			struct dma_fence *fence;
>   			struct drm_out_fence_state *f;
> +			e = crtc_state->event;
> +
> +			ret = -ENOMEM;
>   
>   			f = krealloc(*fence_state, sizeof(**fence_state) *
>   				     (*num_fences + 1), GFP_KERNEL);
>   			if (!f)
> -				return -ENOMEM;
> +				goto error;
>   
>   			memset(&f[*num_fences], 0, sizeof(*f));
>   
> @@ -1477,12 +1479,12 @@ static int prepare_signaling(struct drm_device *dev,
>   
>   			fence = drm_crtc_create_fence(crtc);
>   			if (!fence)
> -				return -ENOMEM;
> +				goto error;
>   
>   			ret = setup_out_fence(&f[(*num_fences)++], fence);
>   			if (ret) {
>   				dma_fence_put(fence);
> -				return ret;
> +				goto error;
>   			}
>   
>   			crtc_state->event->base.fence = fence;
> @@ -1538,6 +1540,11 @@ static int prepare_signaling(struct drm_device *dev,
>   	}
>   
>   	return 0;
> +
> +error:
> +	drm_event_cancel_free(dev, &e->base);

I think it's clearer to name the error handle as `err_free_event`, and 
to use `&crtc_state->event` directly instead of `&e` here.

With this,
Reviewed-by: Melissa Wen <mwen@igalia.com>

Thanks!

> +	crtc_state->event = NULL;
> +	return ret;
>   }
>   
>   static void complete_signaling(struct drm_device *dev,
>
> ---
> base-commit: 5d2584e2ffaabf2d420edcb2d120209e151f8dce
> change-id: 20260728-drm_pending_vblank_event_leak-a36cedb296ba
>
> Best regards,
> --
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>

