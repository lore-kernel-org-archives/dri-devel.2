Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CA0C98314
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC98F10F21F;
	Wed, 23 Sep 2026 22:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nXSFu0oQ";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC73910F205
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:57 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c83397eeeeso999445e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202957; x=1790807757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E15zTz6LSPQ0+KOjqcr732bl7v4sHhRkFWWTNxNbp1E=;
 b=nXSFu0oQEFoxi6i4hrPMCuyEHbw0amaSY6jb7B50w7FGJzjmZVr0QIvqwkSCf3baWY
 kktII8DmMAG3ux2sE+r/k1AaKs9658bDTUXDNTey/dWkmBwMlFuhzYi4uB3MSmve1sWl
 gAW6u685aEe5FK4wBvVSvmqdx/bUyxbivMWc+3EH6BkTeKjOKQ4aXEvOenUIzL0uJ1x7
 T9f1IyRsvxYVoulZVdwbIRmRJgbXM57E7X9oUwmnLWXwwIFYxaEvmYsk9WqacHTDHzRf
 /Ge+QgI2naw+D+ommJA6reZHnsbWb5h1sfZRzCCElkumaJKKlgS93tks8MJSOOwWKzFt
 RdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202957; x=1790807757;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E15zTz6LSPQ0+KOjqcr732bl7v4sHhRkFWWTNxNbp1E=;
 b=KBwIITvFwOGPBo421bvAqQ37vp7/nSWOBfKPFih1YUXhFUuxMJ1n/bf4BFotYHRGhT
 kaMwVwOnCysQrr1A0G7rXPDToJENJZYzeOkLt/iSqyZkb5osYhcHZxwobHuPcciWUh/E
 I1wNpab5tqW1u3QtodsVMjUQ8TA4l/cUwCixCfccX9/fNBC6MANP+4NGsdPVPumbZk4n
 TXaFhnwkjtTluD2VaphCS2/1BspSdGFHpfvybJfTNkXchmKvRRF4DChQLwaRDuM+eF+F
 u8Vy4S+1C9x7r2l+ERHZ3bt2ce2z0jbKJwh7wieJ95y3oJoH+CrTn0sl2WHwvkb5Ras0
 YPfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkQDUKTorWfpegImSCsNH3uJTCHhB9ePq9/KKWYnZ6alQXrIrP4zcqDUKB6XNQpyUbkheEuixMOog=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lcpY0va9jBnoRaCI9SRqECbDh/+l7FsMgMDdj6yIYKrjI6l8rA
 orPodjbHq01bXfOtteTRxQM5SqJCkZi82DDaQlPJfttzfjbxMI/fvYA=
X-Gm-Gg: AYBFou1J/nx60rhNxjLXSec5NzqpS7Q+K8VZTJSVHZ38yEchGUGYF1q9sEnC02i3Yu/
 a6lfQCQgqUcI/wzyXZgQNKjtqFxxZZ95rt9MuZHu0k5jl9f5ed1Yc21KRRI8bL69pU44HoVXSnU
 +m2EYwk+x8XU0ejnGNyFN8dvGj6VDKiMCueo6pOe0AZfn3sspMXeRK5aEZQ5ZQ/b5H6CA8zEk8c
 fk6CbcytdnFkd+4QK+dQzq6k3KHLgPMMjNBdVOxgqFhDY9bmlZgIsMWTRvF24kllGe8hQajM/Nc
 rei6adUErKoBFg60zM9Xv1Vwgt5xO6a1vh6Q3mNfuenVQedxQrBtzYTdqWBGhDLwjlam6PHRK/V
 CF15fD9PGQ6cwlhRjl9pXroUsxQOQMgs6z2foI+z1WJ1LNfuWC5Y6cPGDnerLprsGr+Cai6uvLw
 1AiFKrN3qsfRyScCMZ/oRje3HfVxGn+vcDJ9pJrjlR4FddVzdCUQzY/2b9VQRJTpi8cqbFSIGkz
 r7RiSx+gNdNJVpM90oLJfyF/zdsEu3dnF5DXzHonpaTtMTYQQ==
X-Received: by 2002:a05:6122:198d:b0:5c9:82a1:a6a3 with SMTP id
 71dfb90a1353d-5cb08753a03mr590726e0c.6.1790202956828; 
 Wed, 23 Sep 2026 15:35:56 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9f04fb621sm5162983e0c.9.2026.09.23.15.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:55 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/3] dt-bindings: display: add Chipwealth CH1115 OLED
 Controller
Date: Wed, 23 Sep 2026 19:35:13 -0300
Message-ID: <b961c25f0b67968b6ef891f2dd3527508a374261.1790200427.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790200427.git.nico.antinori.7@gmail.com>
References: <cover.1790200427.git.nico.antinori.7@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
Notes:
- Patch series based on 7.3-rc1
- Carried "Reviewed-by: Krzysztof Kozlowski <...>" from v3 since this
  patch did not change.

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
index 73acf72c01f6..16a4a7a158ab 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -331,6 +331,8 @@ patternProperties:
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

