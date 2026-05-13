Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA5CCD343F
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 01:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D675010E2D0;
	Wed, 13 May 2026 01:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="imxPtnhJ";
	dkim-atps=neutral
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B48510E2D0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 01:49:28 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=1QPd0/wQRL2rpFFHXggBsfXQ3q5bbcdXUBEQwFMmobY=;
 b=imxPtnhJl4i9km34mrSU/FVG1amcCI38T36mo7t9LLstpZydxhK7KB1glydHi/bBXzTxSAAue
 3/hqS6kWUqZmevDluMwfuIwdaAJ9hxBbKMwjwREu3LjCo414BQRw5ANwONpfB5FdMHRJt14nnNP
 gb/22009IDDfzp/PuEt2YL0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gFbm96x0BzmV9L;
 Wed, 13 May 2026 09:41:45 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0BE44402AB;
 Wed, 13 May 2026 09:49:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 09:49:23 +0800
Message-ID: <d5b26695-f1fd-4cb6-8e19-201f689eceaf@huawei.com>
Date: Wed, 13 May 2026 09:49:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>
References: <20260512184755.4137227-1-zhipingz@meta.com>
 <20260512184755.4137227-3-zhipingz@meta.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260512184755.4137227-3-zhipingz@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> peer access and translate the raw steering tag into an mlx5 steering
> tag index. Factor mlx5_st_alloc_index() so callers that already have a
> raw steering tag can allocate the corresponding mlx5 index directly.
> Keep the DMAH path as the first priority and only fall back to dma-buf
> metadata when no DMAH is supplied.
> 
> Add pcie_tph_get_st_width() so the mlx5 IB driver can query the
> device's negotiated ST width without poking pci_dev::tph_req_type
> directly (that field is gated by CONFIG_PCIE_TPH and would otherwise
> break !CONFIG_PCIE_TPH builds). Pass the width to the dma-buf
> get_tph() callback so the exporter can return the value that matches
> the consumer's capability.

1\ Recommend the PCI/TPH modification be committed separately.
2\ How about rename it to pcie_tph_enabled_req_type() ? so we could
   use already defined macro:
#define   PCI_TPH_REQ_DISABLE		0x0 /* No TPH requests allowed */
#define   PCI_TPH_REQ_TPH_ONLY		0x1 /* TPH only requests allowed */
#define   PCI_TPH_REQ_EXT_TPH		0x3 /* Extended TPH requests allowed */

> 
> Pass the dma_buf pointer that the umem already resolved into
> get_tph_mr_dmabuf() instead of re-resolving the user-supplied fd.
> Re-resolving opens a TOCTOU where a concurrent dup2() can substitute a
> different dma_buf between umem creation and TPH lookup.
> 
> Track the per-MR ownership of the allocated mlx5 ST index on
> mlx5_ib_mr (dmabuf_st_index / dmabuf_st_owned) and release it once the
> firmware mkey no longer references it. Both the cached path
> (mlx5r_umr_revoke_mr_with_lock + ib_frmr_pool_push) and the
> destroy_mkey path call mlx5_ib_mr_put_dmabuf_st() so the ST index does
> not leak when the MR is reused from the FRMR pool.
> 
> Initialize ret in mlx5_st_create() so the cached steering-tag path
> returns success cleanly under clang builds.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
>  drivers/infiniband/hw/mlx5/mr.c               | 72 ++++++++++++++++++-
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 27 ++++---
>  drivers/pci/tph.c                             | 20 ++++++
>  include/linux/mlx5/driver.h                   |  7 ++
>  include/linux/pci-tph.h                       |  2 +
>  6 files changed, 124 insertions(+), 10 deletions(-)
> 

...
