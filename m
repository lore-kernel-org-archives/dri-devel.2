Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90676CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E393110E3B2;
	Thu,  1 Oct 2026 13:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W2mf+C2S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFB710E3B2
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790863071; x=1822399071;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=d7v26iQFTdiIcal9H6M1hydLOF69IvlhXeSIwe7CQ+I=;
 b=W2mf+C2S9khUr9fcHtM1X4nZJsr4+FxhwXEyqshaw7sp860xRVJZ7Fuz
 kZLBliDGiQsAhWeykXZWP4xoEtpxwiCdWjGoljCKtUiLH4s3/XPw4enaL
 NctQyV9GHNt+nvLMzho89SM3Hf8czeD+AehtDJ4hH5FS/ypiGGeyN9MsM
 aDeRTAQxvgONpqUe8YzcvXCrm/PPshSZs3eJogrl3kbLNgy7EXowbyGJF
 lS1ZvK6ohdBTbBmpLCLk9V48gV+FLZzlhCAvFaTUp31idJoErhdP+JnUq
 1KKKmKDa6tGkmrM6/vXS2SVb7bYPmRxyyMszGOwdUmXzroNaKxHJ2FA9y g==;
X-CSE-ConnectionGUID: FC493PKUS+2li/mqIvttVg==
X-CSE-MsgGUID: Dr/bAieKT8GljKwRn4Mtiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91639267"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="91639267"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 06:57:50 -0700
X-CSE-ConnectionGUID: esJu5ho+TvSQoC6a+Q87Dw==
X-CSE-MsgGUID: gdfB//qtTX+exdKnH/z9Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="279303180"
Received: from unknown (HELO [10.94.255.201]) ([10.94.255.201])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 06:57:48 -0700
Message-ID: <37a282ab-2d39-467f-8cb0-eb099a3ea0b5@linux.intel.com>
Date: Thu, 1 Oct 2026 15:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] accel/ivpu: Improve HW IP gen and buttress version
 checks
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
 <20261001110401.2866557-2-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20261001110401.2866557-2-dawid.osuchowski@linux.intel.com>
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

