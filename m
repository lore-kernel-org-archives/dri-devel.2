Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9388CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 19:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 939C310E280;
	Fri,  1 May 2026 19:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="GcoIXONH";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZHRcW/xX";
	dkim-atps=neutral
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3F710E280
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 19:12:41 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 215021D00085;
 Fri,  1 May 2026 15:12:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 01 May 2026 15:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1777662759;
 x=1777749159; bh=CyuI0WlfUye1AEo6nueVt3RVxpAH+P71icEP9FTaGcI=; b=
 GcoIXONH1GU8XpqtDPjm0MvuAIgxz9OFgccqq+0Uk2Bnkjg2HEkT2oYz4M3Nvupl
 k2PmcnbKn1PXpHKw8uVvMCQ+UiK5Jdvj9JLlZXHY4Di0Pu5zrT1JQVIXSNJm6OZO
 le9CeWVgkA5rRhAGcdXtF1t6VuGgiByF4215QKMerZq0875S329014pqxgT5nEkA
 FJpdU64+9DT2VKObLBizKH79RxMV9w8cENzfM7UAFDR3GmbUFvjlUnhJh64adbRw
 P7Y3t/uOMlpgnypkh3xqhpx7BaJuGufGMB5HAPQB/25p3bcVLl5X6MM9xmXFrYuq
 PAZUc5RgSjS6rCbym3S+fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777662759; x=
 1777749159; bh=CyuI0WlfUye1AEo6nueVt3RVxpAH+P71icEP9FTaGcI=; b=Z
 HRcW/xXtmeAkZLFh4ba+qw+fmB3SDu0pteliYvUO3whVaF+JFCGAnqC0th8AdeyD
 a4JXLREi2op4J2ruLhwaxiEbwSFsKvRpY4LzV8dh8JgzeLWNSQkApJa7ucUTKiNg
 moBCQMms/YgQz2Z/zIp/VZExyBtGln9093uOJBD5aZcy+DHiQtfjSJ4hhwxaa3xB
 w10Bo+NmCGOz+V0D1b8YF+Ybbcl4xra8LUT8+JGt2J293ksDmC+g2RfVMi6aWgwD
 AjpN7gRDwVO/QLhWh5GBDJIRFLCplBTFIXquS7udYYxNHcNXkPjIVYlLPTQkVfcN
 gHp665Il9S/9Xiozb0agQ==
X-ME-Sender: <xms:J_v0aXrTOYr3CssCoqGLcDyCK9F0jRzdhjAhcYObQGitQ_pEll_oig>
 <xme:J_v0aS9Y6Cwj02Q8v_2jbrKM63AO5ozzlkwRnkmJGcoR-ZOc1ft8F1963hFHhTXdj
 1Cq93Z7wbxyUHMFVL8CxYuxg3e5vqL_WXSZJr7bIArvnVJ824D6Ig>
X-ME-Received: <xmr:J_v0aY3KqoZfvp8BiBB6Bo41K8W0vdfGJim5mqYYIS2X_u1jhvmEgNLN2Yc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeluddtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
 ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
 htvghrnhepkeehjeeitefffeeuieetjedtjeffvdelledvuedvffdvfeetgefhveekuedv
 fedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdp
 nhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrg
 htthgvvhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhr
 ghdprhgtphhtthhopehjghhgsehnvhhiughirgdrtghomhdprhgtphhtthhopegrmhgrsh
 htrhhosehfsgdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdhkohgvnhhighes
 rghmugdrtghomhdprhgtphhtthhopehmnhhghigruggrmhesrghmrgiiohhnrdguvgdprh
 gtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghj
 ohhrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhumhhithdrshgvmhifrghlse
 hlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:J_v0admTanMNzoud-7lvTq3FrjB5BbRldFAGzV4udTFJQ-ycjSg7WQ>
 <xmx:J_v0ad2GZ6WPaEfSxJFx1M7kn-cKd8gnx61awOBwiFTPaj-Tma8XDQ>
 <xmx:J_v0aUjBZ4Ua9Z-oCX-yep9-mN3xurlrIygQVuGhWXeoTx5ajA5xVw>
 <xmx:J_v0aTU_8ndqtxKbdTx6a8HrZRDFmrleiY12wuT1UZy_ii1NIOJhMQ>
 <xmx:J_v0afx21FZdjyPsHBHFYQreUVAsfVYdOZPFmM60fQM2RPoihqNNGOHs>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 15:12:37 -0400 (EDT)
