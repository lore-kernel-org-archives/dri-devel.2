Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C0CCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0743510F411;
	Mon,  8 Jun 2026 13:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Y/Mbym9N";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D5410F411
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780927180;
 bh=4KVrLMycKsikXvnvino2QPXXCvoymR4yiO89X6KtzAA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Y/Mbym9NKFHUwPhlbJjf7kZd1EdatfkyAgNmRTqXEfg94CAq33no/JgtljslZgNNf
 vU2LbPE+DZZe4qD8Y2NYO6ojDrKEsSb9dJYbDJcDU+k8YW8TNqdWjNoNmFomKLLEj/
 MSOdk1XQJ/mJUIpzn701m47kvI8ZWZWk3D7wkO0RFmDf/OgSguLbJk5zc+bP9lTNYj
 UXyvTRdWRROcXrUZtMPHMoLCJldPO/xw8Fs65nvYt2bqkcLeJVKL/nTk0oKdlllgQZ
 Fpj/AMt4ZqT9LXKl3aNj/0ZQIvTsRCtSYAxNanzdLCqxt6H1AZAG9IIeVF02bPbIcy
 XWAbjNF+9qZ9Q==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 681CD17E0416;
 Mon,  8 Jun 2026 15:59:40 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:59:33 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/18] drm/panthor: Add Mali v15 hardware support
Message-ID: <20260608155933.080e73b3@fedora-2.home>
In-Reply-To: <20260528150546.3168527-8-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-8-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 28 May 2026 16:05:35 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> @@ -251,12 +279,56 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
>  		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
>  	}
> +}
> +
> +static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
> +{
> +	void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->map.pwr_control_base;
> +	u64 texture_features;
> +
> +	ptdev->gpu_info.gpu_rev_wide = gpu_read64(ptdev->iomem, DISCOVER_REVIDR);
> +	ptdev->gpu_info.l2_features_wide = gpu_read64(ptdev->iomem, DISCOVER_L2_FEATURES);
> +
> +	texture_features = gpu_read64(ptdev->iomem, DISCOVER_TEXTURE_FEATURES);
> +	ptdev->gpu_info.texture_features[0] = lower_32_bits(texture_features);
> +	ptdev->gpu_info.texture_features[1] = upper_32_bits(texture_features);
> +
> +	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, DISCOVER_THREAD_FEATURES);
> +	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, DISCOVER_THREAD_MAX_THREADS);
> +	ptdev->gpu_info.thread_num_active_granularity =
> +		gpu_read(ptdev->iomem, DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY);
> +
> +	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, DISCOVER_GPU_FEATURES);
> +
> +	/* The following _HI registers do not contain any information (yet) */

AFAICT, this is also the case for DISCOVER_GPU_FEATURES.

> +	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, DISCOVER_MEM_FEATURES);
> +	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, DISCOVER_MMU_FEATURES);
> +	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, DISCOVER_AMBA_FEATURES);
> +	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, DISCOVER_TILER_FEATURES);
> +	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, DISCOVER_CORE_FEATURES);
> +
> +	/* AS_PRESENT register removed on v15+ create virtual mask from MMU_FEATURES.AS_COUNT */
> +	ptdev->gpu_info.as_present =
> +		(1U << MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features)) - 1;
> +
> +	ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
> +	ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
> +	ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
> +}
