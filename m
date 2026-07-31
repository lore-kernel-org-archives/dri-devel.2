Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E147C55172
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE59710F423;
	Fri, 31 Jul 2026 21:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="a0HFdqWM";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104C210F423
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:33:06 +0000 (UTC)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VLWsDR2307560
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:33:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=vCoC9kPvd9L9eWd1I71UR2CsPLtClId9Denx+
 viO4H8=; b=a0HFdqWMro7MinE5ctNppEbCSV18apph+UkeVVXnOtQ6EhDXJcufW
 D1PqIdndYX0TI58jA/yD/vN0jDzd+KLye8UwCiPPWf3MbyUiKTdM50lddDV1yo4/
 MGJ5vPARTpgjoPD0Q+k/kngRgEpC5sk0g+Czfb9Y4xeKjtc18rIjRZ+jfw12DcUp
 D2DkHhLEUOK5vJvnNoOo7yFU7yVy47zhBcujx7ZbOzp+aKrVVNtPiD6tdHlvkN6Z
 cyE8qWchN7zL+BjRQm2NQ8genhJtQsQ50QeRZu+Z0eIfjaKz8tFVaP68h38VRq80
 zSiOMWqTtYtDURyis8FkIXR9cnZ4VcibQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fqrkq002g-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:33:05 -0700 (PDT)
Received: from twshared14178.03.snb1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 31 Jul 2026 21:33:02 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id EBB1A43C24EE2; Fri, 31 Jul 2026 14:16:15 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Michael
 Guralnik <michaelgur@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>, Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v13 3/5] dma-buf: add optional get_pci_tph() callback
Date: Fri, 31 Jul 2026 14:15:50 -0700
Message-ID: <20260731211601.3033906-4-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260731211601.3033906-1-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=E639Y6dl c=1 sm=1 tr=0 ts=6a6d1491 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8 a=i0EeH86SAAAA:8
 a=mECi3VIRXVL5EC2FsE4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: jYl7QgmSWAtypAGdYicXEPc2j_wfyQD7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX/ZjdJ1+JMz1M
 Gyk17NJfPzjLPg1DpsE2iaaPP71XFHip2m1lpyJZM/gKVMgctn8dHVjcibgg0bMZwGWu7lzH/aW
 cWUsWZIaV/I27wvVcbV8igJfgOAPh3g=
X-Proofpoint-GUID: jYl7QgmSWAtypAGdYicXEPc2j_wfyQD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX8pxMSvhs/zCM
 dJgnZUrhtvAN6GonxmJPEt+rTrKswCQImmNXV72/pXoUwuHRCRw+BhaxMctGWKLWrDhDnnS9sw+
 jujOpyQXow31mfT72wcIJgIt1uutLHy/kDKnkki2injwD3BLf2kmRb1ByPndGODGjJvXdGeKy0c
 WkFowZaF4QPW5IenpLFOtS4d0i0eYdiHS28kpmQsUB5lskuHW1ALwmSjSexe5Y1yeU6fjaSIRMM
 8OAIS4CIuDgDRDLhTOTHYe0cfKgOqFlX2NBks2rIz6Q4k1s4Vpfd7tTvxpVJBLVj9ipXHBIW/oH
 SUpNWxq6D1NDRXnF/UgUJCS47MkOCWp3NfHq1ZBrFw5jf8YnMxer7PZCMDt+D0g+lni2+ZkazqA
 HNcygiwSYt6nS1iEsGAzc52Htg1Zf4DvL0U1H9rdz6xTK6xg7kWcjfe4vD4gyQ91MSvjjlQFXmI
 yXiySpoIm7z3r3izqAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01
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
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/dma-buf/dma-buf.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 25 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..71f335442ba7 100644
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
+ * &dma_buf_attach_ops.invalidate_mappings). Importers must re-query aft=
er a new
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

