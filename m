Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD7AC61DD6
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 06:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063AC10E096;
	Sat, 29 Aug 2026 06:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NjrVZOMY";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E37510E096
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 06:38:13 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cc1ceadbd16so1709859a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 23:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787985493; x=1788590293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tmcfXCWyqYWXrP5NL+KMYMRkQ9XRom7Vi8Cv0Onf708=;
 b=NjrVZOMYmKwe73OmY8g6eZe25bDmR/7MCc6/jeC2/Kji+VamZgqRrEwAjlpuBmHzJk
 0us7rGZTCvO5+vWzIrEru59IUnOxPw+7myzoOU1QSEB3IsmxedYs/5fS92RJFmYXU83V
 JXUlbLytxMLy4t7MLVsz2ElwAFbcO7i5IO5f4r94NtxgG1ofArVHTzzEzk7iQZ/te1FB
 YAF454ZoRzQLo8GXXxcZFVN5rDr54chHGaspnM+YdPMmRouAGjKSDL6B8ipZ6sZSCPCt
 c+ksx1apy8OOsqMwAJocCNZD5/s8zW5/Gqh6p0q6i9SYsJhfwJKKzm/X/XNtIfCFOLRf
 Ro5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787985493; x=1788590293;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tmcfXCWyqYWXrP5NL+KMYMRkQ9XRom7Vi8Cv0Onf708=;
 b=kLN5IRKjTsLgLmIE3bUKtGpVTDdoCnjjpLSuHXz6F2w2MdeBlRUtfOQLY7hGFRuHp5
 jvfPugECeQxFa4MwEuHbg6iWaxPdqh4hQHPCCRc4iY08rNYAes7fuekcsbiQ9GnAmAx2
 ndp5mQxainDcBBxqRUfAuWFrzWVhYruR9Wyh0Wh6b/aSiGmRenXWHqM+QI4PJtkUjwTS
 EY0mE70O4U0sHC7tRjYmedOfRyVyihDFr22DQNVjNnvgaJrNqB7DFy8//2CgfRPEGkbZ
 vcPB0wSWYAjGWpSzOxfXXFooXv5FGIGY5zC0VZEhxUypfRSYrJCXPn+qQ0UYQju3u4SS
 cKrg==
X-Forwarded-Encrypted: i=1;
 AHgh+RplS+LLyEb1CZJuYqNJR1H+t+yaspVhjUCreILmlleNhpL4pnw/q5p2ymGzcnXu2hU3nBM+v5KqgB4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nSWCRerV72nfC+jUI8bJgiuSnHcEqDW3XRuPTJx0knzfMCUhIf
 VOOljowq2tz9Dy4TsF5Hk6Zemj7E6PAQuK1KAJLJS/LKpzOmeq92Yf4=
X-Gm-Gg: AR+sD13Q2Q675thiyKDQJ1m5Vj3PVbnTQvUlYetaBMs13uo+yoXhJvaYi7IKq6nd+07
 nHyw8HFmCK0L+XLGK2LsKwUxdXYDPVVMEd41JteyAD5GRWuZg+k6/yNMfhFZHBlyeTnWgJ0pZE/
 E2fhxBdOeHMUYU/EJE74beUxzKYfQOd9+ocS9SqqYHIWY5QDDdWW+g+lEr8wl88Ah5cBAEAWJlm
 EygdjAafABuzb7KkqzYFJGSJLA9/krTdvIq/PWWU42dsiylrfcomaVznQkCt9NvCY/sff2pYLxP
 +UaQO24NAmRBiSjw1qRWEpSTBTxsSR+/skR7WJEI4P2TrYblg5k8BccKZTiPMplG/MoTjwWeGJD
 hPqEl2DVwNtTsF2kt7w+BbSALRCHqawqcqGaMhjLtRKlowsIHBlhTHjA6YdeIaFiZb3nX2VSC9Z
 bQHyvEuQpURQGjOLWWFtOiAYb3G3Tvv/fINxo8d8cNa3DAntK+yc9ZYzGwoGx4grAmv/wNXeWG+
 VQK7u+D++WPsCowJVZy+P5rPnIes94Ssj/V7vI=
X-Received: by 2002:a05:6a21:594:b0:3bf:49c8:f7b with SMTP id
 adf61e73a8af0-3d2681a3f3cmr23957289637.13.1787985492691; 
 Fri, 28 Aug 2026 23:38:12 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d1abbdsm10957539c88.2.2026.08.28.23.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 23:38:12 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 1/3] dt-bindings: display: add Chipwealth CH1115 OLED
 Controller
Date: Sat, 29 Aug 2026 03:32:13 -0300
Message-ID: <5e1a01043e1935d59d48630dc6211652e64b108a.1787973729.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787973729.git.nico.antinori.7@gmail.com>
References: <cover.1787973729.git.nico.antinori.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
NOTE: patch series based in kernel v7.2

 .../bindings/display/chipwealth,ch1115.yaml   | 81 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml

diff --git a/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
new file mode 100644
index 000000000000..6b037c40242e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/chipwealth,ch1115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chipwealth CH1115 Display Controller
+
+maintainers:
+  - Nicolás Antinori <nico.antinori.7@gmail.com>
+
+description:
+  Chipwealth CH1115 is a controller for monochrome dot matrix OLED
+  panels.
+
+  https://datasheet4u.com/download/1576606/CH1115.html
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+
+properties:
+  compatible:
+    const: chipwealth,ch1115
+
+  reg:
+    maxItems: 1
+
+  chipwealth,inverted:
+    type: boolean
+    description:
+      Display pixels are inverted, i.e. 0 is white and 1 is black.
+
+  chipwealth,offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 63
+    default: 0
+    description:
+      Display start line offset. Specifies the vertical alignment and row shift
+      along the Y-coordinate.
+
+  width-mm: true
+  height-mm: true
+  flip-horizontal: true
+  flip-vertical: true
+  panel-timing: true
+
+required:
+  - compatible
+  - reg
+  - width-mm
+  - height-mm
+  - panel-timing
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@3c {
+            compatible = "chipwealth,ch1115";
+            reg = <0x3c>;
+            width-mm = <12>;
+            height-mm = <8>;
+            chipwealth,offset = <8>;
+            panel-timing {
+                clock-frequency = <0>;
+                hactive = <88>;
+                vactive = <48>;
+                hfront-porch = <0>;
+                hback-porch = <0>;
+                hsync-len = <0>;
+                vsync-len = <0>;
+                vfront-porch = <0>;
+                vback-porch = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d2ba67c4c8e0..1d158ac83ce9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -325,6 +325,8 @@ patternProperties:
     description: ChipOne
   "^chipspark,.*":
     description: ChipSPARK
+  "^chipwealth,.*":
+    description: Chip Wealth Technology, Ltd.
   "^chongzhou,.*":
     description: Shenzhen Chongzhou Electronic Technology Co., Ltd
   "^chrontel,.*":
--
2.47.3

