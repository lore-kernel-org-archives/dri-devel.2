Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E968CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 15:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826DE10E50C;
	Tue, 26 May 2026 15:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="s651LwtE";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4B510E506
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 15:31:44 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q3Ne8f820802
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:31:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=XNoBiHILo2xfhk1gyCU/EOdOIWe77gslqFadpuBRrVU=; b=s651LwtEog/0
 VCCLmu7muqs8vjfx6fSWV8DDSraMOw97NnVrN9H9F6ax/OLb5F9d+l+HPym5c/OR
 sNSm2wLjf16lmrggj58INV3iN/Q5eLhlC/J/FgHr27bWDPRBWexn1n3i24kb4ahi
 MnBL4funyN0by2VrSgh+Y0x30oSUxUefu4+/MPvvGV/Vj5SfXDjJp1F4n7D6gFnf
 O3tCPipoZuY2XXJ3RqF6XgUcyjHRtiguLm1ZfdSna+5NOq8GU2pQHYrgnf4BMFOd
 822QCyCPRwG/tnrh5j8iL2zVKPGzrzDKGwMCurNAh8T504T4U0vyitaWazPqGkNt
 tgW6CsrWLQ==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eb9wyxsek-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:31:44 -0700 (PDT)
Received: from twshared124658.16.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:31:40 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id B753A35B01D80; Tue, 26 May 2026 07:44:07 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
Date: Tue, 26 May 2026 07:43:53 -0700
Message-ID: <20260526144401.1485788-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526144401.1485788-1-zhipingz@meta.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AJP4I92E-YiCIktaLuTV1zT2044TPd0z
X-Authority-Analysis: v=2.4 cv=NY7WEWD4 c=1 sm=1 tr=0 ts=6a15bce0 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8 a=YRoFvhOfcVPyCIBj9wAA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: AJP4I92E-YiCIktaLuTV1zT2044TPd0z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzMyBTYWx0ZWRfX2qZo1KIg0HP2
 HW0YerLma78nwLYdfDn0TviVrwp23HEpeKzcvKNZXctfZ5DNAwSPIbJlyHzyb+LXim+4cM00LZN
 gnXVfOVfXLCfkt7GeajBnMnuDzVkFoLQBAXbEGEm3qPeawDkIBSc6nzhsQP5Lxu5qIDksx4L5rB
 iB6d0n3EVf9v5zzTJ6YgSXRww6FhriP6Q5l5i86va+N9de40yDnSgmNTICN06uINenOYXS9zp2Z
 nP3WItFsys13Xk5pKVK9SOY9M22ABaSdJSEwBmT9dFsQ+IMDBay6QLtCkr+whu6R2huuqcYV23T
 5SVQuTvL2rgHofmXx3mzFjc6Yo5DtUERdo2tRb73WXaLyMKqn+/muXHBK50Lchf55Pp23l7PSj8
 FoNXRVQa/BcS9WNN1ZF/R6hQLpmV/5+J5LS+0uZse8bZ5klW24sBKsGwFrcWJHOIotn20yeE0rC
 ZQuqeQ+VLBkiCOqIjsQ==
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

Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
requester mode without reaching into pci_dev internals.

This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
!CONFIG_PCIE_TPH stub for callers.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c       | 12 ++++++++++++
 include/linux/pci-tph.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 91145e8d9d95..6c4492075ae9 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
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
 /*
  * Return the size of ST table. If ST table is not in TPH Requester Exte=
nded
  * Capability space, return 0. Otherwise return the ST Table Size + 1.
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index be68cd17f2f8..fe572737b409 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
@@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *d=
ev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { retur=
n 0; }
 #endif
=20
 #endif /* LINUX_PCI_TPH_H */
--=20
2.53.0-Meta

