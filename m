Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F6DC5DF97
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 17:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E50210E28A;
	Sat, 22 Aug 2026 17:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cVHy/nRX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="arjR3TRq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739CA10E28A
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 17:01:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67MEMBm81462801
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 17:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=; b=cVHy/nRX/fwPTMrK
 VEYj8GtgiZehApcNnPQxTfCnhDtkHRcjHmCeDp8NpHxUPnsejg4Qo9nHmDO97Wq1
 clH2tfTl+vvfZdHm1IHeaWPw1ZWmxdg4QGb45hngv+96gz9+yu9Xf7HZndF7bYuA
 eeI0qHbATdwUI+spCH+FjbUgOXczqqJzpJKl5RCC8WRLOXGmbl6QzrYn2+MUz4Xy
 PuQG+OxZ5A3YLu/oCJquSOOuYIqkHoVujNpK/yEKecC9LPdhpXG7zX9Dd4NtYa22
 iy73NHayRI8WDzeQZdpmLoy5Wsu8LqfPD4nZ+R3R5dLrYFdEIn1QR2O3uVDCqMOG
 U8BqSg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74399mss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 17:01:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d58262ffbfso5487835ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787418113; x=1788022913;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=;
 b=arjR3TRqjAHP3hcwIW0r7j2ZZNfvgVtue3wYVnaTd/f1PhxSHuzPwDmSkGMAr57dzf
 cqEl9/iYTR/axSklTuAo+BYv/aPBjGI2Bs8/Dp3MN6Ol8Ku25OoVhHwsME/6yUz9UV0p
 +uP4XxPWPm8pKAPT+Y26AL7d5KFAM0Ix3oV7BFaQmWnEeN8564enArkWA7ihD/HKYe9x
 B9m8QPmGGQhhlbRMGcBazAECk3edzEtzLteNahU9E2RDD0nmzWs7gNpYvyjl+cZb4wMZ
 O0rIYXzCcJqSB0qJ/KnM643jj7IaUqIxGsqc/Mx7oDoDCSTx7wkoP+8j35b088O9YEHK
 LHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787418113; x=1788022913;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=;
 b=neLLoKnZRcCyHZELltBqmuRhMBT8VD/B8sQg9MEpndvR9GsEjzURozVzU3YunaqEUq
 0naRDqP0+LgFwAAmOkbBCSE4BIPYbvap/eM5iPnC9/KwGXREISnzFRyVLeAdpMJgAAat
 h/5FEHM0vjEHR5Ow9BTeHc55by/ZOM6DSCg5VwRY6LOobD/RxBSavqzQsH9jVuRAO2Xf
 Eacg9uThquLqIh4tPE6VcYJPxLDgpbydtPS5EmFy8cOA4iDxOHmfnZV2v48J/t03Tnt5
 cs0j+HuKT+B+Lz65oRx0UOpotw2LCinaVaPXeDFDdJr8BJRdrkcbPas1nyBQKkxWYQFp
 pBfQ==
X-Gm-Message-State: AFuF++l1QFI0WaJPhGBta7jacVXW+XWa0OQvWsA4vpKhuej6qsqaILGl
 iXgvsZOGRYR8j5bP/W9fW7DoZ8BU7Md+Gqv6z7VNqheHRy9oqyce4vKTZJ6YXawm06FLsMe392p
 GRMjyYt/9QWbZ0ikqhb82L7b0THa+g45ulORoxzAIN7sSBysY5VChaDieLWO9jgGFMO2GP9XMca
 fWSWo=
X-Gm-Gg: AR+sD11CPob49D7nAuto3VXr9rDWOGle/8zMD3qQukIM6gmgBiLQKfIvBOPlm/uqEsk
 Q4YxFe4XVgty1YHFqRmKGWFsvayncWsbb44DwbTJo744ksNiQbKa96msxGNHa2cJsoIoY+zDT23
 Q3bEtapWUbhLAAW4DO9X8mnqnHWih+yjvnfthRPK/ehGIFhZkvuYC0HlOwx8CQ06Rq3UnDNgK0a
 3shZxKZoi4KNN1f23RZO9sFjj+wpH82N2gE4e5ieXCxUJj3wP4+UDePbpYmcwpMI8wienCpRoYd
 3lfHQ4YtBN9qwY6/7fssn2xDw5Tj2Ce7gDUWjEUlU9OvJQC/tKHWJQNirehRqFSvyvS9GvTr6fA
 Smb1PmoV3Th/4aZx0O2o0Z6Z38f0qGbeoPS5jXX1NNInx8recsYod7ve2TnZT6K+mTLReKBucJm
 tcWNx6tUJ0SSMORHOFMr2g
