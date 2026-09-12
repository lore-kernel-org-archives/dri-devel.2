Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58177C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 21:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E92110E4D8;
	Sat, 12 Sep 2026 21:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ndeU6AQ7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gq/g48vm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C7D10E4D8
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 21:37:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CLCLUD4054513
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 21:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=; b=ndeU6AQ7n14Bm5mH
 uJt6386T+qEQJJC2L5Gd9Leqq1nj0ruFP/MhVVh5kSw/ovQwySCS+NeNbuHdYjUN
 7SUXyuZ4LWPh/YQB/80XuMoOI/XywhqY+C6BErsAXVLjA3v9gYxLjFk+6baVZyPp
 0A7espEo49jT3n4e22ZyNWhwUf8eCIX9WN6CAvokR6vuGOyv6zUmOIcVsHpbXZ7S
 wRk3fhv6exKGOE5POE7Syb9xHXhkIWriF1oTt4AM8e32nTlNXY0O5sHA6XkHAUHy
 ql1MGqcwfoArTJUEz8kBSsUCmrow8hsa4UI6AELmzRPnMebPHyT437XOhYoU5KFS
 NHIMDg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c1y00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 21:37:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so29244445ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789249070; x=1789853870;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=gq/g48vmAJoalWHmP5KMkZPD4uZ7IjEhUU4E/AVTBT9bKt18WObHsv0HYjId9GqqjA
 SUzB+FvcapYMJrWLmIGYRHE4pNNrTP5+QmAneJAU/ATNJXpCLnmA2d8DMZrNeSKerPbD
 0de/H10moXFHdWhl0I2ypLXjRYibSyAWWXlvzutH9Nh4dH+SL+aWJJgKtNK5DmO/lCPu
 RiPJmVy373lIuJpQh1QsrLm0+vcLmrtD1SGfqBE1Q8TR38g+1MZ4Ui5ABfTL/5McQCbA
 l0ko9RD82j7k7p3qfOACAWOySFxfvZ2oqzgDQABRvpEPFNmM8jLCLoMelYI25frfYCUh
 I2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789249070; x=1789853870;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUSdb7GhbdJGsEth6SJ34W7vHVCnsU2vlRUxl4txdnY=;
 b=iGFmJCgzBsahRAP7her4BGWxpwkdVDd0a8drzOE5j3SYkqrTpEHCwWgAjIsDfPOuWx
 whdK9MiBS1blY5AkcUttVbDtL/tCxj366B1hvQX70EI0x2GW3GPb0zqK1iYxVY+NmuKo
 meMuDaPl85iGUvK3jAb7hDqdz4bo3AT1vfv+fJTw3uO1RmpG8Qi9PHWsqV3Tec6XTFPx
 qcPIaf3a+XqHPUYmwYXLHwfluCEkjmLCNfLzK1yUuGq/coRfSOCnMpUxC8U+MLYtS6gP
 PxalXIlAUynF3WYAHP0FJV25Y9KW0gbGhMN61GPp0x94WakmK5TPR2W16ZmjW3anarLZ
 KDpg==
X-Gm-Message-State: AFuF++lj6elnv8InUVyUcsew2YeaqQp5KI1xfp6JO9vxxHz38GtdmAqF
 mNI7FAghSp/FVCcUGFMr7NOKQjNc0T062i/sJktFhoUyldSulzvZDO7XsnQnBV/nMBPLJDTF6mb
 k2mp5lHNmh6g3/bUmO+lmDwWGrsHhG8wCMnwPgyxnY8+eR8R+wlQbDOv6tN1V9QwFZFnIss8WBI
 ENxmA=
X-Gm-Gg: AYBFou3xhMuWokHTCu4bpdUuVdSnKAGlJbFROqHrX0tZMdTzhEtjkkby1llQ2TDT/5n
 fgfk7BgR+C9lVD1XlqEYKHbpkuE6D1rO1QYzNoZdyFArb5aInq9kQFtyWbMAzeMWs0acJDLtT2g
 WlfKMLTSH5/WjSHF83uMegplM8ICd9/5nyzXQOk2C4UYODYSCwA/RDoVuFsGVOMvR4xKJ6wG9fm
 oDyVWdXUA7VQJLLvYgdaCoc83XboxIrBfX14eC/SAn73hK1kiOD+RFZy+gZMs5AIWODfUc/ATda
 er9e7usMHut+Xs8svluApdLcES7vY99NUcXiV+flSYlwh1YCG9wCLFW8iYYV6svQQhyGq2ZPHet
 Hp05Ib39SHYH5dLFTeCz/HiSZ6A==
