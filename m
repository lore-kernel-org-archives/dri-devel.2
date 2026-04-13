Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EA7EBFD16
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D825E10E379;
	Mon, 13 Apr 2026 08:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eZAyKEiL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E1410E376;
 Mon, 13 Apr 2026 08:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776069111; x=1807605111;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ygX3QGpmpzQ4vDb35DrfpC80ywfwMhPNQFU2B1S833A=;
 b=eZAyKEiLNDAcCguLfo7h0TEfW001AB6mONoY+EKiN8Qu2mA9/GRvdJDc
 XOHmCyQwWNLpnjFgmT/s/JJdckUuQatpd0iX21BOR86bO5Zc603+PfIZz
 SUilkH9itz1tPCXEO6FDiDpzbpDL5orVT2K6sHXNC1lKt8stJpPr9/rL8
 dWF2BtlOvzYEbJJ3/Soj9+YW7fdWJdSt7uJVZabNitHYA5ZVkdEKJ24lp
 ZWaVdAkh3Di4NWr8VbJFTKIdcBiyuK7GMf+/5i8YufXNpLPgghwQ5zxuq
 N2XI2A/qRlaLciBhJ2BJyZ80NpvrCkiOB/L7xxjbiSOcou5lthtcsJnmc Q==;
X-CSE-ConnectionGUID: CaSBIIZrSPeqgdp25K6bOw==
X-CSE-MsgGUID: 9MSjyXp4S8eexQ51ovl6qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76907460"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="76907460"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 01:31:51 -0700
X-CSE-ConnectionGUID: kRnB8EohQb611Ginyevg6g==
X-CSE-MsgGUID: AiU4VxdXSISX/Yzv4b1gFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="233756454"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 01:31:47 -0700
Message-ID: <f4e2171a-da58-488f-be02-26a39b5afbe3@linux.intel.com>
Date: Mon, 13 Apr 2026 16:29:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/26] vfio/pci: Change the DMA-buf exporter to use
 mapping_type
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian Koenig <christian.koenig@amd.com>,
 Dongwon Kim <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <12-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <12-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
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

On 2/18/26 08:11, Jason Gunthorpe wrote:
> Simple conversion to add a match_mapping() callback that offers an
> exporter SGT mapping type. Later patches will add a physical address
> exporter so go straight to adding the match_mapping() function.
> 
> The check for attachment->peer2peer is replaced with setting
> exporter_requires_p2p=true. VFIO always uses MMIO memory.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/vfio/pci/vfio_pci_dmabuf.c | 31 +++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index d4d0f7d08c53e2..c7addef5794abf 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -25,9 +25,6 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>   {
>   	struct vfio_pci_dma_buf *priv = dmabuf->priv;
>   
> -	if (!attachment->peer2peer)
> -		return -EOPNOTSUPP;
> -
>   	if (priv->revoked)
>   		return -ENODEV;
>   
> @@ -75,11 +72,35 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>   	kfree(priv);
>   }
>   
> -static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
> -	.attach = vfio_pci_dma_buf_attach,
> +static const struct dma_buf_mapping_sgt_exp_ops vfio_pci_dma_buf_sgt_ops = {
>   	.map_dma_buf = vfio_pci_dma_buf_map,
>   	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
> +};
> +
> +static int vfio_pci_dma_buf_match_mapping(struct dma_buf_match_args *args)
> +{
> +	struct vfio_pci_dma_buf *priv = args->dmabuf->priv;
> +	struct dma_buf_mapping_match sgt_match[1];
> +
> +	dma_resv_assert_held(priv->dmabuf->resv);

My understanding of this lock assertion is that priv and the underlying
priv->vdev are accessed within this function. Therefore, the lock is
necessary to protect them. Do I understand it right?

However, callers - for example, dma_buf_mapping_attach() - do not
acquire dma_resv_lock() before calling this function. So kernel traces
will always be triggered.

> +
> +	/*
> +	 * Once we pass vfio_pci_dma_buf_cleanup() the dmabuf will never be
> +	 * usable again.
> +	 */
> +	if (!priv->vdev)
> +		return -ENODEV;
> +
> +	sgt_match[0] = DMA_BUF_EMAPPING_SGT_P2P(&vfio_pci_dma_buf_sgt_ops,
> +						priv->vdev->pdev);
> +
> +	return dma_buf_match_mapping(args, sgt_match, ARRAY_SIZE(sgt_match));
> +}
> +
> +static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
> +	.attach = vfio_pci_dma_buf_attach,
>   	.release = vfio_pci_dma_buf_release,
> +	.match_mapping = vfio_pci_dma_buf_match_mapping,
>   };
>   
>   /*

Thanks,
baolu
