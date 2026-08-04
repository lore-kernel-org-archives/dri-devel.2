Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CC6C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BF210EB3E;
	Tue,  4 Aug 2026 17:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jb20+PQB";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC7CB10E141
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 17:19:10 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so32988f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785863949; x=1786468749; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kJpsobbV6cDtzB2hYIU7sj8yXmkuFvAex2Z4hVps0ns=;
 b=jb20+PQBi93FxazeX3tY1dWTGxN+RrfZbQigZKP/fzpIJQNhvvuZTDIb/SobiKJsxu
 fgczpQzRmYQvemAZKN6ZGA8l4XWLuhgLlN83B4vgusaRW0vqEk3B9/xcMt+9aW+ObWVj
 HnsSda7RwHQ9VWdKafFHGUVva/orYvinSIwk3Iy+Xn3ycXJsvpceiUNrrFU6AhT84IX+
 j1MigWNXLrt9EqcY+V/BQvi4xvobS85vudtPorl+crcPjT/HStCCyZC7JFKG3ZmHpplY
 TR2bxnCEAWPnCe6belJkJ7mb1724kivXk4f3ORU2SWuASqGdd2p4+vW1OzRfQPxkheql
 v44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785863949; x=1786468749;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kJpsobbV6cDtzB2hYIU7sj8yXmkuFvAex2Z4hVps0ns=;
 b=JXWW1h8J2D3stdZoWUNG5wjLz6dGknJ/ynC7bZkvRyOjAMEV8spSVmrTGL41YcZjV9
 WjcQLHmdr8b7ctibKHCZ7Y5U7Gjp+um26rSJ22eN+C2K4ysF8wwUboBE/k1OLNYlMmN4
 cvWQ/6psKljJZ9ejXnJLsVBmgpHdW7L4EqUupFu2UQTXQHPDv3rHQFAYbkuEkffpSDWX
 eZ9gG3Sux5pORvs6ts97IhGpc63LiRWwQlXKLDTfGRXmWJwmRSA+pILfezkBWvJj4dwP
 IhpyYKLTuWB2vRE7/GCNfLifJlvG0uJDuwk7Roeh1AmDWtTc60B8wrPx/ptoSscSsVYa
 Y79g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7uZ/vZ9xAwl6rjctH/T9OAY3ntqZvTicc7c+E0mBG8Otqx5PAMe3xDoECLawvT7WP+wZ7+nCyQrs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywb1mKwEZHrm448XSYSQBp2b6GaL/VxZvnfuaLBCJ1H1bpo2I19
 XaxV28tKutrbUOvz/PsRF/YI5NeydEtMfLzOaJulNBC2B7PdkbkwWSn1
X-Gm-Gg: AR+sD11pHvmowJqf6NJHZ0GWXoqgHF5/jJZTJ9TtFcslqGJF3eU7zjjoA5b/G7zRlh9
 ujxyALeprxeVEquki+yEoUclmICEWOKtH8nUSKG0KZEJJgw0E6XmXVg0Wtww9143R/QAhcNdVxO
 Gqh4TOVGxSFUVOA760V+ZMF0MOI2q3/DfAymZZie1uFuWtmvultdlIgYoiyrpf/cb0kvS7gY40c
 k4AV+ASp0s4jFbKrolFH55VM+Q5aLydWZP73W9kkF3J9rudQ43iAezNiZ4i2BrAM6e1/8/cAQZV
 v4yfJOMts04zQSNNvtF9lEkiWsANdB5XBO6DorUQDkLe55qs8dnKubZAN0pCtejskfVUMItxI9C
 xdoF0Bj0DH/W1rOiwK4IDAZmQgLmzRf3pxTOho8B48qqmjKrGLzDZUQJYkk6Mp+HAFcICJlu+77
 zjFP2fCeuMesaTHxSPzmNr4fpdXRxz2DLhW9gJV7w5lI1gNe/FQycE9yHV4A/aysAcVGoUiaoen
 UyIhhEOFb6ru5qAVDuGms96tenayLkc4oiBIUaxTrnl5R6eg38fEtr4YRUCplF/8PUHVGMlyZ/r
 n63XCQhI+ScNjzdbZhm16VCNiWQXM4cdxD14ubs=
X-Received: by 2002:adf:fe49:0:b0:47f:941a:796d with SMTP id
 ffacd0b85a97d-47fec4fa3admr1381301f8f.12.1785863948785; 
 Tue, 04 Aug 2026 10:19:08 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfda6afsm1357370f8f.3.2026.08.04.10.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 10:19:07 -0700 (PDT)
Message-ID: <38163009-770f-4596-abe2-249efc113f59@gmail.com>
Date: Tue, 4 Aug 2026 18:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/16] block: introduce dma map backed bio type
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
References: <cover.1785596451.git.asml.silence@gmail.com>
 <e26aefbcb383be7092dc76343ce745013e671334.1785596451.git.asml.silence@gmail.com>
 <20260804162440.GB12292@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260804162440.GB12292@lst.de>
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

On 8/4/26 17:24, Christoph Hellwig wrote:
> On Sat, Aug 01, 2026 at 04:46:19PM +0100, Pavel Begunkov wrote:
>> Premapped buffers don't require a generic bio_vec since these have
>> already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf
>> maps as they are mutually exclusive.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
...>>   
>> +static inline int bio_split_io_at_dmabuf(struct bio *bio,
>> +		const struct queue_limits *lim, unsigned *segs,
>> +		unsigned max_bytes, unsigned len_align_mask,
>> +		unsigned start_align_mask)
>> +{
>> +	unsigned bytes = min(bio->bi_iter.bi_size, max_bytes);
>> +	unsigned seg_shift = bio->bi_dmabuf_map->seg_shift;
>> +	unsigned offset = bio->bi_iter.bi_offset & ((1U << seg_shift) - 1);
>> +
>> +	if ((bio->bi_iter.bi_offset & start_align_mask) ||
>> +	    (bio->bi_iter.bi_size & len_align_mask))
>> +		return -EINVAL;
>> +
>> +	/* single contiguous range into the dma-buf */
>> +	*segs = 1;
>> +
>> +	bytes = min(bytes, ((unsigned)lim->max_segments << seg_shift) - offset);
> 
> I guess ->seg_shift is some sort of encoding of a max
> segment size?

I'll add a comment.

We rather need the minimum segment size, you can always split large
ones. I calculated it even stricter as the least common multiple
pow2 to avoid divs here.

If the device supports N segments and we know that each segment is
at least M bytes, then we should be able to issue IO of size N*M
of full segments. The line above truncates the bio size using
that + offset adjustments.

I guess it might be more straightforward to calculate the worst
case number of segments and then adjust the splitting size, but
since we don't return the number of segments it's more
computations. E.g.

seg_size = 1U << seg_shift;
nsegs = (bio->bi_iter.bi_size + offset + seg_size - 1) / seg_size;

if (nsegs > lim->max_segments) {
	nsegs = lim->max_segments; // unused after the block
	bytes = seg_size * nsegs - offset;
}

-- 
Pavel Begunkov

