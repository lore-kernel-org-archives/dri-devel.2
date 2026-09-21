Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90733C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C0110E829;
	Mon, 21 Sep 2026 13:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sKLwOJg6";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B657E10E829
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:57:18 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a60590a85cso5615495a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789999037; x=1790603837; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ofpT4h/xZOk97T1LnY16xox+YwsLCtjUsNXPXQGc7Q0=;
 b=sKLwOJg6z9jH6cNNINQ/UdJqMS/pZD+4njbPCNx60JqbiAOi21BXL78vkKxmuHLGu4
 RrLukmgD2c7/VMMIDOeLbyz0bvusneHE57gaY1lQK4Mu2Gbxhxqaqk7MjnQKnWhUqfc4
 KLWPFhSwH3MbRGmk3b3/yNRvWgV1d5mHIA7hRZHDaipK61P6HcdOQg8KQVbWjkjU2394
 mF+wk9OU9jAcRsHsp8q2TrqzOKJ+OCni9O+wG/XwDHXcEuxyZugH0b1cSImjy15tgYg0
 u2UDd8cbdaVmPUtxYR9i6TE41U1G17LHLOTDmoDQ/R/bJBYKa+DiagFdVTKMoaFQA5F/
 qmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789999037; x=1790603837;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ofpT4h/xZOk97T1LnY16xox+YwsLCtjUsNXPXQGc7Q0=;
 b=MGaJfZ9HT0/MTzLsO4wC4KyOyk4UQBBb6fo7nhhwrtdcCtfWBmMxEhJH7YiUa2LKN3
 yAAzvuBlCbMwLycn+tKz1yHeU2aVoRVyKcirH4W6e+qhIJHXYoOQuYpzBOZ4cdd7ip3Z
 qkGawpa9he/6/M8q/JWo1dby74mcomHLzg2HMj8rXQUyRXfk+o/aN9rUzeIr2py/+QtQ
 vBpdwFsxkUFLQo+rKxHgwtFFEIF7m8CL1Zv+i3QTKZfHr649ElntmM/834DRLnOMs4rk
 JA0UFF4u60nLJEB0QkGUnvWqN1hFs4oWDiYkVhz8RNrJXoh0uAujArmROnzSjMHLj3JI
 mSEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWAwPitPoRNLISul4bqybTvWZUP+eWbwylo79bqGE1oBXx87OtJg2M+YgmOWOPQgUXo5Pz+8Z8Y9s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ko7Vj+TB3v9HYuPs00HJPjDym91YxzUbFB6oVQ0rMNPSoeTGv6
 EvaYYOzRa70wDza4tRLAGc0+8DcemQ3R8oG4lpPVikOXgZ0vMtb/6ZBX
X-Gm-Gg: AYBFou1ju9GN+Kw4lEZrn/6gPS7ASLZek/MizOQ42qJnvDuUFzdVh5dsFk/ZPRTKBtx
 unUFfzL8nXrc5JC4FvDeEpMO+2SmjGJ7GkP8xa23a6OVD9+j/5m7nmlVdNC7dSqNU1Y9N3zvrrt
 9kEhGRVEDkBc2lKtgzS5eGSylqGgOThPdmBnno/Ds6UIFqcrgtJmZE1DN3nhbW4sayd1uESeU+e
 5skwaaFfjATzc+RbbxtbBnaEbBnbXFmxLucEQGq/mRIm3easLtL0TSvnSjs+9kVn0JnlbZSer3P
 O3wjiMjhr8JuRZbDcPAEKCIDndFzfPaWutEZPe9jc++us8do+hLL3T+eKHA+2F1EnFtpPkru7+p
 A3SoaxKUCw86kj1YleK/E86RKz3CGC9LrCfdrXPldt0GenrjJ9YpOWJTaIxapMHpVFkUnPYg2bq
 P2rczhpV6BXjl7b+5U7PdLH9Q1pAkfyF26NKncBo9E3JvxbQXzZUg/4Yg2QbJzEimL/dK6CCXAc
 Ou/kFZTifre9smb7TXkbUmv0NL8BvChxPmzuyovmMz9lSKzId+cFAr7oUiH6riHe7+GoAuNNqnI
 FDN2/9F8vxyfx0ZiZW9ee0DTh5OrdDXSapNc
X-Received: by 2002:a05:6402:210f:b0:6a9:aead:4e98 with SMTP id
 4fb4d7f45d1cf-6aa577f5cfdmr8215865a12.1.1789999036894; 
 Mon, 21 Sep 2026 06:57:16 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa67e0d3c5sm4446691a12.22.2026.09.21.06.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 06:57:14 -0700 (PDT)
Message-ID: <a8b01e56-bc86-412b-862c-d6a3efef2e6d@gmail.com>
Date: Mon, 21 Sep 2026 14:57:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Nitesh Shetty
 <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <181b08be-04bc-4ae9-bb88-15321a82440f@amd.com>
 <8285ede8-bebb-403a-8a37-b9987cd37a8f@gmail.com>
 <0113c49a-a364-4df6-9ab4-681c789d9d3b@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <0113c49a-a364-4df6-9ab4-681c789d9d3b@amd.com>
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

On 8/6/26 08:29, Christian König wrote:
> On 8/5/26 12:59, Pavel Begunkov wrote:
>> On 8/5/26 09:27, Christian König wrote:
> 
>>>> +
>>>> +    dma_resv_lock(dmabuf->resv, NULL);
>>>> +    ctx->dev_ops->unmap(ctx, map);
>>>> +    dma_resv_unlock(dmabuf->resv);
>>>> +
>>>> +    dma_fence_put(&fence->base);
>>>
>>> You should probably set map->fence to NULL after that.
>>
>> The map is freed two lines below, but I can add it as
>> a defensive measure.
> 
> In that case it's ok, I've just haven't seen the kfree(map) below.
> 
>> ...
>>>> +    ret = dma_resv_reserve_fences(dmabuf->resv, 1);
>>>> +    if (WARN_ON_ONCE(ret)) {
>>>> +        struct dma_fence *fence = &map->fence->base;
>>>> +
>>>> +        dma_fence_get(fence);
>>>> +        percpu_ref_kill(&map->refs);
>>>> +        dma_fence_wait(fence, false);
>>>> +        dma_fence_put(fence);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    dma_resv_add_fence(dmabuf->resv, &map->fence->base,
>>>> +               DMA_RESV_USAGE_KERNEL);
>>>
>>> That sequence is clearly incorrect!
>>>
>>> The fence must be created after dma_resv_reserve_fences(), otherwise you definately have an illegal memory operation here.
>>
>> I'm not sure what you mean, can you elaborate? I only cared about
>> pre-allocating it to avoid allocations here. We add / signal the fence
>> only once, no reuse. The map is going to be killed here, and if we
>> create a new map, it'll have its own fence.
>>
>> I can move the dma_fence_init() call here if that makes a difference?
> 
> Yeah that is a good start, but you might need a bit more.
> 
> Here is a summary of the usual procedure you need to follow when implementing a dma_fence backend:
> 
> 1. Allocate your operation object, in this case here it's your mapping I think.
> 2. Prepare your operation, including all memory allocations.
> 3. Call dma_resv_reserve_fences() to reserve a fence slot.
> 4. Allocate and init your dma_fence object.

Looks I forgot it reply here, sorry for that. I killed dma fences in
v6 in favour of synchronous waiting, it turned to be less trouble even
outside of these fencing rules as I can rely on dma-resv lock less in
the code.

-- 
Pavel Begunkov

