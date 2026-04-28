Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D932FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799EF10E362;
	Tue, 28 Apr 2026 14:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QLESFZwN";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A27910E0F7
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 14:05:53 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so7431984f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777385151; x=1777989951; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FnRMYZk9AoTLKpYfdj4qSypPzAu9CBcixbEqmVErBwg=;
 b=QLESFZwNMfIBBN/fKdRDEkGh/O1TajZI9d1lwsgJTf5Aay/3Q/PbtSdNxmj7YqG9aL
 1BQnIzK2mV1iGQPCo/7xAqXnGMkUR7AEVnLDdjuUu9KN0sEOUOgmL8P4ghPARXRKwIDo
 f+R8gaBWAIs5SehZpWNPBxltWDOYcIFBvsukgz5lWPPbEh4JkDg0NxQsTpjYW4tEXCk3
 QfjQUwW+aaMkYCExuWGIG5s/9898ANOppvSYV/QyqWB+Qx7z6M8vGqMnUWFbqXSSVhZC
 ARzIpbvbDojtzYRozeqU6ddwelA0Jgsd/zRd7Moui0Fd19C+1FHvOfZEAN+VLnaiUURg
 oHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385151; x=1777989951;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FnRMYZk9AoTLKpYfdj4qSypPzAu9CBcixbEqmVErBwg=;
 b=AdPPvOR44ULS+ap2FcYoir2MUw+Wy+axCOsnXa40mMS1n42o/VE4Xei2j3iOQqbuBl
 Vv9qZqMx+ToZBFPqbR4SKzFon6mLk4ma25uLTd/kJxco2inTk/KdTUajYbKvmwGU9pQX
 NZFXowKY/o2Neudn2p9FNhZGk0EaMqllDyRjQLL1OLwml/Q++2LxXt8n5//w+sajM1wP
 zmun1mclFcMcaicSFyODHp3t4++2w3ZcDB0b7h6Q3P/PPkuTNsiFwRQiuGNgAXneHS1h
 JOsXXKT141qBC26vf6W+NGtkbxyN59JVO6SFNlo7yIdRgQjQpOxQzC2fiM+BGz2jue15
 FmHQ==
X-Gm-Message-State: AOJu0YxCZt0m0gqbT5jGDvXzrXDRLPqHQma+R5hz+Xsdm7ZgAX1cTcsW
 duG3ZjAdoCCYYO8kKaBSkK3ZCk4bK+oaFT7xOGdflOjAU77tvjqbmZ2xbpBAFfhsibg=
X-Gm-Gg: AeBDievJDxrOLaE+p7/P/a4m4F15Kv4UqcLYZvKJOsxyGhw+YUsgGFHAgMUQVl1Ih23
 ZYQVvzhjsd52JzYjEVWzygm7ej5JnERQHKOXYWbtpvW3oQ1Gc60TfdSYQJi1Jg9/9CE2EvlQDsj
 HReeThiucTCCBzmAx+xWaer+5ahuZ4TSqS4mcJ9bg/GsL9U5R9+JFm7VHHpZDYJ2C1QQx0WcWRj
 y+Q+B9OYiaSyrmhcm2vczXPB59RVR6/pSFhT8M2zHPyOlEu+nTFJDvOzWim+5mOEdoXgVgik4TF
 ADBQGh7UUFd7Y/7tpptHcpNFvx+bihbbix3MzDbGmRlp2wAJNvfxKYYfIMOAiZyan0+WTsdLjGU
 rHGZ3xxiqo9VVFXNV1/Z51zNfG3Bo4K7IsovIyvXYdLFip2JWWUPihzS9MR6ZYxXdgsr8pqCg4T
 ZdVANPirJG1IMT9c77oNm2jr5vhLWBcHIthXs8JlplWYbcwfasuDhpqUo=
