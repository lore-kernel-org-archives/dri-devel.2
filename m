Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B9DC44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48ED910E41B;
	Fri, 17 Jul 2026 08:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QIefMY/s";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70F210E41B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 08:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784276253; x=1815812253;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=mBfUr6xwbOx4OliWx535EHYlqyVnYtGd52c70RMBpwY=;
 b=QIefMY/sO3OrfB5izW/Y47nBzYSqmLlvXVnntCkGdzrUIk20Ntqu0o44
 ajuxkUMWdNVXLQyAf9wFhJhhBx5qzLIrY2JV9xxOoMnKqUunTxlpKPrvu
 KBqc5Fw/t4VQIgkVTuimrVjKCap4alEPiGt5u9JtRZ/vOW3hSl/d5rAKk
 evYK9lt8/sl+nB3KjCtK2kkGzpWZd0sZeigLcEsT1llA19B8vMypRH304
 SHeYXzFHUiRgTxj63nRLNLXI7ZEkmcObpaox1JJjIgOnG/HuGSsMSK2Mj
 3q4c9pSvMGNr2Id/hv733Dt1h/+OIv4W7KvJHLF2PAmcQFwZVc4V9LH+7 g==;
X-CSE-ConnectionGUID: QWCMl/mITSid/qDOdYnalg==
X-CSE-MsgGUID: KcMSbn1gRae6F9lyjD5e6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95545660"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="95545660"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 01:17:31 -0700
X-CSE-ConnectionGUID: upRuDK7vRcO62O38PnDRLQ==
X-CSE-MsgGUID: /zWdhJ6DQlC2ezwG1CZnaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="260307900"
Received: from sosterlu-mobl1.ger.corp.intel.com (HELO [10.245.115.26])
 ([10.245.115.26])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 01:17:30 -0700
Message-ID: <bc9c3c06-a240-49dc-a461-27958dc8e9f7@linux.intel.com>
Date: Fri, 17 Jul 2026 10:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Remove unnecessary min_t()/max_t() usage
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com
References: <20260716083350.248419-1-andrzej.kacprowski@linux.intel.com>
 <27097f78-bd31-402b-89bf-bf06cdd363a2@linux.intel.com>
Content-Language: en-US
In-Reply-To: <27097f78-bd31-402b-89bf-bf06cdd363a2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 16-Jul-26 15:29, Wachowski, Karol wrote:
> On 16-Jul-26 10:33, Andrzej Kacprowski wrote:
>> Remove unnecessary min_t()/max_t() usage in ivpu_fw.c
>> and ivpu_mmu_context.c. The min()/max() macros are
>> sufficient as the types are compatible and
>> there is no risk of overflow.
>>
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_fw.c          | 2 +-
>>   drivers/accel/ivpu/ivpu_mmu_context.c | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
>> index 5a8f7dfb54e6..b78b7c35cd9b 100644
>> --- a/drivers/accel/ivpu/ivpu_fw.c
>> +++ b/drivers/accel/ivpu/ivpu_fw.c
>> @@ -318,7 +318,7 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
>>       fw->shave_nn_size = PAGE_ALIGN(fw_hdr->shave_nn_fw_size);
>>       fw->cold_boot_entry_point = fw_hdr->entry_point;
>> -    fw->trace_level = min_t(u32, ivpu_fw_log_level, IVPU_FW_LOG_FATAL);
>> +    fw->trace_level = min(ivpu_fw_log_level, IVPU_FW_LOG_FATAL);
>>       fw->trace_destination_mask = VPU_TRACE_DESTINATION_VERBOSE_TRACING;
>>       fw->trace_hw_component_mask = -1;
>> diff --git a/drivers/accel/ivpu/ivpu_mmu_context.c b/drivers/accel/ 
>> ivpu/ivpu_mmu_context.c
>> index c4014c83e727..bb3ca81838e3 100644
>> --- a/drivers/accel/ivpu/ivpu_mmu_context.c
>> +++ b/drivers/accel/ivpu/ivpu_mmu_context.c
>> @@ -588,8 +588,8 @@ void ivpu_mmu_context_init(struct ivpu_device 
>> *vdev, struct ivpu_mmu_context *ct
>>           start = vdev->hw->ranges.runtime.start;
>>           end = vdev->hw->ranges.shave.end;
>>       } else {
>> -        start = min_t(u64, vdev->hw->ranges.user.start, vdev->hw- 
>> >ranges.shave.start);
>> -        end = max_t(u64, vdev->hw->ranges.user.end, vdev->hw- 
>> >ranges.dma.end);
>> +        start = min(vdev->hw->ranges.user.start, vdev->hw- 
>> >ranges.shave.start);
>> +        end = max(vdev->hw->ranges.user.end, vdev->hw->ranges.dma.end);
>>       }
>>       drm_mm_init(&ctx->mm, start, end - start);
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Pushed to drm-misc-next.
