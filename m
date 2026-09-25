Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F42BC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D099810E214;
	Fri, 25 Sep 2026 11:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MdRhzimy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD8310E7CE
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790336607; x=1821872607;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xSCzSQa9vpv7fTrpe4D6eJEWhOskC3i34wNAy1rzkek=;
 b=MdRhzimyRrXokFdFk9n+prxn1v8X66bR73kXThYSijcVyGkQnPbOdKYh
 iY+Fn9zTRmDNUUCBW1dFqX2/MYMVqVsRtWq8J7FdbrB/Wocvmb+XPaAHE
 XZ66QALMNPct+awVp7p6y92FE9JhA4UZUsBWMYhoQvF9jYibHjqnjvBkf
 Q6u2aw+UgN9siLKJ76GRmM9Ok1bf4sbqoF8KAbeM/OxQJJFlxEye3O6Ez
 /Ppp4XyzFC8j9gHYNBv1fewxlbFs3/B12MXmcJwwlyptKW6SGgJpgZR6B
 WsGVOa+sAoYTbK8aIo8I6bAKeiEiXN/PRUWgDvIgaSo82+aYTCnoj9vtG w==;
X-CSE-ConnectionGUID: nuFNTCBaT5yZI1wPQ474JA==
X-CSE-MsgGUID: 9FfQfa2ZQS2Te5ZnBV4zWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="93839870"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="93839870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 04:43:22 -0700
X-CSE-ConnectionGUID: /daeCRXrS4WRpBjCCG+/fw==
X-CSE-MsgGUID: rpOFlsItSKaRR05dJQ3aaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="312238006"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [10.102.89.94])
 ([10.102.89.94])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 04:43:16 -0700
Message-ID: <edc255b9-4537-4542-bfa8-6f004bcbe6b7@linux.intel.com>
Date: Fri, 25 Sep 2026 13:43:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Fix IOVA offset when linking phys vecs to sgt
To: Yili Zhang <zhangyili01@baidu.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260924065508.27245-1-zhangyili01@baidu.com>
Content-Language: en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260924065508.27245-1-zhangyili01@baidu.com>
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

On 2026-09-24 8:55 AM, Yili Zhang wrote:
> The dma_buf_phys_vec_to_sgt() routine links every physical range into
> the allocated IOVA space at offset zero instead of advancing the offset
> by the already mapped length. This breaks the THRU_HOST_BRIDGE flow
> whenever phys_vec contains more than one entry: the second and
> subsequent dma_iova_link() calls try to install mappings on top of
> PTEs that already exist, which fails and makes the whole conversion
> return an error.
> 
> Fix it by passing the accumulated mapped_len as the IOVA offset. This
> matches the pattern used by all other dma_iova_link() callers and is
> consistent with the rest of the function: dma_iova_sync() and the
> error path in dma_iova_destroy() both operate on the [0, mapped_len)
> prefix of the IOVA space, which assumes that the ranges were linked
> contiguously starting at offset 0.
> 
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> ---
>   drivers/dma-buf/dma-buf-mapping.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
> index 833be519e1e6..ef0f22854d01 100644
> --- a/drivers/dma-buf/dma-buf-mapping.c
> +++ b/drivers/dma-buf/dma-buf-mapping.c
> @@ -156,7 +156,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
>   						       phys_vec[i].paddr);
>   		} else if (dma_use_iova(dma->state)) {
>   			ret = dma_iova_link(attach->dev, dma->state,
> -					    phys_vec[i].paddr, 0,
> +					    phys_vec[i].paddr, mapped_len,
>   					    phys_vec[i].len, dir,
>   					    DMA_ATTR_MMIO);
>   			if (ret)

