Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B19C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A2110F3E6;
	Fri, 24 Jul 2026 14:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="PgAWPxYC";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5CE1210F3E6
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:57:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D36871477;
 Fri, 24 Jul 2026 07:57:46 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48343F66F;
 Fri, 24 Jul 2026 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784905070; bh=AuRznZgvnVOZRgTqPVt6/HqFFEYBxJeWl4M5Sa2HuQk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PgAWPxYCiJ87ig9g8AffJSIwam2E2vl2eQTwe0GsxCh6SNG2ZQBJgDIMJpeH6vA0H
 ggRzwcxmP8HrxCLoL+KcGtsgOACAIoNjtGyrXiEgPPJ6k7UBmGp5JyTfESs1RL8I56
 RJB4HaLNrRSfxFBF/ZU6kJVVh+nHIFSVDrkkpLkw=
Message-ID: <f64f9c37-8213-4f40-bd73-d88817defa30@arm.com>
Date: Wed, 22 Jul 2026 16:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/panthor: De-duplicate FW memory section sync
To: Ketil Johnsen <ketil.johnsen@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260712135439.1546950-1-ketil.johnsen@arm.com>
 <20260712135439.1546950-2-ketil.johnsen@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260712135439.1546950-2-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=UTF-8
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

On 12/07/2026 14:54, Ketil Johnsen wrote:
> Handle the sync to device of FW memory sections inside
> panthor_fw_init_section_mem() so that the callers do not have to.
> 
> This small improvement is also critical for protected FW sections,
> so we avoid issuing memory transactions to protected memory from
> CPU running in normal mode.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 986151681b246..389f9182fac16 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -449,6 +449,7 @@ static void panthor_fw_init_section_mem(struct panthor_device *ptdev,
>  					struct panthor_fw_section *section)
>  {
>  	bool was_mapped = !!section->mem->kmap;
> +	struct sg_table *sgt;
>  	int ret;
>  
>  	if (!section->data.size &&
> @@ -467,6 +468,11 @@ static void panthor_fw_init_section_mem(struct panthor_device *ptdev,
>  
>  	if (!was_mapped)
>  		panthor_kernel_bo_vunmap(section->mem);
> +
> +	/* An sgt should have been requested when the kernel BO was GPU-mapped. */
> +	sgt = to_panthor_bo(section->mem->obj)->dmap.sgt;
> +	if (!drm_WARN_ON_ONCE(&ptdev->base, !sgt))
> +		dma_sync_sgtable_for_device(ptdev->base.dev, sgt, DMA_TO_DEVICE);
>  }
>  
>  /**
> @@ -629,7 +635,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  	section_size = hdr.va.end - hdr.va.start;
>  	if (section_size) {
>  		u32 cache_mode = hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
> -		struct panthor_gem_object *bo;
>  		u32 vm_map_flags = 0;
>  		u64 va = hdr.va.start;
>  
> @@ -666,14 +671,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  		}
>  
>  		panthor_fw_init_section_mem(ptdev, section);
> -
> -		bo = to_panthor_bo(section->mem->obj);
> -
> -		/* An sgt should have been requested when the kernel BO was GPU-mapped. */
> -		if (drm_WARN_ON_ONCE(&ptdev->base, !bo->dmap.sgt))
> -			return -EINVAL;
> -
> -		dma_sync_sgtable_for_device(ptdev->base.dev, bo->dmap.sgt, DMA_TO_DEVICE);
>  	}
>  
>  	if (hdr.va.start == CSF_MCU_SHARED_REGION_START)
> @@ -727,17 +724,10 @@ panthor_reload_fw_sections(struct panthor_device *ptdev, bool full_reload)
>  	struct panthor_fw_section *section;
>  
>  	list_for_each_entry(section, &ptdev->fw->sections, node) {
> -		struct sg_table *sgt;
> -
>  		if (!full_reload && !(section->flags & CSF_FW_BINARY_IFACE_ENTRY_WR))
>  			continue;
>  
>  		panthor_fw_init_section_mem(ptdev, section);
> -
> -		/* An sgt should have been requested when the kernel BO was GPU-mapped. */
> -		sgt = to_panthor_bo(section->mem->obj)->dmap.sgt;
> -		if (!drm_WARN_ON_ONCE(&ptdev->base, !sgt))
> -			dma_sync_sgtable_for_device(ptdev->base.dev, sgt, DMA_TO_DEVICE);
>  	}
>  }
>  

