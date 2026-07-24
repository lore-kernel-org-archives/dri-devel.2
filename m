Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9569BC531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C094410F3F8;
	Fri, 24 Jul 2026 14:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ylaX/+Ba";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Km3dRFOZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ylaX/+Ba";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Km3dRFOZ";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E560C10F3E6
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:53:43 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 753F17B943;
 Fri, 24 Jul 2026 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784904822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RAbRRkvRTxVUP4oDtav7AZ4U19XpJLvmf4PtWK1XFlc=;
 b=ylaX/+BapsrlcuO8oMXXB8HAmdfGXLP31Z7ebwxeLkCKt+Krk8GPyM0hZbTYqttmSL8sg8
 cypfXhTbZkRJjuUmk7szOFTmhTnP8bbq7YYDi+ouTuwDRJLZq6JHionSJQKLPQCePPC4+j
 hChJglEHOmOwGNU+oD1BtYhZts04SV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784904822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RAbRRkvRTxVUP4oDtav7AZ4U19XpJLvmf4PtWK1XFlc=;
 b=Km3dRFOZEaV+XY97uNOiebcEHLXx1u848dxvahZF68g7AdbD8azVpnCXYRJir/l+Z50bK9
 Z5rfzC4JJusLQrAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784904822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RAbRRkvRTxVUP4oDtav7AZ4U19XpJLvmf4PtWK1XFlc=;
 b=ylaX/+BapsrlcuO8oMXXB8HAmdfGXLP31Z7ebwxeLkCKt+Krk8GPyM0hZbTYqttmSL8sg8
 cypfXhTbZkRJjuUmk7szOFTmhTnP8bbq7YYDi+ouTuwDRJLZq6JHionSJQKLPQCePPC4+j
 hChJglEHOmOwGNU+oD1BtYhZts04SV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784904822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RAbRRkvRTxVUP4oDtav7AZ4U19XpJLvmf4PtWK1XFlc=;
 b=Km3dRFOZEaV+XY97uNOiebcEHLXx1u848dxvahZF68g7AdbD8azVpnCXYRJir/l+Z50bK9
 Z5rfzC4JJusLQrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AB5E779BA;
 Fri, 24 Jul 2026 14:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DDOzCHV8Y2ppcgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 24 Jul 2026 14:53:41 +0000
Message-ID: <85fef48b-6e6a-40ff-9b71-5048828220fe@suse.de>
Date: Fri, 24 Jul 2026 16:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gem: Move pages_to_sg helper into drm_gem.c
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Zack Rusin
 <zack.rusin@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260724-get_pages-v1-1-b10e5d65628e@collabora.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260724-get_pages-v1-1-b10e5d65628e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TAGGED_RCPT(0.00)[etnaviv]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[collabora.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,pengutronix.de,armlinux.org.uk,loongson.cn,aosc.io,xry111.site,iscas.ac.cn,oss.qualcomm.com,linux.dev,poorly.run,somainline.org,redhat.com,arm.com,rock-chips.com,sntech.de,nvidia.com,broadcom.com,intel.com,epam.com,linaro.org];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCPT_COUNT_GT_50(0.00)[54];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid, suse.com:url,
 collabora.com:email, imap1.dmz-prg2.suse.org:helo]
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

Hi

Am 24.07.26 um 14:08 schrieb Adrián Larumbe:
> None of the semantics of the function tell of it being a PRIME-exclusive
> entry point. In fact, most drivers seem to be using it to translate a list
> of pages into an sg table that can be used for GPU mapping later on, rather
> than just for sharing an object's pages with another driver.
>
> Move it across files and rename accordingly.

Makes sense to me. But the helper has no hard dependency on anything in 
DRM. I wonder if it shouldn't be a helper in the dma or 
memory-management subsystem.

>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

In any case:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>


Best regards
Thomas


