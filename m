Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7267FCD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC6B310F8FF;
	Mon,  8 Jun 2026 19:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="lABBUkrc";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D2010F8FA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:17:15 +0000 (UTC)
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6583qf952017234
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 12:17:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=LZCUbo/ppriv2BKbMhTc4u0byMQ5QlwKZF6k1nD2Q+k=; b=lABBUkrcJ/b9
 osu00gkKlj332gdDq0qgB9F5xx85GJDZAvjTiS+uToP0GM1zQtnesL5WtaEH1R9R
 RyfvyIt0B3+7F7eLVtJSRN8hCLL8VbHiu100dQoOVgYfwUy8kDq7xvJqU1YeJnnc
 oL6g733b+UvoUPPWEG+c7+1Je3cvfqmxYBBhJlI/rkPOwBdKo+YqSDb/gZDz2BzY
 1joj4VyZdshHH74WtB5/MbXgFbpC7ZcXETEi7nmXnlfUMwquBNsYP1EfLLUxq22I
 +GAsSnrTZ9Ip0yecLX2gCvrYkH+/+HME9H8gqyzeJ/bE6Gl0tUIaobcwOrCKmP8E
 Z9X/ktjPqA==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en85k6vwy-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 12:17:15 -0700 (PDT)
Received: from twshared115868.16.frc2.facebook.com (2620:10d:c085:208::7cb7)
 by mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 8 Jun 2026 19:17:12 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 873AB3CC1014D; Mon,  8 Jun 2026 11:56:50 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
Date: Mon, 8 Jun 2026 11:56:41 -0700
Message-ID: <20260608185646.4085127-5-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608185646.4085127-1-zhipingz@meta.com>
References: <20260608185646.4085127-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6j9E15Yy77QcWi4492RE6q1ur_1y-T7p
X-Proofpoint-ORIG-GUID: 6j9E15Yy77QcWi4492RE6q1ur_1y-T7p
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=6a27153b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=Vh3pHvTd1UiKqhSfTVkA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3OCBTYWx0ZWRfX6y6kMEuyv8uL
 JwTihGXHloIpfqMlOC4ipeE/xIiUYk9e30Nj8F87tYz3g/qDNTPTXeGsrIXn85vIjSZk8k+AsW+
 92YIAGV3N5PbyYMJ0hTAW5w6qau9uhpDlDDbxw+MZByrhAJW9VVdYiF98iKPcEYSUX2JphjrDUy
 RpJoPl3xVAnjwVdVBGXi/2F/Mq8y0LpZvUy4PncpFIj1F3nSA/osqo7+gqFV8eLYdvCBxpF8GUf
 Anj9m6nQyY0ubs82vFcebGGBxL/T923WYrYwNqOO7EYYjn+ZWXIyDhchJtW19IltbNf+CAMoavY
 XfTlHOT9SV9vJtaGKLvub6Q26vRjk0OOLzsAn6YvsBlWm8cSFeBg0quhKHrGqNqSwEFGiNbS0+C
 RPXjd+RZP8NgRe11hI+5a2jVIZXei65Q6/0rzZB1LQJkn98UwROmw7uKferV60uGzVhBbcKLyDb
 jbNZTZZ7ZHIUTSsCiYw==
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

Implement the dma-buf get_tph callback for vfio-pci-exported dma-bufs
and add VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can attach TPH
metadata to such a dma-buf.

8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
uAPI carries both with explicit validity flags, and get_tph() returns
the value matching the importer's requested width (or -EOPNOTSUPP).

The TPH descriptor is published and read under a new per-dma-buf mutex
priv->tph_lock so a SET racing with a get_tph reader sees consistent
fields. The mutex's only role is serialising the TPH state; priv->vdev
and dmabuf lifetime are managed by the existing ioctl reference and
dma_buf_get() ref, so the cleanup path does not need to take this
mutex.

The SET ioctl returns -EOPNOTSUPP if the underlying device does not
expose the PCIe TPH Extended Capability (pdev->tph_cap =3D=3D 0); setting
ST metadata on a device that cannot act as a TPH completer is
nonsensical and rejecting it early gives userspace a clear signal.

