Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57152CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B930210E745;
	Mon, 18 May 2026 09:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ogSkazjX";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E9010E745
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:29:24 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso25534545e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779096563; x=1779701363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CDwQwZfzQ+v4zAM7BuOooX+kRgbnUOKOzvArP/cGiqU=;
 b=ogSkazjXW0lneCv8eLUHyEJqnLZurJZCWxclYqhnCQ1mX62feZNbBT+IXFFslKcOXD
 hKqaXoNseBcnBSWIbZW0e/CDakxwMQ9pKlWDB3YUMoG9elSCY2mKutwIyIKuX1mm5k+b
 6Rsshj/x1mxrO82nXNqFUxFvS9vsPKwcxHyYkwce9j2jzHrDckAcR1s/zix7+N8fKwfF
 pFjVBzkEBVkX9m0zMmB1wEW9SVTZdE3ovSSCG7B+kC1VRdwSHHoLEhMAEPhFsjKs79q1
 hpD29iLPAEwvmlHYz4MCba3TSzkHIzU+x1XYnAKRz5pOgmSbsZiCtgiajU+0huN/RzBr
 nm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779096563; x=1779701363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CDwQwZfzQ+v4zAM7BuOooX+kRgbnUOKOzvArP/cGiqU=;
 b=bfxGZ1xi8PURUnPHFbjZeTddi2yVI7HU7C/Zr1aTwXUEZsH72JRCw2MVsTaRicO1ej
 M8z+n8jI12grv3CwlswkbjbrlAx+jwKjY/AsaSPetI4qINd/2vsCVm9B2cmZHq4C75TR
 os8CgEwnMYiruXbIWMomgI6l0QZ4EVJtVVqqKRTxyzPs4A4nv65SbS6uie7Tamq+i9Ia
 CXV0jECWuEt2pCJTvNeZFQyE8KtSp13tOhStRBIrJ6ULAGt9Qsh2x+1/dzfG05+2E86a
 KSxt9ZDhC+YhufYN2+gLb8K3LGV/Jo8NBc0md46QW+ASjwLHxQ2z70UFsvrn9GrcuJhh
 RyqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WVlKoGCqUd2wPM5h9nt7Mt3ssiAb6N1FycvU3rn5CpgujqE1aaAbYUXnz6XnSt67Zhkn/QqcSN74=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVRzN2BddgH449DNX6qXhYD9uLswx1eSoxALrHgVrPSxdy5Dx7
 PyH0oQJy+C2LOZMlVk1mx01+LMZXWL3cLXe+yXevzRJ0gBFB2uZEilo0
