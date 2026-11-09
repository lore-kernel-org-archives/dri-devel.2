Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23505606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SZdk3bvi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ANQJa8DL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5DA10E84A;
	Mon,  9 Nov 2026 06:27:43 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0C310E84A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:27:31 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96AI4u3634656
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 06:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9lJO8yrpw3BUbzBS4kl1WsJ8PY4vORMCggNcE5/sowc=; b=SZdk3bviUCE91hQG
 +Q1HYTnvnlwwCEt/zwKp3UmDMpzO3QHu20DCO4NdfxNR6Q4mVG2gjiK8YlObLA7y
 o39QtnGz/gigA8qJcgklEq0JDSk+FI2EEYXVoR1tVUy7NHPgoTVehOChqKsqsVMt
 CdzddI0gckpCtZTuSEEhE8idFmg/zueKSA6+TrPOjSnhhNuT2qwjah0qgBb7lPx3
 70qSIkvcBS7iSLg8JMJ216BGgOtgQr8UaCSp1GXbiKtu0rKcAsHc1LZvuDMDq756
 Qs2v/NbFB+wCVAz88edZSSicMnjzGag9yJtGzw47G60Mn4i1JnpxVgE5CwRZRMQx
 J2AxGw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2gd1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:27:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36fa5673fccso2803431eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794205649; x=1794810449;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9lJO8yrpw3BUbzBS4kl1WsJ8PY4vORMCggNcE5/sowc=;
 b=ANQJa8DLB8NoBiz8DHdpkJUaQGbDto19E/hM3OA8dBvGxfVYP5atp0/m209JekW/rh
 1X0b4qCkifQ2qu/+b1ZINVC+Vpcek67/XW4pLRIRAn1rER11yblXrvsAGhzFHdR0rV7E
 TnCTiwFnyRIdL++hLsv8zw0TntoEFotFSGoDqyy/sKSKKEZ4/Vp44taa2I81obV7sCZi
 vKHGaoowwh0ukcBmg+Y00eFnixhWZTtIdu5dvr6gXwHeJEkKyzcEcz8yHqD3WxxqFys3
 jvT2zWlq4Jy4MWz2Iz6g6qQQr1rNDwXIQhzE2rOwzLBjxp1OPcTP3B8TzB57xNXcmh8K
 GeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794205649; x=1794810449;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9lJO8yrpw3BUbzBS4kl1WsJ8PY4vORMCggNcE5/sowc=;
 b=DYNjLpzx+542PIxxxHSlyA53uepK+Uv9bXo8Wx1MqjfbnA+3XqaD+VszwGrfpS5zCq
 sDOog7ubPtcZV2I9lGpLzjnjt/eQFoKbVDjsoxYyIHBvrEUOmsqz8ba74cCUUCPfU0DF
 gNI+/fLAwAMGhO05mHOX7uKRZI6LoX07MBee16CMMoVOxA2Qp8LOXSC/LGLHZ4aKKQjx
 7IYnd79qU7NZz0VSWbRX2TkXUBmFoW1HAzx7Eo8jS9/a0z0WVdyFmJRSK0quD43K5e9I
 UJ82uzqOiEwz/xQ//Q4YfKicc38l7MvhO8e/AihCMIQuxHx5jyKlwt4Wh9BwjwOUKCuK
 pPUA==
X-Gm-Message-State: APuU4Z+MpZYZ3LQ8+xfYOOAmdlGuoUNketgFrju6VSvy2JjgEcAsdQeg
 Q2ebECKVOEws/F3/VflvOOGgN31Gho6m+1M3vv1gt1Z74NuY/F8TtFeUjnuCMxLZ257jFs4wY6v
 tdFIfATD0Kv43Wvu8LJ57zE9NA5TNF3TKVtzXCzd9+Bb/khpkqYYPhDbyTCregZpI1YQN6HI=
X-Gm-Gg: AYBFou2E7MnF48lGuqCgcKka3aMfeHN6S9v/eIMhOVcvLTWnerUetFOjAyWBYLupTKR
 79pxUrAmo/e70Mgh2FBbggUrkF1n04KONBjl8iYhobsA5v2r2XL1w9Swbuo8GpAM2BsoCQesJos
 oV+nDwf98InUWcyuvP0X4IuK8gnfLGDJBWcduLp8Jbl4iZ7iagp4W9Dfv7sCKvFDfNf+OB0wtLu
 yiA5V/JMid7psdAYN9s5KiiIslw9OjfmQybTzZOcZuyRew6PmJmjTcQCvndaI9pQUeLEKhWAKsL
 /RNsnKmGOunIxZDDoEmPe40nOxhPovwuzPFxCE4AUheQp/fI7irYUXxxtqTg8XkrIXwHxjBYI0M
 ylNyvdrapGw93kE0MqRYzmjOCK0Q8HwQHmTCMKtxu1rM7ncC7mRQOrxntnlADUgfZs+qWshMrCm
 +vGifW3w8=
X-Received: by 2002:a05:7301:dd82:b0:35d:d671:933a with SMTP id
 5a478bee46e88-3725dd59d8dmr5276180eec.15.1794205649255; 
 Sun, 08 Nov 2026 22:27:29 -0800 (PST)
