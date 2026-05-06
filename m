Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC6DCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 07:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595C310E3F6;
	Wed,  6 May 2026 07:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="Ew/DB68b";
	dkim-atps=neutral
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14E210E3F6
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 07:04:28 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=I4AmL4fvNpHMSVvocXatLftD8fJJA1bCgo9cY2QiSIw=;
 b=Ew/DB68bHUrSMhBn5/hMtVsMFKu006BxiMFiG/N/kYcaJph0xKfstdQz6yH8GMWVGNimnU5P+
 9jpxClX/XwWL12MleUz9H09yjPafzKAzBbYjrVhyN686xOBytdxGOZ9Ry4uzdkFlyqWw9a9tt5z
 nQPJxUjeIBbD/1b5iR8YL0s=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g9R693VDZzKm5S;
 Wed,  6 May 2026 14:57:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 79D764055B;
 Wed,  6 May 2026 15:04:26 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 15:04:25 +0800
Message-ID: <a63179d7-28b1-4269-9ef2-c20368d0b91c@huawei.com>
Date: Wed, 6 May 2026 15:04:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
References: <20260430200704.352228-1-zhipingz@meta.com>
 <20260430200704.352228-3-zhipingz@meta.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260430200704.352228-3-zhipingz@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
> Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> peer access and translate the raw steering tag into an mlx5 steering tag
> index. Factor mlx5_st_alloc_index() so callers that already have a raw
> steering tag can allocate the corresponding mlx5 index directly. Keep the
> DMAH path as the first priority and only fall back to dma-buf metadata when
> no DMAH is supplied.
> 
> Pass the device's supported ST width (8 or 16 bit, derived from
> pdev->tph_req_type) to get_tph() so the exporter can reject tags that
> exceed the consumer's capability. Initialize ret in mlx5_st_create() so the
> cached steering-tag path returns success cleanly under clang builds.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> 
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -46,6 +46,8 @@
>  #include "data_direct.h"
>  #include "dmah.h"
>  
> +MODULE_IMPORT_NS("DMA_BUF");
> +
>  static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
>  {
>  	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> @@ -899,6 +901,40 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_attach_ops = {
>  	.invalidate_mappings = mlx5_ib_dmabuf_invalidate_cb,
>  };
>  
> +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st_index,
> +			      u8 *ph)
> +{
> +	struct pci_dev *pdev = dev->mdev->pdev;
> +	struct dma_buf *dmabuf;
> +	u16 steering_tag;
> +	u8 st_width;
> +	int ret;
> +
> +	st_width = (pdev->tph_req_type == PCI_TPH_REQ_EXT_TPH) ? 16 : 8;

The tph_req_type is defined under CONFIG_PCIE_TPH, how about add a wrap function
to query it.

> +
> +	dmabuf = dma_buf_get(fd);
> +	if (IS_ERR(dmabuf))
> +		return;
> +
> +	if (!dmabuf->ops->get_tph)
> +		goto end_dbuf_put;
> +
> +	ret = dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
> +	if (ret) {
> +		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
> +		goto end_dbuf_put;
> +	}
> +
> +	ret = mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_index);
> +	if (ret) {
> +		*ph = MLX5_IB_NO_PH;
> +		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
> +	}
> +
> +end_dbuf_put:
> +	dma_buf_put(dmabuf);
> +}
> +
>  static struct ib_mr *
>  reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
>  		   u64 offset, u64 length, u64 virt_addr,
> @@ -941,6 +977,8 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
>  		ph = dmah->ph;
>  		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
>  			st_index = mdmah->st_index;
> +	} else {
> +		get_tph_mr_dmabuf(dev, fd, &st_index, &ph);
>  	}
>  
>  	mr = alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> @@ -29,7 +29,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *dev)
>  	u8 direct_mode = 0;
>  	u16 num_entries;
>  	u32 tbl_loc;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
>  		return NULL;
> @@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
>  	kfree(st);
>  }
>  
> -int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
> -			unsigned int cpu_uid, u16 *st_index)
> +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> +			       u16 *st_index)
>  {
>  	struct mlx5_st_idx_data *idx_data;
>  	struct mlx5_st *st = dev->st;
>  	unsigned long index;
>  	u32 xa_id;
> -	u16 tag;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!st)
>  		return -EOPNOTSUPP;
>  
> -	ret = pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> -	if (ret)
> -		return ret;
> -
>  	if (st->direct_mode) {
>  		*st_index = tag;
>  		return 0;
> @@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
>  	mutex_unlock(&st->lock);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
> +
> +int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
> +			unsigned int cpu_uid, u16 *st_index)
> +{
> +	u16 tag;
> +	int ret;
> +
> +	ret = pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> +	if (ret)
> +		return ret;
> +
> +	return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
> +}
>  EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
>  
>  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -1166,10 +1166,17 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type
>  			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
>  
>  #ifdef CONFIG_PCIE_TPH
> +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> +			       u16 *st_index);
>  int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
>  			unsigned int cpu_uid, u16 *st_index);
>  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index);
>  #else
> +static inline int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev,
> +					     u16 tag, u16 *st_index)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
>  				      enum tph_mem_type mem_type,
>  				      unsigned int cpu_uid, u16 *st_index)
> 
> 

