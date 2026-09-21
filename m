Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3292C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E9810E7E5;
	Mon, 21 Sep 2026 14:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h28fSkQV";
	dkim-atps=neutral
Received: from mail-ed2-f26.google.com (mail-ed2-f26.google.com
 [74.125.228.90])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBECF10E7E5
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 14:00:37 +0000 (UTC)
Received: by mail-ed2-f26.google.com with SMTP id
 4fb4d7f45d1cf-6aa13e194easo4693196a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789999236; x=1790604036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YF4hTPZsf1CzF+RjsRJpL1NqJMDoLq3jkvr85glNVqI=;
 b=h28fSkQVOgUobfDGMjlWylr/ateg1uNrw+1sh8cifhVBxMv9hLihrBsmIlsECgu4+C
 4FC+rfPa9qfv/KTM5vGqeUf9tzU+JgH4D1tWXbk2qZG4e5LJ1qA3faq3pBRHqwpZd/6T
 EXilMaqqXQ64gynqPkEeD8HNFeIsfcJI8V9/ki5qwY+cVHNKFPd5tk0yP6b8MGMcbxqT
 Wwcv3uNNfksDgVC69MM9wWejaBqawBN70jrGbifAkiFWrCQf2ZFSL0JUxRgnrjxlFqA1
 M3iCTjVrmXx7zE30zC6kvBo+3IvIBdoUsodBA0y74dUZ1LFvzDog4ZOHOfh5W7KY8ibI
 qIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789999236; x=1790604036;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YF4hTPZsf1CzF+RjsRJpL1NqJMDoLq3jkvr85glNVqI=;
 b=wzMFh2votuLfDmgQdy+u/w67c7Yqyw7+AY1MtWOo6pBD3i/HUGTLSEF1Cy4AEuLXqk
 M3zhvHIgNBcwJGzid6zRX3geq05FmR8bT9pls/xBEdl/HJrl8Kjwg4N6U8vi8i8L1zzg
 atgYnz30iCE4zVr2RHk6vSp87li4BG3dfGSKMws5mPiVIwtaEFWUz3QBAnGwbh1ujVOj
 tCJAmvblRSvEI4D1XuBJnb8crG/znjdJzhqKrKGLf1dIaNkFiZKijYjfimC/h9Yn5kzV
 4fGfipLAKxeXV3gnaScucTmopqLUFXJYWb9HNFK4fj5f6xA/2gyDofInBpYwPlbJnTWZ
 uVYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWhWoe00ca2eGdiX+F86EF7d8A6Jqszo2vouu3s5FvMYmIliovvjwZiwOyMszwh2swh+JnKiPUPEo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mu7yoyI34bpwYgoBYpIo5VpPuoe4E+D4RmcmZLRQYAV+097tXd
 GtqJphHcODBnbyu4ULD/mRq6L0y7LVNTp0ukC6/TaWCuv+2lsZfVDhaY
X-Gm-Gg: AYBFou1nLp5I1IL2pGgunHvEhqUYQ5HcTLkKn/UAlQI42K4it4K8meg1Baf74slUQH6
 z4jmD0c45ro83B2xIvBJ5yQB71QWzNGeS0IHEO5z/ukjSCJ11BeomdMyEs8SfgmkoalDBrlkvSp
 v7fVkozyjaalvOZ49YkiTZR/oLOk6osOtFBq8YiRy6UWRbeGtB0dnB+eMbSQrksN0jd3VeG0HzF
 hTyOy/LjbMtc3DikbTIknigpNA9FvTKNjblwrljxcVXqxhZOSF/t02gwyGec5HzXX2pynfqW5IC
 ggujbzWw3HQUZaqtmxzgz5MPbztZDXnwx8sug5GgVj9/wE3fTbeeSfGF0Ihmhyys1Hs/+GZK+Rn
 LMNnvK4Hps03ajhwAOeYTdXy08vdZdln5SZ3/HAwyF0QewXTbU+cqJyFLU0MUxP5zt/Di+AelZv
 a55att0f85zpPEMHE/focMQhpFrni7JO6SSvrUjL9VOMmJSIHmleWhd196gP+Uz8A1WN8igDXYN
 AoIoi8c1CCLsdR7G+40zCrFbJSHBSUy147JDX8FTzHz2H5uEkUOpunf4LDospa92mmbPNlsEapB
 8QdMIr6mtzV1iWM3pYHo2G7bTQ==
