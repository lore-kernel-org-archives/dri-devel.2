Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C35ACD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 15:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE0F10E51D;
	Tue, 26 May 2026 15:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="WWNYZ9AL";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F0010E51D
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 15:31:52 +0000 (UTC)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q4ZPuN2221234
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:31:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=FyW6MI7ppD8uhXjlOJVh7voBOCW3iNd/b/HNjSSujQE=; b=WWNYZ9ALZrmP
 SPU2AILN7omA7/UAk3aTu0oD8ZddiaIv5CuwEjC8wlIPg86Y2ZDhTOBlrEgKTj6p
 ekAF/fcPv4gh63oEoDu+M/9qQbn782GEllAUICt6+kzO9iqQz+BQu2Ms0jT0w2b2
 XH5Y2lze2+8MSm2GV16AvhIbX5tvd+6ScJPxNg1awXdLmpxvCZwWMYUsXdYTf5y1
 vWbUq27zSar9EMs/PSvSUc73WAT8Fy4/e2A+bjNy2B7u/vJbNyD4y0T8NcjJhZTA
 gSiN/gY1f0QUviHvakQp7Z+Ljen4bB9PB6oNWPlRJkbb19NLYKNrS0g7AFOSic6C
 O15U8gvNcA==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ebbhgefe8-17
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:31:51 -0700 (PDT)
Received: from twshared124658.16.frc2.facebook.com (2620:10d:c085:208::7cb7)
 by mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:31:40 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id DD4F735B01D95; Tue, 26 May 2026 07:44:09 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v5 3/4] vfio/pci: implement get_tph and DMA_BUF_TPH feature
Date: Tue, 26 May 2026 07:43:55 -0700
Message-ID: <20260526144401.1485788-4-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526144401.1485788-1-zhipingz@meta.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: X4D3gJnvSYcme6WV2Vth03B-hil_Mizx
X-Proofpoint-ORIG-GUID: X4D3gJnvSYcme6WV2Vth03B-hil_Mizx
X-Authority-Analysis: v=2.4 cv=K8MS2SWI c=1 sm=1 tr=0 ts=6a15bce7 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8 a=aQ3nSqChrCSY4CE2ar0A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzMyBTYWx0ZWRfXwyqVNPST8epZ
 /UELO/W9LYJKm2RqwABMqpWcrTXcVtm6W/AY44gxkbLElsg2szzzIHmaW4pB6qeKoEO5mZORYYV
 MMmWs9VeSDYPg9CqmoGNWDXm1lTAkpLUpgef9y0OZDWHjWmOgd26E59Yq2MD7ZRgE7gQ4ExRqMO
 i0i+Guk4o1BifUK8NlWcvjXpmNFNorRb7dLdEr+lWuFKVPgOlMW8HDZca80SU0Xxw7wng/C0jxF
 /nEnIgD5WKrVuU+pMWj/PULQ825fRqqEzIXnhbOt01lfhd93oEjnt/wMevb62r2j7nMcs75L3Qg
 9DYNQDqp8Hqcb6/pRevTjh7fu71IR2A99HlY9nfMc+iX2zKJKTD0TSXU+4XPQFQA+zumizNAjOa
 IvVgCFruczgquC8JZuVXzE6BHSn7Q9aLtA1g3mcN2LCAhi4j+8m8oH8cT+SHpJ4zzUhq/ZeeZW0
 oHbMAX4jKHt4eoVzv3A==
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

Implement the dma-buf get_tph callback for vfio-pci-exported dma-bufs
and add VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can attach TPH
metadata to such a dma-buf.

8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
uAPI carries both with explicit validity flags, and get_tph() returns
the value matching the importer's requested width (or -EOPNOTSUPP).

The TPH descriptor is published under a new per-dma-buf mutex
(priv->lock) and read by get_tph() under the same mutex. The same
mutex serialises with the priv->vdev clear in
vfio_pci_dma_buf_cleanup() so a SET racing with device teardown
cannot observe a half-detached dma-buf. memory_lock remain on the
existing dma-buf paths; the outer order is memory_lock -> priv->lock.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c   |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c | 110 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |  12 ++++
 include/uapi/linux/vfio.h          |  37 ++++++++++
 4 files changed, 161 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
index 050e7542952e..4fa36f2f7555 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device =
*device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
+		return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
+							 argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
index 1a177ce7de54..3ea2978c376c 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -19,7 +19,19 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
-	u8 revoked : 1;
+	/*
+	 * @lock serializes TPH SET vs get_tph and the priv->vdev clear in
+	 * vfio_pci_dma_buf_cleanup(). It nests inside memory_lock:
+	 * the outer order across these paths is
+	 * memory_lock -> priv->lock.
+	 */
+	struct mutex lock;
+	u8 tph_st_valid:1;	/* priv->lock */
+	u8 tph_st_ext_valid:1;	/* priv->lock */
+	u8 tph_ph:2;		/* priv->lock */
+	u8 tph_st;		/* priv->lock */
+	u16 tph_st_ext;		/* priv->lock */
+	u8 revoked:1;		/* dma_resv_lock */
 };
=20
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -69,6 +81,38 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 	return ret;
 }
