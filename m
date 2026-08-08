Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE71AC5AD2C
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 08:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1542910E434;
	Sat,  8 Aug 2026 08:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPy1YKf2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fMjpuUSx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22B610E434
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 08:08:07 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6787VrSB3062617
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 08:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=; b=WPy1YKf28LOJOgOH
 36nStU2C54HGDAfPSNx8DlfW+tN40Uqobu2i6hSPLkecqlq6dEDexfcylKnoOzdi
 6gl//BeEVI2GW9aOyiMh8QbKr4KaNY9ZaH6b5vguGQROYFCxPpzJPzwbt5Z5Zyqo
 bmxPxhdqi+oK9/az81crbJmaNEUpgMKl3iHpfoevKlcW5Xyo5S+a2oLqN9MYvZOe
 ugE1LUb0qcQpvEsFXyPmv6C28Q1HnuuZl8lf2cFVu2t+M8o6AJOnGlUF02dxAqoO
 Fx0IFNWJk5QalCwyguRA0WI6x6ti0cnqNYqzRqAqGnJxSCYRnLRFHqfqpF2GBfL0
 kVKUAA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwr9g9u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 08:08:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so846786a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786176487; x=1786781287;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=fMjpuUSxWKK16Yn2dCzeJL3FKYOA5jViOqo/VkaX7I9g3m2YQlxTkVHYyDeUH1zcPs
 Liv4/5uhAAm4uWjV8zax1JnYkCs4+666hokZftSIK3VWcrhHfA54MTtN4zcjDchpRpuM
 JLUdgBg1WT0/iVRRu9Wswzb7pE7GKfEsKjJGVu+htfm61xKmVRN7plU6CN4nzW58xa48
 UjyndW9V1k9wSP4je7jO2wP7sPFvUVUVzu76h3gPBiwF0JYECdltNtfVaNN3Q4WL17TU
 mJdHa0H9MFoERFRG7uXxPzQh7zMLQWzkL8IcIS2JkRlv5Ua7N9yBIFT1skURjOhpWag+
 oeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786176487; x=1786781287;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=ewy7myWCgh2pPJd8DrS4fW/+HUM16yiHCX5VvrxcjOwp1mzc35g16v/Bj18h/TPk/s
 Qby2ER7R0lrXAY4KVTKxCu2CmpfT06kgJQ0tyd9WypNyo8ICWvgIgUZlmr7yvoC5Dj//
 XfvIdINWP/2nuKQCLZfvQktjRyQ2BaADG2d6VumlGtJV/A6EUcg15UbDihVL/D212xjH
 kFGgyD1EhRhq/+FdrHpvgosGa7Qmlt+Uzclp9S8pQtWm6xAboBuFXDW3qmdl6ogjqgEr
 Mi4f25lXNFdVWghe6gP2vxgRCieBID7Uts+RrQCTB+a5+8IxaUP7glwKCO+KDojn/sVM
 XWaA==
X-Gm-Message-State: AOJu0Ywr6zMPaz8ak6oBWoJgjT5FSlglWslye6OprXbyoWULkhIkLQKP
 uLOaaO2J/g7CvMaJs7NHHmiHOh7GXHVv5QON2J5vs4DsdiPQ33Y1dJPA3S0JqXxSLWQ8Fbr46BY
 JaQ6lf0t2f3IRI4VnoHMWY0OlnO6cQ7/cs6hlyHp25hvmia61h0xptv19xy9p9l16AyUi44k=
X-Gm-Gg: AR+sD10VULYdYKIShF5xhfwThibWUxP3ih/Dvvceh4IMwTwaam4zaH2LN6d/H8FrQ4B
 yFjz+uCa4Dxf2oCg5YRMYeKazIwnOXFHHHHQLnZNcmzohu7YSEl3Mr2SrzXplPhw2vNYpz2bRQX
 l0VQM0zYhlecDiA8653x/twfDQjQy1d5+4m5KBE6hh2tczVtnWtI6eywJcB/cTerlx7xhhEnHQl
 bCVOg8UHmKcSaWWbY33I/QrfsMLuHwreoMiG6quc77q3y961njuc4OzJ9wwM5ECm/2W+cg/HRU6
 K5gSKDhWcvd2fuBwYnao2kiX9oU4/46GJFY2KJWrOWBiCVSBin3kzxaHNLr7+bWyFB/G8lHsFok
 9OYSqMRhwcXzyBw+8Q9pJm/y0HA==
