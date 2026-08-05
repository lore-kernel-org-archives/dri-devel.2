Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29508C56201
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F5B10E1DE;
	Wed,  5 Aug 2026 10:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dp38H6Dl";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C344710E1DE
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 10:59:07 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so500556f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785927546; x=1786532346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qChqnXEV/RUrII3F6FtB3OpL17H6S0GQj9i1G4DFOPk=;
 b=dp38H6DlGmX2s93DluGUKOXX4oeY6h1MWSARD0GFL+2XGLGfTQcLIu4UgbhoSkLoyn
 By/LEpI9v5CAM0toFUWJiQTGb6Ujl2uQpNHt+P4R+pquFwNxzZK4rwkx1QJjBR68/TC7
 XUUjSSNqRGI5FKZhl+N32sEAH88m0tcwgILune1kYUtvviGbgsVzcg50WF0JQuRgcJVU
 Bfk3ImJdcgI7r+Km8SjUM/i8HZ/b0Fchke2CNGsbuiH/0PceUIpw1HqCEDIFh/chy12+
 flLs/9TV86zCZmDUE6xn4eNgg4v5B1ZbbodhcINnTs+nhCB90bjQMDFQzb/RCVsVhVyR
 UCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785927546; x=1786532346;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qChqnXEV/RUrII3F6FtB3OpL17H6S0GQj9i1G4DFOPk=;
 b=jYNv2ywScaRxblockd8YqdKSLV4RUn+XH8871VHQm+H70YRbHkOdzsnaKrZtw78ofB
 qDngn1Db5CdJbtYRGDrwyGSb0hm476VJpTnncmxHTyqXFHgjgs0h+mXDLdAnKGfEJXZk
 b71ut4krDoyOcBLvrcmw+DEJ7rW4wMaSiITj2fcTZFDKkrbUEHzOvagnPqubLT9S/X0w
 drWM4AtaUaKUy72xZXlaiPhztdgT+6lv0n4kE8pVSQWwwapojQfSChLKBRBKFgi1HVcy
 tSUH2LdouI3I9zQvl8OYA9o6Ta5ogOW0zlVP9rrD95VdxkEu7pmqN5wXAHawkMgQGdXq
 dQ/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RokOdevcfI5JJrOeHa8wiZvlRfqYZB2FbrmnEN77gHU2Qz8NBx7F77Q2k/pyZbAOZg0PyqHIavmrN0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyacLhfGIvWc/8fKDHyADWf1gMEul3Ky6KV7/Tui22vgksxyNUq
 Ay/0iFPVazNIImf+6UhDb6uWQ4cLp+GYvkPK5uUlQrVilUrJHanCybzt
X-Gm-Gg: AR+sD11ImilmTcLpXYxoNfGzBWDNqSLF066rN0wY4Q3C9ZeiK69zLRcaHfYDNp2H7lX
 D6b54cF3j2nG9yytB6BVA84goVROX83Gph8IuJj5Tdkihgj+ef3ukhpfsPAbrdFM8PcG5DN6Yq/
 nRg7lc+p8ULpO0H6V7xYHejC81HJuBm/HlKtzX/H+60wO2jHqXeUJm/7ZVbo0hBRHnb/UkTBoe3
 +Qd2r+/eh3zezJV8O6OJWP4JpS82FMdjuGSLaUZgnYqiJomFhHt0FCqHngzQ46H3BTyNoWS5FTs
 nJN2+qvVA6QiP8ifJPAlKpjpIcMf843SUX7zl6g1AcK34bsbcjoEhVYKNvJlqxMDlX3W+9zulJd
 bmZ2pDnGHYPm2/C+0bCZzK7KoMflD1y9HLcJjgQSCAds1JFOInrLFwMaakAlEtK58C4RX2oKVkq
 C8y5d0DpIY+NlrTIvnbpwfgF4Wx72fjWvSeB3/LS6rvh2lUP0Stmf//9i+NiJLPLmyYwKFfbycA
 LR32wmquWb1tU3FBNznqDIGkHVX8kbsKmZqT9ao/hnRIhCTCkaXogIJPoipTZwfAE6u021dvQo6
 apNgWGvwf/B5vj88Q39BXA6AuP2cDDZpDY1RaWzSRiAXOMeh
X-Received: by 2002:a05:600c:4e94:b0:497:ff73:68d5 with SMTP id
 5b1f17b1804b1-4994e6c5eafmr60022735e9.0.1785927545848; 
 Wed, 05 Aug 2026 03:59:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e035900sm80665575e9.11.2026.08.05.03.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 03:59:05 -0700 (PDT)
