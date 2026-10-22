Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40758606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Mc9J8ya/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D3E11253E;
	Thu, 22 Oct 2026 12:17:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 494E711253E
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:17:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DE2D2C41
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 05:16:56 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 8E2673F7B4
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792671419; bh=iNNPWrLLhrInRpAMKQhmWTnUnRz/l8TgFGAx7zKoFqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mc9J8ya/ccRzm7cX1oNKVvqUZZlDAc2Df25TsLTHEKuf7q3Le8DWN3eGxk25ljFRl
 7+Xc2lbBwgG4eU7t/lDemXIzalI8T2DAWLDf7RV2XA7scHdK6AI2GNXdP5+VV990UH
 k8DPo2GWXGe+U7iYOgd1oSEHFMRTCtQr3YJpsolw=
Date: Thu, 22 Oct 2026 13:16:48 +0100
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
Subject: Re: [PATCH v7 2/8] drm/panthor: Add register definitions for perf
Message-ID: <atn-sGozr05TmZKu@e142607>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-2-12c32495062f@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011-panthor-performance-counters-v7-2-12c32495062f@arm.com>
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

On Sun, Oct 11, 2026 at 06:36:49PM +0100, Lukas Zapolskas wrote:
> The perfcnt_size register, needed to size the FW-side ring buffer, is
> comprised out of two fields, FIRMWARE_SIZE and HARDWARE_SIZE, indicating
> the size of the corresponding components of a single sample. The total
> size of a single sample in that ring buffer is the sum of the two.
> 
> The perfcnt_config register configures the size of the ring buffer, the
> counter set requested by the user, and whether the optional metadata block
> is required.
> 
> For newer FW revisions, the perfcnt_features register reports the
> presence of an optional metadata block.
> 
> GPUs with arch major 11 or greater also report the number of performance
> counters in a single counter block via the GPU_PRFCNT_FEATURES.
> 
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_fw.h       | 9 ++++++++-
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h | 4 ++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index a99a9b6f4825..124e2b40b15f 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -198,8 +198,12 @@ struct panthor_fw_global_control_iface {
>  	u32 output_va;
>  	u32 group_num;
>  	u32 group_stride;
> +#define GLB_PERFCNT_FW_SIZE(x) ((((x) >> 16) << 8))
> +#define GLB_PERFCNT_HW_SIZE(x) (((x) & GENMASK(15, 0)) << 8)
>  	u32 perfcnt_size;
>  	u32 instr_features;
> +#define PERFCNT_FEATURES_MD_SIZE(x) (((x) & GENMASK(3, 0)) << 8)
> +	u32 perfcnt_features;
>  };
>  
>  struct panthor_fw_global_input_iface {
> @@ -208,7 +212,7 @@ struct panthor_fw_global_input_iface {
>  #define GLB_CFG_ALLOC_EN			BIT(2)
>  #define GLB_CFG_POWEROFF_TIMER			BIT(3)
>  #define GLB_PROTM_ENTER				BIT(4)
> -#define GLB_PERFCNT_EN				BIT(5)
> +#define GLB_PERFCNT_ENABLE			BIT(5)
>  #define GLB_PERFCNT_SAMPLE			BIT(6)
>  #define GLB_COUNTER_EN				BIT(7)
>  #define GLB_PING				BIT(8)
> @@ -248,6 +252,9 @@ struct panthor_fw_global_input_iface {
>  	u64 perfcnt_base;
>  	u32 perfcnt_extract;
>  	u32 reserved3[3];
> +#define GLB_PERFCNT_CONFIG_SIZE(x) ((x) & GENMASK(7, 0))
> +#define GLB_PERFCNT_CONFIG_SET(x) (((x) & GENMASK(1, 0)) << 8)
> +#define GLB_PERFCNT_METADATA_ENABLE BIT(10)
>  	u32 perfcnt_config;
>  	u32 perfcnt_csg_select;
>  	u32 perfcnt_fw_enable;
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index 4c5b953796e4..2f0877068e44 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> @@ -23,6 +23,7 @@
>  #define GPU_TILER_FEATURES				0xC
>  #define GPU_MEM_FEATURES				0x10
>  #define   GROUPS_L2_COHERENT				BIT(0)
> +#define   GPU_MEM_FEATURES_L2_SLICES(x)			((((x) & GENMASK(11, 8)) >> 8) + 1)
>  
>  #define GPU_MMU_FEATURES				0x14
>  #define  GPU_MMU_FEATURES_VA_BITS(x)			((x) & GENMASK(7, 0))
> @@ -69,6 +70,9 @@
>  #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
>  #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
>  
> +#define GPU_PRFCNT_FEATURES				0x68
> +#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
> +
>  #define GPU_TIMESTAMP_OFFSET				0x88
>  #define GPU_CYCLE_COUNT					0x90
>  #define GPU_TIMESTAMP					0x98
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
