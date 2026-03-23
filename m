Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0041F483D7
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E2510E048;
	Mon, 23 Mar 2026 17:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nTRqbWbv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8884A10E048
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774288437; x=1805824437;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=u5t1TFwBx8WnyaM63nFRG9/Qj/4xkp15sbmGC+zLfl0=;
 b=nTRqbWbvRopz0ERr0R/cRAgH5+pDMLV7XMUpEKjnAa+JI7gAOg4h+vLK
 WMv6zura+X4hOY3feBscGFn3BnEZTzQBZnxHearwDe05qvhIakVsHkpU5
 LrxYgFKPK7+CEoS9aWsvirltV5Bj5eHuYGTbKI4KvLNAknwD5+zHjlKx1
 gqcPRbDbUPCFX1MUG6Z9wlsWkA7zgGJePzFu+ZF8t43vRuHfZxqJM5L2k
 dhIow4D4aynHJ293pkHTKiv0XMXw1/sAoq0m9k2hB+cyTlrcf/uiEC2Qx
 m1BVca1Tk0bCFl85TIQ82/IB5dG+HU6wKgwKtrFouU6IBSkfIJ7Ss71Jb g==;
X-CSE-ConnectionGUID: VvwMFY2ARLu8tvmq8YzlIw==
X-CSE-MsgGUID: 07cGbKAXS4+SspmUzKf9kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79204115"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="79204115"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:53:56 -0700
X-CSE-ConnectionGUID: p6IxU8e8S+ewbuZwH3iokA==
X-CSE-MsgGUID: y148Gp61TrGXnNBOvHotKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="219243849"
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.94.253.106])
 ([10.94.253.106])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 10:53:54 -0700
Message-ID: <8735bc51-0774-49fd-bfe3-2c220f9f2f75@linux.intel.com>
Date: Mon, 23 Mar 2026 18:53:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Return ERR_PTR on dma_alloc_noncoherent
 failure
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 mario.limonciello@amd.com, maciej.falkowski@linux.intel.com
Cc: Wendy Liang <wendy.liang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com
References: <20260323173719.2311474-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260323173719.2311474-1-lizhi.hou@amd.com>
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

On 3/23/2026 6:37 PM, Lizhi Hou wrote:
> From: Wendy Liang <wendy.liang@amd.com>
> 
> dma_alloc_noncoherent() returns NULL on failure, but callers of
> aie2_alloc_msg_buffer() check for IS_ERR(). Return ERR_PTR(-ENOMEM)
> instead of NULL to match the amdxdna_iommu_alloc() path and the
> caller's error checking convention.
> 
> Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
> Signed-off-by: Wendy Liang <wendy.liang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/accel/amdxdna/aie2_message.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index 7e219a5eda56..a1c546c3e81c 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -56,6 +56,7 @@ void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
>  			    dma_addr_t *dma_addr)
>  {
>  	struct amdxdna_dev *xdna = ndev->xdna;
> +	void *vaddr;
>  	int order;
>  
>  	*size = max(*size, SZ_8K);
> @@ -67,8 +68,12 @@ void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
>  	if (amdxdna_iova_on(xdna))
>  		return amdxdna_iommu_alloc(xdna, *size, dma_addr);
>  
> -	return dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
> +	vaddr = dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
>  				      DMA_FROM_DEVICE, GFP_KERNEL);
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
>  }
>  
>  void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

