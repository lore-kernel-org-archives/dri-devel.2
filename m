Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90B5C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E8210E19D;
	Wed, 15 Jul 2026 14:18:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NSqFZan9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C495410E19D
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784125134; x=1815661134;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=4pQVkM9WBlO2vZEiiX+bLHbTyBfnEvBkqXZimCFqLzk=;
 b=NSqFZan9XJqhoENFsVTZA2tgDZidK7Ba05PGOXtxbO0avRt/9xajxUxS
 N+hZfZB/M5D5E+cAO62F1f5p2/DeRLnd3j+6D2HqLI0i9XCLT7VVW3FQO
 lKS4M2/X1XS0q8dN6rpBZNJJLlLW5YFCtZEmMleuNzcAddcziJF5e9AGz
 POgppNc9viV14ovRl0POSZgfiyZi1szw8FnwrL/t9H2o+kaFKfWYqoGKM
 bjtWRAnBoymnsLIOiX5VqK4cxubWrlGYxMDLeA0tyV1uizWtR0qtmfNGw
 CZmlCNkU7LSlYSfCXZiuNsDuj3p6E3n3ioNNzw2mNNVWpgqANiDK7L8lN A==;
X-CSE-ConnectionGUID: L5unHJzxRzqwK32daUXCLA==
X-CSE-MsgGUID: Oqr3udusRVqyj0TzDklA/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95364455"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="95364455"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 07:18:53 -0700
X-CSE-ConnectionGUID: +mB4D5dkQ8+P3dLhZmOkfQ==
X-CSE-MsgGUID: g4UT7WH3Tm2EgfctWuLglw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="259783028"
Received: from jakomppa-mobl.ger.corp.intel.com (HELO [10.246.16.242])
 ([10.246.16.242])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 07:18:51 -0700
Message-ID: <a4713578-1490-4b33-927f-57160d5f7c20@linux.intel.com>
Date: Wed, 15 Jul 2026 16:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Reject firmware log with size smaller than
 header
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Jhonraushan <raushan.jhon@gmail.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260715074206.867712-1-raushan.jhon@gmail.com>
 <68d6db92-5e48-477f-ba97-d116480e0636@linux.intel.com>
Content-Language: en-US
In-Reply-To: <68d6db92-5e48-477f-ba97-d116480e0636@linux.intel.com>
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

On 15-Jul-26 10:21, Wachowski, Karol wrote:
> On 15-Jul-26 9:42, Jhonraushan wrote:
>> fw_log_from_bo() validates the tracing buffer header_size and that the
>> log fits within the BO, but never checks that log->size is at least
>> log->header_size. fw_log_print_buffer() then computes:
>>
>>    u32 data_size = log->size - log->header_size;
>>
>> which underflows to a near-U32_MAX value when firmware reports a log 
>> whose
>> size is smaller than its header. That huge data_size defeats the
>> log_start/log_end bounds clamps added by commit dd1311bcf0e6 ("accel/ 
>> ivpu:
>> Add bounds checks for firmware log indices"), so fw_log_print_lines() 
>> reads
>> far past the small real data region of the BO. A size of 0 also makes
>> fw_log_from_bo() advance the offset by 0, causing the callers to loop
>> forever on the same header.
>>
>> Reject logs whose size is smaller than the header (which also rejects
>> size == 0).
>>
>> Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jhonraushan <raushan.jhon@gmail.com>
>> ---
>>   drivers/accel/ivpu/ivpu_fw_log.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ 
>> ivpu_fw_log.c
>> index 275baf844b56..716467aa3156 100644
>> --- a/drivers/accel/ivpu/ivpu_fw_log.c
>> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
>> @@ -43,6 +43,10 @@ static int fw_log_from_bo(struct ivpu_device *vdev, 
>> struct ivpu_bo *bo, u32 *off
>>           ivpu_dbg(vdev, FW_BOOT, "Invalid header size 0x%x\n", log- 
>> >header_size);
>>           return -EINVAL;
>>       }
>> +    if (log->size < log->header_size) {
>> +        ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
>> +        return -EINVAL;
>> +    }
>>       if ((char *)log + log->size > (char *)ivpu_bo_vaddr(bo) + 
>> ivpu_bo_size(bo)) {
>>           ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
>>           return -EINVAL;
> 
> Thanks for submission.
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Applied to drm-misc-fixes.
