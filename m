Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C537CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF71610E43A;
	Thu,  1 Oct 2026 14:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BNToWPoA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9778810E36F
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790865226; x=1822401226;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4cqVMQ34yWXS7UmbtuEiFN7qqNkZ5z776vO9e4dW+/4=;
 b=BNToWPoAmrNXd4WEuxQvB1yn1K6g4F0Xf6UBeeH4INZZzbIutrsLPQ9d
 Jooh51TjfZ27uT7OMDNCKsdP45y7Qy/awHmqsykjiccX/QExvVabwR2k/
 FJo0J26nn7dEbxJcq22+IptpSRic6zmWVlh7vcpC6dM43cqGAKPL2GI4f
 Od1OJwa4v0TdhlZgjrCidORmdA1uzMd1NnE2FKAtJhzMbWFu/jsUzauE3
 Q1+Mn8UfRGTdbjRgTHzMZDp1n9su2mVnY8/A76hw/t4wvDLaZhHRJoPzY
 OFsHiTVaJazvrWHIpvYBccBOPr5NcTmGlO6SKqppHS73VE4ovYm4RRhFH g==;
X-CSE-ConnectionGUID: RFdzHwbwQvCjJNhomR2nNQ==
X-CSE-MsgGUID: q36ygC8MTLKdhvt4Bgc8Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91722619"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="91722619"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 07:33:45 -0700
X-CSE-ConnectionGUID: +ohxo7QlRN29HVIWbG3m0Q==
X-CSE-MsgGUID: +eoFzYutSeGls1DTLeLvQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="305502884"
Received: from acagidia-mobl1.ger.corp.intel.com (HELO [10.94.248.197])
 ([10.94.248.197])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 07:33:44 -0700
Message-ID: <f5ed524b-4b9b-44de-be6e-b097a8ba1511@linux.intel.com>
Date: Thu, 1 Oct 2026 16:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] accel/ivpu: Convert hw_ip_gen/btrs_gen to enum types
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: karol.wachowski@linux.intel.com
References: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
 <20261001110401.2866557-3-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20261001110401.2866557-3-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 01-Oct-26 1:04 PM, Dawid Osuchowski wrote:
> Change the hw_ip_gen and btrs_gen members of struct ivpu_device, and
> their accessors, from u32/int to enum vpu_hw_ip/enum vpu_hw_btrs, and
> drop the default: labels from the switch statements in ivpu_hw_ip.c
> that dispatch on them. Switching on the real enum types lets the
> compiler treat these switches as exhaustive at compile time, so a
> missing case for a new generation now warns instead of silently
> hitting default:.
> 
> This compile-time guarantee holds because ivpu_ip_gen_init() now fails
> probe on an unrecognized PCI device ID instead of leaving these fields
> at 0, so the switches never see an unhandled value.
> 
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.h   | 28 ++++++++++++++++------------
>   drivers/accel/ivpu/ivpu_hw_ip.c | 14 ++++++++++----
>   2 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index 87953d0474fb..ce9cb118c0c4 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -31,17 +31,9 @@
>   #define PCI_DEVICE_ID_WCL	0xfd3e
>   #define PCI_DEVICE_ID_NVL	0xd71d
>   
> -#define IVPU_HW_IP_37XX 37
> -#define IVPU_HW_IP_40XX 40
> -#define IVPU_HW_IP_50XX 50
> -#define IVPU_HW_IP_60XX 60
> -
>   #define IVPU_HW_IP_REV_LNL_B0 4
>   #define IVPU_HW_IP_REV_NVL_A0 0
>   
> -#define IVPU_HW_BTRS_MTL 1
> -#define IVPU_HW_BTRS_LNL 2
> -
>   #define IVPU_GLOBAL_CONTEXT_MMU_SSID   0
>   /* SSID 1 is used by the VPU to represent reserved context */
>   #define IVPU_RESERVED_CONTEXT_MMU_SSID 1
> @@ -107,6 +99,18 @@
>   		ivpu_dbg(vdev, MISC, "Using WA: " #wa_name "\n");	\
>   } while (0)
>   
> +enum vpu_hw_ip {
> +	IVPU_HW_IP_37XX = 37,
> +	IVPU_HW_IP_40XX = 40,
> +	IVPU_HW_IP_50XX = 50,
> +	IVPU_HW_IP_60XX = 60,
> +};
> +
> +enum vpu_hw_btrs {
> +	IVPU_HW_BTRS_MTL = 1,
> +	IVPU_HW_BTRS_LNL = 2,
> +};
> +
>   struct ivpu_wa_table {
>   	bool punit_disabled;
>   	bool clear_runtime_mem;
> @@ -136,8 +140,8 @@ struct ivpu_device {
>   	struct drm_device drm;
>   	void __iomem *regb;
>   	void __iomem *regv;
> -	u32 hw_ip_gen;
> -	u32 btrs_gen;
> +	enum vpu_hw_ip hw_ip_gen;
> +	enum vpu_hw_btrs btrs_gen;
>   	u32 platform;
>   	u32 irq;
>   
> @@ -259,12 +263,12 @@ static inline u16 ivpu_device_id(struct ivpu_device *vdev)
>   	return to_pci_dev(vdev->drm.dev)->device;
>   }
>   
> -static inline int ivpu_hw_ip_gen(struct ivpu_device *vdev)
> +static inline enum vpu_hw_ip ivpu_hw_ip_gen(struct ivpu_device *vdev)
>   {
>   	return vdev->hw_ip_gen;
>   }
>   
> -static inline int ivpu_hw_btrs_gen(struct ivpu_device *vdev)
> +static inline enum vpu_hw_btrs ivpu_hw_btrs_gen(struct ivpu_device *vdev)
>   {
>   	return vdev->btrs_gen;
>   }
> diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
> index c604c1c37e99..bd6bb3fa49ff 100644
> --- a/drivers/accel/ivpu/ivpu_hw_ip.c
> +++ b/drivers/accel/ivpu/ivpu_hw_ip.c
> @@ -688,7 +688,7 @@ static void pwr_island_delay_set(struct ivpu_device *vdev)
>   		post2 = 0;
>   		status = high ? 46 : 3;
>   		break;
> -	default:
> +	case IVPU_HW_IP_60XX:
>   		post = high ? 198 : 17;
>   		post1 = 0;
>   		post2 = high ? 198 : 17;
> @@ -801,10 +801,15 @@ static void ivpu_hw_ip_tbu_mmu_enable_40xx(struct ivpu_device *vdev)
>   
>   void ivpu_hw_ip_tbu_mmu_enable(struct ivpu_device *vdev)
>   {
> -	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX)
> +	switch (ivpu_hw_ip_gen(vdev)) {
> +	case IVPU_HW_IP_37XX:
>   		return ivpu_hw_ip_tbu_mmu_enable_37xx(vdev);
> -	else
> +
> +	case IVPU_HW_IP_40XX:
> +	case IVPU_HW_IP_50XX:
> +	case IVPU_HW_IP_60XX:
>   		return ivpu_hw_ip_tbu_mmu_enable_40xx(vdev);
> +	}
>   }
>   
>   static inline u64 get_entry_point_addr(struct ivpu_device *vdev)
> @@ -940,8 +945,9 @@ int ivpu_hw_ip_soc_cpu_boot(struct ivpu_device *vdev)
>   		ret = soc_cpu_boot_40xx(vdev);
>   		break;
>   
> -	default:
> +	case IVPU_HW_IP_60XX:
>   		ret = soc_cpu_boot_60xx(vdev);
> +		break;
>   	}
>   
>   	if (ret)
Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
