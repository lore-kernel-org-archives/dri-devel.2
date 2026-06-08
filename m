Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671C8CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45B410F8FC;
	Mon,  8 Jun 2026 19:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="PTLsBZ3X";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0554C10F8FC
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:17:03 +0000 (UTC)
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65810GRZ1862310
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 12:17:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=lDYiZf89tMB/jY2Oi7bqvG5rG/l6tpRDvVzGXtZAUes=; b=PTLsBZ3XR+MR
 YUKNHipEwWjhXpYJP4ZfYH1VZhSEXa8fu3PxTAqKxY2hbyXDKRWhtbB0iLSKhUux
 RyLC4TmlLBXZVbW1JTH29dK+ptRp0gzRVM3NC3Ke2pJrcr3CsbLxeGTSQtYJTIzb
 rf23+qNcwNGZRWSI0nwTMklahxR4uiEMgUDDUS/1m9PI7GsQ1tXBxowdkW6RSjYM
 Y9MqkLvFJJpwel7ZmIyk8Iw6Zsom1CVUi3wk0DusI/Ay2eREQ2G9TeEdxmrkcOKn
 ESzZF6ELZ6qRIn4LplKoKYHDqVQyKnfOG1qbhHxnPvBEA6pCNMY1vt3G6txq9SP6
 Y+ErFQlLYQ==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en5a5fetx-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 12:17:03 -0700 (PDT)
Received: from twshared9540.02.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 8 Jun 2026 19:17:01 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id BB19F3CC10149; Mon,  8 Jun 2026 11:56:49 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v6 3/5] dma-buf: add optional get_tph() callback
Date: Mon, 8 Jun 2026 11:56:40 -0700
Message-ID: <20260608185646.4085127-4-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608185646.4085127-1-zhipingz@meta.com>
References: <20260608185646.4085127-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iWlYvGMGICFfXz7QCDb9es-MhWj-WKul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3OCBTYWx0ZWRfXyvCkDxsPrcMl
 nYT02yDJx1qBi5XomReF1po33bEZVXL+O+kobL6ABBoSGYirks+n4IGNnWJD2aN9womCtBnf8t2
 ir39TW3qWDZTeHCaj7d1BeMOfpHfIZo7Q3tE0eC2bPYMY/0VLC5nhRT2XI9nt4UBwAYnZXeoLV7
 ZOOO8re4QgbJjYhwsucjohhDZ2Z9c2BP0dHh4U03TlHW9ZewpijeEfd82H3xfKApOaE29rwveyD
 2uNKxvR65OauM6fjllhjofG9VGejjgd1RJFufaLnuJ5CcxMzhyrOpzU6IvMOSNVgn1EqfCnP/25
 hlyDajb9lOC3nPVC4KsNFYcWO5RpKfc3j/MAtSHBqAD1sjQVS6Nc8r5eOYZc6NxzYW8pDTbZKgC
 rpTwyXo8l24F2BBteGUwFw3Up1H+pEzP9GxybKj6NrX5W2GU8FIXCXlxLByUodqLJVju/kHyXWz
 bOLdhrHdClPFFc3m8eQ==
X-Proofpoint-GUID: iWlYvGMGICFfXz7QCDb9es-MhWj-WKul
X-Authority-Analysis: v=2.4 cv=ZKLnX37b c=1 sm=1 tr=0 ts=6a27152f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8 a=VCL5LVowTDoYIPPXMCYA:9
 a=gKebqoRLp9LExxC7YDUY:22
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

Add an optional dma-buf get_tph callback so an exporter can return TPH
(TLP Processing Hints) metadata to an importer.

8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe TPH
ST table and may both be present with different values. The importer
passes its supported steering-tag width and the exporter returns the
matching value, or -EOPNOTSUPP if no metadata is available for that
width.

The callback is intentionally exporter-owned and optional. The exporter
owns the completing address space for the dma-buf, so only it can decide
whether it has meaningful TPH metadata for that completer. The dma-buf
core keeps the returned ST/PH tuple opaque and simply provides a
discoverable negotiation point between exporter and importer; exporters
that cannot derive a useful tuple just return -EOPNOTSUPP.

That keeps the kernel API generic rather than VFIO-specific. The first
user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with the mlx5 RDMA
driver as the first importer, but any future exporter that can derive a
TPH tuple for its completing address space can reuse the same callback.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 include/linux/dma-buf.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..8437dbe4a83e 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,37 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_tph:
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @extended: false to request the 8-bit ST namespace, true to request
+	 *            the 16-bit Extended ST namespace
+	 * @steering_tag: Returns the raw TPH steering tag for the requested
+	 *                namespace
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 *
+	 * Return the TPH (TLP Processing Hints) metadata associated with this
+	 * DMA buffer for the requested steering-tag namespace. 8-bit ST and
+	 * 16-bit Extended ST are distinct namespaces in the PCIe TPH ST table
+	 * and may both be present with different values, so the exporter must
+	 * select the value that matches @extended and must not substitute one
+	 * for the other.
+	 *
+	 * The exporter owns the completing address space for @dmabuf and
+	 * therefore decides whether it can derive meaningful TPH metadata for
+	 * that completer. The dma-buf core treats the returned ST/PH tuple as
+	 * opaque transport metadata; importers that support TPH place it on
+	 * outbound TLPs, while exporters that cannot derive a useful tuple
+	 * simply return -EOPNOTSUPP.
+	 *
+	 * Return 0 on success, or -EOPNOTSUPP if no metadata is available for
+	 * the requested namespace.
+	 *
+	 * This callback is optional.
+	 */
+	int (*get_tph)(struct dma_buf *dmabuf, bool extended,
+		       u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
--=20
2.53.0-Meta

