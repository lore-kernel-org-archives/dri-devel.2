Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80632C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADE510E14B;
	Wed, 29 Jul 2026 10:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsxgbQNK";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA91A10E14B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:49:48 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c1c50c1e29bso117731466b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785322187; x=1785926987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
 b=nsxgbQNK3t5F7NtuqCNBjpLlzPfKLyp6X5e6hw644mq38k6RiQbjZdBpjgHIG+Usfm
 LEOAD1C5dKCzpW+14vAE3AtGU8YqlJ6sJl8B+QvXYLyroDhjPnwHo98CnfvgorDKdhEX
 yW2hd7eHXphwhqQXML1DvE0xQXQRpMH6ogHxHLnhhSPm7UcdZUhFa29GYpTp5lqIYe4b
 smXy2K3vdfq+6K4XCubJ9Jynlf0VkUiydBoel/i5bwxhVFIRcDM08dvC6guRZCWJMJUm
 sVxjZm7/GLUtcQT/DazL/2splx38PmqC7U350BrMf9AQldoz7vYb/ZMNDDnXMgqkkayy
 b+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785322187; x=1785926987;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
 b=ep3RfJTH2vPru/ZglNGHrCp7YrEGoqdk5O+tj5z+9PuvVs20UORnfzKaAW+dO/BsE4
 ISXYRnqnrkGKgn1Ms7eeUrVWYYJRhBmyljOTXmDfo/c6Ezdo7DadjDs4/uhBe5YvNVC8
 tl4bXG/zK2wkj7H3PPLwV9VSwwciT5gwjI5Vs1UZcB/UmdfOoXmyxPLIig6jv363vYV0
 sGUPbl5+06u86N/u3OweVKEg0VGFEbWQ1WfMkrDz1BrDkk45MrL5fSl+isqEd4IPRtSk
 ZHCW6fYqyrIceFtFya51/FUOS8QRDRdXtHlYxPWIN/j24LnbApkW6ZShEf4vrICF4NjO
 TM1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSs2SP714cvDA26UgBs1048Q9uSbMT6prKZuOe756U0t/BuMq5upXLd9kMxJ7c5SCbpwrgQ+5SsEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5WDqWYPipQ5QMxCReUMPDAuEeE0f1yiVZajYYfYdpSkyKEwy1
 0ZA2pjdf6v8OIOwiJ1w7YmhzudfywkMfZaFZqIw0jyZNll9k8gfy6KF7
X-Gm-Gg: AR+sD10CYrojk9ehLHotSxpiw5zD1gM6yVEAaPaiCHTAiRO84rD00s6XMyq4FJdQ5Tp
 t8JhxgTNc5sLE/J/gMieumULEejnRTZq6/YuyaDGg9bWG3+C66U2dUucondHJOaZ6mjBw/UBQrt
 2F8ewMk57RfZ8c9xOuN6bCiqfSGRjbK2vcCc5NvFsSgJAkB0Le0tUvNO1tVbjKXwdrM5yHuLWiH
 2k47wQwx/8U1E3RtkdVdFDNa/wMJrCN4gdtC+ROSJBA6acniWAcD0nrL4niT7NRB1EcceoaKJnl
 XA6bKhl4qzFyNwo/nDkQokvDK1y/BrYB5aLWR2m0gcnZ9qQyX1lC4KEm9H7ntpLxc4ZL/vUur13
 7wijXm7LphKfkZ7aeC/StDxfzS6d9ZCXgV5lfrptsx5Iwj9sqE6VKvLB5/VjqMlCHDKW6Z/h0dE
 uDCxbbQPSCvjI/T69QU45R5pqXwB3d4nQ2JPGvtbnIu8REgt7QSOEof+1OXzEIEk3G108mz46W2
 Rp7+sALzm6O2PMpnl36xknP6iaYbpA+l8ZgWKeScpy9c5dVs8u+Csw7oiG+ESnE7TACLdMWn9Q1
 4WorcFbQATX8fxiFPPJzyn9OwK14+w==
X-Received: by 2002:a17:906:fe47:b0:c15:bea2:d209 with SMTP id
 a640c23a62f3a-c1f7215dee1mr299738366b.4.1785322187169; 
 Wed, 29 Jul 2026 03:49:47 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:640]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83d27f47sm97965566b.26.2026.07.29.03.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 03:49:46 -0700 (PDT)
Message-ID: <c81be43c-2fe3-4403-b8a9-dd19855eeb58@gmail.com>
Date: Wed, 29 Jul 2026 11:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
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
 <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <20260729071048.GH9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729071048.GH9534@lst.de>
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

On 7/29/26 08:10, Christoph Hellwig wrote:
>> +static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
>> +				    struct dma_buf_io_ctx *ctx)
> 
> Please stick to two-tab indents for function declaration continuation
> for the nvme code to keep the code easy to maintain.
> 
>> +#if defined(CONFIG_DMA_SHARED_BUFFER)
> 
> This should be good old #ifdef.  Same in a few other places over
> the series.

Going to apply both for v5, thanks.

> Modulo these minor nits the patch looks good.

-- 
Pavel Begunkov