X-Received: by 2002:a05:6000:2f88:b0:43d:77a8:3baf with SMTP id
 ffacd0b85a97d-4464b1b8620mr6133552f8f.32.1777385151303; 
 Tue, 28 Apr 2026 07:05:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4464004ed80sm7143264f8f.34.2026.04.28.07.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:05:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 Apr 2026 16:05:46 +0200
Subject: [PATCH 1/2] dt-bindings: regulator: document the R63419 based
 dual-DSI video mode Display Panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-1-981eb5ab5a51@linaro.org>
References: <20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-0-981eb5ab5a51@linaro.org>
In-Reply-To: <20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-0-981eb5ab5a51@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2731;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8AhOD+DA7zhgZsiv1DYImW1qYoVVKswrctJNPegNwkA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8L68gmergD/mdWEyvIOSW4ZX2Dqq0B1E4+WS5gXQ
 pNG2cpGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafC+vAAKCRB33NvayMhJ0YTFEA
 CEo0fnwHQ6I5nJ6bxVfKUkU5SWUTJ0biC77jpSou3g4o0ec8qrm969D9GoXh7zh86DfcfhI0X1FMIA
 W791j5j+DlQdLQbLnJ2M/hTHmsC0iNv6ojbU/ZT4kRIyOJzduyv2Cp/pa6O9grXzWtinU64vGuajCc
 yF9x6xXbZ64z/7cRI1Av6dXVlT7MbrypH6JOTV0W3ne8I7PgwX2y/yBeEZySE0KhApLahfsNt1cjXB
 AZG7c4qM7aqotSuvu8H9pbgmsqNJvdCixUTPDcud1US/6Z1jp3nickwrvwxzAT4kpQ4kWRH27nL+y2
 V9K2rLjUVUGCUFbdkOwdPxw8KJvhKv44yN+OMCpF+3voiW3AeyQmEq7EOF3NjN4FEi5oUntHQR+A9Y
 BNAF8kPfvuvXl7LosB/nhSm9Za1dAPh7F26m6yVgky8nIvJ3mpv/SaIOwqC9CLMWXAg8xC5sKzWXin
 YnrqmA8leQBeGp6p0U8Y4olBs2dgS47bX2c3RZYdTs1pEDD8f/RDlnNZLR0QUsqc28ZgVGJdJfcjCB
 TeDLLmpjlyeQ+7WHJIiKwuKM4WCem2b+45VLaGqkAgEPRPqa+xpthYh0VhNwyztQbJ2Uh2IuGUfwRK
 g5FgwTWgpT2qxEyq9kb62e6Dg9JL2kuY6e9wCdyMZF8yfbni+qkb3S8y4OIQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Document the Reneasa 63419 based dual-DSI video mode Display Panels found
in the Ayaneo gaming handled devices.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/display/panel/renesas,r63419.yaml     | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
new file mode 100644
index 000000000000..5777930aac78
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/renesas,r63419.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R63419 based dual-DSI video mode Display Panel
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  The Renesas R63419 is a generic DDIC used to control dual-DSI LCD panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ayaneo,wt0600-2k
+      - ayaneo,wt0630-2k
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+  vsp-supply: true
+  vsn-supply: true
+  vci-supply: true
+
+  backlight: true
+  reset-gpios: true
+  ports: true
+
+required:
+  - compatible
+  - vdd-supply
+  - vddio-supply
+  - vsp-supply
+  - vsn-supply
+  - vci-supply
+  - backlight
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
+            compatible = "ayaneo,wt0600-2k";
+            reg = <0>;
+
+            reset-gpios = <&gpio 176 GPIO_ACTIVE_LOW>;
+
+            vdd-supply = <&vdd_3v0_lcd>;
+            vddio-supply = <&vdd_1v8_io>;
+            vsn-supply = <&vdd_5v0_pos>;
+            vsp-supply = <&vdd_5v0_neg>;
+            vci-supply = <&vdd_3v0_vci>;
+
+            backlight = <&backlight>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    panel_in0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    panel_in1: endpoint {
+                        remote-endpoint = <&dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+...

-- 
2.34.1

