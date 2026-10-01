Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B23CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DDC810F5C0;
	Thu,  1 Oct 2026 07:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hPqrST1l";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574EF10F5C0
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790840696; x=1822376696;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=G08Na7UTKGRH5/549OBd1VB7wTVdtemrarq6HS5OcUM=;
 b=hPqrST1lMuGqlLU7po/cWqpbOVLAa8REUGuvh7ePUE5XGjTw+P+mlo9z
 exZkd+eVe55Fnj6a8TueAwoUELe5jzpuy8oIBTKrSN+Fenrz1S+eGEPGh
 rrkzd36dBn56HwgDuFXLPGK4EVhbcIUHOkh2Fgu/MSPL0fiIa5b+Rw0om
 3Ebqe/+Vh61wkjFF3aFydveP6k0dzMrUbv3N70ktcrgdY9gmMivOka3km
 jKzN+XF0UGBM5oz9mXwiyHfq+RB6RdeONo5oQMul4S9IgU5++wfXQiD87
 EIF1TYn9noiD8d7U3KIrlULrk7q4xBlVBukZF8PUyzNFkVR9UlbCwNdpb A==;
X-CSE-ConnectionGUID: 6IFzlO1yQ9OtjRqSY9l+QQ==
X-CSE-MsgGUID: UZttNx/jRfGsCK2ySyneYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="107971948"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="107971948"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:44:56 -0700
X-CSE-ConnectionGUID: wmShosyrR6i1G4NnWYw3Hw==
X-CSE-MsgGUID: EzLFEzsTQiqs+W9nkUSLlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="283981556"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:44:54 -0700
Message-ID: <b24a13be-1642-4e94-a27f-ea40dc992606@linux.intel.com>
Date: Thu, 1 Oct 2026 09:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Drop MTL interrupt clear-with-zero workaround
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com
References: <20260930160348.1562800-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260930160348.1562800-1-andrzej.kacprowski@linux.intel.com>
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

