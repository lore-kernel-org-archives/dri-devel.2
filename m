Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744CECD13DA
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D104110F44F;
	Thu, 30 Apr 2026 20:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="LPX2prnm";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF57D10F44F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 20:11:31 +0000 (UTC)
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UDBBO1518622
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=+CctzKmPD0mZYNaUqqbHQ9y/m7DXh0Zn+N73X9LhqfM=; b=LPX2prnm7kxp
 sIUSSBr8vUmzakv5GIA35ijPUajL0sKIpyMQ4PoTOjGkjbD1YTraAKUYHR9Ak4QJ
 kSdHd1hzQRl3NvJ8yF7+ZFZc1wod9xeyoZ+DA4uPKkYXT3DkpIfkz4gwJQBi2h1M
 fWQzHcjEC+LQZScAO2372RTrJyb09azlMcPE2g1UuXIGh806pxdtvoMbl6CKbS90
 NCwU3Umy+mdrQAkHrgu6/+/8BhQ+9D1JVW/4l+DJ4Ssn+RMMWYYNplputHuvISQ+
 QdkbFezdlY+SP+IioU6KUtyhT577zdO/5LGtHBxkriel60LP24iY6508GSiqmcpO
 eD7dCFVakQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dsf6p8rjn-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:11:30 -0700 (PDT)
Received: from twshared6963.04.snb3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 30 Apr 2026 20:11:26 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 843451B9B4FD1; Thu, 30 Apr 2026 13:07:06 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Zhiping Zhang
 <zhipingz@meta.com>
Subject: [PATCH v2 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
Date: Thu, 30 Apr 2026 13:06:57 -0700
Message-ID: <20260430200704.352228-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430200704.352228-1-zhipingz@meta.com>
References: <20260430200704.352228-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIwOCBTYWx0ZWRfX6078Tkx/9NEq
 y6tohbQKNn+XYQjSs/52T9iMJXWlZ3ljH5LViKAQjcREPf2jgFFMmBhBzdk3oMyCfMOVPUzNTg2
 JCVfgbJNUxIqtkr79t2QLlMBrIuQZg7AledOGg0I/UyzuMuMKsAUmqHtyxjfaS5X/FdatwP3ZNJ
 Zb5JMVIVi1yb1ZwyUZtI7qTxhAL+yk9S2K+xFClpYjo0zvdMqeIQoMMAYWLz+3XRf/ecqCtZKSi
 tlJmhv6s+itmp5XcxK8uVLjnjG3KCYYo35lq5QjtFxtY2tLF67R6Yl5C6ciNa6Oq5TAEJCBdL7t
 ZMCcHtN5hyUEOeh4B8wdu65GU1Q7eb6aF9FjAvAV628dKKoLKqe2bq94Ne9qwx14SjJxq/zCQCX
 vGtRNoPgI2xIhO8rInyhlQ0uAmGeSM6v3ad+oKIMWjoEAcrz4A2uM6VZz8oQuVLffm4FEdOIKNQ
 FICebavma0wF9gKci0A==
X-Authority-Analysis: v=2.4 cv=Cfo4Irrl c=1 sm=1 tr=0 ts=69f3b772 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VabnemYjAAAA:8 a=c4au4WjlRKfxtgWlyl4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: zBVssKA2EgOeotz7bL2vW_yjhN6aeSG6
X-Proofpoint-GUID: zBVssKA2EgOeotz7bL2vW_yjhN6aeSG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01
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

Query dma-buf TPH metadata when registering a dma-buf MR for peer to
peer access and translate the raw steering tag into an mlx5 steering tag
index. Factor mlx5_st_alloc_index() so callers that already have a raw
steering tag can allocate the corresponding mlx5 index directly. Keep the
DMAH path as the first priority and only fall back to dma-buf metadata wh=
en
no DMAH is supplied.

Pass the device's supported ST width (8 or 16 bit, derived from
pdev->tph_req_type) to get_tph() so the exporter can reject tags that
exceed the consumer's capability. Initialize ret in mlx5_st_create() so t=
he
cached steering-tag path returns success cleanly under clang builds.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -46,6 +46,8 @@
 #include "data_direct.h"
 #include "dmah.h"
=20
+MODULE_IMPORT_NS("DMA_BUF");
+
 static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
@@ -899,6 +901,40 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
 	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st_i=
ndex,
+			      u8 *ph)
+{
+	struct pci_dev *pdev =3D dev->mdev->pdev;
+	struct dma_buf *dmabuf;
+	u16 steering_tag;
+	u8 st_width;
+	int ret;
+
+	st_width =3D (pdev->tph_req_type =3D=3D PCI_TPH_REQ_EXT_TPH) ? 16 : 8;
+
+	dmabuf =3D dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return;
+
+	if (!dmabuf->ops->get_tph)
+		goto end_dbuf_put;
+
+	ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
+	if (ret) {
+		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
+		goto end_dbuf_put;
+	}
+
+	ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_index);
+	if (ret) {
+		*ph =3D MLX5_IB_NO_PH;
+		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
+	}
+
+end_dbuf_put:
+	dma_buf_put(dmabuf);
+}
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -941,6 +977,8 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *d=
ma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+	} else {
+		get_tph_mr_dmabuf(dev, fd, &st_index, &ph);
 	}
=20
 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -29,7 +29,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *de=
v)
 	u8 direct_mode =3D 0;
 	u16 num_entries;
 	u32 tbl_loc;
-	int ret;
+	int ret =3D 0;
=20
 	if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
 		return NULL;
@@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
 	kfree(st);
 }
=20
-int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
-			unsigned int cpu_uid, u16 *st_index)
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index)
 {
 	struct mlx5_st_idx_data *idx_data;
 	struct mlx5_st *st =3D dev->st;
 	unsigned long index;
 	u32 xa_id;
-	u16 tag;
-	int ret;
+	int ret =3D 0;
=20
 	if (!st)
 		return -EOPNOTSUPP;
=20
-	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
-	if (ret)
-		return ret;
-
 	if (st->direct_mode) {
 		*st_index =3D tag;
 		return 0;
@@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
num tph_mem_type mem_type,
 	mutex_unlock(&st->lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
+
+int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
+			unsigned int cpu_uid, u16 *st_index)
+{
+	u16 tag;
+	int ret;
+
+	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
+	if (ret)
+		return ret;
+
+	return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
+}
 EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
=20
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1166,10 +1166,17 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
 			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
=20
 #ifdef CONFIG_PCIE_TPH
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index);
 int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
 			unsigned int cpu_uid, u16 *st_index);
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index);
 #else
+static inline int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev,
+					     u16 tag, u16 *st_index)
+{
+	return -EOPNOTSUPP;
+}
 static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu_uid, u16 *st_index)
