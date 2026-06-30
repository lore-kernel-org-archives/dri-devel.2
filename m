Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BEBC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC2610E14D;
	Tue, 30 Jun 2026 02:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JbRTRSB7";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF55710E14D
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 02:37:20 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2c9b42be8feso22504255ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 19:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782787040; x=1783391840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIDvIEEjfLAoYUqaVOiOTF/fktMs0pzzICShunhvFN8=;
 b=JbRTRSB7QtXFBd61Y8YSdfKPvkei7YmURZGXtuC4q7uh2ZOrf53z+B9aMBQ06m13Ht
 PTSrhiagbtC/uyWop8MSSHhUKiF2StWxvk86gdmy6W629QLHsXdv3PUWyineuWumdxdj
 5pbHzDzYhSML0rqVGEsGLrLC6GrE3lJe/kRr7U6l0zX/Gl9xNN6AphGTnbM/ah7n5Pp/
 7rLWWAk1u9K3Wni7uCzYTyiGHUbsJb7cmZmQ1J6+C9H28ObYc8ZkEay+/odVA4SAU3Nk
 MNvgGdxFtuuZUEmnjlLBo2o9ONfc1pveBLRcO6VPoYimNQuUnADAek+dILDm5emSePh4
 PsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782787040; x=1783391840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RIDvIEEjfLAoYUqaVOiOTF/fktMs0pzzICShunhvFN8=;
 b=oDrSW+3HmTDgP51r6/Fai918RsAKj3gQCzU0rY07B9OnYlQwaaQdRbdbH0eL9rMbpj
 kPUvqjuJcW0UfL1FprLxKwdIo+fSBQp0NKR3wpJcDRMfA7Gb4jNCdptqAFebc1nXWc+u
 QjrPylk03McefNkbtIieopK880jX1kJP1TzHZJ/OBmUQbtAuS+npDf4tELIfI8LWGgFi
 u18hJiG/w/s8R93I9GI3bEsWLQG+VMKC8O3JRGdpT3hFFZp3Nqf9KMbWe0XQWfB66aO2
 CjjJkRNEMIXMhBvQbzk2YP7sf2cF5CI0N5eXpjFeuJcup8ZaBYqqEOaMsu7vNICIQuZD
 isAA==
X-Gm-Message-State: AOJu0YzXe7nD3ZkHolNMQGd4Eyy8BxHYA7ws/6fGG5sxMyeCIFLqGhQF
 xWO+DAAsel6hqVmMZRn9cFIP1trGkHsItL3Sl7g0nJz5Vtm4N719PHkU
X-Gm-Gg: AfdE7cm4bnGOfyIBeWNWuSDKvk8wmpR+I0S3AweMOWq2xFqHLKNhqW5DQZK3EPRWkKl
 +mzjKrryEHAbUs5UGxUASH1wPAaDEIgjhI+3HkXHnTcdETiT+s6hV0qO0XGwIhV5j5N+GLsZ+63
 VJM2LdMbD+nLxHBl1/GdcqSopLVT8LlnXmpl0NmSR4EB6TQiShRZFumdFyrmBlD4D0ZDZ2dChpA
 pLlT4p8cvw5fVOxLYbkgsrGWEXcEsh7pnLDBiM7iZJELgcb6fcdWkjpfl3H7ijlJ4vZSsXOSLSE
 Ru9GjXtXq6Yv9lnhSVDTQpXJyAaJ5grqYLWwZwDsE/bmZyf5cD6/vQbTD8KrqjgdbP2SiQDBKQk
 RgGqPRioCuzC+4QSFRn2CUd8UdLvPWnOgBSmH/rBoHnGfG8F2n88fZSkSEwgNn/fA+Yk19wFfJN
 WW410dhZcc4CQ=
X-Received: by 2002:a17:903:8c6:b0:2c9:97a8:8c1b with SMTP id
 d9443c01a7336-2ca2eb32b10mr13789275ad.46.1782787040083; 
 Mon, 29 Jun 2026 19:37:20 -0700 (PDT)
Received: from nuvole ([2408:844c:b00:2b2f:398a:8bef:b88c:653a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca3828c2fesm3310465ad.49.2026.06.29.19.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 19:37:19 -0700 (PDT)
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
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT36536
Date: Tue, 30 Jun 2026 10:34:38 +0800
Message-ID: <20260630023439.248861-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630023439.248861-1-mitltlatltl@gmail.com>
References: <20260630023439.248861-1-mitltlatltl@gmail.com>
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
LENOVO Legion Y700 Gen4 with a 10-bit CSOT panel.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 .../display/panel/novatek,nt36536.yaml        | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
new file mode 100644
index 000000000000..f854fc99ba81
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
@@ -0,0 +1,90 @@
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
+  Technology (CSOT).
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

