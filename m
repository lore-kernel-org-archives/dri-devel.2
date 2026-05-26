Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244B7CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 15:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B8110E6EC;
	Tue, 26 May 2026 15:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="DwNXBepa";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D67E10E6D3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 15:58:30 +0000 (UTC)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q2rgd62323490
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:58:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=gDuNn3rpanO1DihrMmhQrHSm1RvOXRtnr6ab6R1I/jM=; b=DwNXBepavwKm
 nyZY44KwzPaJYlaOLv3fWadfTO19FqKlVbV3mEO1Wuznug2CdCtTKFjmfR28ekX0
 x/WDlyRAXGjAPKndLF5deyJpSujQx8DmOGrityvhXzK+ZrtOQBn6pmmmswBlf0sc
 lSxM+pRbKPESX77Ga1/L11yEZxyN1Skkw0pRDfpHhIb6SsRKhE1zAWnLbCGWBGTV
 wkX555t4VippH3t7zBW8DSLhbx5TsBBjWDEqKmZm2mzb4wQMfA8AY+2Qay/JED9W
 ItwXRnX9zv96oHxkB5LhxnVUoh6ji/BwjukVna5tKEvuRvkDoJd3dZqkUepG19V9
 JCrEcuGzcQ==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eckmkyc0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:58:29 -0700 (PDT)
Received: from twshared132777.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:58:28 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 6B92735B01DBB; Tue, 26 May 2026 07:44:12 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v5 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
Date: Tue, 26 May 2026 07:43:56 -0700
Message-ID: <20260526144401.1485788-5-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526144401.1485788-1-zhipingz@meta.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNyBTYWx0ZWRfX/6AFtdfGXM3r
 bjh6FDM7Wwh+guHCn7J9OmDh47gmZR0aKz3Wzkby7wrNZtx1MpDGv8DG9I1UzSo3eMOfDY4DMfX
 fCyovSU/1hU8/Q7gaAdTvwjwdYT03yFY2qKo/XG5URi39J0bhD7OV3OrhlA53klkHU+L/F1CUct
 dj9Et6iCKJboQdYLNI+N+69O3zIQa5MfBzHPSS7EQzo3ioCsK/EgXkOE+lih/WbyJsRjKTHltRP
 tn7BY1wPl48shymsU5FI+asdZgxCzeK69/S53EoiMsPRQv/X8yKovU4oxrshcDjVgJGe20ItyCA
 fBpw6qhpALomZqSxaHH7vD0e5y//SGR6rv+MlfGg288A6yJkL5hVich3x1O2j17Rs4MC5j4cST4
 TsTO36X3mJwxgVbliinsLlLv44VtuYpMKbb9aOUMvZRNqzIYvOne4IHKgBvX72ysxXst1tP9GiL
 zJnJphQqXS5xDvskpdg==
X-Proofpoint-ORIG-GUID: bGcUno0bGjZTpj618y4n_P4hin4xM7If
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a15c325 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VabnemYjAAAA:8 a=V5UY4OeGJVDm2y4WvKoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: bGcUno0bGjZTpj618y4n_P4hin4xM7If
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
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

Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
peer access and translate the returned steering tag into an mlx5 ST
index. Keep the DMAH path as the first priority and only fall back to
DMA-buf metadata when no DMAH is supplied.

Track per-MR ownership of the allocated ST index and release it on MR
setup failure, destroy, and FRMR-pool reuse. Release the ST index before
the MR is pushed back into the FRMR pool, and free mlx5_st_idx_data when
its refcount reaches zero so repeated allocation/deallocation does not
leak memory.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
 drivers/infiniband/hw/mlx5/mr.c               | 86 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 28 ++++--
 include/linux/mlx5/driver.h                   |  7 ++
 4 files changed, 115 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw=
/mlx5/mlx5_ib.h
index e156dc4d7529..4ab867392267 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -721,6 +721,12 @@ struct mlx5_ib_mr {
 			u8 revoked :1;
 			/* Indicates previous dmabuf page fault occurred */
 			u8 dmabuf_faulted:1;
+			/* Set when the MR owns dmabuf_st_index and must
+			 * release it via mlx5_st_dealloc_index() once the
+			 * firmware mkey is no longer referencing it.
+			 */
+			u8 dmabuf_st_owned:1;
+			u16 dmabuf_st_index;
 			struct mlx5_ib_mkey null_mmkey;
 		};
 	};
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index 3b6da45061a5..8059b5e4da97 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-resv.h>
+#include <linux/pci-tph.h>
 #include <rdma/frmr_pools.h>
 #include <rdma/ib_umem_odp.h>
 #include "dm.h"
