Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A3FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12CA010E347;
	Wed,  1 Jul 2026 10:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="fCJ5ImEc";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D8510E347;
 Wed,  1 Jul 2026 10:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782900837;
 bh=ZQWJyLX7UxBynIft5IW9JjFWP9zLMapOq6iJxTycB+4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fCJ5ImEcsiawkGgGikQX8rOnygvRp/uOTc2As7CXH3Oi2hlwHgaVjHBRFsxTGHhQF
 TPKz9cLcbWBZNNNPveWkVr3IQmtVDqOunNgESKXQ4ml21oUynrGNJVY5tORB1/P6hx
 AHOdNqsyqWEqsxueuY8Z+w9JybdBDrUww+HtttRgj+m8CNl8wKjtnqLs50QzV3Jykt
 awilGXOkjJa4+6HzIf6lmzFQejIfac1sa7sGtfsC7vZZgKzIlScIBSE+T47DuWDpLK
 4lVFLZYn3jb+1S+FO78ygWgvRsn6QBXmXnZc+m5ste94lMHrH99Z6e7rrqD3gJJQtG
 4UcPdnPuk3C5w==
Message-ID: <6e41bc45-82a2-4cd3-a666-ade919acd26b@lankhorst.se>
Date: Wed, 1 Jul 2026 12:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/xe: Avoid using stolen memory for DPT.
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260630135523.1775379-1-dev@lankhorst.se>
 <20260630135523.1775379-2-dev@lankhorst.se>
 <55a8612b-65af-4e15-ae5d-a27a55064f84@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <55a8612b-65af-4e15-ae5d-a27a55064f84@intel.com>
Content-Type: text/plain; charset=UTF-8
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

Hello,

On 6/30/26 16:10, Matthew Auld wrote:
> On 30/06/2026 14:55, Maarten Lankhorst wrote:
>> On systems with media GT, extra latency is added when accessing stolen
>> memory when the GT is in MC6. Since we additionally aren't counting how
>> much memory is used for stolen and we could in theory fill up the
>> entire stolen area with DPT's, avoid using stolen and only use the
>> default memory region.
>>
>> Additionally, this may also result in random system hangs under load.
>>
>> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> 
> Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
> Cc: <stable@vger.kernel.org> # v6.12+
> 
> ?
> 
>> ---
>>   drivers/gpu/drm/xe/display/xe_fb_pin.c | 33 +++++++-------------------
>>   1 file changed, 8 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>> index 5f4a0cd8deca0..73469ea5f333d 100644
>> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
>> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
>> @@ -164,31 +164,14 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
>>           dpt_size = ALIGN(intel_rotation_info_size(&view->rotated) * 8,
>>                    XE_PAGE_SIZE);
>>   -    if (IS_DGFX(xe))
>> -        dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>> -                           dpt_size, ~0ull,
>> -                           ttm_bo_type_kernel,
>> -                           XE_BO_FLAG_VRAM0 |
>> -                           XE_BO_FLAG_GGTT |
>> -                           XE_BO_FLAG_PAGETABLE,
>> -                           pin_params->alignment, false);
>> -    else
>> -        dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>> -                           dpt_size,  ~0ull,
>> -                           ttm_bo_type_kernel,
>> -                           XE_BO_FLAG_STOLEN |
>> -                           XE_BO_FLAG_GGTT |
>> -                           XE_BO_FLAG_PAGETABLE,
>> -                           pin_params->alignment, false);
>> -    if (IS_ERR(dpt))
>> -        dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>> -                           dpt_size,  ~0ull,
>> -                           ttm_bo_type_kernel,
>> -                           XE_BO_FLAG_SYSTEM |
>> -                           XE_BO_FLAG_GGTT |
>> -                           XE_BO_FLAG_PAGETABLE |
>> -                           XE_BO_FLAG_FORCE_WC,
>> -                           pin_params->alignment, false);
> 
> Technically this changes the behaviour for dgpu, where it looks like it will fall back to system memory? Surprised that would even work though, and not get a bunch of pipe errors? I would assume VRAM is a requirement.

I just tried it out to answer the question, turns out this fails spectacularly!
It gives a pipe fault error on every vblank on my bmg.

It probably never worked, but as long as we never fall back it never was an issue.
The new behavior is correct, I'll update the wording of the commit message for this.

> Either keeping the same behaviour, or updating the commit to mention this change, or splitting that out (maybe needs a separate fixes?),
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> 
Can I extend that to patch 2 and 3 too?

>> +    dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
>> +                       dpt_size,  ~0ull,
>> +                       ttm_bo_type_kernel,
>> +                       XE_BO_FLAG_VRAM_IF_DGFX(tile0) |
>> +                       XE_BO_FLAG_GGTT |
>> +                       XE_BO_FLAG_PAGETABLE |
>> +                       XE_BO_FLAG_FORCE_WC,
>> +                       pin_params->alignment, false);
>>       if (IS_ERR(dpt))
>>           return PTR_ERR(dpt);
>>   
> 