Message-ID: <8285ede8-bebb-403a-8a37-b9987cd37a8f@gmail.com>
Date: Wed, 5 Aug 2026 11:59:10 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <181b08be-04bc-4ae9-bb88-15321a82440f@amd.com>
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

On 8/5/26 09:27, Christian König wrote:
...>> +struct dma_buf_io_fence {
>> +	struct dma_fence base;
>> +	spinlock_t lock;
>> +};
> 
> Upstream has change to allow embedding the spinlock into the dma_fence, so this structure here is most likely not necessary any more.

ok

>> +static const char *dma_buf_io_fence_drv_name(struct dma_fence *fence)
>> +{
>> +	/* default fence release kfree's the base pointer */
>> +	BUILD_BUG_ON(offsetof(struct dma_buf_io_fence, base));
>> +
>> +	return "dma-buf-io-ctx";
>> +}
...>> +static void dma_buf_io_map_release_work(struct work_struct *work)
>> +{
>> +	struct dma_buf_io_map *map = container_of(work, struct dma_buf_io_map,
>> +						  release_work);
>> +	struct dma_buf_io_fence *fence = map->fence;
>> +	struct dma_buf_io_ctx *ctx = map->ctx;
>> +	struct dma_buf *dmabuf = ctx->dmabuf;
>> +
>> +	/* the release path must wait for fences */
>> +	if (WARN_ON_ONCE(refcount_read(&ctx->refs) == 0))
>> +		return;
> 
> Stuff like that is usually illegal.

Should be fine, it's just a warning. The map holds a ctx
reference so can't be 0. IIRC, it was synchronised a bit
differently before. I can kill it, refcount_inc() has the
same warning anyway.

> And why are you using refcount directly instead of kref?

Not sure it'd make much difference here.

> 
>> +
>> +	/* Prevent from destoying the ctx while unmapping */
>> +	refcount_inc(&ctx->refs);
> 
>> +
>> +	/*
>> +	 * There are no more requests using the map, we can signal the fence.
>> +	 * It should be done before taking the resv lock as someone could be
>> +	 * waiting for the fence while holding the lock.
>> +	 */
>> +	dma_fence_signal(&fence->base);
> 
> Signaling fences has a whole bunch of very strict rules associated with it. E.g. you can't alocate memory for example.
> 
> Are you sure you actually need and want a dma_fence here?

Waiting for potentially a ton of IO synchronously on invalidate
sounds like a bad idea though. Hmm.

>> +
>> +	dma_resv_lock(dmabuf->resv, NULL);
>> +	ctx->dev_ops->unmap(ctx, map);
>> +	dma_resv_unlock(dmabuf->resv);
>> +
>> +	dma_fence_put(&fence->base);
> 
> You should probably set map->fence to NULL after that.

The map is freed two lines below, but I can add it as
a defensive measure.

>> +	percpu_ref_exit(&map->refs);
>> +	kfree(map);

...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct dma_buf *dmabuf = ctx->dmabuf;
>> +	struct dma_buf_io_map *map;
>> +	long ret;
>> +
>> +retry:
>> +	/*
>> +	 * ->dmabuf_map() will be calling dma_buf_map_attachment(), for which
>> +	 * we'll need to wait for fences. Do a bit nicer and try to wait
>> +	 * without the resv lock first.
>> +	 */
> 
> Clear NAK to that. Always wait while holding the resv lock if you can!
> 
> It is absolutely not beneficial to do this outside of the lock and usually just hides problems instead and prevent fixing them.

Ok

...
>> +	ret = dma_resv_reserve_fences(dmabuf->resv, 1);
>> +	if (WARN_ON_ONCE(ret)) {
>> +		struct dma_fence *fence = &map->fence->base;
>> +
>> +		dma_fence_get(fence);
>> +		percpu_ref_kill(&map->refs);
>> +		dma_fence_wait(fence, false);
>> +		dma_fence_put(fence);
>> +		return;
>> +	}
>> +
>> +	dma_resv_add_fence(dmabuf->resv, &map->fence->base,
>> +			   DMA_RESV_USAGE_KERNEL);
> 
> That sequence is clearly incorrect!
> 
> The fence must be created after dma_resv_reserve_fences(), otherwise you definately have an illegal memory operation here.

I'm not sure what you mean, can you elaborate? I only cared about
pre-allocating it to avoid allocations here. We add / signal the fence
only once, no reuse. The map is going to be killed here, and if we
create a new map, it'll have its own fence.

I can move the dma_fence_init() call here if that makes a difference?

-- 
Pavel Begunkov

