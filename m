Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5886FF483D7
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22B310E16A;
	Mon, 23 Mar 2026 17:56:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dqr/AgRT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE2110E16A
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:56:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DFC6160103;
 Mon, 23 Mar 2026 17:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6E9C4CEF7;
 Mon, 23 Mar 2026 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774288581;
 bh=bQ9gS4dZs5k5v646yeU2BSLbqiSWZITsVgQ8bfbSq4Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dqr/AgRTk5rGZXvGocbcSOySMZd1pKmvaVn8sLTWrDh3myt3anGRX5+0sVSiO1jdY
 97ffcZCmv1MVHN21sQuTdgJUvbcZW0zscy3WAc+lr77NxHPazRhtn+LHpoUPiQibbN
 Rq8KdfwnnPs/ERblaUDc8jwcrc2VQJ81UU0geJQqHINAUAmL7wv70CXgAJvU1xuU1J
 X/jPAKDdaZTW+gC1ilmaEfuB8bUtx7yCkAKdB8/NG3laVdbWU7CzeKRE5E5iN+L2cc
 GGRoevQrtWbsUMdjjMg5k3zVFas1nn469edLuKHjHRS+DA0QY+vLJRkE8JmltLSTQc
 SYAQR6sXwwAUQ==
Message-ID: <8d2f44e4-46fd-471f-91a2-5f76b128761f@kernel.org>
Date: Mon, 23 Mar 2026 12:56:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Return ERR_PTR on dma_alloc_noncoherent
 failure
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Wendy Liang <wendy.liang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com
References: <20260323173719.2311474-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260323173719.2311474-1-lizhi.hou@amd.com>
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



On 3/23/2026 12:37 PM, Lizhi Hou wrote:
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
>   drivers/accel/amdxdna/aie2_message.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index 7e219a5eda56..a1c546c3e81c 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -56,6 +56,7 @@ void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
>   			    dma_addr_t *dma_addr)
>   {
>   	struct amdxdna_dev *xdna = ndev->xdna;
> +	void *vaddr;
>   	int order;
>   
>   	*size = max(*size, SZ_8K);
> @@ -67,8 +68,12 @@ void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl *ndev, u32 *size,
>   	if (amdxdna_iova_on(xdna))
>   		return amdxdna_iommu_alloc(xdna, *size, dma_addr);
>   
> -	return dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
> +	vaddr = dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
>   				      DMA_FROM_DEVICE, GFP_KERNEL);
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
>   }
>   
>   void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
