Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18722C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEC010E059;
	Sun, 19 Jul 2026 15:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ftim+XxG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i9G8Wmh9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A9EC10E059
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 15:57:49 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JDvcSP3725658
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 15:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=; b=ftim+XxGsBGn/Z/i
 2qSIaKotx0a/S6IVTcZ8mCpD+TJSdM7cVf3thKj+lcjqcdRsRRbvk8QL6DCgcvw1
 iUHG4u8vcL5iGUTKL2LS1rjzIewZpM+c6wScvP0eDc25CS6ZkXbX1TQFePyakB6p
 pKc5dcMaXHx7ErRdOYLShzsJQA6FObdiSd7g5o93tG3k3SRQVJU5GAASmHmTnESn
 196TLFl/m6X1Va/3fG6KwgWMCGIOmCzxjrUT+3xf774/W4/1wfaCSDruKLYBNaVm
 3NeWQRYTFs4jkCplyV/giTjTro46kXYcpsqc4M59EWtVW0kSobe1sbuEJbxbJ4XB
 0UnUVw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnk183-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 15:57:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-384cb1637c2so2709103a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784476667; x=1785081467;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=;
 b=i9G8Wmh9uHkaRmfOaNBmxvmteah/1r6AP40WT/1yTBiImxJGh8aCW2R/8lBVMjAl8M
 UfJsrazUfncpD8lSAjzhPpAvB8u2uNxAlIZsRgl9uuGHkzP+OWCE4oyCOTg9wGaPCy+8
 dOYcwjSaAhoUtSznDn0OfD0a1Ab/bHSGfBc3zvufKNgwZWYv0WhGqPpSQaKzRhdCuJKf
 87ZKyBaUF94bswIK8PTjlXnIlxGFbIBZZWWy8UX/LHANJP7wRGBZTryQhNMI6iRP0gT1
 mDNn+pxxznu8bcH3k7dfl3mFrJImTVt8P8emxsB9Tgfb0gdpp1LnFccLSpgI8R6ktk8H
 x4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784476667; x=1785081467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nMeeDoM5kZU/bqV8HBx/kQzsngPCM+3poCWoyr7i+Wc=;
 b=BWhb8UCtcrR0y4nQ5n5Dmr3fnNtMtaNgD0fiI1BtNRzK0RFeB6ce5M+hC7Wuykrm3+
 tKWOgsuMKp5cqiXBCRXiiM+r1MJmhiq+6c8y9qMCKnrW+sd1zFpMH1ktzvrWGcVDdIq7
 pxzv5cEsI/dKrinopRfbs6+NlZhdr0upoBHUm43zDFeYC9SBIADKN+HcZM96TP8tnteQ
 SQBxO07rya8lBeuH8FYBW1MBcm3khjvsIcGLl1WFFqt+8IQM4DspMrxMmInGKGd27+Hk
 4MELxuYfrB0aoQ6s6f36nyvtniLT4VZ/d/DgG7M2+8x8kVZMnjOtBC/cc0MCV0zwM98w
 9akQ==
X-Gm-Message-State: AOJu0YwzCfSYio/bl3b0R7AiHFdvXg6DXBHki+Cpblw7ntTaTvUvKPaK
 WzM4dfsckbTuqeGspm64dHmTIAOQwXaNhnwkckFJU06f/J2epRNeBhPnImDMDxVBte0ENJ6bTKu
 tY+rV35u8TsG8tGHfwWOzIiv0GhAUzBV6gJkFZigPejYvqFmgplFTfLfG/h+q6mGkKKeT7HA=