X-Received: by 2002:a05:7301:dd82:b0:35d:d671:933a with SMTP id
 5a478bee46e88-3725dd59d8dmr5276136eec.15.1794205648626; 
 Sun, 08 Nov 2026 22:27:28 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372660f444csm15812458eec.19.2026.11.08.22.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:27:28 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 11:57:14 +0530
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT37802
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-jshekhar-nt37802-v2-1-a8e9efdcabd7@oss.qualcomm.com>
References: <20261109-jshekhar-nt37802-v2-0-a8e9efdcabd7@oss.qualcomm.com>
In-Reply-To: <20261109-jshekhar-nt37802-v2-0-a8e9efdcabd7@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jayant Shekhar <jshekhar@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794205638; l=2780;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=6A0PN/ZwhHfEEa/gLa1HSpBnzXndrJU0BtXt+eizvwQ=;
 b=fMXgzr8oSYD/JYtzoIIVvi3Mgn8Phaki7FN3OZeVHeGFDWA2gbXZc/75A9DHViEOdc+wsQEdL
 mrW7HBveoklAt0DgLrAkzJbsNgZs3pJPqYp7YWAJ+yoYIaQ6ZeDB1xr
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af167d2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=4LWvrIubDFmFlJ2n6vYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyNSBTYWx0ZWRfX7wDqu/MbGtmZ
 d/5q+iyf8S3fjjXfFIoemjIzKCGKCkQWwWGCsca1v2VdfY6wEXiZqZ8Bmy0rmOTkzqFaxEUzEj7
 KXWprmCAOoGgOFfpsGIMFu4bBwmRT5yP7Fldy6jo9mizSe6MsQuT5xzN8iALQbJxJlP6iksOupt
 5+ZQN/Fmw8Cks2G3kjLjy6kwCJEE/LJamfcJIo9DbNNT0OewS29Zc66q7UpVORzCcDfZpfSAuWF
 nyb774j345Uj7c7KP4LGssGHprSWi9ccqL6eXv9zMHBIhKtwNjVOH6AEQq4aMWqUAUxTssmbaqi
 05EHpoQwZjWycVU5+BIx26UWOB/cngsjvI0o0S2EGg5qKH8AzxY07CvfiUd4v0KFtP8kjDNDrvI
 BYmMgDH0Oo195w0VzT3U/2h/cAPlsPaoiW6vsKxC1M6QO0+wqOoqBT/adb4v/l8GPAmVp0TECfR
 gv4DUoouJ5Bmyo/41Bg==
X-Proofpoint-GUID: A6GqGwkFBmuWeVawZtAL9AMpo0o07zxE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyNSBTYWx0ZWRfX6RPDnLtvys/4
 VDiPcqGByPZuLs4FsqBs7yEXf0b3suT8K3hPa2FHm2dcIajxm5gghOXOQaciCabBa1UTRC1ta2Y
 0/1JdvTXpSwOHLtBLEOviiug1w+gTQU=
X-Proofpoint-ORIG-GUID: A6GqGwkFBmuWeVawZtAL9AMpo0o07zxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090025
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the Novatek NT37802 AMOLED DSI command-mode panel.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 .../bindings/display/panel/novatek,nt37801.yaml    | 49 ++++++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
index 1b38c1d0af68..be318cc84d52 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
@@ -4,26 +4,30 @@
 $id: http://devicetree.org/schemas/display/panel/novatek,nt37801.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Novatek NT37801 AMOLED DSI Panel
+title: Novatek NT37801 and NT37802 AMOLED DSI Panels
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
-  Naming is inconclusive and different sources claim this is either Novatek
-  NT37801 or NT37810 AMOLED DSI Panel.
+  Naming is inconclusive and different sources claim the NT37801 panel is
+  either Novatek NT37801 or NT37810. The NT37802 panel uses the same common
+  DSI interface and regulator supplies, and additionally requires EXVDD.
 
 allOf:
   - $ref: panel-common.yaml#
 
 properties:
   compatible:
-    const: novatek,nt37801
+    enum:
+      - novatek,nt37801
+      - novatek,nt37802
 
   reg:
     maxItems: 1
     description: DSI virtual channel
 
+  exvdd-supply: true
   vci-supply: true
   vdd-supply: true
   vddio-supply: true
@@ -41,6 +45,18 @@ required:
 
 additionalProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: novatek,nt37802
+then:
+  required:
+    - exvdd-supply
+else:
+  properties:
+    exvdd-supply: false
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -59,6 +75,31 @@ examples:
 
             reset-gpios = <&tlmm 98 GPIO_ACTIVE_LOW>;
 
+            port {
+                endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "novatek,nt37802";
+            reg = <0>;
+
+            vci-supply = <&vreg_l13b_3p0>;
+            vdd-supply = <&vreg_l11b_1p2>;
+            vddio-supply = <&vreg_l12b_1p8>;
+            exvdd-supply = <&display_panel_vdd>;
+
+            reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
             port {
                 endpoint {
                     remote-endpoint = <&dsi0_out>;

-- 
2.43.0

