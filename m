Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38B8CD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071EA10E522;
	Wed,  6 May 2026 09:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e5FhhJEG";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD2610E522
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:02:24 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488b0046078so53741805e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 02:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778058143; x=1778662943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mmaZWXsqMxYY1SXzoardDG6u5dyIRaJ/iULJJHwbN+E=;
 b=e5FhhJEG6ZeDitROVnr4KCA/RqkiO5XhqkzcL2yV/Lup6WNSJoEK7PVDJvKSUrlyK4
 u4H6063VwEpnJd3PhmjOaogICxIOMTBOHuWTvy4D66G0rj8ZhUH5y2sLTaWAyA0YvK6P
 xEL8ZreRA6WEbUm1oYL1KTuaD6lMn/sATaM4n9y+5HJfcZPkJppoUpBREM4khRfuLxdn
 4amlwIvVnQNpNDRtWwrgIn/ma0hITUaKHyXt3pyY6gTb9h7+4HxoaIeXcHB8gVCiS9og
 K7MWO0y7qpGic4IKf3rqig9BI/L41VUfbGpGWVuV6zaSC+WkyclNYcekaCdpcLkRNsEs
 FK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778058143; x=1778662943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mmaZWXsqMxYY1SXzoardDG6u5dyIRaJ/iULJJHwbN+E=;
 b=SzuEyDdP5fknorPrpcLFhLGL+TBCOyEaP20TuzgZAJKy4ECbG04MmHP1MDZq2t3PcZ
 esOpCp8DtGDl8yMRmtZSGL81TBoMAh8/ItC6m9XmL/xWdI+XwtVmCKRSOeJg5tdHrLGZ
 aY35HcYHM+i6EiMHG0o5qQlGZztaFtpBtGP2U7HGjXHDbM8UBzntf9vDDUVi8emJZIq3
 xew113POgOo1CUadjYjORlWUb4vcOMwsShnZRD+El3/ERr/5BLaqIz1VwmzP9odvAYmk
 DiSoQeTK5lJumPmZoi+HPSsXAb7M4Ny/BDN8yrPoLMGQqhLD9eUrj0aRkK6yUyN+nSUh
 p/Gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XC4zEPVmqBdRMbEANXU5Pf+/IfhwrJfNFFc18kK4ayG7Qbye1YNlXmUTuW4V65/Xya7Phnn132Yg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHpPYfWmXun7QmXor8AeczXyqCgMoPi8Ii4GibjdiHEhx5P+dM
 moScNMbcB4ZDaiI3rR4HhqUdz9p52uPIYgIYlj5Y1pEev4P/OtPyz5SB
X-Gm-Gg: AeBDieuwu4U3NDRjspHeH12C7/9vWhHGyQs8O+1EXdntXSEyntY4G2DYQOgRpdG24jr
 baEPWwYfi71YTfOff8sOZESie4tVCK2/1x0LoFdHHDvxMic0wJUqje0exAdNyuG7CF4f+CIizfw
 H1cuy1xrWOSQhAx/XGtaPNJOrOddXWVEomYwhLWsvzmcLNktp0ZqC6w0j2eow7QWyVXRTArmn4A
 eTK0jeJQ5prqyfW8kJj8SyUxX+NpPo4qm4G0XYftU50gFE+OJwbfYTv0F3STdcGPOWz+26jTfOr
 n467LSUdQV1vTqKAn97KEZu7rgnf+fVnJMaOvvVty1ZdSxy/HH4TG7Ey3ERBIwRTwwfyBV69ccG
 p8zKRQZ3g/q3etecHx1V3ndg2QNSL9uXgMwrjbHDWYy/xnsSZrXrFU0Xg88SO5qr1B+5hhKFK9M
 GFGKjVk3zdGlMlXTZ0qXjYDvzomf/c/mMoTk6U/V6Mo3igcIr6FpNTSUTEYINei6xPdPbfecjqd
 sc4RAeT8tdvlmt2KBuWZIomApWbTjCS42gJlftrgw==
X-Received: by 2002:a05:600c:2e0c:b0:489:1c2d:211e with SMTP id
 5b1f17b1804b1-48e51e0c833mr25734095e9.5.1778058142476; 
 Wed, 06 May 2026 02:02:22 -0700 (PDT)
Received: from [10.109.92.22] ([86.33.71.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e52f5c1cfsm21365215e9.0.2026.05.06.02.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 02:02:21 -0700 (PDT)
Message-ID: <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
Date: Wed, 6 May 2026 10:02:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <afi7c-VUJWOLlC1m@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <afi7c-VUJWOLlC1m@fedora>
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

Hey Ming,

On 5/4/26 16:29, Ming Lei wrote:
> On Wed, Apr 29, 2026 at 04:25:46PM +0100, Pavel Begunkov wrote:
>> The patch set allows to register a dmabuf to an io_uring instance for
>> a specified file and use it with io_uring read / write requests. The
>> infrastructure is not tied to io_uring and there could be more users
>> in the future. A similar idea was attempted some years ago by Keith [1],
>> from where I borrowed a good number of changes, and later was brough up
>> by Tushar and Vishal from Intel.
>>
>> It's an opt-in feature for files, and they need to implement a new
>> file operation to use it. Only NVMe block devices are supported in this
>> series. The user API is built on top of io_uring's "registered buffers",
>> where a dmabuf is registered in a special way, but after it can be used
>> as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
>> requests. It's created via a new file operation and the resulted map is
>> then passed through the I/O stack in a new iterator type. There is some
>> additional infrastructure to bind it all, which also counts requests
>> using a dmabuf map and managing lifetimes, which is used to implement
>> map invalidation.
>>
>> It was tested for GPU <-> NVMe transfers. Also, as it maintains a
>> long-term dma mapping, it helps with the IOMMU cost. The numbers
>> below are for udmabuf reads previously run by Anuj for different
>> IOMMU modes:
> 
> Plain registered buffer is long-live too, which raises question: does this
> framework need to take it into account from beginning?

Not sure I follow, mind expanding on what should be accounted?
Are you suggesting that we might want to use normal registered
buffers in a similar way? I.e. giving the driver an ability to
pre-register them?

> BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
> which can maintain long-term vfio dma mapping over registered user-place aligned buffer.

Interesting, just too a glance, and it looks like what David Wei
was thinking to add to fuse, but IIUC he gave up exactly because the
client will need to cooperate and that could be troublesome.

Should we try to push everything under the same interface instead of
keeping a ublk specific one? Again to the point that it requires
a cooperative client, but if it's something more generic, the user
might just try to use it as a general optimisation. In the same way
it'll be helpful to fuse, and as a bonus you wouldn't need tree look
ups (but mandates clients using registered buffers as a downside).

It'd need to shaped to somehow work better with host memory as I
assume you want to be able to map it into server in common case.
Switch case'ing if it's a udmabuf is not the greatest approach,
but maybe we can figure out something else.
  
-- 
Pavel Begunkov

