Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D02CCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A6710F38C;
	Mon,  8 Jun 2026 13:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QUXng92G";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072DC10F38C
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780924130;
 bh=lQZk1UoBG1cvKh5cmaud+0YxSDw+2jCd4jHtSawxQJI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QUXng92GFK5QCsggmR43GW8wmsH4CtY2EhbrhLIZrOOQVkmKiOPxNvWk69pAefpzu
 nfsG/VmaKIj/Mndac6HOl1EoarE8i0WtiBsCP/g02x2stFip5hsb06hYLrRBM9gcTT
 hOYe9Uk4kEt+YyFHZklQMnvrN6s6qAft0sYpKRjjpprD8VMUAFPFKO9lF/A4Tc3r5v
 KjIjMsSdOtQlhJyC1V+162i8MxRPVUnqlVwEmSH6WJVMPqkwVOHZAV/N5KTB/kS21M
 cCgTtfOh5k24kyjvta/FOtSc0KBtbOAAgbHqrogDzGHSLhq8f+mFgR6Ghcbxj+Jymp
 UIdZkaIShUz4Q==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4FEAA17E0416;
 Mon,  8 Jun 2026 15:08:50 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:08:47 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/18] drm/panthor: Parse and store GPU_ID fields
Message-ID: <20260608150847.5d17711b@fedora-2.home>
In-Reply-To: <20260528150546.3168527-4-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-4-karunika.choo@arm.com>
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

On Thu, 28 May 2026 16:05:31 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> Prepare for Mali v15, where GPU_ID expands to 64 bits and its field
> layout changes.
> 
> Introduce a small panthor_gpu_id structure and parse the GPU_ID fields
> once during hardware initialization. Convert existing users to consume
> the cached fields instead of extracting them repeatedly from the raw
> register value.
> 
> This centralizes GPU_ID decoding and makes it easier to support both the
> existing and v15 formats.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 33 ++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_fw.c     |  4 +--
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  2 +-
>  drivers/gpu/drm/panthor/panthor_hw.c     | 26 +++++++++++++------
>  drivers/gpu/drm/panthor/panthor_hw.h     |  3 +--
>  5 files changed, 55 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index c376e52e8564..8b2a9bb426fc 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -104,6 +104,36 @@ struct panthor_irq {
>  	atomic_t state;
>  };
>  
> +/**
> + * struct panthor_gpu_id - Parsed GPU_ID fields
> + */
> +struct panthor_gpu_id {
> +	struct {
> +		/** @arch.major: Architecture major revision */
> +		u8 major;
> +
> +		/** @arch.minor: Architecture minor revision */
> +		u8 minor;
> +
> +		/** @arch.rev: Architecture patch revision */
> +		u8 rev;
> +	} arch;
> +
> +	/** @prod_major: Product identifier */
> +	u8 prod_major;
> +
> +	struct {
> +		/** @ver.major: Major release version number */
> +		u8 major;
> +
> +		/** @ver.minor: Minor release version number */
> +		u8 minor;
> +
> +		/** @ver.status: Status of GPU release */
> +		u8 status;
> +	} ver;
> +};
> +
>  /**
>   * enum panthor_device_profiling_mode - Profiling state
>   */
> @@ -160,6 +190,9 @@ struct panthor_device {
>  	/** @csif_info: Command stream interface information. */
>  	struct drm_panthor_csif_info csif_info;
>  
> +	/** @gpu_id: Parsed GPU_ID fields */
> +	struct panthor_gpu_id gpu_id;
> +
>  	/** @hw: GPU-specific data. */
>  	struct panthor_hw *hw;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 52f176644aa6..784d0a25beb2 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -799,8 +799,8 @@ static int panthor_fw_load(struct panthor_device *ptdev)
>  	int ret;
>  
>  	snprintf(fw_path, sizeof(fw_path), "arm/mali/arch%d.%d/%s",
> -		 (u32)GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id),
> -		 (u32)GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id),
> +		 (u32)ptdev->gpu_id.arch.major,
> +		 (u32)ptdev->gpu_id.arch.minor,
>  		 CSF_FW_NAME);
>  
>  	ret = request_firmware(&fw, fw_path, ptdev->base.dev);
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index b63a33fe155e..bb5e64188a15 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -74,7 +74,7 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
>  	if (!data || !data->asn_hash_enable)
>  		return;
>  
> -	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
> +	if (ptdev->gpu_id.arch.major < 11) {
>  		drm_err(&ptdev->base, "Custom ASN hash not supported by the device");
>  		return;
>  	}
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 5cf54028f606..3570e2889584 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -120,9 +120,9 @@ void panthor_hw_power_status_unregister(void)
>  
>  static char *get_gpu_model_name(struct panthor_device *ptdev)
>  {
> -	const u32 gpu_id = ptdev->gpu_info.gpu_id;
> -	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
> -						GPU_PROD_MAJOR(gpu_id));
> +	const struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
> +	const u32 product_id = GPU_PROD_ID_MAKE(gpu_id->arch.major,
> +						gpu_id->prod_major);
>  	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
>  					 GPU_FEATURES_RAY_INTERSECTION);
>  	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
> @@ -246,13 +246,13 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> -	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> -	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> -	status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
> +	major = ptdev->gpu_id.ver.major;
> +	minor = ptdev->gpu_id.ver.minor;
> +	status = ptdev->gpu_id.ver.status;
>  
>  	drm_info(&ptdev->base,
>  		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> -		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
> +		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
>  		 major, minor, status);
>  
>  	drm_info(&ptdev->base,
> @@ -274,7 +274,7 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>  static int panthor_hw_bind_device(struct panthor_device *ptdev)
>  {
>  	struct panthor_hw *hdev = NULL;
> -	const u32 arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> +	const u32 arch_major = ptdev->gpu_id.arch.major;
>  	int i = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(panthor_hw_match); i++) {
> @@ -296,10 +296,20 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
>  
>  static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
>  {
> +	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
>  	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
> +
>  	if (!ptdev->gpu_info.gpu_id)
>  		return -ENXIO;
>  
> +	gpu_id->arch.major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->arch.minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->arch.rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
> +	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->ver.major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->ver.minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->ver.status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index f797663893b2..2a666d8cdb98 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -5,7 +5,6 @@
>  #define __PANTHOR_HW_H__
>  
>  #include "panthor_device.h"
> -#include "panthor_gpu_regs.h"
>  
>  /**
>   * struct panthor_hw_ops - HW operations that are specific to a GPU
> @@ -58,7 +57,7 @@ static inline void panthor_hw_l2_power_off(struct panthor_device *ptdev)
>  
>  static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
>  {
> -	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
> +	return ptdev->gpu_id.arch.major >= 14;
>  }
>  
>  #endif /* __PANTHOR_HW_H__ */