X-Gm-Gg: AfdE7ckNkz3F8BFG/m9ehetHc9KXz1RvAfHo4dZaZm9hgLjOK0qiGG7Sn0lekeIsri3
 WDe14Fof/WJlokbsdvvvP9tpv+6Uf5UjqgJLS02x+mVOaBCCh0kEwTaEKIJBoVsxK87ejP1GBRs
 uUBHbyCwP0zmiFmpJBlL62uWliaoWcT+PWl1QzsjDDSudvvow5jD6FkxW17cftpx5JaxAdnIO3i
 uAH5ppYeO8GMMIMpWlNOXUSbxFKfUPymQG6A6lYXHAm836aoM0asddt4hH6yqTPU6taTW1CxMnP
 PbfAW+2PuF2Fst8ZWUM5uqy415RPzPkPC0vDs1Np+ceqDXLP9jmtU1M4pNewv5lsX5GBIpbZJAI
 rSKSF5yCd5Yiem52Sg1gtNY7iutEf13H6q2Q2x7bhFpsXQ3N8Ny3oyZfFLKKVkAj8bVr7pJ7kX2
 W/txM1Gjtqw187dnv+o2K6
X-Received: by 2002:a17:90b:134d:b0:37f:e7e7:ad1 with SMTP id
 98e67ed59e1d1-38e4b697024mr9059749a91.5.1784476666838; 
 Sun, 19 Jul 2026 08:57:46 -0700 (PDT)
X-Received: by 2002:a17:90b:134d:b0:37f:e7e7:ad1 with SMTP id
 98e67ed59e1d1-38e4b697024mr9059720a91.5.1784476666382; 
 Sun, 19 Jul 2026 08:57:46 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d439sm33127054eec.5.2026.07.19.08.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 08:57:45 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Sun, 19 Jul 2026 21:27:25 +0530
Subject: [PATCH v6 1/2] dt-bindings: display: bridge: lontium,lt9211: Add
 lt9211c support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-add-lt9211c-bridge-v6-1-e56d22152586@oss.qualcomm.com>
References: <20260719-add-lt9211c-bridge-v6-0-e56d22152586@oss.qualcomm.com>
In-Reply-To: <20260719-add-lt9211c-bridge-v6-0-e56d22152586@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784476650; l=1545;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=7XMiXr7D3fC2Of65x2F+DhMxVAnk7abheQMCzBYJB9E=;
 b=1mg6j7F2+7PtEmJRYo6v6QrTNu0dH7Nea6WFgmNwqGUIDgQlEp8KMlM/kGcs0y1OsF/cY9Kpd
 S7tDzN4aD4kDOHmiMsMFgY/a5BaSISxYFYevgLe2Bg04UiD1vGE2XDJ
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-GUID: h9tzcVBziLQdh7himY0Zy6K8TsO4AWtb
X-Proofpoint-ORIG-GUID: h9tzcVBziLQdh7himY0Zy6K8TsO4AWtb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDE3NyBTYWx0ZWRfXzzTRiyqT90zD
 CvPcFjz5TlWYuDO6msmKCVM/HN2qIHIx9D+atBAKn5T+0sx8x+F8EaKM91G2Qk8Fbb5aFzcW5sx
 j0v2S7qxuDPkrRzfLlpgGwV1IrUNT/ZnYCzqmzzKbauSmn/QArujXd7lGb6MYcNyjGbjtEQ7t5T
 EX8DGiuk5HExlKaYMoXryI0C0o9bQirGrJrX3ol7zqbzTlbbVpgEesQK9OZumSNJkbCvIxlvgTf
 WQzoC+PTGfwjdkhFU1GUouTI3eUl1Fo+Ak393PbUBbATKIQexWQZ9/h8hQfU1QKJ4O5ZO3h522R
 h4nUGkUQampnoJ1fp4KuowRlZ3z7xTwLzMkWIdaZu8y12Aox16kXFQ6nB1b1hh5s5zHLEvUmm0U
 Glz8SH+H8ppzcAeN7t4PmfLuIBtmBFf6X/yrOt4Xr1sNS+zrMjWZmTvbUSepU0wUI5hT5UcN+hV
 F8kCpDEvVHIfqRSgYfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDE3NyBTYWx0ZWRfX0Cv/oDMo1fwm
 Z+rm+mAM1RUIb6I/2TGPsmwjIdihorSeTqp/OZxsZ8vCuam//oApIH7yjejbiFnGET642/WMQMx
 XZ/CZloFiCGRQngIxYKAmoA33enOPOw=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5cf3fb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=UcubZVdaWCKl6vSfqw4A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190177
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

