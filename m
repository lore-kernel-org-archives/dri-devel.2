Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B9F10A62CC
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82FBB10E97A;
	Thu, 26 Mar 2026 13:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="UeOYGNcg";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1001E10E626
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 23:51:52 +0000 (UTC)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OLWXah1320219
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:51:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=B4WuddQzak0iMs+x+SFLQE/xEKY5OBiF+Wu5h4lGL3o=; b=UeOYGNcgp3H5
 TduUlpqGXTYgT2Q9D/GPNOXzh9XnVHI8ldO3rbkDsSieTaencdeWe3FEzmmQFLo9
 yQUVfQDqtlZHleg/lJFvwS2mA5wl0gAPpIwLFuR+PXtoxXqWT8gYFJKu+mf2Xy4Q
 g2zpRB1AbAWFsikg1g4GJklKIsw0oMdms3A/+QgYl7GUTOSaqa6WHAe17JesKs9e
 dzuZH8e8Il6fRFaEvXK231nTHShFGD/ba5KWCF36ReRxufwl8FC+zo9ke9KPpNZu
 kqWAZ8s0mYg7rb3+pNOB8XsqnZIDtjwfzLge2BusvK0lgDmunLf4Pl1NrgxYf380
 L1CwELs+Vg==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d42mbhct2-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:51:51 -0700 (PDT)
Received: from twshared25002.15.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Mar 2026 23:51:46 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 8DA221D7CF55; Tue, 24 Mar 2026 16:46:26 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Date: Tue, 24 Mar 2026 16:46:02 -0700
Message-ID: <20260324234615.3731237-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324234615.3731237-1-zhipingz@meta.com>
References: <20260324234615.3731237-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE4NCBTYWx0ZWRfX3WUXXCSuOFeB
 sVWpFXgWONX8LceWOEU8wOpRHgcsp1kZjB3AsIonxyAZwLgKFezhsDGFf/uKMfuxrSOcc3adoT0
 7DU56URRlkWoyXXYJNeehClkMpz7OPTujFm0+vp8X5Slc1TLlBBywYyFgrWiWhZntM3J14D06X3
 swUkmrIovnMvrYwu1n1OI7ClKnqaYMEfZj5jxEhBQuhps4aXDBEt21c4URAdUH3ys+IO5DBkFf0
 jcpF36iqzpGhQ4f1tWRe265iac7of6ex9nnBfvogxndOgVUjMS+E1hAKJoiIorz5ARR1F5ORmbb
 O9MKF2QTDLTE4Zsa5K7Qlqnbg/1fNIE1c4cl2zlMcGajplNxNgBuBBsFZRhTTk5WqhMd5K09hFl
 VIRT29yCxneaiXC1DXorWAsMDJvuXVsBX5OlTsf1i71qAwO4Wp2Hmun2mT9cBQXSA58sT5wZZ3Y
 0MpdYwSfrJbtr4xM3/Q==
X-Proofpoint-GUID: zbr107TwwAsv20N6x7ZfQHaLE9dH32TO
X-Proofpoint-ORIG-GUID: zbr107TwwAsv20N6x7ZfQHaLE9dH32TO
X-Authority-Analysis: v=2.4 cv=FNwWBuos c=1 sm=1 tr=0 ts=69c32397 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8 a=9vb4j_dHmgPK81v2NVsA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 26 Mar 2026 13:17:48 +0000
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

This patch adds a callback to get the tph info on DMA buffer exporters.
The tph info includes both the steering tag and the process hint (ph).

The steering tag and ph are encoded in the flags field of
vfio_device_feature_dma_buf instead of adding new fields to the uapi
struct, to preserve ABI compatibility.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 26 ++++++++++++++++++++++++--
 include/linux/dma-buf.h            | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h          |  9 +++++++--
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
index 478beafc6ac3..c45cb3884b85 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -17,6 +17,8 @@ struct vfio_pci_dma_buf {
 	struct phys_vec *phys_vec;
 	struct p2pdma_provider *provider;
 	u32 nr_ranges;
+	u16 steering_tag;
+	u8 ph;
 	u8 revoked : 1;
 };

