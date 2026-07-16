Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5503C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB2A10E36E;
	Thu, 16 Jul 2026 13:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H3P8uQWQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5698F10E36E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784208579; x=1815744579;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=M/REfYXH+P/gjHjpzC7jgdpPnubnF/nkAeSAQYC9Nc8=;
 b=H3P8uQWQhUrF0LOFbrc8NN5coSATt0EOINUCILvWp6vobmEQ3lhEDfHr
 PbyhDOKf2PstMJG9vncyt7vvQTVLtFr85HLSGpM52NH+kbO7WS0q8rKYu
 VUYeEjVBRuxwDMiVUCHLyNugwOW8wDexpTsj+ItFGbVWtNInCZJXCT1xh
 nVnTCZ4CDvUKvyTZ3ABme7RMTR0CUMSB15N9K3RVhFxh3wlkQTdv9Xaf8
 Oew9lNxl5i1jKqRhzhhV79Em4nz1JHZ3zJzmB5GYrWA5KAaH81OzkrsFG
 D05G66oXeONmefYSYgfSOhCJvKo74PS/9ipJZizqg/7nHd3TSWHQA3HsQ Q==;
X-CSE-ConnectionGUID: n84/zGcPTMqfjEzW/gUwpg==
X-CSE-MsgGUID: 8GNaxSEmSfm+7niB5f5K2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72399053"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="72399053"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 06:29:39 -0700
X-CSE-ConnectionGUID: 93e+XA5LT5aurGL7+Kxhuw==
X-CSE-MsgGUID: rA1C1XL3Tyuc3zIQx+XIlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; d="scan'208";a="260090760"
Received: from jpiaseck-mobl2.ger.corp.intel.com (HELO [10.94.252.39])
 ([10.94.252.39])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 06:29:38 -0700
Message-ID: <27097f78-bd31-402b-89bf-bf06cdd363a2@linux.intel.com>
Date: Thu, 16 Jul 2026 15:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Remove unnecessary min_t()/max_t() usage
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com
References: <20260716083350.248419-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260716083350.248419-1-andrzej.kacprowski@linux.intel.com>
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

On 16-Jul-26 10:33, Andrzej Kacprowski wrote:
> Remove unnecessary min_t()/max_t() usage in ivpu_fw.c
> and ivpu_mmu_context.c. The min()/max() macros are
> sufficient as the types are compatible and
> there is no risk of overflow.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_fw.c          | 2 +-
>   drivers/accel/ivpu/ivpu_mmu_context.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index 5a8f7dfb54e6..b78b7c35cd9b 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
> @@ -318,7 +318,7 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
>   	fw->shave_nn_size = PAGE_ALIGN(fw_hdr->shave_nn_fw_size);
>   	fw->cold_boot_entry_point = fw_hdr->entry_point;
>   
> -	fw->trace_level = min_t(u32, ivpu_fw_log_level, IVPU_FW_LOG_FATAL);
> +	fw->trace_level = min(ivpu_fw_log_level, IVPU_FW_LOG_FATAL);
>   	fw->trace_destination_mask = VPU_TRACE_DESTINATION_VERBOSE_TRACING;
>   	fw->trace_hw_component_mask = -1;
>   
> diff --git a/drivers/accel/ivpu/ivpu_mmu_context.c b/drivers/accel/ivpu/ivpu_mmu_context.c
> index c4014c83e727..bb3ca81838e3 100644
> --- a/drivers/accel/ivpu/ivpu_mmu_context.c
> +++ b/drivers/accel/ivpu/ivpu_mmu_context.c
> @@ -588,8 +588,8 @@ void ivpu_mmu_context_init(struct ivpu_device *vdev, struct ivpu_mmu_context *ct
>   		start = vdev->hw->ranges.runtime.start;
>   		end = vdev->hw->ranges.shave.end;
>   	} else {
> -		start = min_t(u64, vdev->hw->ranges.user.start, vdev->hw->ranges.shave.start);
> -		end = max_t(u64, vdev->hw->ranges.user.end, vdev->hw->ranges.dma.end);
> +		start = min(vdev->hw->ranges.user.start, vdev->hw->ranges.shave.start);
> +		end = max(vdev->hw->ranges.user.end, vdev->hw->ranges.dma.end);
>   	}
>   
>   	drm_mm_init(&ctx->mm, start, end - start);

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
