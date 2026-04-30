Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1546FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0596110E465;
	Thu, 30 Apr 2026 18:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hxBSQ4AQ";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FDC10E465
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:18:48 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso11841495e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777573126; x=1778177926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+sxVPeWzK/5JcscdkmY85m6FCWps4Q/alwynbpD7Pbo=;
 b=hxBSQ4AQQK5iHOGQzmf+24qvaSFjzXu4fPQ1WczHZoiKkFmg5xVuSZgRKy1JPcSk0H
 dj3R9EATMCP4+7Kdv2gqmG2EBAuG2q4G6u4tAzYcLjvm2VXyI1YDXjvRrhNYUT+MKN8s
 rWySvGXJWSY5orjpdjTbT0voDoMrowRZSeUf6jKxuHKrwBPnmjIogqO7+h87fLAfUmTd
 7H44Rtib4JYsdfysxC+G/3E2mWKlDViHkdPlSmsnKvPyPtYcTEsrWw+3vT2kxn96P9zw
 dsIGEYBif4j3BK9jyIt9VMDU/oJ72I5/dKNocpBqd+DfcZdbAQjTte++EaSpNus82e9F
 XfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777573126; x=1778177926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+sxVPeWzK/5JcscdkmY85m6FCWps4Q/alwynbpD7Pbo=;
 b=lZvO9QpE6xEUsiBv8ONkeipJxbmRhlXRPjTuDXTg944MIj7I/JkT0xtOPYBUpK5CFI
 G9KhzWKp8zJ1/DEVWUDTn22jN7vYWmU4MGrDJLlWj1quhhHbKHTd15jlNkhOtee3xckb
 eNEFiyJBM8DHJ8+A0RQY1JshcPq2C+WKB0XBeCQHYZCdkLjVu9peoD0Juuspz05UgJoF
 qID8KvdBxc8VHP/kg4ljLINTwwWS1HByVL/sRxkjGk8JivKRQ59NrP6hNw7iwpgGM98q
 /LufH7GqRKZxfLdKUWazD7f8WZAtysIwRvy2aNuwF+s+U4JUF7liUHZXm53EUuk3DbH6
 YNcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ85wJv2paJAj318mz3AP+ZAV/5pd3xcEa0T+/eWZpBY7Ube8IZqgoRNAKAywzMj9WqACO6ebph2GiM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yweb7WZpT+5VUbscdwkF/CD+J+kKz2r7elxhyloMtecvlxOsVW2
 3KfeBl+XYrtCDVmsYiLc4vlYNmX2ZYd3s0rDhfzgZ3OIKJwO4sLmK2/x
X-Gm-Gg: AeBDiev9w2sUIFzXqpl5LeKcFqfXhoZ64CU2evY/w5KkqMvaUmeZTbka9zga6u+lHl6
 WlkP8TD+aLVpjl/hApoC8Qstd/U3Bj6VO6Z2DiZQSO/EHIV+WOpi/JZBb2E5N2Sh2M1/Nfw1OZ6
 oCUGxHzPjBR/egxZ4AEm1f/lRrsgAQ9FNummBy4cNEpx+9K/7pH0gS4Jhn1YFGHltv+Fo0XlpuV
 ppxMlY8S1Xv+k/auWkj2x7xNuDVu8ZZ/61TGjRaWydcAXVofSTL3PGhNJ1b1pOM8ahHSdDyiHQx
 c11wvexDWL1E9y+MOvUPOaGNKBq6f0z6WCWFgCwzqEwrmPzKPKAYVlemUpPBsrrzHZshfeXm7Kh
 +kD2FZEzl1RPrfJdAJgs3D5Wi6XsVM/iAujBl13zO9VTOxIkhawye4aaXfNhLn//7vg+fb/Gjed
 V2gF3rSCKZgPXooWO93j3eBHa6FDshCC9H+o+DOXbT35eA2MoYS7kHCbdXW7i0Cd/WC0TzVDJoY
 6ia8MTCImi5am8jm4UEx8xh5IGew69h3ibvqmU/gVblMKhZNRFute/NawZ0dLp2+nSL6lXSYWeI
 uA==
X-Received: by 2002:a05:600c:3495:b0:48a:5339:ef0e with SMTP id
 5b1f17b1804b1-48a83d62ffbmr66464485e9.3.1777573126483; 
 Thu, 30 Apr 2026 11:18:46 -0700 (PDT)
Received: from [10.109.92.8] (net-2-37-141-89.cust.vodafonedsl.it.
 [2.37.141.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8d15fdedsm3944495e9.4.2026.04.30.11.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 11:18:45 -0700 (PDT)
Message-ID: <7f091660-2e60-4de5-a3b7-7b8d206fd6ab@gmail.com>
Date: Thu, 30 Apr 2026 19:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Maurizio Lombardi <mlombard@arkamax.eu>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
 <DI5RO76D5IWR.19K0ES58HUIVS@arkamax.eu>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <DI5RO76D5IWR.19K0ES58HUIVS@arkamax.eu>
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

On 4/29/26 17:07, Maurizio Lombardi wrote:
> On Wed Apr 29, 2026 at 5:25 PM CEST, Pavel Begunkov wrote:
>> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
>> dmabuf when it's mapped, which is then used to initialise requests.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
...>> +
>> +static int nvme_create_dmabuf_token(struct request_queue *q,
>> +				 struct io_dmabuf_token *token)
>> +{
>> +	struct nvme_dmabuf_token *data;
>> +	struct dma_buf_attachment *attach;
>> +	struct nvme_ns *ns = q->queuedata;
>> +	struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
>> +	struct dma_buf *dmabuf = token->dmabuf;
>> +
>> +	data = kzalloc(sizeof(data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
> 
> Shouldn't this be kzalloc(sizeof(*data)...) ?

Good catch, I'll apply it all for next version

-- 
Pavel Begunkov

