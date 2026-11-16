Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F1606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=BaeIFVC/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31BF410EE19;
	Mon, 16 Nov 2026 10:15:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A374C10EE19
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=AHZ6lJkO0NsKqFcyD6tacNMmzzFNjBIydW0bSiRfiHA=; t=1794824147; x=2110184147; 
 b=BaeIFVC/+3ZnHNL9wBhUE/P0xuJe7hc9kYoURQF3PQs6hYrASDnsRSBDdNPnmqwgp5rByg1xA7j
 zTUyxeVYMcB7a8VUYhJ0/0q7bNUGC2jDAQbw4wdjZ0HzdTXnAx/iD7w77SDkt6OYRbJc8DTowiWF8
 r+rL+1qDnFMIeAP/kRfAdPZPhntkhW/PgYFkXjwdO8nfi2IwBnIR1ng1nGM6OvN/mG6dCz9xZD//P
 4WLe2j7dKU+BSbQ1nSToalCyfHhcsoFY7Nu3KKxsgDEKGyvJKlCQFevHE8fLkSukVVLPv5Jf8636+
 sJW+Ihv8U+fjyYNp3vh/QUTc4EVQvjBb1Cww==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xStkX-000000008oE-1L3l; Mon, 16 Nov 2026 11:15:45 +0100
Message-ID: <bd8a53b4-c35a-43ae-b279-2d998df42256@igalia.com>
Date: Mon, 16 Nov 2026 10:15:44 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/gem: Fix and enable CHANGE_HANDLE
To: David Francis <David.Francis@amd.com>, dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20261113150226.1123441-1-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261113150226.1123441-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 13/11/2026 15:02, David Francis wrote:
> Make the following changes to CHANGE_HANDLE
> - reject new_handle = old_handle with -EINVAL
> - idr_preload before idr_alloc
> - reject new_handle = 0 with -EINVAL
> and re-enable it.
> 
> These changes are prerequisities for the enabling of this ioctl, which was
> disabled over security concerns and the lack of IGT tests.
> 
> For a summary of the saga so far, see
> https://lists.freedesktop.org/archives/dri-devel/2026-June/571890.html
> 
> I hope these changes leave the ioctl in a spot where it is safe to
> re-enable. There are now igt tests covering all corner case behaviour
> and race conditions between change_handle and itself, create, free,
> import, and export.
> 
> The new_handle = 0 and new_handle = old_handle corner cases
> are now -EINVAL as recommended; these are covered in the igt tests.
> 
> idr_preload is now correctly called before idr_alloc.
> 
> And the new handle being taken is now EBUSY instead of ENOENT.
> 
> With these changes the TODO can be removed and the ioctl can be
> re-enabled.
> 
> Accompanying IGT patch on igt-dev (currently at v4) is
> tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE
> 
> v2: new_handle = old_handle is EINVAL
> v3: More detailed commit message and some cleanup
> v4: New handle taken is now EBUSY instead of ENOSPC
> 
> cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> cc: Christian Koenig <christian.koenig@amd.com>
> cc: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/drm_gem.c   | 33 ++++++++++++---------------------
>   drivers/gpu/drm/drm_ioctl.c |  3 +--
>   2 files changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6a86bd2a0343..0c64170f7d61 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1018,44 +1018,33 @@ drm_gem_open_ioctl(struct drm_device *dev, void *data,
>   	return ret;
>   }
>   
> -/*
> - * This ioctl is disabled for security reasons but also it failed
> - * to follow process in terms of adding testing in igt and verifying
> - * all the corner cases which made fixing security bugs in it even
> - * harder than necessary.
> - *
> - * To re-enable this ioctl
> - * 1. land working IGT tests in igt-gpu-tools that cover
> - *    all corner cases and race conditions.
> - * 2. handle idr_preload
> - * 3. handle == 0
> - * 4. handle == new_handle semantics definition.
> - */
>   int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>   				struct drm_file *file_priv)
>   {
>   	struct drm_gem_change_handle *args = data;
>   	struct drm_gem_object *obj;
> -	int new_handle, ret;
> +	int ret;
> +	u32 new_handle;
>   
>   	if (!drm_core_check_feature(dev, DRIVER_GEM))
>   		return -EOPNOTSUPP;
>   
> -	/* idr_alloc() limitation. */
> -	if (args->new_handle > INT_MAX)
> -		return -EINVAL;
>   	new_handle = args->new_handle;
>   
> -	if (args->handle == new_handle)
> -		return 0;
> +	if (new_handle == 0 || new_handle > INT_MAX ||
> +	    args->handle == new_handle)
> +		return -EINVAL;
>   
>   	mutex_lock(&file_priv->prime.lock);
> +	idr_preload(GFP_KERNEL);
>   	spin_lock(&file_priv->table_lock);
> -	ret = idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
> -			GFP_NOWAIT);
> +	ret = idr_alloc(&file_priv->object_idr, NULL, new_handle,
> +			new_handle + 1, GFP_NOWAIT);
>   
>   	if (ret < 0) {
>   		spin_unlock(&file_priv->table_lock);
> +		idr_preload_end();
> +		ret = -EBUSY;

I think this should be:

if (ret == -ENOSPC)
	ret = -EBUSY;

So -ENOMEM is passed on. With that:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>   		goto out_unlock;
>   	}
>   
> @@ -1063,10 +1052,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>   	if (IS_ERR_OR_NULL(obj)) {
>   		idr_remove(&file_priv->object_idr, new_handle);
>   		spin_unlock(&file_priv->table_lock);
> +		idr_preload_end();
>   		ret = -ENOENT;
>   		goto out_unlock;
>   	}
>   	spin_unlock(&file_priv->table_lock);
> +	idr_preload_end();
>   
>   	if (obj->dma_buf) {
>   		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index e2df4becce62..ff193155129e 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -660,8 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
>   	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
>   	DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
> -	/* see drm_gem.c:drm_gem_change_handle_ioctl for why this is invalid */
> -	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_ioctl, DRM_RENDER_ALLOW),
>   
>   	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0),
>   

