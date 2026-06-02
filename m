Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD84C5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0EA9113865;
	Tue,  2 Jun 2026 05:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nBpnYJba";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB45D113865
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780379407; x=1811915407;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=mj9HAMZM6TU9/v8UpvnCJpU2g06IGq5K1i9ePAy2V7E=;
 b=nBpnYJba8p2nBzuKeWeYBNzhsYgfiDP5kSdZFjU2GCbOc32C7fi2xMS5
 bUQu0g95SIwCT2EFCZvQ53IPRQfody4mdblC0iQJ4fmtGPtNZVlpBq8Jq
 9EeW6mWoT0u09YfpfwpMBPHH/Z2jW1XSdEHpQNrLppL1vHHV4MA11cx4Q
 bmrFr2D7dYKqLPZI1aK1P8TuPm5I0ZQ3YdK5gi9/Mx/YYWx1PQJvPGivz
 YR3MIlFY7gHjgr4EQglqVuvY+SYT46BJTZAmlnSvIFoy3gyCUs+Hzik4E
 YWlXCHWNhNIjIBXsXHaB0CFY81V108xI4QR5JIK87WaMi8OklWwEjflBZ g==;
X-CSE-ConnectionGUID: SNtXRdnITha9eMe+EnuQqQ==
X-CSE-MsgGUID: JaoMsRQMThWunGSev4IDRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="85045080"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="85045080"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 22:50:07 -0700
X-CSE-ConnectionGUID: hYmEZITgTaqvFUGvO3o+dg==
X-CSE-MsgGUID: 1sZrEx44RRmEsOKR1hw/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="267451426"
Received: from martanox-mobl.ger.corp.intel.com (HELO [10.94.250.132])
 ([10.94.250.132])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 22:50:04 -0700
Message-ID: <97e861e1-8c15-4421-847e-58028fdf5327@linux.intel.com>
Date: Tue, 2 Jun 2026 07:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add bounds check for firmware runtime memory
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529120853.135876-1-andrzej.kacprowski@linux.intel.com>
 <fcad21ec-ebeb-41af-a94a-b31120fa945a@linux.intel.com>
Content-Language: en-US
In-Reply-To: <fcad21ec-ebeb-41af-a94a-b31120fa945a@linux.intel.com>
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

On 29-May-26 14:27, Wachowski, Karol wrote:
> On 29-May-26 14:08, Andrzej Kacprowski wrote:
>> Validate that the firmware runtime memory specified in the image
>> header is properly aligned and sized to hold the firmware image.
>> This prevents errors during memory allocation and image transfer.
>>
>> Fixes: 2007e210b6a1 ("accel/ivpu: Split FW runtime and global memory 
>> buffers")
>> Cc: <stable@vger.kernel.org> # v7.0+
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 

Applied to drm-misc-fixes.

>> ---
>>   drivers/accel/ivpu/ivpu_fw.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
>> index 107f8ad31050..33c50779c06b 100644
>> --- a/drivers/accel/ivpu/ivpu_fw.c
>> +++ b/drivers/accel/ivpu/ivpu_fw.c
>> @@ -259,6 +259,22 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
>>           return -EINVAL;
>>       }
>> +    if (!PAGE_ALIGNED(runtime_addr)) {
>> +        ivpu_err(vdev, "Runtime address 0x%llx not page aligned\n", 
>> runtime_addr);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!PAGE_ALIGNED(runtime_size)) {
>> +        ivpu_err(vdev, "Runtime size %llu not page aligned\n", 
>> runtime_size);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (runtime_size < image_size) {
>> +        ivpu_err(vdev, "Runtime size too small: %llu, image size: 
>> %llu\n",
>> +             runtime_size, image_size);
>> +        return -EINVAL;
>> +    }
>> +
>>       if (!ivpu_is_within_range(image_load_addr, image_size, &vdev- 
>> >hw->ranges.runtime)) {
>>           ivpu_err(vdev, "Invalid firmware load address: 0x%llx and 
>> size %llu\n",
>>                image_load_addr, image_size);
> 
> 

