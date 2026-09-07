Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68BBC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C4C10E84F;
	Mon,  7 Sep 2026 14:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="PjuUDZvI";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1B510E84F
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 14:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788790048; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Kpz2kvN63OIHbP4Y/doeEX+OXusagVwQBCM7Y1oI7lJCAn0Gt1aBRu6NtyPi3ixIALnk2JL4b34PLODI+pnGns2PAZF+YEjt1+SR5AQdsXJaTiwJG2lP8j6ZNCCO7gFAIo5xmDZK2saTWcpgc8H5dpXNvSv/O36D7r+DK+GfdY4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788790048;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DCz9i2reWsrpFYk13e0Qo4NLX16nsUoQAAk500fgnYA=; 
 b=RDVu7FebuL7wRhe94McVXXZCT3JbVxpEp56t7taUClHyFIFBi6VdyN1Pv1RVXCKwNKG1fGPOR1RL1KHAWR8dr+ljMFeCDjJD/bAxMANazFl25woJM2GpZhvqyx3CwTW969lavf3xTuTmXu2FQFs3XgDwyvtr7eKiF1pmxWJi/x4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788790048; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DCz9i2reWsrpFYk13e0Qo4NLX16nsUoQAAk500fgnYA=;
 b=PjuUDZvIpUc7A6wDhfGdbbMeVQ2gG78lA2xzPukD+VsLrJI+jdCERPNqQv5Mt0W9
 uoG5WfLzJzuGr+yMQU/5T3iNrOxkNpagZ7qG8Lj55hr/oa5IP5rrBMaLkUz9jYGv0nn
 c54FbGO0xK9Tb4gBpbHZyuDIjM7c9BGUQkquIRrc=
Received: by mx.zohomail.com with SMTPS id 1788790047477485.6602521989356;
 Mon, 7 Sep 2026 07:07:27 -0700 (PDT)
Message-ID: <55240372-c265-4b38-be94-f29a58ddbb22@collabora.com>
Date: Mon, 7 Sep 2026 17:07:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: fix object leak when drm_gem_handle_create()
 fails
To: moonafterrain@outlook.com, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>
References: <20260815-virtgpu-gem-create-leak-v1-1-a4e9fb18caa3@outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260815-virtgpu-gem-create-leak-v1-1-a4e9fb18caa3@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

On 8/15/26 09:16, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> virtio_gpu_gem_create() owns the reference taken by
> virtio_gpu_object_create(). On the drm_gem_handle_create() error path it
> calls drm_gem_object_release() instead of dropping that reference.
> 
> drm_gem_object_release() is the inverse of drm_gem_object_init() and does
> not touch the reference count or call obj->funcs->free(), so it is only
> correct as the last step of a destructor, as in
> virtio_gpu_cleanup_object(). Using it here leaves the bo at refcount 1
> with no remaining reference, so virtio_gpu_free_object() never runs and
> the shmem pages, sg table and virtio_gpu_object are leaked. Since
> virtio_gpu_object_create() has already set bo->created,
> VIRTIO_GPU_CMD_RESOURCE_UNREF is not queued either, leaking the host-side
> resource and the resource id.
> 
> drm_gem_handle_create_tail() drops the handle reference on all of its
> internal error paths, so the caller only has to drop its own. Use
> drm_gem_object_put(), matching the success path below.
> 
> Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 66c3f6f74e9c..d2f0b8a3f172 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -45,7 +45,7 @@ static int virtio_gpu_gem_create(struct drm_file *file,
>  
>  	ret = drm_gem_handle_create(file, &obj->base.base, &handle);
>  	if (ret) {
> -		drm_gem_object_release(&obj->base.base);
> +		drm_gem_object_put(&obj->base.base);
>  		return ret;
>  	}
Could you please fix all other occurrences reported by bot in a v2?

-- 
Best regards,
Dmitry
