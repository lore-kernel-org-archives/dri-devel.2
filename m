Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C858109B493
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41FB10E220;
	Tue, 31 Mar 2026 15:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dUEEOhSk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="doMFTete";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6CC10EB71
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VBZKUV1842530
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nESO+7BDMbX0WOtw7s5EKiU43Row0DSXtiOScNm/q4E=; b=dUEEOhSk0MB0qVG/
 DFIxuyMCw+5MU4Wn80Glk0aHehcXlU/VnONIPNVTm9KNab1ujpJvKIANx1c5f6/b
 om6yoHrOCgegWIgpgIJx4tLtpAHOj2/bF79Cd15BT9+BtLbT+egA5ko6vzVqrtiT
 6DcOJ2kSLix0mT2zlIncShJVA3/fokiMLusT+Eh567oDlvdxgBFgBx5lmtJeakKu
 hiaY9SFlcEO6KXnbGtNBQoXz9HW4ahX8QyluSVK8+7/u0EQmtC6AU0jnZgIhqovk
 a7dpa2Bto9fN5upNjE5mWgqT23YVU7Z1oBC0+ZjFcnPBnZuJVw0LezfkFYAwTiSj
 DSTHew==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80rskxw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b802961ecso76386611cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774971858; x=1775576658;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nESO+7BDMbX0WOtw7s5EKiU43Row0DSXtiOScNm/q4E=;
 b=doMFTetekf/8uqBNAuN2r4/zvpg3DyRxP7AFFrqP5mBgs6GJwxTt0NLSfCvoa3SNdu
 5qA6fl9dMLhEiLRS9xdXFXIUS9/1cNxqLE8QMVYZedujPpZwGGL9JqQs2W6P6wi7ea8y
 +PqYFAVO5FmYubfZPOC3Fq+SgFy6ix9Oz6pLgj4h+l+SXI4zSY2pZLLE93hbc0FT7G9v
 K5ewTzZFGW8lJfadskF8PhO9MZAjTkCC76PVWNg/xSMkRAkBwxCarWaKik4skSj8Ch4C
 VQSdkwiT/IjHkM054TMY83ZNkrSax7HYkHRZcwy8K0NDuI9sUfvtKt720fTN2kV6t7zk
 NoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971858; x=1775576658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nESO+7BDMbX0WOtw7s5EKiU43Row0DSXtiOScNm/q4E=;
 b=ofVg1q9VHGcWBgqgiTXItEVgFiIF5P05teFoS/26MCrxbbQNMfdKQ976/46Ke9edCi
 FWa0DX8SkdKbaSKMdPDLotHS/rWa6rxwApiaBNqDJuAJKZJJyEttZllujvcbANdjzR+d
 0nU6y7Q5VFqDyZT/6yWe4CFtM52/ys/ny0mcSFhu2rljEJzzONaOvgvJdsKP7c3zvm+g
 xdKXSfeeQxFRJvEsGAAGoZhBpYx1eeLZ234aAGqd6XwIvgwBfRgI07xkuXyTuI4PygZC
 s1ajkcJJMo81KU9kQh3fk8/BD6Uy1n13yBsTuqvUhVwX3A6p3EgCRtBinshBFBcyiPoE
 4UtA==
X-Gm-Message-State: AOJu0YxhdEhtPdA4Hihr3mnw0Q65wKAPGruduc6CBwF9kVzekVSq+Tz9
 ay0EkGWyZDis/laB9cH+g8AtDG5JPC+Y7TMYRaEaUsa7EwOOl46p211K3NqwOR/0Pd5SfZM99Lq
 KULMhZ3Dvee5namNEA5Vl/8RF2vIR7YKM6aZoF3rRjnx4JzKm2KZ2aabnPwruj8slIm0INDA=
X-Gm-Gg: ATEYQzz4AD8UaatKCwNe7DXiuUEYxsDD3Tgl9CioT+9rJADLd4CX48uy/SLGU2Ot83E
 TYM9U6/LdSqAOPyXpLuRTHE1ifkh6Bv/19hzaeBNDEf4Nc8xC0qLBR8VUQBz4hHQZTP1rzl6AWY
 VYGmEOES97dHsp4+80AT25NEyqHRxZk9X8x0FU3ut0eW1TKT9oRC7jCzV8KYDMwWmmGbfhO3uEz
 oK70hsb4FUEdVZB4aMFPj0JFx2b8/vw5ulbkCcea2D64zklwwKTjuw8WO/KNeoooRLMyXOHn7rE
 St1msiNXG5N4rn8g8PUYKjDFFN8MBlPXNaRpVnNErYAZKIAiHXG4NgaE9AVvg2TRrTIiPblL0Mp
 0SocEWEXvYAIykeCPuS+zNVPo57xONq1GeTmrc7qJke5F3ddgA9OTihu6fV04JLFECNgL07CPID
 +5V9lCruHur1JUdHVjIGqJfY9+WymxaDO9ij4=
X-Received: by 2002:a05:622a:1e99:b0:50b:3e14:47f5 with SMTP id
 d75a77b69052e-50ba3918d3cmr223748101cf.44.1774971857977; 
 Tue, 31 Mar 2026 08:44:17 -0700 (PDT)
X-Received: by 2002:a05:622a:1e99:b0:50b:3e14:47f5 with SMTP id
 d75a77b69052e-50ba3918d3cmr223747371cf.44.1774971857373; 
 Tue, 31 Mar 2026 08:44:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c838931b9sm25387461fa.23.2026.03.31.08.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 08:44:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 18:44:12 +0300
