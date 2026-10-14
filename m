Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03968CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3732D10E2F0;
	Wed, 14 Oct 2026 11:07:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE2410FD0C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791976044; x=1823512044;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=e5rdTj8iGHnSzZxo3004l8PqTSTYcENe5B4npAgXTls=;
 b=nsF7HiJA8k/kU/da9sq2opV79K4jvuIhbYXOCnSi3155Ob8OFwHLvtjk
 aJ1+d0AE9yhblOPMm8/kikTe97+OZUK3ZpQNKLjUEeFG17nf4Bp2Bp80x
 C9tlwSMKtT19SdjKhwIzIkedBYOc/UwvwH/M8H222d1aFN5424klYc11h
 sEPrznql/TYNrHHJ5ueX1OzYQvrwcapMUOO1eknfFQdN6f9QfTSIGD86i
 lb8FV3vRcEZUAqJyG2T1hIDB1ZMhp/UfEj6GYtCUaXg9SqKRUncrv7Hxm
 cKFwbf70wWfjZop2XAyKkaqijzVwz9iSFT/cLmhwxnQeox7kjJ95B7ebu Q==;
X-CSE-ConnectionGUID: szjB1G+yQSmQOohZ5oT/nQ==
X-CSE-MsgGUID: fCUFRCJlRJmU6Ni+MBpn8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="816894"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="816894"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 04:07:24 -0700
X-CSE-ConnectionGUID: NR6afPNTRlmdC089An9U0A==
X-CSE-MsgGUID: xX25/tx6SnKQo+WurodRWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1613069"
Received: from unknown (HELO [10.94.255.201]) ([10.94.255.201])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 04:07:22 -0700
Message-ID: <b5b65d68-ab34-4589-b40b-6cf59d0c8d48@linux.intel.com>
Date: Wed, 14 Oct 2026 13:07:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Load firmware on cold boot
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com
References: <20261014101545.3298558-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20261014101545.3298558-1-andrzej.kacprowski@linux.intel.com>
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

On 14-Oct-26 12:15, Andrzej Kacprowski wrote:
> Load the firmware image immediately before each cold boot
> instead of during probe or cold-boot preparation.
> This moves image loading to a single call site
> and aligns code for future driver changes.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

> ---
>   drivers/accel/ivpu/ivpu_drv.c | 8 ++++++++
>   drivers/accel/ivpu/ivpu_fw.c  | 5 ++---
>   drivers/accel/ivpu/ivpu_fw.h  | 2 +-
>   drivers/accel/ivpu/ivpu_pm.c  | 1 -
>   4 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index ada18a36caef..61149b7c30c2 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -520,6 +520,14 @@ int ivpu_boot(struct ivpu_device *vdev)
>   	ivpu_fw_boot_params_setup(vdev, ivpu_bo_vaddr(vdev->fw->mem_bp));
>   	vdev->fw->last_boot_mode = vdev->fw->next_boot_mode;
>   
> +	if (!ivpu_fw_is_warm_boot(vdev)) {
> +		ret = ivpu_fw_load(vdev);
> +		if (ret) {
> +			ivpu_err(vdev, "Failed to load the firmware: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>   	ret = ivpu_hw_boot_fw(vdev);
>   	if (ret) {
>   		ivpu_err(vdev, "Failed to start the firmware: %d\n", ret);
> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index 71ac0a861935..96f5be23a867 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
> @@ -473,8 +473,6 @@ int ivpu_fw_init(struct ivpu_device *vdev)
>   	if (ret)
>   		goto err_fw_release;
>   
> -	ivpu_fw_load(vdev);
> -
>   	return 0;
>   
>   err_fw_release:
> @@ -488,7 +486,7 @@ void ivpu_fw_fini(struct ivpu_device *vdev)
>   	ivpu_fw_release(vdev);
>   }
>   
> -void ivpu_fw_load(struct ivpu_device *vdev)
> +int ivpu_fw_load(struct ivpu_device *vdev)
>   {
>   	struct ivpu_fw_info *fw = vdev->fw;
>   	u64 image_end_offset = fw->image_load_offset + fw->image_size;
> @@ -505,6 +503,7 @@ void ivpu_fw_load(struct ivpu_device *vdev)
>   	}
>   
>   	wmb(); /* Flush WC buffers after writing fw->mem */
> +	return 0;
>   }
>   
>   static void ivpu_fw_boot_params_print(struct ivpu_device *vdev, struct vpu_boot_params *boot_params)
> diff --git a/drivers/accel/ivpu/ivpu_fw.h b/drivers/accel/ivpu/ivpu_fw.h
> index e7045b47dfaf..45a705431f22 100644
> --- a/drivers/accel/ivpu/ivpu_fw.h
> +++ b/drivers/accel/ivpu/ivpu_fw.h
> @@ -55,7 +55,7 @@ struct ivpu_fw_info {
>   bool ivpu_is_within_range(u64 addr, size_t size, struct ivpu_addr_range *range);
>   int ivpu_fw_init(struct ivpu_device *vdev);
>   void ivpu_fw_fini(struct ivpu_device *vdev);
> -void ivpu_fw_load(struct ivpu_device *vdev);
> +int ivpu_fw_load(struct ivpu_device *vdev);
>   void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params *boot_params);
>   
>   static inline bool ivpu_fw_is_warm_boot(struct ivpu_device *vdev)
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index c1ce8329790e..cd4eff72f76c 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -46,7 +46,6 @@ static void ivpu_pm_prepare_cold_boot(struct ivpu_device *vdev)
>   	ivpu_cmdq_reset_all_contexts(vdev);
>   	ivpu_ipc_reset(vdev);
>   	ivpu_fw_log_reset(vdev);
> -	ivpu_fw_load(vdev);
>   	fw->last_heartbeat = 0;
>   
>   	ivpu_dbg(vdev, FW_BOOT, "Cold boot entry point 0x%llx", vdev->fw->cold_boot_entry_point);

