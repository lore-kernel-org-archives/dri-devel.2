Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A539CC6B2A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1173410E51F;
	Wed, 14 Oct 2026 23:51:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C04B10E51F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMYNPQ152717
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BL4vTvhY22+WkGmvg7vp/kCyClFOGVcldDZlDDXoP/k=; b=Nw1VGvWDcRuOvcdr
 EbE6sGvjtyEPI4XcPUD++TzvxNaj+u46lzdW7uttqFc7jNMUn+cDTdaP1Q1Zu8BV
 YTPgkLqmDuPUxKS7pU4CRunM7yorQmikpqj36mmVD+exlqfbvTcidmXTJZknxlHz
 4P2TBUDbdwHM+6uR1E/ifnsR5adue4UE4ohsAsjUTWx/BFBtG5C4IQ08w+N+c18d
 UN5EdxNUog61cdtmyFJqmUtuYF8E91/Lmga4VBSfTcQfwwK9Q7pFBeqAg56AhMoJ
 xgviQSzxvMdPufZCX8JJKl8EfzGZQT6KtXCaTlU6bRb/7HZcAQt7MT8/gjHqn9um
 03KaAA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aek49w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ce7a85f04so1019553085a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021890; x=1792626690;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BL4vTvhY22+WkGmvg7vp/kCyClFOGVcldDZlDDXoP/k=;
 b=AR7/zLcI8TN3ou89ckjI22chW57oAAPT6N8hIvZb1zcWHD7Gx4qHe9R9UpEVjXOTzz
 V/sOnRkeatlKOnr8sssRjFnYWTqZvLT1eTqb/WICbDAtTDIl0GV7C2PuomTVy+bSaXOx
 R8ohdFze6kVaaDcE4O7Yv2JBEfdDgqMKZvEUjqCl0dhZ/cgo6YQg653LwB0EGyfXXr3h
 88TYQRAnItCtBV26fEMavIgKyJZyniQkR8z9fTJ321wE4reka1ACFYpq5GEJOzv9FM05
 FZTirUI0kLyiZaDMxUyHUyI2kUEv4g6CtxUGd4trrIJ0eVZSX60A/WjNaAXsaNfFimMD
 sibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021890; x=1792626690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BL4vTvhY22+WkGmvg7vp/kCyClFOGVcldDZlDDXoP/k=;
 b=yDLpIMYNuqqrOni99quio2Pv+6eskPbxfjPOf0QUE2tgm6hvLztGRBxn9M1WYvLomF
 F3QnPI1yLhHHyFcXCJPzlz7gIKARGJDen6yU7Kx4SeanHxJQQ7Lq5q3psoZvNVvLJsEW
 gKsAz0AwdQ8CZEVjniXh/AKZdB/dIlb+gg2O3OFJ/RuRD1JJS2hx96MblfyLD5J24yH3
 atBInN8/sMs8+DChSlv67Jf4mdAhiNxPbKwPDY9f/7HoZcIfkcN0h+QiXK3VQSMHuTMC
 6hecN48MtouCrI7X8VIq9R7+84G/pDasotBeZ2NQbc5GRqQvgbiIW/NgoVjk2kzoAOg4
 ljDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJGAWXRLNAMDggft1OXGNdgOdkZacaWGGFI/PSH6osxA9FmYCwQ153cLANdYI1Gq3AIYyR3blbUIY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIO931CB6GC17azJ6ZwRFZ83y2+ZNBTCf4vt+DERp498O5CXP5U
 QPNdq2xSaC3mVEg4bCuHppa+uZf0nhktXfnASXqHKYWoyycQ5+3zQ8MVae3sdjKqf38i/6d7qL/
 EkyiyUHYCXw3ZcZuD3vSoUQuYA+X2Ogv4iiwQVDrEz1j/JsVpmcAF6NRklGp8fMhMI+v8ikg=
