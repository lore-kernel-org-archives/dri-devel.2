Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A272CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DACE10EC88;
	Mon,  5 Oct 2026 11:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IVjStBq4";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F4110EB61
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 11:49:20 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a0977b9c20so22168505e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 04:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791200959; x=1791805759; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tN32JBtkwvrpOHkqPOwCz1peQMff+9nW+9FnKuTc/9Y=;
 b=IVjStBq4M12OOafSTui54PvFqoZfoay+y1sGoVgsMNNznY3QZ5eop5u+p7JfouHt0N
 SfN9ii3uUz9wWNLCVMVIXMBcuNPO4i5J0SauDDuHRAGU4mg9wTDOHDI6JQZWzMfN8icu
 w3AEIr9vRk3HlgTDiKH2u/eujoySBKfLTKL0ZmaeT6TTEQf37SL629uAcs4WxZnICV7T
 AUN1pvvtTTPMEPNCwccgNG/STEIhrhZ5PtOfNZsB9SYkyt8B7ntBqNJQ/j69qFikQIDN
 n00WeeeYevWOG5+x4ZzshaeTBpg5pl9OLxnfvU4yBoGd1csLopLioqa6CMocZ9M/WEjc
 mciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791200959; x=1791805759;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tN32JBtkwvrpOHkqPOwCz1peQMff+9nW+9FnKuTc/9Y=;
 b=uCFiFnzb7WllZNJQ7UOj4NEw/fa7Lcxm85ZgZ2cDT7DQkp42QB28Rpdx1LxGXK83ZE
 eyfMZNSmKqoelOsEXG5iPpBskdhI3jZ6pxjxKs50DIfyJS+WUVKJv2VHiipeR7LH47Wf
 WXpxDiF3aROl4QwWCe5FLq1g4fsYD+rDZYCkDMRuDp+Ccz0pke6rwCtRkk7AKoH7T8jF
 uReF6i1qV1eKdeR7t0JLzkc0hzld2roYYpKoeMurDFUCsCskGnuldc8oKwJ7DllK0o3Y
 QZRlk+l74xqhz9sXibmitmq43OqRKjpadYspOHshuVxjsVvAEIMIeuCP8QG0HJLh6Pt8
 STuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPEwX2vw3QOy5GvSA2HwJLo4lnznBkxVD0pZBaXUVR1By1i1TjQ+O146jW9DSIv5Ki7CzI0aclm1Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKT7AaQ7IgGkF+5KbOjPDqHTPXK+TihOliaPnb8VxntQiKjoHt
 LLHs1VR77EewTfacuS0LK8KHV0XL0tl74pbLUsVOLEjf3gWHPHBeSM2R
X-Gm-Gg: AYBFou0n+CEErptNWT8M0TS3xEMrotJYt6cCnvCJuzZPcaz+nkgoqTP4tGMW9APz5lm
 C0Cfr9yn3C6XUbEuwuD7c2jZ+v+kTK8dS3d+nhwIGSiVZxm4rP1Oq8XpefdjKmhs4d1jABhyFOg
 b6Aw2sew3rXkXYX50gILsjhC3SEOK8KsRfqu663WDVNmE72V70N1svbPExf3kAm9POQhOCTZrQI
 x6elfFoCD4p3fHu7QeRDzvMH2zQcLjk7XJvxe+emtxx/OGuN09ihOET/P9iUMXLbrMJGtlRzcCp
 x33vM+9zFVRUQy4MHMSBSjH4KQ1n7lXA3r+RaPJCTmTwewkRPMLwO8gezy8lqSyACCRmkO7lQGB
 ihu85lob4DNovOrV3v1GAjWoFV33RVMCIUB3ONlzo0mgpi+fS3GCeH7ygMIHr7oU8H5N8Vx1l4R
 h20UQRtt6yd1LXj1Y+kziWQdSro5lHqtu37SXPvszk8bEVq3Q0X9jS6mObvy1eVVs+63SLzt8xg
 tpAvZy5M23F1u0XQ/9rJLw/tyFR9/9j51jnoP68zAROmVdBBP2qCIrC6WA+6y8qXmCMjRPsLMA=
X-Received: by 2002:a05:600c:1c08:b0:4a1:722a:d2a3 with SMTP id
 5b1f17b1804b1-4a1722ad405mr52583605e9.23.1791200959268; 
 Mon, 05 Oct 2026 04:49:19 -0700 (PDT)
