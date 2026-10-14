Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C54CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE4910FDB3;
	Wed, 14 Oct 2026 16:19:41 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C518510FC62
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:29 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbxuj3644305
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BL4vTvhY22+WkGmvg7vp/kCyClFOGVcldDZlDDXoP/k=; b=pLWb0ROcOc9PtZgX
 7HgmNxOUcneULNYEVNi2ruiFZUCuFGvnp2zDcjll6fdbOygleoG3oO7ZWAqrGyAc
 8G9ok3MgrzW4YkzVXJZQJQw/NOnmnmGTV/F10ZThZuRtkc/pSL5VV0SMWlD6uwLb
 GlQZ/7OQHHy4VM6ZOmkMt1uOLOCqBP6klqeoqjAs2dlmUNaWEmGW+4UzPWsCD1rE
 Kq0ubDgtSWr9l0IqJLjC/qSAS1+zM8zxOizBiS/22t6agSJjXpA5QPGY7KA/QHEW
 sjIF9CDbcli6JuBJ69N1z64gcq3wA3FCbXJRtJNYd88Bg0nu6CjGMPcXTAVaczBD
 90ilSQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470aeum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a3f673221so1313421385a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791994768; x=1792599568;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BL4vTvhY22+WkGmvg7vp/kCyClFOGVcldDZlDDXoP/k=;
 b=YFDoHMX4oTFa9+Mp5kWxVbWWfpfDR2NbFh8UXMmJdzcN8Wd7X75legVUii3WGgRpL9
 rMy8Y3/IctZ04lg+k9jdLEsBAZ2FeFAgHwObBtL/KfAZe6Ln3nyEs0q49MBajlK5LnpR
 dT9l0PvQrqnuKfCA0uVKbBQamDrK0i1LyUqsklRRPfdwJKEZ3Qm+wkbo/+dwtGLj+wwX
 eqcZoU3wkUJ0lMu1U7cAWNSqmt2bhfIov46eomZ57j9tsEIDkr9r40/fbo80ZhJXaLz7
 H3SddP9dgtKTLzAU4j/M69XxcoeOViRDCtXKULiUUoqGgyfLL7j4pBERFkGxdwdOsvYs
 1Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994768; x=1792599568;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BL4vTvhY22+WkGmvg7vp/kCyClFOGVcldDZlDDXoP/k=;
 b=QQdOnywZFROoungmO20ZKiVsj9S9zLQR710810/2X2fs4Nn7I8k2FeHGrwDLVFix8y
 6sHXXQO30NvNLWwoOFaNbWEZ2uW7sZjN8IHzBf5n3BnSfdDpyhEgvGwGJMpn6h8z4FPS
 syCjYNSLB+03cFv8CBOFgxPOlcpw+Ci1s4m1AQlyZP9If+Vcm1oIKpxowe1aousrCTZR
 VXrswK/YoDfFQAMTNsMEexSE6/bIZWReNVhU/lJrN82fcSRd99joDj38rUlNmEtx/YAW
 633kOBQ3LatybCHvbjCjzi/vrgb/OyaS9n9X3AhqLeuKNclLrCo+QufWdxHojcBkLKSZ
 UaxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZYerO5NpdVBSzfjD3794WRwZsjEZVJvooI5bhkLDi/AQ5C4/XC136NB8pxaSpwm27qc6LNLMUt1g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLTXPIxUMnBIcMPmgRhM+5/+LEPKFjKAHGkLMY6OCHUVFNM9XU
 n/8XUjbgYzfQ7A7zuHNrieOHjjpoKRy7IZfOemrWMNms0p7kWuii63M43s1DNtb59JBO6FftTmt
 VCZ5N4wOcCHaKYq+wPqdyz77KjPBfLLIjQfx1M2NHJL1BYX7Y6JTOlNzdcx4RHGXiRsuoMeA=
X-Gm-Gg: AYBFou2KWwE+VH2Iuo3MjzaShIfXimv3mvBD3u8wdWYkKyGTPLNDeCkTVMi/nAd/HYz
 +GmlZ+Bx5PIJ1MEYUfglCEtwCovfmnn5d19c1I8J5d56teHzaSIFvK48hvNonCL3/B88wU++SMl
 DOhF6TDK9YaNwxZ29wXnI7qEEVdy4F5QoZ3Xw1L4jJMjslCc0sJSOTs2HPT7GFwD8l4GX83S7ZY
 W9fponjvYR361QgEzZVEezhXWcx05lXzuwTqLXoFCjzzEAO3xuwTy6MN3K25woSXM7dnWTTPb7z
 LlIG1hG37FckdVDFKixDoOYBTbDJytk0hQAO4A4uePlWJvqs4jX8A4ciiOwmnBt9sSLkbuvn5fn
 YjAj/aH10tcLritNBsjF+j2BkAlwGB4qCBOuC04LHIZC+0FifCcUdyO5iRY2uB59yI0VG+bzHe/
 KIp4ZlCDs8E0Xl
X-Received: by 2002:a05:620a:17a0:b0:93e:c12c:fbba with SMTP id
 af79cd13be357-93ec12d08bfmr2614211985a.71.1791994767723; 
 Wed, 14 Oct 2026 09:19:27 -0700 (PDT)
