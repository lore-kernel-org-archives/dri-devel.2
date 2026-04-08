Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EA2105D9B9
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEAFC10E0E6;
	Wed,  8 Apr 2026 14:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bvi4uoir";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C311C10E095
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775657697; x=1807193697;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=F1Oanl/6JKq5+zqycVJqQqLmfwZAYkq4LkXldQ0lYmI=;
 b=bvi4uoir5l8i6G4BXPDtsKdpiEET/5bWlLd6XMhJvQ2wTBQTOyy8GKwB
 TcfJY6Gmr5k+nFSYlbufdVsHsfreI7ypP0E7qxJJIclMRs8NBBZ42Q1C5
 tMx3cTBWL1lp9Tm19MK/+yuaTnR8B0YEcMB1AU0GkZjg0J7it4/mwMcvt
 JhaeSz6tp3A02N4vQTO+is/K1TIIP9xi+iV7kmvDljClIQSxg3xBStFWu
 O/T2OJ2jj1ysakJsCVLNHK+E9hu3zlYHxibYV6lLeEO36AbIPWwRORTL2
 AFUJpzii1tyqRCAfjdoV0EB8dpx/GGCoPOYc1mm8mM7sMYGI269lmOFor Q==;
X-CSE-ConnectionGUID: ac9XGW7USBe58/Nj+Safsg==
X-CSE-MsgGUID: KiT8ez0HR+aKc52zegJrYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87718962"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="87718962"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 07:14:57 -0700
X-CSE-ConnectionGUID: mctQlVdFTXGE/kcHKsH4EQ==
X-CSE-MsgGUID: 8ZW+qikAQESI8TD9bTfgYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227628764"
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.246.19.164])
 ([10.246.19.164])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 07:14:56 -0700
Message-ID: <6da500f8-d9e2-4bf0-b6e4-9be5699b5ad6@linux.intel.com>
Date: Wed, 8 Apr 2026 16:14:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Add support for limiting NPU frequency
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 maciej.falkowski@linux.intel.com
References: <20260408130827.2082946-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260408130827.2082946-1-andrzej.kacprowski@linux.intel.com>
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

On 4/8/2026 3:08 PM, Andrzej Kacprowski wrote:
> Add configurable frequency limits to allow users to constrain the NPU
> operating frequency range for power and thermal management. This support
> requires firmware API version 3.34.0 or newer.
> 
> New sysfs interface:
> 
> The freq/ subdirectory contains the following attributes:
> 
> - hw_min_freq: Minimum frequency supported by hardware (read-only)
> - hw_max_freq: Maximum frequency supported by hardware (read-only)
> - hw_efficient_freq: Hardware's optimal operating frequency (read-only)
> - current_freq: Current NPU frequency in MHz (read-only)
> - set_min_freq: Configure minimum operating frequency (50XX+ devices)
> - set_max_freq: Configure maximum operating frequency (50XX+ devices)
> 
> Legacy attributes npu_max_frequency_mhz and npu_current_frequency_mhz
> are maintained for backward compatibility.
> 
> Implementation details:
> 
> - Frequency configuration is communicated to firmware via JSM messages
> - User-specified frequency values are clamped to hardware limits
> - Power-efficient frequency (pn_ratio) is adjusted dynamically to stay
>   within the configured range
> - Frequency configuration is initialized during device boot
> - The JSM API header is updated to version 3.34.0 to support the new
>   VPU_JSM_MSG_FREQ_CONFIG firmware message
> 
> Added description for the sysfs attributes in the Documentation/ABI.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---
> Changes in v2:
> - Added sysfs attribute documentation in Documentation/ABI.
> - Updated MAINTAINERS to include the new documentation files.
> 
>  Documentation/ABI/obsolete/sysfs-driver-ivpu |  30 +++
>  Documentation/ABI/testing/sysfs-driver-ivpu  |  65 +++++++
>  MAINTAINERS                                  |   2 +
>  drivers/accel/ivpu/ivpu_drv.c                |   8 +-
>  drivers/accel/ivpu/ivpu_hw.h                 |  16 +-
>  drivers/accel/ivpu/ivpu_hw_btrs.c            | 112 ++++++++---
>  drivers/accel/ivpu/ivpu_hw_btrs.h            |  10 +-
>  drivers/accel/ivpu/ivpu_jsm_msg.c            |  18 +-
>  drivers/accel/ivpu/ivpu_jsm_msg.h            |   4 +-
>  drivers/accel/ivpu/ivpu_sysfs.c              | 186 ++++++++++++++++---
>  drivers/accel/ivpu/vpu_jsm_api.h             |  34 +++-
>  11 files changed, 420 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-driver-ivpu
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-ivpu
> 
> diff --git a/Documentation/ABI/obsolete/sysfs-driver-ivpu b/Documentation/ABI/obsolete/sysfs-driver-ivpu
> new file mode 100644
> index 000000000000..16f6a0b22406
> --- /dev/null
> +++ b/Documentation/ABI/obsolete/sysfs-driver-ivpu
> @@ -0,0 +1,30 @@
> +What:		/sys/bus/pci/drivers/intel_vpu/.../sched_mode
> +Date:		October 2024
> +KernelVersion:	6.12
> +Contact:	dri-devel@lists.freedesktop.org
> +Description:	Current NPU scheduling mode. Returns one of the following strings:
> +		- "HW" - Hardware Scheduler mode
> +		- "OS" - Operating System Scheduler mode
> +		Read-only.
> +		Deprecated since the "OS" scheduling mode is not usable
> +		and will be removed from future versions of the driver.
> +		Will be removed in 2027
> +
> +What:		/sys/bus/pci/drivers/intel_vpu/.../npu_max_frequency_mhz

