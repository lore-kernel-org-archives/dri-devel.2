Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C073ACD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2781C10E803;
	Mon, 18 May 2026 14:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IKqyClKI";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708A710E7C7
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 13:59:58 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-67b32c695efso7118975a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779112797; x=1779717597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+WT00WHtAu4WqCgP+skKdKZ8K4Rq+JbbmW7SvyUtdIs=;
 b=IKqyClKIKaaYFrUPHNkkQroOg8MVkDLBiz95KOxnsfZhti98ojlwobQjqLdDEo//jc
 aLKSuYe1YzD9YWOzmE7cNasSJJJgq9EJME7Tpg02HgBRenvqzCIexJ1wIKaQdmbSnxo6
 ITb8rDi6jwDMzc6y1Rw2YxbgG8v7pKCpqXcZIn8L1x4cx6xwK+OFSq9XwZbA9xPaNpHx
 TVyw33afw5jdWT6ijQ/isX1AK6jtHNeFFjD/YkxXT5Njux8u/HFpRhnOeiOBk0MSJ1+8
 oXo0nqm67ma0IeS7GgxnMUUiUAP1gBDgph95LyvVRugDo3T5Q+rlaFtobiX4QAU246Kk
 cIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779112797; x=1779717597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+WT00WHtAu4WqCgP+skKdKZ8K4Rq+JbbmW7SvyUtdIs=;
 b=IPOJHEYPFgXwCDm2Tsfoq5lomLkT2rV1m9raAWYpg3IAPzsK2K2BPDKAQ2yqx64IHR
 3NC2xrZQ3TeR+gh6U17PmDaEmb+k2f5iXRfcqc9KfEuRO2RTbET1U/RCoWwRmxslbccP
 NAKGltj3T8fM7q1u8DWPdt+CVE9CuVCaDAPMJVN9Kh49o5AUFsAtMK7KU+MSm1iZKup9
 9VJVookDpo3gA9ULeZ0KRFyAUxmgiMxElXJa78MPZqgcRq5fwG4OlriXBWFOnxnTf1Hd
 JjknnVXjLzPlxvZzS/OxSE7FytyGFT91H1w8Oz3Nbr+PyobkhpvxUdhKGFggFeiCtZ0Z
 W48Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+H233Y+2ZzXXRMHReazs5wPMtySQVjw5RlK9I1EdhHoSgZaLjS4Et40M48MFbp9iI3yH4j8iE+PHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz16Tm/ge0iPYFxPGQjhewsg59gLtd+sNDkV5PnBZlpH2WAhY4F
 PZqFlooaItqySphhC9hCJDxYWkZWhTsTSSrLeqZDRn6ii4ncC07u+CMe
X-Gm-Gg: Acq92OGliHL4mjeJgxe5qs8EW5vyjv5JJEpPsRX/cQF5AnO8wFYlfC/k/G52GqzTd+r
 eY9+3O4jxpKWE+lA7tLx3knTfP0X6Adz8CXg2C1LeccVF3VmW2AJxLtV+a3zw9/EaU6D1GERSyx
 6UahJAWUKfNuYmEg1ekldyWH0FLLJY9UogjE4qjFc3vy+BskfzSalD5NaPV7lr9y2v2Uq1UmTW1
 6REMAEH84YHyVy0Oqlc2/hK0Gce7ialJFkkZHecMnSQbK57Grf4BHGvsCcWL9UycXhWWkmB16FW
 EgPaVDgQgZPOSjYjMsGeWKpkT7goam48FuPyoQZu3LW9iYhBMi9tLgqbUVWr/NyJe2bCVShUSZF
 zPC7LPpbOcCKo9CbU2NpD6xfgl4mYn4XVt9u650QqlmcbdaHK1lraxustxAc9ln8dSi7EKNEWa4
 CEtLUOQND8vFwWTxfo57tzXjcFkAdec526fTB6M7GDfd2Bxm8ralJ0Iz21fO29heMtPwPWYtFwq
 obzaEnP75nnTsCA2EocJGPN+6HmaiwdOU2zh4mzwkyCxz73MA1VNOQpHhmZmZf1rZtYz2sDOmbE
 e+LL6Yx/Lf4c
X-Received: by 2002:a17:907:3f1d:b0:bc1:7da0:21 with SMTP id
 a640c23a62f3a-bd4f34bd0e3mr858876966b.23.1779112796524; 
 Mon, 18 May 2026 06:59:56 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4dea94bsm565057266b.33.2026.05.18.06.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 06:59:55 -0700 (PDT)
Message-ID: <166da921-77bd-422e-85af-ef67d6fccc42@gmail.com>
Date: Mon, 18 May 2026 14:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
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
 <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
 <20260518125713.GC5754@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260518125713.GC5754@lst.de>
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

On 5/18/26 13:57, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 01:40:18PM +0100, Pavel Begunkov wrote:
>>> When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.
>>
>> That might be more penalising than placing them in the right order,
>> and it might be fine as it's new and all that, but it's not a clear
>> cut as it's definitely not created to be a slow path.
> 
> Yes.  Whatever the caller is using at a given time is the fast path here,
> and dynamic branch prediction in modern cpus handles this really well.
> 
>> TBH, not sure
>> why we're bike shedding such things, is it somewhere in the code
>> style?
> 
> It makes reading the code annoying, so it better have a good reason.
> Now for a single conditional it's not much of an issue, but these
> things tend to pile up and then start to get really annoying.
> Always write your code the most straight forward way unless you
> have a good reason not to.

For me, having the most common case first is more natural and
readable, but I'm going to flip it just to avoid spending more
time here.

-- 
Pavel Begunkov