On 30-Sep-26 18:03, Andrzej Kacprowski wrote:
> Early MTL steppings needed a runtime check for BTRS interrupt status
> registers that cleared by writing 0 instead of the usual write-1-to-clear
> flow.
> 
> Those pre-production steppings are no longer supported. Remove the
> workaround flag, probe helper, and conditional IRQ clear path, and always
> clear handled MTL BTRS interrupt status bits by writing the interrupt
> status value.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.h     |  1 -
>   drivers/accel/ivpu/ivpu_hw.c      |  4 ----
>   drivers/accel/ivpu/ivpu_hw_btrs.c | 24 +-----------------------
>   drivers/accel/ivpu/ivpu_hw_btrs.h |  1 -
>   4 files changed, 1 insertion(+), 29 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index 86d7c9966cac..210f723cf251 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -110,7 +110,6 @@
>   struct ivpu_wa_table {
>   	bool punit_disabled;
>   	bool clear_runtime_mem;
> -	bool interrupt_clear_with_0;
>   	bool disable_clock_relinquish;
>   	bool wp0_during_power_up;
>   	bool disable_d0i2;
> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
> index 647dc045c231..c039eee501ae 100644
> --- a/drivers/accel/ivpu/ivpu_hw.c
> +++ b/drivers/accel/ivpu/ivpu_hw.c
> @@ -67,9 +67,6 @@ static void wa_init(struct ivpu_device *vdev)
>   	vdev->wa.punit_disabled = false;
>   	vdev->wa.clear_runtime_mem = false;
>   
> -	if (ivpu_hw_btrs_gen(vdev) == IVPU_HW_BTRS_MTL)
> -		vdev->wa.interrupt_clear_with_0 = ivpu_hw_btrs_irqs_clear_with_0_mtl(vdev);
> -
>   	if ((ivpu_device_id(vdev) == PCI_DEVICE_ID_LNL &&
>   	     ivpu_revision(vdev) < IVPU_HW_IP_REV_LNL_B0) ||
>   	    (ivpu_device_id(vdev) == PCI_DEVICE_ID_NVL &&
> @@ -90,7 +87,6 @@ static void wa_init(struct ivpu_device *vdev)
>   
>   	IVPU_PRINT_WA(punit_disabled);
>   	IVPU_PRINT_WA(clear_runtime_mem);
> -	IVPU_PRINT_WA(interrupt_clear_with_0);
>   	IVPU_PRINT_WA(disable_clock_relinquish);
>   	IVPU_PRINT_WA(wp0_during_power_up);
>   	IVPU_PRINT_WA(disable_d0i2);
> diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
> index a17c829adb89..2f4f5156d62e 100644
> --- a/drivers/accel/ivpu/ivpu_hw_btrs.c
> +++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
> @@ -24,9 +24,6 @@
>   			   (REG_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, IMR1_ERR)) | \
>   			   (REG_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, SURV_ERR)))
>   
> -#define BTRS_MTL_ALL_IRQ_MASK (BTRS_MTL_IRQ_MASK | (REG_FLD(VPU_HW_BTRS_MTL_INTERRUPT_STAT, \
> -			       FREQ_CHANGE)))
> -
>   #define BTRS_IRQ_DISABLE_MASK ((u32)-1)
>   
>   #define BTRS_LNL_ALL_IRQ_MASK ((u32)-1)
> @@ -59,18 +56,6 @@
>   #define DCT_ENABLE                     0x1
>   #define DCT_DISABLE                    0x0
>   
> -int ivpu_hw_btrs_irqs_clear_with_0_mtl(struct ivpu_device *vdev)
> -{
> -	REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, BTRS_MTL_ALL_IRQ_MASK);
> -	if (REGB_RD32(VPU_HW_BTRS_MTL_INTERRUPT_STAT) == BTRS_MTL_ALL_IRQ_MASK) {
> -		/* Writing 1s does not clear the interrupt status register */
> -		REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, 0x0);
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
>   static void freq_ratios_init_mtl(struct ivpu_device *vdev)
>   {
>   	struct ivpu_hw_info *hw = vdev->hw;
> @@ -729,14 +714,7 @@ bool ivpu_hw_btrs_irq_handler_mtl(struct ivpu_device *vdev, int irq)
>   	}
>   
>   	/* This must be done after interrupts are cleared at the source. */
> -	if (IVPU_WA(interrupt_clear_with_0))
> -		/*
> -		 * Writing 1 triggers an interrupt, so we can't perform read update write.
> -		 * Clear local interrupt status by writing 0 to all bits.
> -		 */
> -		REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, 0x0);
> -	else
> -		REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, status);
> +	REGB_WR32(VPU_HW_BTRS_MTL_INTERRUPT_STAT, status);
>   
>   	if (schedule_recovery)
>   		ivpu_pm_trigger_recovery(vdev, "Buttress IRQ");
> diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.h b/drivers/accel/ivpu/ivpu_hw_btrs.h
> index d6343d734570..e545284fcfa2 100644
> --- a/drivers/accel/ivpu/ivpu_hw_btrs.h
> +++ b/drivers/accel/ivpu/ivpu_hw_btrs.h
> @@ -19,7 +19,6 @@
>   
>   int ivpu_hw_btrs_info_init(struct ivpu_device *vdev);
>   void ivpu_hw_btrs_freq_ratios_init(struct ivpu_device *vdev);
> -int ivpu_hw_btrs_irqs_clear_with_0_mtl(struct ivpu_device *vdev);
>   int ivpu_hw_btrs_wp_drive(struct ivpu_device *vdev, bool enable);
>   int ivpu_hw_btrs_wait_for_clock_res_own_ack(struct ivpu_device *vdev);
>   int ivpu_hw_btrs_d0i3_enable(struct ivpu_device *vdev);

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

