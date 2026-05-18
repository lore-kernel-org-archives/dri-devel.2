Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82D4CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E853810E5C0;
	Mon, 18 May 2026 10:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="msBnqz5n";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177D410E5C0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:14:14 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so31091745e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 03:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779099252; x=1779704052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HqBDj90Kc3B5RL3RITDRmt05U20tIBaa43CY99Xd9RQ=;
 b=msBnqz5nQj75WfrWP7xtCxwQlxfKPjcM462LYX9r31HLB9aqcZ8cm/71qS34j47Zsc
 hhIZezunllxWDfWtvD8nA3vWPJAb6kD5TxtDf/ESFo9zO9jStViN432NEqT2uP5CzN7T
 dchH6Zrq6G/r6mtSLFey+Tf3zH09YToHDG9/t1diKbEr+P5qZV95Wu1ZMTyv2yRukuzD
 Pf9hKXu7eAVwkkXw/ko094FkKk+7Y+bXMUYTpQdMa5m3ZJkoxf700ZHdgNNoXg4f0k88
 3FCpn/o5TdBZTpqL8PwhSu6X89ONQpqjP3BTcXmXtSSywkh9jkkTLrVkHcWS/Fa6DYX3
 CflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099252; x=1779704052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HqBDj90Kc3B5RL3RITDRmt05U20tIBaa43CY99Xd9RQ=;
 b=fqkzc0Gn9Sh6FB0m5dXoNAHNtrL/AX/gTu4KTBlWY4OT1Yd09ORmWUhpa8U2LkhOL+
 +tyj9taj95XVWsQrC5bvEt5ENuaZCAqkT/GDnIJLdDCqJ2/fkFR7NyvbyY2EHAQG+c7+
 ZqgILhlGqmrnb986hOT1irEZgb8LUu2q6JRWMdMJFIOpECim52lKoSVHtQv7Jbk1Ip98
 eqWrXKM8gh1e7IiNTEtInJg/y9+hqmB0wQNBImPsYpsBGoYoLtjP7HW9mf4n4Q3+Bb1M
 rkK3lAPfyufFDZ1aLQSiMuKQVAqUBcQ5BcKORAXCKQHvjEd39qFJnNXjHxP6dKV0DGU3
 Gfxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LhnysgpMLWRZKhISA1giPnuWGlV+5MPvkwv9ZTOyV8AD+oB67Y8e02xXQX6+UstlCrjK5MA4j1eQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwA2YCijuIWpvU3W3GrLSM2Uxr32djfbtkxBFIqRwVbV3ly2KIT
 JRw/YuAs2nNOmoCEZWu3DyHotymijonNFUpV+jRODpxTKBsgmhDW1Vhj
X-Gm-Gg: Acq92OGVAuaHIidgAFxYio2/HRExcNWRdegKC0Q6XcQOHO6pU0LMW7HmVcu9QXzsP3Y
 TxNlwagmp7+NI2Wzoxyt4B7gzjiWd5tDYuRdk5UWRnkbYFw1h1OTY4fj1tvNQVPX25yMcssvNbr
 XiCdbZWfr3Nv0j0/I78xN5OLBvy+qJBu6BXjA1CF+ivSMin5pCgIP+oQfNmLdIEOdpyKlqrcKAf
 img4NsKywcX0H0LWDSKIzohMm19yRncRDpgNOByKvdHuG6XCPaFWaOoSSK+G8Y6LwH7uaQA2JDL
 x/fQkMVe40CozxfhA+TlXOyIBTXFly0QD61hmg4FutSX4nj/vP7KY0cjv3L6Sbkb/9pdPf5+c35
 1p50FPtlr3hdf0tneYjL9v3empRjLTdVr0p6/NINALyembfM9q85sYjAvJY7NDP0Ts1aA5xJahr
 SwetXWm4IRCOk1fAiyuwm3bfcdXGmsDALa2RaO3JhvTu72lT3McI7ntwjJGl3T00HEbmnmLuRwm
 hvDd0w0zCqYgFoC1blc1lJU/SNVq8Jd3bscncCBw4i2KtpiVpSZ1O5BzSA=
X-Received: by 2002:a05:600c:3b12:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-48fe59ab80emr218398395e9.0.1779099252361; 
 Mon, 18 May 2026 03:14:12 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:6e9b]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0f72sm38877974f8f.25.2026.05.18.03.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 03:14:11 -0700 (PDT)
Message-ID: <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
Date: Mon, 18 May 2026 11:14:09 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513082431.GA6461@lst.de>
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

On 5/13/26 09:24, Christoph Hellwig wrote:
> Naming and placement:
> 
> This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
> and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
> But I'd like to hear from the dma-buf maintainers about that.

Looking at what Ming is saying, it'd make more sense to keep some of the
parts like iterator and the file op more flexible and not automatically
imply dma-buf even if it's the main and for now the only medium. I.e.
ublk/fuse can use a similar interface for mapping buffers to the server
even without dma mappings.

I don't know how the API should look like, maybe passing memfd, and dma-buf
supports mmap, but I think it's better to call the op something like
"register_buffer" instead and keep all it in lib/ for the same reasons.

> Config option:  as this unconditionally when DMA_SHARED_BUFFER is enabled,
> why does it need a separate config option?

More clearly marking relevant code, easier to make optional if needed,
and gives some introspection via /proc/config.

> Interface:  io_dmabuf_token_create / ->create_dmabuf_token filling
> in a structure allocated by the caller feels odd.

It's minimising pointer chasing. "token" is mainly used by io_uring in
the hot path, and io_uring just keeps it as a part of a larger struct.
For the same reasons "map" is allocated by the driver.

I can add an extra parameter to io_dmabuf_token_create() for how
many extra bytes to allocate for the caller's use, if that makes
things any better for you, but it was easier to just pass an
already allocated struct.

   My gut feeling
> would be to move most of io_dmabuf_token_create into a helper called
> by ->create_dmabuf_token so that the token is allocated in the
> driver data structure and returned from create_dmabuf_token.

-- 
Pavel Begunkov

