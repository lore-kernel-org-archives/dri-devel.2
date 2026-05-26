Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C03CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 15:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A10810E20C;
	Tue, 26 May 2026 15:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="NYkPXJUV";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A1010E20C
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 15:31:42 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q3Ne8c820802
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:31:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=NjjuGBs/GaZZnJ1qzo3XYstQajuQ7o6yqaqfiOeKhcU=; b=NYkPXJUVwY8w
 xHOp2wQMcH0s1ahyrquQ9DTI3jR5/On8cq7v+G6B01OgYbCgFrOP9xtVzC8e/Dft
 DGuOOk7xQyclT6ZlBzz3mNqp897Fhtg0zvaiWx2uH7urujOktKaf/LW9lx1D1qfn
 k5VRWjU6Sl7EOWq6Yjdm9WjoKIHYa4zAICYKzeKiuk5fojwht3dDbEV+oQ64YG3x
 1ERQyJZxRYs0eeal9QSy/KJAtqaFTvy8Fx+WeGrA8OrR8lF672cBVrU3RYgtwH9q
 IcyCW1m8znwxadQqlTORMyAZAssKGOd4eEBw+Tmy7d3wd+NQvlhvRrX7j8Fu0gWS
 bZnpcfYf1Q==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eb9wyxsek-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:31:42 -0700 (PDT)
Received: from twshared124658.16.frc2.facebook.com (2620:10d:c085:208::7cb7)
 by mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:31:40 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 388FC35B01D89; Tue, 26 May 2026 07:44:08 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v5 2/4] dma-buf: add optional get_tph() callback
Date: Tue, 26 May 2026 07:43:54 -0700
Message-ID: <20260526144401.1485788-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526144401.1485788-1-zhipingz@meta.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bhu0irFl80Dq_6CmMT7fU8yYcVuJf9RD
X-Authority-Analysis: v=2.4 cv=NY7WEWD4 c=1 sm=1 tr=0 ts=6a15bcde cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8 a=y7wLlh4LprZ0846ZMF0A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: bhu0irFl80Dq_6CmMT7fU8yYcVuJf9RD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzMyBTYWx0ZWRfXwKhf7sxbte4F
 I9oBqfZXUNZ7F38Biy4nTUJA+YCWx926JB3JPKsAkxC6pg/VL/5rx/NqDRo3gXelx4FVr/xy6Vh
 u7VTj30n7KhZ9T/zUFIK4+/kvIOxh5mn0rSSTifZdu1A0LPwGOD7+cs0IYFUAMCS+OtD01XuXio
 EI/aMKj9y87nPJohu8LzQpbiNgYe5gzuycfeUgLWoIrHgKpWbLh5vTCUIsrbBwHBVxNB2L9zENr
 RfBqNvCsroXCbMIr6IxExNAtSSH2KEbLLcD6E5u1SihejtWfrMpIPFAU7OxEfRp8sdhzZ7CRPcU
 /PWKyPkodEqwL86zBUkmkz/ppYOF+TZiS9Wz5palsbRd3GKUTGsWD0PO7uUYauKeuA/IWIliWc0
 ByKJ/rysEk17Vou3y++4Wu+2SLqHYI8E44bfnx+5AKUy7uaSvpK+TsDoemCxEzSDBnhj5ZaKVnU
 RXi6w5nHuLffAEv7bXg==
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

Add an optional dma-buf get_tph callback so an exporter can return TPH
(TLP Processing Hints) metadata to an importer.

8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe TPH
ST table and may both be present with different values. The importer
passes its supported steering-tag width and the exporter returns the
matching value, or -EOPNOTSUPP if no metadata is available for that
width.

The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with the
mlx5 RDMA driver as the first importer.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 include/linux/dma-buf.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..49eb6ad644a2 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,27 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_tph:
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @steering_tag: Returns the raw TPH steering tag for @st_width
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 * @st_width: Consumer's supported steering tag width in bits (8 or 16)
+	 *
+	 * Return the TPH (TLP Processing Hints) metadata associated with this
+	 * DMA buffer for the requested steering-tag width. 8-bit ST and 16-bit
+	 * Extended ST are distinct namespaces in the PCIe TPH ST table and may
+	 * both be present with different values, so the exporter must select t=
he
+	 * value that matches @st_width and must not substitute one for the oth=
er.
+	 *
+	 * Return 0 on success, -EOPNOTSUPP if no metadata is available for the
+	 * requested width, or -EINVAL if @st_width is not 8 or 16.
+	 *
+	 * This callback is optional.
+	 */
+	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
+		       u8 st_width);
+
 	/**
 	 * @map_dma_buf:
 	 *
--=20
2.53.0-Meta