> ---
> drm_prime_pages_to_sg() has no real dependency on PRIME/dma-buf interfaces.
> It is a generic helper that converts a page array into a scatter/gather
> table via dma_map_sg_attrs. Nothing in its implementation touches struct
> dma_buf or import/export logic.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  6 ++---
>   drivers/gpu/drm/drm_gem.c                   | 35 ++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_gem_shmem_helper.c      |  2 +-
>   drivers/gpu/drm/drm_prime.c                 | 38 -----------------------------
>   drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  3 +--
>   drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  3 ++-
>   drivers/gpu/drm/loongson/lsdc_gem.c         |  3 +--
>   drivers/gpu/drm/msm/msm_gem.c               |  2 +-
>   drivers/gpu/drm/msm/msm_gem_prime.c         |  2 +-
>   drivers/gpu/drm/nouveau/nouveau_prime.c     |  4 +--
>   drivers/gpu/drm/panthor/panthor_gem.c       |  6 ++---
>   drivers/gpu/drm/radeon/radeon_prime.c       |  5 ++--
>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  6 ++---
>   drivers/gpu/drm/tegra/gem.c                 |  4 +--
>   drivers/gpu/drm/vmwgfx/vmwgfx_gem.c         |  4 +--
>   drivers/gpu/drm/xe/xe_dma_buf.c             |  6 ++---
>   drivers/gpu/drm/xen/xen_drm_front_gem.c     |  2 +-
>   include/drm/drm_gem.h                       |  5 +++-
>   include/drm/drm_prime.h                     |  2 --
>   19 files changed, 68 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index b33c300e26e2..c9a98aec7eb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -203,9 +203,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   
>   	switch (bo->tbo.resource->mem_type) {
>   	case TTM_PL_TT:
> -		sgt = drm_prime_pages_to_sg(obj->dev,
> -					    bo->tbo.ttm->pages,
> -					    bo->tbo.ttm->num_pages);
> +		sgt = drm_pages_to_sg(obj->dev,
> +				      bo->tbo.ttm->pages,
> +				      bo->tbo.ttm->num_pages);
>   		if (IS_ERR(sgt))
>   			return sgt;
>   
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 018df97d590d..22c8a3b5f667 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -780,6 +780,41 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>   }
>   EXPORT_SYMBOL(drm_gem_put_pages);
>   
> +/**
> + * drm_pages_to_sg - converts a page array into an sg list
> + * @dev: DRM device
> + * @pages: pointer to the array of page pointers to convert
> + * @nr_pages: length of the page vector
> + *
> + * This helper creates an sg table object from a set of pages.
> + * This is useful for implementing &drm_gem_object_funcs.get_sg_table.
> + */
> +struct sg_table *drm_pages_to_sg(struct drm_device *dev,
> +				 struct page **pages, unsigned int nr_pages)
> +{
> +	struct sg_table *sg;
> +	size_t max_segment = 0;
> +	int err;
> +
> +	sg = kmalloc_obj(struct sg_table);
> +	if (!sg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (dev)
> +		max_segment = dma_max_mapping_size(drm_dev_dma_dev(dev));
> +	if (max_segment == 0)
> +		max_segment = UINT_MAX;
> +	err = sg_alloc_table_from_pages_segment(sg, pages, nr_pages, 0,
> +						(unsigned long)nr_pages << PAGE_SHIFT,
> +						max_segment, GFP_KERNEL);
> +	if (err) {
> +		kfree(sg);
> +		sg = ERR_PTR(err);
> +	}
> +	return sg;
> +}
> +EXPORT_SYMBOL(drm_pages_to_sg);
> +
>   static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>   			  struct drm_gem_object **objs)
>   {
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 22ec52e2ffb8..144d088a477f 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -825,7 +825,7 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
>   
>   	drm_WARN_ON(obj->dev, drm_gem_is_imported(obj));
>   
> -	return drm_prime_pages_to_sg(obj->dev, shmem->pages, obj->size >> PAGE_SHIFT);
> +	return drm_pages_to_sg(obj->dev, shmem->pages, obj->size >> PAGE_SHIFT);
>   }
>   EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
>   
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 9b44c78cd77f..54539a8929c1 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -835,44 +835,6 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
>   	.vunmap = drm_gem_dmabuf_vunmap,
>   };
>   
> -/**
> - * drm_prime_pages_to_sg - converts a page array into an sg list
> - * @dev: DRM device
> - * @pages: pointer to the array of page pointers to convert
> - * @nr_pages: length of the page vector
> - *
> - * This helper creates an sg table object from a set of pages
> - * the driver is responsible for mapping the pages into the
> - * importers address space for use with dma_buf itself.
> - *
> - * This is useful for implementing &drm_gem_object_funcs.get_sg_table.
> - */
> -struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
> -				       struct page **pages, unsigned int nr_pages)
> -{
> -	struct sg_table *sg;
> -	size_t max_segment = 0;
> -	int err;
> -
> -	sg = kmalloc_obj(struct sg_table);
> -	if (!sg)
> -		return ERR_PTR(-ENOMEM);
> -
> -	if (dev)
> -		max_segment = dma_max_mapping_size(drm_dev_dma_dev(dev));
> -	if (max_segment == 0)
> -		max_segment = UINT_MAX;
> -	err = sg_alloc_table_from_pages_segment(sg, pages, nr_pages, 0,
> -						(unsigned long)nr_pages << PAGE_SHIFT,
> -						max_segment, GFP_KERNEL);
> -	if (err) {
> -		kfree(sg);
> -		sg = ERR_PTR(err);
> -	}
> -	return sg;
> -}
> -EXPORT_SYMBOL(drm_prime_pages_to_sg);
> -
>   /**
>    * drm_prime_get_contiguous_size - returns the contiguous size of the buffer
>    * @sgt: sg_table describing the buffer to check
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index b0436a1e103f..a8e8614f8210 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2015-2018 Etnaviv Project
>    */
>   
> -#include <drm/drm_prime.h>
>   #include <drm/drm_print.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/shmem_fs.h>
> @@ -104,7 +103,7 @@ struct page **etnaviv_gem_get_pages(struct etnaviv_gem_object *etnaviv_obj)
>   		unsigned int npages = etnaviv_obj->base.size >> PAGE_SHIFT;
>   		struct sg_table *sgt;
>   
> -		sgt = drm_prime_pages_to_sg(dev, etnaviv_obj->pages, npages);
> +		sgt = drm_pages_to_sg(dev, etnaviv_obj->pages, npages);
>   		if (IS_ERR(sgt)) {
>   			dev_err(dev->dev, "failed to allocate sgt: %ld\n",
>   				PTR_ERR(sgt));
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> index 6757ae6ec304..f44484325ddb 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2014-2018 Etnaviv Project
>    */
>   
> +#include <drm/drm_gem.h>
>   #include <drm/drm_prime.h>
>   #include <linux/dma-buf.h>
>   #include <linux/module.h>
> @@ -22,7 +23,7 @@ struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
>   	if (WARN_ON(!etnaviv_obj->pages))  /* should have already pinned! */
>   		return ERR_PTR(-EINVAL);
>   
> -	return drm_prime_pages_to_sg(obj->dev, etnaviv_obj->pages, npages);
> +	return drm_pages_to_sg(obj->dev, etnaviv_obj->pages, npages);
>   }
>   
>   int etnaviv_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> diff --git a/drivers/gpu/drm/loongson/lsdc_gem.c b/drivers/gpu/drm/loongson/lsdc_gem.c
> index 2fb03487c983..37160228244c 100644
> --- a/drivers/gpu/drm/loongson/lsdc_gem.c
> +++ b/drivers/gpu/drm/loongson/lsdc_gem.c
> @@ -9,7 +9,6 @@
>   #include <drm/drm_dumb_buffers.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_gem.h>
> -#include <drm/drm_prime.h>
>   #include <drm/drm_print.h>
>   
>   #include "lsdc_drv.h"
> @@ -51,7 +50,7 @@ static struct sg_table *lsdc_gem_prime_get_sg_table(struct drm_gem_object *obj)
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	return drm_prime_pages_to_sg(obj->dev, tt->pages, tt->num_pages);
> +	return drm_pages_to_sg(obj->dev, tt->pages, tt->num_pages);
>   }
>   
>   static void lsdc_gem_object_free(struct drm_gem_object *obj)
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index efd3d3c9a449..7e3418290c22 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -207,7 +207,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
>   
>   		msm_obj->pages = p;
>   
> -		msm_obj->sgt = drm_prime_pages_to_sg(obj->dev, p, npages);
> +		msm_obj->sgt = drm_pages_to_sg(obj->dev, p, npages);
>   		if (IS_ERR(msm_obj->sgt)) {
>   			void *ptr = ERR_CAST(msm_obj->sgt);
>   
> diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
> index 036d34c674d9..d25393a9e549 100644
> --- a/drivers/gpu/drm/msm/msm_gem_prime.c
> +++ b/drivers/gpu/drm/msm/msm_gem_prime.c
> @@ -23,7 +23,7 @@ struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
>   	if (WARN_ON(!msm_obj->pages))  /* should have already pinned! */
>   		return ERR_PTR(-ENOMEM);
>   
> -	return drm_prime_pages_to_sg(obj->dev, msm_obj->pages, npages);
> +	return drm_pages_to_sg(obj->dev, msm_obj->pages, npages);
>   }
>   
>   int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/nouveau/nouveau_prime.c
> index caab60fc62f6..b95f2f07df74 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_prime.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
> @@ -32,8 +32,8 @@ struct sg_table *nouveau_gem_prime_get_sg_table(struct drm_gem_object *obj)
>   {
>   	struct nouveau_bo *nvbo = nouveau_gem_object(obj);
>   
> -	return drm_prime_pages_to_sg(obj->dev, nvbo->bo.ttm->pages,
> -				     nvbo->bo.ttm->num_pages);
> +	return drm_pages_to_sg(obj->dev, nvbo->bo.ttm->pages,
> +			       nvbo->bo.ttm->num_pages);
>   }
>   
>   struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 9855df738194..ec530d254fa4 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -321,8 +321,8 @@ panthor_gem_dev_map_get_sgt_locked(struct panthor_gem_object *bo)
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> -	sgt = drm_prime_pages_to_sg(bo->base.dev, bo->backing.pages,
> -				    bo->base.size >> PAGE_SHIFT);
> +	sgt = drm_pages_to_sg(bo->base.dev, bo->backing.pages,
> +			      bo->base.size >> PAGE_SHIFT);
>   	if (IS_ERR(sgt))
>   		return sgt;
>   
> @@ -702,7 +702,7 @@ static struct sg_table *panthor_gem_get_sg_table(struct drm_gem_object *obj)
>   	drm_WARN_ON_ONCE(obj->dev, !bo->backing.pages);
>   	drm_WARN_ON_ONCE(obj->dev, !refcount_read(&bo->backing.pin_count));
>   
> -	return drm_prime_pages_to_sg(obj->dev, bo->backing.pages, obj->size >> PAGE_SHIFT);
> +	return drm_pages_to_sg(obj->dev, bo->backing.pages, obj->size >> PAGE_SHIFT);
>   }
>   
>   static int panthor_gem_vmap_locked(struct drm_gem_object *obj,
> diff --git a/drivers/gpu/drm/radeon/radeon_prime.c b/drivers/gpu/drm/radeon/radeon_prime.c
> index a77881f035e7..4cfc4282a59c 100644
> --- a/drivers/gpu/drm/radeon/radeon_prime.c
> +++ b/drivers/gpu/drm/radeon/radeon_prime.c
> @@ -26,6 +26,7 @@
>   
>   #include <linux/dma-buf.h>
>   
> +#include <drm/drm_gem.h>
>   #include <drm/drm_prime.h>
>   #include <drm/radeon_drm.h>
>   
> @@ -38,8 +39,8 @@ struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *obj)
>   {
>   	struct radeon_bo *bo = gem_to_radeon_bo(obj);
>   
> -	return drm_prime_pages_to_sg(obj->dev, bo->tbo.ttm->pages,
> -				     bo->tbo.ttm->num_pages);
> +	return drm_pages_to_sg(obj->dev, bo->tbo.ttm->pages,
> +			       bo->tbo.ttm->num_pages);
>   }
>   
>   struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_device *dev,
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index b188539dca0b..7897da0becf4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -89,8 +89,8 @@ static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
>   
>   	rk_obj->num_pages = rk_obj->base.size >> PAGE_SHIFT;
>   
> -	rk_obj->sgt = drm_prime_pages_to_sg(rk_obj->base.dev,
> -					    rk_obj->pages, rk_obj->num_pages);
> +	rk_obj->sgt = drm_pages_to_sg(rk_obj->base.dev,
> +				      rk_obj->pages, rk_obj->num_pages);
>   	if (IS_ERR(rk_obj->sgt)) {
>   		ret = PTR_ERR(rk_obj->sgt);
>   		goto err_put_pages;
> @@ -432,7 +432,7 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
>   	int ret;
>   
>   	if (rk_obj->pages)
> -		return drm_prime_pages_to_sg(obj->dev, rk_obj->pages, rk_obj->num_pages);
> +		return drm_pages_to_sg(obj->dev, rk_obj->pages, rk_obj->num_pages);
>   
>   	sgt = kzalloc_obj(*sgt);
>   	if (!sgt)
> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index 436394e04812..701af672b4e5 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -17,7 +17,7 @@
>   
>   #include <drm/drm_drv.h>
>   #include <drm/drm_dumb_buffers.h>
> -#include <drm/drm_prime.h>
> +#include <drm/drm_gem.h>
>   
>   #include "drm.h"
>   #include "gem.h"
> @@ -352,7 +352,7 @@ static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
>   
>   	bo->num_pages = bo->gem.size >> PAGE_SHIFT;
>   
> -	bo->sgt = drm_prime_pages_to_sg(bo->gem.dev, bo->pages, bo->num_pages);
> +	bo->sgt = drm_pages_to_sg(bo->gem.dev, bo->pages, bo->num_pages);
>   	if (IS_ERR(bo->sgt)) {
>   		err = PTR_ERR(bo->sgt);
>   		goto put_pages;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> index 39f8c46550c2..c9e7f2e3668c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> @@ -28,7 +28,7 @@
>   #include "vmwgfx_bo.h"
>   #include "vmwgfx_drv.h"
>   
> -#include "drm/drm_prime.h"
> +#include "drm/drm_gem.h"
>   #include "drm/drm_gem_ttm_helper.h"
>   
>   #include <linux/debugfs.h>
> @@ -76,7 +76,7 @@ static struct sg_table *vmw_gem_object_get_sg_table(struct drm_gem_object *obj)
>   	if (vmw_tt->vsgt.sgt)
>   		return vmw_tt->vsgt.sgt;
>   
> -	return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages, vmw_tt->dma_ttm.num_pages);
> +	return drm_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages, vmw_tt->dma_ttm.num_pages);
>   }
>   
>   static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 8a920e58245c..f0fe80706b79 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -118,9 +118,9 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
>   
>   	switch (bo->ttm.resource->mem_type) {
>   	case XE_PL_TT:
> -		sgt = drm_prime_pages_to_sg(obj->dev,
> -					    bo->ttm.ttm->pages,
> -					    obj->size >> PAGE_SHIFT);
> +		sgt = drm_pages_to_sg(obj->dev,
> +				      bo->ttm.ttm->pages,
> +				      obj->size >> PAGE_SHIFT);
>   		if (IS_ERR(sgt))
>   			return sgt;
>   
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> index eec4c1da3f9e..a4a7c7f2c91c 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> @@ -236,7 +236,7 @@ struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
>   	if (!xen_obj->pages)
>   		return ERR_PTR(-ENOMEM);
>   
> -	return drm_prime_pages_to_sg(gem_obj->dev,
> +	return drm_pages_to_sg(gem_obj->dev,
>   				     xen_obj->pages, xen_obj->num_pages);
>   }
>   
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 885244e375d3..7b9cc6335689 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -155,7 +155,7 @@ struct drm_gem_object_funcs {
>   	 * here cannot be used for sg tables pointing at driver private memory
>   	 * ranges.
>   	 *
> -	 * See also drm_prime_pages_to_sg().
> +	 * See also drm_pages_to_sg().
>   	 */
>   	struct sg_table *(*get_sg_table)(struct drm_gem_object *obj);
>   
> @@ -589,6 +589,9 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj);
>   void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>   		bool dirty, bool accessed);
>   
> +struct sg_table *drm_pages_to_sg(struct drm_device *dev,
> +				 struct page **pages, unsigned int nr_pages);
> +
>   void drm_gem_lock(struct drm_gem_object *obj);
>   void drm_gem_unlock(struct drm_gem_object *obj);
>   
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index f50f862f0d8b..603e16a40ae7 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -92,8 +92,6 @@ void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map);
>   int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
>   int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma);
>   
> -struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
> -				       struct page **pages, unsigned int nr_pages);
>   struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>   				     int flags);
>   
>
> ---
> base-commit: 48dd37d1fef33fbf42f1d6887c61e242fd21d00d
> change-id: 20260724-get_pages-e2e91c53eaa3
>
> Best regards,
> --
> Adrián Larumbe <adrian.larumbe@collabora.com>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


