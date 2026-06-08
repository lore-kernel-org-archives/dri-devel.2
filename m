Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C27CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0743210F921;
	Mon,  8 Jun 2026 19:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="va7kZ5vp";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03E310F921
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:38:15 +0000 (UTC)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658BiKdT2461587
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 12:38:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=Slt/f/kti5jSkjQ05HhKPnhN3PF1Ignk8RONn40F3Cc=; b=va7kZ5vp8tqf
 u1dsFHwHccErX5in2SHrSI4S7y9ANDeFYW8PDAt1GbhVgoKY4liDw6VBvcw+WDJi
 q5vHawcwlS3ka6C471c4TYJjYPD5QA7MNH9WqK5i6UtT0P0gPDxgIXMQkjgRz8kz
 gnrVIeU3DzIP0BXSHgaY1n3JK22WpAVe4VrnjMWslK0D1QuHtsgdOc0A6JqEZ41M
 K5rnglChJ6ZcVXiSiHArO+dWC+L2livnUYLMxloIxs9EK7GpDDAUvnIfHZxoM2m3
 p1ju94LdGCUKV1/UHhy0dpJK8FK6kfTJZ1bbRkAnIz4Cv4BeppbYe3wrJkrm9lcm
 4NlbWP0IeA==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4emjum2qtc-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 12:38:15 -0700 (PDT)
Received: from twshared2149.04.snb1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 8 Jun 2026 19:38:14 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id EEFA33CC10134; Mon,  8 Jun 2026 11:56:48 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v6 2/5] PCI/TPH: expose enabled requester type and capability
 helpers
Date: Mon, 8 Jun 2026 11:56:39 -0700
Message-ID: <20260608185646.4085127-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608185646.4085127-1-zhipingz@meta.com>
References: <20260608185646.4085127-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Fvk1OWrq c=1 sm=1 tr=0 ts=6a271a27 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8 a=YRoFvhOfcVPyCIBj9wAA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: kOKZrxLAGWR2v78qTWlZsX1VePKvmQfx
X-Proofpoint-ORIG-GUID: kOKZrxLAGWR2v78qTWlZsX1VePKvmQfx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3OCBTYWx0ZWRfXyMSFXD9iaxG0
 9r86IHUBppAD+zC0lX0r5tNXGg57w1wUaiJ2azAPzmqMsD0+p4uDqaZrzE3AhfXk7ASMI524x87
 hzkIx1uxljzUJ9jjcy1G98PPIwpHSBTnq1yiRlwrwOIWvC4Sr0hyFFYZtGB4uwQTsG6S7Cv/b5p
 igtV4k7kP9RhrNg4aYpdiilHX4mRk1bTtKE9zQHfWxeze4RO+fgSDESXEC0rg7/7kuDPeD8wWkb
 BozEkEJXUdox61QmUgX2iGMFfapKK+X1e0ZQ5gZ2v9YPlS0OyoAgWXW79tqfm+r+zKtgIkWxA+r
 NsK8NzUGL9uv+hdmtJ6bCviO62qJe3hpL8+wrS2ZfY/C2wsDo/VqZjCNv7Bklye1RMKQGSRLL+m
 LVrj24+d3ikilgHY+O61bDdrmNqxPTzj3DfSE7kals3frS0CmE5s6kiD7Qe+bujz8lN+nNOIfUF
 3m6J0+iohdWkaBY5Byg==
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

Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
requester mode without reaching into pci_dev internals, and
pcie_tph_supported() so they can test whether the device exposes the
PCIe TPH Extended Capability without doing the same.

This keeps pci_dev::tph_req_type and pci_dev::tph_cap inside the
PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c       | 25 +++++++++++++++++++++++++
 include/linux/pci-tph.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..aa09113c46d4 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -174,6 +174,31 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
=20
+/**
+ * pcie_tph_enabled_req_type - Return the device's enabled TPH requester=
 type
+ * @pdev: PCI device to query
+ *
+ * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_=
TPH.
+ */
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{
+	return pdev->tph_req_type;
+}
+EXPORT_SYMBOL(pcie_tph_enabled_req_type);
+
+/**
+ * pcie_tph_supported - Whether the device advertises the TPH Extended C=
ap
+ * @pdev: PCI device to query
+ *
+ * Return: true when the device exposes the PCIe TPH Extended Capability=
,
+ * false otherwise.
+ */
+bool pcie_tph_supported(struct pci_dev *pdev)
+{
+	return pdev->tph_cap !=3D 0;
+}
+EXPORT_SYMBOL(pcie_tph_supported);
+
 /*
  * Return the size of ST table. If ST table is not in TPH Requester Exte=
nded
  * Capability space, return 0. Otherwise return the ST Table Size + 1.
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..2e07bce77038 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,6 +9,8 @@
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
=20
+#include <linux/pci_regs.h>
+
 /*
  * According to the ECN for PCI Firmware Spec, Steering Tag can be diffe=
rent
  * depending on the memory type: Volatile Memory or Persistent Memory. W=
hen a
@@ -30,6 +32,8 @@ void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
+bool pcie_tph_supported(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -41,6 +45,9 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *d=
ev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{ return PCI_TPH_REQ_DISABLE; }
+static inline bool pcie_tph_supported(struct pci_dev *pdev) { return fal=
se; }
 #endif
=20
 #endif /* LINUX_PCI_TPH_H */
--=20
2.53.0-Meta

