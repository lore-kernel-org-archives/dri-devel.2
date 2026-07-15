Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9263C4450A
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B8110F13A;
	Wed, 15 Jul 2026 20:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="PVH6mwFt";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518BA10E236
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 20:51:07 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FKQfkD943256
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:51:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=7YiqQdnniWevXoO8/n4Dj4e9MIf/UItPFP3U5fRYzK4=; b=PVH6mwFtDh+8
 9gXs4K1tSPAd48583Pz8Cp/fLvi6/IkuO8WZABQGpTFPvVzAoRP4iaFkj1qhThBI
 G8pg3ef3p+msjiCnMaIrTSYYz0fThGx33Slfg+vgIUbkRE9G3uMY6nLpYXtT+TjC
 3wQ9KlTs/R514oL3LdDtnkltUK7w4gc9nOkMKZtd/vv+Mud1LcfBMFbYqQl5ZEZP
 ptfcJzJQpEoQhHbjGgzBFhJBatcjOaUvpBmH21SH9Pb1ct+caro+64QtC/du1otR
 66f7YNSmmPXWLLdKb9yFBufCyAB6/PH8xqmsE2sGj8byyAc3xExRCJ3dyoHMscMx
 s5snPjgtmA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4feamkk1k7-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:51:06 -0700 (PDT)
Received: from twshared4170.04.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 15 Jul 2026 20:51:04 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 07CB4423AA096; Wed, 15 Jul 2026 13:40:12 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Michael
 Guralnik <michaelgur@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v12 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
Date: Wed, 15 Jul 2026 13:39:58 -0700
Message-ID: <20260715204008.3911275-4-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715204008.3911275-1-zhipingz@meta.com>
References: <20260715204008.3911275-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfX1Dl0R7SwMryv
 WopJpKpSrJb73UzUIe1JTFYdWck6L3bCtQOAOWPTJCqNOZdTNnvc2CRvrCupkDpTy4GEHW//sIg
 sz/kGh291hcLLB0KDYm1RNvlkXHxroY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfX+6B1xAw+L5UB
 dJSa4zXo7cS/1XKi5FamAqQ1ZHSZm5feoJjwR+GXnSBL+IETd0mHJe91o3Bs49ArjNYCVpm2mA0
 eb0y//kXBNB2GSFSimOwKonHozSj3s/IuTV76huFNdFbOHWQZjYQYWZu/ozsAdeRswFR73nWMCR
 SoK2148xjMO8yP8Xx/w82wcwOtVrHG3KRKrkznYAX9M+GSiwLTM8siWBsXNTihicHV4+MjPAOQ5
 86aIpDPZOxeHRX5yGmf68sKeGlxon5Ib6nymeajFheRsy1dKjKxfSJ/cAdljxqxnWXKOKJZeIf4
 qxB3CIdmAckr5yex1VL42IdZex5lP0Qf9eiPmVzl7d7gyZAJ2RKdvfMilhf6Qj+4ROCZryHZ9gO
 T5XBnYO+HjrsdwMm89/4mv2a/HSHbaJED4pqffX5bO//lH4kQdD8ANR/WdvMKz0Yd0DDYfEYRrO
 bDcMbRgYMF+wdStj4SQ==
X-Proofpoint-ORIG-GUID: Xz9wsYv6bZ60ivvhpfYk8hqx1QyjADRC
X-Authority-Analysis: v=2.4 cv=bJEm5v+Z c=1 sm=1 tr=0 ts=6a57f2ba cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=pTDmpHESbC-hH2JOtYYA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Xz9wsYv6bZ60ivvhpfYk8hqx1QyjADRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01
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

Implement dma-buf get_pci_tph for vfio-pci exported dma-bufs and add
VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
for a VFIO-owned device.

8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
uAPI carries both with explicit validity flags, and get_pci_tph()
returns the value matching the importer's requested namespace or
-EOPNOTSUPP.

Publish and read the TPH descriptor under dmabuf->resv, matching the
locking used for other importer-visible dma-buf state. The SET ioctl
takes dma_resv_lock_interruptible(), while the callback runs under
DMA-buf's asserted resv lock.

Hold memory_lock in the SET path while checking that the dma-buf still
belongs to this vfio-pci device and while publishing the descriptor.
Cleanup clears the dma-buf/vdev association under memory_lock; taking the
same lock prevents publishing into a dma-buf that has already been
detached from @vdev, and preserves the memory_lock -> dmabuf->resv order
used by the move path.

The attach path reads @revoked without holding memory_lock. Use
READ_ONCE() for that lockless attach-path test and WRITE_ONCE() for the
revoke/unrevoke writers to document this intentional lockless access: the
read is a benign early-out, and a racing revocation is re-checked under
dmabuf->resv in vfio_pci_dma_buf_map() before any mapping is handed out.
The annotation only needs to keep the access well-formed against the
memory_lock-protected writers.

Reject requests the device cannot consume as a completer:
pcie_tph_completer_type() must report at least
PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
gate so the feature only probes as supported when the device can really
consume it.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c   |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c | 117 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |  13 ++++
 include/uapi/linux/vfio.h          |  43 +++++++++++
 4 files changed, 172 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
index 3f11a9624b9c..4e5e34a77b76 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1625,6 +1625,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device =
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
index c16f460c01d6..7db84d27dfec 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -3,6 +3,7 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pci-tph.h>
 #include <linux/dma-resv.h>
=20
 #include "vfio_pci_priv.h"
