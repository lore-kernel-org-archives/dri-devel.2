Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49480C5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0AEE113866;
	Tue,  2 Jun 2026 05:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gEqM34EI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634AB113868
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 05:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780379388; x=1811915388;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=eZrCBGazyAZ2yRvUieVnU0FSZppveeZKV8WrKXXSByQ=;
 b=gEqM34EIae/Dtzu+nyC+jkFYPi6EtRwkDBz1OFjlIWs1naMBKBp1yFRg
 Ea+NqljHFdBDyo1muWWZiImLX4G/L3/G2dGEOtI5LSiN1v4RaUDAZeriv
 of8lciR4QushTbrFjvnhUe/cGEPgcTh8+bLD9H7tdthzAsML0RLHNvQj3
 yMj6kw2mnLdlg6dhEUW3gH69LgrR3MX8ItFzIXIpdVfJb2O/mm9rT+bp5
 zzB513hXFS6FH1ag6iuWEKbdBcK79pgx019VDggkJA2GUAGdP3j8Yxqtg
 8nO2Q4cc6TYk4Ue9KtQpP6RbpUQyNhS3pi2JfvoWBPM5ifwFtOHGo2RwZ g==;
X-CSE-ConnectionGUID: xmnl+v5fR8uMolCM8lyETA==
X-CSE-MsgGUID: HBf+dpjgTYivl94Dm9B+ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="85045070"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="85045070"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 22:49:47 -0700
X-CSE-ConnectionGUID: ayOaYNxsQISKe30thcLIng==
X-CSE-MsgGUID: nLS+remORPyhloR7ciO78g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="267451392"
Received: from martanox-mobl.ger.corp.intel.com (HELO [10.94.250.132])
 ([10.94.250.132])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 22:49:45 -0700
Message-ID: <32cb5055-c2e1-4bfd-a691-202e4cf08d17@linux.intel.com>
Date: Tue, 2 Jun 2026 07:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add buffer overflow check in MS get_info_ioctl
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
References: <20260529120841.135852-1-andrzej.kacprowski@linux.intel.com>
 <8cd98877-6535-4ca4-8c96-88c136a2dac1@linux.intel.com>
Content-Language: en-US
In-Reply-To: <8cd98877-6535-4ca4-8c96-88c136a2dac1@linux.intel.com>
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

On 29-May-26 14:23, Wachowski, Karol wrote:
> On 29-May-26 14:08, Andrzej Kacprowski wrote:
>> Add validation that the info size returned from the metric stream info
>> query is not exceeded when checked against the allocated buffer size.
>> If the firmware returns a size larger than the buffer, reject the
>> operation with -EOVERFLOW instead of proceeding with an incorrect
>> buffer copy.
>>
>> Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
>> Cc: <stable@vger.kernel.org> # v6.18+
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Applied to drm-misc-fixes.

> 
>> ---
>>   drivers/accel/ivpu/ivpu_ms.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
>> index be43851f5f32..cd176e77b9a0 100644
>> --- a/drivers/accel/ivpu/ivpu_ms.c
>> +++ b/drivers/accel/ivpu/ivpu_ms.c
>> @@ -291,6 +291,13 @@ int ivpu_ms_get_info_ioctl(struct drm_device 
>> *dev, void *data, struct drm_file *
>>       if (ret)
>>           goto unlock;
>> +    if (info_size > ivpu_bo_size(bo)) {
>> +        ivpu_warn_ratelimited(vdev, "MS info overflow: %#llx > %#zx\n",
>> +                      info_size, ivpu_bo_size(bo));
>> +        ret = -EOVERFLOW;
>> +        goto unlock;
>> +    }
>> +
>>       if (args->buffer_size < info_size) {
>>           ret = -ENOSPC;
>>           goto unlock;
> 
> 

