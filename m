Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D85CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 13:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DF910E642;
	Tue, 26 May 2026 13:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LY/qNWgm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E1D10E63A
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779800589; x=1811336589;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DmrMVPVBRVouVYRBTNpLUvPwxMwv4Fk4XoqfcqhDqI8=;
 b=LY/qNWgmj0lEMa4rmPa7+idfBg6iit/HOkpMh+S9XHw04wLBuR8BMUJK
 S75OhTn9d6iiSfXFCi6TrK3koXo8p96iRj1q7o88Vpeutt/knMhLtV5hL
 srF+eUP+82RCHNAAtcPODS6ge3XfuuwvndMlyaeM663BJg0kwAsnnG7We
 40x2HebZxH9yIgKZcBOTboiUj2ZhZq5cuDYcQa+a5Pv80sgYUB68EXCL5
 fQO86a3lOZAXOMp9S9UjYblz7XFFPvxlaQ1vnrC/h8ozY/VQi37l4Uhnq
 fztRy4SE2j/Nzsca5sDWnUFrHVh6Grdlqo3ZfgljRvf6usfTs9p1wXBQr Q==;
X-CSE-ConnectionGUID: zPaE9RZlSYKiZR6EovOzgA==
X-CSE-MsgGUID: vRoJwjUUR3mLVW3mpTNjNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="106069365"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="106069365"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 06:03:08 -0700
X-CSE-ConnectionGUID: 3G0O2eedQzuhctHhwHqXgQ==
X-CSE-MsgGUID: kqdW99j1QFykhDbmmzwMcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="245951599"
Received: from martanox-mobl.ger.corp.intel.com (HELO [10.94.250.132])
 ([10.94.250.132])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 06:03:07 -0700
Message-ID: <2fc67da7-b1e0-4400-a8ec-dcc4ea3810ca@linux.intel.com>
Date: Tue, 26 May 2026 15:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Remove disable_d0i3_msg workaround
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com
References: <20260526125521.594479-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260526125521.594479-1-andrzej.kacprowski@linux.intel.com>
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

On 26-May-26 14:55, Andrzej Kacprowski wrote:
> All published NPU firmware versions support D0i3 delayed entry
> flow, making this workaround obsolete. It was originally added as
> a safety measure for potential firmware bugs.
> 
> Recent firmware dropped legacy D0i3 entry support, so the workaround
> can't be used anyway. Hardcode d0i3_delayed_entry boot param to 1 to
> ensure older firmware works in the correct mode.
> 
> No functional changes, just dead code cleanup.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

