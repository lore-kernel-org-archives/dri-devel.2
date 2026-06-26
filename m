Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764E0CDE011
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9647E10E38E;
	Fri, 26 Jun 2026 12:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="JT/zh7ng";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2071610E37D;
 Fri, 26 Jun 2026 12:43:46 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65Q9uKxN3594545; Fri, 26 Jun 2026 13:43:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=h
 s7SSbW3zxJ/7kNQjLhTGnz6d/xCdf7MbG/zrgIxwoY=; b=JT/zh7ngWSvivIwhE
 M0DQxJ1nr+ExWkiqENC2cllN5CwYeKO3DlV9Q/Wbkc+v5Jy1Dtzl19E24nUhaz4c
 kWipZBD34FsdCjknhJdZPWFguGNViqkBjawy3QafdkkA7u80chovuWKiUJrxjGcu
 n5SV/HI51TcGR8pwc3E1zu5n7asPIAFWuANQnMTR956gOX0m5ylzC694LBeekMMt
 bFi8ugb8nbk88skuJqTUzPXQzoUhLSkf7AKnC93oWHWbc9AFrtpKCCCEHr6QMD4U
 aDLY4TBWrcfPOLjKq2Z1F6m5EacEtJ6m9pUfh/dJpj+Z1UEHYKA+dGOm3OvRNTWL
 orlwQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f1q7w83q0-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 13:43:36 +0100 (BST)
Received: from [127.0.1.1] (172.25.2.144) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 26 Jun
 2026 13:43:35 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Fri, 26 Jun 2026 13:43:12 +0100
Subject: [PATCH v2 3/3] dt-bindings: gpu: img,powervr-*: Add maintainer entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260626-maintainer-updates-v2-3-e1b3f246c44c@imgtec.com>
References: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
In-Reply-To: <20260626-maintainer-updates-v2-0-e1b3f246c44c@imgtec.com>
To: <imagination@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor@kernel.org>, Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, Frank Binns
 <frank.binns@imgtec.com>, Brajesh Gupta <brajesh.gupta@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 Matt Coster <matt.coster@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=BIO3CltyiwRLe2UAsolQ/5WXbs1RV5BSmdIO7X+Dxss=;
 b=owGbwMvMwCVWuUfy8817WRsYT6slMWTZFX8tVBaK2l2ue+qya6W5Mbej8r7eBFEt3z9xB8zux
 4ukVKt3lLIwiHExyIopsuxYYblC7Y+alsSNX8Uwc1iZQIYwcHEKwEQ+WTEyHF6Q/Pq5cta7zkeT
 edYpzfDUO3OhOMphvaXTcofYMzlPvRn+qR0yXJoe9MJT+rCvTLRYvmudWuiKHan/msWNvyTz337
 FCAA=
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.2.144]
X-Authority-Analysis: v=2.4 cv=D9h37PRj c=1 sm=1 tr=0 ts=6a3e73f8 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=dQmqtT5jEasA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=gEfo2CItAAAA:8 a=r_1tXGB3AAAA:8 a=rC20Y6xFHIYgf1721XUA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEwMyBTYWx0ZWRfX7g8c6zBxlmP+
 q+kPh4G+hRL+pGyweNZZzqC6Hh9wZULxhUMnV6H3Fxmdmif1XMwjQclozEOmhzrKtTe8s8MiHAg
 ESJhAk2JckszO96b/Yl3daZzmFpNM/hflHTJFmylBMjQW67npo1USn0z3lq7joqdWI/X5Sp8msh
 167Zgqoir1ayIotpj5Ymn28imqnZ9a81hDwgJ0ad6NZarrFJ2xJk/J3DbkvGIKon6xomQ+7RWpE
 5s1oglJAbmZu9FecD1t8OIuW9wO/KQ3+AvUxV//GOQEl5t6duRl6UCzGS40Q41DIh1N2Ud2uYAe
 zhm5C9TxMNGaez1wItTxFOvnXZGuvVPJ7Zji6bfqTK6M2fuwgDMJvD9CVyzpvt8773uETf1/1QH
 diEaiUg18Bt8HDNnFhRQeCjSBwPozegyPwW5mp/RBOziaWuB9pwUr74TojvBkUrQrx6bhi3GapA
 ZTONe87BsFJxqJh25ZQ==
X-Proofpoint-GUID: TC8EWXIRuMT0Os_WZ-JXM-bUlBawXi5L
X-Proofpoint-ORIG-GUID: TC8EWXIRuMT0Os_WZ-JXM-bUlBawXi5L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEwMyBTYWx0ZWRfX8sjNhomN7WN7
 jz1AtNRdqqZNRwDahqYMmRjp24ZkXB1rYYTPnV6ijdF+9ZzUx69ywF4X+nFG+ONe+zZ7+7XoE7i
 e+G0kBd4aJosT1A8hVzZnX9UgFz63Xk=
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

These entries were previously unaligned with MAINTAINERS, but will be
even more so now that entries are being changed there. Bring them in
sync by replacing the list here with the updated one from MAINTAINERS.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 4 +++-
 Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index a1f54dbae3f3..91e4ff61b394 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -8,7 +8,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Imagination Technologies PowerVR and IMG Rogue GPUs
 
 maintainers:
-  - Frank Binns <frank.binns@imgtec.com>
+  - Matt Coster <matt.coster@imgtec.com>
+  - Alessio Belle <alessio.belle@imgtec.com>
+  - Luigi Santivetti <luigi.santivetti@imgtec.com>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
index f5898b04381c..3e7df7344430 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
@@ -9,7 +9,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Imagination Technologies PowerVR SGX GPUs
 
 maintainers:
-  - Frank Binns <frank.binns@imgtec.com>
+  - Matt Coster <matt.coster@imgtec.com>
+  - Alessio Belle <alessio.belle@imgtec.com>
+  - Luigi Santivetti <luigi.santivetti@imgtec.com>
 
 properties:
   compatible:

-- 
2.48.1

