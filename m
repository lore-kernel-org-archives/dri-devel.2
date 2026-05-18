Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64222CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4CE10E8AA;
	Mon, 18 May 2026 14:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="clKQFnUo";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB17D10E88E
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:23:58 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b936331786dso298408766b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779114237; x=1779719037; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m58bYDJ543WmyZ11IWytLuY71YuFJ2Bw6ePCWpryz/I=;
 b=clKQFnUo1trSTZfso/w5GIEqyQ+0oqGbeYXF4WDu3pOKliYtPFCkAqd6RwI+5u8hSM
 RnKKMzs7MBDh+W9vysLE7Qf0LG5fh5miaeJnJD+ccePIfJds9JjrrRIhPJJwmPIFMTTA
 L5UY1kMoXE5xaP5Cqw+3CCp63EmzpotEVL/m4gtAkF7NSfJNPymMS1L40BkVYN0V/wuD
 VKVaG7BTOf/Rb5+FzjK4b9uJTAez1X3QbweQt8JxZXlXRNTsB93uHhqolGtDu3Sxg04r
 d6OrcHEHF+att4ZwmMuZA2o9adoDn/FSgQAkIaM8isuAwmgZrLLgyGwnkvYYbL7BNGTD
 ypRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114237; x=1779719037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m58bYDJ543WmyZ11IWytLuY71YuFJ2Bw6ePCWpryz/I=;
 b=U1YJEioaN/4GFET83i0rtJXXlILbfD+lQ2vTAboTisgP81kOcWvT351lccmVdWxtXQ
 3xZAkzYTKgWQekqg+tU/sgvCak9Lb6SuJ3WtEjmWaEvOm70AuinFz17er/lPnvjDXcT7
 785MUi0VIm56JwAtQDPPN9qO5u8CSZytf7A5GNwWfv7LVnj2dr52twzbLTyRpyd6TvRf
 UyD8h8Asu8gmODp/+Gd0adHsqCY/Sb/WnvC3EUbdVPQd/NqBN2VTmY5C80Oe/wtFhH5v
 gCH+g5Kyl4Oc5NVG1zRIWGahe8TJ3EPitDyg9z4FAUPV9eowxSAP1itq5dPuNEyhNL2p
 VBPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ93cLD6rKg/Ns4AQoULUknUnP3+hBn2e3d/ZhGQkMClAaROEwSTNb64MsuVyNqGPq7wJD4E20/SwQM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyvsyT9I/CaPaQwf89CFmbm5Ts0Bgy6inSGJIRmR8ACNHoNMwF
 iS2Sl+AiE3a9J9MzPakWwVfPgFq5h2iFl6sWdDQmnGXvJi6dcnzoK/ia
X-Gm-Gg: Acq92OHE3WzqE3tn+hQRGsNyNmYkG7msNlvbV5aYB/JjQiwN+46MpyuhXXkJmLgNySD
 rBO1TDTwW3UYDj4kncZJjtGL4s0hKZUxLkriszDbWfURQdi08kWQlNh40EPJpyRzNJCNPyIAjrw
 /FdH6VR+7gljXHu4mbHnrKHBY6nnI3HkxnHtg2PM7datJjzFMd3bGfUQZf1f5RRWcjvU64p0Mqc
 PHrKQL8fcs7mXbuCmh7XAxqlblZ6+i4zQxp2cIqsPILpQZUvB+87ctqg4g9srhDUkfhrBeDoJjG
 l4kIq/fP/Ym7JtkA5lUxLukrBoLfLQSg+EixaCMmHzWJysXPC4jnVnh5+j6sAm+1LVV6Cyb35b6
 EF1TKLblK8wwgtC9i3nASraOYVtISwtVNCAuU4342ZlwAF2WHQceXQfNueFHAqTvcslKIZpZT4q
 84mxleEPwJ/QPXGCDW3VIAA0s0YzEqTQHqtLQzsczZ9i9jpfsq0ureILn3Ck0qOtv3pJwc2ZFnA
 EhV1h3Xk+Hii5x7H29RMlmqKcC4QOZgE94jn027f2JNyCaHXVG38ASgc2D92lG95/zeGQUao4K6
 PQ==
X-Received: by 2002:a17:907:c291:b0:bd5:7a3:a58b with SMTP id
 a640c23a62f3a-bd517994249mr821357066b.46.1779114237152; 
 Mon, 18 May 2026 07:23:57 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68310d58c79sm5325464a12.12.2026.05.18.07.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:23:56 -0700 (PDT)
Message-ID: <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
Date: Mon, 18 May 2026 15:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
 <20260513082431.GA6461@lst.de>
 <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
 <20260518125326.GA5754@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260518125326.GA5754@lst.de>
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

On 5/18/26 13:53, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 11:14:09AM +0100, Pavel Begunkov wrote:
>>> This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
>>> and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
>>> But I'd like to hear from the dma-buf maintainers about that.
>>
>> Looking at what Ming is saying, it'd make more sense to keep some of the
>> parts like iterator and the file op more flexible and not automatically
>> imply dma-buf even if it's the main and for now the only medium. I.e.
>> ublk/fuse can use a similar interface for mapping buffers to the server
>> even without dma mappings.
>>
>> I don't know how the API should look like, maybe passing memfd, and dma-buf
>> supports mmap, but I think it's better to call the op something like
>> "register_buffer" instead and keep all it in lib/ for the same reasons.
> 
> Let's get the current version landed.  If we come up with some kind of
> non-dma dmabuf in the future we can refactor it and move it around.
> I'm a little skeptic we'll be able to share code as long as dmabuf
> is allergic to physical addresses, though.

To be fair, it's not that dma-buf specific. This lib/ code only
does some resv locking, fence waiting and queuing fences, otherwise
all the attaching is done by the driver behind callbacks. Switching
it to some memfd could be pretty simple. But The main thing it'd
need to share is iterator handling like forwarding in the block
layer, and it should be fine as it's already passed as a completely
opaque object with no knowledge about pages / dma / etc. for the
middle layers.

> lib/ is most certainly the wrong place for something that absolutely
> is not library functionality but directly interacts with a few
> subsystems.

It only interacts with dma-buf, and even for dma-buf attachments
are created by the driver. Block, nvme, io_uring are users, either
using the helpers or implementing callbacks.

Ok. Let's assume for the argument's sake it's not dma-buf
specific, if not lib/, where would you put it? I was also
assuming that dma-buf being under drivers/ is rather a relic
of the past rather than the desired location, hmm?


-- 
Pavel Begunkov

