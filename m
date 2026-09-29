Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6167C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 348BA10E11A;
	Tue, 29 Sep 2026 15:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZQ7yZe4f";
	dkim-atps=neutral
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr
 [80.12.242.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9099A10E11A
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 15:45:47 +0000 (UTC)
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
 by smtp.orange.fr with ESMTPSA
 id Ba1TxOXSTmvgMBa1UxXbFm; Tue, 29 Sep 2026 17:45:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1790696745;
 bh=XhYOalr3R26HFLIa9ZlXnwM+/1lAsc8W8oOx84qhODs=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=ZQ7yZe4f721D2FFc/wegR1sVUR+pLlDmZMoRecTHXd8wQBZoXNrn9rquk3Lpcs0TX
 OSNh11BInBxuyDtPwU3/8eQWumoL0+clSja6jhRbqaFRFcvOvbfcLkBauwN8rGhSR8
 3Pdsu1Wwjl8J+DuUJGbwh9M1FNXHY6uEqYBM28A1kEwewQ4iQpzYzwNwQ97WDUnzd4
 3pLYpncoI1nWhMB+7txXYzc/xsZvtxAD9mqFBGkWhMxi1+sEmoalrJItslM/tYGPM1
 TC8vHmVyOZk8Rx6B1bEjFYjnSLx+meQIGFU3m3ywEvrW5B+h/a+sZ6APgPPM0nbUxa
 xaY94xit9qA5A==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Sep 2026 17:45:45 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
Date: Tue, 29 Sep 2026 17:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: agk@redhat.com, akpm@linux-foundation.org, anuj20.g@samsung.com,
 axboe@kernel.dk, bmarzins@redhat.com, brauner@kernel.org,
 christian.koenig@amd.com, dm-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, hch@lst.de, io-uring@vger.kernel.org,
 jack@suse.cz, joshi.k@samsung.com, kbusch@kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
 matthew.brost@intel.com, mpatocka@redhat.com, nj.shetty@samsung.com,
 phil.cayton@intel.com, sagi@grimberg.me, snitzer@kernel.org,
 sumit.semwal@linaro.org, tushar.gohad@intel.com, viro@zeniv.linux.org.uk,
 william.power@intel.com
References: <cover.1790602223.git.asml.silence@gmail.com>
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 28/09/2026 à 15:32, Pavel Begunkov a écrit :
> Enable BIO_DMABUF_MAP backed requests. On registration we map the
> dma-buf and store it as a prp list, which is then used to initialise
> requests. All attached contexts are stored in a new list dmabuf_ctxs,
> and additions/removals are synchronised with dmabuf_lock.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Hi,

a few nitpick below, should it help.

> ---
>   drivers/nvme/host/core.c |  12 ++
>   drivers/nvme/host/nvme.h |   2 +
>   drivers/nvme/host/pci.c  | 308 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 322 insertions(+)
> 

[...]

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a953c0697f99..e58bdd9a4098 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -27,6 +27,8 @@
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/io-64-nonatomic-hi-lo.h>
>   #include <linux/sed-opal.h>
> +#include <linux/dma-buf-io.h>
> +#include <linux/dma-resv.h>

Move up, to keep better alphabetical order ?

>   
>   #include "trace.h"
>   #include "nvme.h"
> @@ -318,6 +320,8 @@ struct nvme_dev {
>   	bool hmb;
>   	struct sg_table *hmb_sgt;
>   	mempool_t *dmavec_mempool;
> +	struct list_head dmabuf_ctxs;
> +	struct mutex dmabuf_lock;
>   
>   	/* shadow doorbell buffer support: */
>   	__le32 *dbbuf_dbs;
> @@ -397,6 +401,13 @@ struct nvme_queue {
>   	struct completion delete_done;
>   };
>   
> +struct nvme_dmabuf_map {
> +	struct dma_buf_io_map base;
> +	struct sg_table *sgt;
> +	unsigned nr_entries;
> +	dma_addr_t dma_list[];

Add __counted_by(nr_entries) and update nvme_dma_buf_io_map() so that 
nr_entries is set at the right time ?

> +};
> +
>   /* bits for iod->flags */
>   enum nvme_iod_flags {
>   	/* this command has been aborted by the timeout handler */

...

> +static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx *ctx)
> +{
> +	unsigned nr_entries = ctx->dmabuf->size / NVME_CTRL_PAGE_SIZE;
> +	struct nvme_dma_buf_io_ctx *nvme_ctx = ctx->dev_priv;
> +	struct dma_buf_attachment *attach = nvme_ctx->attach;
> +	unsigned long tmp, i = 0;
> +	struct nvme_dmabuf_map *map;
> +	struct scatterlist *sg;
> +	struct sg_table *sgt;
> +	int ret;
> +
> +	dma_resv_assert_held(ctx->dmabuf->resv);
> +
> +	map = kvmalloc_flex(*map, dma_list, nr_entries);
> +	if (!map)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sgt = dma_buf_map_attachment(attach, ctx->dir);
> +	if (IS_ERR(sgt)) {
> +		ret = PTR_ERR(sgt);
> +		sgt = NULL;
> +		goto err;
> +	}
> +
> +	for_each_sgtable_dma_sg(sgt, sg, tmp) {
> +		dma_addr_t dma_addr = sg_dma_address(sg);
> +		unsigned long sg_len = sg_dma_len(sg);
> +
> +		if ((sg_len % NVME_CTRL_PAGE_SIZE) ||
> +		    (dma_addr % NVME_CTRL_PAGE_SIZE)) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		while (sg_len) {
> +			map->dma_list[i++] = dma_addr;
> +			dma_addr += NVME_CTRL_PAGE_SIZE;
> +			sg_len -= NVME_CTRL_PAGE_SIZE;
> +		}
> +	}
> +
> +	ret = dma_buf_io_init_map(ctx, &map->base, sgt);
> +	if (ret)
> +		goto err;
> +	map->nr_entries = nr_entries;
> +	map->sgt = sgt;
> +	return &map->base;
> +err:
> +	if (sgt)
> +		dma_buf_unmap_attachment(attach, sgt, ctx->dir);
> +	kfree(map);

kvfree()?

> +	return ERR_PTR(ret);
> +}
...

CJ
