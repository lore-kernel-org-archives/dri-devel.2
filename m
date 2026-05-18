Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499B4CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9403710E5D6;
	Mon, 18 May 2026 10:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZMH1Jot+";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55FF10E5D6
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:29:57 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so704338f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779100196; x=1779704996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yBM/MqSlhfscJgewJTDJnR/WZOfF3ZaH9qUvK+mYr0I=;
 b=ZMH1Jot+re0OWBBv3bavQYj40d5gqz2kgVJKzaNCu9xhspZ569grTvL+LpIMnshBcg
 0fUrOKH01HD0RtUTfM5rifM8LrEhvh99EBA797L9CZkozzFLRcJ2lCpDosctWh0eCREB
 u/+GUHigihgwoMcSKC2qAN1nm4mt2MoLl07tCvudRceHrpVhsJkBfMnKhw+vfunz0Xuf
 h9rFXt/Izz9OBGdLOedUrIioa44nEOCMUkwNpScXpLa1O6tEXB8diLjhsv8LeWDdicWB
 hbdmO8eUtUlom+eRwTGqM/XOF9NVlRVGIFDxMeesyhs6nXyfpQKuGG+wbqQfaLDbAE4E
 k8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779100196; x=1779704996;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yBM/MqSlhfscJgewJTDJnR/WZOfF3ZaH9qUvK+mYr0I=;
 b=mEkHIdPqmUxrRXAjkVR995UNGtfU2/vrvNvwzM+1jApQ+oC4kDRkEXqOaitaKR/c3j
 X2kIxSZuksPHrIBLF49GYXDtWD/sGZ3UP5TfsVYFB3rNcYVMwZEaae2wTyehWeK1iG7M
 9yfUlcf16cNL+XNl941KG1btklsgIFHfYgM9WNEYfwY6IE3e0+JcbHJvnC4veU5n7uRD
 HjpWFdOGkZhtrUImanHXu8hJtiyLQEDcFzNl9ViPfKaPxsu6RC3Ur1GR6iFCD45g1u83
 5DHQXt/CxkRpSkZmnrX8mE0P2TR19ZlgzpTqGchE4A6gQFzGa76htKHyuti6KInnum+5
 v2Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8T2HvLPtil5NuBUsvphX6E2yKJyon7Cgw8d7KtXuy58bz+jJ68D08a7gdWRJXYnq0e51BPsvDhY7M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtBfo5hRM6C8G0aaS58uq6VpaT//x2PAR2ynQ+jWkVhJLLhJGr
 ZIRB83zPBwzMFd2uAG8y6GmihEOBbqT3ZYC/IgELM6slyv4gk3jhlSXz
X-Gm-Gg: Acq92OFtUKnjC6D0Uh3VcNthbb32vQxc4L2NmE0hzepAgXGoqZbIM3JduRNg4Uy38T9
 d5eSkSgE326w/zb5Femd7xMIWi1PBqzLsTWEHllFyXoy7zbSG1B2PxuIScqGVdS1C7inYD+d2NM
 HQct1HZk7ROn0gnFEVPLKqnXDlIYuetbLPsigEpCx4mzpbVBqmXYZlfW9j5s5M1UbiJCGXjABM3
 azP3xSmZf161nr7B7vjsx7lpNhqpYXnqQNBbUOWtV4PBPZHUJXemKqdK5eyJ2geeMI1mYRiQu0m
 mIH55rVd/afAosr/GlZzVV5GMkJiEJXWA+qWdsOCsfWBRioKuqxGFqrYAA/049FpI1YGoA3GT5Z
 djwGGovq9bcOsuejybVsOWbIdNsQ6DDzt8LdvN54Xb51Lv++kQpv5MLENPH2FWcTfDtIyX4bY31
 sFJ8H7NkGtfuCNvT3C8Qv1eBt9X497gODim7hLPVKnkjS+ntgFVxFPEbQWQxgSDW4LtTWVn0zlM
 5ocE//yFJxUHvkgLS6X289xvx01d2SDSOAWU9Nn5Rwvxm9nIux85eUjOZ8=
X-Received: by 2002:a5d:5885:0:b0:43c:f7e5:817b with SMTP id
 ffacd0b85a97d-45e5c5cc2b5mr22613508f8f.19.1779100196106; 
 Mon, 18 May 2026 03:29:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:ec20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6454sm36537426f8f.34.2026.05.18.03.29.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 03:29:55 -0700 (PDT)
Message-ID: <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
Date: Mon, 18 May 2026 11:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
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
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
Content-Language: en-US
In-Reply-To: <20260513081929.GD5477@lst.de>
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

