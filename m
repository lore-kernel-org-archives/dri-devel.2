Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCA5C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3291610EC19;
	Wed, 29 Jul 2026 13:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wk9ewKd9";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78ECB10EC16
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:09:08 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so9240915e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785330547; x=1785935347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YUW97RbS/cuxZAvn9F7FgEb6B/w45ofSr5IJCTvWkgY=;
 b=Wk9ewKd9UxxNmeQQDJDr1uMvMZAPc99E3Y0YKEyLYU432WiXsmjATGCyTrAeoZxw6p
 I4saD9KHX6gjo6h3/w6waXFfqoJmGgjzdfpB+aVXszcDiiCphrrDM19tUAyF8XIyBo2c
 jHmvPJp8m/uNLrEVCUWzt+J1xXjIlM9H7f3gJOrimwwVNTDNF5b30P7cG5TjW6UUQt9X
 VK2aT3eVliB9M3mxRTEx8yy7puoFmkWwYdcbcV685LxoE6QppfdNMTykT5EbLhiwXg5l
 InPUiKHbDHkoKiJhzNw00/jkZBCb8zNvRpH1A7yjrt8kYbuAB9xY7nevJR1ydSmJcD4i
 ECGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785330547; x=1785935347;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YUW97RbS/cuxZAvn9F7FgEb6B/w45ofSr5IJCTvWkgY=;
 b=m/iMxnZowsugId05MyuGY+z4DnF2uP8v5Esti/8z+vijt/c8zo/IOcmX2iSvriceMk
 XhR7Oe6luF+fe1fkkll8ykr0kQmj76wVbxMhquprWHW0Ajq4ATvG96oA1o9jvLuVBeV5
 Umw6g2AUKQklAaahLXdxU/gvf4nTNC+tpbId6czYIpFKcd4dAu9lKHVw8fDsf19+PthM
 UhmlSM7xN/z2uXdRbYK9P+fUYMh1142v+7wwZlmDdCG8S7Xj0iA9l+X3M4l8bRWQeXvf
 juBNU7SGVfnmGVti4jdKm9aeLgscjm9F+HHSiCxD0+CR1oeWRBj9Tqc082C6y+H0xxQz
 2xeA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro78kfOSwZOPeYuVW/t++4F0rkdSWZa4oAf2zN/LFVmGnQoMC711fpo/mrvS5Sl0oIemehsMaIFYpY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8hmlhUdjXdG7iMqCGaBw9Mb1UYpG5n8trpYziwuOU7R/iVrQu
 AVLrCouNfJqoiPClZvSwU846HU7s03W7DBWrN45ZDkY4Qm4H/9eY3EYS
X-Gm-Gg: AR+sD12JmwNxQt0jLZdtDE2E3hyo7BRu1kmVCWp9rnD0VjIsQbYTHquXOCyxCFefXhm
 BHiKFl19vOeXYL6OE60oH3PHJHlIkDtndY4B0nZYKNgNXaJlKxExsMxkyiLvjCL24PVryadOhmA
 nngru2sWRAPoGudRJdMyuWHznqrYH1HVpulHpgxzjIb53sL8kTxbgQBqKqPxSOjTyR/7hai/fV5
 HdDCQKVkBXTqFUQRSKWym7WvBjhf3jW77cxEQS9DBAzXjG4uBJNm2zW8wSsfDpV1uLwVPVmigpD
 cqKg/qTpNU/WMv5nzMupVsH74iyUyM1txeBhiHecAsAQuzVlai4vBy2k+3oigkJJoDNTZU2B0gz
 oSEnGqzpuFe7Ez8LFNNjS75ZTG8en8te2NBh/9RUTzGRRd207ReA5ZiLOw06dCt7AOJZ8kNi9oi
 +7gdd2+ssgTwd36t3qWXe16WQW8KbOsfMLBHU918o8lUrM791P1rBzA/VTce9RBN4W+64SWIBIt
 1T1EcCBpUrYy547FY6HCtUFm6H+fCyG9lky4RdX1Lu1RF2HBZgAltmnbwT+97IMxEyuQbZvj3EX
 CkN89l6w4Gb5+yVaRAY=
X-Received: by 2002:a05:600c:348c:b0:495:4fd4:f7b6 with SMTP id
 5b1f17b1804b1-496c659f7e1mr79358045e9.37.1785330546620; 
 Wed, 29 Jul 2026 06:09:06 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:640]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d70014sm93438595e9.3.2026.07.29.06.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 06:09:05 -0700 (PDT)
Message-ID: <8160ce17-6f14-4946-9146-3d261e8398d3@gmail.com>
Date: Wed, 29 Jul 2026 14:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
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
 <b03bba6f-0a8f-41fc-af59-2a69d271f28b@gmail.com>
 <20260729115540.GA32573@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729115540.GA32573@lst.de>
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

On 7/29/26 12:55, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 12:45:47PM +0100, Pavel Begunkov wrote:
>> It was exposed in early version as I was passing a [{dma,len}, ...]
>> array, but we moved from that. Maybe I should put the minimum
>> segment size in the map structure, and (possibly over) split using
>> that for now? Keith had this chunk in his patches:
>>
>> +		int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
>> +
>> +		nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE) >>
>> +								PAGE_SHIFT;
>> +		if (bio->bi_iter.bi_size > max_bytes) {
>> +			bytes = max_bytes;
>> +			nsegs = (bytes + offset) >> PAGE_SHIFT;
>> +		} else if (nsegs > lim->max_segments) {
>> +			nsegs = lim->max_segments;
>> +			bytes = PAGE_SIZE * nsegs - offset;
>> +		} else {
>> +			*segs = nsegs;
>> +			return NULL;
>> +		}
> 
> This seems very pessimistic, especially for the case of the registration
> only having a single segment, which I'd expect to be fairly common due
> to P2P bar mappings, huge pages or IOMMU coalescing.  So at very least

Agree that PAGE_SIZE is too pessimistic, but I'd calculate it from
the sg table on registration and use here. Not ideal but should cover
most common cases like huge pages.

> we'd want to special case that, but in an idea world the caller would
> be required to provide a useful nr_segments for the I/O.

Not sure we can do it in the straightforward way from the abstraction
perspective, mapping are hidden from io_uring, and there could be
multi-device files with differently shaped IOMMU mappings at some
point. We'll surely need readv/writev support later, so maybe we can
improve while doing that as it'd mean passing a {off,len} of some
sort from io_uring.

-- 
Pavel Begunkov

