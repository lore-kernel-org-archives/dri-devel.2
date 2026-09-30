Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A854BCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE5910F1F4;
	Wed, 30 Sep 2026 07:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KuecQipm";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8326510F1F2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:06:05 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ff9642c57so7536175e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751964; x=1791356764; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WNCP+MgExkv2yvoAQcyTiZxwG6dNYRxx1MxpmqPtKeA=;
 b=KuecQipmzq+UUryvpoal4tNs+fDvtiTshtVTgDvyX02rF0gsjrSH8+zIT3KcGkvtRC
 jVPcl56BDmkClXiCUOCsVz1hdLFOnAbdHACV0/DYxA7ttSS3Rwna+aNcelD0/dWdftgR
 C6jHsj1/mGVVBhtpu80Whw48l1Y5sHFazsQoAcjaaJ4Do089SNgCOJFYosR3973wVSY6
 3dl1fvAvE48dwROK4pFAoBbvaAKJi9j/AG+eyNdSUYy4ie3KsWuZA3MuLfx/TdpLgv20
 QVJetWNNRwND4snA438FZLsApubEVWGnXREMw/vwgQnlWkJLykUNzkqqMr2GgWdp8J2a
 g9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751964; x=1791356764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WNCP+MgExkv2yvoAQcyTiZxwG6dNYRxx1MxpmqPtKeA=;
 b=tey8mxO/t2WMNGymJJHp0NnLcWRUk4U5oivxcYUg5+EWZLge72w9+MCGpNBwtRvilm
 FBrb+v8O8YYLRfDuWhlCNOh9Z/S/L6gQ9U3QCrtW70KnGytua+v9dwWeRaw2HItyBsa+
 eiacyQeGDXMHgad9+wnsWUO/zues7Gn2MdBfOcS3pmiQSzZYgY6QiX0pB6zJfYfmWkTR
 +x0CTrt+ETduDRXnDWBNGrq5w0ipnDTCeSwHiLXWobl/h2oQMH8NigU/QhOD4ztMQpNb
 kHBwMb0Drapny4sWGYg/QVxebzwS2UXJONZu0mZXOR86dHbNcVO3OMlyknwVLlXohsEZ
 5utQ==
X-Gm-Message-State: AFuF++nZdNYBUBmff74pYBCedPEl+qGFqHCCCJBTC5/G1co6M+YUteEq
 BilSAzqHitcgcUL17XRK9lZ/uBfoUMafC7cAAA5CLfzf/7ZUygyIJYyg
X-Gm-Gg: AYBFou18qzONFcdQxuHOMzMAXoswU744gbmZLT4AM6vO6Wzc0X4VGRdwuuLw9/hxEO1
 S4ngCdSH3Ha9yEkdR5ZuQ4Gy3lEYIPkUJNUWJV5tye+gCelS5AU3txFgVwqLJCvJrWCa6kRlAMN
 Ow4dbrl8qPa3lQUN0NjFiSANvkWJGGhOey1lWM2mtQYmiVMeGYw9B8lz4qQvq/KMTTVgvM8Eo+m
 8HR2l4CfQHbLPa3HdL2QUuNLGem9GL6fuDv0aNfO9LKCzenBeIiY+BDkcuS/X/gh0p1rwVoTX/h
 zHsyTOzR8NDebgluJsu/nnuK8Y6JdGQw2fi5sSoyf1kbATa5o1qw0noFZOjVvKKFEMrgUZkoZjp
 ERxlKxz+i/YoHkCfPklwpYE6fry9vaGHlReacy4a8w0ViaH22ycgAjQLuZWISi17bJLGSSRw7x5
 JIho5vBx9BaKtw7NX0DfXgF+QhdKNYahm9QkXSRLu4Gq5DpAjoe9E8iV6oWdE4XOxIdMfsaxYes
 kqgCHZppNXrUhZB5qP5NOrVEZhp3w==
X-Received: by 2002:a05:600c:4f8e:b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-4a01b196740mr4474045e9.6.1790751963864; 
 Wed, 30 Sep 2026 00:06:03 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f5bcdsm1145150f8f.27.2026.09.30.00.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:06:03 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 5/6] dt-bindings: display: panel: Document Hitachi
 TX10D07VM0BAA and LG LH400WV3 panels
Date: Wed, 30 Sep 2026 10:05:34 +0300
Message-ID: <20260930070535.47130-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930070535.47130-1-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
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

Document Hitachi TX10D07VM0BAA and LG LH400WV3 MIPI DBI 4" WVGA panels
found in LG Optimus 2X P990.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/panel/hit,tx10d07vm0baa.yaml      | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml b/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
new file mode 100644
index 0000000000000..ab839d9e4e111
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/hit,tx10d07vm0baa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hitachi/LG 4" WVGA TFT LCD panel
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - hit,tx10d07vm0baa
+          - lg,lh400wv3-sd04
+
+  avci-supply: true
+  iovcc-supply: true
+
+  reset-gpios: true
+
+  backlight: true
+  port: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    panel {
+        compatible = "lg,lh400wv3-sd04";
+
+        reset-gpios = <&gpio 175 GPIO_ACTIVE_LOW>;
+
+        avci-supply = <&vcc_2v8_lcd>;
+        iovcc-supply = <&iovcc_1v8_lcd>;
+
+        backlight = <&backlight>;
+
+        port {
+            endpoint {
+                remote-endpoint = <&dbi_out>;
+            };
+        };
+    };
+...
-- 
2.53.0