@@ -19,7 +20,17 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
-	u8 revoked : 1;
+
+	/*
+	 * Updates protected by dmabuf->resv, @revoked additionally
+	 * protected by memory_lock.
+	 */
+	u16 tph_st_ext;
+	u8 tph_st;
+	bool revoked;
+	u8 tph_st_valid:1;
+	u8 tph_st_ext_valid:1;
+	u8 tph_ph:2;
 };
=20
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -30,7 +41,7 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmab=
uf,
 	if (!attachment->peer2peer)
 		return -EOPNOTSUPP;
=20
-	if (priv->revoked)
+	if (READ_ONCE(priv->revoked))
 		return -ENODEV;
=20
 	if (!dma_buf_attach_revocable(attachment))
@@ -69,6 +80,26 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 	return ret;
 }
=20
+static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool ext=
ended,
+					u16 *steering_tag, u8 *ph)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+
+	dma_resv_assert_held(dmabuf->resv);
+
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
@@ -101,6 +132,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
=20
 static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
 	.attach =3D vfio_pci_dma_buf_attach,
+	.get_pci_tph =3D vfio_pci_dma_buf_get_pci_tph,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
@@ -333,6 +365,83 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
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
+	u8 comp;
+	int ret;
+
+	comp =3D pcie_tph_completer_type(vdev->pdev);
+	if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
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
+	if (set_tph.ph & ~0x3)
+		return -EINVAL;
+
+	if ((set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT) &&
+	    comp !=3D PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
+		return -EOPNOTSUPP;
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
+
+	/*
+	 * @revoked and the dma-buf/vdev association are torn down under
+	 * memory_lock by vfio_pci_dma_buf_cleanup(); hold it while validating
+	 * ownership and publishing so the dma-buf cannot be disassociated from
+	 * @vdev underneath us. Lock order memory_lock -> dmabuf->resv matches
+	 * vfio_pci_dma_buf_move().
+	 */
+	down_read(&vdev->memory_lock);
+	if (priv->vdev !=3D vdev) {
+		ret =3D -EINVAL;
+		goto out_unlock_mem;
+	}
+
+	ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);
+	if (ret)
+		goto out_unlock_mem;
+
+	priv->tph_st         =3D set_tph.steering_tag;
+	priv->tph_st_ext     =3D set_tph.steering_tag_ext;
+	priv->tph_ph         =3D set_tph.ph;
+	priv->tph_st_valid   =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
+	priv->tph_st_ext_valid =3D
+		!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
+	dma_resv_unlock(dmabuf->resv);
+	ret =3D 0;
+
+out_unlock_mem:
+	up_read(&vdev->memory_lock);
+out_put:
+	dma_buf_put(dmabuf);
+	return ret;
+}
+
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revok=
ed)
 {
 	struct vfio_pci_dma_buf *priv;
@@ -347,7 +456,7 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_devic=
e *vdev, bool revoked)
 		if (priv->revoked !=3D revoked) {
 			dma_resv_lock(priv->dmabuf->resv, NULL);
 			if (revoked)
-				priv->revoked =3D true;
+				WRITE_ONCE(priv->revoked, true);
 			dma_buf_invalidate_mappings(priv->dmabuf);
 			dma_resv_wait_timeout(priv->dmabuf->resv,
 					      DMA_RESV_USAGE_BOOKKEEP, false,
@@ -369,7 +478,7 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_devic=
e *vdev, bool revoked)
 				reinit_completion(&priv->comp);
 			} else {
 				dma_resv_lock(priv->dmabuf->resv, NULL);
-				priv->revoked =3D false;
+				WRITE_ONCE(priv->revoked, false);
 				dma_resv_unlock(priv->dmabuf->resv);
 			}
 		}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci=
_priv.h
index fca9d0dfac90..063f3748478a 100644
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
@@ -128,6 +132,15 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_d=
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
+
 static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device =
*vdev)
 {
 }
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..4c1c70aac150 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,49 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
=20
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) met=
adata
+ * with a vfio-exported dma-buf. The dma-buf must have been created by
+ * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must repor=
t
+ * TPH Completer support in Device Capabilities 2 (bits 13:12); requests
+ * carrying VFIO_DMA_BUF_TPH_ST_EXT additionally require the device to
+ * report the Extended TPH Completer encoding. Otherwise the ioctl
+ * returns -EOPNOTSUPP.
+ *
+ * @dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA=
_BUF.
+ *
+ * 8-bit ST (@steering_tag) and 16-bit Extended ST (@steering_tag_ext) a=
re
+ * distinct namespaces. @flags is the authoritative validity mask for th=
e
+ * two namespaces: VFIO_DMA_BUF_TPH_ST marks @steering_tag valid and
+ * VFIO_DMA_BUF_TPH_ST_EXT marks @steering_tag_ext valid. An importer
+ * requests one namespace and receives the matching value.
+ *
+ * Each SET fully replaces the dma-buf's TPH state for future queries
+ * only. A namespace whose flag bit is clear is reported as unsupported
+ * to future importers; an importer that has already retrieved a value
+ * is unaffected. @flags =3D=3D 0 leaves both namespaces unsupported for
+ * future importers.
+ *
+ * @ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
+ *
+ * Undefined @flags and @ph bits must always be zero.
+ *
+ * Userspace must configure TPH before handing the dma-buf fd to an
+ * importer.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
+
+#define VFIO_DMA_BUF_TPH_ST		(1 << 0)
+#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)
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

