Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89537D3514B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDA810ED9A;
	Wed,  1 Apr 2026 07:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eyosuL/u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ckx4YhJO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2444510ED9A
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:26:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317Qomv3081373
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4tuSg4uKpYZ3ltK87EQx0c6H4sS4d6Dc+WdX7+gIALo=; b=eyosuL/uMdllbuoG
 OoXppU7EyRulzXAUy4g1IxpXBgRZ7mqTI9WNAzDCVx1Sg3n3TbIJIjzsBOtDx9/S
 UFiHtgNg7Fq7HBZrUshrXV+r6kbRb2eoHTf7ccch2MLJLE5C7rRKJNm3A+UTlXId
 14Z7nHtTCFkw6Fun9+o+xr2p++DDyIdamIlrCtdSls6IdkMoXBypdUgyfyH3v7/O
 WlfFLT8c8lo+c80/dTKtwyD/L24uBA9s5VX+f/yxA5GnHIawewCbvnZ5bqNcOCrT
 asmSA4TKsxypBcF1R+cD2W13YVkos0/gaDPFpyRtYhxMiAsONdBwW/5eqqa6uUEd
 hSkfVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kdkttqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:26:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4b81c632so210616871cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028411; x=1775633211;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4tuSg4uKpYZ3ltK87EQx0c6H4sS4d6Dc+WdX7+gIALo=;
 b=Ckx4YhJOhLlwxb2dEEVfx0M4LK2FqdNJA3JKMipe5dcUiturp2/vOvb43gqFN+cxsH
 ZrtVRM5lAnQJfNewr+cw36H0lbQKDLiXO6Z8nLw4yEF7Ds100z//2pjK4a11rFF07yI+
 YknRXiy17ZkydxtM9Rra+7iRcDdneD0K0Ql3claYalIx4QZ3REyG6FrU/XzDKg2A22g5
 JsqZ8a5dkYkvFDENyjDE9A8aOa6FGw1aVMM5vvc/i6GEjnCwRTiSDyCz75c6Vm36gTRp
 txzp7AjaETDMfIILJG+iKOsKtJsP19O9V2RPnE9h9B2FgF61dwwIc/Tsr/Vheixu3jgN
 69eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028411; x=1775633211;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4tuSg4uKpYZ3ltK87EQx0c6H4sS4d6Dc+WdX7+gIALo=;
 b=VMRl4q3Dtdwr+OBeAK0LveuLT8tMUDfPLGsH2ccBQjed2zEcTyLXL6ykAocCNDhV81
 cAbVt7XXdTvTRJPUDYAmWk8FF+zc8Tumb6hkkR2vdmPjlF5XSrrusNTqRAfFhI43zmKf
 rr8ATdFCEbtesL3vNehOuXKUYbqNZznfniwQyP9+QcV+WAM3ngw+IXAKp6d4q5YUMjjh
 9c7vJh/X8IpTHgkUoxURMKADNU9fvZ0yepQQNu1RyDz8LYm8nQ+gz4ITZMgzlaNw6nG4
 ehA35jAfY2Jo8IefXQv3z4C1REiWiKLUxIPB41SuiRfD7wTpgVMQxbmdei+WCQBSAEpT
 mNBA==
X-Gm-Message-State: AOJu0YwTXVbH3KI1PoTgvn1Oz7GorE11FZqBUiSjM1tz9Xi3oHXNF1zw
 XWcBVLBn9gPH6uAXqmDMtJ2kAtRvKYSS4HZbUlEuJPZTLypoc2q0hNx3wcZ6uJLZuRoC1QejpI/
 CYULh3gbGvyHPyMFSSZz+zSjGdwbsv8Ujim/Y9t81qUIeBYyvkyarh5U+GEsgPyFO/qM3zmg=
X-Gm-Gg: ATEYQzxl61M/0DZbz9FVqG1OoxlBRl15lVvvgAbNcBtBJJGNmECO4QKgQPJHGWWdQMM
 gz6e3/BWrAeyGR503t85B8bgaojA6VBrL+rhZvRCqI6VoRoSThNxvH7EvxSrmacQxeWUPDBZmsK
 272+klHU+vrvjS+5Kj8yrwDYPHS5kQT3uSLf+IJet1qKfdR75L16qQm/rziIJKSbU+7clN2Rdw+
 ZBXhQxBBtfjCb2QoqFXO8jUIHPJD+Nfl+wycxTYF3RaWMYaFvvpfIEoSHBEyHuYWJvSNqGDsqGo
 BVNIRM9/qn59UOjUIAvNVmmf1dgstbfH/oNy57fwg9daCTv17/EiZmSqJ9yEeCHVdA9h7ISJVai
 Ha9Wv+HdYkNjSnI4TvUj6Y7OSsWKZdiHM9pkFQQcK/qFwvRVu3HxS65qykd+lG4PQotUnLmg1Bh
 Jm8pF4HFmqPUh9iIShEsDrNFmCCRCuyTDULOA=
