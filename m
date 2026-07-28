Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14163C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5304610E7DB;
	Tue, 28 Jul 2026 07:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="IFjmi0Y6";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1EA10E358
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 01:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1785200732;
 bh=GSIsWbiJgOU7u68drycpZAJLfMtAi+4XlVRaMUF95yE=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=IFjmi0Y6aYo0cCE0OmHWsUtBQ/mKGYF2yTSBasj2ZJZWhChZFPLima84GQHMburQD
 8PjX5jDN6uG5OZk3hn9ybYzSyFHwtFqtUynF+Sho/DtLM7oqQnYIyGd6bsfMFoHtWL
 1m83Ti5dEEfl44Hb6LodbrN1nYQBhaOY1x1QV0a4=
X-QQ-mid: esmtpsz20t1785200724t93c1ebc5
X-QQ-Originating-IP: xhjeCmfDmNb1JxmDwikRXGKv5p5Y0XMHmqSTDI/Su+Q=
Received: from snode5.. ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 28 Jul 2026 09:05:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4903690583128765275
From: Sterling-Ash <liangbaihui@linux.spacemit.com>
To: Frank Binns <frank.binns@imgtec.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
Subject: [PATCH v3 1/2] dt-bindings: gpu: img, powervr-rogue: add spacemit,
 k3-gpu
Date: Tue, 28 Jul 2026 09:05:12 +0800
Message-Id: <20260728010513.1627950-2-liangbaihui@linux.spacemit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728010513.1627950-1-liangbaihui@linux.spacemit.com>
References: <75c9382d2bda766aa459b00321153d715254d1a4.camel@imgtec.com>
 <20260728010513.1627950-1-liangbaihui@linux.spacemit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OKkKo7I1HxIeTMMv1nV0rGC82yELjUeKyaJ/gcwQqjRhibJFRSqq3xZl
 hhIs5z6UGX1i6PxRcEL26hxobWlGP8uluCLV0nDA41+FKVGAVemg1iQSgncqBsU0WNoIYCW
 gQk7UrNpPFSc64HwgoBekWBYQArvmejNmBmEiRUI/zWZOM0Sula8K4tP6te/W+VjqXMm/md
 kbeWfb46P9xx/51r2mtexzFTEdWM50wjSMxLItee99c9AN6EfC3S4J/TUWpJchUH+oi18nY
 mlUKiCrjQC1CowSCriMTYExj3M/LobfMrwwsb/tRXC877tV+alChvFAeYKsI6wMmmfYJVzB
 sttb4F9CdI+8+VKvZgVREJae1BCU0x5XQT/r2CzDCRZf6Vc/E11DSrbNGzj7+K96Zc/cIUw
 xZ9nDDIxVRIO/uRO//VOaEjVost7rROYmyeLykXSxlOn8NzJrzbmbseWtZfgvV3EBgxsKPP
 M3nRzVKmMOOa+1+42y3q/rJsh1sYU+oN10eaiMVAe34lkxA9Yt7kElYh9oaiskn3Kl+cZbW
 CQYOwaIHHwBap7WkEUbBQ1oEwk7sutnrqxbAgUy6oI1FUZeFn89Hd9h8EPZSObpziZcJWs/
 1zoLARlkPIeUoaz+hy6P6dyx+otKXa4uiG2j3SR40aBhkNqHn2SUrz1X9OHfAr0LWJbK1aa
 qmhDrjxFcsHI1sNoi7J7C4+vpRarj8V7lxFdv3fYzkXxv6T0HSlAvwylfV7gshFiU2+Mgxr
 csIY0VmB9XXkSISIRuG/0uscGHJB+lNVbX05Ez+pDJnirm9tmb/zKTDpmmYnQ6bg0zj6ZdI
 BBdavDAoLltKUuStXSBG/7ulEdz3ucv8ragMKIMqBEL9zYgo3jOrElYHUpbjtwXLOsbCddO
 3tv0HAN1P0U2meFaLSXDlm5ii6dCmO+qqd9mQ/ugRIDGQKdcQ2LxYuCnuDx7IiPDFOl2BQ6
 KocJu41Iw5zy6oVDUIrF+1piwsYdEPSCxFGI1p4YhioaH3/89PPTqMd/BZ179aOCdLnKONN
 mWCVFVCaZdW9Lx75GndSrI+csVctw=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

Add a compatible string for the IMG BXM-4-64 GPU integrated into the
SpacemiT K3 SoC. It shares the same core as thead,th1520-gpu but is
kept as a separate compatible entry, since the K3 integration differs
from TH1520 in its clock and power-domain requirements: K3 has a
single "core" clock rather than three, and its GPU power domain is
enabled by the bootloader before Linux boots rather than being
modelled and switched by Linux, so no power-domains property is
required for this platform (unlike the other img,img-bxm-4-64 user).

spacemit,k3-gpu is added to the existing ti,am62-gpu/ti,am62p-gpu/
ti,j721s2-gpu "if" block that restricts clocks to a single entry,
since K3 has the same single-clock requirement. It does not match any
"if" block that constrains power-domains, so that property falls back
to this schema's general constraints, where it is optional. This
leaves room for a power-domains provider to be added later without a
further binding change, should one ever be modelled in Linux for this
SoC.

Signed-off-by: Sterling-Ash <liangbaihui@linux.spacemit.com>
---
v3: also add spacemit,k3-gpu to the existing ti,am62-gpu/ti,am62p-gpu/
    ti,j721s2-gpu "if" block restricting clocks to a single entry --
    previously it fell back to this schema's general clocks constraint
    (1-3 items), which would have let an invalid DT with 2 or 3 clocks
    pass validation (found by automated review on v2).

 .../devicetree/bindings/gpu/img,powervr-rogue.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index a1f54dbae3f3..d29f0d163b91 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -38,6 +38,11 @@ properties:
               - thead,th1520-gpu
           - const: img,img-bxm-4-64
           - const: img,img-rogue
+      - items:
+          - enum:
+              - spacemit,k3-gpu
+          - const: img,img-bxm-4-64
+          - const: img,img-rogue
       - items:
           - enum:
               - ti,am62p-gpu
@@ -100,6 +105,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - spacemit,k3-gpu
               - ti,am62-gpu
               - ti,am62p-gpu
               - ti,j721s2-gpu
-- 
2.34.1

