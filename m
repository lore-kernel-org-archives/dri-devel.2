Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8437CCA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B103210E5C9;
	Fri,  2 Oct 2026 14:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="cMepIyQW";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D8810E4A3
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:21:52 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2e1b09e0c7so13518566b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790950911; x=1791555711; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qgqhj3Epuh5RclDvybJ2oNFa673B4IjvzwU5Ux/nnZ0=;
 b=cMepIyQWBplIxTeX8L+F651Z+u4rMukr4MfVvIkcjwnGLA4to/ClgV8lmg6ppLT2Fk
 jOUTIhH5SULjmQtAhrGlLIAF5qL1y2qHyQxVP5ooz3XIH0jDsfK9QlEIB5arRVYQPNob
 Jz4zWDykfS0gBJlRpb1cB/Hp1VGo96xqV+ChWk0gtxC/fwhuksa3g2WjeMuFgmMsun4z
 oMDTGCUuJ1zWKLfDtRq+LopRvmXkSwb9CWmP09bezu2c/G70yaqvlm0DNPzy+vd9qQ9R
 ki7thsobWi6DzBRgIA1ETmzPPPKZsTw6dDZidWK54aC/P/gS1F1rUEMIgzGxmhJDcf+T
 6cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790950911; x=1791555711;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qgqhj3Epuh5RclDvybJ2oNFa673B4IjvzwU5Ux/nnZ0=;
 b=bM++l7GfdMHhsto6vb+Zs11gZInWRt/swLnFbIxdkdBD/6P94eoZuQC/2kfYYF4YtP
 glIb6QxjzPEDzEdgYdMo0II2uOkv+l+GNSSud1fX8cHD5muChKrt5ctIJt46Rvgw83bw
 idmdwa74y21IbUH722zWm6O8CtTcu5oDygF/8LtME3FTxGaaP3eNZjYZ2s/sGLXA9Jen
 iasiw4beZyOeZcchoBW/M0+jGbHsb1m3SXGo62BchhPOnVCFxUJ7KmzsOAgjp1BQ9cKu
 dr1+DSzePIVwPHL6x6fZh6WKJYvIw3sxJhPElmYT9nLN2gBL8QajZxlKxAilDNuL7RJ+
 H/rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykrhkZB1Y/sIsiFzV0ZvlhYCPlWak1XMR5u3Dp4vpH2q+7J+GRE0kWnWWA22JLTZr9EOqOtizg19c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mJoY60onv/vGP0H52Aa/0vqgrIb9Dddj6JwggpyTw1zI5a1y2B
 hqyOZ7wBFkyM8JyR44fz2QO6lyC2nEo6IVPGhcD9ZcThtxqPHNsfXe/XMGe38wZ3KRw=
X-Gm-Gg: AYBFou1AYc1H0ilbuNqIFlRgCIHu9mBp6iLAL5BG+1XZMBUnaqS3xquSGl5UyeZCyks
 uW2wR/3OzslRLNmjUvu+wvmUtH5Pl6ArwFTd/vVJo5nL0jQS7LG5jGhaU4jKE/nUUnvjrp9q4Lf
 zHcXyQETQMRDc4BP9AjPJj80Y4aQ3a92fG+cdtXhLarhinHsZXCOYypo8qdiH+Y+b3scihZTFyy
 cHYrJvyUwp0rcbSx43JAEa0q4RIqzd06p5vi1KBO9GJy9qXQcYd0Nclt3HyEa0gNvCij7akWQk2
 t7dLucxYhypFihUKMzqEWnru8O3uN/NX2gRqoBh7zSF13cKlIi4fT8VVRTliJJG44ELelkuaWJ4
 1cSl1F80sWX9yvVG8OvXKzR/exYD4vp+EXdJDl9U2FHki7CoMYAapbefSagAwmcyuYG7jDFZL0q
 R5YAXph2Drk9/ftiToq77QTRd0gE1I/rjJOAjCQ+PHztZO5Fe1Wy1T5p/t5c713ZfBpyhE98GqJ
 BFBW1JlfAwAY9enqWj0Yi4oMQEywtCEaw+9Fc1YCDnr08tntf6Y4SslYN1G8Bc=
X-Received: by 2002:a17:907:c16:b0:c2e:4488:b8a3 with SMTP id
 a640c23a62f3a-c2e4afb4dfamr203583766b.33.1790950910733; 
 Fri, 02 Oct 2026 07:21:50 -0700 (PDT)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e4cf684e3sm89307166b.51.2026.10.02.07.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:21:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 02 Oct 2026 16:21:45 +0200
Subject: [PATCH v3 1/4] dt-bindings: display: panel: Add Novatek NT37705
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-fp6-panel-v3-1-4b80f83bc936@fairphone.com>
References: <20261002-fp6-panel-v3-0-4b80f83bc936@fairphone.com>
In-Reply-To: <20261002-fp6-panel-v3-0-4b80f83bc936@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790950908; l=2354;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ZXP6OkY2DxkiTYSnHO0CLOwn5hC6SXDi4hWyiPvZAl8=;
 b=COCbMQS3AncCT3ls131LtMAtGjNrfapFqjTCKGzpbyoLUllRaFlpMgQRKj5Tez5BqkWhFh/lN
 W1H8eSLRNWGCCSu1sBjRPqGfBc6lhIZA2e1Mh3sB1U6Uiped9YwZYHK
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Novatek NT37705 is a display driver IC used to drive AMOLED DSI panels.

Describe it and the panel in the Fairphone (Gen. 6) (BJ631JHM-T71-D900
from BOE) using it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://lore.kernel.org/r/81a3c207-4d8f-490f-8e2a-6f3f4c2acd35@kernel.org/
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/display/panel/novatek,nt37705.yaml    | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
new file mode 100644
index 000000000000..850d91e25af5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt37705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT37705-based DSI display panels
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description:
+  The Novatek NT37705 is a generic DSI Panel IC used to control AMOLED panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: boe,bj631jhm-t71-d900
+
+  reg:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O voltage rail
+
+  dvdd-supply:
+    description: Digital voltage rail
+
+  vci-supply:
+    description: Analog voltage rail
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vddio-supply
+  - dvdd-supply
+  - vci-supply
+  - port
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
+            compatible = "boe,bj631jhm-t71-d900";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
+
+            vci-supply = <&vreg_l19b>;
+            vddio-supply = <&vreg_l9b>;
+            dvdd-supply = <&vreg_oled_dvdd_1p2>;
+
+            port {
+                panel_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.56.0

