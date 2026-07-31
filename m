Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579AAC55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA11D10F422;
	Fri, 31 Jul 2026 21:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="BerzG1Vs";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3745C10F422
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:28:10 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VKWY5d1888568
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:28:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=dawVXRLF7As82TJE534FIW9bleOAb90pEt/+G
 KEnD4M=; b=BerzG1VsMnrADddeoL6y7rY/DFS4fLOrGJh4YfQ6cZwMF5ABZ6Cyv
 yYLpsdWy/h0cbr0GfRK5lMBbnmlIPk6FtorIXMOJ0KRI4ZVQalgMJ9ez3oR7OEv+
 B0UTwhNcBgD5YRuwhqkmKtPygA4hjH2fbRrdplR22E3+fhMf9URhfSwXfZr4ZwKw
 TymTq0L9i6Lj6NsiVa2BBK3Kxzm37niZkPo/Os8jxws3L+cfAPhbiPkNXLGF6yAW
 kkq7IfCzmy+qxJdwLcnf/x/lbQ9p2l1lcPn7pJT1S46zu6sa5cpOtHAFoz+7BZ32
 lUVyUkzelPp391656YfWwN7F/pPAEzUYw==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fqrj2qxrg-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:28:09 -0700 (PDT)
Received: from twshared98642.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 31 Jul 2026 21:28:07 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 69EC343C24EC8; Fri, 31 Jul 2026 14:16:15 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Michael
 Guralnik <michaelgur@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v13 2/5] PCI/TPH: Add requester/completer type helpers
Date: Fri, 31 Jul 2026 14:15:49 -0700
Message-ID: <20260731211601.3033906-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260731211601.3033906-1-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ldsaJ3m0Muz13RJJrwbrYDBeS_zr7Zar
X-Authority-Analysis: v=2.4 cv=QuhuG1yd c=1 sm=1 tr=0 ts=6a6d1369 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=WR4Jl2Km8_0e0mXVxbYA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX3E3DWea/bCDn
 0B4tO8/KX0+MAasbbRo6DNuIB56qSHfUMFrONPeALM4yxaazJZDL5Bq8avQEP2sYt7kzdqyYRFp
 pzvjEnG1lq+i0SgtEyLhFqPhhKY4bNnTj6EP4EcMAT331TDgIanNrhaDffQ2IbIgT6Cy29El1ry
 mQso92z/8foyaZify/xDrWVA3PSbx9LdD2ztHGOjDbacpBn8qNnnUmQLaNKQIVRqSUyAyz47ZBD
 ywgwQawRpV2ZZxH4MdDYfH0IvG0FeOwUrmmN3PEsFapRHR1/B+tK7+YvEDuEhlOg9hU12hsYb9p
 O4Wu4BpLLbDc/HSE4xrTFT6x46dUG2aRkGNnDnU5Ks/WQ+NGHNnKNj5yeAjoZqpPLL8HkQipOYO
 EujHiKYD+9HJWNv1vF8sKS5PgAIjo7Tjv/q3bYOHZQH7lgLoKoxfL6Bmn5oeBNrNBbPgQE7f7uj
 BcMs0J7xEWX0fVff6eg==
X-Proofpoint-GUID: ldsaJ3m0Muz13RJJrwbrYDBeS_zr7Zar
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX32LvOOS41VqQ
 Fgyg2NCWISxWuOy216CVni6soe0pIggqXhO9f5PlU/9v9XF170kDSSrqnYyXcvvDisVYIt+/YvC
 tH5/RvIUdhTRpq7++5cNKXx6xdFGWoY=
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

Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
requester mode without reaching into pci_dev internals.

Add pcie_tph_completer_type() so drivers that publish TPH metadata for a
device acting as a completer can gate on the "TPH Completer Supported"
field of Device Capabilities 2 (bits 13:12, PCI_EXP_DEVCAP2_TPH_COMP_MASK=
)
rather than reusing requester-side state. It applies the same reserved-
encoding fold as get_rp_completer_type(), inlined, so the reserved 0b10
value never reaches callers.

This keeps pci_dev::tph_req_type and the completer-capability decode
inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c       | 44 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  8 ++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 5cbb381e2a02..d0202ff7a1b2 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -223,6 +223,50 @@ static u8 get_rp_completer_type(struct pci_dev *pdev=
)
 	return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
 }
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
+	u8 tph_comp;
+	u32 reg;
+
+	if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+	if (PCI_POSSIBLE_ERROR(reg))
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+
+	/* 0b10 is reserved; fold it into "not supported" (see above). */
+	tph_comp =3D FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+	if (tph_comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY ||
+	    tph_comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
+		return tph_comp;
+	return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+}
+EXPORT_SYMBOL(pcie_tph_completer_type);
+
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
 static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 ta=
g)
 {
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

