Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D206CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD8B610F8FE;
	Mon,  8 Jun 2026 19:17:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="bfqNbmKj";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE8610F8FE
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:17:05 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6581mGKt4020943
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 12:17:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=gCwGWNOHw9RIvLvGZ7VbW1v67n2sZSJBrAfUvTr3IzI=; b=bfqNbmKjxzLn
 zHhw50zCEW+N2duFuy1qLhdCCmMfwhdohnhLcdBloRnkaqPDrVvoPmFa5G1mlfqD
 b6C3UTja33y3KDXL8/wAFz1CbdB797+gLZNAFXrl1z8zCd9ttoFvfCsT/V9lF9tD
 Icrgu2yPBschnkeDzivLf/c3IKf6aAJD5q9EjhmTleceZ5EnFapXXhVG2pu/PnPP
 Ig1eOg37cB4WKadgW5B0CSMvKLn0H7G0+s2owWUCKgTVN+ZGYZM/Jb+KrKBhI+or
 IZgUO4fZlCc61G+i3E8TT6rQy39zmqjouiVQ3jHyb38yjaHCl4qvwzgH40eJL8xp
 GdKTMx50DQ==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4emh81astx-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 12:17:05 -0700 (PDT)
Received: from twshared9540.02.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 8 Jun 2026 19:17:01 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 4FACD3CC10155; Mon,  8 Jun 2026 11:56:51 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v6 5/5] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
Date: Mon, 8 Jun 2026 11:56:42 -0700
Message-ID: <20260608185646.4085127-6-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608185646.4085127-1-zhipingz@meta.com>
References: <20260608185646.4085127-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: q72F5yYkV6QXoLh3QfuRqIl8MsgO85JI
X-Authority-Analysis: v=2.4 cv=PJI/P/qC c=1 sm=1 tr=0 ts=6a271531 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8 a=Oq1nFPtDFzcDtp-DflMA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: q72F5yYkV6QXoLh3QfuRqIl8MsgO85JI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3OCBTYWx0ZWRfX+P/MOlMW8BtW
 Aa2ObA8n89c325ygbPcg25A8o6jN7w3cmnv2CYq4sMhKJ8r7CjlX+jql5dGtNpy/twiQ7griMB5
 hfjQgUMjEFMC9EoSihVcEP06DnuDY6g9BWDOYni7wvx8UUDvNq50SDDXmvcR3n9YttkVqPR2a7B
 YCInRetRq0fP6lbiKrRh/33Dj6H9xRg14klc6pea+Qq+4oNnOXTHug0KZaAC3cKjiwDnCFhvEkb
 VL8wqp+k+L6OXZHO09BXYII0cGNkxzqHD9ZinkEXmiYyVkrEEDhyaaqhbfr17Cr/bHafnLl2/ML
 qC+Z/vAJOIWBz4TeWPJrZO5ZCEYjDxOqGJsmuUnUsA+qS/R1dYOUCRJprc89PAa5Vx77x4atetO
 ETlrY20AmhYPD3sl/8yqIQKAkN1rwUHvfeBAVsYmg+7mWJDZLK7AIxyqKZbazI2Q7SWk/jGOoeZ
 fTA8RJTZs7tCSUcuFbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
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

Split the existing mlx5_st_alloc_index() into mlx5_st_alloc_index_by_tag(=
)
plus a tag-from-cpu wrapper so the dma-buf path can allocate an ST
index directly from a raw steering tag without going through the
per-CPU table. mlx5_st_alloc_index_by_tag() explicitly initialises
'ret' so the duplicate-tag fast path doesn't return an uninitialised
value, which would otherwise be observed by callers when an MR
re-uses a tag that already has an ST index allocated.

For TPH-backed FRMRs, the extra ST-table reference belongs to the
hardware mkey handle, not the transient MR object. Add mlx5_st_get_index(=
)
and extend the FRMR pool API so ib_frmr_pool_pop() reports whether a
handle was reused and destroy_frmrs() receives the pool key. The DMAH
and dma-buf paths take a provisional ST ref before pool lookup; reuse
drops that provisional ref immediately, while newly created handles
keep it and release it only when the FRMR handle is actually destroyed,
either directly or through FRMR pool aging/cleanup.

Also decode the PH bits stored in kernel_vendor_key when recreating
pooled mkeys so the programmed requester hint matches the pool key.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/core/frmr_pools.c          |  20 ++-
 drivers/infiniband/hw/mlx5/mr.c               | 124 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++--
 include/linux/mlx5/driver.h                   |  12 ++
 include/rdma/frmr_pools.h                     |   5 +-
 5 files changed, 191 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/co=