@@ -60,6 +62,15 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 				       priv->size, dir);
 }

+static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steerin=
g_tag,
+				    u8 *ph)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+	*steering_tag =3D priv->steering_tag;
+	*ph =3D priv->ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment=
,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -90,6 +101,7 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D=
 {
 	.unpin =3D vfio_pci_dma_buf_unpin,
 	.attach =3D vfio_pci_dma_buf_attach,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
+	.get_tph =3D vfio_pci_dma_buf_get_tph,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
 };
@@ -228,7 +240,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
 	if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
 		return -EFAULT;

-	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
+	if (!get_dma_buf.nr_ranges ||
+	    (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
+				   VFIO_DMABUF_TPH_PH_MASK |
+				   VFIO_DMABUF_TPH_ST_MASK)))
 		return -EINVAL;

 	/*
@@ -285,7 +300,14 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
 		ret =3D PTR_ERR(priv->dmabuf);
 		goto err_dev_put;
 	}
-
+	if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
+		priv->steering_tag =3D (get_dma_buf.flags &
+				      VFIO_DMABUF_TPH_ST_MASK) >>
+				     VFIO_DMABUF_TPH_ST_SHIFT;
+		priv->ph =3D (get_dma_buf.flags &
+			    VFIO_DMABUF_TPH_PH_MASK) >>
+			   VFIO_DMABUF_TPH_PH_SHIFT;
+	}
 	/* dma_buf_put() now frees priv */
 	INIT_LIST_HEAD(&priv->dmabufs_elm);
 	down_write(&vdev->memory_lock);
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 133b9e637b55..26705c83ad80 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,36 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);

+	/**
+	 * @get_tph:
+	 *
+	 * Get the TPH (TLP Processing Hints) for this DMA buffer.
+	 *
+	 * This callback allows DMA buffer exporters to provide TPH including
+	 * both the steering tag and the process hints (ph), which can be used
+	 * to optimize peer-to-peer (P2P) memory access. The TPH info is typica=
lly
+	 * used in scenarios where:
+	 * - A PCIe device (e.g., RDMA NIC) needs to access memory on another
+	 *   PCIe device (e.g., GPU),
+	 * - The system supports TPH and can use steering tags / ph to optimize
+	 *   cache placement and memory access patterns,
+	 * - The memory is exported via DMABUF for cross-device sharing.
+	 *
+	 * @dmabuf: [in] The DMA buffer for which to retrieve TPH
+	 * @steering_tag: [out] Pointer to store the 16-bit TPH steering tag va=
lue
+	 * @ph: [out] Pointer to store the 8-bit TPH processing-hint value
+	 *
+	 * Returns:
+	 * * 0 - Success, steering tag stored in @steering_tag
+	 * * -EOPNOTSUPP - TPH steering tags not supported for this buffer
+	 * * -EINVAL - Invalid parameters
+	 *
+	 * This callback is optional. If not implemented, the buffer does not
+	 * support TPH.
+	 *
+	 */
+	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index bb7b89330d35..e2a8962641d2 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1505,8 +1505,13 @@ struct vfio_region_dma_range {
 struct vfio_device_feature_dma_buf {
 	__u32	region_index;
 	__u32	open_flags;
-	__u32   flags;
-	__u32   nr_ranges;
+	__u32	flags;
+#define VFIO_DMABUF_FL_TPH		(1U << 0) /* TPH info is present */
+#define VFIO_DMABUF_TPH_PH_SHIFT	1         /* bits 1-2: PH (2-bit) */
+#define VFIO_DMABUF_TPH_PH_MASK	0x6U
+#define VFIO_DMABUF_TPH_ST_SHIFT	16        /* bits 16-31: steering tag *=
/
+#define VFIO_DMABUF_TPH_ST_MASK		0xffff0000U
+	__u32	nr_ranges;
 	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
 };

--
2.52.0

