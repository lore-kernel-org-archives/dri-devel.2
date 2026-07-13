Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C50C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9B110E5B6;
	Mon, 13 Jul 2026 08:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B4L5bEtL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43F210E5B6
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783931597; x=1815467597;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=X7RlLgSSTyTrJ1Kh15xDULhk6gCRU9sXicYlKhVZeUM=;
 b=B4L5bEtLRmQ1Cnkv0CF4zpjNSXNTH6KE8WPEsOJVKxaS1uK/O4MayVXz
 +fLQlaV9DD7uviW1DLuLk9AUagWlCpaDSD/GoU40YL7+89FUVmo5b+1+Q
 xceFAbhpqsIoBcnfHrN+8AJSiZId3O5x6ckQb04B78u/Vzv/9AvgbRIx2
 +w/LF6Yfkmosy8vb3S0JwngNJ2rQmRy1UBk/Klvu5keO7a7PiCmElMSnU
 bujf+42BF0nu0pws72LfNW60xKJM+LAwkxmET4erlj52MsL8m4G+7G8JT
 R1ERiJZW55OUL/fyg2eg1MuoQW6uSOUgZP06QHOXRMpjkxOzfg6Mh0uz9 w==;
X-CSE-ConnectionGUID: 9t8arQanQsqmfiXq1QyH5Q==
X-CSE-MsgGUID: XBGRYMjAQxCUDPoh+42eow==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95903265"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95903265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 01:33:17 -0700
X-CSE-ConnectionGUID: +bCRt4BuQXWkwpoaYY6rxQ==
X-CSE-MsgGUID: NXq3KW5+QHGGJjd5R43Lgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251070334"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.64])
 ([10.217.180.64])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 01:33:16 -0700
Message-ID: <c08922c8-2dd6-4f0f-b0cc-b60d0a866f0a@linux.intel.com>
Date: Mon, 13 Jul 2026 10:32:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix wrong register read in LNL failure
 diagnostics
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
References: <20260710101331.1899505-1-karol.wachowski@linux.intel.com>
 <a5474281-ef01-4d8c-8640-f8e2bc4e531c@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <a5474281-ef01-4d8c-8640-f8e2bc4e531c@linux.intel.com>
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

On 13-Jul-26 9:18, Andrzej Kacprowski wrote:
> On 10-Jul-26 12:13 PM, Karol Wachowski wrote:
>> diagnose_failure_lnl() read VPU_HW_BTRS_MTL_INTERRUPT_STAT instead of
>> VPU_HW_BTRS_LNL_INTERRUPT_STAT, which on LNL and newer parts is a
>> different register with a different bit layout, so failure diagnostics
>> decoded the wrong register and reported a bogus error cause.
>> Read the LNL interrupt status register instead.
>>
>> Fixes: 8a27ad81f7d3 ("accel/ivpu: Split IP and buttress code")
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_hw_btrs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ 
>> ivpu_hw_btrs.c
>> index dac935164e11..a17c829adb89 100644
>> --- a/drivers/accel/ivpu/ivpu_hw_btrs.c
>> +++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
>> @@ -927,7 +927,7 @@ static void diagnose_failure_mtl(struct 
>> ivpu_device *vdev)
>>   static void diagnose_failure_lnl(struct ivpu_device *vdev)
>>   {
>> -    u32 reg = REGB_RD32(VPU_HW_BTRS_MTL_INTERRUPT_STAT) & 
>> BTRS_LNL_IRQ_MASK;
>> +    u32 reg = REGB_RD32(VPU_HW_BTRS_LNL_INTERRUPT_STAT) & 
>> BTRS_LNL_IRQ_MASK;
>>       if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, ATS_ERR, reg)) {
>>           ivpu_err(vdev, "ATS_ERR_LOG1 0x%08x ATS_ERR_LOG2 0x%08x\n",
> 
> Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Thanks!
Applied to drm-misc-fixes.
