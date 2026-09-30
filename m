Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FEDCA5FBE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D093210E174;
	Wed, 30 Sep 2026 10:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f5fNJ6zv";
	dkim-atps=neutral
Received: from mail-ej2-f13.google.com (mail-ej2-f13.google.com
 [74.125.228.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79AE10E174
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:03:34 +0000 (UTC)
Received: by mail-ej2-f13.google.com with SMTP id
 a640c23a62f3a-c2e227422e3so40175566b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790762613; x=1791367413; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eCoj95WhFRCP2kPh50xeXjC6XymL7tbWMA/noa+qpCU=;
 b=f5fNJ6zvjN9q7UBvRTm5k8JENfTIDf3eor//Kr78CWXD0ahEvyJoxJrb0Fnr1TmodV
 ubP75EkYeLG8qFNmZK73HLzR1ahVEAJzmLHmf6CRFsIsh9G32S5K5PAXHDIb4o0eUhRB
 lUQyg7O4BPYkpUr/15+XXRyIj3ZLD8go/cSmcQkcNALq5/dsUyvC2kZxbmpjYWLAy207
 BOhP031uHsZE/wTU8V46fymDnlh6SRJfq135FPE8yNiSWKxHL6r5dX1jeAd9wT1QKM/7
 Z7wCKxgoOcz0VpLkoQopyv30OqONJhip2ie03PiK+ZZGURgP95Ux65XoLjm4nlzWTKw7
 KtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790762613; x=1791367413;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eCoj95WhFRCP2kPh50xeXjC6XymL7tbWMA/noa+qpCU=;
 b=cXag74vFoBpXXoqiO+EfCkc5niaxpat/mhP9Vh8hrMYKg8ngjHCao76miyj28xq/6n
 cypYnT+LuJcSs4Z1AUT+DRjIi6K+v89saXzEG3sllfhNcYLkV+TGhA4cOa8KSwWcVrB/
 Gqf9C3ceQ7TFxhJ3zZ1hAKfhsBZYWLL6KkBE+AQVfdr0yjVQudmbOfWn+flt8OmFMWv+
 19qfeQo20VksN4vWEgdneaoJQoLY3huopWtEUzyb2uF45x6elasHSPQai9bWKkY7WVAj
 HDep7229rbLp+Ym3mrRQHGt7QNqwrxE7sYei/4WSwPBE3HrOItS4gnm/rrXm5Ce7yQ2Q
 5WJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHCp4AdqtzNwX0S+OlViN1dqv4SufkFfMQQ3brRtrX+ZV/A/fiezRzvkG6BBI3LZD/8JPtICGdicE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mVsZ9E189ZnEUYx/fRwh57FHfmV1/uc/JaswczbDNr6Im/b8d8
 GZXFMskP6vCx25nRjYK6BIunCtlReNRNiLW37FYZ1LlkzSuFRklDf5L8
X-Gm-Gg: AYBFou0Ni0gLueBk7F90khv83BB778mL9zjG+hTwT7NmSS8FYGl0xkKV4rv5jsSxoRd
 Z7+v1//2PGvimbgzXZI2+h+W4LekR8y9cOHuxh/UReFpNWLHUVFYK+6sHDNnexszBXxrMV0XZEn
 uNyupyZ08kQi+TafjYqZmB1Z+QLOByFEXIl9rOaizesrmZZOn90TQ/XT7P3YTQfHDe0gbspeYoW
 kF4VkY919HZEmwDdw0/bIaa77G8wIKIsrN2xehCiUHvIT9VV3bFEK/euhe7UkR17lvB0cIIsgAk
 ZgKlxQKwVQnl39w+OwDhWFc7T5EWODRaw4NH8vvGZNsQD4J6OJ85V0s3nsIJ36l8w1VbEs4fFR1
 VHH/6VxpGtWRRnt76vsosLtbt8WcpUgEzmKd/zrZVzbq8aMLyE4/NKo/AqAxdvcHhdPmc99P/ee
 o4FvbKQ3Uy0+RK11wIZU9brqIqNIDprK0psC7VqZjTNw9E4NXBzOD5YmsQWYOTYlQwfRgCX9sTF
 Sv/apj681JdtgLndWsSMiawZYVBd+6PFL6SGNT+n0fiWuP5cDKKpvFxSLcCvbwJ216ouAgHYKRf
 dvpJmEXm2C+b4pNHjl1tQZB5tXdoIyMpVoZytXrVfXYSGU+tTHPi2O4nbZc=
X-Received: by 2002:a17:907:3e97:b0:c29:f5d5:5aa1 with SMTP id
 a640c23a62f3a-c2e23e1a588mr68319966b.43.1790762611323; 
 Wed, 30 Sep 2026 03:03:31 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e22f4316csm40646266b.15.2026.09.30.03.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 03:03:30 -0700 (PDT)
Message-ID: <387993f3-9cea-4725-aba8-536fd6234428@gmail.com>
Date: Wed, 30 Sep 2026 11:03:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: Matthew Brost <matthew.brost@intel.com>
Cc: sashiko-reviews@lists.linux.dev, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
 <20260921135344.035B81F000FF@smtp.kernel.org>
 <17884261-52ab-484e-a39a-01e67f7a1d2e@gmail.com>
 <aryyKMFpgK9JYQr0@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aryyKMFpgK9JYQr0@gsse-cloud1.jf.intel.com>
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

On 9/30/26 07:54, Matthew Brost wrote:
> On Tue, Sep 22, 2026 at 10:08:38AM +0100, Pavel Begunkov wrote:
>> On 9/21/26 14:53, sashiko-bot@kernel.org wrote:
>> ...>>   }
>>> [ ... ]
>>>> +int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
>>>> +			struct sg_table *sgt)
>>>> +{
>>>> +	unsigned seg_shift = ~0U;
>>>> +	struct scatterlist *sg;
>>>> +	unsigned long tmp;
>>>> +	int ret;
>>>> +
>>>> +	for_each_sgtable_dma_sg(sgt, sg, tmp)
>>>> +		seg_shift = min(seg_shift, __ffs(sg_dma_len(sg)));
>>>> +
>>>> +	ret = percpu_ref_init(&map->refs, dma_buf_io_map_refs_release, 0,
>>>> +			      GFP_KERNEL);
>>>
>>> [Severity: High]
>>> Does this GFP_KERNEL allocation violate DMA-buf locking rules?
>>>
>>> dma_buf_io_create_map() calls ctx->dev_ops->map(ctx) while holding the
>>> dmabuf->resv ww_mutex. If the driver then calls dma_buf_io_init_map() under
>>> this lock, the GFP_KERNEL allocation could deadlock if memory reclaim
>>> attempts to acquire dma_resv locks.
>>
>> Most of these look trivial, going to fix them. This one, however,
>> doesn't sound true AFAIU, I haven't heard about any blank ban on
>> GFP_KERNEL allocation under resv lock.
>>
> 
> I can confirm this definitely not correct - see dma_resv_lockdep it
> acquires dma_resv then fs_reclaim_acquire(GFP_KERNEL). Shrinker enter
> direct reclaim and try to take dma-resv locks, but not block on the
> lock.

Just to double check, I believe by "this" you mean that the
sashiko report is incorrect. I'm going to leave it as is, but
let me know if I'm wrong.

-- 
Pavel Begunkov

