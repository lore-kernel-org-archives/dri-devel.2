Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0692109B493
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3B610EB63;
	Tue, 31 Mar 2026 15:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ORtU+VJw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTh6Lw5B";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A99310EB5C
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VE5BNf058081
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cjHn7Kk5aOTSG3RKTc9qr3CMGxHyzEiq474/PRW5gVM=; b=ORtU+VJw/diHjWeO
 D1C2sLVRbvlbKqpOl/dieiFOs9sexY9X7WQC1r040w3SREEL/rWiiFl7KRMnvp/4
 lyVwBkR4u+dxmHOvgv2df1Jiucgh519cUFWXXzeJo7wHvFpvjFu+KfygXn9pmw7B
 RjetECiWe2oX4QJwQxnG/TUQu0nf30CZp7xitwX30WkfEq7xIr+MP/tFVUacpKjl
 btxByp3EgFFCZclKHeacRkw79nYjWZYo3BGbfLfKrkahMacO7lBOO39K7w52VwXh
 0Zw6m+VhOp25P9/kbAiKO/zS4kesZCmaZZ4l4bsG1IYyH/C+AWobVugHl7QEj6Mj
 r9iCgA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8ahksxyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b3544bc7bso83298951cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774971855; x=1775576655;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cjHn7Kk5aOTSG3RKTc9qr3CMGxHyzEiq474/PRW5gVM=;
 b=bTh6Lw5BmbFXQdp0Yrruxy7Gz+85msJD7bGFXhAhzhinptS46dPvL9fHYk1EP3BbJ+
 /oC+8WFR95q3wXQevirdqUH7ybvTs64VCdAC1ksNwUQclEOu4fkLU8X9aXXd7YD11lq8
 RJvIodJoZKNPcLbVJUVlvzNhXXv6N2AWSvIQ11eBfxOD02vEHNSYvwyjjGqmLbpyHyB1
 X7PFhYl8Kw5K+GYEOHUOLhlu5PN39HiU+FFRdfWxW/kZKB9ujRVSMT1frYW8ji7bPLiz
 U650M2L/cfjXJvTjNeLoou+2G9RaeeXcCTTFNRNd9OBM1lBakt7YEyVqjFXha+csaO1/
 fMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971855; x=1775576655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cjHn7Kk5aOTSG3RKTc9qr3CMGxHyzEiq474/PRW5gVM=;
 b=kyzYGWxBHql8xCSnUOaqUVDAkky5CGDq8uak16NCRzzaNoquuGSQ4SmgCd1X8WNU1U
 wfQ3Fm6DjNcE+PWr4y50dbHndS/jkV0KPtQEeHvOkhNbPT9W34fbanspLZK2KY+Vk8/T
 aj8CdElnbHORASIIwdpPIUS1Ou0V0ppaGF1fhUvyngeWEhKu+lOVT5P354NLanOCG3OZ
 rao3z756/MrtOYSTxh8KAde1dgE8yTRUX/v+vWUJ6lMuErNo/RQlDpy9H4zNMwuV3JLJ
 cJb7j2l0SnY1MtWM0XxlbHbRFiapH4B2tcMH4mt6/JJrLqP5jFeqM7mxurvA3zauhfy8
 B1rQ==
X-Gm-Message-State: AOJu0YwxIbbjwgpacmnA4451xsWd659hrExtrrFFTz2SjLMcd++O7yfT
 I4llXKOZYV56/Apav4yM5cJD2jBhDwJyFIPgfxxTV1N98Dn9CQJlfF7wkJVS3CtWEwtm88X0QAh
 Iah0v3VOVx5wXUubEeSxyWNGdwoxMvib5OquJ9dgj5TsmAIRWqhw/rk7ixubrP458uCqKQjY=
X-Gm-Gg: ATEYQzweZinowZrn7uefgj1ssZbMSp/L+TZJfCLvtjBrmEu8ThBhYS/wQMmeDp9Rplp
 NZtiVvxqOnI2k8QnQbMDtmVXryKVwGIQefi7SRoWV27fR5C0Oxlp8n9Yd3wx7tHEZ+J2tGpuFvi
 XrDUKxGxha/fTstCXBNWCR4SpYP5XxcvgMq6R4osmlMWwqO9r1dHyTb/UJs3QKYIoNIjRWAhFPq
 BSasaynjPfhBVzCWXqCcaBSsx+p6BDmmPqe9n1HjVonZo7ce/+hD7kkHsQJNUgMGCXM2DRx7U4c
 JsflVTe8hr+b9fTq5BkW2hi6Fz+sYrx8AhlBcVIuTnazoQ7lU18tmH6B9NLi0eY20AxghSrE1xY
 f6W/BJd2/jjCu1gUM+KYxvYmRYLm3EnlkbVuH7RcMok+lKHSfqVcsW9s4Cn2DJdmeUjRS+3NiS0
 srWSNpZCDID7/IvH12CwN+n3P1ZcOdl8qaDoY=
