Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379A7606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=F48nCjBc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF5610E0B5;
	Fri, 23 Oct 2026 14:33:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9FA1010E0B5
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 14:33:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 060DF1C14
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:33:13 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 002A03F8C6
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792765996; bh=Gn5JR1ydvrwm3YaCW1+DyZrrnVAr3G/GKLqMw2kyGeg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F48nCjBchpvQ07geL5KcWSTG6kf1AxXfmz5aSx8pbcQSTw3EBJUtVA2GMOvK0Tfrr
 9T9kEfrZoE/wUJtQ3x/tDwY0Z1XO5p5cYcrNjpcIKy8hpMdTpZ3Es7eq6X86beLbMj
 X8vQc8WdQxouR9iJb8tEiA8UjFl3q9TbRWkEN5Fc=
Date: Fri, 23 Oct 2026 15:33:04 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v7 8/8] drm/panthor: Expose the panthor perf ioctls
Message-ID: <attwIGMsvdfAx-j_@e142607>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-8-12c32495062f@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011-panthor-performance-counters-v7-8-12c32495062f@arm.com>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 11, 2026 at 06:36:55PM +0100, Lukas Zapolskas wrote:
> This patch implements the PANTHOR_PERF_SESSION ioctl series.
> 
> The minor version is bumped to indicate that the feature is now
> supported.
> 
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 117 +++++++++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 3e62142d7ebd..5ca41cb9c1ba 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -184,7 +184,12 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size), \
> -		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks))
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_create, shader_enable_mask), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_start, user_data), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_stop, user_data), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_sample, user_data), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_session_destroy, handle))
>  
>  /**
>   * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
> @@ -1603,6 +1608,103 @@ static int panthor_ioctl_bo_query_info(struct drm_device *ddev, void *data,
>  	return 0;
>  }
>  
> +static int panthor_ioctl_perf_session_create(struct drm_device *ddev, void *data,
> +					     struct drm_file *file)
> +{
> +	int ret, cookie;
> +	unsigned long sid = 0;
> +	struct drm_panthor_perf_session_create *args = data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (!mem_is_zero(args->pad, sizeof(args->pad)))
> +		return -EINVAL;
> +
> +	ret = panthor_perf_session_create(file, args, &sid);
> +	if (ret)
> +		return ret;
> +
> +	drm_dev_exit(cookie);
> +	return sid;
> +}
> +
> +static int panthor_ioctl_perf_session_start(struct drm_device *ddev, void *data,
> +					    struct drm_file *file)
> +{
> +	int cookie, ret;
> +	struct panthor_file *pfile = file->driver_priv;
> +	struct drm_panthor_perf_session_start *args = data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (args->pad0)
> +		return -EINVAL;
> +
> +	ret = panthor_perf_session_start(pfile, args->handle, args->user_data);
> +
> +	drm_dev_exit(cookie);
> +	return ret;
> +}
> +
> +static int panthor_ioctl_perf_session_sample(struct drm_device *ddev, void *data,
> +					     struct drm_file *file)
> +{
> +	int cookie, ret;
> +	struct panthor_file *pfile = file->driver_priv;
> +	struct drm_panthor_perf_session_sample *args = data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (args->pad0)
> +		return -EINVAL;
> +
> +	ret =  panthor_perf_session_sample(pfile, args->handle, args->user_data);
> +
> +	drm_dev_exit(cookie);
> +	return ret;
> +}
> +
> +static int panthor_ioctl_perf_session_stop(struct drm_device *ddev, void *data,
> +					   struct drm_file *file)
> +{
> +	int cookie, ret;
> +	struct panthor_file *pfile = file->driver_priv;
> +	struct drm_panthor_perf_session_stop *args = data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (args->pad0)
> +		return -EINVAL;
> +
> +	ret = panthor_perf_session_stop(pfile, args->handle, args->user_data);
> +
> +	drm_dev_exit(cookie);
> +	return ret;
> +}
> +
> +static int panthor_ioctl_perf_session_destroy(struct drm_device *ddev, void *data,
> +					      struct drm_file *file)
> +{
> +	int cookie, ret;
> +	struct panthor_file *pfile = file->driver_priv;
> +	struct drm_panthor_perf_session_destroy *args = data;
> +
> +	if (!drm_dev_enter(file->minor->dev, &cookie))
> +		return -ENODEV;
> +
> +	if (args->pad0)
> +		return -EINVAL;
> +
> +	ret = panthor_perf_session_destroy(pfile, args->handle);
> +
> +	drm_dev_exit(cookie);
> +	return ret;
> +}
> +
>  static int
>  panthor_open(struct drm_device *ddev, struct drm_file *file)
>  {
> @@ -1687,6 +1789,11 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
>  	PANTHOR_IOCTL(SET_USER_MMIO_OFFSET, set_user_mmio_offset, DRM_RENDER_ALLOW),
>  	PANTHOR_IOCTL(BO_SYNC, bo_sync, DRM_RENDER_ALLOW),
>  	PANTHOR_IOCTL(BO_QUERY_INFO, bo_query_info, DRM_RENDER_ALLOW),
> +	PANTHOR_IOCTL(PERF_SESSION_CREATE, perf_session_create, DRM_RENDER_ALLOW),
> +	PANTHOR_IOCTL(PERF_SESSION_START, perf_session_start, DRM_RENDER_ALLOW),
> +	PANTHOR_IOCTL(PERF_SESSION_SAMPLE, perf_session_sample, DRM_RENDER_ALLOW),
> +	PANTHOR_IOCTL(PERF_SESSION_STOP, perf_session_stop, DRM_RENDER_ALLOW),
> +	PANTHOR_IOCTL(PERF_SESSION_DESTROY, perf_session_destroy, DRM_RENDER_ALLOW),
>  };
>  
>  static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
> @@ -1807,6 +1914,12 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
>   * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
>   *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
> + * - 1.10 - adds DEV_QUERY_PERF_INFO query
> + *        - adds PERF_SESSION_CREATE ioctl
> + *        - adds PERF_SESSION_START ioctl
> + *        - adds PERF_SESSION_SAMPLE ioctl
> + *        - adds PERF_SESSION_STOP ioctl
> + *        - adds PERF_SESSION_DESTROY ioctl
>   */
>  static const struct drm_driver panthor_drm_driver = {
>  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> @@ -1820,7 +1933,7 @@ static const struct drm_driver panthor_drm_driver = {
>  	.name = "panthor",
>  	.desc = "Panthor DRM driver",
>  	.major = 1,
> -	.minor = 9,
> +	.minor = 10,
>  
>  	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
>  	.gem_prime_import = panthor_gem_prime_import,
> 
> -- 
> 2.43.0
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
