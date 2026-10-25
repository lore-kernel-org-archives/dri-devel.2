Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782A606A323
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=CCdQH6KE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3143010EC7A;
	Mon, 26 Oct 2026 08:36:51 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32AFB10E208
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 19:16:44 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso6694305e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792955802; x=1793560602;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fXRuDl/kfmEcnVDe/qo2rO7Ex+8Z1Yq/lHQYrnrvp8k=;
 b=CCdQH6KE4j0E55PPi5P8EniQbOnjijiVd1E2aoprYL7kTiHSR0J3JxcpEVVcOOCHns
 fQUJuULa5aYuAIhKnGbOJaJQfu2q1KdOcKnspnl6ZbMm3M5g85quKt1xqRmnrRF/1I/j
 WsXNFJS4YMC/g/L1JBV3rJn4Zd5QcZgnfbPFrisk8VRmPYWNxfR57diEb07Qifw+kdyT
 7eLALoL6eUkYO9Mu47IACUm8WQGYFE6G+uCPBMC0Ku4t6OGAVfFa69oWUBDZaIO1i1qA
 ZrmngkLaGlcBKdp75fZYTitD+oTU825m4nLLEFJDvnbgtBGpv3Zl3EEnkkOEqEZ+Ii7m
 lzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792955802; x=1793560602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fXRuDl/kfmEcnVDe/qo2rO7Ex+8Z1Yq/lHQYrnrvp8k=;
 b=iEH+RpXpO+WyEv2JR/l2fJFEOIE0Aqimi6ZYn+BbdDS9iC7YgoGKxePuqeuVlQ0KKg
 ZPtGhELVaIDln4nu2KZKPxb4TsU/ywXpT2/qk+/CvZY7vwGYsr+Vx0MLn24R+RqrjF4Y
 aqr9bU/HkYW/eGOBaMEenKhaBNucYzpHKLtta0IWJnThH6p+CmquT0eX98GmhUCy8R3T
 yHz+8LQ7PkWyXd72mEvgOqvI554Z8lWZ5p3xkdvyHWgrYubI9VC0R6v2YJS2A5szlAjx
 RVE+wXifppH5BtFFAL02+zXFLriXd4AEweEKbHa3+Y945ESiSPE55qKoajmfzYa2BNW4
 Ux/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDCGU5i2SSEQ2ipkWSzAI3/K0izQnZxFKazCLfhRHn0Pu5PROR/TtyN99fD+6eyQOcSjzklcRXjo4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKGGZ3vY3cY1/eUl8eBZBvQoON7aHKoxgUFuv7AJ3jmhVgWpKGb
 nlUz6IJFvjZ1UUtl/OSLBmhVND3Sq5h+Ok525n1B8Dh5UCLVuZLtww3HzpJL5Nko7+A=
X-Gm-Gg: AYBFou0DuKV46viFoor20PnaH9JfXWoHqj73vRzKMcJLa48c3xX5aefPyBtlmVJtavi
 +1R3VUqUrbOUtLC+Nd6k+IzoxiMVR7OSJQgESMtTc2dgXNnFmsDYllfkuUHuqrTGY0IwlPvjy4/
 723T6gmbJrysbRjTv68hElt3YgKHV6levEVdfQo0YV8rjiBOQW0BKgfI+DxivZqQeUX7X8oNYm3
 56lEhyJ9bmHioWPuSYuWRVf8e8aEVpy5bOBF5AdxvE6QyrCOfnswubME1SXm4WY4vD+e1/m1mNP
 Yvgt0pWf3GVzJbVzZuucXgFJ3GQzr5zK3EEsBsuNHZ+kSg6ZeSxYIisaYzxFHfZHsSaNirhWx2L
 bdopinptSHCtywNMKg7EqiE2KVOLUotu812Nzs+he9kNX2vPVDM9zMxhNlH6rbLd6VQFNDs2Kyy
 2k9soOxFURpQ9ZXUTqqRFKuMgA/+4adRi4vS/a2MRkR3DjLoaAg81d1g77QL2USgzovM9LPP0cp
 ZWwP8hhDApvAQLkmDoo95bD2GAp6QHNFdnW08pk3od4KojLf6sv8rgfARUnwa5+d9m9y4z3i12n
 WEHUGCjpBWeepWA=
X-Received: by 2002:a05:600c:3e8c:b0:4a1:d2b5:38e0 with SMTP id
 5b1f17b1804b1-4a35acbcc9cmr72896635e9.25.1792955802524; 
 Sun, 25 Oct 2026 12:16:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5822a7sm144560865e9.11.2026.10.25.12.16.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 12:16:42 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 2/5] dt-bindings: display: Add the Ingenic X1600 LCD
 controller
Date: Sun, 25 Oct 2026 20:16:37 +0100
Message-ID: <20261025191640.13592-3-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025191640.13592-1-olivier@mgcrea.io>
References: <20261025191640.13592-1-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The X1600's display controller fetches frames through descriptors and
keeps its interface and timings in register blocks of their own (X1600
programming manual, chapter 10), so it shares nothing with the
controllers ingenic,lcd.yaml describes. Its registers are those of the
X2000's display controller without the composer.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 .../bindings/display/ingenic,x1600-lcd.yaml   | 70 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml

diff --git a/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml b/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
new file mode 100644
index 000000000000..171536c78f4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/ingenic,x1600-lcd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic X1600 LCD controller
+
+maintainers:
+  - Olivier Louvignes <olivier@mgcrea.io>
+
+description:
+  The display controller of the Ingenic X1600 SoC. It fetches frames through
+  descriptors in memory and drives a parallel RGB panel or a smart panel;
+  its registers have nothing in common with the controllers described in
+  ingenic,lcd.yaml.
+
+properties:
+  $nodename:
+    pattern: "^lcd-controller@[0-9a-f]+$"
+
+  compatible:
+    const: ingenic,x1600-lcd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: The pixel clock, whose gate also gates the controller
+
+  clock-names:
+    items:
+      - const: lcd
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: The output, to the panel or bridge.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    lcd-controller@13050000 {
+        compatible = "ingenic,x1600-lcd";
+        reg = <0x13050000 0x10000>;
+
+        interrupt-parent = <&intc>;
+        interrupts = <31>;
+
+        clocks = <&cgu 16>;
+        clock-names = "lcd";
+
+        port {
+            lcd_out: endpoint {
+                remote-endpoint = <&panel_in>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a08087fb6e67..98d46b1cc029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12927,6 +12927,11 @@ F:	include/linux/mfd/ingenic-tcu.h
 F:	sound/soc/codecs/jz47*
 F:	sound/soc/jz4740/
 
+INGENIC X1600 DRM DRIVER
+M:	Olivier Louvignes <olivier@mgcrea.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
+
 INJOINIC IP5xxx POWER BANK IC DRIVER
 M:	Samuel Holland <samuel@sholland.org>
 S:	Maintained
-- 
2.39.5

