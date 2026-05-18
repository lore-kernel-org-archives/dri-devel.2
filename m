Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B31CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04FF10E6AB;
	Mon, 18 May 2026 09:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SAPckOto";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86DE010E6AB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:24:42 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso1049141f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779096281; x=1779701081; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ZnntFD93TY8/+xleaPVExk6NAT6He9j34KXY+n97WI=;
 b=SAPckOto6+9K8089IzWEt74pN6omlzcQ5uUfQJUSfnEcSGyyX2eZh5sNjYwvhQ5UC3
 VZIjHHlIZB2Ayrg2m01g9bZeWvRVosgd+11gdnYT46ZkjKw/LAxll8vpVCy7dkFch8YI
 Evs3uotF7bsdTpB07IdBWGpM4xMQ6IP2+139IMqUL0KN5H7gWgO5Xwxl4ZpnkZ2WVDxE
 Pp8/YP7sj5BKe23UXbHf3cVKsd9P1vMkSBf4UQnU4kACml5DRehnQvV/p1q4mlUEKzzd
 Z64wB/dqbsuZHYQNp7E21qDEqQVAOh8VqpcZsjZYasYqSxXhqyRHSJHoc+nYdf5NquEV
 L02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779096281; x=1779701081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ZnntFD93TY8/+xleaPVExk6NAT6He9j34KXY+n97WI=;
 b=ZVjKOElOp4Q1a5vuzfc6JdXha/xUI44KROYu3chju2lKLalGm/t/vV5DmbBMmY70hp
 01kYm3AxqUJhwX1CrsBsEYcvVlSICMZMIh9yaBTueVvVPM6uhd2rKE+NelXqcCp4aQ1s
 fHpxp7k8ZdEtxpfLLWRH8TwWTb14mC9lMviP6TR5/o0j3q9fTDiEiidRZq4IuxHRiY3m
 oZ6ndTMl91uYQgz8L+ItS1ak00r4DcFB968s1qVEO9hZQolB3Yr/QNN6QyOfC4FsBhLQ
 duyIiDIZstplpI/S0eyFHGX6J93qvigKhA+F6PQq60sGgGRjP+txqXYkt1WYvmwNRXZ3
 FBHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sYwYVrWeGtmQgfeerenY+LlkFn1ELvUOsIHqw1HquZLgpMleeDFVD/wtex+BSsvpAXDxvsqubATs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0nKAOmxtPrMn042fgXZeeHwk3idth+OEyArMiDtrTwIqiJ1VS
 fpnDxr8xhw59Yug9izxx6IU5/kNDYMwoa23R8dyFR4s0R4mP7Aif6b1C
X-Gm-Gg: Acq92OHdcsBy22SeH4FSBeVY2hWqClbEd+94+KjRIR4ozz1tMTTthl9LhNDNEUF1PAz
 P+yu68Oj4Wz+VJpVOqpd3riaBUUZECYbRgZ5JSTc+RkFQMKhafdxUDxfhAP9twPv4jXVGQlTEgX
 x9yPul4MKErhMEe27HJ4vWjah4pxVW/HcxwFu2J0sw+TyjRe3XInLzagwwc+3G1vzQg9xWy+fJq
 oLwJhomw2pv/z7ubjOaeoUNtam5g4uKEwMiGoEOccwDSZvTMvOlUC5vYRJB2pMRxCwu3/k1e/dP
 +UCqu4RF912fnIav7cG370ukd4KOAbgrE/inB88nAtMy1EN55mKessuPeCqc+qkefMcxOJGDi9k
 BMOGgNWYaL1gIij2slldj6ar2y3aoOvGdmMKIqd0eoexoMAkch3n+nuFGBjXC+lJQ+FnjNjFxda
 XuhS38P3iMchT746hNWXEl2sBCEyp5VX0uQS5C+NFdEdt6X3RC66hQguT5NDgyts9YdK5KrH0iu
 Si1B1dDntkGmi5pjG+hZnu13VNTaAHg4bjykuQfyPzicucCPjeQb6RNgwM=
X-Received: by 2002:a05:6000:288c:b0:43b:962b:5314 with SMTP id
 ffacd0b85a97d-45e5c372a9cmr22814328f8f.19.1779096280750; 
 Mon, 18 May 2026 02:24:40 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:6e9b]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e6a135f0csm17325957f8f.27.2026.05.18.02.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 02:24:40 -0700 (PDT)
Message-ID: <4b2f74e9-3225-47f6-85fe-911720030e35@gmail.com>
Date: Mon, 18 May 2026 10:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
To: David Laight <david.laight.linux@gmail.com>
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
 <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
 <20260513110557.705bdeed@pumpkin> <20260513142909.03ae6c2b@pumpkin>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513142909.03ae6c2b@pumpkin>
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

On 5/13/26 14:29, David Laight wrote:
> On Wed, 13 May 2026 11:05:57 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> ...
>>> @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
>>>   {
>>>   	if (unlikely(i->count < size))
>>>   		size = i->count;
>>> -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
>>> +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
>>> +	    unlikely(iov_iter_is_dmabuf_map(i))) {
>>
>>
>> Doesn't the extra check add more code to all the non-ubuf cases?
>> This could be fixed by either making iter_type a bitmask (with one bit set)

Not going to do that. It was specifically converted from bitmask
before, and the check optimisations like this were voiced back than.

>> or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
>> '(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'
> 
> This seems to DTRT:
> 
> #define _ITER_IS_ONE_OF(iter, t1, t2, t3, t4, t5, t6, t7, t8, ...) \
>      ((1u << (iter)->iter_type) & ((1u << ITER_##t1) | (1u << ITER_##t2) | \
>          (1u << ITER_##t3) | (1u << ITER_##t4) | (1u << ITER_##t5) | \
>          (1u << ITER_##t6) | (1u << ITER_##t7) | (1u << ITER_##t8)))
> #define ITER_IS_ONE_OF(iter, t, ...) \
>      _ITER_IS_ONE_OF(iter, t, ## __VA_ARGS__, t, t, t, t, t, t, t)

We definitely don't want that, using them directly would've been
much cleaner.

if (get_type_mask(i) & (TYPE1 | TYPE2)) ...

-- 
Pavel Begunkov

