Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF71BCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D38A10EA9E;
	Mon, 28 Sep 2026 14:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ltDfkQMu";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB4610EAB9
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 14:41:31 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c2940ef15d3so383173566b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790606490; x=1791211290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gdKbC3riLBZ98r8oodQbbP8SrsBHoTyLl7tB6yhXYEA=;
 b=ltDfkQMuXhQ2aeD1MSGsGJEjGqut1mcyBNJNI3v4MsRPlgnHifXpcZqX6x/n1+umZO
 TzQGd1QaeX6iPDVOGMCCU/ktL6fEnQd7eojZ1+l7NubYTqvllMAPqevJ+yAusTCNnxmD
 tENJJmERGCt2bljL0KA3mXFahvoSXuIp2XCmqg+Yq7mSsoDFXWY4iRTmTSecT67Fkcs6
 p4uEsJK/t7R4kCFz99XUN6BthMoc5UmaZCBcPaQj7ZdDUIc8377+mBTrCdKqzC5cMKA6
 xetwk3ve5DIKnStfyt6BbSvpj6Xgqq0VwTILeEB+rE6J5s/WzMeL+Jme+NqHSs5HJ2GW
 J9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606490; x=1791211290;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gdKbC3riLBZ98r8oodQbbP8SrsBHoTyLl7tB6yhXYEA=;
 b=D8gDuzM2DrbJSZrDd+LAxOrDymCwJ31X1Q4H7yRrH9IxnOYZv0I/Gu7rWnBhepMwBc
 iu5NbOEpUaJw4Ox+DQHxpFbDgv4ttoV/m3ljHnfVxvk7Mcg95XXQXKE9tdMriEnPdzuf
 9S92/99p5h46kEVjHS//RYcNYwWuN+J+5aN+DmmdSOQUPFYXUbhL+TBYJ1YKbyNarzkT
 dWr5nlKsRdrFukKLFHfE+okidEH++c2EE9fqivL02g3ety+z/sQTebmlon2EsXCZ/jdk
 vmL49eGpheXvRxq+q9F3x6Z33N4rWOmMubvzN7l9PjlKBDu0C4BsPZ+D3+8HJqQTks9H
 50/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6tZiNCSg16Sg3G/0PvL3WCtidz1Vzcnx9fpGK4fogB5g471JWRIIb23Snk5zDfBNWnWclKlx06No=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l+fzUUDVGAnJCYsNe+w+1WuAubmX2XjwL5gUwWulDZL8J6ivAV
 L4uRN8fnogKTuO5BYqV+CMUa1WZwUOkN2vlzQ3qA76D/ozajg5XHq52W
X-Gm-Gg: AYBFou0mwFvhEUkjwoF8NLpyrW/UclxItsLObfdv6IauRUsxkPKT+QDvXElttyyKWwE
 cqkhs5wIPBcq4e2AejtMG7dXw6eHTRXkld9tpLnTSQuMa1eXVgau1ypzpfbmfHeh+TQhE/DLKpq
 PpwsjYH82h2ZrX4Mj523CxPWgMb29pnFXVepngEddhMtvk6OEgKtR0/W7nRwE9auxMn18taKK6A
 gTNx6bcuA4gRcpgbcBI9XtbsUPUJdgAkhjwoJAeoIbpXs2vER2wPNOb3movpjuWwjOim+zLf67F
 /gJwzGgyz3t0z2uGoYBefuDPVfpO7dtWW2alG98Q60E+1p+guvVq5bl0DGMu2O25z17OBAhsSc9
 W91deqEA41ycGF7WKNT7Q3slO1T2VEqsxkd73umIY8uUCfG5nV+967vvGLTtOBayMuaLX4IgsJQ
 65ZIBteHUhKYflLGx8S8c5eQR4a4JTJjI2Voso89KAYJoI6z2KOWGsBBanBAk/sFInJgjHXk2US
 vD0pPTjb9AZVc/CMIi/vFFlZGxwKp47mV0SsWly+TTKfth7vC4wECDQd8gjHVndVF+1qYsjxLwD
 iZc3Wf/iBjxgHCCTggxIVFlPrgueV1L+X67AzWMVO7zr8lYx
X-Received: by 2002:a17:907:7b8c:b0:c2d:c33d:a9d4 with SMTP id
 a640c23a62f3a-c2dc33dada2mr388838266b.10.1790606489807; 
 Mon, 28 Sep 2026 07:41:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c?
 ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2b769429ddsm355555066b.51.2026.09.28.07.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 07:41:29 -0700 (PDT)
Message-ID: <38f81e58-44ca-4fe6-ba72-97557b7625e9@gmail.com>
Date: Mon, 28 Sep 2026 15:41:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
To: sashiko-reviews@lists.linux.dev
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
References: <cover.1790602223.git.asml.silence@gmail.com>
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
 <20260928140208.0C56B1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260928140208.0C56B1F000FF@smtp.kernel.org>
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