Subject: [PATCH v2 3/4] dt-bindings: display: panel: add Waveshare LCD panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ws-lcd-v2-3-a1add63b6eb6@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=kOrsLLql6SeNEpGZuqe3iM109imXDdNUD6rH11IV+eU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpy+vKTf7HPSFGe/zpHn5roYYMVYpcNcdSULUMo
 KxV5HedoSeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacvrygAKCRCLPIo+Aiko
 1buyCACORV1nra9xC2den1laru8dqfDnTGVIvuPr+Ut16KWuO8UoQ+2Ha9W7/YZMC7yB72ULcN2
 skMmeY3nQlWUDDvDnzg/WeltjfKMihzZkGo6J1PREuZ+MJ1FuUcd1vB96W7rdbaRxtkq5fu4uXY
 a2/0ARDrmw2PjAaS4CmaR/gtyQlEqfsHQdv+pasg4Qp4jKEY76mlntrhWSDJGynsiAWlrtVFkMO
 GFtSlOHKg7An0B87oG3zAjTmNR023KmXHDNDUov3Iw0bZ+5QSsyciqnf0QAFpnz1GoJHU4irFGR
 kteqk2fa7LcHvcz1Ae3Aztauw0Habc1TQy9IpjgW5v6A0T8P
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: N0dWyrKudvrIQFNDp27om-T3AhG3VqgQ
X-Authority-Analysis: v=2.4 cv=VInQXtPX c=1 sm=1 tr=0 ts=69cbebd2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=ovjr5O5YrjmXieTAoP0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: N0dWyrKudvrIQFNDp27om-T3AhG3VqgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1MSBTYWx0ZWRfXz4jypTmVbbCJ
 as9s0YNqrm6dqXErxpth9uAPJH6ZKqmDnTu7sqz3i18VbsaZ1gMJu8ib2Ns5psZB21bdpbC6b3M
 8D5VnVDpHVoNpOj05Bd0BPTLieKQ8AYbFiWtVybk68WCn5RH21uVDBS5Fal5ri/Ifbd0EdnNUg4
 SrMRCZp0pr1g5Z7geOzsYeJtIaOCgENhiLl2ddUa0T/fNcjrIuL9KvorSaCNHK0H2F/fdvG7twZ
 31ZEUhydkIM22xLBo61a5ETx7mqwFoME57fVsHfxKkYRBH+6On6/dfzm5PBqQHK4J4IahUb3tWz
 I9WAHZnlAiRhGBUFDuY0RssTexGhjZluFQCwCuq7MGiG/ivMYZPOfE55E0p5zPFVGwO0820dkQg
 Ev5eDwONTj11tL+cOM/G1t92aRG0jXUWczpcs7e/neY2eeiy1uSsUT4whnEsnj5iiTp24hs6cNp
 YZU5KYK9qIJlV644Chw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310151
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

Waveshare has a family of LVDS / DPI panels bundled with the DSI2DPI or
DSI2LVDS bridge. The bridge and the rest of the logic are covered by the
waveshare,dsi2dpi compatible. The bindings already include several
entries for the panels from this series (waveshare,13.3inch-panel,
waveshare,7.0inch-c-panel). Define compatible strings for the rest of
the panels from that series.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/display/panel/panel-simple.yaml       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 9b8fa03f7cbc..c9ac59e04118 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -343,10 +343,38 @@ properties:
       - vivax,tpc9150-panel
         # VXT 800x480 color TFT LCD panel
       - vxt,vl050-8048nt-c01
+        # Waveshare 10.1" WXGA (1280x800) LCD panel
+      - waveshare,10.1inch-c-panel
+        # Waveshare 11.9" (320x1480) LCD panel
+      - waveshare,11.9inch-panel
         # Waveshare 13.3" FHD (1920x1080) LCD panel
       - waveshare,13.3inch-panel
+        # Waveshare 2.8" VGA (480x640) LCD panel
+      - waveshare,2.8inch-panel
+        # Waveshare 3.4" (800x800) LCD panel
+      - waveshare,3.4inch-c-panel
+        # Waveshare 4.0" WVGA (480x800) LCD panel
+      - waveshare,4.0inch-panel
+        # Waveshare 4.0" (720x720) LCD panel
+      - waveshare,4.0inch-c-panel
+        # Waveshare 5.0" WSVGA (1024x600) LCD panel
+      - waveshare,5.0inch-c-panel
+        # Waveshare 5.0" HD 720p (720x1280) LCD panel
+      - waveshare,5.0inch-d-panel
+        # Waveshare 6.25" (720x1560) LCD panel
+      - waveshare,6.25inch-panel
         # Waveshare 7.0" WSVGA (1024x600) LCD panel
       - waveshare,7.0inch-c-panel
+        # Waveshare 7.0" WXGA (1280x800) LCD panel
+      - waveshare,7.0inch-e-panel
+        # Waveshare 7.0" HD 720p (720x1280) LCD panel
+      - waveshare,7.0inch-h-panel
+        # Waveshare 7.9" (400x1280) LCD panel
+      - waveshare,7.9inch-panel
+        # Waveshare 8.0" WXGA (1280x800) LCD panel
+      - waveshare,8.0inch-c-panel
+        # Waveshare 8.8" (480x1920) LCD panel
+      - waveshare,8.8inch-panel
         # Winstar Display Corporation 3.5" QVGA (320x240) TFT LCD panel
       - winstar,wf35ltiacd
         # Yes Optoelectronics YTC700TLAG-05-201C 7" TFT LCD panel

-- 
2.47.3

