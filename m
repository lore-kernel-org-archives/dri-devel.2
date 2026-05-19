Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C7FCD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 20:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1153810E3E8;
	Tue, 19 May 2026 20:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="MtUMjghr";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CC910E3F0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:25:26 +0000 (UTC)
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JKJIMJ3374386
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:25:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=rbYQZfT6xz9UhXToVb8wAi/NM8rY7U8L5aP4mxh8ef0=; b=MtUMjghr/Ra4
 BYZTh/gh7rLL8iSFD01ZRiUU0lM5+FjgixhztW4Lq8CLxVsfHyAbgZXmqPoc/Eca
 QbiImoM326mVvAGWiAhiBM9z6T5HCYc32EocwLvtbpUrBniLkIvkd9hQDUri+xqs
 X+tSgcvBEajUxSI5QMD+jWSJs1priMPz+Zo5bcr5U1VyFW9QwlUho4RI7hpWli5B
 /JpNdlj7+DQWXo9dy3AZra2abYTIklgyDEAveiW9wPtxitLiSQ1XISWlrj2WLHU8
 nAduPhDSyH4CkKQ9RpiJZ3lsAbaRjNj3ojPjfM7GQh+K/A+kBJvtb7Xy1FhS+SUa
 amxjUSKHrg==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8xsxr15e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:25:25 -0700 (PDT)
Received: from twshared132777.16.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 20:25:24 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id 3130E2F3ADAE5; Tue, 19 May 2026 13:14:06 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v4 2/3] PCI/TPH: expose the enabled TPH requester type
Date: Tue, 19 May 2026 13:13:50 -0700
Message-ID: <20260519201401.1558410-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519201401.1558410-1-zhipingz@meta.com>
References: <20260519201401.1558410-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIwNCBTYWx0ZWRfXwjzJxoPK8+be
 LNiqYrKMG2Z9aweS27dd1s7eci6Gui6cJ9ICxX0chcm3ARItpiMfv8FT3b0dV8EegpvxGngKZmX
 D4zmIJeTOvKSH3aAHKeeALy+Pb42uox0RLI4epRrgEeGkeGph+LLgXzaUXuDi61YV6atXD5GDaL
 H2I0XmX7QV0qhdKT5YzIYzPxAWGxHrebJY4E8fgjcRM99r8Deq7YOdYX2Cb8VkkIzi54LKiDovJ
 4rqmUOaYrOUpEQ4ZK3paFQ+u9l+joxJRwGiyPKmyLOUaz3XxosvwcwGO7K9vCqS1qOyAXwct30w
 HfKrJnuft2o/ch/k9lpb25L7AavMRn4t/of9mATzwNXmRvbJ2yfAF/3ycuGu74qt0YEKUaE/k/B
 qZR9Ymq8C9dFSQ3s6yt4eD09C4cdv27xCM5n057BruL6/aMaWK/hw/WLkMG6gsPuGRx9MRmOuld
 IuIJsOsF2/XtDqugSFA==
X-Proofpoint-GUID: 5tIqBrH77kHMwQDhqMPjomDDPd9e2jJc
X-Proofpoint-ORIG-GUID: 5tIqBrH77kHMwQDhqMPjomDDPd9e2jJc
X-Authority-Analysis: v=2.4 cv=BLyDalQG c=1 sm=1 tr=0 ts=6a0cc735 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=YRoFvhOfcVPyCIBj9wAA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
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
requester mode without reaching into pci_dev internals. A
!CONFIG_PCIE_TPH stub returns PCI_TPH_REQ_DISABLE so callers need no
ifdef.

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
