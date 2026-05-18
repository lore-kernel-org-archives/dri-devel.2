Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B34CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC4810E310;
	Mon, 18 May 2026 12:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DMPL6DOp";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BD610E5CD
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:40:22 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso18742265e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779108021; x=1779712821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=;
 b=DMPL6DOptXllPw1SDYXekuvtu1S5fy/nWbJKXN56DUjCJe+HVgpkjcgAFrw8EbjnYo
 cXcIxlx26Ds6bgSxUWaBEmg7ql0h6tBghMre5jXbsh29oWezKZRR6p8y/hlZa5qqhQuv
 66i39gCnZzpAS9sc6AxA4NIwzpEsFWIZT2E0avkP0wGFGjnZSF9xHx6kN0Mt299wmcbG
 UU9Nwywi85vQB/NqsoPEEbGC+ytb7ockNYMj00M7B+PxFpV0Vm7D9oOyCFF8WmVMnK6n
 kO/gCs12iUHjjG1QGLaoARL2GSBuafI2Lm3DLagTAVGe8HMR2/Babrm4+oQRIgmlj5w7
 InNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779108021; x=1779712821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=;
 b=Kp0FNbWymao7T4WgtwQVYMePKN/1EiuxjqwegY6hGJra9CY2Gdng8K/6dKID+dV0pX
 d5Xod6Eqht5vKxlJkac17qA2uJlUC83VEwIdERm2jVXOOG+ZyOw0o8MmGF8/491JmPfI
 LdZd8dimQFNLwR9cJJ6Uok51WrMFyU1PTMkQMId4hhLQBrE3RywBrk6yLKI/QZTj2r3l
 J2FwWhBAwBAJDnUxcBEU5N6ykoXgfSF0a6st3IAmxTULM/5GVkEqb0INZVjarV9M4HSa
 o6m6BvTdIatPWlXgYa8zImzxYi89sD9merL9MLN1sCSzJKsGWOQpgyOIF3j0/dJuux0l
 M3mA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fUqibzko9yap0CubzAARX4xC5VL0+kE2lSY3LxyAuRIup9aMKRBqBP0v3rx/yUCahbZJrke2KI6k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoL254mcmVNBeQ5+NQJJqC9n6TUytM1QVEGJFQbBausdvZV2nG
 55bj0xRhoqVyYO84Zt9rU5E3NaK3o2ZEZVFhZJ2n6hhHn/+5ZSyd3sTC
X-Gm-Gg: Acq92OHQ285Qsn2a95W1xLJh7qvH+EpQjMm1hHQ5x5QkB5yJTzuaoOgyZ6I8dpnFrK1
 hwjm3v3ZXG3uiendgvdsFYYAU+xdiQj9YRUl4D370jfwA7lqmAhnRuIHKJiGhtHTagYbXWJQG6G
 ZWqKdR9LRgEhtOZ4Zw29axlxzi1aXWUAitd2Hzq3CDMReSQO7uEp3WLWWLUmTV1+6fP76EkkCCs
 VLY804uQ09Wqbdn5RM6xzySLliZ486Ez6e36bCUM9ehodkQv6NMtlN0O+lEWIjw6Oz5lsaXnao3
 xCzNvLg0/AVzGu9D/4Uqledunxi8esB9SviPWYi/VW3R1GwPbsObvbcj2hQwdsOOzctZ9BxqSb7
 q2x3dyzlnOzcbIrV4jKWc9BegHL2xB3XwfKWABE6nawZLsC5rtOEc+qr2B9zTQqMmjBfcPjWc6t
 qZr8y2fi3R86MU7TjGtb7/HmMcZNVaXzPWQssdjva6hVeEfm9fpy+bA1tFpUVmF0DbCxehtAdN+
 74thz9YHD9KYzGXenWiNeVZ2jzBAtWIYGpsG3EUGmukP+/I9etJ+A3FMwyUjfVQ5EpNuA9uDKZ/
 6X5p6QYIwihb
X-Received: by 2002:a05:600c:6592:b0:48a:557e:6b4f with SMTP id
 5b1f17b1804b1-48fe62f8861mr237008575e9.23.1779108020601; 
 Mon, 18 May 2026 05:40:20 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c8d39esm256597555e9.7.2026.05.18.05.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 05:40:20 -0700 (PDT)
Message-ID: <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
Date: Mon, 18 May 2026 13:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
 <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
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

On 5/18/26 13:22, Christian König wrote:
> On 5/18/26 12:29, Pavel Begunkov wrote:
>> On 5/13/26 09:19, Christoph Hellwig wrote:
>>>> +    if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>>>> +        bio->bi_io_vec = bio_src->bi_io_vec;
>>>> +    } else {
>>>> +        bio->dmabuf_map = bio_src->dmabuf_map;
>>>> +        bio_set_flag(bio, BIO_DMABUF_MAP);
>>>> +    }
>>>
>>> This is backwards, please avoid pointless negations:
>>
>> I can flip it, but compilers tend to prefer the true branch. E.g. this
>>
>> if (cond) A; else B;
>> C;
>>
>> can get compiled into:
>>
>> jmpcc cond B
>> A: ...
>> C:
>> return;
>> B: ...
>> jmp C;
> 
> When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.

That might be more penalising than placing them in the right order,
and it might be fine as it's new and all that, but it's not a clear
cut as it's definitely not created to be a slow path. TBH, not sure
why we're bike shedding such things, is it somewhere in the code
style?
> What could be useful is to have the true path for the more common and the false path for the less common case for documentation purposes, but in that case I would expected some code comments as well.
What kind of comment are you thinking about? A "this is not a likely
path" type of comment before each mention of the flag is usually not
very useful.

-- 
Pavel Begunkov

