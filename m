Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5E0C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 712CF10E1A4;
	Thu, 24 Sep 2026 14:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KkWDot93";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B94110F615
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:54:15 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 d9443c01a7336-2df88e75374so362925ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790261655; x=1790866455; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NeIicMve7ehJE9aOQQanCJG0U7pMjZjhCXnTq3oHqAM=;
 b=KkWDot93QN3ePuPA0T6/X471eTVnZULUv8qHRnmBBPkyco+oeX8Q5/v1klmOt8NfCi
 RVxjxXhOOGhoxZM7c7valEF4dzqzhYKkmc0xYWEMmSgMucb35frBKxxbOeCAOBsZdeuv
 lWJU3UBl1PA6s50niiWQ+KJnLm75ucYdwgD5816u/G88tHm0WtRNqxmy0wAi/LKtzBVw
 fnPFPNbIVBTU+ao6bd87sKaEQvny+LSahMzjn7TkUpu/VvW1jL185vZJthg9Iu/lazam
 VKVWlBSbP7wFYUL55Wgtr99BZPloa6txWrl//2QLB9usoVTyWSluw1RGqPei3wFaVQrh
 YXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261655; x=1790866455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NeIicMve7ehJE9aOQQanCJG0U7pMjZjhCXnTq3oHqAM=;
 b=avDV0wac+d1OFnn/qgm6OonPfZU5zf6BreoQH6ZyPr6flXNh0GxiraB5apCgHo/LGf
 aDvJrHFxfKTGR5npwmqKuLcaO8vAWDZY68nrf5r2z9fUtbcb7KaVgkE6PPzoQ34H/O07
 P0RwdzrlBr5PeY1o9CxvNSVDxVzcAkEsPqPBwBslXJwEFUb7tKEqWOunN/ZWow1m/DjR
 qOVk9HM3pcbe5QTczVv90siI+o4ZsBC1myhBIJT9X8Jw/BDvlZgz3oa8/NI0yB8ayYge
 eU/0kJWeeZQLshTQzbcVzN1EsLX5n2W4IcCaXXIAZFAB++XCZtujzpWb9Mdld9AyEbU+
 hA7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgTTDO5o2S5qqOGMcDChgwU46GqWQLwC6g8D9WJimEOXN/YOEz9OFwPCsRokp2C5NPx3xvYGS5tk0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n+zFmMWdEjjnUEEjoD60nI5Br/RqippaHnZiXZcDGHckEINGtm
 9Ci0YZe2qslU/0dWhw2MwEyxNVgRZkN2OeIfWMvUKArnpo+nSLYK50pM
X-Gm-Gg: AYBFou1gUPsat6gBSAt5pBxStUS1EirOxMIUwiLjjg2RSLm0xV20ebkG6X0GW8lc+3K
 MECAxj7ATwO9ZzbO0hNJYXd38GOrRg/8bWuNN3R6gGeRNPylC5XLbOTQHRaxnJONQzXpPQmmDl8
 utS6prp/13MT/aT2h3nh1gHalJ2JbxF+DoppaI2XJbS896FuKjOSJopy/2nZXpCKr5zcp8o9MgP
 qAZwpyrvazKNMrdT74whtID/Fk05O9FYRTm5jYZ/U7rMjktAZ0VUgLLr6ZQSagVyR/aR4vDqrZs
 Dp0aS5isVBi45QXyOFif7gbhDrx19tZnyAoNMBJmPO4VjLuSxamGGWYLKtqqo7GjXnFgIJhXqtO
 QvgupDsCplII5KdRtgd8GXJsVSFVqlrnI29FCDZF9VPjfqeihFe+9pzEc7zKw+AL/gjAAYTWN5h
 GUxtKvBbg1tUYbJIQf/JhSwEYlBmV0ZChtE7w5raIUnuRygxCRbDrtNfVIxm5WNgzwacnVDQ==
X-Received: by 2002:a17:902:cf4a:b0:2dd:8b95:d8f6 with SMTP id
 d9443c01a7336-2df8e574a97mr1721755ad.1.1790261654451; 
 Thu, 24 Sep 2026 07:54:14 -0700 (PDT)
Received: from marchy ([2405:3800:9cc:defe:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5c2f3bsm28750015ad.39.2026.09.24.07.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:54:13 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Adam Azuddin <azuddinadam@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add RAiO RA8875 display
 controller
Date: Thu, 24 Sep 2026 22:53:55 +0800
Message-ID: <20260924145400.1385815-2-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924145400.1385815-1-azuddinadam@gmail.com>
References: <20260924145400.1385815-1-azuddinadam@gmail.com>
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

The RA8875 is an SPI-connected TFT display controller by RAiO
Technology Inc. It supports display resolutions of up to 800x480.

Assisted-by: LLM
Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 .../bindings/display/panel/raio,ra8875.yaml   | 78 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
new file mode 100644
index 000000000000..b50fd95c5753
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
@@ -0,0 +1,78 @@
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
+description:
+  The RA8875 is a TFT LCD controller for panels up to 800x480 pixels.
+  It can be connected to the controller via 8080/6800 parallel interface,
+  SPI or I2C. This binding describes the SPI-connected device.
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
+  vdd-supply:
+    description:
+      3.3 V supply for the IO pins, the oscillator IO pins, the ADC pins
+      and the internal LDO. The 1.8 V core rail is generated internally.
+
+  reset-gpios:
+    description:
+      GPIO connected to the active-low RST# pin. Optional, since the board
+      may instead use an RC reset circuit.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - display-timings
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: display@0 {
+            compatible = "raio,ra8875";
+            reg = <0>;
+            spi-max-frequency = <16000000>;
+            vdd-supply = <&vcc_3v3>;
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
index ba2002969373..99d5113fb035 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1395,6 +1395,8 @@ patternProperties:
     description: Radxa
   "^raidsonic,.*":
     description: RaidSonic Technology GmbH
+  "^raio,.*":
+    description: RAiO Technology Inc.
   "^ralink,.*":
     description: Mediatek/Ralink Technology Corp.
   "^ramtron,.*":
-- 
2.55.0