Date: Fri, 1 May 2026 13:12:36 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Mahmoud Adam <mngyadam@amazon.de>, David
 Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Pranjal
 Shrivastava <praan@google.com>, Alistair Popple <apopple@nvidia.com>, Vivek
 Kasireddy <vivek.kasireddy@intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <kvm@vger.kernel.org>, alex@shazbot.org,
 Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>
Subject: Re: [PATCH 1/9] vfio/pci: Fix vfio_pci_dma_buf_cleanup() double-put
Message-ID: <20260501131236.278ac431@shazbot.org>
In-Reply-To: <20260416131815.2729131-2-mattev@meta.com>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-2-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 16 Apr 2026 06:17:44 -0700
Matt Evans <mattev@meta.com> wrote:

> vfio_pci_dma_buf_cleanup() assumed all VFIO device DMABUFs need to be
> revoked.  However, if vfio_pci_dma_buf_move() revokes DMABUFs before
> the fd/device closes, then vfio_pci_dma_buf_cleanup() would do a
> second/underflowing kref_put() then wait_for_completion() on a
> completion that never fires.  Fixed by predicating on revocation
> status.
> 
> This could happen if PCI_COMMAND_MEMORY is cleared before closing the
> device fd (but the scenario is more likely to hit when future commits
> add more methods to revoke DMABUFs).
> 
> Fixes: 1a8a5227f2299 ("vfio: Wait for dma-buf invalidation to complete")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
> 
> (Just a fix, but later "vfio/pci: Convert BAR mmap() to use a DMABUF"
> and "vfio/pci: Permanently revoke a DMABUF on request" depend on this
> context, so including in this series.)

We really need a fix for this split out from this series, It's already
been shown[1] that this is trivially reachable.  Carlos proposed[2] a
similar solution to the one below.  I was concurrently working on the
issued and suggested an alternative[3].  Let's pick a solution for
7.1-rc.  Thanks,

Alex

[1]https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
[2]https://lore.kernel.org/all/20260429182736.409323-2-clopez@suse.de/
[3]https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/

 
> drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 281ba7d69567..04478b7415a0 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -395,20 +395,25 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>  
>  	down_write(&vdev->memory_lock);
>  	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
> +		bool was_revoked;
> +
>  		if (!get_file_active(&priv->dmabuf->file))
>  			continue;
>  
>  		dma_resv_lock(priv->dmabuf->resv, NULL);
>  		list_del_init(&priv->dmabufs_elm);
>  		priv->vdev = NULL;
> +		was_revoked = priv->revoked;
>  		priv->revoked = true;
>  		dma_buf_invalidate_mappings(priv->dmabuf);
>  		dma_resv_wait_timeout(priv->dmabuf->resv,
>  				      DMA_RESV_USAGE_BOOKKEEP, false,
>  				      MAX_SCHEDULE_TIMEOUT);
>  		dma_resv_unlock(priv->dmabuf->resv);
> -		kref_put(&priv->kref, vfio_pci_dma_buf_done);
> -		wait_for_completion(&priv->comp);
> +		if (!was_revoked) {
> +			kref_put(&priv->kref, vfio_pci_dma_buf_done);
> +			wait_for_completion(&priv->comp);
> +		}
>  		vfio_device_put_registration(&vdev->vdev);
>  		fput(priv->dmabuf->file);
>  	}