X-Received: by 2002:a05:620a:17a0:b0:93e:c12c:fbba with SMTP id
 af79cd13be357-93ec12d08bfmr2614198985a.71.1791994766522; 
 Wed, 14 Oct 2026 09:19:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33d7d0f6sm740187e87.38.2026.10.14.09.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:19:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 19:19:16 +0300
Subject: [PATCH v2 1/5] dt-bindings: display: panel: add Truly NT36850 WQHD
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-sdm845-hdk-v2-1-6d0b4b42f267@oss.qualcomm.com>
References: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
In-Reply-To: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3208;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fT31BRXck6wLmrm1EKJZG7Thy04mm4/J5d4uR4ASm/0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqz6uGAFgE0CkXa4ltb/f9AHLvc+RyB+ghur2s4
 EONUgy3x0+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCas+rhgAKCRCLPIo+Aiko
 1XnOCACRQNTYxqCdZS4yKkEgV2Tryf5Yu4zl6pjDChuPjeenHaqwL+KrD1wNA+bbqoPPZQN0lpH
 QUBsJU0Yz/uTfuZUuDE0UBoiRJt7JUbcyedFA66VbM2yGnK5lvoxdWW+Hc01veBAna/Y2bjQoDM
 Lg5N5hp1iczJhhcxtUgjwM9kRq8cAE8IdKqoiQr6sRZQ5zVSX2cCmagiqV854kfbTRrc3M9gpWz
 5yZ64SoxTmW1MBu/K30bvLrS8tike1mU1yENkd4J7GDzTEgqqbKRSalJqP75Bh4DrJcRFHYap4S
 dBIfTBlEPIwM0Odb9kRTZq80HPX8nw3AynzOiu+y1RoN89bl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfX4rHWjfcdwDcj
 Fio+6JgiKznnRp0jLI/ZPebw9McMXphDgN8L4wTJeb0HQhWCSPg2rc63+X2k2rBxDkQsLaX6Ewt
 TcU7U4qwV+PbtH4flv8CyT0EpVn1Lm36C55GCrIcpGlDeFgGQ67bqa9WlTAyteNzbcAxdKwmw0V
 wf4kMgtNZkWCwvNVJInPFuP3tzagSl8TE7VIvldaJkusfGl73Pm2MK9ewHD0J7qxmuWEyew2Fvc
 X81gan8kSZMucpZxtOI+5RJVOfA0YeBxei5GXpUruWd356969LI13sbXevqiE6GaZ1INzkw1CN5
 8Ak5PF//61dfp3RNAQCvQS1yIIfAvliTcTCQTu3me0mWzZB4xufDoSIUuNRv9cOzZ7UYqiIrbmI
 7nM06s14v0CmlVA4QW6uDqZupM515meGascpf+ZCd6xV1JIfQVyG3dnxbvPDQs8z3klzTumYvqa
 ZFcWB7EvUbgvUSqMCGw==
X-Proofpoint-GUID: N4GBmXJZkBIDg4mTp3U08ppoeuY-W-do
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfab90 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=od__NDLvqBWtWXuahMwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: N4GBmXJZkBIDg4mTp3U08ppoeuY-W-do
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfX+VjvYv48RwDG
 0044MJP9cx/S6qR8jXlvNmPdLP4ElHgGEYcj+pBAC7FPKGTpHZ9WXTGp28YQ7hosmAXkU0i8vbH
 5FweWj7cjDYjs0fuRW8IuzujssdrcWk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140064
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

Describe the Truly 5.7" WQHD dual-DSI command mode panel based on the
Novatek NT36850, used on the display cards for the Qualcomm SDM845 and
SM8150 HDKs.

The model name of the panel is not known. Neither the vendor kernel nor
the HDK documentation mention it, and the panel block cannot be taken
apart completely to check the label. So the compatible is built from
the vendor, resolution, refresh rate and the controller name.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../display/panel/truly,wqhd60-nt36850.yaml        | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/truly,wqhd60-nt36850.yaml b/Documentation/devicetree/bindings/display/panel/truly,wqhd60-nt36850.yaml
new file mode 100644
index 000000000000..1cc63a6adc7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/truly,wqhd60-nt36850.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/truly,wqhd60-nt36850.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Truly WQHD panel based on the Novatek NT36850
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+
+description:
+  Truly 5.7" 1440x2560 60 Hz LCD panel driven by the Novatek NT36850
+  controller. It is a command mode panel using two DSI links and it is found
+  on the display cards for Qualcomm hardware development kits.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    const: truly,wqhd60-nt36850
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O voltage supply
+
+  avdd-supply:
+    description: positive bias supply
+
+  avee-supply:
+    description: negative bias supply
+
+  ports:
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vddio-supply
+  - avdd-supply
+  - avee-supply
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "truly,wqhd60-nt36850";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+            vddio-supply = <&vreg_l14a_1p8>;
+            avdd-supply = <&lcdb_ldo>;
+            avee-supply = <&lcdb_ncp>;
+
+            backlight = <&wled>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    panel_in_0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    panel_in_1: endpoint {
+                        remote-endpoint = <&dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+
+...

-- 
2.47.3

