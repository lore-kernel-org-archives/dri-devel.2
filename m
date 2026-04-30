Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A89CD13DA
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2DD10F44D;
	Thu, 30 Apr 2026 20:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="ce6O/wDv";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032BD10F44D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 20:11:29 +0000 (UTC)
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UDBBNv518622
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:11:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=XO4gDs/Vlu99NfyVjj4NXutxQm8yt30Ut2WY5+A6e1s=; b=ce6O/wDvLzBW
 0tXIMu+id8OHvF0uHfUJEwOb97wJkuDhA4Jx5PCEzqDTQR2hqn4xpolTHrydAvny
 aA7QQDuMybLgvYqAhanYSC5TeaDxwBFN7bvU4dAqmpQLTld3yJppy4gUjUGw76pR
 xRIH9rTbGSSMNCR6ZrxV3X015hkYR6ZROFEQ3keoqFWxHvRIpD+rkyLk97B2aOLh
 RTqmG+hy9lFWNT6thNGodRXaXBhQnVzftJmJwJZawTEAV4Itwium/iSkXfsLyPKx
 SlJnMqsDYqnP+6c/7SBWortbHIRJt3ZYhKZAtS11FszZkICU68F7oXyn3+tGCeHP
 vP9heifzgA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dsf6p8rjn-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:11:28 -0700 (PDT)
Received: from twshared26632.02.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 30 Apr 2026 20:11:26 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 919901B9B4FCA; Thu, 30 Apr 2026 13:07:05 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Zhiping Zhang
 <zhipingz@meta.com>
Subject: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH
 feature
Date: Thu, 30 Apr 2026 13:06:56 -0700
Message-ID: <20260430200704.352228-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430200704.352228-1-zhipingz@meta.com>
References: <20260430200704.352228-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIwOCBTYWx0ZWRfX+7/oASmFwJFt
 ezEDOIY+OQSuX2xlJ0aztBS87UzvbWzEuhUEfzJoibDLZX7V+1JfnwKJzcA76Fv+6aEU73/gTjP
 Pp6K138E1rHn0OPQNt0BFaIrOyyH77pQpd8kMEei01yKwXMivOS1INjv7oUEu7Cqv/sunQbsv74
 WnTqyfFxMsKHgjnntC0MMfZ936JJLg5ddkFPTrA94a2Nfn2csp9ucAt/QmfJVavpUGcLrJ7kgXu
 rmFtcp8pSEOHPZ6M9LKATtS52ShMB4BzDdJlVqDpqGj7d4xZ49i942MCqYvhTBq3aYfVmnRkdp6
 Sy/XwG8bJCx+ngtskzDT5L88plZ386ogKGxhDcMIY1QRGHqzsIe5nIyXekEO3Zk9OEc2HhukNhw
 u0pBkhzVzi1rFumPTVb2A1D5MrpuafOZul2acsE8NEOQG7yumCwNLtEgb/6yvLXNQaqvduUCLPi
 hxuEoRgGFUM+ESVlOiQ==
X-Authority-Analysis: v=2.4 cv=Cfo4Irrl c=1 sm=1 tr=0 ts=69f3b771 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VabnemYjAAAA:8 a=I2VOSbTcSc4ADjQXWK4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: J65JKkLu8e1LQAMLvML-aSmiYstQXL25
X-Proofpoint-GUID: J65JKkLu8e1LQAMLvML-aSmiYstQXL25
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

Add a dma-buf callback that returns raw TPH metadata from the exporter
so peer devices can reuse the steering tag and processing hint
associated with a VFIO-exported buffer.

Add a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
VFIO_DEVICE_FEATURE_DMA_BUF along with a steering tag and processing
hint, validates the fd is a vfio-exported dma-buf belonging to this
device, and stores the TPH values under memory_lock. This keeps the
existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI completely unchanged.

The user sequences setting TPH on the dma-buf before the importer
consumes it.

Add an st_width parameter to get_tph() so the exporter can reject
steering tags that exceed the consumer's supported width (8 vs 16 bit).
When no TPH metadata was supplied, get_tph() returns -EOPNOTSUPP.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device =
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
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -19,6 +19,9 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
+	u16 steering_tag;
+	u8 ph;
+	u8 tph_present : 1;
 	u8 revoked : 1;
 };
=20
@@ -69,6 +72,22 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 	return ret;
 }
=20
+static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steerin=
g_tag,
+				    u8 *ph, u8 st_width)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+
+	if (!priv->tph_present)
+		return -EOPNOTSUPP;
+
+	if (st_width < 16 && priv->steering_tag > ((1U << st_width) - 1))
+		return -EINVAL;
+
+	*steering_tag =3D priv->steering_tag;
+	*ph =3D priv->ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment=
,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -101,6 +120,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
=20
 static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
 	.attach =3D vfio_pci_dma_buf_attach,
+	.get_tph =3D vfio_pci_dma_buf_get_tph,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
@@ -331,6 +351,55 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
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
+	if (set_tph.reserved)
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
+	down_write(&vdev->memory_lock);
+	if (priv->vdev !=3D vdev) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
+	priv->steering_tag =3D set_tph.steering_tag;
+	priv->ph =3D set_tph.ph;
+	priv->tph_present =3D 1;
+	ret =3D 0;
+
+out_unlock:
+	up_write(&vdev->memory_lock);
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
@@ -128,6 +132,13 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_d=
evice *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
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
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,23 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_tph:
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @steering_tag: Returns the raw TPH steering tag
+	 * @ph: Returns the TPH processing hint
+	 * @st_width: Consumer's supported steering tag width in bits (8 or 16)
+	 *
+	 * Return the TPH (TLP Processing Hints) metadata associated with this
+	 * DMA buffer. Exporters that do not provide TPH metadata should return
+	 * -EOPNOTSUPP. If the steering tag exceeds @st_width bits, return
+	 * -EINVAL.
+	 *
+	 * This callback is optional.
+	 */
+	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
+		       u8 st_width);
+
 	/**
 	 * @map_dma_buf:
 	 *
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,28 @@ struct vfio_device_feature_dma_buf {
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
+ * steering_tag and ph are the raw TPH values that importing drivers sho=
uld use
+ * when accessing the buffer.
+ *
+ * The user must set TPH on the dma-buf before the importer consumes it.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
+
+struct vfio_device_feature_dma_buf_tph {
+	__s32	dmabuf_fd;
+	__u16	steering_tag;
+	__u8	ph;
+	__u8	reserved;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
