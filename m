Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120C9CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBD110EA18;
	Tue, 19 May 2026 07:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QnkEWy68";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C333E10EA18
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:55:36 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso22860955e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779177335; x=1779782135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/lqih5w8kOsHKdyaSXO9SGORGhwE1abTlQDwvsKNOc=;
 b=QnkEWy68+DGNZJ+aHsREDmpp4BxU4EAxHeFc3G/kxFe0HNWvFYLRY30jZxhhNVRi7V
 YUhbtjdBw//taJYa8Xyo8Je1YHVZwsZPiezdC0nJ0Xn6Zx5O1+yVOVg4/2rArblLZs+Q
 9i5HrVbU69xoS8BjOfJ+bHw9WAOHsGwqn02svgZ8VrwJsiBLLa8b8IBQIOl6dEcoGOx3
 iO+IntYQkCLnv2/NJvw7Ksa723ufq7yFbl30+f9rYUbZ+Mz+6LRrAhbCatqe2qyLuHqT
 5vT/GfRAGxO+pZcFcM6O28gTW14n21Yp1/IUAo3/+rtd6ytpvj4kXvt3ClcoRLM6Y0El
 Y+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779177335; x=1779782135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/lqih5w8kOsHKdyaSXO9SGORGhwE1abTlQDwvsKNOc=;
 b=gFRZyP6ksqx73LjIUbMWtrHLM60Y1mGV+YLXoEdZjdRTJPbBGIcm5iz/ax614v30Jo
 lOwUVorO55qIW71t7Znml+u5GvzJWBccLgAwcolY/IcGgocWRdFH9gL2hociQF18UG2i
 Cno6VoKkZ3a42e1cvljVo2DTIhJ0KQPRFI5ydENg/OsPqMPOBstrAGNekfphaZTLRWIl
 zDFJDtUywitTWntR5svckDANxpFcbMK0O50UxX3N9/bjqAzEjBnILW8ucxgPdTliFIcF
 obbAW9eAdJdaDYcHgZA1730TPjnRH/JxCUBx2JB/spQxVJqYPcWhG/q2A6Bg1Y3dm1kI
 2mdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GQW1A/qtr/VllKloI9+F6pCf+VMVzc9Cmz5Pt4TpfmrNRSiAh1V9jeR4tQoiC/rRKX2ojtGGKinw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOOBun/S2hrcDITrf33SV4Fz5IB5VRI3sNhaIZlsghsGfh2NsQ
 D/hBZ9Jri8KpSRqXc8kICN2fsh6kts9U3VPolOywL/XHgHSh9xhLgrMd
X-Gm-Gg: Acq92OGx4mZeUey10yxOYW0lyYUhn5IcVDAY0RwuaShAVRmHfkY559esU4UvZvH0wS9
 wLNReRD3F/vxmWGoefUqxjfSVJHZTXrte6meM5/cWeQeAAjkgS0jWvTaGVX9gTy6VPqoXE2ibp+
 se+om0XZR+e9zFITv6JUCv5pUEvnlKG95QmDr/llkJFLptH53vE+weiaBna8N3SW4Q0fLFLM1Gz
 oVp+cQpC6kVR0OSFkwdq47P9qv2OX/MH59eJM83nqHGJzZ3RcmV6/Zud0vil5NhVIQhvOsrJaQX
 oIixyF6jQXwm+xVY5T75JIAPS57H6fF8shPMj/qBVSHiNeqoQa0iev7F8e15BFk6Km5I2W7UhT5
 ZRC85PY6LnzYR0sM2D3opOpGNvZ7+DiKXK9N5PIcerrlbzzH9M79OLPmX1ZaFTXMno6kz1apNWF
 BsAhAYV2C8av7mTfthtQGdXNybWMS++ei5G1aFqWOEsBdI5atERmEC7OcbW8zqbDc8XDhJ0AIWq
 5AadZbgOwOOR6ouWVzw+yXEJ53OspDveztz7sEfwj5CLkxKiErz9hzqt+y+Qi9fhYYfSpn5qGSP
 fQ==
X-Received: by 2002:a05:600c:470e:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48fe60ea590mr265981195e9.12.1779177335066; 
 Tue, 19 May 2026 00:55:35 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm329088665e9.6.2026.05.19.00.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:55:34 -0700 (PDT)
Message-ID: <9933142a-4ce2-4219-9574-73da30edd74e@gmail.com>
Date: Tue, 19 May 2026 08:55:32 +0100
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
 <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
 <20260519065653.GB8173@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260519065653.GB8173@lst.de>
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

On 5/19/26 07:56, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 03:23:53PM +0100, Pavel Begunkov wrote:
>> To be fair, it's not that dma-buf specific. This lib/ code only
>> does some resv locking, fence waiting and queuing fences,
> 
> But all the dma resv/fence stuff is pretty tied into the dma-buf
> ecosystem.  I don't think it would really apply to something not
> doing DMA at all.

The point is that those can be separated to reuse the rest.
  >> otherwise
>> all the attaching is done by the driver behind callbacks. Switching
>> it to some memfd could be pretty simple. But The main thing it'd
>> need to share is iterator handling like forwarding in the block
>> layer, and it should be fine as it's already passed as a completely
>> opaque object with no knowledge about pages / dma / etc. for the
>> middle layers.
> 
> But none of that really sits in the current lib/ code anyway?

It's about naming. E.g. passing a DMABUF_ITER that doesn't have a
dma-buf would be confusing, and then it'll need renaming at all
layers to support the use case.

>>> lib/ is most certainly the wrong place for something that absolutely
>>> is not library functionality but directly interacts with a few
>>> subsystems.
>>
>> It only interacts with dma-buf, and even for dma-buf attachments
>> are created by the driver. Block, nvme, io_uring are users, either
>> using the helpers or implementing callbacks.
>>
>> Ok. Let's assume for the argument's sake it's not dma-buf
>> specific, if not lib/, where would you put it? I was also
>> assuming that dma-buf being under drivers/ is rather a relic
>> of the past rather than the desired location, hmm?
> 
> drivers/dma-buf is a pretty natural place for it, I could not thing

_If_ there is no dma mappings, drivers/dma-buf would definitely
be an awkward spot. Just trying to understand your criteria for
placement, let's say of a generic buffer registration code assuming
there is no dma-buf involved at all. Again, just a hypothetical.

> where else you'd place dma-buffers.  I'm not sure how hmm has anything
> to do with it.

Looks there is some confusion. It's was meant as an interjection
with an open question, I didn't mention the HMM subsystem.

-- 
Pavel Begunkov

