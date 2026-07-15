Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32DEC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FDC10F087;
	Wed, 15 Jul 2026 13:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kOajmKYd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E3D10F08D
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Uo61uh8d0g4W7zMCQ6OTzWnkeXWexsVHjVydVzKCuP8=; b=kOajmKYdhjeS/3bRIl9cZG5SWY
 joHxEMNPEdgB6n8lB6xlRy+JQXOFBGiQktNDrwiEhfyHsmLW6oKWTlJV/D3/6cNp1vn8Z+hXWDwwb
 rSYDtEZ/xGSxpk8nH1xl8XE/aDmqUrabpQ1HCc5bulMEE2wLEBUZXvnk22pBrJjx9pMm63CIwqOxK
 CryVEoXU3FGjbifOKhhT6i+0v3Egf/g/MSPm6Tk/qgIpQs0QRhpLuhnV5Y4QWmGU02HPl+cGf+OQm
 WEE3njUnpp8M7+PWQf4BnYwSztFTv6PCaDSelUqGKfan2f9aae9WYlktpobGIVj1x7sVrPfjDNxaQ
 Nxe+QY5w==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wjzwn-00FThw-9Z; Wed, 15 Jul 2026 15:46:49 +0200
Message-ID: <f51d745c-c383-4d19-ac51-af9c69a83ba8@igalia.com>
Date: Wed, 15 Jul 2026 10:46:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Widen cache_clean_lock over the whole L2TCACTL
 sequence
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 stable@vger.kernel.org
References: <20260707200738.659002-2-mcanal@igalia.com>
 <e65137e19a8773a2f760531034481e0df60071d4.camel@igalia.com>
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
In-Reply-To: <e65137e19a8773a2f760531034481e0df60071d4.camel@igalia.com>
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

Hi Iago,

On 15/07/26 03:16, Iago Toral wrote:
> Hi Maíra,
> 
> has this change fixed anything?

Not real bug, just the theoretical race-condition between
v3d_clean_caches() and v3d_flush_l2t().

> 
> Also, I believe that GFXH-1897 is exclusive to Pi4. Have you tested if
> this change has any visible performance impact on Pi5?

I'll test it, however I don't imagine it would have a impact, as the
race condition should be rare enough. We would need a CACHE_CLEAN job
running simultaneously to v3d_invalidate_caches().

One thing I believe it might be possible is to skip a flush if a flush
is already happening, but it would be a micro-optimization.

Best regards,
- Maíra

> 
> Iago
> 
> 
> El mar, 07-07-2026 a las 17:05 -0300, Maíra Canal escribió:
>> v3d_clean_caches() and v3d_flush_l2t() both write the single L2TCACTL
>> register and poll its status bits. The mutex cache_clean_lock exists
>> to
>> serialize them, but v3d_clean_caches() only took the lock around its
>> final
>> FLM_CLEAN write.
>>
>> These functions run concurrently: v3d_flush_l2t() is issued from the
>> BIN/RENDER/CSD invalidate path while v3d_clean_caches() runs from the
>> CACHE_CLEAN queue, and each queue's scheduler uses its own ordered
>> workqueue, so their run_job callbacks execute in parallel.
>>
>> Because clean locked only its final write, a concurrent flush can
>> write
>> L2TCACTL during clean's unlocked phase. Both use non read-modify-
>> write
>> writes to the one register, so whichever lands last wins: clean's
>> TMUWCF
>> write can land on the flush's in-flight L2TFLS invalidate, triggering
>> the
>> GFXH-1897 hazard of writing L2TCACTL while a flush is pending.
>>
>> Hold cache_clean_lock across the entire L2TCACTL access sequence so
>> it
>> is fully mutually exclusive with v3d_flush_l2t(), which already takes
>> the
>> lock around its own write.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: abf888b03a98 ("drm/v3d: Wait for pending L2T flush before
>> cleaning caches")
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/v3d/v3d_gem.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c
>> b/drivers/gpu/drm/v3d/v3d_gem.c
>> index c43d9af41374..e597b6fd47c4 100644
>> --- a/drivers/gpu/drm/v3d/v3d_gem.c
>> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
>> @@ -204,6 +204,8 @@ v3d_clean_caches(struct v3d_dev *v3d)
>>   	struct drm_device *dev = &v3d->drm;
>>   	int core = 0;
>>   
>> +	guard(mutex)(&v3d->cache_clean_lock);
>> +
>>   	trace_v3d_cache_clean_begin(dev);
>>   
>>   	/* GFXH-1897: Ensure pending flushes complete before writing
>> L2TCACTL */
>> @@ -220,7 +222,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
>>   		drm_err(dev, "Timeout waiting for TMU write combiner
>> flush\n");
>>   	}
>>   
>> -	mutex_lock(&v3d->cache_clean_lock);
>>   	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL,
>>   		       V3D_L2TCACTL_L2TFLS |
>>   		       V3D_SET_FIELD(V3D_L2TCACTL_FLM_CLEAN,
>> V3D_L2TCACTL_FLM));
>> @@ -230,8 +231,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
>>   		drm_err(dev, "Timeout waiting for L2T clean\n");
>>   	}
>>   
>> -	mutex_unlock(&v3d->cache_clean_lock);
>> -
>>   	trace_v3d_cache_clean_end(dev);
>>   }
>>   
> 

