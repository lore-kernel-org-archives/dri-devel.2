Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116C7CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513D310EF31;
	Wed, 14 Oct 2026 13:41:04 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0596410E8A6
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:40:57 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-823b938464fso658724a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791985257; x=1792590057;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TI1InYuhv2BOMB8UNQLzhmzx2APX9vyjkfAbRr4ddfE=;
 b=nz5/jY7prstYnNKVisBlFfjOT2qVvKRSpbn4TrNNs77glTPZ8/butBxzhknYoWDCb8
 lpmjZbI/WyVmfeloMQgYIhXcQQaxLqYAqLM0QlTap0p/lbXLZFJFHJF6ZJW9nFE9XiOP
 QPZgRB9ur7EmXQ5OEzpiF0r36zD5sx1vJCjcLu+vN/+Cjg74HF7dfRpJZNIb0Gbwj3go
 a/3mDXLlCdlmFHWy9F+qMib2YiUzq3sMHMiaVIQN3FgU2yywYVZp23vAvhAesK4P5gjq
 I9WN5yAEHB8S+ZlSQu/s9t7mfJ93uF9Ef+dafT/2HgguUh4/kEmZccuPgbMSjbQju8nQ
 iKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791985257; x=1792590057;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TI1InYuhv2BOMB8UNQLzhmzx2APX9vyjkfAbRr4ddfE=;
 b=xTXj35HjF3DGm6INpKrxtFuMig65omGralyEam0CrjrAsns0KS0A8iZOSfmBN4wmhS
 XSwROatmcGHgnpoK9PrfyUkqiXsUxQlINIRQVMMb1b8yNPjxk7cv77Nax3RdfU3u0gfz
 MOltjN0YbakFSeZ5dt1JMEgMXcbg5flh1lhWs+mGgZWhj3L9J2VqjSx9vYpsDr58l4dr
 GhhRlOfDeM6HgVPWQgAb4AHt29Icw2fwzOOhIlX+PWzCqwCr2akphthkCts+8HV50RNA
 kvWH2SmwRbOZ0sm7yFwksHjSO/iT5rIw8w7w1fJaIaOOOvrKt+LmPQ1aNRCqo5Mzvsah
 5YRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxvAy0yd90n4mBiioQYeGTo9tRCCqP8supTd1Bt7p74aam+hqNKS8LnHo+1qEbNMdoaj08+ycUW3Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLmwBCYC5EsC5kjeGSgWXAvwAgp7Uh91Mt+eVWAPLvpsiEkHwI6
 mP16tIGyfWlGbqG6KBUO6iOX+0dDc8fVWF25PO68WXMrVnj6ddCR7lmaJFWtXalysQQ=
X-Gm-Gg: AYBFou32J1zIM6BbL4TqGxAHQa1qUfl5OSU3491AEFOvVSElYjxC81G5Y+SLpYcIqZG
 hQSWoo7ZWCKq4RamiHbCm6w9dxZhVlK1Mh5fcWz4JcCy5+FQ3By8kaJxemaOVQ0I8PDmUTnpl6o
 uUYvOXOOQ9o7wGEffGoyUrYRMH/kdCzOP20MZEiF5+FIHqAws35Ig1dXk27D7rKN/b5nTFW3kRg
 EBOl/EfOwcsh2HNPLNzQmZxuYZ4dLp316NlnD8irCAioiLbdQm6k4VNW7ZtIMLAiUHippKrjoj0
 sgTWKlYSpu5YsKVk1KLni1JJFEP82ao1keKH3+Dr9wNDhZG8rPKf6FG21EERXStYwgQLHlrqJOl
 y648xsTw0ncocWvP96AO9tvnf0NNTpD+he8bD18+0Ue5PVIV6wicdtsk5w3cnZKAS0Vq0KynaSY
 0FNj/E3AhPKLWAwfmG33nXc2N5ujvjv66xII7yNGn2LVi8n6WrAQ4m4O0ES7ukn1PT+CGlgQ6Xr
 7SlHjEkIRJH2iPMPOVm65sFSMaAyrSUE6Ex4UeeAt1PWDuarXoGlGP1Jg==
X-Received: by 2002:a05:6830:67e4:b0:812:4cc7:4afe with SMTP id
 46e09a7af769-830969d183fmr14838309a34.17.1791985256814; 
 Wed, 14 Oct 2026 06:40:56 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83038f822dcsm14657364a34.10.2026.10.14.06.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 06:40:56 -0700 (PDT)
Message-ID: <81e6538c-977c-4b45-bd44-242ce5e00dd7@kernel.dk>
Date: Wed, 14 Oct 2026 07:40:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 13/13] io_uring/rsrc: add dmabuf backed registered
 buffers
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791975048.git.asml.silence@gmail.com>
 <4aa230df871ee275536f367087b44ebfebb88cc1.1791975048.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4aa230df871ee275536f367087b44ebfebb88cc1.1791975048.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

A few nits:

> diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
> new file mode 100644
> index 000000000000..1a1a88640823
> --- /dev/null
> +++ b/io_uring/dma-buf.c
> @@ -0,0 +1,66 @@
> +#include "dma-buf.h"

Needs SPDX license header.

> diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
> new file mode 100644
> index 000000000000..a876a9e5e272
> --- /dev/null
> +++ b/io_uring/dma-buf.h
> +static inline int io_attach_dmabuf_map(struct io_kiocb *req,
> +					struct iov_iter *iter,
> +					unsigned issue_flags)
> +{
> +	bool nowait = issue_flags & IO_URING_F_NONBLOCK;
> +	struct dma_buf_io_map *map;
> +	struct io_buf_dma *bd;
> +
> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> +		return -EOPNOTSUPP;
> +	if (!(req->flags & REQ_F_DMABUF))
> +		return 0;
> +
> +	bd = req->buf_node->buf->priv;
> +	map = dma_buf_io_get_map(bd->ctx, nowait);
> +	if (unlikely(IS_ERR(map)))
> +		return PTR_ERR(map);

No need for unlikely() with IS_ERR(), it already includes that.

-- 
Jens Axboe
