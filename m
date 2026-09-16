Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653A3C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CE410E981;
	Wed, 16 Sep 2026 13:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NrG7S+UY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9AE10E665;
 Wed, 16 Sep 2026 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=X2rxwilczNJ6ldHARZUdKBvRtCkMFchMNSB1ii9fkZk=; b=NrG7S+UYe3WaWMj2cKDB/dU80O
 UtZ7RwfEmHvOUvah0KiMxldqn8ttnycG1Js/mLdipLaPDhoPA2f8vknKDT1FWToE/FMR/8PNWHOYz
 beXqpU7U2r1tJAmA5GxM0ZvYXF6EpLyUoYfgqRu8GGIbWrX7a5FddYJvkcJyKZfXzTrpMMUtoPjhK
 xYHlkfI5rhUXLAPhBK5aq5oto88zogJh7TeaQ1NBs311rzJs8D/6I9+1fBgojnV+bEplQRLdGmjGR
 JBoxJCuhkOWsbfYui4hhLW6TCctbbVBcDClIlzG32rK+MhKcJf3kzOyhlSPwDYSRAAvYOyb03dv8L
 FMIEZ2RQ==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x6pN8-002wbV-Tp; Wed, 16 Sep 2026 15:08:22 +0200
Message-ID: <3f134188-0af1-4c7e-8bb8-ddb2504c9efe@igalia.com>
Date: Wed, 16 Sep 2026 10:08:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm: Add drm_timeout_rel_to_jiffies()
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-2-f2ae987d861f@igalia.com>
 <c20c43109d3ebb08ad6a0c811ffaeb48f90efed5@intel.com>
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
In-Reply-To: <c20c43109d3ebb08ad6a0c811ffaeb48f90efed5@intel.com>
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

Hi Jani,

On 16/09/26 07:38, Jani Nikula wrote:
> On Tue, 15 Sep 2026, Maíra Canal <mcanal@igalia.com> wrote:
>> drm_timeout_abs_to_jiffies() covers the drivers whose wait UAPI takes an
>> absolute deadline, but there is no equivalent for the drivers that
>> express a wait as a duration. Drivers such as i915 and v3d convert the
>> value themselves.
>>
>> Converting a nanosecond duration to jiffies needs some care.
>> nsecs_to_jiffies() returns unsigned long, so on 32-bit a large
>> userspace-supplied timeout overflows its range and is silently truncated.
>>
>> i915 already handles both cases in a local helper, which v3d has a copy
>> of. Add the same conversion to the core, so that it is available to any
>> driver and both copies can be dropped.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/drm_timeout.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>>   include/drm/drm_timeout.h     |  1 +
>>   2 files changed, 46 insertions(+)
>>

[...]

>> diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
>> index cd9621c52062..6ee222a3e97c 100644
>> --- a/include/drm/drm_timeout.h
>> +++ b/include/drm/drm_timeout.h
>> @@ -12,5 +12,6 @@
>>   #include <linux/types.h>
>>   
>>   signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
>> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec);
> 
> The signed/unsigned differences here bug me a little. Maybe explain why
> in the commit message if there's a rationale?
> 

Answering both your e-mails, the rational behind this change was: don't
make any changes to drm_timeout_abs_to_jiffies(); only move it as it is.
As I'm the one introducing drm_timeout_rel_to_jiffies(), I took the
liberty to implement it in a way that makes more sense to me, which is
using `unsigned long`, considering that a timeout in jiffies should
always be positive. Also, i915 and v3d implement the function returning
an unsigned long.

I believe that drm_timeout_abs_to_jiffies() historically returned a
signed long because dma_fence_wait_timeout() takes a signed long timeout
parameter (I'm not sure why).

Best regards,
- Maíra

> I note that drm_timeout_rel_to_jiffies() return value is assigned to
> unsigned long variables half the time. I guess its kernel-doc could say
> it never returns negative values?
> 
> BR,
> Jani.
> 


