Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1021CD98C5
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE46210E4C8;
	Wed, 10 Jun 2026 20:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="qkYU3WCp";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FAA10E4C8
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 20:03:47 +0000 (UTC)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJajWx2132236
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 13:03:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=mjV1JPJZgyO6zER9smScw/osP/KPl9XPFLfl/CjHm9Q=; b=qkYU3WCpwxJI
 ifHo8IpKF4iO88LNKskApNkbkoPFomwQVvPqqdLiBFJ+2Y5pac06JRVW/mVxs99d
 YZfToUU80/AH/eAsz481oPlGinKKVj06yc+dp4qPwwxamSPAYDKGaGGQ8Yn2XaH7
 fOjU4zVVxo7ewSSpwDXKGAPDr0uZKPuJ+OeLaRBhXzxH22XFBjSAgjSyjTFebvUZ
 TK9kcywzYk9pttQzn5QtYdGeCysAfaykk/t+jlvCMrQIo3DhGiQUfm619lo5mSW0
 5pWM4kBEqVVkbNzfLSmOikPIVeW79A1WNe+UZ9ZDl9ka3B8szQDXrpDWVrfhmHgx
 xTEHGbr8xA==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe81g690-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 13:03:47 -0700 (PDT)
Received: from twshared5616.02.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 10 Jun 2026 20:03:44 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 3D35B3D7AB633; Wed, 10 Jun 2026 12:32:05 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
Date: Wed, 10 Jun 2026 12:31:51 -0700
Message-ID: <20260610193158.2614209-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610193158.2614209-1-zhipingz@meta.com>
References: <20260610193158.2614209-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE5MCBTYWx0ZWRfX16VIOnTe5aTQ
 dMQXR3u59wKt1soIFTm500X6rjgtc7hmcdSWHH2jq4Y8h0Mdgjc10tyRJND5GJ56cNYVIgalC9d
 TFdhhUSyCkP9Zar0zrG56Gqmx+mFm8WCg6RbjUHaRUyzSi244+c7vN3AHoXKozz6x1Gyga8mAgx
 KUvjBIFohezSCp9xuIemc8dy3un7JvP4cicXQVeOK2iX+IM52mexsgwC3udNhX03wvEH7p2OJxy
 rsFkPmPwtMBt7lf9ieAZIb5kzcJsaeOzjavkfq0eeH3yOAw6RSw1vrvif4GEcTVvKJ+HlqTRosD
 pzCPdqVCcvde7a7dRvhx1K+TQNFHWL7zRkQT1QzqUsfWrKoQPf0Z+F3Lq1HObInoUhwfiIAZ+3W
 ndQl0Ij4GZkBuHlZbvqOvyUe65li9nH/ifofr1yY8pmejF738HuqYY2OPLSxQ/tqt1rjwIByGvO
 dM/q3CK/haJ/G03dvlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDE5MCBTYWx0ZWRfXzZ2/UNZf//cx
 9jOb1I7Ma+Ksk48L59ai8JOgTxs5gkOmvx365M2+GTQr76xKU71ziN+vSdqRFza9vS6mSpdkCcW
 nJ6Nx7BGXZ49WRB4jQJgjmWvlI2pIo0=
X-Proofpoint-ORIG-GUID: T9hjJbyi8Cb31gMTFJgLsUfQkLI8dIYu
X-Authority-Analysis: v=2.4 cv=ToXWQjXh c=1 sm=1 tr=0 ts=6a29c323 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8
 a=K7z10gKaAp536EQdUv4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: T9hjJbyi8Cb31gMTFJgLsUfQkLI8dIYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
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
requester mode without reaching into pci_dev internals.

Add pcie_tph_completer_type() so drivers that publish TPH metadata for
a device acting as a completer can gate on the "TPH Completer
Supported" field of Device Capabilities 2 (bits 13:12,
PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
state. Fold the reserved 0b10 encoding into NONE so callers only see
the defined values.

This keeps pci_dev::tph_req_type and the completer-capability decode
inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
callers.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

---
 drivers/pci/tph.c       | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  8 ++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..4fe076bba953 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -174,6 +174,49 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
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
+ * pcie_tph_completer_type - Return the device's TPH Completer support
+ * @pdev: PCI device to query
+ *
+ * Reads the "TPH Completer Supported" field (bits 13:12) of Device
+ * Capabilities 2. The reserved 0b10 encoding is folded into
+ * "not supported" so callers only need to compare against the three
+ * defined values.
+ *
+ * Return: one of %PCI_EXP_DEVCAP2_TPH_COMP_NONE,
+ *         %PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY or
+ *         %PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH.
+ */
+u8 pcie_tph_completer_type(struct pci_dev *pdev)
+{
+	u32 reg;
+
+	if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+
+	switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
+	case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
+		return PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY;
+	case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
+		return PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH;
+	default:
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+	}
+}
+EXPORT_SYMBOL(pcie_tph_completer_type);
+
 /*
  * Return the size of ST table. If ST table is not in TPH Requester Exte=
nded
  * Capability space, return 0. Otherwise return the ST Table Size + 1.
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..7743af6fe432 100644
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
+u8 pcie_tph_completer_type(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -41,6 +45,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *=
dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
+{ return PCI_TPH_REQ_DISABLE; }
+static inline u8 pcie_tph_completer_type(struct pci_dev *pdev)
+{ return PCI_EXP_DEVCAP2_TPH_COMP_NONE; }
 #endif
=20
 #endif /* LINUX_PCI_TPH_H */
--=20
2.53.0-Meta

