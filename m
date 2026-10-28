Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF9606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VHXudFNS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AA610E06E;
	Wed, 28 Oct 2026 15:57:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2160410E06E
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 15:57:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 450361756
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:57:43 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 2A3F73F673
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793203066; bh=txQmD3ouPDSBPgZC5W9cfkGiI+1/33A6oWKISoZaYhw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VHXudFNSDE7KuIQzXHdF9yUub3s9hl4PCC9AIvaOBrrFfP7+DWooHWfz1iD6YUSDW
 UH2v/l5g205vbIr1MqewZX3gtf5SF5INtaO5KcNscXvSdZMCtA8A9MwYMg3GFvxsrt
 iLP8FKPQ1b0tEkhwEsCV8sw+E0GoLajE0CiOicxI=
Date: Wed, 28 Oct 2026 15:57:44 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v1 03/27] drm/panthor: Parse and store GPU_ID fields
Message-ID: <auIbeK8uH-ZWRyu-@e142607>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-4-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922204535.2850094-4-karunika.choo@arm.com>
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

On Tue, Sep 22, 2026 at 09:44:57PM +0100, Karunika Choo wrote:
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> v1:
> - changed struct panthor_gpu_id into a flat structure instead of
>   inconsistent groupings.
> 
>  drivers/gpu/drm/panthor/panthor_device.h | 29 ++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_fw.c     |  4 ++--
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  2 +-
>  drivers/gpu/drm/panthor/panthor_hw.c     | 26 ++++++++++++++-------
>  drivers/gpu/drm/panthor/panthor_hw.h     |  3 +--
>  5 files changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 54031c5252473..ba93a100ceda2 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -110,6 +110,32 @@ struct panthor_irq {
>  	enum panthor_irq_state state;
>  };
>  
> +/**
> + * struct panthor_gpu_id - Parsed GPU_ID fields
> + */
> +struct panthor_gpu_id {
> +	/** @arch_major: Architecture major revision */
> +	u8 arch_major;
> +
> +	/** @arch_minor: Architecture minor revision */
> +	u8 arch_minor;
> +
> +	/** @arch_rev: Architecture patch revision */
> +	u8 arch_rev;
> +
> +	/** @prod_major: Product identifier */
> +	u8 prod_major;
> +
> +	/** @ver_major: Major release version number */
> +	u8 ver_major;
> +
> +	/** @ver_minor: Minor release version number */
> +	u8 ver_minor;
> +
> +	/** @ver_status: Status of GPU release */
> +	u8 ver_status;
> +};
> +
>  /**
>   * enum panthor_device_profiling_mode - Profiling state
>   */
> @@ -169,6 +195,9 @@ struct panthor_device {
>  	/** @mmu_info: MMU info */
>  	struct drm_panthor_mmu_info mmu_info;
>  
> +	/** @gpu_id: Parsed GPU_ID fields */
> +	struct panthor_gpu_id gpu_id;
> +
>  	/** @hw: GPU-specific data. */
>  	struct panthor_hw *hw;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 4f1fab66a13bf..13efed3a2ea72 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -809,8 +809,8 @@ static int panthor_fw_load(struct panthor_device *ptdev)
>  	int ret;
>  
>  	snprintf(fw_path, sizeof(fw_path), "arm/mali/arch%d.%d/%s",
> -		 (u32)GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id),
> -		 (u32)GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id),
> +		 (u32)ptdev->gpu_id.arch_major,
> +		 (u32)ptdev->gpu_id.arch_minor,
>  		 CSF_FW_NAME);
>  
>  	ret = request_firmware(&fw, fw_path, ptdev->base.dev);
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index a383b04f101ed..ade2646e2caf6 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -73,7 +73,7 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
>  	if (!data || !data->asn_hash_enable)
>  		return;
>  
> -	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
> +	if (ptdev->gpu_id.arch_major < 11) {
>  		drm_err(&ptdev->base, "Custom ASN hash not supported by the device");
>  		return;
>  	}
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 4c96573b649a1..2143e57d48106 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -119,9 +119,9 @@ void panthor_hw_power_status_unregister(void)
>  
>  static char *get_gpu_model_name(struct panthor_device *ptdev)
>  {
> -	const u32 gpu_id = ptdev->gpu_info.gpu_id;
> -	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
> -						GPU_PROD_MAJOR(gpu_id));
> +	const struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
> +	const u32 product_id = GPU_PROD_ID_MAKE(gpu_id->arch_major,
> +						gpu_id->prod_major);
>  	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
>  					 GPU_FEATURES_RAY_INTERSECTION);
>  	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
> @@ -245,13 +245,13 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> -	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> -	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> -	status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
> +	major = ptdev->gpu_id.ver_major;
> +	minor = ptdev->gpu_id.ver_minor;
> +	status = ptdev->gpu_id.ver_status;
>  
>  	drm_info(&ptdev->base,
>  		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> -		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
> +		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
>  		 major, minor, status);
>  
>  	drm_info(&ptdev->base,
> @@ -273,7 +273,7 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>  static int panthor_hw_bind_device(struct panthor_device *ptdev)
>  {
>  	struct panthor_hw *hdev = NULL;
> -	const u32 arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> +	const u32 arch_major = ptdev->gpu_id.arch_major;
>  	int i = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(panthor_hw_match); i++) {
> @@ -295,10 +295,20 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
>  
>  static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
>  {
> +	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
>  	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
> +
>  	if (!ptdev->gpu_info.gpu_id)
>  		return -ENXIO;
>  
> +	gpu_id->arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->arch_minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->arch_rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
> +	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->ver_major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->ver_minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> +	gpu_id->ver_status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index f797663893b2d..bdda3b10e660a 100644
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
> +	return ptdev->gpu_id.arch_major >= 14;
>  }
>  
>  #endif /* __PANTHOR_HW_H__ */
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
