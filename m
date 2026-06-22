Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BF8CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA01D10E62E;
	Mon, 22 Jun 2026 11:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gXqVCwUZ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736AB10E62E
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 11:55:47 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A7F29CE;
 Mon, 22 Jun 2026 13:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1782129308;
 bh=TDWFD3aVcqsYOWPdtLK1KFJLiTGZTVKDYeLf7bJYrTI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gXqVCwUZLPEnE7+3WkZgPXN8wj92R1iMQN4M2WulFhoKn0NvAfnk3KZEWuZgsup5D
 8RoaWA0hX6YTShku4A/WXvC7oWXoVYz8aYCGcrzpDgRyQdiF9DSQq8L4frK/138L3R
 7KtnEvqzi26otYw6b7lxtx7g1yobSEfXkbX8oo5A=
Date: Mon, 22 Jun 2026 14:55:44 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] drm/gem: modernize locks to use scoped_guard()
Message-ID: <20260622115544.GA3899302@killaraus.ideasonboard.com>
References: <20260616181956.61476-2-birenpandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616181956.61476-2-birenpandya@gmail.com>
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

On Tue, Jun 16, 2026 at 11:49:57PM +0530, Biren Pandya wrote:
> Several GEM core functions manually managed mutex_lock() and
> mutex_unlock() over single scopes or error paths. This adds boilerplate
> and carries the risk of lock leaks if error paths are refactored.
> 
> Modernize these locks by deploying the <linux/cleanup.h> scoped_guard()
> macro. This ensures that the locks are reliably dropped when the block
> exits, cleanly removing goto out_unlock paths and tightening the
> lifecycle.

What's the reason for doing so in in drm_gem and not other areas in DRM
?

> Signed-off-by: Biren Pandya <birenpandya@gmail.com>
> 
> Compiled locally, but requires IGT validation by the DRM CI.
> ---
>  drivers/gpu/drm/drm_gem.c | 66 ++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 891c3bff5ae0..d3a061d42ba7 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -346,13 +346,13 @@ void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
>  	 * we checked for a name.
>  	 */
>  
> -	mutex_lock(&dev->object_name_lock);
> -	if (--obj->handle_count == 0) {
> -		drm_gem_object_handle_free(obj);
> -		drm_gem_object_exported_dma_buf_free(obj);
> -		final = true;
> +	scoped_guard(mutex, &dev->object_name_lock) {
> +		if (--obj->handle_count == 0) {
> +			drm_gem_object_handle_free(obj);
> +			drm_gem_object_exported_dma_buf_free(obj);
> +			final = true;
> +		}
>  	}
> -	mutex_unlock(&dev->object_name_lock);
>  
>  	if (final)
>  		drm_gem_object_put(obj);
> @@ -374,11 +374,8 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
>  	if (obj->funcs->close)
>  		obj->funcs->close(obj, file_priv);
>  
> -	mutex_lock(&file_priv->prime.lock);
> -
> -	drm_prime_remove_buf_handle(&file_priv->prime, id);
> -
> -	mutex_unlock(&file_priv->prime.lock);
> +	scoped_guard(mutex, &file_priv->prime.lock)
> +		drm_prime_remove_buf_handle(&file_priv->prime, id);
>  
>  	drm_vma_node_revoke(&obj->vma_node, file_priv);
>  
> @@ -1021,37 +1018,34 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>  		goto out;
>  	}
>  
> -	mutex_lock(&file_priv->prime.lock);
> +	scoped_guard(mutex, &file_priv->prime.lock) {
> +		spin_lock(&file_priv->table_lock);
> +		ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
> +				GFP_NOWAIT);
> +		spin_unlock(&file_priv->table_lock);

And why don't you use guards for the spinlock as well ?

>  
> -	spin_lock(&file_priv->table_lock);
> -	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
> -			GFP_NOWAIT);
> -	spin_unlock(&file_priv->table_lock);
> +		if (ret < 0)
> +			break;
>  
> -	if (ret < 0)
> -		goto out_unlock;
> +		if (obj->dma_buf) {
> +			ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
> +						       handle);
> +			if (ret < 0) {
> +				spin_lock(&file_priv->table_lock);
> +				idr_remove(&file_priv->object_idr, handle);
> +				spin_unlock(&file_priv->table_lock);
> +				break;
> +			}
>  
> -	if (obj->dma_buf) {
> -		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
> -					       handle);
> -		if (ret < 0) {
> -			spin_lock(&file_priv->table_lock);
> -			idr_remove(&file_priv->object_idr, handle);
> -			spin_unlock(&file_priv->table_lock);
> -			goto out_unlock;
> +			drm_prime_remove_buf_handle(&file_priv->prime, args->handle);
>  		}
>  
> -		drm_prime_remove_buf_handle(&file_priv->prime, args->handle);
> -	}
> -
> -	ret = 0;
> -
> -	spin_lock(&file_priv->table_lock);
> -	idr_remove(&file_priv->object_idr, args->handle);
> -	spin_unlock(&file_priv->table_lock);
> +		ret = 0;
>  
> -out_unlock:
> -	mutex_unlock(&file_priv->prime.lock);
> +		spin_lock(&file_priv->table_lock);
> +		idr_remove(&file_priv->object_idr, args->handle);
> +		spin_unlock(&file_priv->table_lock);
> +	}
>  out:
>  	drm_gem_object_put(obj);
>  
> 
> base-commit: 72c25183cac9bc584c9de21797a5883af44bcc7a

-- 
Regards,

Laurent Pinchart
