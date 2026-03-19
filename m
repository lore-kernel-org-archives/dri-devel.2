Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACD5107527A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3D310E91D;
	Thu, 19 Mar 2026 08:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Ol5dRrPd";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF94510E91D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:50:55 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso489683f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773910254; x=1774515054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uoOuKJHYCdrx47B8tUzvGBTD6AGVU3PPyUDBwcbLhxM=;
 b=Ol5dRrPdB0PLkau9yAyxaN/LHu/cIaE2eI18kDcW8r8RBKyJekhbbDGgcIVU58iuSk
 oviRtO4dUh49auNI5vxCLXSKkNXOMlrSwUH4Wg0DYTckaJoCLzoehbR9oq5H1jYe/Ti/
 0CyJbCKuQMj2qprsxNCDmxXVLG5NIYumeClXWTaADjFF1+ents14NANPMAVOw8rpdSRj
 uYHCjTYubzpfApY+/qzqO4FCnQP852N8OphiyOTsdyEMSX8Y+AQhNPaARzE+8mvLZnlY
 amuQZW/AcO/Ybp3amBWAx5Z6o4eBYf7BrfLhFqxich2IwhWAfaogroreby2g8fiOqT/3
 IqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773910254; x=1774515054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoOuKJHYCdrx47B8tUzvGBTD6AGVU3PPyUDBwcbLhxM=;
 b=oYE8n+M3OjH7nSpzxmZMh7wO8Wg5Iz3SrHaEDRz5O6XgHPxuRORiXXyIXkCPltPVtV
 aMeNcII0/jb6Y9EaBLMs2E1+y1vCZ+G2WewlqQAN2nAI/9F6r+kJJrU/RiwRiGk7JFH3
 CXXvPyEjpQlSR909cffkg0zlVrbxeyqrc1NbGBb/452wH3RtzMdFW7KXYkUvUA6hpURf
 o71415Dfnw4yqZXWV9VewG4jE4LIxrbN4wLUhnrvm8x3i7/xxK/hywgbgchqGobZc1r7
 bHruM3M8y3q6G0VSsbhHTyQN/1kon8wk/mUelu/6bXivZdYxTCj7B942Qi/ck9KVglFk
 3FdA==
X-Gm-Message-State: AOJu0YzpWn2gMYnhgjZ8rDDtHWhEYOWyGBWQSXVfhZqGfVvALmGUwenq
 GUYifrIloo28jqFA9VHxpY2O9HRKdvpjysAsaHtV5vJ429z76ATL7Gpf+eAL+bz62Ps=
X-Gm-Gg: ATEYQzzwDBGZnFU2fY59L7xMc+P+mFm8PmxTNoO2JCECL73Qt43UYFIHh9nUDvpCv7R
 XLX26fA3Fjti0SijoXkeSncGjnFAVkkQv3eT2rLxoYoYcqjrRRQIra5o/f2fmicPtvzpl0E3+3x
 r6wscABYpzgcCTpbMa3EfZ1jl+ArVswvjR4Qx8UsE25sDizKV4YslruKe9a4q96zE8POscmZP0D
 ov9q3FS7L4dl0u7a3ENgOKwGKH2C7sKGfUxSH6zb3VjJ73mJWpI9d6JCHco8FDB8LQx/FIhd6WL
 OMmhstFOHXYGN+5SxWONLKC4fRuO0jtJPpv/0NFVvkfmcAYcYjU4kwZaMHNFQQbUqgJlY3l8afr
 oK1L90req99Uv661q2Fz9yw7JHW2oRDUv6ctH8mrsPkHHHKPvF6SqYMvyiXZjtrRoKf3N7avcy8
 A4tBOdf+We4tJF52NLTIPsdwBqjqATfIZKdZYZQLCb5flT
X-Received: by 2002:a05:6000:2c0c:b0:43b:4960:60f2 with SMTP id
 ffacd0b85a97d-43b527cda0dmr10699686f8f.47.1773910253957; 
 Thu, 19 Mar 2026 01:50:53 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852097sm14386202f8f.9.2026.03.19.01.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 01:50:53 -0700 (PDT)
Message-ID: <a9213f65-6747-417c-9b7b-7b2ed0a5c3d9@ursulin.net>
Date: Thu, 19 Mar 2026 08:50:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Add new KUnit test suite for concurrent job
 submission
To: Marco Pagani <marco.pagani@linux.dev>, Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260219140711.3296237-1-marco.pagani@linux.dev>
 <e215efdd-c547-4ce4-affe-7198ed37c2a6@ursulin.net>
 <4793f2a5-9b08-4cd8-8e1e-d8a3a7125299@linux.dev>
 <3ac5825a-95e3-4b9a-aa7e-9b0107fa7b6b@ursulin.net>
 <7281dcf3-5c1a-47fa-81d1-ebf701d2cf81@linux.dev>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <7281dcf3-5c1a-47fa-81d1-ebf701d2cf81@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 18/03/2026 17:23, Marco Pagani wrote:

8><

>>>> Alternative approach could be to set a per test time budget and just
>>>> keep the workers submitting until over. It would be simpler to
>>>> understand and there would be more submit/complete overlap.
>>>
>>> I agree. Using a test time budget and having workers continuously
>>> submit jobs until it expires would make better use of the test time.
>>> I'm thinking that the simplest and most straightforward approach would
>>> be to cyclically distribute periods among workers until they reach the
>>> the largest possibile value below test duration, which would coincide
>>> with the hyperperiod. This would also solve the issue of selecting a
>>> suitable periods_cycle parameter that you mentioned earlier.
>>> In practice, something like this:
>>>
>>> drm_sched_interleaved_params [...]
>>> {
>>>           .num_workers = N
>>>           .test_max_time = T
>>>           .job_base_period_us = P         /* Small GPU job, 100 us */
>>> }
>>>
>>> period_us = job_base_period_us;
>>> for (i = 0; i < params->num_workers; i++) {
>>>           workers[i].period_us = period_us;
>>>           period_us *= 2;
>>>           if (period_us > test_max_time)
>>>                   period_us = job_base_period_us;
>>> }
>>>
>>>
>>> What do you think?
>>
>>
>> Again some time has passed so rather than going to re-read your patch I
>> will go from memory. IIRC I was thinking something really dumb and 100%
>> time bound with no need to think when coding and reviewing. Each thread
>> simply does:
>>
>> ktime_t start = ktime_get();
>>
>> do {
>>    .. thread doing its submission pattern thing ..
>> } while (ktime_to_ms(ktime_sub(ktime_get(), start)) < test->time_ms);
>>
>> May miss the time target by a job period_us but who cares.
> 
> Sorry for the delay. I got pulled into other things. I left out the worker
> execution part since we already agreed on that. Instead, I've replied with
> some pseudocode describing a new strategy for period assignments from test
> parameters that takes into account your comments.

Sorry I misread when I saw test_max_time clamping I thought it was about 
runtime control. I guess it makes sense to clamp it to avoid 
over-shooting by too much. You removed the cyclical nature so I guess in 
practice this will not happen? I mean number of workers vs base period 
you don't expect more than one of them to get clamped?

Regards,

Tvrtko

