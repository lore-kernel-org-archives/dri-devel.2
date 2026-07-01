Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36721C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B4210EE84;
	Wed,  1 Jul 2026 10:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WhVQWLDT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721E810E332;
 Wed,  1 Jul 2026 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782901707; x=1814437707;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=kAK9weZsqxS2bAQAvkWLHMzfV9MxXyT3aba2Cm8LaH4=;
 b=WhVQWLDTTWjTj8P7tEt086iCyqFWMUhkNDB8hYVv7yw/WaJgAYHLhfrQ
 XOt5NY3EIxIoV8mqacpX9olvnavZFIA9kxZCLS+XZcdPWK20X6D2/03Wl
 JIV5aA8XSV8+Ukj9sani6XkfcQBpJBBY08yDM41q7nYivrqk6T2OWw0xj
 xKKnHCvfJEAtV/q+fDOtF1gY2mVtrO648R19Hv5IcetvTavYtiD8u8Ayg
 3X31d0Hvr9Zc3ll2vU6azY2mXcD6DbgeYlb8yPFxQ8w11zGUmHBezvGL3
 Wq+q4RoZ9ywpebP8cdGvpHzPifxK94Y+fWgnwQ4epzGL5s2uPD0LMmlus w==;
X-CSE-ConnectionGUID: 44YkLOnDSiiB7+lQWE9gKw==
X-CSE-MsgGUID: t1AkUnKSTEiBQpsU2dQSWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101173238"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="101173238"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:28:26 -0700
X-CSE-ConnectionGUID: 4SzPP/+VQBGXQr+XOttBPg==
X-CSE-MsgGUID: JsInsb0PQKGnEAzQCLxC9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="246171427"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.244.86])
 ([10.245.244.86])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:28:25 -0700
Message-ID: <63241399-5b71-4961-907f-59621dcef843@intel.com>
Date: Wed, 1 Jul 2026 11:28:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/xe/display: Avoid using stolen memory for
 framebuffer when media gt exists.
From: Matthew Auld <matthew.auld@intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260630135523.1775379-1-dev@lankhorst.se>
 <20260630135523.1775379-3-dev@lankhorst.se>
 <06860a7f-0df8-4e8d-b4ff-c6ebabc5fa4c@intel.com>
Content-Language: en-GB
In-Reply-To: <06860a7f-0df8-4e8d-b4ff-c6ebabc5fa4c@intel.com>
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

On 01/07/2026 11:27, Matthew Auld wrote:
> On 30/06/2026 14:55, Maarten Lankhorst wrote:
>> On systems with media GT, extra latency is added when accessing stolen
>> memory when the GT is in MC6.
>>
>> Simply disable allocating stolen memory for framebuffers when media gt
>> is found.
>>
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>> ---
>>   drivers/gpu/drm/xe/display/xe_display_bo.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/display/xe_display_bo.c b/drivers/gpu/ 
>> drm/xe/display/xe_display_bo.c
>> index 8953da0136dcb..677ae3af9ac0c 100644
>> --- a/drivers/gpu/drm/xe/display/xe_display_bo.c
>> +++ b/drivers/gpu/drm/xe/display/xe_display_bo.c
>> @@ -131,6 +131,13 @@ bool xe_display_bo_fbdev_prefer_stolen(struct 
>> xe_device *xe, unsigned int size)
>>       if (IS_DGFX(xe))
>>           return false;
>> +    /*
>> +     * Avoid stolen memory when the media_gt exists,
>> +     * because a lot of latency is added when media gt is in MC6
>> +     */
>> +    if (xe_device_get_root_tile(xe)->media_gt)
>> +        return false;
>> +
>>       if (XE_DEVICE_WA(xe, 22019338487_display))
>>           return false;
> 
> There is also the question for why this WA only applies to LNL, but the 
> GT side of the WA applies even to PTL+, which seems highly suspect. 
> Might be worth mentioning that in the commit. Also wondering if can now 
> just drop 22019338487_display?
> 
> Also not sure if should just go with platform check here:
> 
> if (info.platform >= LNL)
> 
> ?
> 
> Either way:
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Also should this have the same Fixes: ?

> 
> 

