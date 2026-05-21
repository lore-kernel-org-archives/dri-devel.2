Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDE7CD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 07:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2168010E472;
	Thu, 21 May 2026 07:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="F6xmE+q5";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33EB10E472
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:36:34 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso63244565e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1779348993; x=1779953793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aeSM2g8bZVLAD7HoUus+r1iNqBJclrQDqDOcugxmg7E=;
 b=F6xmE+q5uSHorCW6dar3MyLNON7DW+xMNY5+Sp/h8nf6uwku6X52LWikqlGW9nLdka
 xMQrpRdOtXovb+rmKUQEWDEIeXH5Fvh2f1N5gQs7wbOHSXgJSiOWmrpBFfcoElvzcQfM
 +EJ92KwiWMYdylASJVCNqedy1mVBSer70Smnh4B+Hc5j9KG0WjYqn5XrBg5tsY+VtYdn
 dbBOcbWKGaz+ELkBAO/esBpF0xvZW4Q+gzcgsru0cwJQd8r/RbC+OzNCiy0sGShIzXYU
 FMOUg5erafD7J2iMr/+TitAwF8SYea7Dznx0Bdq3nSRn19AFA2KwquXffBzEYk9QwVla
 e0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779348993; x=1779953793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aeSM2g8bZVLAD7HoUus+r1iNqBJclrQDqDOcugxmg7E=;
 b=LRoPEWGA50sI+4DsNInaOoSdGh6d2T4+WbY390Vlm1W2GGtSdiAn6WPDiyByw5cXoY
 KqLn/cCIcgRLNW7MZtpGL8G9EDpb9vY+3tWo1QRqtNMCcHH3ExVJlywUqT7xoNCZsZv9
 YsO7jG3XdzK5beCGb37hh+hA08a0oCmCgtbFkjJ80oUlGQIDq+Em+EoS8Go5wXhVecfH
 V2XJqaVxh++bgFsCFPAmpeIhZWvIbc8QveGY2Q2oDXNYWD7zbmmR6a/BEY2M0ik2uQU7
 3LSei1MkhyJsmkixLDRz0+Sh5EXcDrCcGnwcOK4YgzBtZ/w+HNPozdBPf+k2R/v3Puqn
 Oc0g==
X-Gm-Message-State: AOJu0YzRhnQo4eyATQOChP1n89HLblQTC/2QvujSQq2B0aQAxIs3vdIY
 QnzqlNTkGGYKg1ZK0PTOFeiILkssHGnDAk0cl7TWV97Ue4GfS9TnaxtJE+nNJnmbX0o=
X-Gm-Gg: Acq92OEcdrqGR4tLO4RVDUgBbZHHwBNTAsMkIBO6PcNyHJNoYyt5r5VAEmbXEl8h3JQ
 bI9JGgWRPJvuG/uXzRYJR2DscIn4Rp29VPk/7udLvyP0jnkNulhV8WMbshrSgZiWxW7C7/wKT+0
 5dS/2X13YrJDKIhfOzQPGFBhD7pHvcQ+KQpIvmZL9Qs90wmfST8dM8MRwxBwN5wXLtlqa/yKQc3
 drzw1JCYbDNyY7CA79TL1s0Z07V8+L9erItEk7lYD0NdD2R3mhEFTyjxCoI4Tx/ZQw1UeIhSR0P
 6ReDiYEU93/A1uQnnWThYe5D0uqXmazx3jEN8JWdNjFiHd/8V2AqZ0Q0r5MFuclQqxdInvARo0/
 6OPuriPNqkaPjPStE5MyuSnVzh8quzqUrm8wPuxv1tjpK7UySb3Mshpj2QsSkdZh85MNeGoQTjB
 JWt5oLus5uHC+Cp6kCfNBFUZtHwOgg103Z5IWMsmbd1Nwc
X-Received: by 2002:a05:600c:3147:b0:48f:e44c:e058 with SMTP id
 5b1f17b1804b1-49036035212mr20529925e9.1.1779348992976; 
 Thu, 21 May 2026 00:36:32 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c9a5108sm6225945e9.6.2026.05.21.00.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 00:36:32 -0700 (PDT)
Message-ID: <83f498ef-aaa8-4b96-9dcc-9dbb4d91b80f@ursulin.net>
Date: Thu, 21 May 2026 08:36:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ttm/pool: Use sentinels in debugfs
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
References: <20260427162253.682415-1-mario.limonciello@amd.com>
 <8c2c205c-1930-4f4a-a44a-d51163ae5648@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <8c2c205c-1930-4f4a-a44a-d51163ae5648@amd.com>
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


On 21/05/2026 05:30, Mario Limonciello wrote:
> 
> 
> On 4/27/26 11:22, Mario Limonciello wrote:
>> The values in the `page_pool_shrink` debugfs file should recognize
>> the sentinels rather than causing an underflow.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5218
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_pool.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
> ping?

LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ 
>> ttm_pool.c
>> index 26a3689e5fd90..4e83f4978b136 100644
>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>> @@ -1335,15 +1335,22 @@ static int ttm_pool_debugfs_shrink_show(struct 
>> seq_file *m, void *data)
>>           .gfp_mask = GFP_NOFS,
>>           .nr_to_scan = TTM_SHRINKER_BATCH,
>>       };
>> -    unsigned long count;
>> +    unsigned long count, scanned;
>>       int nid;
>>       fs_reclaim_acquire(GFP_KERNEL);
>>       for_each_node(nid) {
>>           sc.nid = nid;
>>           count = ttm_pool_shrinker_count(mm_shrinker, &sc);
>> -        seq_printf(m, "%d: %lu/%lu\n", nid, count,
>> -               ttm_pool_shrinker_scan(mm_shrinker, &sc));
>> +        scanned = ttm_pool_shrinker_scan(mm_shrinker, &sc);
>> +
>> +        /* Convert shrinker API sentinel values to 0 for debugfs 
>> output */
>> +        if (count == SHRINK_EMPTY)
>> +            count = 0;
>> +        if (scanned == SHRINK_STOP)
>> +            scanned = 0;
>> +
>> +        seq_printf(m, "%d: %lu/%lu\n", nid, count, scanned);
>>       }
>>       fs_reclaim_release(GFP_KERNEL);
> 