X-Gm-Gg: AYBFou14EnNsYYvN6nAi2qwSlJ2KkJjTw5a2NuPRjv5Wll69bb8piPxk9LGgXIDggRe
 E0Xjtr9lIGNEVcuujATJw7vmx9SrFq2e+PrQQx6Np1m3yU1sVZ583jmLrSKxJcndDI6WgFMHju0
 guMipL2l3qsrQVB+E/H1KsNpvlv/VOF/PLo1219gwRnal2+f+OZDwENqPU5visSjOPjffHQi/jY
 vmrKHpRKu06zixQ4X2F8D68rH7e3zGwnkEhb83tIhPmLNIQiXS+kv0Jye+vmo+Igpm61UU/1oTe
 rWCv3/jfZlTIC2ikDUBMHnih8KXU2bZZZGujZ+2LEj26PqgjHYXSUPo9E7kgUKwoH1DU1zZnDbG
 22B/AXDpxtZcUMEElRyfQfe9XPTiUW99NYxhymgacFB7qC/TUBq1v/BFdZIwVKF1hxgtaHM9mpT
 o8eYSfwxLGilEJ
X-Received: by 2002:a05:620a:1a0d:b0:93e:6394:5e37 with SMTP id
 af79cd13be357-93ebd1c4b2bmr2843094585a.14.1792021890152; 
 Wed, 14 Oct 2026 16:51:30 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0d:b0:93e:6394:5e37 with SMTP id
 af79cd13be357-93ebd1c4b2bmr2843090785a.14.1792021889684; 
 Wed, 14 Oct 2026 16:51:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafded5414sm2285281fa.16.2026.10.14.16.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:51:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 02:51:13 +0300
Subject: [PATCH v3 1/5] dt-bindings: display: panel: add Truly NT36850 WQHD
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sdm845-hdk-v3-1-1c179cd0d16f@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com>
In-Reply-To: <20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com>
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
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9YF0Qqb0Jsn2AzfHSzmdbHfGJDrdky9Vj1BN3Yu4/ugn
 LV7Gg06GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRgsvsfwW05kcdnlhbvcLu
 f1Cl5RaVK9YnDovxsGUU1zxnNBEUZ7JzLHPPlirfdlxk2sWEH/7WTspHKwICAq54x9VNc5DLEGf
 v1Xizg+n3mexIjnuO7tvXn+jlVHF8uXCWS4hxzdbfC/anJ5oIXPsj9ldn8/RHP3mmac75Yjin8G
 bgE+FtJw3i2bluOwZ+cTfVvnw+2Prt/YnKGUx/shQvuEQeKFpqKHlpYewa7vjo7vsep4T/p3a82
 DnpjETSrb5KVluOL4zHYqIy7zV7OU+wOl6hPLO9SKLBp/5E3MQ+v6WCTntfuAQuejrxefKGCht2
 09VrKwofCGhE1QfvTrcrmneFK1CkVccjvPjKn11FM+oB
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: _-7YMWOb_tFy5lFI4Hu6t2FDjGN6usA6
X-Proofpoint-GUID: _-7YMWOb_tFy5lFI4Hu6t2FDjGN6usA6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NSBTYWx0ZWRfX8KPmKfrjq7aU
 wvSr1RaY1Z37b2NVi4g5Z0UkcNbVsZ8J/nIH5pRnHOxZgdkJi36Mx4Ia27NgRfKOUFhoqWGrk15
 neIbGAAUyAqr8D/Iu3xXVX4tOnuFaQY=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6ad01582 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=od__NDLvqBWtWXuahMwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NSBTYWx0ZWRfX3lCLvkK8xFDT
 KBmwol1fC7le88iAovLz8U4CwYpxUX2nJYzJbzSYEiUcmp83iT3aPOnStRqsQGez2EAFgQQk9s0
 n9vwPE+EHbaBtrxY3cqSxWGLwkEj0Yqh4Bo8kWq1aRl6qhPWHKGj8Ac7ES/6KXSbX3zmpDoHpxe
 zfH8AcRqX5pUaq7k69XsnViH0thIR+9Ijm/b7Vhy/Cw0VtZ4u1iF8i4STl0OsQFkcTFZDa6J3KX
 VUc8wD7GPGP/FtE4l9QdiL0qP+F3PSuIkohM4p1FU+6E0KBfUcMXd7Y18cJIWHyLnJuVcd2T25M
 49tV14ws5VTHVb7Mz9UAQ5CV7N3CHmPXzTiEfY4nAbUha1rY87UjJn/7/VMsOccAQJxhMFf5+9f
 D65MCYN9l6GkFjm4MnBPDzt9MEsz6+rzK7SCBoqbm7s9fovzRsD9bOujPXc7nHeIWi1qGu0DjcV
 vwqVzQaLR5xnM5UT4Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140095
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

