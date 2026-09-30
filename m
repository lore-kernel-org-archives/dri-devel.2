Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E94CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA00610E18F;
	Wed, 30 Sep 2026 10:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dW7VvZFa";
	dkim-atps=neutral
Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com
 [74.125.228.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B4C10E18F
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:08:14 +0000 (UTC)
Received: by mail-ed2-f31.google.com with SMTP id
 4fb4d7f45d1cf-6ad795d5205so670098a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790762892; x=1791367692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L6C6Fqcl7JBjpTUHBHO+U+uYrchMJCAF5saUsMOGnSk=;
 b=dW7VvZFax/5vZvUae82SckJNVs8RlD6+tOJvzldvEjxHCcgrKLdMI1eaCKtJxppY8X
 NJZoTdPJMYaAE6H/ZJ8xL1lzUSYRVJzGb6FxlLFwsDDkJC1/SGZe88CajCjiXj0P+8eV
 iX53/iUmrdAgxt2g+NhrYtbT2DhH7ujXLQgigpNJep2lZ+7NwBzvUsxrayg3WuGVnk2s
 cen9ZtOgR+yBP14YbUQjq+Sz8JNO/fO5WfL8q4UuGIygJdllNHL1TUj7cXvKEv5EoLQ6
 kAAft2l4xUVHQZ9CUAfRkDUaOLNIsSIjuU5aUKy9he+wB33/NjwhUbWDn5j42zfe4CDl
 zE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790762892; x=1791367692;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L6C6Fqcl7JBjpTUHBHO+U+uYrchMJCAF5saUsMOGnSk=;
 b=0c+48P5999vnjomfbPFCeBKRg8eU3b43gkqWnkThM5ycAzNAk3D19IA+Noqg4dIbQD
 ilx48pPABgmapZZ9daAYaJFmiHOK7Yo13XBJsGObfeBVFx7OEns/nmuQFSfbL4d4kS0c
 AtBrGD7AFEPwzEO2D5sogsVQPiQlseAathMMcdgTZHX04s3C4tbS2IxHz4t5nhrmTIOH
 Xm8D2hU4U62vUKCpQ1mCescdZQnJk7bsk52GLTMbesSTjW+OE1FSy+kcgUNilPVBVwAJ
 gs6uWF/zmU8OxrHq94S5OtEwfhWuqA3+94Kpk7+goLEJ210GMSIsr3HOVztXDmavXKNL
 Gd8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzThuD6M61g2/Uu3ENFnxTYl3dE0EEB8aw0OY9Ye+I7jFfQX+RUulKYwPexbcksRxtu3dNgDWRZRI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIy4O4QoFc7e1INAq+0LMlyv4fgrLFwahw0W8dSQOLBy8FN0UGK
 xz+7YpYTzxRpT2uIX7yDn4idlkpeDHtcmrssWBQeQ0NN7IVoR79SPnLM
X-Gm-Gg: AYBFou1CtQ8q4ZE7G0Ky8G3Wfh3YJHLkdH+u1sVsssM4iPmfQcxDOx72FAzbA6fXdgu
 jrhWaPITwsZqCVlzfpRJA1g8jQWVGvgaa1HQ95VctwGmXz5waHVdIK/zyZ2Delx5+K/NxXfDLMw
 rfj3bjoRBXzh/8PITOTsvYmtrjtbQmQKxQF/bG+c2y/mF/Pd2eseaFP8m0eD4vRQ1sl3GTxJaN1
 UVX6esTVYr9uR+G5ZZzIYBJverYKi05ozSaSAEr+p2E9Tc1f1Kza732a6GJnEsuffRUJfeARDod
 T/5dMDMNmZziHIDwv6NEq/zi3eJQFnKq+HKKG/7rTg1l5WHnUaUZCcWjAr2SeHYPxn7EbNvMBj7
 5YuAuVtUgH6BEvrzZ/fdpAX1KHTVTrnPdmR4ID6rgsJFId0pabP/n8fy0q9dtwgYhZfqt1vjwuH
 FgOqNFgiMN/IilwoFw+l0uGBKyr29Dw8uqnwSJR9FwsKtBODw8s03QDFAKZB8DFJHxdLrfV9iHw
 uXCApjJCLGpwhafzWC3dfqYAJC+oNzcji6LLNkym7LByYS6bPzhk6DsY6lqpaTiMfTark/6+1ug
 hf0IFMPFiFzNs3LvKoDVCjca1K2/ZD3jw0cLJsuT99SF7CH+
X-Received: by 2002:a05:6402:42c4:b0:6a9:a362:4646 with SMTP id
 4fb4d7f45d1cf-6ae198f0fbfmr582772a12.14.1790762892209; 
 Wed, 30 Sep 2026 03:08:12 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ae156adf4fsm527943a12.32.2026.09.30.03.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 03:08:11 -0700 (PDT)
Message-ID: <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
Date: Wed, 30 Sep 2026 11:08:06 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
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

On 9/30/26 04:00, Matthew Brost wrote:
> On Mon, Sep 21, 2026 at 02:38:45PM +0100, Pavel Begunkov wrote:
...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct dma_buf *dmabuf = ctx->dmabuf;
>> +	struct dma_buf_io_map *map;
>> +	long ret;
>> +
>> +	guard(mutex)(&ctx->map_create_mutex);
>> +
>> +	scoped_guard(mutex, &ctx->map_mutex) {
>> +		if (ctx->maps_killed)
>> +			return ERR_PTR(-ENOENT);
>> +		/* recheck under the lock in case it has already been re-created */
>> +		map = __dma_buf_io_get_map(ctx);
>> +		if (map)
>> +			return map;
>> +	}
>> +
>> +	dma_buf_io_wait_active_maps(ctx);
>> +
>> +	ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>> +				    true, MAX_SCHEDULE_TIMEOUT);
>> +	if (ret <= 0) {
>> +		if (!ret)
>> +			ret = -EAGAIN;
>> +		dma_resv_unlock(dmabuf->resv);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	map = ctx->dev_ops->map(ctx);
> 
> I'm playing around this code now.
> 
> I think you need the dma_resv_wait_timeout after the 'map'?
> 
> If a device doesn't support p2p ->map() will typically trigger an async
> migrate to system memory and data will be moving but the map is valid -
> Xe 100% does this, I checked AMDGPU and fairly confident it has the same
> async behavior.

There is a wait right before because I read somewhere in dma-buf
comments that I need to do that, sounds a bit odd if I need to
wait on fences before and after. I can add it, just curious how
come that other dma_buf_map_attachment() callers don't need to do
that. Or maybe they wait somewhere else?

-- 
Pavel Begunkov

