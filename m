Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB0606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fzmqt7oK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zsp+V2bY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA4810FFC8;
	Thu, 12 Nov 2026 10:16:06 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2AC510FFB5
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:15:54 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC9NeAQ2514376
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y+7ViZgck0V8RkyIHFto0Znqk/6YAtzFgiUxh5asDVE=; b=Fzmqt7oKnOcfFg2u
 ewzqXgKKfY296D6RBHlr7RPnrOCjgyuFJnbMJqhtiEJQWIJBTquuOKWIYGdBcwot
 INFto1MfBzgi19DZZPHb0y0z9C1zYCmBUx70VgrUgS7cFxaKyDLdeH1pfFedbjSf
 i9dg2DBH1hCX2MTlbZef7q8nvqOO70v4NGKtKGIZe76ZSwVpvfYoOciD9jL2Duts
 3iCpK2mkIi76LYki8HF9r9jbPqHjuwI3K0/Bg3hqLCa5J3aiOP1BeDVOhkV6ptQh
 G7pE7dwjRtZ/+RgsqHyBvuVAJM6MdQ+0ns20RyFcDT2ZyRYrQb5hlkuB6q0BsZYo
 D4zh8g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1u3pt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:15:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8b32efd7ec4so3707834b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794478554; x=1795083354;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y+7ViZgck0V8RkyIHFto0Znqk/6YAtzFgiUxh5asDVE=;
 b=Zsp+V2bYTmcUKBe8h56OWLdyOB2RwKj2okGem0rzdduXcBeCJUWyKPRHxjIok5JzLK
 yQrbW0Mromh8L5sdEu6polvu4jVAlU7B+RSQiZc+0hKXuuvh35MdV1Bljw7aNOOtCsDB
 80Je0V9Nt+UK9/oyb5ECTxxjVpD/J9cJmUenhdoFJx9AWzsbG5PuRiv3PbNsh11AQCID
 W5v77hIcbveHbRy96oGRyNadKpYK+MVD+7G69zvWpuO3O99RHfQUxDOnX0UrAEQ/yUCI
 aUhhWzdSlZYHoJ9kYv5jKHwfPC+24BKh8kMnuHpq6jfO72zsuJBmoifzc/WFuX0i9wwf
 vMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794478554; x=1795083354;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y+7ViZgck0V8RkyIHFto0Znqk/6YAtzFgiUxh5asDVE=;
 b=G214omMOOofgETu5kjfRmGTHjsVW723QYyJALRiUw7DD8R1AzoF6+Ake5Cf+OZugLg
 y9F51t3Yb/FJXrPgfNi5hUpEnOqkgT9TcCa4j5JZ0h0gq2XLEBXGZ52qHXTdUyehgVWJ
 eC1CwS4qmReohLkqsCC4AvbLhcDAydhogPvguVZiT44z0qZpIMifrcdOrT7xcohls84O
 JeKMsbGVWGnHCuZOjAFvriIsQ+2EIAjDuPB9mj8ur34KbQaFU25KuISgdmkfs510lS7n
 sTngSYFIR1ueAkGyI173PxH2sTbQKMNK8/R5TzxKNDHYk9GzNIWjwyw/b+e1MEzRCFoh
 Pl6w==
X-Gm-Message-State: APuU4Z8QZej49oKaIz3qBVqsW3yeFX811qQXAUvJ4/K7KXli2YzngGuy
 14Ur4hypRxLSBbEED86mL/dEV3BBfHkMnLDZslsFWPOQB1Gje5AnLJfBj9tgnhYyHkxJaA6yR42
 bD3koD2T8OlExdAvvw8fNV9KLUP9oXycoS0KQ1K90riZzUXfXm1tUCrCfiMZK9ZowavHWb1c=
X-Gm-Gg: AYBFou3Zgu4dE+0BrDzC+aNlH2RJstcafTNDWas9rWUthBkG5Mjv2neyvj1mdaL52bh
 4Tc9rQnPBdMLFXC91KlGODziU0V7arwyb8JhpiSylSZGOhidLqKIa8npDVwMVk3wDtOneSVWx+a
 mNQacIdQtxTe5LG67iYhCnTickKXxr0w64ZVrj8B6sRaWrn7+6G71Jeh9s4Nrt12JMINmbvVdU2
 M9wtJolM3PSG8OrZjs0OMl16/oxiB2ypeb2CZ7owsQ693Ov1fXGFsQcvBkymL8ROkzc+ayKHpjO
 w8tRiLPRri6I0fYC37YetLrEPhugzkw5JTx99sg6GMnGMdlF7FuxgkJqsf34pszsUk7x47+TsBC
 KsIie1GUV2YTAa9wys8/wDQzcLzLxgbhc6VmGUayEIsRcpSsWBJQ6ro9I6No+VhIDlOFAjLyJer
 oS
X-Received: by 2002:a05:6a20:258b:b0:3e2:b400:2b04 with SMTP id
 adf61e73a8af0-3f2fecdd04cmr5825431637.45.1794478553663; 
 Thu, 12 Nov 2026 02:15:53 -0800 (PST)