re/frmr_pools.c
index 5e992ff3d7cf..61a77847118e 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -92,7 +92,8 @@ static void destroy_all_handles_in_queue(struct ib_devi=
ce *device,
 	u32 count;
=20
 	while (pop_frmr_handles_page(pool, queue, &page, &count)) {
-		pools->pool_ops->destroy_frmrs(device, page->handles, count);
+		pools->pool_ops->destroy_frmrs(device, &pool->key,
+					       page->handles, count);
 		kfree(page);
 	}
 }
@@ -136,7 +137,8 @@ static bool age_pinned_pool(struct ib_device *device,=
 struct ib_frmr_pool *pool)
 	spin_unlock(&pool->lock);
=20
 	if (destroyed)
-		pools->pool_ops->destroy_frmrs(device, handles, destroyed);
+		pools->pool_ops->destroy_frmrs(device, &pool->key, handles,
+					       destroyed);
 	kfree(handles);
 	return has_work;
 }
@@ -453,9 +455,11 @@ int ib_frmr_pools_set_pinned(struct ib_device *devic=
e, struct ib_frmr_key *key,
 }
=20
 static int get_frmr_from_pool(struct ib_device *device,
-			      struct ib_frmr_pool *pool, struct ib_mr *mr)
+			      struct ib_frmr_pool *pool, struct ib_mr *mr,
+			      bool *reused)
 {
 	struct ib_frmr_pools *pools =3D device->frmr_pools;
+	bool local_reused =3D false;
 	u32 handle;
 	int err;
=20
@@ -464,6 +468,7 @@ static int get_frmr_from_pool(struct ib_device *devic=
e,
 		if (pool->inactive_queue.ci > 0) {
 			handle =3D pop_handle_from_queue_locked(
 				&pool->inactive_queue);
+			local_reused =3D true;
 		} else {
 			spin_unlock(&pool->lock);
 			err =3D pools->pool_ops->create_frmrs(device, &pool->key,
@@ -474,6 +479,7 @@ static int get_frmr_from_pool(struct ib_device *devic=
e,
 		}
 	} else {
 		handle =3D pop_handle_from_queue_locked(&pool->queue);
+		local_reused =3D true;
 	}
=20
 	pool->in_use++;
@@ -484,6 +490,8 @@ static int get_frmr_from_pool(struct ib_device *devic=
e,
=20
 	mr->frmr.pool =3D pool;
 	mr->frmr.handle =3D handle;
+	if (reused)
+		*reused =3D local_reused;
=20
 	return 0;
 }
@@ -493,10 +501,12 @@ static int get_frmr_from_pool(struct ib_device *dev=
ice,
  *
  * @device: The device to pop the FRMR handle from.
  * @mr: The MR to pop the FRMR handle from.
+ * @reused: Optional output that reports whether the returned handle was
+ *	    reused from the pool instead of freshly created.
  *
  * Returns 0 on success, negative error code on failure.
  */
-int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr)
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr, bool *r=
eused)
 {
 	struct ib_frmr_pools *pools =3D device->frmr_pools;
 	struct ib_frmr_pool *pool;
@@ -509,7 +519,7 @@ int ib_frmr_pool_pop(struct ib_device *device, struct=
 ib_mr *mr)
 			return PTR_ERR(pool);
 	}
=20
-	return get_frmr_from_pool(device, pool, mr);
+	return get_frmr_from_pool(device, pool, mr, reused);
 }
 EXPORT_SYMBOL(ib_frmr_pool_pop);
=20
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index 3b6da45061a5..b56df39d3385 100644
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
@@ -167,12 +168,39 @@ static int get_unchangeable_access_flags(struct mlx=
5_ib_dev *dev,
 #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK 0xFF0000
 #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK 0xFFFF
=20
+static int mlx5_ib_get_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
+					  u16 st_index)
+{
+	if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+		return 0;
+
+	return mlx5_st_get_index(dev->mdev, st_index);
+}
+
+static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_ind=
ex)
+{
+	if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+		return;
+
+	mlx5_st_dealloc_index(dev->mdev, st_index);
+}
+
+static void mlx5_ib_put_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
+					   u64 kernel_vendor_key)
+{
+	u16 st_index =3D kernel_vendor_key &
+		       MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK;
+
+	mlx5_ib_put_st_index_ref(dev, st_index);
+}
+
 static struct mlx5_ib_mr *
 _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 		      int access_flags, int access_mode,
 		      unsigned long page_size, u16 st_index, u8 ph)
 {
 	struct mlx5_ib_mr *mr;
+	bool reused =3D false;
 	int err;
=20
 	mr =3D kzalloc_obj(*mr);
@@ -195,11 +223,14 @@ _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, stru=
ct ib_umem *umem,
=20
 	mr->ibmr.frmr.key.kernel_vendor_key =3D
 		st_index | (ph << MLX5_FRMR_POOLS_KERNEL_KEY_PH_SHIFT);
-	err =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr);
+	err =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr, &reused);
 	if (err) {
 		kfree(mr);
 		return ERR_PTR(err);
 	}
