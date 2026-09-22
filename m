Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C7CC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC12510EB2B;
	Tue, 22 Sep 2026 09:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KcrKOwwr";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7522E10EB2B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:08:43 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae52so6167719a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790068122; x=1790672922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dTXrnoLoVJCuS9ADi1i1j1z6MUlrlfKtSYdHYbXCKbo=;
 b=KcrKOwwrfvnA/9r7wmrEbWer0mA/sK0vlRaINbVgfJeWy7s0WhcyNug2ojZJN1yLmd
 JgUG0MMZ1kvE7J4nIB8R6nUF0RJr+7sMTp9YjuaWYo0RMQo92/mj5jn5DZgcbgonRLGW
 rXjVM2L5q1iBCYsg55anw1n0rFzvt3JZP7SDzol7YbGVqRLAzG5rtJaeRLQf1RcEnQb6
 FWjjhgujaTvdLUvWF6v+AqYcFehR8XJCRGqdDrB4Nl8x+oE19yBmXhjzh5bA1Ssc6avM
 DyH8v/l6Y4klNsi/OXdFSYFHSR/A99HciMBseFcs6KitPTEn5ic1leZEbYSXhGPpBgz2
 ce+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790068122; x=1790672922;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dTXrnoLoVJCuS9ADi1i1j1z6MUlrlfKtSYdHYbXCKbo=;
 b=1UTY7vXFtiW6X+vPc8OsBjSXJxmRWUDkDv8zZThfWHpeEmuXyD3UHsg2r83L8LohKH
 PAyDgy8g6r66LaiRhxnxC2zGNQNIJEpweWmmhx3Uf6mMcs2iINm2dhlN1CpCGsX2O3wX
 AHlrj84N0edTn3QZ047yXhw50kkf8oHHJQk+bsMInkHAPaY1JjhcJ+kiZ2T+nmlP0rNQ
 FZqeaGKRBnjvx3uR/UyrkZYcOkzWyy+6aFPsTpHGScRpXiJBzsA0QXYPpJGHxW5Xdem7
 3/Og2CW4oU/eXQ+0wMsn/uvUMuxawsU+Of7jjnIg7p+6S4eEA/Zb3zahHmoERYzIIJAR
 VxzA==
X-Forwarded-Encrypted: i=1;
 AKwUvByC4xSqixZm7i6UlsNecGlj0C6yTTnv/j4HRGmw6ydgtM2fjWYMt6soFRyuhHFJoycsy5nkxByrILQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++miC+imsdsHKH5ycoMdnHquGPr6juQSPq3vlek4xlwfQjn0PX0J
 s+zeKdfsGcA+bWa244S4v0/0HUvwNJOVRNCv6UDIklyBZ4+5vp6kqyAW
X-Gm-Gg: AYBFou1Z0iIvL9v4Ox5aqEUJL4BQRmENxIv4Dh/my20lW5qOyztR0jyTiq1XGwRI1+f
 f1uMQbbiqUwElevV4uEi2q4XjleES/OetDiAVybiNrpX2V5NTnhcErouSP0FN3jlrV0bSasjmzu
 IRSTI5BEkqS5qzMir6CBVteqJYP2bATqaD7iw1LfcwK41WtvxzMG3RDO3VepFhY+96XX+7KGwQE
 MLOBF2vvVYFYN+3czEK7R72UtvwBKkeFM+hEXt70vwAjDKFvI8EpAhM7b8KnR1pdbUGIMYTtgHC
 jdCCzvqOMsgGDFh9g2cJqn3HXQESTGqP0EhxvGM/VEZ2uEchKPMncJYguVc0vQP6S7zGskBpiEb
 YXA1hatDc8JZGjpf6lX+0JTAJyK4GQ818CRdkcWHCe/HQUOo0mUPxR8PFjdPkN5KdfqP32YyjMO
 tHH//ldBWUGCJVIN1yxtv6QlD2JVVSSk1cJSPiz79e0G4lM4hQ+r4bwDQDjjhQvoEv9swopXGhY
 TUZPOnVYSjv6kO89w/LhqCKG8Pwwr9ggY35r4F8RO/iFfbECRlpReYLrUmO/5zWzdQ/kqWYO7R8
 0qF59I1sfRYr2N7NC8S2fAEhyCRxZlyPbcYv76IKcrRrEguu
X-Received: by 2002:a05:6402:f08:b0:6aa:9d7b:cdb7 with SMTP id
 4fb4d7f45d1cf-6aa9d7bd216mr1932146a12.3.1790068121665; 
 Tue, 22 Sep 2026 02:08:41 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aaa44f7aa0sm631529a12.16.2026.09.22.02.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 02:08:41 -0700 (PDT)
Message-ID: <17884261-52ab-484e-a39a-01e67f7a1d2e@gmail.com>
Date: Tue, 22 Sep 2026 10:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: sashiko-reviews@lists.linux.dev
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
 <20260921135344.035B81F000FF@smtp.kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260921135344.035B81F000FF@smtp.kernel.org>
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

On 9/21/26 14:53, sashiko-bot@kernel.org wrote:
...>>   }
> [ ... ]
>> +int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
>> +			struct sg_table *sgt)
>> +{
>> +	unsigned seg_shift = ~0U;
>> +	struct scatterlist *sg;
>> +	unsigned long tmp;
>> +	int ret;
>> +
>> +	for_each_sgtable_dma_sg(sgt, sg, tmp)
>> +		seg_shift = min(seg_shift, __ffs(sg_dma_len(sg)));
>> +
>> +	ret = percpu_ref_init(&map->refs, dma_buf_io_map_refs_release, 0,
>> +			      GFP_KERNEL);
> 
> [Severity: High]
> Does this GFP_KERNEL allocation violate DMA-buf locking rules?
> 
> dma_buf_io_create_map() calls ctx->dev_ops->map(ctx) while holding the
> dmabuf->resv ww_mutex. If the driver then calls dma_buf_io_init_map() under
> this lock, the GFP_KERNEL allocation could deadlock if memory reclaim
> attempts to acquire dma_resv locks.

Most of these look trivial, going to fix them. This one, however,
doesn't sound true AFAIU, I haven't heard about any blank ban on
GFP_KERNEL allocation under resv lock.

-- 
Pavel Begunkov