The uAPI itself is not device-specific. It publishes the PCI SIG-defined
ST/PH tuple for a VFIO-owned PCIe completer and keeps the tuple opaque
to dma-buf; any importer simply requests the namespace it supports and
places the returned value on generated TLPs. Any other userspace driver
using vfio-pci for an endpoint that accepts inbound TPH can reuse the
same interface.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
Test plan: verified the kernel-side behavior by checking that an
importer such as mlx5 emits the programmed ST/PH on outbound P2P TLPs
after a successful VFIO_DEVICE_FEATURE_DMA_BUF_TPH set.

 drivers/vfio/pci/vfio_pci_core.c   |  3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c | 92 +++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
 include/uapi/linux/vfio.h          | 45 +++++++++++++++
 4 files changed, 151 insertions(+), 1 deletion(-)

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
index 1a177ce7de54..dd11a7db6b41 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -2,7 +2,9 @@
 /* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.
  */
 #include <linux/dma-buf-mapping.h>
+#include <linux/mutex.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pci-tph.h>
 #include <linux/dma-resv.h>
=20
 #include "vfio_pci_priv.h"
@@ -19,7 +21,14 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
-	u8 revoked : 1;
+	/* @tph_lock serializes TPH SET vs get_tph on the TPH fields below. */
+	struct mutex tph_lock;
+	u8 tph_st_valid:1;
+	u8 tph_st_ext_valid:1;
+	u8 tph_ph:2;
+	u8 tph_st;
+	u16 tph_st_ext;
+	u8 revoked:1;
 };
=20
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -69,6 +78,25 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 	return ret;
 }
=20
+static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, bool extende=
d,
+				    u16 *steering_tag, u8 *ph)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+
+	guard(mutex)(&priv->tph_lock);
+	if (extended) {
+		if (!priv->tph_st_ext_valid)
+			return -EOPNOTSUPP;
+		*steering_tag =3D priv->tph_st_ext;
+	} else {
+		if (!priv->tph_st_valid)
+			return -EOPNOTSUPP;
+		*steering_tag =3D priv->tph_st;
+	}
+	*ph =3D priv->tph_ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment=
,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -95,12 +123,14 @@ static void vfio_pci_dma_buf_release(struct dma_buf =
*dmabuf)
 		up_write(&priv->vdev->memory_lock);
 		vfio_device_put_registration(&priv->vdev->vdev);
 	}
+	mutex_destroy(&priv->tph_lock);
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
@@ -265,6 +295,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
 		ret =3D -ENOMEM;
 		goto err_free_ranges;
 	}
+	mutex_init(&priv->tph_lock);
 	priv->phys_vec =3D kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_ranges)=
;
 	if (!priv->phys_vec) {
 		ret =3D -ENOMEM;
@@ -327,12 +358,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
 err_free_phys:
 	kfree(priv->phys_vec);
 err_free_priv:
+	mutex_destroy(&priv->tph_lock);
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
+	if (!pcie_tph_supported(vdev->pdev))
+		return -EOPNOTSUPP;
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
+	if (priv->vdev !=3D vdev) {
+		ret =3D -EINVAL;
+		goto out_put;
+	}
+
+	scoped_guard(mutex, &priv->tph_lock) {
+		priv->tph_st =3D set_tph.steering_tag;
+		priv->tph_st_ext =3D set_tph.steering_tag_ext;
+		priv->tph_ph =3D set_tph.ph;
+		priv->tph_st_valid =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
+		priv->tph_st_ext_valid =3D
+			!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
+	}
+	ret =3D 0;
+
+out_put:
+	dma_buf_put(dmabuf);
+	return ret;
+}
+
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revok=
ed)
 {
 	struct vfio_pci_dma_buf *priv;
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
index 5de618a3a5ee..0ca26721849b 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,51 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
=20
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) met=
adata
+ * with a vfio-exported dma-buf. The dma-buf must have been created by
+ * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must expos=
e the
+ * TPH Extended Capability (otherwise the ioctl returns -EOPNOTSUPP).
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
+ * This publishes the PCI SIG-defined ST/PH tuple for a VFIO-owned PCIe
+ * completer. The dma-buf core treats the tuple as opaque completer-owne=
d
+ * metadata; an importer simply requests the namespace it supports and p=
laces
+ * the returned value on generated TLPs.
+ *
+ * @flags =3D=3D 0 clears any previously published metadata.
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
+	__u16	steering_tag_ext;
+	__u8	steering_tag;
+	__u8	ph;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
--=20
2.53.0-Meta