+	if (reused)
+		mlx5_ib_put_frmr_st_handle_ref(
+			dev, mr->ibmr.frmr.key.kernel_vendor_key);
 	mr->mmkey.key =3D mr->ibmr.frmr.handle;
 	init_waitqueue_head(&mr->mmkey.wait);
=20
@@ -229,7 +260,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib=
_dev *dev,
 	init_waitqueue_head(&mr->mmkey.wait);
=20
 	mr->ibmr.frmr.key =3D key;
-	ret =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr);
+	ret =3D ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr, NULL);
 	if (ret) {
 		kfree(mr);
 		return ERR_PTR(ret);
@@ -273,7 +304,8 @@ static int mlx5r_create_mkeys(struct ib_device *devic=
e, struct ib_frmr_key *key,
=20
 	st_index =3D key->kernel_vendor_key &
 		   MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK;
-	ph =3D key->kernel_vendor_key & MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK;
+	ph =3D (key->kernel_vendor_key & MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK) >>
+	     MLX5_FRMR_POOLS_KERNEL_KEY_PH_SHIFT;
 	if (ph) {
 		/* Normalize ph: swap MLX5_IB_NO_PH for 0 */
 		if (ph =3D=3D MLX5_IB_NO_PH)
@@ -299,7 +331,8 @@ static int mlx5r_create_mkeys(struct ib_device *devic=
e, struct ib_frmr_key *key,
 	return err;
 }
=20
-static void mlx5r_destroy_mkeys(struct ib_device *device, u32 *handles,
+static void mlx5r_destroy_mkeys(struct ib_device *device,
+				const struct ib_frmr_key *key, u32 *handles,
 				unsigned int count)
 {
 	struct mlx5_ib_dev *dev =3D to_mdev(device);
@@ -311,6 +344,9 @@ static void mlx5r_destroy_mkeys(struct ib_device *dev=
ice, u32 *handles,
 			pr_warn_ratelimited(
 				"mlx5_ib: failed to destroy mkey %d: %d",
 				handles[i], err);
+		else
+			mlx5_ib_put_frmr_st_handle_ref(dev,
+						       key->kernel_vendor_key);
 	}
 }
=20
@@ -333,6 +369,7 @@ static int mlx5r_build_frmr_key(struct ib_device *dev=
ice,
 		get_unchangeable_access_flags(dev, in->access_flags);
 	out->vendor_key =3D in->vendor_key;
 	out->num_dma_blocks =3D in->num_dma_blocks;
+	out->kernel_vendor_key =3D in->kernel_vendor_key;
=20
 	return 0;
 }
@@ -753,6 +790,12 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd=
, struct ib_umem *umem,
=20
 	xlt_with_umr =3D mlx5r_umr_can_load_pas(dev, umem->length);
 	if (xlt_with_umr) {
+		err =3D mlx5_ib_get_frmr_st_handle_ref(dev, st_index);
+		if (err) {
+			ib_umem_release(umem);
+			return ERR_PTR(err);
+		}
+
 		mr =3D alloc_cacheable_mr(pd, umem, iova, access_flags,
 					MLX5_MKC_ACCESS_MODE_MTT,
 					st_index, ph);
@@ -767,6 +810,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd,=
 struct ib_umem *umem,
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 	if (IS_ERR(mr)) {
+		if (xlt_with_umr)
+			mlx5_ib_put_st_index_ref(dev, st_index);
 		ib_umem_release(umem);
 		return ERR_CAST(mr);
 	}
@@ -899,6 +944,65 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_atta=
ch_ops =3D {
 	.invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+/*
+ * Query TPH metadata from @dmabuf and translate the raw steering tag in=
to
+ * an mlx5 ST index. On success *@st_index is updated with a provisional
+ * reference for a candidate FRMR handle and *@ph is updated to the dma-=
buf's
+ * processing hint. Callers that fail to allocate a handle, or that reus=
e an
+ * existing pooled handle, must drop the provisional ST reference. On an=
y
+ * failure *@st_index and *@ph are left untouched, so the caller's no-TP=
H
+ * defaults stand.
+ *
+ * @dmabuf must already be referenced by the caller (e.g. via the umem's
+ * attachment) so we don't re-resolve the user's fd here and avoid a
+ * dup2() TOCTOU between umem creation and TPH lookup.
+ */
+static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf *d=
mabuf,
+			      u16 *st_index, u8 *ph)
+{
+	u16 local_st_index;
+	u16 steering_tag;
+	u8 local_ph;
+	bool extended;
+	int ret;
+
+	if (!dmabuf->ops->get_tph)
+		return;
+
+	switch (pcie_tph_enabled_req_type(dev->mdev->pdev)) {
+	case PCI_TPH_REQ_TPH_ONLY:
+		extended =3D false;
+		break;
+	case PCI_TPH_REQ_EXT_TPH:
+		extended =3D true;
+		break;
+	default:
+		return;
+	}
+
+	ret =3D dmabuf->ops->get_tph(dmabuf, extended, &steering_tag, &local_ph=
);
+	if (ret) {
+		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
+		return;
+	}
+
+	ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag,
+					 &local_st_index);
+	if (ret) {
+		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
+		return;
+	}
+
+	*st_index =3D local_st_index;
+	*ph =3D local_ph;
+}
+
+static void mlx5_ib_mr_put_frmr_st_handle_ref(struct mlx5_ib_mr *mr)
+{
+	mlx5_ib_put_frmr_st_handle_ref(mr_to_mdev(mr),
+				       mr->ibmr.frmr.key.kernel_vendor_key);
+}
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -941,12 +1045,22 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device=
 *dma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+
+		err =3D mlx5_ib_get_frmr_st_handle_ref(dev, st_index);
+		if (err) {
+			ib_umem_release(&umem_dmabuf->umem);
+			return ERR_PTR(err);
+		}
+	} else {
+		get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
+				  &st_index, &ph);
 	}
=20
 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
 				access_flags, access_mode,
 				st_index, ph);
 	if (IS_ERR(mr)) {
+		mlx5_ib_put_st_index_ref(dev, st_index);
 		ib_umem_release(&umem_dmabuf->umem);
 		return ERR_CAST(mr);
 	}
@@ -1400,6 +1514,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib=
_mr *mr)
 		dma_resv_unlock(
 			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
 	}
