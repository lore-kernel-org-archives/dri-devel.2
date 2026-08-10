Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E46FC5B56C
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA6C10E8FF;
	Mon, 10 Aug 2026 15:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="InSSFqAU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F38210E236;
 Mon, 10 Aug 2026 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=os657xqLGgDm/9BsJwKm0Ml1+Xpgpj6PbqbNKEPedwY=; b=InSSFqAUtqJgpjF9gDXzPI1PX3
 6OPs13+vrcLG+PApOUtM/gkAZsPLUyxTij20rEkuatYQP933tg2VnYa3lqdwmLkDgY7YFXGi8rPGW
 u04iztb1TsRZzL9E/qsRGp2Pu2AFyCfJD4RT4AMaYhWguPU9GnwJwjZR0RNmwIfzXhWsJrOn32U6t
 S63k1qX0fJOZaVvnJ20/iRkO+PNr+B7m4pqsjen42Aj938aVUSDcsTNEWkKNjucVsvgxvI4Wa+g1y
 Mo0k67uDzncD6H8oeFJxIhUyZvBAjFSIDeDLuBkcinzYp8NP3ZoZjLHmPqgxHZeThMN/Y0mq0v+Qt
 3SctFU3Q==;
Received: from [187.36.208.132] (helo=[192.168.1.103])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wtRzU-00GeZ7-KL; Mon, 10 Aug 2026 17:32:40 +0200
Message-ID: <038c825a-aaa3-4bb0-98ae-6f93dce73544@igalia.com>
Date: Mon, 10 Aug 2026 12:32:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/amdgpu: Use drm_timeout_abs_to_jiffies()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Melissa Wen <mwen@igalia.com>,
 Iago Toral <itoral@igalia.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com>
 <20260809-drm-timeout-helpers-v1-3-2de67405a145@igalia.com>
 <eaba2132-a4ad-4634-b00b-6728364a792c@amd.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <eaba2132-a4ad-4634-b00b-6728364a792c@amd.com>
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

Hi Christian,

On 10/08/26 10:34, Christian König wrote:
> On 8/9/26 21:23, Maíra Canal wrote:
>> amdgpu_gem_timeout() converts an absolute deadline in ns into jiffies,
>> which is what drm_timeout_abs_to_jiffies() already does for the other
>> drivers whose wait UAPI takes a deadline. Use the shared helper and keep
>> only the part that is specific to amdgpu.
>>
>> Two details change along this conversion: the helper rounds up rather than
>> truncating, so a deadline less than a tick away now waits for one jiffy
>> instead of returning 0. It also uses nsecs_to_jiffies64(), so the
>> conversion no longer truncates on 32-bit, where a large deadline could
>> previously be reduced to an arbitrary shorter one.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>
>> ---
>>
>> As a note, this patch can be merged independently to the AMD tree
>> without any dependencies.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 ++--------------
>>   1 file changed, 2 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 6a0699746fbc..84b509a484b0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -25,7 +25,6 @@
>>    *          Alex Deucher
>>    *          Jerome Glisse
>>    */
>> -#include <linux/ktime.h>
>>   #include <linux/module.h>
>>   #include <linux/overflow.h>
>>   #include <linux/pagemap.h>
>> @@ -40,6 +39,7 @@
>>   #include <drm/drm_gem_ttm_helper.h>
>>   #include <drm/ttm/ttm_tt.h>
>>   #include <drm/drm_syncobj.h>
>> +#include <drm/drm_utils.h>
>>   
>>   #include "amdgpu.h"
>>   #include "amdgpu_display.h"
>> @@ -622,23 +622,11 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
>>    */
>>   unsigned long amdgpu_gem_timeout(uint64_t timeout_ns)
> 
> Please completely nuke that function and replace it with calls to drm_timeout_abs_to_jiffies().
> 
>>   {
>> -	unsigned long timeout_jiffies;
>> -	ktime_t timeout;
>> -
>>   	/* clamp timeout if it's to large */
>>   	if (((int64_t)timeout_ns) < 0)
>>   		return MAX_SCHEDULE_TIMEOUT;
> 
> That check was actually never correct at all as far as I can see.
> 

I'm not sure about that... Taking a look at other UAPIs (like Panfrost),
I see that they use a s64 timeout_ns, which matches the ktime_t the
deadline is converted through. Contrary to that, AMD exposes a __u64 in
the UAPI and defines AMDGPU_TIMEOUT_INFINITE = 0xffffffffffffffffull in
libdrm. Therefore the check looks correct to me: it detects the values
above S64_MAX and maps them to an infinite wait.

Having said that, the comment is quite misleading. How about?

       /* Map anything that doesn't fit in a s64 to an infinite wait */

To make it even clearer, we could use `if (timeout_ns > S64_MAX)`.

> We need to make sure that when timeout_ns is larger than represent-able in long jiffies (especially on 32bit systems) then MAX_SCHEDULE_TIMEOUT is returned by drm_timeout_abs_to_jiffies().
> 

Actually, what drm_timeout_abs_to_jiffies() does is clamp the
nsecs_to_jiffies64() return to MAX_SCHEDULE_TIMEOUT - 1, so that a
finite deadline is never turned into an infinite wait. So it is safe on
32-bit, but it's not doing exactly what you described.

Best regards,
- Maíra

> And I hope that drm_timeout_abs_to_jiffies() does that correctly already, if not this seriously needs fixing anyway.
> 
> Regards,
> Christian.
> 
>>   
>> -	timeout = ktime_sub(ns_to_ktime(timeout_ns), ktime_get());
>> -	if (ktime_to_ns(timeout) < 0)
>> -		return 0;
>> -
>> -	timeout_jiffies = nsecs_to_jiffies(ktime_to_ns(timeout));
>> -	/*  clamp timeout to avoid unsigned-> signed overflow */
>> -	if (timeout_jiffies > MAX_SCHEDULE_TIMEOUT)
>> -		return MAX_SCHEDULE_TIMEOUT - 1;
>> -
>> -	return timeout_jiffies;
>> +	return drm_timeout_abs_to_jiffies(timeout_ns);
>>   }
>>   
>>   int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
>>
> 