X-Received: by 2002:a05:6a20:258b:b0:3e2:b400:2b04 with SMTP id
 adf61e73a8af0-3f2fecdd04cmr5825386637.45.1794478553168; 
 Thu, 12 Nov 2026 02:15:53 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaae3e110sm3185872b3a.36.2026.11.12.02.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 02:15:52 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:45:34 +0530
Subject: [PATCH 1/4] dt-bindings: display: bridge: Add Parade PS195
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mahua-hdmi-v1-1-b463d7b1dd7e@oss.qualcomm.com>
References: <20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com>
In-Reply-To: <20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794478537; l=3963;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=7LNEKtT4mDMRU5sAzssLKLYmcuRayyy/4HBNgkZ2SGg=;
 b=U/AdJ+o45wb9voMrU2x2MRI1ftHCAd8QA/V23fnJsMKleV0BRWd/NRWn4JvLwt39el9WdiRnd
 TVKaAHUSTjhD7TYJe6mGwPBnrsgR2x2fHIzka11OamsKRpe6gDMvKmH
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af591da cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=cm27Pg_UAAAA:8
 a=xQKGsFAfKFO7eTD4QCIA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: ui3n8sskp1lFphQwp6Avq0Sfw2NHsLjH
X-Proofpoint-ORIG-GUID: ui3n8sskp1lFphQwp6Avq0Sfw2NHsLjH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfXwIvq11pGYr4O
 7gsZuK2hJktV8rX44zUgPB/6IYBBAgtlXORkKLPwC7uI3zbTkAHzaYBOUMD2ODKKizeicBVi3Mf
 VhWs40gc4NzoJZOhyYjxHmRyoMdXSqcv0Rw0fQa6rEOjML3GHGQXGZXXn3KXAdlseMtEGGLvwlT
 QxJRR5Rv0zmA4uEMvl5mhOTceeK0KWZbllhjj2/7KBW+00IY6Ioe8706ct9EPycv+NOTft4P7Wj
 6cdhq5bCAwmbREx+jdG+mInUE/tlL3CNSe7g0d5w6sqs11lWblJ4bHJLgaGclrjp4d9CniKKD8m
 ugZRvsrA4I9TMJyoakwOJpK9awJrGkGXLd02jC6g2kmZRxkBfHIIu54LEXUkpRTHRzG6bWSyMKl
 Pj31Q6SypRj4cRCYHDxWICayaacFo6B/Z80PSjGRkLPuGUEegxpgEu1JpdZ569cuhZEm+iU3X3A
 wo2h9AhTyKT2n6Ar8/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX5ZBAGkJ/uY+S
 zNaIAvMdFZhuMdDWvv60fwDl35WTyXHdgVRSV5LYrFDvwrTjROPtw42aShxeMnylz3uza2+XUUe
 h5zYMLA40wIVGL8sEO0nwxWJyYypYGM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120040
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add bindings for the Parade PS195 DisplayPort to HDMI bridge, describing
its power supplies, optional reset GPIO and display ports.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/bridge/parade,ps195.yaml      | 98 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 104 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/parade,ps195.yaml b/Documentation/devicetree/bindings/display/bridge/parade,ps195.yaml
new file mode 100644
index 000000000000..089191570ef0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/parade,ps195.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/parade,ps195.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Parade PS195 DisplayPort to HDMI protocol converter
+
+maintainers:
+  - Mahadevan P <mahadevan.p@oss.qualcomm.com>
+
+description:
+  The PS195 converts DisplayPort input to HDMI output. Firmware loaded from
+  an external SPI flash handles link training, EDID access and hotplug
+  detection. This binding describes operation without host control of
+  the device registers. The optional I2C control port is not required for
+  display operation. Reset may be controlled by a GPIO or released by a
+  board resistor-capacitor network.
+
+properties:
+  compatible:
+    const: parade,ps195
+
+  vdd09-supply:
+    description: 0.95 V core and analog supply.
+
+  vdd12-supply:
+    description: 1.2 V I/O supply.
+
+  vdd33-supply:
+    description: 3.3 V supply.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to the active-low RESETB input.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    unevaluatedProperties: false
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        description: DisplayPort input.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        unevaluatedProperties: false
+        description: HDMI output.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - vdd09-supply
+  - vdd12-supply
+  - vdd33-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    hdmi-bridge {
+        compatible = "parade,ps195";
+
+        vdd09-supply = <&vreg_hdmi_0p95>;
+        vdd12-supply = <&vreg_hdmi_1p2>;
+        vdd33-supply = <&vreg_hdmi_3p3>;
+
+        reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                bridge_in: endpoint {
+                    remote-endpoint = <&dp_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                bridge_out: endpoint {
+                    remote-endpoint = <&hdmi_connector_in>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 46c416cadacd..9e1db88ec1c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8581,6 +8581,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
 F:	drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
 
+DRM DRIVER FOR PARADE PS195 BRIDGE CHIP
+M:	Mahadevan P <mahadevan.p@oss.qualcomm.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/parade,ps195.yaml
+
 DRM DRIVER FOR PARADE PS8640 BRIDGE CHIP
 R:	Douglas Anderson <dianders@chromium.org>
 F:	Documentation/devicetree/bindings/display/bridge/ps8640.yaml

-- 
2.34.1