X-Received: by 2002:a17:903:2450:b0:2d6:ff5f:eeda with SMTP id
 d9443c01a7336-2dd2a1f027fmr180077765ad.6.1789249069786; 
 Sat, 12 Sep 2026 14:37:49 -0700 (PDT)
X-Received: by 2002:a17:903:2450:b0:2d6:ff5f:eeda with SMTP id
 d9443c01a7336-2dd2a1f027fmr180077375ad.6.1789249069284; 
 Sat, 12 Sep 2026 14:37:49 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f0feaasm14987841eec.21.2026.09.12.14.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 14:37:48 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
Date: Sun, 13 Sep 2026 03:07:29 +0530
Subject: [PATCH v14 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-lt9611c-v7-v14-1-534b43a07662@oss.qualcomm.com>
References: <20260913-lt9611c-v7-v14-0-534b43a07662@oss.qualcomm.com>
In-Reply-To: <20260913-lt9611c-v7-v14-0-534b43a07662@oss.qualcomm.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789249055; l=2049;
 i=mohit.dsor@oss.qualcomm.com; s=20260808; h=from:subject:message-id;
 bh=ut+CndQz/jrWa/IvwRM0rWOCvN47R5Wgsw+GSTdue28=;
 b=JRLIa9O+Ei1CWlCfGQPz6+ldSMZTkwkNehDcLrQzB+KYZxgsyNjtmjulCQxx3H1ujtNe6o8rh
 fOVukMcWklhB2HVccFqqXiUWD16hRuhCc6yobWytRzDS+8pXh5vKbqF
X-Developer-Key: i=mohit.dsor@oss.qualcomm.com; a=ed25519;
 pk=outHVBN53JhozDw1xkj3G1qrqqE5scMBP7M4WL3aHQQ=
X-Proofpoint-ORIG-GUID: kc1HPonwuqxDXDsMI2kzZhR88_JQSccR
X-Proofpoint-GUID: kc1HPonwuqxDXDsMI2kzZhR88_JQSccR
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa5c62e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=SdC2vBNBQt3qShdCGKMA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMxNSBTYWx0ZWRfX4u/V6mYu9Dfb
 Rx8MafYdtxr9vjVATSIASfD0pF78ZZtjU+BENTPWIf8YjIZyCh9Ro3lumR6h4+n7SJ3/AC/+SY0
 LOMiqObFaEkMXz1lKfPMbGlOc1QjgTpyxoxQRYlvxvLN/fto8i+Yu308KMFwcOGv6C3j5tJ9Jaa
 V9erSISrUI+yrB7W4y8A2g0gbgO5bPzU9/I6RYbomyaR0hM0CZa9/auJEuax8JbrveWJHyDg5ou
 9lzjZtpxy+nbH7IpkRVIwzgXarQB82wluueSc+WbB0KPbnQSvzFyjGbJV20onRW6piB4HeRx9T5
 yWOYLO/zKCgmWn4sUX21Ha9DXiOTDTcr9FSSgIY2cfql2zo+kFDN3lTvOzcRG+y3gJZezZOCSrq
 FBBb9pX0XP4ZLfGo1iT5XkF+yzkxfujxef1aJVbKnsMecWdk4OZPi8rTj/cZtbjaIoZxbPyfAsS
 YtGuCMqtAjOYTD1MLIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMxNSBTYWx0ZWRfX3kJv03nx3Sp3
 BAnd5W74RHyFzFfb8yCM0gzCqgVUrpWJXXN9/JFWruA9Z11TdRdElegbc7R2MZOJGOXD4Ub1pfz
 KnOFMQueW8fBFcS9+oGUCuYzdMXP6B4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120315
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

