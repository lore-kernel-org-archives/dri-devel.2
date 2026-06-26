Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE175CDE002
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EEE410E37D;
	Fri, 26 Jun 2026 12:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="KvdouatO";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB8910E383;
 Fri, 26 Jun 2026 12:43:46 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65Q9uKxM3594545; Fri, 26 Jun 2026 13:43:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=5
 Ogf5Wl3QQZvTKRAy4ITMzPaEdLMo0ILl6iyTX/9sOE=; b=KvdouatOyCB0ThqgN
 wJ9q0E5EKSWkG9/fWMgq8PyajaaIiYR8A5enh/LbFiVXzgF15kO+cZlrBfT+7A/4
 OMN/m09GRjDGZO8fzv/ir0G75pCXlw6pug1s4COF5TDrKBsYNO2Cr3tnwUJAg6yx
 pF76kFHsEywrZJ9+S2cnHvIwyVLbj59njHKUWHZfKLQT/z0z14AzFz2k3o2PNb9Q
 LxqJ3DdzKZTAcjs5yqzDHHwUtRoMpjbhSXWEA63hxbA6HvTIw9kNtmTz40b34bY1
 0ww5heO6UK72r7ZrqVbmt422uwWc6PYgXdOQI6rcDRuEeV/+eKsjBt957jRMEbdC
 5ot2g==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f1q7w83q0-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jun 2026 13:43:35 +0100 (BST)
Received: from [127.0.1.1] (172.25.2.144) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 26 Jun
 2026 13:43:35 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Fri, 26 Jun 2026 13:43:11 +0100
Subject: [PATCH v2 2/3] MAINTAINERS: Update imagination maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260626-maintainer-updates-v2-2-e1b3f246c44c@imgtec.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=matt.coster@imgtec.com; 
 h=from:subject:message-id;
 bh=273UYrDZLPZRLdQE9gl9FKkhwcDVtVsSfuVQnIfzmlo=; 
 b=owGbwMvMwCVWuUfy8817WRsYT6slMWTZFX+12f1s1bWbYgFnX/R9lTZv3H/yh2S76EMWO/ejL
 eITqmYt6ChlYRDjYpAVU2TZscJyhdofNS2JG7+KYeawMoEMYeDiFICJ5JszMhxRC/Rn158yIcDT
 RzTC9Y5sS9aD/NbsppxTzwL/z1HxUWZkWNPoHVgmOV2xXPDVPvud6cc/bQthuXm73dD637xFnb+
 ecAIA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.2.144]
X-Authority-Analysis: v=2.4 cv=D9h37PRj c=1 sm=1 tr=0 ts=6a3e73f7 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=dQmqtT5jEasA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=e5mUnYsNAAAA:8 a=r_1tXGB3AAAA:8 a=iCmMkxMm0QhFShkxjzEA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEwMyBTYWx0ZWRfXyo02b29RyqFn
 dflS28wKA1e1qRaxxAGmSIhfZIXm8HtHYIoM6MTSHBsupNMStuRO1hx4vrR2nhUhgJW2CVsjUQW
 bfIHtseh9HJHSbpfLVqHcCJ17obFyl7nvocfQ6gV62+g7TKzLYDSbcW5u2F/3v3cIJCmoutX8Y1
 Rc/q3nCVaAHGTor04gE0TMkU7kd1YYFlqWvSyYaWjJbbXU8z2yhUEhFVy28CUDyhDzr8TL0/+qX
 MDAAto1jV1egZQSdHYdfmCI25eqpFHUlp3fbn8VFQsbG9zjnV/WwSBq00PFYY2zcwZJWxVIPYwr
 NZ0N4fJlNSn99jOgpMDoFP/M1E7y03yNckedG8KjCdYbwZwu/ThIDpYe2cu1I1Fdb5U1h6slikz
 VaVmo95yZ/7RWR7Xp1Fkr74eIdgMPiM53JqrAFCcffGTJyGSbviobNdaZ13BlOttjkcgmCFqnjS
 RZB4LdORbqWWm2PGtvw==
X-Proofpoint-GUID: sbJBbXXXRH7GcHwv8mXIGAQVLvxJBQsM
X-Proofpoint-ORIG-GUID: sbJBbXXXRH7GcHwv8mXIGAQVLvxJBQsM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEwMyBTYWx0ZWRfX13yvxXsKG9we
 GRBHAfD8IlESq+CKNL4nFCKYApdvy/gScTZvLqzNUZPny81Mn5NAXRgK5+2yWTTAVYXfK+HSi3r
 LIklUh8ReIxof1rQQtM1+jdj9IJjl08=
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

New people are taking up maintainership roles within the team.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b45e60524762..fe02d1087ab2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12567,8 +12567,9 @@ S:	Orphan
 F:	drivers/media/rc/img-ir/
 
 IMGTEC POWERVR DRM DRIVER
-M:	Frank Binns <frank.binns@imgtec.com>
 M:	Matt Coster <matt.coster@imgtec.com>
+M:	Alessio Belle <alessio.belle@imgtec.com>
+M:	Luigi Santivetti <luigi.santivetti@imgtec.com>
 L:	imagination@lists.freedesktop.org
 S:	Supported
 Q:	https://patchwork.freedesktop.org/project/imagination/list/

-- 
2.48.1