X-Received: by 2002:a17:90b:3b45:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-392621444f0mr9275831a91.15.1786176486637; 
 Sat, 08 Aug 2026 01:08:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3b45:b0:38e:4f41:83df with SMTP id
 98e67ed59e1d1-392621444f0mr9275808a91.15.1786176486258; 
 Sat, 08 Aug 2026 01:08:06 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085f2c714sm7497465a91.10.2026.08.08.01.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 01:08:05 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Sat, 08 Aug 2026 13:37:50 +0530
Subject: [PATCH v10 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-lt9611c-v7-v10-1-ee90a136d82a@oss.qualcomm.com>
References: <20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com>
In-Reply-To: <20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com>
To: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, vishnu.saini@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786176472; l=2049;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=ut+CndQz/jrWa/IvwRM0rWOCvN47R5Wgsw+GSTdue28=;
 b=RSfqZgLlC7ouqQF3CnuaxrweixNLlxltxLDU4C8pViE2bAPJqX5Hj8K0QpSgO4pk883unA5jL
 a3tM6oIPSfmBbA4hsYq00GVy6OIeYNxqT8uCRRwEotULJVLeR01lYOF
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Authority-Analysis: v=2.4 cv=d73FDxjE c=1 sm=1 tr=0 ts=6a76e3e7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=SdC2vBNBQt3qShdCGKMA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: ri1xD6lXMY_D5FQNPTWkwRrz6xvARnAQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDA2NSBTYWx0ZWRfX74oMX3Fe7mfy
 RKxZtBYbMzMLj3HBP3dpWTokRXhY0VjBqSxitXp8rB05taeumFWCdtdn1aoOpmdez8VFvUtlNs/
 x4Mo3S1/aSS8C54X6jUubXmHZsWFycVcQTHGTUsWKsBqm8Vk3R3iYWKtwF8+DstqRYM/Im7Dnih
 /FKOwnqLeDgBx7iUbiLjIgnTR1pPuo0iWLyJ1FMTYdBW8sMNSYx0hFXrwax4c1h5+fOobTVmVns
 s58HT7ZfXNfk67PI6lZ2E3XsqQ3NH/Ng1OIqM0JqL6jz9keUnFuQGB380c7BiIJT6m/cX9PSdOv
 RfnqRW9VnehnEI1G/70ohue9wpD49kRJMalmCX9BuPx56ULhpC4xMcohYHYvs0vJNhpDEJrnI/W
 2Z6O5DRS9CYanKqkdEb0nCN8oOLVbCbqRdEwKgG1WPRNoa9c5KQc1McI/wMORNNKeP6c4ThCVEx
 Exa03Wp513aRxlSxfEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDA2NSBTYWx0ZWRfX1ZiTKLhinQqA
 pQ5g+yd63BtYOhJyNEQN8uhzbGV1pT1jgaKHksUdXEGYy8Pvkyk3MFxKgZYALi51Hch22EceJVI
 oZvqlyDMsi9aGVks7uf+Ao6dlrcjEm0=
X-Proofpoint-GUID: ri1xD6lXMY_D5FQNPTWkwRrz6xvARnAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080065
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

From: Sunyun Yang <syyang@lontium.com>

LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
mipi dsi and output hdmi, differences in hardware features:
- LT9611C: supports 1-port mipi dsi to hdmi 1.4
- LT9611EX: supports 2-port mipi dsi to hdmi 1.4
- LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Sunyun Yang <syyang@lontium.com>
Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
---
 .../bindings/display/bridge/lontium,lt9611.yaml        | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
index 429a06057ae8..194aeaac601f 100644
--- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
+title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 description: |
-  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
+  The LT9611, LT9611UXC, LT9611C, LT9611EX, and LT9611UXD
+  are bridge devices which convert DSI to HDMI
 
 properties:
   compatible:
     enum:
       - lontium,lt9611
+      - lontium,lt9611c
+      - lontium,lt9611ex
       - lontium,lt9611uxc
+      - lontium,lt9611uxd
 
   reg:
     maxItems: 1
@@ -78,6 +82,16 @@ required:
 
 allOf:
   - $ref: /schemas/sound/dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: lontium,lt9611c
+    then:
+      properties:
+        ports:
+          properties:
+            port@1: false
 
 unevaluatedProperties: false
 

-- 
2.34.1