@@ -46,6 +47,8 @@
 #include "data_direct.h"
 #include "dmah.h"
=20
+MODULE_IMPORT_NS("DMA_BUF");
+
 static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
@@ -899,6 +902,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
 	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+/*
+ * Query TPH metadata from @dmabuf and translate the raw steering tag in=
to
+ * an mlx5 ST index. On success, returns 0 and the caller becomes the
+ * owner of *@st_index (must be released with mlx5_st_dealloc_index()
+ * once the firmware mkey no longer references it). On any failure
+ * *@st_index and *@ph are left as the no-TPH defaults set by the caller=
.
+ *
+ * @dmabuf must already be referenced by the caller (e.g. via the umem's
+ * attachment) so we don't re-resolve the user's fd here and avoid a
+ * dup2() TOCTOU between umem creation and TPH lookup.
+ */
+static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf *d=
mabuf,
+			      u16 *st_index, u8 *ph)
+{
+	u8 req_type;
+	u16 steering_tag;
+	u8 st_width;
+	int ret;
+
+	if (!dmabuf->ops->get_tph)
+		return;
+
+	req_type =3D pcie_tph_enabled_req_type(dev->mdev->pdev);
+	switch (req_type) {
+	case PCI_TPH_REQ_TPH_ONLY:
+		st_width =3D 8;
+		break;
+	case PCI_TPH_REQ_EXT_TPH:
+		st_width =3D 16;
+		break;
+	default:
+		return;
+	}
+
+	ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
+	if (ret) {
+		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
+		*ph =3D MLX5_IB_NO_PH;
+		return;
+	}
+
+	ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_index);
+	if (ret) {
+		*ph =3D MLX5_IB_NO_PH;
+		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
+	}
+}
+
+static void mlx5_ib_mr_put_dmabuf_st(struct mlx5_ib_mr *mr)
+{
+	if (mr->umem && mr->dmabuf_st_owned) {
+		mlx5_st_dealloc_index(mr_to_mdev(mr)->mdev,
+				      mr->dmabuf_st_index);
+		mr->dmabuf_st_owned =3D 0;
+	}
+}
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -941,16 +1001,26 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device=
 *dma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+	} else {
+		get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
+				  &st_index, &ph);
 	}
=20
 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
 				access_flags, access_mode,
 				st_index, ph);
 	if (IS_ERR(mr)) {
+		if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+			mlx5_st_dealloc_index(dev->mdev, st_index);
 		ib_umem_release(&umem_dmabuf->umem);
 		return ERR_CAST(mr);
 	}
=20
+	if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX) {
+		mr->dmabuf_st_index =3D st_index;
+		mr->dmabuf_st_owned =3D 1;
+	}
+
 	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
=20
 	atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_pages);
@@ -1377,9 +1447,17 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_i=
b_mr *mr)
 	bool is_odp =3D is_odp_mr(mr);
 	int ret;
=20
-	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
-	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
-		return 0;
+	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
+		/*
+		 * The mkey has been revoked: firmware no longer references
+		 * dmabuf_st_index, so release it before this mr can re-enter
+		 * the FRMR cache for reuse by another registration.
+		 */
+		mlx5_ib_mr_put_dmabuf_st(mr);
+
+		if (!ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
+			return 0;
+	}
=20
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
@@ -1400,6 +1478,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 		dma_resv_unlock(
 			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
 	}
+	if (!ret)
+		mlx5_ib_mr_put_dmabuf_st(mr);
 	return ret;
 }
=20
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 997be91f0a13..8929c17c88bc 100644
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
@@ -175,6 +184,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, =
u16 st_index)
=20
 	if (refcount_dec_and_test(&idx_data->usecount)) {
 		xa_erase(&st->idx_xa, st_index);
+		kfree(idx_data);
 		/* We leave PCI config space as was before, no mkey will refer to it *=
/
 	}
=20
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04b96c5abb57..523a9ab0ae1e 100644
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
--=20
2.53.0-Meta