+	if (!ret)
+		mlx5_ib_mr_put_frmr_st_handle_ref(mr);
 	return ret;
 }
=20
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 7cedc348790d..877b37b4e639 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
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
@@ -152,8 +147,46 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
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
+int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_index)
+{
+	struct mlx5_st_idx_data *idx_data;
+	struct mlx5_st *st =3D dev->st;
+	int ret =3D 0;
+
+	if (!st)
+		return -EOPNOTSUPP;
+
+	if (st->direct_mode)
+		return 0;
+
+	mutex_lock(&st->lock);
+	idx_data =3D xa_load(&st->idx_xa, st_index);
+	if (WARN_ON_ONCE(!idx_data))
+		ret =3D -EINVAL;
+	else
+		refcount_inc(&idx_data->usecount);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mlx5_st_get_index);
+
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
 {
 	struct mlx5_st_idx_data *idx_data;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04b96c5abb57..0480b5c4f189 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1166,10 +1166,22 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
 			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
=20
 #ifdef CONFIG_PCIE_TPH
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index);
+int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_index);
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
+static inline int mlx5_st_get_index(struct mlx5_core_dev *dev, u16 st_in=
dex)
+{
+	return -EOPNOTSUPP;
+}
 static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu_uid, u16 *st_index)
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
index af1b88801fa4..a08d2b2cf9f3 100644
--- a/include/rdma/frmr_pools.h
+++ b/include/rdma/frmr_pools.h
@@ -24,7 +24,8 @@ struct ib_frmr_key {
 struct ib_frmr_pool_ops {
 	int (*create_frmrs)(struct ib_device *device, struct ib_frmr_key *key,
 			    u32 *handles, u32 count);
-	void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
+	void (*destroy_frmrs)(struct ib_device *device,
+			      const struct ib_frmr_key *key, u32 *handles,
 			      u32 count);
 	int (*build_key)(struct ib_device *device, const struct ib_frmr_key *in=
,
 			 struct ib_frmr_key *out);
@@ -33,7 +34,7 @@ struct ib_frmr_pool_ops {
 int ib_frmr_pools_init(struct ib_device *device,
 		       const struct ib_frmr_pool_ops *pool_ops);
 void ib_frmr_pools_cleanup(struct ib_device *device);
-int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr);
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr, bool *r=
eused);
 int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
=20
 #endif /* FRMR_POOLS_H */
--=20
2.53.0-Meta

