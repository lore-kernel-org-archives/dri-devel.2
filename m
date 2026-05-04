Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D17ACD3439
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2516A10E987;
	Tue,  5 May 2026 07:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FvaewfDf";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A0F10E0B1
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 02:14:17 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8296e257735so205666b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 19:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777860857; x=1778465657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2f9qY6qIojyC+n3cwV4DcJgl1Mh7dbRflEA4i8ZvFGU=;
 b=FvaewfDfMaxttqvF9E2h64ql2+GXkUMK7Q7i/EF/t9GArqAA7e62oUtYL8jEP4Z4pJ
 2K6uSMZlj3Jt/ksIiRTJHYDxAMdDMvgDwfaqlNJsS6wPK88hTyelOHi7+3iqCjGfN/bE
 8r2vTcYzPVmla1TZ3oqmGNlxEA0PsliF5DQA0b1iMYAauJj+7cwM7/rzRFuQA+nGWkjb
 tiqWToCM8g5UFbAIwzMVq9meQWIjxGgCbkm1Dvo+7hQ9fnVol/MpERK0I8EqQJjW4Z2S
 kwAfqJc4jnyzZJMzprYL8Gxps57zdaIG8zA83Nq9yOBojAHN6C39+SwlBBoWtF9JC1J+
 P3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777860857; x=1778465657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2f9qY6qIojyC+n3cwV4DcJgl1Mh7dbRflEA4i8ZvFGU=;
 b=ICN5o0BCJEsjpsd9zp1v2byAM/4AEXKnkjEwO2C1UUa5ddjWneID2BiYNBcDa/9eDM
 A39+Y0txjWZsYFGQw5jk5x2DE7gPeCqa30fsXpCig2VClFP51jzXAfgwV6dZtX/M/YBd
 JIU8n2tX88820R9nwcr12YVYmv7v6fs2Id6wql8M6TRt7PECwmB8SN+c739DdipTZgBo
 zNrQmI+jUErntXv52u0SEMoVnxymkVng5RAcg/L4752/5XanTxc+/ZLTpP01nx1g9rvO
 NogAUfPWBzYZnEGyq6DYlY/H9JCLvUjVUndXQQT3/tJCHxaNxfD/sCGK96acOGn2gRHn
 n0lQ==
X-Gm-Message-State: AOJu0YxfpbqWDo3l/ao0Kuz1BffQhuDR5LRAmrFcEUZ7it9U3BGSx+uP
 pupvM6u2vURnPks0jawvbTKPJm1sHMoZySLYwsnrU4GcfayM43FRJjtG
X-Gm-Gg: AeBDietKMVsWz23njCVc1QKGS1rVZBTp2q9RskW39lJJO3sPu1C8sMMrpPseCUp7J7t
 IEAtXq74gYNa/jRbaJulQZT4YuYDQ20iEWhK9tfiyhX15uQ2wGlG4pIik/pu9V4NobBDPtKGvE6
 TIO4FATf93vNB3GVT9Vtj0rXEvLmcw60lZV7L7Bpde8YXjOa9COQFAnbFsf+sr8H1owYq4wHosz
 1jGqL73vkx2zJWQU0qYrUq9FUnrYXhR3U2EfPU1adQn5O2qempJTGtf81ZiC5liPWzvZJU0Yo7A
 APtmCpMB+7ThzjUA+sBztuEBsGr7optVixUFXFoK/3YeqTTWypIiBkZiOyeIZiJi/bwUU/JC3EG
 ltTCk8+inl2wUAmT8Q9dHuK0DhWDtdySYy7ouPojTwoIdhyPEj+h6IRL3I5I7V57W2N7+iqXgrj
 N/5wbALzt7AuSXpQ78sYI3sQq1DUf6NmAi
X-Received: by 2002:aa7:88c8:0:b0:837:42a6:58a8 with SMTP id
 d2e1a72fcca58-83742b5accdmr1150467b3a.2.1777860857024; 
 Sun, 03 May 2026 19:14:17 -0700 (PDT)
Received: from marchy ([2405:3800:95f:677d:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515b485eesm9072385b3a.48.2026.05.03.19.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 19:14:16 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, Adam Azuddin <azuddinadam@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Kael D'Alcamo" <dev@kael-k.io>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/2] dt-bindings: display: panel: Add RAiO RA8875
 display controller
Date: Mon,  4 May 2026 10:13:50 +0800
Message-ID: <20260504021355.72128-2-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504021355.72128-1-azuddinadam@gmail.com>
References: <20260504021355.72128-1-azuddinadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

The RA8875 is an SPI-connected TFT display controller by RAiO
Technology Inc. It supports display resolutions of up to 800x480.

Add YAML binding schema for the RA8875 controller, along with
the raio vendor prefix for RAiO Technology Inc.

Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 .../bindings/display/panel/raio,ra8875.yaml   | 76 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
new file mode 100644
index 000000000000..a49521242763
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raio,ra8875.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RAiO RA8875 Display Controller
+
+maintainers:
+  - Adam Azuddin <azuddinadam@gmail.com>
+
+description: |
+  This binding is for display panels using an RAiO RA8875 controller
+  connected via SPI.
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: raio,ra8875
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO used to reset the controller, optional
+
+  vcc-supply:
+    description: Regulator that provides the VCC voltage, optional
+
+  display-timings:
+    $ref: /schemas/display/panel/display-timings.yaml#
+
+required:
+  - compatible
+  - reg
+  - display-timings
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ra8875: ra8875@0 {
+            compatible = "raio,ra8875";
+            reg = <0>;
+            spi-max-frequency = <16000000>;
+            reset-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
+
+            display-timings {
+                native-mode = <&timing0>;
+                timing0: timing0 {
+                    clock-frequency = <25000000>;
+                    hactive = <800>;
+                    vactive = <480>;
+                    hfront-porch = <40>;
+                    hsync-len = <40>;
+                    hback-porch = <40>;
+                    vfront-porch = <10>;
+                    vsync-len = <10>;
+                    vback-porch = <20>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..ca453042f6a2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1361,6 +1361,8 @@ patternProperties:
     description: Radxa
   "^raidsonic,.*":
     description: RaidSonic Technology GmbH
+  "^raio,.*":
+    description: RAiO Technology Inc.
   "^ralink,.*":
     description: Mediatek/Ralink Technology Corp.
   "^ramtron,.*":
-- 
2.54.0