On 5/13/26 09:19, Christoph Hellwig wrote:
>> +	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>> +		bio->bi_io_vec = bio_src->bi_io_vec;
>> +	} else {
>> +		bio->dmabuf_map = bio_src->dmabuf_map;
>> +		bio_set_flag(bio, BIO_DMABUF_MAP);
>> +	}
> 
> This is backwards, please avoid pointless negations:

I can flip it, but compilers tend to prefer the true branch. E.g. this

if (cond) A; else B;
C;

can get compiled into:

jmpcc cond B
A: ...
C:
return;
B: ...
jmp C;
  

> 
> 	if (bio_flagged(bio_src, BIO_DMABUF_MAP)) {
> 		bio->dmabuf_map = bio_src->dmabuf_map;
> 		bio_set_flag(bio, BIO_DMABUF_MAP);
> 	} else {
> 		bio->bi_io_vec = bio_src->bi_io_vec;
> 	}
> 
>> +	if (bio_flagged(bio, BIO_DMABUF_MAP)) {
>> +		nsegs = 1;
>> +
>> +		if ((bio->bi_iter.bi_bvec_done & lim->dma_alignment) ||
>> +		    (bio->bi_iter.bi_size & len_align_mask))
>> +			return -EINVAL;
>> +		if (bio->bi_iter.bi_size > max_bytes) {
>> +			bytes = max_bytes;
>> +			goto split;
>> +		}
> 
> Please add a comment explaining why nsegs is always 1 here.



> 
>> @@ -424,7 +424,8 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
>>   	switch (bio_op(bio)) {
>>   	case REQ_OP_READ:
>>   	case REQ_OP_WRITE:
>> -		if (bio_may_need_split(bio, lim))
>> +		if (bio_may_need_split(bio, lim) ||
>> +		    bio_flagged(bio, BIO_DMABUF_MAP))
>>   			return bio_split_rw(bio, lim, nr_segs);
> 
> The BIO_DMABUF_MAP check should go into bio_may_need_split.

Ok
>> +static inline void bio_advance_iter_dmabuf_map(struct bvec_iter *iter,
>> +					       unsigned int bytes)
>> +{
>> +	iter->bi_bvec_done += bytes;
>> +	iter->bi_size -= bytes;
>> +}
>> +
>>   static inline void bio_advance_iter(const struct bio *bio,
>>   				    struct bvec_iter *iter, unsigned int bytes)
>>   {
>>   	iter->bi_sector += bytes >> 9;
>>   
>> -	if (bio_no_advance_iter(bio))
>> +	if (bio_no_advance_iter(bio)) {
>>   		iter->bi_size -= bytes;
>> -	else
>> +	} else if (bio_flagged(bio, BIO_DMABUF_MAP)) {
>> +		bio_advance_iter_dmabuf_map(iter, bytes);
> 
> This is a bit of a mess.  You're using bi_bvec_done for something that
> is not bvec_done, which makes the naming very confusing.  That is even
> more confusing than the existing usage, which isn't great.  Also we
> add yet another conditional to heavily inlined code.  I'd suggest
> the following:
> 
>   - add a prep patch to rename bi_bvec_done to bi_offset, as even for
>     the existing usage it is the offset into the current bio_vec as
>     much as it is the count of byes done, as those must be the same
>     and it is used both ways
>   - add a prep patch to also increase bi_offset for bio_no_advance_iter.
>     It is not actually use there, but incrementing it is harmless and
>     this will avoid a new special case
>   - please also documet this new usage in the commet in struct bvec_iter.
>   - then just add the dma buf mapping to the bio_no_advance_iter condition

I'll take a look

>   - figure out what to do about dm_bio_rewind_iter, which pokes into these
>     things that really should be block layer internal

Need to check what that is, but doesn't implement the interface and
is not supposed to ever see the dmabuf iterator.

>>   }
>> @@ -391,7 +403,7 @@ static inline void bio_wouldblock_error(struct bio *bio)
>>    */
>>   static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
>>   {
>> -	if (iov_iter_is_bvec(iter))
>> +	if (iov_iter_is_bvec(iter) || iov_iter_is_dmabuf_map(iter))
>>   		return 0;
>>   	return iov_iter_npages(iter, max_segs);
>>   }
> 
> Please update the comment for this helper.
> 
>> @@ -322,6 +327,7 @@ enum {
>>   	BIO_REMAPPED,
>>   	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>>   	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>> +	BIO_DMABUF_MAP, /* Using premmaped dma buffers */
> 
> Shouldn't this be a REQ_ flag as we should never mix and match bios with
> and without this flag in a single request?

Do you mean adding both and propagating it from bio to req? submit_bio()
takes a bio, so we still need to set it there before it reaches blk-mq.
And there might be bio-based drivers using it in the future.

-- 
Pavel Begunkov

