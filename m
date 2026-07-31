Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB5EC55172
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDE810F427;
	Fri, 31 Jul 2026 21:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="HZlnexVt";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE1110F422
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:28:03 +0000 (UTC)
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VKX5Ju2105498
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=W7iqLmYoZdNfKKZd/AsiKZKGkQzWVXi2ivpsj
 OaJhGQ=; b=HZlnexVt3+uoXQ66UYkAypriTFtiVZCTZ0iuWnripwU4s81QQYMtf
 3uiGm7MDLbrR3rjFIOMPn62LHDRzhW3PlLrqOJV3tfj8gTBN6OcXnzxfDecOgtKP
 qUKbjdUe8IMDI1YfX8bmQZEZVGbunyhMrquhFNbFvOCZea6NwtEsRNjOKF2QzHJ4
 Hmdxyd7aYrM8RzpU0ZVs8ZqQMTT/oBFRzrw9l0QDqGu2pxGc4LxOL1K+ymsaV5PB
 ndv1MDSEHEVYXhnrc5IWACVLSQTVgOd+58F8tlerdxD+pnzlJ+B6tYcZWYxn24aj
 hdJni3HX7B9Y+EOIeOSrtR5b6Hp5dQdag==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fs2n60a8j-15
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:28:03 -0700 (PDT)
Received: from twshared14582.04.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 31 Jul 2026 21:27:57 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id BDF5043C24EC0; Fri, 31 Jul 2026 14:16:14 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Michael
 Guralnik <michaelgur@nvidia.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>, Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v13 1/5] PCI/TPH: treat reserved 0b10 completer encoding as
 unsupported
Date: Fri, 31 Jul 2026 14:15:48 -0700
Message-ID: <20260731211601.3033906-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260731211601.3033906-1-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX5J/gjiyxGvbn
 wK+C3M6u6/L31Vi9YMJnJHhGhghIop0ARm2RRuE2bMOutOXzqXFk/OeIbkz8sz2t/Er/Y9AJ/ox
 mDG5keziMKlQGZINYqKEx1mfJ0q9sUA=
X-Proofpoint-ORIG-GUID: i9p_-onPUlFAzvE_KbnTjj13_sGu5TRW
X-Proofpoint-GUID: i9p_-onPUlFAzvE_KbnTjj13_sGu5TRW
X-Authority-Analysis: v=2.4 cv=UvNT8ewB c=1 sm=1 tr=0 ts=6a6d1363 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=i0EeH86SAAAA:8
 a=5iV6q52TU81yRMb5XQMA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2MyBTYWx0ZWRfX4X/302io5P9E
 78IwYWWndh9HrT4dETLre3gObP12kf7v+WljLGKLwFyFu/GyZv+70gj6rIItYudhMKW6EPF4voD
 bHw6pH+I8Y7K2xjVoM+wI/8Zsr7UEHUt/YSvpH5NOJEfJZtXpOfoD5sQxYv1+l5S4e/sGJMtPBR
 I/4ePmsnRYBBgq0TsT9vCAek0b5bsccm1frLhBpdSA/1iE/kvhQQqQZTlCBhYyIw4zngVDANdte
 85C2LokufEigjRUp/tF6NTy6ctbeoDJRXGGTNNiJtTJSUXPRr4jn07Q1sX3P9MUrxNflXtYdAV/
 D6IiZ4VFC4QJcNigEyh2UP/GVHSPzXh6a6sL5N6yOYqQ9DkXMV4OJPWLvtEsACSo2ND7NCq20ax
 7KycvOR0nvPl/ZwGLqbgL4Kz3qBfTyEk7DOSobdR54Dr+WK/HRa5aGSER3KJFohwHTzP1f5w/7Q
 t2jD0styp7BZZXAWLoQ==
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

get_rp_completer_type() returns the Root Port's "TPH Completer
Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
into the requester type:

	pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);

and later writes tph_req_type to the TPH Requester Enable field, which
only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).

No known hardware presents the reserved 0b10 in this field, so this is
defensive hardening rather than a fix for observed silicon: fold the
reserved encoding into "not supported" so only the three architected
values can ever reach the Requester Enable field.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..5cbb381e2a02 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -200,6 +200,7 @@ EXPORT_SYMBOL(pcie_tph_get_st_table_size);
 static u8 get_rp_completer_type(struct pci_dev *pdev)
 {
 	struct pci_dev *rp;
+	u8 tph_comp;
 	u32 reg;
 	int ret;
=20
@@ -211,7 +212,15 @@ static u8 get_rp_completer_type(struct pci_dev *pdev=
)
 	if (ret)
 		return 0;
=20
-	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+	/*
+	 * 0b10 is reserved; treat it as "not supported" so only the
+	 * architected encodings reach the Requester Enable field.
+	 */
+	tph_comp =3D FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+	if (tph_comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY ||
+	    tph_comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
+		return tph_comp;
+	return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
 }
=20
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
--=20
2.53.0-Meta