X-Gm-Gg: Acq92OE9//BmkRRrXFVtONzYNwfLDREB/ctBVVIhUKB6jnS81i+vsdP0AKlzUL0Px68
 g2PbbUN0ellcKdhA6S1rVlO6J6Ge4f2Wbl7xnPsDTqdcKb+3ETmwz0rof7YzrQ3wXkJZjkhWKag
 MHcgW72dN6O+BFJlpc5tduDAGnYTXvEY2ZBPe4r3bQgRgigDDpHajACqGFAfMXql/C8HMnrZYYb
 U/P07GphMuc4dVWZjzSJ1h4vpdqvPYcrjIn+ZOmIBaxEdw7ZeLNeJr5PMJknB9zubBPPa+qRb9N
 OAnkgTT2tZ8ixVtdWIPIO1cibaa1B6HfoTKYZt39KORJ1VKSXnaL+LSXV5c2hV/pD93HBlAkgrp
 oiJVzfiPzi7jCS+iio7YyuFeQS/MYC3Vn50KwxqvC4Fw4QYrdVxdNe1tqmKFQwLVAOaAiANzDnr
 wDCBg28xkYZ32gak7+V1D4P/oMmgh9mcVsb7rS8KdabucLVatBDvAP11Vg2+hZdioZAIg+qt+pV
 5Vl/3IXz3PYuVL+a4VZNLD722Bivu2RB7SBy6qfe5imwPJv4O1yOnMgDgZc+SeIJ63rGg==
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id
 5b1f17b1804b1-48fe59b047bmr240818345e9.0.1779096563202; 
 Mon, 18 May 2026 02:29:23 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87?
 ([2620:10d:c092:600::1:6e9b]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe582e3sm88451385e9.15.2026.05.18.02.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 02:29:22 -0700 (PDT)
Message-ID: <50ed7240-d8d3-4816-bcc9-ce8adbbbf841@gmail.com>
Date: Mon, 18 May 2026 10:29:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
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
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
 <20260513083817.GC6461@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513083817.GC6461@lst.de>
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

On 5/13/26 09:38, Christoph Hellwig wrote:
> FYI, I really want SGL support before this get merged, but ignoring that
> for now:

I was hoping to let Samsung guys to send a follow up they already have,
but I'll ask them to have about taking it into this patch set.

>> +struct nvme_dmabuf_map {
>> +	struct io_dmabuf_map base;
>> +	dma_addr_t *dma_list;
>> +	struct sg_table *sgt;
>> +	unsigned nr_entries;
> 
> I'd make dma_list a variable-sized array at the end of the struture to avoid
> an extra allocation and pointer derefernece.

Ok

>> +static void nvme_dmabuf_map_sync(struct nvme_dev *nvme_dev, struct request *req,
>> +				 bool for_cpu)
>> +{
>> +	int length = blk_rq_payload_bytes(req);
>> +	struct device *dev = nvme_dev->dev;
>> +	enum dma_data_direction dma_dir;
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map;
>> +	dma_addr_t *dma_list;
>> +	int offset, map_idx;
>> +
>> +	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
>> +	dma_list = map->dma_list;
>> +
>> +	offset = bio->bi_iter.bi_bvec_done;
>> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +	length += offset & (NVME_CTRL_PAGE_SIZE - 1);
> 
> Please initialize the variable at declaration time and use or add proper
> helpers to simplify this:

> static inline struct nvme_dmabuf_map *
> to_nvme_dmabuf_map(struct io_dmabuf_map *map)
> {
> 	return container_of(map, struct nvme_dmabuf_map, base);
> }
> 
> ....
> 
> 	enum dma_data_direction dma_dir = rq_dma_dir(req);
> 	struct device *dev = nvme_dev->dev;
> 	struct bio *bio = req->bio;
> 	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
> 	dma_addr_t *dma_list = map->dma_list;
> 	int offset = bio->bi_iter.bi_bvec_done;
> 	int mmap_idx = offset / NVME_CTRL_PAGE_SIZE;
> 	int length = blk_rq_payload_bytes(req) +
> 		offset & (NVME_CTRL_PAGE_SIZE - 1);
> 
> Also a lot of these ints sound like they should be unsigned.

Ok

>> +
>> +	while (length > 0) {
>> +		u64 dma_addr = dma_list[map_idx++];
>> +
>> +		if (for_cpu)
>> +			__dma_sync_single_for_cpu(dev, dma_addr,
>> +						  NVME_CTRL_PAGE_SIZE, dma_dir);
>> +		else
>> +			__dma_sync_single_for_device(dev, dma_addr,
>> +						     NVME_CTRL_PAGE_SIZE,
>> +						     dma_dir);
>> +		length -= NVME_CTRL_PAGE_SIZE;
>> +	}
>> +}
> 
> Nothing should be using these __dma_sync helpers that are internal
> details. Using them means you call into sync code that should be skipped
> on most common server class systems.

Yeah, the kernel test robot already flagged it as well

> Also the for_cpu argument is a bit ugly.  I'd rather have separate
> routines as in the core dma-mapping code, even if that means a little bit
> of code duplication.
> 
>> +static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
>> +					     struct nvme_queue *nvmeq)
>> +{
>> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +	int length = blk_rq_payload_bytes(req);
>> +	u64 dma_addr, prp1_dma, prp2_dma;
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map;
>> +	dma_addr_t *dma_list;
>> +	dma_addr_t prp_dma;
>> +	__le64 *prp_list;
>> +	int i, map_idx;
>> +	int offset;
>> +
>> +	nvme_dmabuf_map_sync(nvmeq->dev, req, false);
>> +
>> +	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
>> +	dma_list = map->dma_list;
>> +
>> +	offset = bio->bi_iter.bi_bvec_done;
>> +	map_idx = offset / NVME_CTRL_PAGE_SIZE;
>> +	offset &= (NVME_CTRL_PAGE_SIZE - 1);
>> +	prp1_dma = dma_list[map_idx++] + offset;
> 
> Same comments as for the sync helper above.
> 
>> +	length -= (NVME_CTRL_PAGE_SIZE - offset);
>> +	if (length <= 0) {
>> +		prp2_dma = 0;
>> +		goto done;
>> +	}
>> +
>> +	if (length <= NVME_CTRL_PAGE_SIZE) {
>> +		prp2_dma = dma_list[map_idx];
>> +		goto done;
>> +	}
>> +
>> +	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
>> +	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
>> +		iod->flags |= IOD_SMALL_DESCRIPTOR;
>> +
>> +	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
>> +			&prp_dma);
>> +	if (!prp_list)
>> +		return BLK_STS_RESOURCE;
>> +
>> +	iod->descriptors[iod->nr_descriptors++] = prp_list;
>> +	prp2_dma = prp_dma;
> 
> And I really hate how this duplicates all the nasty PRP building logic,
> although right now I don't have a good answer to that.
> 
>> +static inline bool nvme_rq_is_dmabuf_attached(struct request *req)
>> +{
>> +	if (!IS_ENABLED(CONFIG_DMABUF_TOKEN))
>> +		return false;
>> +	return req->bio && bio_flagged(req->bio, BIO_DMABUF_MAP);
>> +}
> 
> This is something that should go into the block layer.

I'll move it

-- 
Pavel Begunkov

