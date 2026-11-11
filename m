Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79B606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ju6qRcDc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF9410FB00;
	Wed, 11 Nov 2026 11:16:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCF910FB00
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=UjzFmlZH5du9pKq7jxIaYiuoZRkZs0U+COEYUNSSUuQ=; t=1794395772; x=2109755772; 
 b=ju6qRcDc/XxepK2NwgMB2HGtUsg9TGefNNS3GfoxYy6620SdMirRHv4snN4+g9+BwfCRHWxv55a
 qWX9qXK2M9CMMwE8PdJnc1vwACYf9Fax0dG3wxlk7nEL+9DoM+IWUmnFbeDMSOCINl4avSahQJpAm
 WRZVtRovzoqn3z9Yd+VhC4B+08KvIwPg9MFPr0BkhM7+KOFegLutcRsODIHDlpJzTK8pytxuUIyTF
 nRIzJNpE+sX2zgRdnq7mpMHy+KyHjDr710tWIETBQVLMeg5uO/UAJB9Myb1yDte1dhbo/YpyzncyH
 DoJVo5Qt28J0LG5fO7J/CfBhoMtnFGA0PNQQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xR6J1-008mxg-Bx; Wed, 11 Nov 2026 12:15:55 +0100
Message-ID: <fc2d5a1a-20a4-4e31-a05d-85b883412a3a@igalia.com>
Date: Wed, 11 Nov 2026 08:15:45 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/12] drm/prime: Allow custom dma_buf_ops in PRIME
 helpers
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 JaeHoon Lee <dlwognsdc610@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
 <20261030-v3d-cached-maps-v1-1-0a6a6b363382@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20261030-v3d-cached-maps-v1-1-0a6a6b363382@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 30/10/26 17:50, Maíra Canal wrote:
> drm_gem_prime_export() and drm_gem_is_prime_exported_dma_buf() hardcode
> drm_gem_prime_dmabuf_ops. Drivers with custom dma_buf_ops can't use them
> and end up duplicating the export and self-import logic instead.
> 
> Add drm_gem_prime_export_with_ops() to export with driver-provided ops,
> and an optional drm_driver.gem_prime_is_exporter() callback to let drivers
> identify their own DMA-BUFs. Note that the callback must receive DMA-BUF,
> so that the driver can check its ops before dereferencing dma_buf->priv.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Thomas, Christian, Boris, do you have any thoughts about this design?
Any feedback would be valuable to move this forward.

Best regards,
- Maíra

