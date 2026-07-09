Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0984C44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBC210E355;
	Thu,  9 Jul 2026 14:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z5x3bjJG";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B15310E355
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:30:41 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3811f512167so1041709a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783607441; x=1784212241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z1y6DB0OS7718UOoTLlP+do+f8qh1SxQISdYuxypXlc=;
 b=Z5x3bjJGVRJpdhGRrE7XsZrRewIVxSemK8gmodK2fjv6eAtmOj5AgHu47Htj0S6kvU
 Ve1Sg3kQw4gPu7yxVdDruRxb7SexwloSdudGqqbBEmcKQZrsHRGMS/ToF02pkeU8assA
 dZvnhIeGkl7v6ucN95O5onsN4niuZh+CbUEPWhPuHIS0rH7j+mU1pGDtWlm0LX8qtppw
 TYN/dmAoTL/7OpoGXzQy9lzhPxB3uowSVo+Eb2QFY+YNTv2W/y+DUYRZTA6HHrAkUB5x
 w9aXV4NJ9oANYECFaoA+LIEgfSKBoPLGG0U8qqrjHOpr/swxS81lxa/D1AiV3uvkdiaa
 0yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783607441; x=1784212241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z1y6DB0OS7718UOoTLlP+do+f8qh1SxQISdYuxypXlc=;
 b=aTtqMCoFcLM3vULmXJ+lCsAqBD7AM/U2Vdd1Hq7NA3sMCuMQ7sralnNrVc1hoiiTw7
 SVSdl8yg3xIH5TWiPWKS20cA5ytsnleG3Vmg0Ya2aKzC4PwQeTVZik4g+Gycc0tA9xB4
 HnwjR+FFtbLxmFmW+j8oaYLRNioUDUsGaXEAkyrTO0QoCjJ+3cRmIYUIBKm1bVfVxJsv
 r4tzj3t2x3eFLcPGhUU0SmD+xp+2pmnmgXaj3NBUADZ8Bafrg8EHuntNNePSGd5Ge2zQ
 EQbypZg8guhMwIV++NbXkN2IwhODjtIgA+CXxyXY+p/GqJoD4m5MU9R5KaS1y0zQPCV1
 o1FQ==
X-Gm-Message-State: AOJu0YxSii6ZQvvwW7sqd9XlQ6ptZPjqNlHSAv3nVCH6asFTypFkhN4r
 xHIIh8QzIr3GZD6V/cKG3X1YZo+5IHDVeMLejhuexbHWcNUXHCu9kt0X
X-Gm-Gg: AfdE7clLEZLARUPG/0cPa2fwvjIxc+4pu5/sCQeSL0FnG+LDRWXvUn/UnEbM9mv2Gbv
 xV8Fa2ox3RAMd5C9NWyLQds2pL33CNGYrFwpb+USawCox6CsLwUQVr0yfFLflX6cVBsuQM0DxvW
 RyGFispupHfVyFZGZoHNfYTC7TLHAMRT69OVv5E2X6Kf4qumpf3aFFoPRP7/fg27ZD7gQA3Xyxg
 k2zkYPacNoVEVUGM6VnCYbVmr6dP/N6BIk0Oo1bJRy/d5geJmvc4Z26JaacC0vT0katIBFfXHZ3
 C5obzz6kucCKijIa80FH3qXwV+8TMUTQZkCmv5KypRvp5xvGDl+7G35EuCEZ3gOn6Ci4ezxA65L
 YGlrNujYoWFsMjMeXmB4Y0nq9krTDL0B4xpdCN/Z0GA6OBxwkIukq5B17do91/Mv0q5GPAu/sbT
 ltUhjqYvW4KrPjzrCkOr62ZOU9vHR5Vy3PqniuNAqftq7I+7X1Uw==
X-Received: by 2002:a05:6a20:12cf:b0:3bf:d0c8:2aa4 with SMTP id
 adf61e73a8af0-3c0bcbe7876mr8699043637.8.1783607441044; 
 Thu, 09 Jul 2026 07:30:41 -0700 (PDT)
Received: from nuvole ([144.202.86.13]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca79aff904dsm2009666a12.6.2026.07.09.07.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:30:40 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Novatek NT36536
Date: Thu,  9 Jul 2026 22:28:45 +0800
Message-ID: <20260709142846.12463-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709142846.12463-1-mitltlatltl@gmail.com>
References: <20260709142846.12463-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

NT36536 is a driver IC used to drive MIPI-DSI panels. It is found in
LENOVO Legion Y700 Gen4 with a dual-link 10-bit CSOT panel.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
v3:
No changes.
v2:
- Collect tags
- Mention the CSOT PP8807HB1-1 is a dual-link panel (Krzysztof)
---
 .../display/panel/novatek,nt36536.yaml        | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
new file mode 100644
index 000000000000..0862998cc6ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt36536.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36536 based DSI display Panels
+
+maintainers:
+  - Pengyu Luo <mitltlatltl@gmail.com>
+
+description:
+  The Novatek NT36536 is a generic DSI Panel IC used to drive dsi
+  panels. Support video mode panels from China Star Optoelectronics
+  Technology (CSOT), such as PP8807HB1-1 which is a dual-link 10-bit
+  panel.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - csot,pp8807hb1-1
+      - const: novatek,nt36536
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O source voltage rail
+
+  vsp-supply:
+    description: Positive source voltage rail
+
+  vsn-supply:
+    description: Negative source voltage rail
+
+  backlight: true
+  ports: true
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - reset-gpios
+  - ports
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
+            compatible = "csot,pp8807hb1-1", "novatek,nt36536";
+            reg = <0>;
+
+            vddio-supply = <&vreg_iovdd_1p8>;
+            reset-gpios = <&tlmm 98 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    panel_in_0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1{
+                    reg = <1>;
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
2.54.0