Received: from [10.41.30.1] ([161.12.45.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027727cecsm346670305e9.9.2026.10.05.04.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 04:49:18 -0700 (PDT)
Message-ID: <c15a7ff3-121e-481b-93e4-466f89520ae4@gmail.com>
Date: Mon, 5 Oct 2026 12:49:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
 <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
 <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
 <c07404e0-33f6-4e5f-a80a-e1901b42dc39@gmail.com>
 <ar1md2N4PkoXSE/N@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ar1md2N4PkoXSE/N@gsse-cloud1.jf.intel.com>
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

On 9/30/26 20:43, Matthew Brost wrote:
> On Wed, Sep 30, 2026 at 01:48:49PM +0100, Pavel Begunkov wrote:
>> On 9/30/26 11:08, Pavel Begunkov wrote:
>>> On 9/30/26 04:00, Matthew Brost wrote:
>>>> On Mon, Sep 21, 2026 at 02:38:45PM +0100, Pavel Begunkov wrote:
>>> ...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>>>>> +{
>>>>> +    struct dma_buf *dmabuf = ctx->dmabuf;
>>>>> +    struct dma_buf_io_map *map;
>>>>> +    long ret;
>>>>> +
>>>>> +    guard(mutex)(&ctx->map_create_mutex);
>>>>> +
>>>>> +    scoped_guard(mutex, &ctx->map_mutex) {
>>>>> +        if (ctx->maps_killed)
>>>>> +            return ERR_PTR(-ENOENT);
>>>>> +        /* recheck under the lock in case it has already been re-created */
>>>>> +        map = __dma_buf_io_get_map(ctx);
>>>>> +        if (map)
>>>>> +            return map;
>>>>> +    }
>>>>> +
>>>>> +    dma_buf_io_wait_active_maps(ctx);
>>>>> +
>>>>> +    ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
>>>>> +    if (ret)
>>>>> +        return ERR_PTR(ret);
>>>>> +
>>>>> +    ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>>>>> +                    true, MAX_SCHEDULE_TIMEOUT);
>>>>> +    if (ret <= 0) {
>>>>> +        if (!ret)
>>>>> +            ret = -EAGAIN;
>>>>> +        dma_resv_unlock(dmabuf->resv);
>>>>> +        return ERR_PTR(ret);
>>>>> +    }
>>>>> +
>>>>> +    map = ctx->dev_ops->map(ctx);
>>>>
>>>> I'm playing around this code now.
>>>>
>>>> I think you need the dma_resv_wait_timeout after the 'map'?
>>>>
>>>> If a device doesn't support p2p ->map() will typically trigger an async
>>>> migrate to system memory and data will be moving but the map is valid -
>>>> Xe 100% does this, I checked AMDGPU and fairly confident it has the same
>>>> async behavior.
>>>
>>> There is a wait right before because I read somewhere in dma-buf
>>> comments that I need to do that, sounds a bit odd if I need to
>>> wait on fences before and after. I can add it, just curious how
>>> come that other dma_buf_map_attachment() callers don't need to do
>>> that. Or maybe they wait somewhere else?
> 
> In GPU drivers, when we receive a foreign object and map it in Xe or
> AMDGPU, this logic sits deep in the stack. However, the top-level call
> is typically ttm_bo_validate(), which in both drivers eventually
> resolves to the TTM ->move() vfunc. That path calls
> dma_buf_map_attachment(), which in turn invokes the dma-buf's ->map()
> callback.
> 
> That ->map() callback can trigger a asynchronous move on a different
> device, where the top-level call is again ttm_bo_validate().
> We then end up back in the TTM ->move() vfunc, where kernel fences are
> installed. I realize that's a lot of layers, but the call chain can end
> up looking like this.
> 
> Now we have a mapping and an object with kernel fences attached. Before
> the object can be used by either the exec IOCTL (batch buffer
> submission), the VM bind IOCTL (mapping into the GPU address space), or
> a CPU page fault (not relevant for dma-bufs since they cannot be
> CPU-mapped, but a useful example of a normal BO move), we wait on those
> kernel fences.
>   
> In the case of the exec IOCTL or VM bind IOCTL, the kernel fences are
> added as dependencies to a drm_sched job, delaying its execution until
> the fences signal. That is where the wait occurs. In the case of a CPU
> page fault, the kernel waits directly on the fences before installing
> the CPU page mappings.
> 
> So the TL;DR is if you want to immediately hand back a valid mapping,
> the kernel fences must be waited on before returning after ->map() call.

Thanks for the overview! I'll add the wait after ->map in v8

>> I can't find it, so maybe it was the comment below and I mixed
>> sth up back then. I'll move it after ->map().
>>
>>
>> * Note that for non-dynamic exporters the driver must guarantee that
>> * that the memory is available for use and cleared of any old data by
>> * the time this function returns.  Drivers which pipeline their buffer
>> * moves internally must wait for all moves and clears to complete.
>> * Dynamic exporters do not need to follow this rule: For non-dynamic
>> * importers the buffer is already pinned through @pin, which has the
>> * same requirements. Dynamic importers otoh are required to obey the
>> * dma_resv fences.
>> *
-- 
Pavel Begunkov