X-Received: by 2002:a05:6402:210f:b0:6a9:aead:4e98 with SMTP id
 4fb4d7f45d1cf-6aa577f5cfdmr8223981a12.1.1789999236010; 
 Mon, 21 Sep 2026 07:00:36 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa67e1a45esm4427483a12.25.2026.09.21.07.00.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 07:00:35 -0700 (PDT)
Message-ID: <14db93d0-b41b-43c6-8934-82d10cc50168@gmail.com>
Date: Mon, 21 Sep 2026 15:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] Re: [PATCH v4 01/14] dma-buf: introduce initial
 file I/O infrastructure
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <anPlbjhpPmj2VZxm@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <anPlbjhpPmj2VZxm@gsse-cloud1.jf.intel.com>
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

On 8/6/26 02:37, Matthew Brost wrote:
> On Wed, Aug 05, 2026 at 10:27:49AM +0200, Christian König wrote:
>> On 7/28/26 23:29, Pavel Begunkov wrote:
...>>> +	/*
>>> +	 * There are no more requests using the map, we can signal the fence.
>>> +	 * It should be done before taking the resv lock as someone could be
>>> +	 * waiting for the fence while holding the lock.
>>> +	 */
>>> +	dma_fence_signal(&fence->base);
>>
>> Signaling fences has a whole bunch of very strict rules associated with it. E.g. you can't alocate memory for example.
>>
> 
> Yes, and the rules around signaling fences from worker threads become
> interesting as well. In practice, the entire workqueue (or any work item
> scheduled on that workqueue) effectively becomes part of the fence
> signaling and reclaim path.
> 
>> Are you sure you actually need and want a dma_fence here?
>>
>>> +
>>> +	dma_resv_lock(dmabuf->resv, NULL);
> 
> So this is illegal because code is allowed to hold dma-resv locks while
> waiting on dma-fences. See dma_resv_lockdep / __dma_fence_might_wait /
> dma_fence_begin_signalling.
> 
>>> +	ctx->dev_ops->unmap(ctx, map);
>>> +	dma_resv_unlock(dmabuf->resv);
>>> +
>>> +	dma_fence_put(&fence->base);
>>
>> You should probably set map->fence to NULL after that.
>>
>>> +	percpu_ref_exit(&map->refs);
>>> +	kfree(map);
>>> +
>>> +	if (refcount_dec_and_test(&ctx->refs)) {
>>> +		/*
>>> +		 * Destruction needs to wait for I/O and dma fences. Defer it to
>>> +		 * simplify locking.
>>> +		 */
>>> +		INIT_WORK(&ctx->release_work, dma_buf_io_ctx_destroy_work);
>>> +		queue_work(system_wq, &ctx->release_work);
>>> +	}
>>> +}
>>> +
>>> +static void dma_buf_io_map_refs_release(struct percpu_ref *ref)
>>> +{
>>> +	struct dma_buf_io_map *map = container_of(ref, struct dma_buf_io_map, refs);
>>> +
>>> +	/* might sleep, use a worker */
>>> +	INIT_WORK(&map->release_work, dma_buf_io_map_release_work);
>>> +	queue_work(system_wq, &map->release_work);
> 
> You can't guarantee that a GFP_KERNEL allocation won't be performed from
> a system worker thread, so you can't safely signal a fence from one. The
> pathological case is when all threads in system_wq are running work
> items that perform GFP_KERNEL allocations, enter reclaim, and then wait
> on a fence that is signaled by another work item queued on system_wq.
> Since all worker threads are occupied, the signaling work item cannot be
> scheduled, resulting in a deadlock. We actually hit this exact deadlock
> early in Xe.
> 
> So, as Christian says, think carefully about whether you really need a
> dma-fence here. If you do, then you need to play by the rules.

I started with moving it out of wq, which was a good idea anyway,
but as mentioned in another email, in the end I just got rid of
fences as I believe Christian was suggesting / hinting on. I cc'ed
you on v6 if you'd be curious.

-- 
Pavel Begunkov

