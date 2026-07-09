Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E4FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE8E10E53E;
	Thu,  9 Jul 2026 07:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="l9cpXVCT";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DDD10E53E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 07:36:39 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493b7612475so12973655e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1783582597; x=1784187397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ykv1Gg8TEg7oJaJLPkBJ3p4DRQzUQ1x6/Z28sb6CbPs=;
 b=l9cpXVCThRMJY2SJQszfzfDbFiM+b3+L8IyT2GifDx+jhgJLuBYlb4KekADP6rrFq5
 1mMQXUx4Kp3PH3wFCpTd1an2LFQ5xCXU2icToDzEvKa5xIwePL6sHq5JpSdfMIomRM7o
 qvoteT6aLHIPH6FprbifcXVEUW/2mgBi8tFds77NdK1HhZZH6AyfQW/eiy5VfJqihYmw
 C1B4bBpE2E/+U2oOWKfpmAcg9t/PFUagTVgPQ3kbikD1tWVL9kdmKDprdOw4u8erCJNX
 A0jOVvz+IuIJFzGX63Jlw4fHZnBkmCzGYJxI/kr3pSwC3vA8O9Aa3b0qq2nfYMpSB8Nf
 1A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783582597; x=1784187397;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ykv1Gg8TEg7oJaJLPkBJ3p4DRQzUQ1x6/Z28sb6CbPs=;
 b=lFl0XrlKjbcCxYQx19udZxBQKBJK8syjmyRenzgN6zARiYurT1FKN4TIwJBq2rHo2I
 SUP2s7piH28y00pfsyI74ucxNuJCDxXsXPIIKe45uyt+poxaxBWBT8xlP3HJX1F+hqcW
 xW7B3eVIgCOIWaaZwHrIWVdCd2xeWYa0Fcf6TtwmZUpp7y1QWZcECIQFnmStDtydWL8A
 05wr69bOh8g/tZ7Gz2va0I9W0WG0yExr5k1EUOjwVYZKSSjtRXe9MiK/L9AHEQrdgM4d
 rQooaUTAj5TWiFvyEVVjwVeh8emfNWOwwUFo9iDRRLsTGD0F4pfsz0RcpfPsF9cthkAs
 3jBA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq29T47waklA3O6vx46uZHQ1VeHcmhqvXKszTrZimDCjWEVlBG14RSTtaqlKnGf40uYImoSNyOqRl4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7VJsQPpBakB8lWWGftuULbxziR7c4U4RwzowLv3sSU9GaiPml
 FpcDQbuqWKdBBb8vT2HqJwHWY2kM6N+ERI2WEZ5IXw9ZOBpjO/dm2Fhz+Y8750lLgig=
X-Gm-Gg: AfdE7clNplwUR1U2lbp+hRepm6zI9IlaR5N9b/kXB/tZ0L87q5DtEwXEGd/i/gi1Ml2
 UIjahumm19hu1HnTvqompESApY4xKIHcTICnrclA0Ut9nRObGEPtQ2yL+V+H1WXayjMiWoVzlxy
 aOiva0oPujYSjA7IFcHUosyA1jRxjIj3rbNLsYf7IImfY7ThUCpLsLn3c1BQ06jkStEUOBaAmFT
 NpGhZKAkaifpyBRtK/aJoy6e5IE1QvgxSDO1N+fcbusI/pmYrbcB3WvwsqDfp6itiOGrVJrPeUE
 9twgC2aRQsDtDqdhbCA81DZVG7gksvpfhQF6soDW7WOJcX9JSBIiZUiwOKF78rhzgySuDdn3pCf
 XJk9RZ6HVketpyQPJ9Y0HDxZboPe26izfS1QhmCUcrcfLe8lCNmsNEUBWhYDZTvZJLtpBCBC/FS
 r1bAhDukYhVwg5Eciiqy5DenyThNUGmxCIzw==
X-Received: by 2002:a05:600c:3516:b0:492:3e66:6c84 with SMTP id
 5b1f17b1804b1-493e68782cdmr58719135e9.30.1783582596744; 
 Thu, 09 Jul 2026 00:36:36 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6e0e5asm41503265e9.9.2026.07.09.00.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 00:36:36 -0700 (PDT)
Message-ID: <27702403-4ecb-4f83-ac02-080a689d94a9@ursulin.net>
Date: Thu, 9 Jul 2026 08:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gt: use correct selftest config symbol
From: Tvrtko Ursulin <tursulin@ursulin.net>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260705080225.436-1-pengpeng@iscas.ac.cn>
 <6b551a44-96fe-4429-a337-9e6a32ac5156@ursulin.net>
Content-Language: en-GB
In-Reply-To: <6b551a44-96fe-4429-a337-9e6a32ac5156@ursulin.net>
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


On 08/07/2026 09:41, Tvrtko Ursulin wrote:
> 
> On 05/07/2026 09:02, Pengpeng Hou wrote:
>> intel_engine_user.c checks CONFIG_DRM_I915_SELFTESTS before running
>> the engine UABI isolation check. Kconfig defines DRM_I915_SELFTEST,
>> without the trailing "S", and the rest of i915 uses
>> CONFIG_DRM_I915_SELFTEST.
>>
>> Because CONFIG_DRM_I915_SELFTESTS is not backed by any Kconfig symbol,
>> the IS_ENABLED() test is always false. Use the existing selftest symbol
>> so the debug/selftest guarded path can be reached when selftests are
>> enabled.
>>
>> This is a source-level fix. It does not claim dynamic hardware
>> reproduction; the evidence is the Kconfig definition and the inconsistent
>> guard in intel_engine_user.c.
>>
>> Fixes: 750e76b4f9f6 ("drm/i915/gt: Move the [class][inst] lookup for 
>> engines onto the GT")
>> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> ---
>>   drivers/gpu/drm/i915/gt/intel_engine_user.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/ 
>> gpu/drm/i915/gt/intel_engine_user.c
>> index be4bbff1a57c..d5190e11b270 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
>> @@ -259,7 +259,7 @@
>>           p = &prev->rb_right;
>>       }
>> -    if (IS_ENABLED(CONFIG_DRM_I915_SELFTESTS) &&
>> +    if (IS_ENABLED(CONFIG_DRM_I915_SELFTEST) &&
>>           IS_ENABLED(CONFIG_DRM_I915_DEBUG_GEM)) {
>>           struct intel_engine_cs *engine;
>>           unsigned int isolation;
> 
> Looks correct but we need to have a test run done to see that the checks 
> this guards actually pass. Please stay tuned for results and please do 
> ping us in a week or so if we forget.

CI was all green. Pushed to drm-intel-gt-next.

Thanks,

Tvrtko