> ---
>   drivers/gpu/drm/drm_prime.c | 47 +++++++++++++++++++++++++++++++++++----------
>   include/drm/drm_drv.h       | 11 +++++++++++
>   include/drm/drm_prime.h     |  4 ++++
>   3 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index fe3436d1235d..4183def83cdd 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -905,22 +905,26 @@ unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt)
>   EXPORT_SYMBOL(drm_prime_get_contiguous_size);
>   
>   /**
> - * drm_gem_prime_export - helper library implementation of the export callback
> + * drm_gem_prime_export_with_ops - export a GEM object with custom dma_buf_ops
>    * @obj: GEM object to export
> + * @dma_buf_ops: &dma_buf_ops of the exported DMA-BUF
>    * @flags: flags like DRM_CLOEXEC and DRM_RDWR
>    *
> - * This is the implementation of the &drm_gem_object_funcs.export functions for GEM drivers
> - * using the PRIME helpers. It is used as the default in
> - * drm_gem_prime_handle_to_fd().
> + * Same as drm_gem_prime_export(), but with driver-provided &dma_buf_ops.
> + * Drivers using this can implement &drm_driver.gem_prime_is_exporter for
> + * the PRIME import helpers to recognize their own buffers.
> + *
> + * Return: the exported DMA-BUF on success, or an ERR_PTR() on failure.
>    */
> -struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
> -				     int flags)
> +struct dma_buf *drm_gem_prime_export_with_ops(struct drm_gem_object *obj,
> +					      const struct dma_buf_ops *dma_buf_ops,
> +					      int flags)
>   {
>   	struct drm_device *dev = obj->dev;
>   	struct dma_buf_export_info exp_info = {
>   		.exp_name = KBUILD_MODNAME, /* white lie for debug */
>   		.owner = dev->driver->fops->owner,
> -		.ops = &drm_gem_prime_dmabuf_ops,
> +		.ops = dma_buf_ops,
>   		.size = obj->size,
>   		.flags = flags,
>   		.priv = obj,
> @@ -929,24 +933,47 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>   
>   	return drm_gem_dmabuf_export(dev, &exp_info);
>   }
> +EXPORT_SYMBOL(drm_gem_prime_export_with_ops);
> +
> +/**
> + * drm_gem_prime_export - helper library implementation of the export callback
> + * @obj: GEM object to export
> + * @flags: flags like DRM_CLOEXEC and DRM_RDWR
> + *
> + * This is the implementation of the &drm_gem_object_funcs.export function for
> + * GEM drivers using the PRIME helpers. It is used as the default in
> + * drm_gem_prime_handle_to_fd().
> + *
> + * Return: the exported DMA-BUF on success, or an ERR_PTR() on failure.
> + */
> +struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
> +				     int flags)
> +{
> +	return drm_gem_prime_export_with_ops(obj, &drm_gem_prime_dmabuf_ops, flags);
> +}
>   EXPORT_SYMBOL(drm_gem_prime_export);
>   
>   
>   /**
> - * drm_gem_is_prime_exported_dma_buf -
> - * checks if the DMA-BUF was exported from a GEM object belonging to @dev.
> + * drm_gem_is_prime_exported_dma_buf - check if a DMA-BUF was exported by @dev
>    * @dev: drm_device to check against
>    * @dma_buf: dma-buf object to import
>    *
> + * DMA-BUFs exported with custom &dma_buf_ops are recognized through
> + * &drm_driver.gem_prime_is_exporter.
> + *
>    * Return: true if the DMA-BUF was exported from a GEM object belonging
>    * to @dev, false otherwise.
>    */
> -
>   bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
>   				       struct dma_buf *dma_buf)
>   {
>   	struct drm_gem_object *obj = dma_buf->priv;
>   
> +	if (dev->driver->gem_prime_is_exporter &&
> +	    dev->driver->gem_prime_is_exporter(dev, dma_buf))
> +		return true;
> +
>   	return (dma_buf->ops == &drm_gem_prime_dmabuf_ops) && (obj->dev == dev);
>   }
>   EXPORT_SYMBOL(drm_gem_is_prime_exported_dma_buf);
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index b23830494ed4..d613740a06d4 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -310,6 +310,17 @@ struct drm_driver {
>   	 */
>   	struct drm_gem_object * (*gem_prime_import)(struct drm_device *dev,
>   				struct dma_buf *dma_buf);
> +	/**
> +	 * @gem_prime_is_exporter:
> +	 *
> +	 * Returns true if @dma_buf was exported from a GEM object of @dev.
> +	 * Drivers exporting with a custom &dma_buf_ops can implement this
> +	 * hook to let the PRIME import helpers recognize their own buffers.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	bool (*gem_prime_is_exporter)(struct drm_device *dev,
> +				      struct dma_buf *dma_buf);
>   	/**
>   	 * @gem_prime_import_sg_table:
>   	 *
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index f50f862f0d8b..9b704e3ca919 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -53,6 +53,7 @@ struct device;
>   
>   struct dma_buf_export_info;
>   struct dma_buf;
> +struct dma_buf_ops;
>   struct dma_buf_attachment;
>   struct iosys_map;
>   
> @@ -96,6 +97,9 @@ struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
>   				       struct page **pages, unsigned int nr_pages);
>   struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>   				     int flags);
> +struct dma_buf *drm_gem_prime_export_with_ops(struct drm_gem_object *obj,
> +					      const struct dma_buf_ops *dma_buf_ops,
> +					      int flags);
>   
>   unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
>   
> 