This says npu_max_frequency_mhz

> +Date:		April 2025
> +KernelVersion:	6.15
> +Contact:	dri-devel@lists.freedesktop.org
> +Description:	Legacy alias for /sys/bus/pci/drivers/intel_vpu/.../freq/hw_min_freq.

But this is hw_min_freq - supposed to be hw_max_freq

> +		Shows maximum frequency in MHz of the NPU's data processing unit.
> +		Read-only.
> +		Will be removed in 2027
> +
> +What:		/sys/bus/pci/drivers/intel_vpu/.../npu_current_frequency_mhz
> +Date:		April 2025
> +KernelVersion:	6.15
> +Contact:	dri-devel@lists.freedesktop.org
> +Description:	Legacy alias for /sys/bus/pci/drivers/intel_vpu/.../freq/current_freq.
> +		Shows current frequency in MHz of the NPU's data processing unit.
> +		The value is read only when the device is active; otherwise it returns 0.
> +		Read-only.
> +		Will be removed in 2027

...

> diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.h b/drivers/accel/ivpu/ivpu_jsm_msg.h
> index a74f5a0b0d93..ead7d07d300f 100644
> --- a/drivers/accel/ivpu/ivpu_jsm_msg.h
> +++ b/drivers/accel/ivpu/ivpu_jsm_msg.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (C) 2020-2024 Intel Corporation
> + * Copyright (C) 2020-2026 Intel Corporation
>   */
>  
>  #ifndef __IVPU_JSM_MSG_H__
> @@ -45,5 +45,7 @@ int ivpu_jsm_dct_enable(struct ivpu_device *vdev, u32 active_us, u32 inactive_us
>  int ivpu_jsm_dct_disable(struct ivpu_device *vdev);
>  int ivpu_jsm_state_dump(struct ivpu_device *vdev);
>  int ivpu_jsm_state_dump_no_reply(struct ivpu_device *vdev);
> +int ivpu_jsm_msg_freq_config(struct ivpu_device *vdev, u16 min_ratio, u16 pn_ratio, u16 max_ratio);
> +int ivpu_jsm_msg_freq_config(struct ivpu_device *vdev, u16 min_ratio, u16 pn_ratio, u16 max_ratio);

This got added twice.

...

Karol