X-Received: by 2002:a17:903:120b:b0:2c9:8287:fd0d with SMTP id
 d9443c01a7336-2d64b049900mr126446695ad.3.1787418113121; 
 Sat, 22 Aug 2026 10:01:53 -0700 (PDT)
X-Received: by 2002:a17:903:120b:b0:2c9:8287:fd0d with SMTP id
 d9443c01a7336-2d64b049900mr126445985ad.3.1787418112656; 
 Sat, 22 Aug 2026 10:01:52 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f9099ce7sm7760562eec.5.2026.08.22.10.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 10:01:52 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Sat, 22 Aug 2026 22:31:33 +0530
Subject: [PATCH v7 1/2] dt-bindings: display: bridge: lontium,lt9211: Add
 lt9211c support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-add-lt9211c-bridge-v7-1-7dcf567d57c4@oss.qualcomm.com>
References: <20260822-add-lt9211c-bridge-v7-0-7dcf567d57c4@oss.qualcomm.com>
In-Reply-To: <20260822-add-lt9211c-bridge-v7-0-7dcf567d57c4@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787418096; l=1545;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=7XMiXr7D3fC2Of65x2F+DhMxVAnk7abheQMCzBYJB9E=;
 b=OccMxKSRoYBvcoaTqsctySdu1Y3kL5I/zp6FB/1RPE1kJxqBuJjQwXiIV9suYg7oEnbFpOhx+
 9T3SEpe48VeDg/ZqkA1QO5MeICSEGWtQ54XAFvOhR+TwR2hcu9wIHxh
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDE0MiBTYWx0ZWRfX4oZ4AHNdg/dV
 SY9RZyOHEoIqMjH4lQjIca0nhErSBmLlnF77XLGoiDK6flcJynFwOY3PxKAjdu9dESDU4LIJ09i
 XzwTq2SFKUeZulYfmfE2GdOivHWj/iYc1TQiPmCnsX6tZ6bKFUdfIwvmKU/EMdSXXoGl3+jV/5i
 yGnHmgaOYr8WVDMLGnM3hLF7qrgDJBuSvu00a9KoLZLe740xxpRUWUDGSWjbsNbCor+GDnyvo1j
 brwKynzcI2bHYpu1Z+8mXP/XJJbybYvQo6vP3IaCx24HZy0QUI7SSpZexeqz8YbSnBtdzzG5Rlw
 bnC2tJuZ+zWiujeYc73d8xzfasKUky4AxlnQF7F0gK5rLsbFwwsXBbAqEZ2N+tYfs91Yrm9vhkj
 ef4BU0RszhGflu2seW35FEUcETbG1N1xETcKTbNyhmS3+CeS7ET5io94lIwI1nhrU7j3u5tlGOV
 ggTrwbUaTBdGIZlo+Pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDE0MiBTYWx0ZWRfX//WNcleUzwG1
 R/dxTWU0gSkBJyoa2TaBlkZDAgtQDmOwb6ErN0sFSwKswyJWFHQRJ8/BDK6F5Xy9QebEE4unWVO
 CxoqzMUhDulrnBajmYofCqwYdtcvatY=
X-Proofpoint-GUID: xGe5AicG08GRMm7D9X1X4hbRihCiXfLA
X-Proofpoint-ORIG-GUID: xGe5AicG08GRMm7D9X1X4hbRihCiXfLA
X-Authority-Analysis: v=2.4 cv=e402j6p/ c=1 sm=1 tr=0 ts=6a89d601 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=UcubZVdaWCKl6vSfqw4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220142
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

From: Yi Zhang <zhanyi@qti.qualcomm.com>

Add binding for the Lontium LT9211C bridge chip.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
index 7cfe92a8bcd7..de61bda09db9 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
@@ -4,19 +4,20 @@
 $id: http://devicetree.org/schemas/display/bridge/lontium,lt9211.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Lontium LT9211 DSI/LVDS/DPI to DSI/LVDS/DPI bridge.
+title: Lontium LT9211/LT9211C DSI/LVDS/DPI to DSI/LVDS/DPI bridge.
 
 maintainers:
   - Marek Vasut <marex@denx.de>
 
 description: |
-  The LT9211 are bridge devices which convert Single/Dual-Link DSI/LVDS
+  The LT9211 and LT9211C are bridge devices which convert Single/Dual-Link DSI/LVDS
   or Single DPI to Single/Dual-Link DSI/LVDS or Single DPI.
 
 properties:
   compatible:
     enum:
       - lontium,lt9211
+      - lontium,lt9211c
 
   reg:
     maxItems: 1

-- 
2.34.1