On 01-Oct-26 13:03, Dawid Osuchowski wrote:
> From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Remove the per-call switch in ivpu_hw_ip_gen()/ivpu_hw_btrs_gen() and
> instead initialize the HW IP generation and buttress version once during
> device init.
> 
> Fail probe with -EINVAL when the PCI device ID does not match any known
> generation, instead of warning and continuing with both fields left at 0,
> so callers never proceed with an unrecognized generation.
> 
> Drop hw->dma_bits and compute it locally to remove the early dependency
> on vdev->hw_ip_gen.
> 
> Make pwr_island_delay_set() use ivpu_hw_ip_gen() instead of the PCI
> device ID directly.
> 
> Move MODULE_DEVICE_TABLE() to the top of the file to colocate it with
> the HW IP and buttress detection logic.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.c   | 69 +++++++++++++++++++++++++--------
>   drivers/accel/ivpu/ivpu_drv.h   | 41 +++++---------------
>   drivers/accel/ivpu/ivpu_hw.h    |  1 -
>   drivers/accel/ivpu/ivpu_hw_ip.c | 18 +++------
>   4 files changed, 67 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 0f215392d42d..ab1a9448c2cc 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -67,6 +67,48 @@ bool ivpu_force_snoop;
>   module_param_named(force_snoop, ivpu_force_snoop, bool, 0444);
>   MODULE_PARM_DESC(force_snoop, "Force snooping for NPU host memory access");
>   
> +static struct pci_device_id ivpu_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_MTL) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_ARL) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_LNL) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PTL) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_WCL) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_NVL) },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, ivpu_pci_ids);
> +
> +static int ivpu_ip_gen_init(struct ivpu_device *vdev)
> +{
> +	vdev->platform = IVPU_PLATFORM_INVALID;
> +
> +	switch (ivpu_device_id(vdev)) {
> +	case PCI_DEVICE_ID_MTL:
> +	case PCI_DEVICE_ID_ARL:
> +		vdev->hw_ip_gen = IVPU_HW_IP_37XX;
> +		vdev->btrs_gen = IVPU_HW_BTRS_MTL;
> +		break;
> +	case PCI_DEVICE_ID_LNL:
> +		vdev->hw_ip_gen = IVPU_HW_IP_40XX;
> +		vdev->btrs_gen = IVPU_HW_BTRS_LNL;
> +		break;
> +	case PCI_DEVICE_ID_PTL:
> +	case PCI_DEVICE_ID_WCL:
> +		vdev->hw_ip_gen = IVPU_HW_IP_50XX;
> +		vdev->btrs_gen = IVPU_HW_BTRS_LNL;
> +		break;
> +	case PCI_DEVICE_ID_NVL:
> +		vdev->hw_ip_gen = IVPU_HW_IP_60XX;
> +		vdev->btrs_gen = IVPU_HW_BTRS_LNL;
> +		break;
> +	default:
> +		ivpu_err(vdev, "Unknown PCI device [%04x:%04x]\n", ivpu_vendor_id(vdev),
> +			 ivpu_device_id(vdev));
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>   static struct ivpu_user_limits *ivpu_user_limits_alloc(struct ivpu_device *vdev, uid_t uid)
>   {
>   	struct ivpu_user_limits *limits;
> @@ -649,6 +691,7 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
>   	struct pci_dev *pdev = to_pci_dev(vdev->drm.dev);
>   	struct resource *bar0 = &pdev->resource[0];
>   	struct resource *bar4 = &pdev->resource[4];
> +	int dma_bits;
>   	int ret;
>   
>   	ivpu_dbg(vdev, MISC, "Mapping BAR0 (RegV) %pR\n", bar0);
> @@ -665,7 +708,12 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
>   		return PTR_ERR(vdev->regb);
>   	}
>   
> -	ret = dma_set_mask_and_coherent(vdev->drm.dev, DMA_BIT_MASK(vdev->hw->dma_bits));
> +	if (ivpu_hw_ip_gen(vdev) >= IVPU_HW_IP_40XX)
> +		dma_bits = 48;
> +	else
> +		dma_bits = 38;
> +
> +	ret = dma_set_mask_and_coherent(vdev->drm.dev, DMA_BIT_MASK(dma_bits));
>   	if (ret) {
>   		ivpu_err(vdev, "Failed to set DMA mask: %d\n", ret);
>   		return ret;
> @@ -713,12 +761,10 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
>   	if (!vdev->pm)
>   		return -ENOMEM;
>   
> -	if (ivpu_hw_ip_gen(vdev) >= IVPU_HW_IP_40XX)
> -		vdev->hw->dma_bits = 48;
> -	else
> -		vdev->hw->dma_bits = 38;
> +	ret = ivpu_ip_gen_init(vdev);
> +	if (ret)
> +		return ret;
>   
> -	vdev->platform = IVPU_PLATFORM_INVALID;
>   	vdev->context_xa_limit.min = IVPU_USER_CONTEXT_MIN_SSID;
>   	vdev->context_xa_limit.max = IVPU_USER_CONTEXT_MAX_SSID;
>   	atomic64_set(&vdev->unique_id_counter, 0);
> @@ -851,17 +897,6 @@ static void ivpu_dev_fini(struct ivpu_device *vdev)
>   	xa_destroy(&vdev->context_xa);
>   }
>   
> -static struct pci_device_id ivpu_pci_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_MTL) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_ARL) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_LNL) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PTL_P) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_WCL) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_NVL) },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(pci, ivpu_pci_ids);
> -
>   static int ivpu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct ivpu_device *vdev;
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index 3b26a64ed04f..87953d0474fb 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -27,7 +27,7 @@
>   #define PCI_DEVICE_ID_MTL	0x7d1d
>   #define PCI_DEVICE_ID_ARL	0xad1d
>   #define PCI_DEVICE_ID_LNL	0x643e
> -#define PCI_DEVICE_ID_PTL_P	0xb03e
> +#define PCI_DEVICE_ID_PTL	0xb03e
>   #define PCI_DEVICE_ID_WCL	0xfd3e
>   #define PCI_DEVICE_ID_NVL	0xd71d
>   
> @@ -136,6 +136,8 @@ struct ivpu_device {
>   	struct drm_device drm;
>   	void __iomem *regb;
>   	void __iomem *regv;
> +	u32 hw_ip_gen;
> +	u32 btrs_gen;
>   	u32 platform;
>   	u32 irq;
>   
> @@ -247,6 +249,11 @@ static inline u8 ivpu_revision(struct ivpu_device *vdev)
>   	return to_pci_dev(vdev->drm.dev)->revision;
>   }
>   
> +static inline u16 ivpu_vendor_id(struct ivpu_device *vdev)
> +{
> +	return to_pci_dev(vdev->drm.dev)->vendor;
> +}
> +
>   static inline u16 ivpu_device_id(struct ivpu_device *vdev)
>   {
>   	return to_pci_dev(vdev->drm.dev)->device;
> @@ -254,40 +261,12 @@ static inline u16 ivpu_device_id(struct ivpu_device *vdev)
>   
>   static inline int ivpu_hw_ip_gen(struct ivpu_device *vdev)
>   {
> -	switch (ivpu_device_id(vdev)) {
> -	case PCI_DEVICE_ID_MTL:
> -	case PCI_DEVICE_ID_ARL:
> -		return IVPU_HW_IP_37XX;
> -	case PCI_DEVICE_ID_LNL:
> -		return IVPU_HW_IP_40XX;
> -	case PCI_DEVICE_ID_PTL_P:
> -	case PCI_DEVICE_ID_WCL:
> -		return IVPU_HW_IP_50XX;
> -	case PCI_DEVICE_ID_NVL:
> -		return IVPU_HW_IP_60XX;
> -	default:
> -		dump_stack();
> -		ivpu_err(vdev, "Unknown NPU IP generation\n");
> -		return 0;
> -	}
> +	return vdev->hw_ip_gen;
>   }
>   
>   static inline int ivpu_hw_btrs_gen(struct ivpu_device *vdev)
>   {
> -	switch (ivpu_device_id(vdev)) {
> -	case PCI_DEVICE_ID_MTL:
> -	case PCI_DEVICE_ID_ARL:
> -		return IVPU_HW_BTRS_MTL;
> -	case PCI_DEVICE_ID_LNL:
> -	case PCI_DEVICE_ID_PTL_P:
> -	case PCI_DEVICE_ID_WCL:
> -	case PCI_DEVICE_ID_NVL:
> -		return IVPU_HW_BTRS_LNL;
> -	default:
> -		dump_stack();
> -		ivpu_err(vdev, "Unknown buttress generation\n");
> -		return 0;
> -	}
> +	return vdev->btrs_gen;
>   }
>   
>   static inline struct ivpu_device *to_ivpu_device(struct drm_device *dev)
> diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
> index 487a918e2fa9..11717ffe738c 100644
> --- a/drivers/accel/ivpu/ivpu_hw.h
> +++ b/drivers/accel/ivpu/ivpu_hw.h
> @@ -49,7 +49,6 @@ struct ivpu_hw_info {
>   	u32 tile_fuse;
>   	u32 sku;
>   	u16 config;
> -	int dma_bits;
>   	ktime_t d0i3_entry_host_ts;
>   	u64 d0i3_entry_vpu_ts;
>   	atomic_t firewall_irq_counter;
> diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
> index 46661fbf9d05..c604c1c37e99 100644
> --- a/drivers/accel/ivpu/ivpu_hw_ip.c
> +++ b/drivers/accel/ivpu/ivpu_hw_ip.c
> @@ -678,29 +678,21 @@ static void pwr_island_delay_set(struct ivpu_device *vdev)
>   	bool high = vdev->hw->pll.profiling_freq == PLL_PROFILING_FREQ_HIGH;
>   	u32 post, post1, post2, status;
>   
> -	if (ivpu_hw_ip_gen(vdev) < IVPU_HW_IP_50XX)
> +	switch (ivpu_hw_ip_gen(vdev)) {
> +	case IVPU_HW_IP_37XX:
> +	case IVPU_HW_IP_40XX:
>   		return;
> -
> -	switch (ivpu_device_id(vdev)) {
> -	case PCI_DEVICE_ID_WCL:
> -	case PCI_DEVICE_ID_PTL_P:
> +	case IVPU_HW_IP_50XX:
>   		post = high ? 18 : 0;
>   		post1 = 0;
>   		post2 = 0;
>   		status = high ? 46 : 3;
>   		break;
> -
> -	case PCI_DEVICE_ID_NVL:
> +	default:
>   		post = high ? 198 : 17;
>   		post1 = 0;
>   		post2 = high ? 198 : 17;
>   		status = 0;
> -		break;
> -
> -	default:
> -		dump_stack();
> -		ivpu_err(vdev, "Unknown device ID\n");
> -		return;
>   	}
>   
>   	pwr_island_delay_set_50xx(vdev, post, post1, post2, status);

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

