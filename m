Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C27CCD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 06:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756E610E64E;
	Wed, 27 May 2026 06:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=reznichenko.net header.i=@reznichenko.net header.b="GaTuA2fB";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E92410E64E
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:23:07 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso119271125ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 23:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=reznichenko.net; s=google; t=1779862987; x=1780467787;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJASFrwjoeNGT0XkAG+AYLQ0wHyxti3wxbxL3mwKs0I=;
 b=GaTuA2fBOM0n5/Kjsz/F+6iXuhqzRFfxMhhrq+wAasPqUOGAM2JM8rw/7iH6pmBvi9
 SIV7H7StmrQAQ9f8S0nl5TMEfT7zFcaWXNteKVDaDsFCnTwzit6pF1yYWm3CoZKlDRGO
 TM/B6yPNtSKKNrHct3E1tymVPHYE8wIEYPBFGTUb+uM/0fDbzZuxuLZGUx4wVlcL0cXr
 2wzmQ6CENWIrM7nHK+Wbb3PlRp9s8iBU0Jt8FJCdUsOpVMs4EPvA6pAWVPFoTuPXPsq1
 deXxgo2FktvK56iX+uu+8NfkDuJJX7ppwoOVZk0S1smZVI0YGDxV5YwUzfjJFLcKuysu
 VSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779862987; x=1780467787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DJASFrwjoeNGT0XkAG+AYLQ0wHyxti3wxbxL3mwKs0I=;
 b=s5epWEzyMV4dGndbHKOwjSxw/zxDkoq+1I+IXy9IA/rSB126FTUW++kBdrXyoAZacP
 EpqvdUukdRnKMtFMsS3e3ZCSiHW0S4iYanJ5GReYJpsewA3liNASJIg4drSYtVTbJtLj
 PgiDnIokQbpk9xwW9qKlEnK9DkssVCxuQJHvC72pl2hIcbX1Cys124n31tTLIxkxUWru
 qimKcOvCkaH5efd7OUkZ/xACjLHCECjx22LYcMiZK4SbBk1swzg6Us2QuefKbV6PJsxQ
 /0hCcv1fL7hwVxsCppFL1bp4TyoX9dlrTkaEKcj6U6TFyxUxaaQPMJ4UPQq29V5GHi/j
 QCJQ==
X-Gm-Message-State: AOJu0YzL2Xx5+ToJd6chSi4AthxSDDrNIyPtTFd158EHBxONglxVr3Op
 XV2EsirnzL92OOwqeUeCnZb/mhI/kZ9hYBZ2Ks8zzCx4MD/tkU7cbaWAsTcDFJTVup8=
X-Gm-Gg: Acq92OFOkEnlRSvOCwExQXPNrM2ZD5KAi1lOxUredB7SIi/DZrYRJZu8Vd8hcM7xskt
 rHStRSieh1a04oyGxgpI+o8momRRyWKv84HKisXuNlvMRhmJkaMfWbCNB+KhXwpT2uoul8bkTBa
 uVCOACYp9nx5JHLc7dz9NYr7dv1sJcZl/UIZjbB/dGvQ21jpr+qPHHfIahtLG5tS2Hg+PSs5UGc
 eOVlKIjLzcNwSFEbe+z1PI25Ksrlf1Pv0O+zJp1W2yMZmku9nqmgZ5uelv3jRd/OydkohYjb05t
 zOgjR0T/6ewyDhPuM+xfbcYp9vThaxnL8vX3SbP2+QkTyfl7bcl6bhRVTbK64leT1biSg4/h9va
 dJH7sJmhkyU75vmtpp/MvfiHzE2TIkQ+2deaj3Hp0vg5/GEmrPLrBk/rebAXueDKYLmDuJlhIL6
 Y4AFPh4uWN2ox8bFvUFHxG/wVuig==
X-Received: by 2002:a17:902:f64e:b0:2b2:50bd:83b3 with SMTP id
 d9443c01a7336-2beb035c826mr231476725ad.10.1779862986733; 
 Tue, 26 May 2026 23:23:06 -0700 (PDT)
Received: from z440.. ([24.21.231.36]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695f05sm182387205ad.6.2026.05.26.23.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 23:23:06 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Manivannan Sadhasivam <mani@kernel.org>, "Kael D'Alcamo" <dev@kael-k.io>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: display: panel: Add Ilitek ILI9488 panel
 controller
Date: Tue, 26 May 2026 23:22:59 -0700
Message-ID: <20260527062300.88928-2-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527062300.88928-1-igor@reznichenko.net>
References: <20260527062300.88928-1-igor@reznichenko.net>
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

Add binding for the Ilitek ILI9488 panel controller which is found on
the FocusLCDs E35GH-I-MW800-CB MIPI DSI panel. Add "focuslcds" to
vendor-prefixes.yaml as it's a brandname and a website
(https://focuslcds.com/) for Focus Display Solutions, Inc.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
---
 .../display/panel/ilitek,ili9488.yaml         | 63 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
new file mode 100644
index 000000000000..ea7449273022
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9488.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9488 based MIPI-DSI panels
+
+maintainers:
+  - Igor Reznichenko <igor@reznichenko.net>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - focuslcds,e35gh-i-mw800cb
+      - const: ilitek,ili9488
+
+  reg:
+    maxItems: 1
+
+  vci-supply: true
+  iovcc-supply: true
+
+required:
+  - compatible
+  - reg
+  - vci-supply
+  - iovcc-supply
+  - reset-gpios
+  - backlight
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
+            compatible = "focuslcds,e35gh-i-mw800cb", "ilitek,ili9488";
+            reg = <0>;
+            vci-supply = <&reg_vci_panel>;
+            iovcc-supply = <&reg_iovcc_panel>;
+            reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+            backlight = <&pwm_bl>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..5ab758570248 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -600,6 +600,8 @@ patternProperties:
     description: Flipkart Inc.
   "^focaltech,.*":
     description: FocalTech Systems Co.,Ltd
+  "^focuslcds,.*":
+    description: Focus Display Solutions, Inc.
   "^forlinx,.*":
     description: Baoding Forlinx Embedded Technology Co., Ltd.
   "^foursemi,.*":
-- 
2.43.0

