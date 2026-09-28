Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCCBCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9754010EB63;
	Mon, 28 Sep 2026 18:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jjpcLyCr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FCB10EB48;
 Mon, 28 Sep 2026 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=SRzjVWsHhgmkv307VMRyp22ehkJ2vsY4NwD7K1IM8Kc=; b=jjpcLyCrI8ZCdQKSgEWQ29VjlT
 dDrbGKC+TQry+E4N6nGrzMFqNWrvkMpswi9gatGOdkwJL4+mt8jsZIJj2Fo4bd23l1uS5oaOuTogS
 pgu9Dr3ZP59dlfFslSjFLoVDO5lF0/xULrkHdbva9GSs/Im2zDKLU6Vxj3d3agpxPh8xCt1JItor6
 k7Xrlqfb6g1QdyWUA1biYq2Pkr6dloM7u9glIb7Uj4lEaJwku5KsnyETdDliMS2WfRD9N5IMamGlU
 OXDlI1XBvCsE7WH3nQPw6gdOpYu0zJ/UJ3J0P/XpmjdtK23IBGPTYyOEauWe+pWHU6858si3UC6Yj
 puLBT/5g==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xBFnQ-008VrI-2j; Mon, 28 Sep 2026 20:09:48 +0200
Message-ID: <7dda1960-9e73-43af-bbb8-e6e7ba32a8f3@igalia.com>
Date: Mon, 28 Sep 2026 15:09:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm: Add drm_timeout_rel_to_jiffies()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-2-f2ae987d861f@igalia.com>
 <7a19a212-194a-4d5b-b0a0-6d2bee24f636@suse.de>
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
In-Reply-To: <7a19a212-194a-4d5b-b0a0-6d2bee24f636@suse.de>
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

Hi Thomas,

Thank you for your review!

On 28/09/26 13:37, Thomas Zimmermann wrote:

[...]

>> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec)
>> +{
>> +    u64 secs;
>> +    u32 rem;
>> +
>> +    /* Make 0 timeout means poll, as for the absolute variant. */
>> +    if (timeout_nsec == 0)
>> +        return 0;
>> +
>> +    /*
>> +     * As nsecs_to_jiffies64() does not guard against overflow, split
>> +     * the timeout into whole seconds and nanoseconds. This way
>> +     * nsecs_to_jiffies64() is always handed a value below a second.
>> +     */
>> +    secs = div_u64_rem(timeout_nsec, NSEC_PER_SEC, &rem);
>> +    if (secs >= MAX_JIFFY_OFFSET / HZ)
>> +        return MAX_JIFFY_OFFSET;
>> +
>> +    return min_t(u64, MAX_JIFFY_OFFSET,
>> +             secs_to_jiffies(secs) + nsecs_to_jiffies64(rem) + 1);
> 
> The timeout is controled by user space, right? Can these additions 
> overflow?  I see that secs is tested against MAX_JIFFY_OFFSET, but is 
> that sufficient?

Although the timeout is controlled by user-space, the additions cannot
overflow here. The secs test bounds the multiplication, which is why it
is written as secs >= MAX_JIFFY_OFFSET / HZ rather than secs * HZ >=
MAX_JIFFY_OFFSET (which could overflow).

Past that check, we know that the remaining is smaller than one second
and therefore, nsecs_to_jiffies64(rem) <= HZ - 1. So, the sum + 1 is at
most MAX_JIFFY_OFFSET.

> 
> BTW there was this NSEC % HZ test in the original code? What was it good 
> for? It is no longer useful?
> 

I believe that NSEC_PER_SEC % HZ was only useful to check if it was a
plain division, which wouldn't overflow. With the current approach, I
believe it's no longer needed.

Best regards,
- Maíra
> Best regards
> Thomas
> 
> 
>> +}
>> +EXPORT_SYMBOL(drm_timeout_rel_to_jiffies);
>> diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
>> index cd9621c52062..6ee222a3e97c 100644
>> --- a/include/drm/drm_timeout.h
>> +++ b/include/drm/drm_timeout.h
>> @@ -12,5 +12,6 @@
>>   #include <linux/types.h>
>>   signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
>> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec);
>>   #endif
>>
> 