On 9/28/26 15:02, sashiko-bot@kernel.org wrote:
...>> +	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
>> +
>> +	if (length <= 0) {
>> +		prp2_dma = 0;
>> +		goto done;
>> +	}
>> +
>> +	if (length <= NVME_CTRL_PAGE_SIZE) {
>> +		prp2_dma = dma_list[map_idx];
> 
> [Severity: Critical]
> Is map_idx checked against map->nr_entries here?
> 
> If dmabuf->size is 4608 bytes, nr_entries is truncated to 1, allocating 1

It'd be rejected, not truncated, see below.

> array element. Userspace could submit a 4608-byte IO. The driver calculates
> 'length' up to 4608 and advances 'map_idx' to 1 for the remaining 512 bytes.
> It reads 'dma_list[1]' (which is out-of-bounds) and uses it as 'prp2_dma',
> potentially resulting in arbitrary physical DMA (read or write).
> 
>> +		goto done;
>> +	}
> 
> [ ... ]
> 
>> +free_prps:
>> +	iod->cmd.common.dptr.prp1 = cpu_to_le64(prp1_dma);
>> +	iod->cmd.common.dptr.prp2 = cpu_to_le64(prp2_dma);
>> +	nvme_free_descriptors(req);
>> +	return BLK_STS_RESOURCE;
> 
> [Severity: High]
> Does this code leave iod->nr_descriptors greater than 0 on the error path?

I can clear it, but unless I missed sth that's what e.g.
nvme_pci_setup_data_prp() already does.

nvme_pci_setup_data_prp() // goto bad_sgl:
	nvme_unmap_data()
		nvme_free_descriptors();


> If dma_pool_alloc() fails in nvme_rq_setup_dmabuf_map(), it jumps to
> 'free_prps:', which calls nvme_free_descriptors() but leaves
> 'iod->nr_descriptors' unchanged. The block layer may requeue the failed
> request.
> 
> If the queue is subsequently torn down, the cancellation path invokes
> nvme_unmap_data() -> nvme_rq_clean_dmabuf_map(). Seeing the non-zero
> 'nr_descriptors', it calls nvme_free_descriptors() again, resulting in a
> double free.
> 
>> +}
> 
> [ ... ]
> 
>> +static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	unsigned nr_entries = ctx->dmabuf->size / NVME_CTRL_PAGE_SIZE;
>> +	struct nvme_dma_buf_io_ctx *nvme_ctx = ctx->dev_priv;
>> +	struct dma_buf_attachment *attach = nvme_ctx->attach;
>> +	unsigned long tmp, i = 0;
>> +	struct nvme_dmabuf_map *map;
>> +	struct scatterlist *sg;
>> +	struct sg_table *sgt;
>> +	int ret;
>> +
>> +	dma_resv_assert_held(ctx->dmabuf->resv);
>> +
>> +	map = kvmalloc_flex(*map, dma_list, nr_entries);
>> +	if (!map)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	sgt = dma_buf_map_attachment(attach, ctx->dir);
>> +	if (IS_ERR(sgt)) {
>> +		ret = PTR_ERR(sgt);
>> +		sgt = NULL;
>> +		goto err;
>> +	}
>> +
>> +	for_each_sgtable_dma_sg(sgt, sg, tmp) {
>> +		dma_addr_t dma_addr = sg_dma_address(sg);
>> +		unsigned long sg_len = sg_dma_len(sg);
>> +
>> +		if ((sg_len % NVME_CTRL_PAGE_SIZE) ||
>> +		    (dma_addr % NVME_CTRL_PAGE_SIZE)) {
>> +			ret = -EINVAL;
>> +			goto err;
>> +		}
>> +		while (sg_len) {
>> +			map->dma_list[i++] = dma_addr;
> 
> [Severity: High]
> Does this loop overflow dma_list[]?
> 
> 'nr_entries' is computed via integer division of dmabuf->size. If the dmabuf
> size is not page-aligned (e.g., 4097 bytes), nr_entries truncates down (to 1).

It'll fail on the alignment check in this loop for [4096, 4097)

> However, exporters often pad sg_table allocations to full pages (e.g., 8192
> bytes).
> 
> The loop unconditionally writes all sg_len chunks to 'dma_list', exceeding the
> allocated 'nr_entries' capacity.
> 
>> +			dma_addr += NVME_CTRL_PAGE_SIZE;
>> +			sg_len -= NVME_CTRL_PAGE_SIZE;
>> +		}
>> +	}
>> +
>> +	ret = dma_buf_io_init_map(ctx, &map->base, sgt);
>> +	if (ret)
>> +		goto err;
>> +	map->nr_entries = nr_entries;
>> +	map->sgt = sgt;
>> +	return &map->base;
>> +err:
>> +	if (sgt)
>> +		dma_buf_unmap_attachment(attach, sgt, ctx->dir);
>> +	kfree(map);
> 
> [Severity: High]
> Is it safe to free a kvmalloc_flex() allocation with kfree()?

Going to fix.

-- 
Pavel Begunkov