=20
+static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steerin=
g_tag,
+				    u8 *ph, u8 st_width)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+	int ret =3D 0;
+
+	mutex_lock(&priv->lock);
+	switch (st_width) {
+	case 8:
+		if (!priv->tph_st_valid) {
+			ret =3D -EOPNOTSUPP;
+			break;
+		}
+		*steering_tag =3D priv->tph_st;
+		*ph =3D priv->tph_ph;
+		break;
+	case 16:
+		if (!priv->tph_st_ext_valid) {
+			ret =3D -EOPNOTSUPP;
+			break;
+		}
+		*steering_tag =3D priv->tph_st_ext;
+		*ph =3D priv->tph_ph;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment=
,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -95,12 +139,14 @@ static void vfio_pci_dma_buf_release(struct dma_buf =
*dmabuf)
 		up_write(&priv->vdev->memory_lock);
 		vfio_device_put_registration(&priv->vdev->vdev);
 	}
+	mutex_destroy(&priv->lock);
 	kfree(priv->phys_vec);
 	kfree(priv);
 }
=20
 static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
 	.attach =3D vfio_pci_dma_buf_attach,
+	.get_tph =3D vfio_pci_dma_buf_get_tph,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
@@ -265,6 +311,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
 		ret =3D -ENOMEM;
 		goto err_free_ranges;
 	}
+	mutex_init(&priv->lock);
 	priv->phys_vec =3D kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_ranges)=
;
 	if (!priv->phys_vec) {
 		ret =3D -ENOMEM;
@@ -327,12 +374,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
 err_free_phys:
 	kfree(priv->phys_vec);
 err_free_priv:
+	mutex_destroy(&priv->lock);
 	kfree(priv);
 err_free_ranges:
 	kfree(dma_ranges);
 	return ret;
 }
=20
+int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
+				      u32 flags,
+				      struct vfio_device_feature_dma_buf_tph __user *arg,
+				      size_t argsz)
+{
+	struct vfio_device_feature_dma_buf_tph set_tph;
+	struct vfio_pci_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	int ret;
+
+	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(set_tph));
+	if (ret !=3D 1)
+		return ret;
+
+	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
+		return -EFAULT;
+
+	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
+		return -EINVAL;
+
+	if (!set_tph.flags)
+		return -EINVAL;
+
+	/* PCIe TLP Processing Hint is a 2-bit field. */
+	if (set_tph.ph & ~0x3)
+		return -EINVAL;
+
+	dmabuf =3D dma_buf_get(set_tph.dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
+		ret =3D -EINVAL;
+		goto out_put;
+	}
+
+	priv =3D dmabuf->priv;
+	mutex_lock(&priv->lock);
+	if (priv->vdev !=3D vdev) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	priv->tph_st =3D set_tph.steering_tag;
+	priv->tph_st_ext =3D set_tph.steering_tag_ext;
+	priv->tph_ph =3D set_tph.ph;
+	priv->tph_st_valid =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
+	priv->tph_st_ext_valid =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
+	ret =3D 0;
+
+out_unlock:
+	mutex_unlock(&priv->lock);
+out_put:
+	dma_buf_put(dmabuf);
+	return ret;
+}
+
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revok=
ed)
 {
 	struct vfio_pci_dma_buf *priv;
@@ -398,7 +504,9 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_de=
vice *vdev)
 			continue;
=20
 		list_del_init(&priv->dmabufs_elm);
+		mutex_lock(&priv->lock);
 		priv->vdev =3D NULL;
+		mutex_unlock(&priv->lock);
 		vfio_device_put_registration(&vdev->vdev);
 		fput(priv->dmabuf->file);
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci=
_priv.h
index fca9d0dfac90..c58f369be4b3 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev *p=
dev)
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32=
 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz);
+int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
+				      u32 flags,
+				      struct vfio_device_feature_dma_buf_tph __user *arg,
+				      size_t argsz);
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revok=
ed);
 #else
@@ -128,6 +132,14 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_d=
evice *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
+
+static inline int
+vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u32=
 flags,
+				  struct vfio_device_feature_dma_buf_tph __user *arg,
+				  size_t argsz)
+{
+	return -ENOTTY;
+}
 static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device =
*vdev)
 {
 }
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..55cac3b7122c 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,43 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
=20
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) met=
adata
+ * with a vfio-exported dma-buf. The dma-buf must have been created by
+ * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
+ *
+ * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_=
BUF.
+ *
+ * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
+ * distinct namespaces in the PCIe TPH ST table and may both be present =
with
+ * different values. Userspace should populate the value(s) it has from =
the
+ * firmware ST table for this device and set the matching VFIO_DMA_BUF_T=
PH_ST /
+ * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a specifi=
c
+ * width and receives the matching value; if the requested width is not
+ * present, the importer is told TPH is unavailable for this dma-buf.
+ *
+ * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
+ *
+ * Userspace is responsible for setting TPH on the dma-buf before handin=
g the
+ * fd to the importer. Calling SET again replaces the previously publish=
ed
+ * values; racing a SET against an importer that is already consuming th=
e
+ * dma-buf is a userspace ordering problem.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
+
+#define VFIO_DMA_BUF_TPH_ST		(1 << 0)  /* steering_tag valid */
+#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)  /* steering_tag_ext valid */
+
+struct vfio_device_feature_dma_buf_tph {
+	__s32	dmabuf_fd;
+	__u32	flags;
+	__u8	steering_tag;
+	__u8	ph;
+	__u16	steering_tag_ext;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
--=20
2.53.0-Meta

