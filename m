Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2543C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BFA010EBB1;
	Wed, 29 Jul 2026 11:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vy2deXpr";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF2C10EBB1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:46:09 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso5842685e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785325568; x=1785930368; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=57DEPZ87ucJ5C9uIRumsuvToNlPqHFcS1ybRBzt41xg=;
 b=Vy2deXprZxkf1s9X7eU1mzsUAVvKK35K1wgCDA/l87BkKhQg+2U5WJ6FO1GSTIbdKx
 JzHgvCxJTWErNuhhg15rHylpNBuaR/ivkqV/0acIY80FZ27IwJwUd1HtNpH5M+K4cSjf
 gGh3JEM9FGrECxul7BsC9RPSc7HQVRFHyod/zPaMfs0wA78SMHcu6hT7QuiW1eCO0ZPP
 EPB0cQp0wiITDF9qe6eOglGPT4pMELzldKNHRmCVvh4EOjyl8iXAAAFg8PtwrPcHjFb2
 Lilg3xOZPY4ZbB3FMPCg+3ouNI/LOWj2lcIMQr3PW75h5wvmwDfZyh1r1vgXEaH/22hC
 1qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785325568; x=1785930368;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=57DEPZ87ucJ5C9uIRumsuvToNlPqHFcS1ybRBzt41xg=;
 b=JXI9aMgVlsw4rQYVks1F2QN5i8HxL/AGxrQR/bbeFDU4Ohvbp1Kw51ogayy+viRbv4
 MYxr5V+h8+QdYcAJkFFDMoiNRxVPAeIGKrEOZKQQOv61kqf5Jxvu4FPu1jKey+PMAvTn
 k91r7PgvrIVkzF0+Hg45RNxU4Sv3eGKmJaqbsQmfkCfa7Ga8RPRmNg/SSmJawoS8+5HL
 jiu0XV3jKwYSBEKl7RScra5KMRYWScU/n+tcWC1W8quDVBYXOiURGctaGg53K46jVNEg
 j+8xsuG6Ky0VRekMqJ41jGrql7WV6OzqoY62XylXiD7mBIss9UZ4vCSz0u+rZwMqs4u0
 BoWA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrf4ILTNHHN+WEas/uu81FIV2bI1DiyY635Im9pb8EAPQIu20vmuy0KMp2IMwXmNYiReYD928SfzLo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyr1IKomZamLmnMvGQkgguDKpvVW0eYGcLjqpY4tdSSsas91cBO
 iTNE4oj3Cee67sEYOzz3QelUwol9JcyHfx72MI/6RfNB5y0plbdvpdYg
X-Gm-Gg: AR+sD1284fScG7FdmiBVu6VnLdOEISlmwJGXSJ6E4CGasr8y+w2nmYcTBsaHuzhmDXH
 raseumnIGiNb7Tvqw6IXV5AWHvN5JqS489wUPlR9+ZQYht862vQ2JRVXTXxJqbglJYobl31OLwM
 ziZP7OAOO0PruZYv+GYXep2IOnPSG+wqVGZ5tS86OyTFAu30GbyUbFhOtnFWgKrBY6tGq/4AA3i
 aDM4/YlRP7+fWOP7LUEvDRgHsG3Rkp31T8gW3U9Lfu9/QdiazAT5NBx/W6trdmmQGypCfrZEulM
 Vm6ePeN8F/O9wWGrRrxRV5ic+AiTPk9H/MgVfOeOeFeCqQGuSKbYbiAgc5YrUg6fiFT1SR/GdBE
 fRo5wIyTBQIUykOlReKxJBuG+Gcqndof1yECQJksBMKG2vtFN/oQ4mBDlIQjxUcYwClMtsakv4R
 HNt9d7hIdjA6y0bi9gv76Vsw5mWu5anNPhD31CE6weCx6mrx03ea2vPyTuh8xUyeTfXsxlEhxyK
 kMI5iaXdOtWKDTV+JIpWc7wwGW4zSALyKVaJRXcozqly9Iko2SOdr5xZLhZK4Hf2mdOcBwnWbQo
 xNyZXwK9M5SUHRe/DVbdJLd0fzAj/w==
X-Received: by 2002:a05:600c:470d:b0:493:e365:7630 with SMTP id
 5b1f17b1804b1-496c6431d1fmr69913135e9.14.1785325567969; 
 Wed, 29 Jul 2026 04:46:07 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:640]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-497fecfccc7sm26554895e9.12.2026.07.29.04.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 04:46:07 -0700 (PDT)
Message-ID: <b03bba6f-0a8f-41fc-af59-2a69d271f28b@gmail.com>
Date: Wed, 29 Jul 2026 12:45:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
To: Christoph Hellwig <hch@lst.de>,
 Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
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
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, cpgs@samsung.com
References: <cover.1785274111.git.asml.silence@gmail.com>
 <5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com>
 <CGME20260729072126epcas5p3ad4422a45f1274b71f15dec8bf487fcc@epcas5p3.samsung.com>
 <20260729072117.GI9534@lst.de>
 <81412691.21785320403945.JavaMail.epsvc@epcpadp1new>
 <20260729113108.GA31120@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729113108.GA31120@lst.de>
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

On 7/29/26 12:31, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 03:47:23PM +0530, Anuj Gupta/Anuj Gupta wrote:
>>> But I also don't understand what the use case for this function
>>> is to start with.  struct sg_table tells us how many segments
>>> exist on the DMA side in the nents member, which should be just
>>> fine for the SGL threshold calculation.
>>
>> sg_table->nents covers the entire exported buffer (<=1GiB), while a
>> request only covers a subrange[bi_offset, bi_offset+payload). Using
>> nents would overcount the request's segments.
> 
> Urgg, yes.
> 
>>>> +	if (!entries)
>>>> +		return BLK_STS_IOERR;
>>>> +	if (entries > NVME_MAX_SEGS)
>>>> +		return BLK_STS_AGAIN;
>>>
>>> Given that the block layer enforced data in rw/command and the
>>> max_segments limit, why do we need the extra check here?
>>
>> A dmabuf bio reports nsegs=1 (bio_split_io_at) to the block layer, so
>> max_segments isn't enforced against the SG entries actually spanned by
>> the request. Hence the explicit check.
> 
> We'll need to expose the actual nsegs to the block layer and split
> based on that.  Otherwise I/O might work or fail based on the device
> capabilities.

It was exposed in early version as I was passing a [{dma,len}, ...]
array, but we moved from that. Maybe I should put the minimum
segment size in the map structure, and (possibly over) split using
that for now? Keith had this chunk in his patches:

+		int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
+
+		nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE) >>
+								PAGE_SHIFT;
+		if (bio->bi_iter.bi_size > max_bytes) {
+			bytes = max_bytes;
+			nsegs = (bytes + offset) >> PAGE_SHIFT;
+		} else if (nsegs > lim->max_segments) {
+			nsegs = lim->max_segments;
+			bytes = PAGE_SIZE * nsegs - offset;
+		} else {
+			*segs = nsegs;
+			return NULL;
+		}

-- 
Pavel Begunkov