X-Received: by 2002:a05:622a:578e:b0:50b:4435:5dfd with SMTP id
 d75a77b69052e-50d3bb8e8c8mr200491cf.1.1774971854812; 
 Tue, 31 Mar 2026 08:44:14 -0700 (PDT)
X-Received: by 2002:a05:622a:578e:b0:50b:4435:5dfd with SMTP id
 d75a77b69052e-50d3bb8e8c8mr200001cf.1.1774971854318; 
 Tue, 31 Mar 2026 08:44:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c838931b9sm25387461fa.23.2026.03.31.08.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 08:44:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 18:44:10 +0300
Subject: [PATCH v2 1/4] dt-bindings: display: waveshare,dsp2dpi: describe
 DSI2LVDS setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ws-lcd-v2-1-a1add63b6eb6@oss.qualcomm.com>
References: <20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com>
In-Reply-To: <20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7geT5bkEq5ZiMOxGkUOHpZ6vimPzI950/l3utWM/ns0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpy+vKqWkIXCC8n2pqeps0iNjD2ADk2hGP/BfNS
 xB0eNmeWxmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacvrygAKCRCLPIo+Aiko
 1TNHB/wNkKsJjn3GwA53zKWKL1Sb2OqwwHB5UsbQNMKN2tscHNPIRYzegnDF6BECXVTn7XvtALq
 kuaGr1UOS8O8trvHt1YtIjRQpC4dMLNYZZg83141Ik7/4eJFYzdduD6ACEoDEAqd4q8OmN7WcIy
 9+XePbFQmx3Oj3nFtDXsn8LZ7L0lSYwkI1iDklgyDInxKdzraiBJ7824VoNDV+29JOTQm9sYOFe
 D5uBpHMgb8ILUd79YutWoM64532wQEzCceaz/wO/axKBIBhmyN7X1UE0MYqjoXBAuFn1aEGVkWa
 JkbSAV1e6DX/Dj3X1FOcg3jTqdxodYZCeR2KcMYKzqIAkXve
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1MSBTYWx0ZWRfX/Lk8SuLwoz7N
 4bedIpnTwnf04zWFIQiLwFEKeIrcJfEuc9arZwI92JTE0cnWm/52J5RWCJuF93xyZv2jKMF8sKE
 3mskLHC1nK076lqX8nEcnjUp4vLUP2+yRkoDDqhaI9+aUS3QJt/Qg1+g8FwxKHNe1NojBv66gHt
 i5yfW6Vha0e6cv5vlSV+V40wY52xAVvuJYXuhAYWy9WoN/2EXQhXRuTpUaS1KEHM2SollEAmLvz
 5osE9h8vATv+92kYCnJ8TPikKJWqWHKJYBAkGVc/JBZ34fIsjqsqbxpkCuZFP+OTEkm3QpuFzaU
 yqfGDNbQJN5DieNA9sjUoGDHKr3pVbZjEmlz5ppDYR30H5WX2nv/pUC/K/oTBhZvlfyNTLGpQ1y
 Q3C5CWhEhPeNtN0YdB5mYEzjPMTgiLHnVtrYIIFuBQCDqI8pD+Vc1uXDKQogWzj19zqbOHKM4SG
 f4M+0ocze0aSFCoCJug==
X-Authority-Analysis: v=2.4 cv=K4wv3iWI c=1 sm=1 tr=0 ts=69cbebcf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=8AirrxEcAAAA:8 a=7qgZ0iPFU4Zeudp_5JAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: WvBR7tQzVU8vbZKuZHwfDaLASE21qMlV
X-Proofpoint-GUID: WvBR7tQzVU8vbZKuZHwfDaLASE21qMlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310151
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

Several the Waveshare DSI LCD panel kits use DSI2LVDS ICN6202 bridge
together with the LVDS panels. Define new compatible for the on-kit
bridge setup (it is not itmized and it uses Waveshare prefix since the
rest of the integration details are not known).

Note: the ICN6202 / ICN6211 bridges are completely handled by the board
itself, they should not be programmed by the host (which otherwise might
override correct params), etc. As such, it doesn't make sense to use
those in the compat strings. I consider those to be an internal detail
of the setup.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml    | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
index 3820dd7e11af..4d34a92192bf 100644
--- a/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
@@ -10,11 +10,14 @@ maintainers:
   - Joseph Guo <qijian.guo@nxp.com>
 
 description:
-  Waveshare bridge board is part of Waveshare panel which converts DSI to DPI.
+  Waveshare bridge board is part of Waveshare panel which converts DSI to DPI
+  or LVDS.
 
 properties:
   compatible:
-    const: waveshare,dsi2dpi
+    enum:
+      - waveshare,dsi2dpi
+      - waveshare,dsi2lvds
 
   reg:
     maxItems: 1
@@ -53,7 +56,7 @@ properties:
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description:
-          Video port for MIPI DPI output panel.
+          Video port for MIPI DPI or LVDS output to the panel.
 
     required:
       - port@0

-- 
2.47.3

