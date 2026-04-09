Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E42EA3C4E
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52B910E7D2;
	Thu,  9 Apr 2026 12:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZfPMl7+i";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E2110E7D3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 12:04:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0346660103;
 Thu,  9 Apr 2026 12:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA7BC2BC9E;
 Thu,  9 Apr 2026 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775736262;
 bh=G/ay3tEaFHjwK7ia51ZNouAZfQhcoggXMm0N8BsIcwU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZfPMl7+iL3vOhEXSU+Aq9hVIsplbGHKLlwtR/ABoHcMLvMGWw0874KFC9D5E9LSys
 lsLrOwbum6ynlKAR+KkIWnePLFrG5xO8yJ6I7eP/AoeNKOz/K3QKxQ5vZTOuejmY+2
 yKCk4Jl52X4QD4S+WPKCWyWqZUlemWl8/oQRfeqG6feHLK11KB+WCZbhzfHM9zUtbJ
 OLRm8NsBrliLji9tDVcMftFeGU06pb63Uemi5Jk2/OGN7PjdzwNZjF9FsSpvwjXasG
 hOo3pBbjX4oP/wvBvGCOQgPR6+Tu1s1xeAepm7KHx3adpZ6uoOk9VdGQ7BLSDGlUku
 QSQ4xu30TdMew==
Date: Thu, 9 Apr 2026 15:04:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260409120415.GF86584@unreal>
References: <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal> <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal> <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal> <acvWplw67b3Gwlkc@kbusch-mbp>
 <20260331190220.GI814676@unreal> <acwkAo2k41xaxdTS@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acwkAo2k41xaxdTS@kbusch-mbp>
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

On Tue, Mar 31, 2026 at 01:44:02PM -0600, Keith Busch wrote:
> On Tue, Mar 31, 2026 at 10:02:20PM +0300, Leon Romanovsky wrote:
> > 
> > Right, what about adding TPH fields to struct vfio_region_dma_range
> > instead of struct vfio_device_feature_dma_buf?
> 
> You might have to show me with code what you're talking about because I
> can't see any way we can add fields to any struct here without breaking
> backward compatibility.
> 
> If we can't claim bits out of the unused "flags" field for this feature,
> then my initial reply is the only sane approach: we can introduce a new
> feature and struct for it that closely mirrors the existing one, but
> with the extra hint fields.

Something like that, on top of this proposal:

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 3961afa640391..70d5ee1e3ef7b 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -241,9 +241,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 		return -EFAULT;
 
 	if (!get_dma_buf.nr_ranges ||
-	    (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
-				   VFIO_DMABUF_TPH_PH_MASK |
-				   VFIO_DMABUF_TPH_ST_MASK)))
+	    (get_dma_buf.flags & ~VFIO_DMABUF_FLAG_TPH))
 		return -EINVAL;
 
 	/*
@@ -300,13 +298,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 		ret = PTR_ERR(priv->dmabuf);
 		goto err_dev_put;
 	}
-	if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
-		priv->steering_tag = (get_dma_buf.flags &
-				      VFIO_DMABUF_TPH_ST_MASK) >>
-				     VFIO_DMABUF_TPH_ST_SHIFT;
-		priv->ph = (get_dma_buf.flags &
-			    VFIO_DMABUF_TPH_PH_MASK) >>
-			   VFIO_DMABUF_TPH_PH_SHIFT;
+	if (get_dma_buf.flags & VFIO_DMABUF_FLAG_TPH) {
+		priv->steering_tag =
+			dma_ranges[get_dma_buf.nr_ranges + 1].tph.tag;
+		priv->ph = dma_ranges[get_dma_buf.nr_ranges + 1].tph.ph;
 	}
 	/* dma_buf_put() now frees priv */
 	INIT_LIST_HEAD(&priv->dmabufs_elm);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e2a8962641d2c..a8b8d8b1a3278 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1497,20 +1497,30 @@ struct vfio_device_feature_bus_master {
  */
 #define VFIO_DEVICE_FEATURE_DMA_BUF 11
 
+struct vfio_region_dma_tph {
+	u16 tag;
+	u8 ph;
+};
+
 struct vfio_region_dma_range {
-	__u64 offset;
-	__u64 length;
+	union {
+		__u64 offset;
+		struct vfio_region_dma_tph tph;
+	};
+	union {
+		__u64 length;
+		__u64 reserved;
+	};
+};
+
+enum {
+	VFIO_DMABUF_FLAG_TPH = 1 << 0,
 };
 
 struct vfio_device_feature_dma_buf {
 	__u32	region_index;
 	__u32	open_flags;
 	__u32	flags;
-#define VFIO_DMABUF_FL_TPH		(1U << 0) /* TPH info is present */
-#define VFIO_DMABUF_TPH_PH_SHIFT	1         /* bits 1-2: PH (2-bit) */
-#define VFIO_DMABUF_TPH_PH_MASK	0x6U
-#define VFIO_DMABUF_TPH_ST_SHIFT	16        /* bits 16-31: steering tag */
-#define VFIO_DMABUF_TPH_ST_MASK		0xffff0000U
 	__u32	nr_ranges;
 	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
 };