X-Received: by 2002:a05:622a:1a84:b0:509:cbc:127b with SMTP id
 d75a77b69052e-50d3bd5731fmr33063221cf.60.1775028411372; 
 Wed, 01 Apr 2026 00:26:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1a84:b0:509:cbc:127b with SMTP id
 d75a77b69052e-50d3bd5731fmr33062941cf.60.1775028410903; 
 Wed, 01 Apr 2026 00:26:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:26:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:24 +0300
Subject: [PATCH 05/19] dt-bindings: dipslay/panel: describe panels using
 Focaltech OTA7290B
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-5-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2192;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=W2l9B2OwEz4Zivn64VXFY6OgAvWjgIUZq1Hf1pqff4o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMirhSCbwfrsUoindh5tIcQpjN2BUzdd9VLtD
 N3aR28c0wqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIqwAKCRCLPIo+Aiko
 1ep0B/9Y4MLaoQn9Rs+aojsS9sQIFOYrYmuNPvJk/MBys5hamRAKdl8Ug9esCtE8LDpcO54zQgf
 8dwQKQv7MEmw9ymrd/RtBHQfwkXrdrBapeENdwYUIqxBPowWtbUB7uCnIn2LpKusg8zOs7OCD//
 ALY2OrArJG8tDkU3qH9ICtLT4Gya7cF7W1D0aemlxB84yeakbCGNBYECnmZUQchq1ZXiGvAjKMy
 uIvwL0DbQc7EABVZp2uiII1Ne/cgGor57MYp77DLY+zp2xoomZ0tSvfNntiVriQF0TGkPc+Qh2l
 ipCZylqfWFDSTXCGnc1R88jr2BwkVPa+8mWlQLNH02Su/m5K
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfXzXu5scd/HllD
 166qKmCMb9Y87bUL6gPnpPG4zPwNnRsnGYApr0n8CZQSbSwRJ0K1+9YUnhWs7bbqwfP+DHwG+fQ
 JxxGAUUykNbPAUr3G7PR1XECgyKmXHrlSIi/HsKEdh6nxrVwgeVBOBJm9DcHJaYa2GCGezXbQzc
 QaBTw+xRiBPK6ZnOAYElWf81k1Z0uKjY/SbX6xuuY58Ag+hqChpA1qvst+4j/xRrBV946e0F5qY
 u8kIaMfsEubovxaR1ZrKHANIu4h3lPQcfksmlYzbTJVRxUbMxyNrjSa38IfVMXJQyKoQn9AM5b/
 cyyjIXff+FL/R9NsXiRMA6C+UgtgL4ZlaGMFk6SpuCqbSrLf7+7nrtWEwcieTsUM17pYFuJzgIm
 Ic1cror8WNKcrbcB0+AM+gckOFUvhuCL1uOg3KGUU04e3nbkpcfxTrC5bYvTDkQHOpqiTt6orYw
 XK119EIZewODyACilbA==
X-Proofpoint-GUID: Ed2-Euwj34W4S10dhsDLmJokuxEvrs8-
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=69ccc8bc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=QaDNpyu5kUm-e7c-h_IA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: Ed2-Euwj34W4S10dhsDLmJokuxEvrs8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010064
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

Add schema for the panels using Focaltech OTA7290B controller. For now
there is only one such panel, from the Waveshare 8.8 DSI TOUCH-A kit.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/display/panel/focaltech,ota7290b.yaml | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml b/Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml
new file mode 100644
index 000000000000..da5237404dc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/focaltech,ota7290b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Focaltech OTA7290B DSI panels
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    - const: waveshare,8.88-dsi-touch-a
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: supply regulator for VDD, usually 3.3V
+
+  vdda-supply:
+    description: supply regulator for VDDA, 7-10V
+
+  vcc-supply:
+    description: supply regulator for VCCIO, usually 1.5V
+
+  reset-gpios: true
+  backlight: true
+  rotation: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vccio-supply
+  - reset-gpios
+
+additionalProperties: false
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
+            compatible = "waveshare,8.8-dsi-touch-a";
+            reg = <0>;
+            vdd-supply = <&vdd>;
+            vccio-supply = <&vccio>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+            backlight = <&backlight>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&mipi_out_panel>;
+                };
+            };
+        };
+    };
+
+...
+

-- 
2.47.3

