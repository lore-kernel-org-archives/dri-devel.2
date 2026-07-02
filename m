Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2322EC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E9510F559;
	Thu,  2 Jul 2026 18:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="HSNZ0lfV";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1A510F554
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 18:16:17 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662GoDVA3610654
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 11:16:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=GPg/dQpQdENuktA3H+tEQWWA4K7/QnNtIBjRw3S75wk=; b=HSNZ0lfV7A+h
 sF2kfsS98GhBL2eV+5oXpUKgTUe/hDSyTUFPAQsZp8zQt3ceE1qdArGVFQ0QEcR2
 Wgs+eeBHWNYK8P6L5c2E+ll18RCgW8qqTCnNwe+M3fk7ZI+LrCB35K/lMsqumB/u
 FkHuocpSf73VFcWZBWRfHzSUHK7vktG5DS9qady43K93Gh/Q7srigjmVTfWgcg2W
 u0fK/jdvgZFbS5aSlgyQFSsdBPStn7qOGTEqxZTQyiFgKLNJHEgSMSB/eSbLbF6L
 r5CL8X2WYKT+Jo2oE2mM3JdqBNMhU33UlE3hxjupyjwcqNZdAFOpsxJhfjQQ8C3m
 xMRgFUueLw==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f5apmfksd-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 11:16:17 -0700 (PDT)
Received: from twshared5491.04.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 2 Jul 2026 18:16:13 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id B1C5B40EEE7AC; Thu,  2 Jul 2026 11:10:28 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Michael
 Guralnik <michaelgur@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v11 2/4] dma-buf: add optional get_pci_tph() callback
Date: Thu, 2 Jul 2026 11:10:15 -0700
Message-ID: <20260702181025.2694961-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260702181025.2694961-1-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE5MSBTYWx0ZWRfX1/mkrFCb9wqK
 kk1Ljn8ZNpzwyC4MkCkz3uZUg9tWHVXsbokAYdmFsjN5Tjhd9HTmyoUvl/AvGi/WWVrazGlqxYW
 wlb0xGuregXj95ZXTOQIeh2ZwSGSk8e/ySA6p3YrObHk07bhpd6NUv5Eta+vTZnBYSHbc2Rb4Sa
 YTyjka3wI1rYWPDUjtGIgFI1GiQOytw9v+K50w07JhkL8u8fCkPszWKsO88HDmSJiYLy91pK7aF
 Y62aBd/y+FXuYu/zIgV4cCPg8ZUioFsYRgFn03j6zWCCaChoSXV3DbzQhTbPbZGpYoP9l33V6zv
 krJmDspVLsC4J8DAXL6eoCOud7tQqMbWxcV9shmQXtqAsdyTHH7Glyx2EL0c3gy8UQiMIuk9mwb
 EKiocYhgDwyvR+Jncxe0YrOZa9b1RVBQ89XClwiYLEJid+I3l5/DfvA98ysBjfT7g1gwJds1eKk
 2b7JEh4Yq0reqHOab2g==
X-Authority-Analysis: v=2.4 cv=NJjlPU6g c=1 sm=1 tr=0 ts=6a46aaf1 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VabnemYjAAAA:8 a=mECi3VIRXVL5EC2FsE4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Z10_rMRSC0UVzl_ke6zMWpLBJupKQtUu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE5MSBTYWx0ZWRfX0Xb/SVn2MyKP
 tFtdmI9w9uzOvV8G2cPiZ4ex0G049AG4nQH78DQSZEejO3wLkkiq8jicMCdF5KiRBG1zhQZDiFP
 qFmJN7Af4AhD0xHj1eyEZ7x/15Ucnos=
X-Proofpoint-GUID: Z10_rMRSC0UVzl_ke6zMWpLBJupKQtUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
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

Add an optional dma_buf_ops.get_pci_tph callback and a
DMA-buf importer wrapper, dma_buf_get_pci_tph().

TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
distinct PCIe TPH namespaces, so the importer requests the namespace it
can emit and the exporter returns the matching ST/PH tuple or
-EOPNOTSUPP.

dma_buf_get_pci_tph() is the importer entry point. It requires
&dmabuf->resv to be held while the callback runs and returns
-EOPNOTSUPP when the exporter does not provide PCI TPH metadata.

The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
mlx5 as the first importer.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/dma-buf/dma-buf.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 25 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..e8314ed240d3 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -939,6 +939,7 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
  *     - dma_buf_unmap_attachment()
  *     - dma_buf_vmap()
  *     - dma_buf_vunmap()
+ *     - dma_buf_get_pci_tph()
  *
  * 2. Importers must not hold the dma-buf reservation lock when calling =
these
  *    functions:
@@ -979,6 +980,7 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
  *     - &dma_buf_ops.unmap_dma_buf()
  *     - &dma_buf_ops.vmap()
  *     - &dma_buf_ops.vunmap()
+ *     - &dma_buf_ops.get_pci_tph()
  *
  * 3. Exporters must hold the dma-buf reservation lock when calling thes=
e
  *    functions:
@@ -1144,6 +1146,36 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
ch)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
=20
+/**
+ * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metadat=
a
+ * @dmabuf: DMA buffer to query
+ * @extended: false for 8-bit ST, true for 16-bit Extended ST
+ * @steering_tag: returns the raw steering tag for the requested namespa=
ce
+ * @ph: returns the TPH processing hint
+ *
+ * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
+ *
+ * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
+ * exporter does not implement the callback or has no metadata for the
+ * requested namespace.
+ *
+ * The returned steering tag and processing hint are only valid until th=
e
+ * exporter invalidates the current mapping (signalled to the importer v=
ia
+ * &dma_buf_attach_ops.move_notify). Importers must re-query after a new
+ * mapping is established following invalidation.
+ */
+int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
+			u16 *steering_tag, u8 *ph)
+{
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (!dmabuf->ops->get_pci_tph)
+		return -EOPNOTSUPP;
+
+	return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, ph);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_get_pci_tph, "DMA_BUF");
+
 /**
  * dma_buf_map_attachment - Returns the scatterlist table of the attachm=
ent;
  * mapped into _device_ address space. Is a wrapper for map_dma_buf() of=
 the
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..14e8eb61a62c 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,29 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_pci_tph:
+	 *
+	 * Retrieve PCIe TLP Processing Hint (TPH) steering metadata for
+	 * this buffer so an importer can program a matching ST/PH hint on
+	 * outbound TLPs targeting the exporter for peer-to-peer DMA.
+	 *
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
+	 * @steering_tag: Returns the raw TPH steering tag for the requested
+	 *                namespace
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 *
+	 * Optional callback for dma_buf_get_pci_tph(). Called with
+	 * &dma_buf.resv held. Returns 0 on success or -EOPNOTSUPP when
+	 * the exporter has no metadata for the requested namespace.
+	 *
+	 * Returned metadata follows the lifetime rules documented for
+	 * dma_buf_get_pci_tph().
+	 */
+	int (*get_pci_tph)(struct dma_buf *dmabuf, bool extended,
+			   u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
@@ -563,6 +586,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
 		    struct dma_buf_attachment *attach);
 int dma_buf_pin(struct dma_buf_attachment *attach);
 void dma_buf_unpin(struct dma_buf_attachment *attach);
+int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
+			u16 *steering_tag, u8 *ph);
=20
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_inf=
o);
=20
--=20
2.53.0-Meta