>   drivers/accel/ivpu/ivpu_drv.h     |  3 ---
>   drivers/accel/ivpu/ivpu_fw.c      | 23 ++---------------------
>   drivers/accel/ivpu/ivpu_jsm_msg.c |  3 ---
>   drivers/accel/ivpu/vpu_boot_api.h |  6 ++++--
>   4 files changed, 6 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
> index c77dde310e81..9eefbbb7ba11 100644
> --- a/drivers/accel/ivpu/ivpu_drv.h
> +++ b/drivers/accel/ivpu/ivpu_drv.h
> @@ -111,7 +111,6 @@ struct ivpu_wa_table {
>   	bool clear_runtime_mem;
>   	bool interrupt_clear_with_0;
>   	bool disable_clock_relinquish;
> -	bool disable_d0i3_msg;
>   	bool wp0_during_power_up;
>   	bool disable_d0i2;
>   };
> @@ -220,8 +219,6 @@ extern bool ivpu_force_snoop;
>   #define IVPU_TEST_MODE_FW_TEST            BIT(0)
>   #define IVPU_TEST_MODE_NULL_HW            BIT(1)
>   #define IVPU_TEST_MODE_NULL_SUBMISSION    BIT(2)
> -#define IVPU_TEST_MODE_D0I3_MSG_DISABLE   BIT(4)
> -#define IVPU_TEST_MODE_D0I3_MSG_ENABLE    BIT(5)
>   #define IVPU_TEST_MODE_MIP_DISABLE        BIT(6)
>   #define IVPU_TEST_MODE_DISABLE_TIMEOUTS   BIT(8)
>   #define IVPU_TEST_MODE_TURBO_ENABLE       BIT(9)
> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index 107f8ad31050..7db199e04f7c 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (C) 2020-2025 Intel Corporation
> + * Copyright (C) 2020-2026 Intel Corporation
>    */
>   
>   #include <linux/firmware.h>
> @@ -347,22 +347,6 @@ static void ivpu_fw_release(struct ivpu_device *vdev)
>   	release_firmware(vdev->fw->file);
>   }
>   
> -/* Initialize workarounds that depend on FW version */
> -static void
> -ivpu_fw_init_wa(struct ivpu_device *vdev)
> -{
> -	const struct vpu_firmware_header *fw_hdr = (const void *)vdev->fw->file->data;
> -
> -	if (IVPU_FW_CHECK_API_VER_LT(vdev, fw_hdr, BOOT, 3, 17) ||
> -	    (ivpu_test_mode & IVPU_TEST_MODE_D0I3_MSG_DISABLE))
> -		vdev->wa.disable_d0i3_msg = true;
> -
> -	/* Force enable the feature for testing purposes */
> -	if (ivpu_test_mode & IVPU_TEST_MODE_D0I3_MSG_ENABLE)
> -		vdev->wa.disable_d0i3_msg = false;
> -
> -	IVPU_PRINT_WA(disable_d0i3_msg);
> -}
>   
>   static int ivpu_fw_mem_init(struct ivpu_device *vdev)
>   {
> @@ -480,8 +464,6 @@ int ivpu_fw_init(struct ivpu_device *vdev)
>   	if (ret)
>   		goto err_fw_release;
>   
> -	ivpu_fw_init_wa(vdev);
> -
>   	ret = ivpu_fw_mem_init(vdev);
>   	if (ret)
>   		goto err_fw_release;
> @@ -711,8 +693,7 @@ void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params
>   	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
>   		boot_params->vpu_focus_present_timer_ms = IVPU_FOCUS_PRESENT_TIMER_MS;
>   	boot_params->dvfs_mode = vdev->fw->dvfs_mode;
> -	if (!IVPU_WA(disable_d0i3_msg))
> -		boot_params->d0i3_delayed_entry = 1;
> +	boot_params->d0i3_delayed_entry = 1;
>   	boot_params->d0i3_residency_time_us = 0;
>   	boot_params->d0i3_entry_vpu_ts = 0;
>   	if (IVPU_WA(disable_d0i2))
> diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
> index 17b42a76aef9..6361fe50596e 100644
> --- a/drivers/accel/ivpu/ivpu_jsm_msg.c
> +++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
> @@ -275,9 +275,6 @@ int ivpu_jsm_pwr_d0i3_enter(struct ivpu_device *vdev)
>   	struct vpu_jsm_msg resp;
>   	int ret;
>   
> -	if (IVPU_WA(disable_d0i3_msg))
> -		return 0;
> -
>   	req.payload.pwr_d0i3_enter.send_response = 1;
>   
>   	ret = ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_PWR_D0I3_ENTER_DONE, &resp,
> diff --git a/drivers/accel/ivpu/vpu_boot_api.h b/drivers/accel/ivpu/vpu_boot_api.h
> index a41170bbc6b7..06c092d5e675 100644
> --- a/drivers/accel/ivpu/vpu_boot_api.h
> +++ b/drivers/accel/ivpu/vpu_boot_api.h
> @@ -41,7 +41,7 @@
>   /**
>    * API header changed (field names, documentation, formatting) but API itself has not been changed
>    */
> -#define VPU_BOOT_API_VER_PATCH 4
> +#define VPU_BOOT_API_VER_PATCH 5
>   
>   /**
>    * Index in the API version table
> @@ -320,9 +320,11 @@ struct vpu_boot_params {
>   	u64 dvfs_param;
>   	/**
>   	 * D0i3 delayed entry
> -	 * Bit0: Disable CPU state save on D0i2 entry flow.
> +	 * Bit 0: Disable CPU state save on D0i2 entry flow.
>   	 *       0: Every D0i2 entry saves state. Save state IPC message ignored.
>   	 *       1: IPC message required to save state on D0i3 entry flow.
> +	 * NOTE: This parameter is deprecated starting NPU50xx+. Bit 0 is now hardcoded to 1,
> +	 * meaning CPU state save always requires IPC message on D0i3 entry flow.
>   	 */
>   	u32 d0i3_delayed_entry;
>   	/** Time spent by VPU in D0i3 state */

