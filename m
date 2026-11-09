Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6902606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=xpkQT2Lx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E3F10E930;
	Tue, 10 Nov 2026 08:33:30 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE3810F483
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:47:59 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so7776325e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 09:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mgcrea.io; s=google; t=1794246478; x=1794851278; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPQrRdeY/kRtnbmlFvQBDv3Ep9Z0Ve/f+uT8OM+fsyc=;
 b=xpkQT2LxILUNGsQdIUOsYd92G01c4HoHsThqre9LvZ4tESYc1M5rcd0sMVst4P2bxn
 dQT/wtr2+lqNKWMFhOu6LQlMKV4izdcYnMqRyOWWWZTrc1Dk/66qQJzE6istWyB0RthQ
 RbIRwn7eg0qOS600HtM/SQJMyt6B2sIiXz5igIuXkOLTTtynsPR0vqvNisjttVUy1/cQ
 /QXGAab9oU4bRHTiiMp7Od5baUuPI7EwqEvXbI/6WSwoYRu2rVwlINq2bbhMQl7qnKiZ
 NbSSt3zvRmQ0x92xSBV/v9wRsqDic0/yKjWrrvtVDII3h1Z588kjWdv+UMuDcVsGP1Wu
 r3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794246478; x=1794851278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZPQrRdeY/kRtnbmlFvQBDv3Ep9Z0Ve/f+uT8OM+fsyc=;
 b=0WkMGp37W1NTpN2djzM27L+wTdGoRtJM2RHL4rMwuPEQDJpPLtH2y5pTA66KEjw/Cd
 sJpkF/TtjRi7Bkv9knncTxXl39+KcVMiHkGlbGVK/JNMuXB6yIqDN0kmysJbkg6DaOQL
 Rw1PASMG6/bxxE8VF0YCR3v5zIOns1L+W9xP0kbwIRAsf9Jn+F573ZI9kbcptgaOVrfI
 5yTouk/hp9TloipxQinaYWIgdokMx3W+ETU9YHpAdsHByap2D2wixQVeSNxXgeTQSlPt
 wHi+d1nbmt2LJO7BBd/cl5dPyl/WOJ8YRRWx1Aq0/qqGf7kvQu+4rikx8/+XXxkxaF0p
 ifOA==
X-Forwarded-Encrypted: i=1;
 AL+hErHlJQOx+/zMML2k3uP61qL18vkUeQm4f0QZqPej7tQflHDsu/WapDdhrwX56kDauJ5hoq9Kk9XU/UQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+mAjMWCZ0jmQl04ZnHCkEPW5xyxWlTntP9bObVn5ek1YnjLJQ8
 jgYNZx7ykXo6O8wMR1G98Uw2TX3lTEg3E70Io7FJRGyWnZ1Noqb9Koqpq5brjiTlCPI=
X-Gm-Gg: AYBFou0bCoNeG0cCBOnVzj0+QoaLZxT3PB1cPrPSETJuH3vs5wzdTE9jQpZosdN2JDS
 5BCElMuulr0khiC8dE+kT6Nf01nQCicedXyVkTHA0HSJh2BRRBQxpr+42UyZYb2l7iZOhq7oKe3
 qB2tefX+9LhEiRDQbFnoGslnw4F2Y5zj6WF1X0yI3Xy+4TBiE+d1aRdsLn4DGUdE+0Bagg0e0f/
 i0EEh1Esm60WuNn4OoyuFxABcl5Gi8VS6ynNdBodlY/wlbRT7SIDQXgzYmzsqGh0roSNsR/nQwo
 QC5wyI30jAe7uhDuK/UbAQHTRUPBtYCuhAq654ozJp4j1GnRTl6mdLQvHgVi6JkWhaGTUBj6gj8
 GIpja0XOuqWdd7ndgsHluofbOeuaRs0IdQO9X+Q/h2NNLH/JCXOH8bHzgMfVLfP76isTyq3dWJX
 1JS8n4R11msmPQJWHK3hKKU0Y31mQ7eK1bYbQzH5CVzGddw39N7+fVB017rhJlAfUG5pSjJnUIU
 QeUf4o1ph2v1PM7MWGQiHfm2xD/+Ugc75+xCWBFFdKnW4GO8KyGq8/TZl4ugeJvw8eFcGDAFvxR
 Sbq61G/tSxitWolKzIW6mkwU27mU5qgsQkQ6rxOQg2/OCxt68ttl23CFoltoOZ57CQVIpuq1BGk
 OcPqwUf+f
X-Received: by 2002:a05:600c:46d0:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4ba023052c9mr134995e9.4.1794246478209; 
 Mon, 09 Nov 2026 09:47:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:e834:fd4d:2ecb:b787])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm167322f8f.53.2026.11.09.09.47.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 09:47:57 -0800 (PST)
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v4 2/5] dt-bindings: display: Add the Ingenic X1600 display
 controller
Date: Mon,  9 Nov 2026 18:46:37 +0100
Message-ID: <20261109174640.96951-3-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109174640.96951-1-olivier@mgcrea.io>
References: <20261109174640.96951-1-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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

The X1600's display controller fetches frames through descriptors and
keeps its interface and timings in register blocks of their own (X1600
programming manual, chapter 10), so it shares nothing with the
controllers ingenic,lcd.yaml describes. Its registers are those of the
X2000's display controller without the composer, which the X2000 and
X2600 manuals call the DPU, as the X1600 manual does in its register and
clock names: hence ingenic,x1600-dpu, which an X2000 binding can extend.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 .../bindings/display/ingenic,x1600-dpu.yaml   | 61 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml b/Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml
new file mode 100644
index 000000000000..0e9f4442e4b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/ingenic,x1600-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic X1600 display controller (DPU)
+
+maintainers:
+  - Olivier Louvignes <olivier@mgcrea.io>
+
+description:
+  The display controller of the Ingenic X1600 SoC, the DPU of the X2000
+  without its composer. It fetches frames through descriptors in memory
+  and drives a parallel RGB panel or a smart panel; its registers have
+  nothing in common with the controllers described in ingenic,lcd.yaml.
+
+properties:
+  compatible:
+    const: ingenic,x1600-dpu
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
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: The output, to the panel or bridge.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    display-controller@13050000 {
+        compatible = "ingenic,x1600-dpu";
+        reg = <0x13050000 0x10000>;
+
+        interrupt-parent = <&intc>;
+        interrupts = <31>;
+
+        clocks = <&cgu 16>;
+
+        port {
+            dpu_out: endpoint {
+                remote-endpoint = <&panel_in>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1c3aec082b0a..ca3f1a4bbd3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13182,6 +13182,11 @@ F:	include/linux/mfd/ingenic-tcu.h
 F:	sound/soc/codecs/jz47*
 F:	sound/soc/jz4740/
 
+INGENIC X1600 DRM DRIVER
+M:	Olivier Louvignes <olivier@mgcrea.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml
+
 INJOINIC IP5xxx POWER BANK IC DRIVER
 M:	Samuel Holland <samuel@sholland.org>
 S:	Maintained
-- 
2.39.5

