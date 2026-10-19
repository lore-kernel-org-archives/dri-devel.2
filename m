Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3429DCCF2E0
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2995D10E953;
	Mon, 19 Oct 2026 09:57:43 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D1910E95E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:57:36 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso18426425e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792403854; x=1793008654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CrA01rti7Ay/Y5eHy2dsofO3a17OwFZMN974VKrytcs=;
 b=DET+5no7axkbNmgHV3iblv5jST2ecZZs7/Bv2XwYTa9FonQl8daiXilaCJG1AC+HTK
 uxXHDlmna4wo2P0ziGWX/+0IFnjH4aWgFo8mZhGglIYsfIx2K+7Nuqf1wHqxSBX7oEnc
 1K1LQMn1pqWe8QMoDT+MWx6sV5fNd+KtyFUcYNP4yjL7Ox9TXl6yTAiLf3HDhyh6bGLH
 PiMNy4cmhR6EaOzT1vVQteMCkyCeLlZ7qJRd0/yENNIpEDo1+c8HI8HddgbYczjgT99o
 f0sv9qgEwHXKUmxR3zpoaaGOGPdBjYSWSqEF/zFqksGsoW63ubDD3OIDiArdZA+Nu9a8
 q3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403854; x=1793008654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CrA01rti7Ay/Y5eHy2dsofO3a17OwFZMN974VKrytcs=;
 b=d2ZP9wMUjVgmc0TmBsfN1klpklDCvIkHRXV0GiG3P8sHD0IS+RatRSycM/9Ggda/zd
 k35LM1GWcrR6ozEX1eCyXqEFeHE2+99DDY3LdN+X89RZ2yBgJpHR1Ocj7OWTZjMNw+/3
 B6g8dHnUa2JlbbkbrQyBZf+EI007hkArzDrAtEx4Jqky+qDYFbH4bm3qwfURZ5ktGpjT
 lzfxpE1mWoqP/QJqa1wFES4dCFkokmvNkQN9qI+Lzt5nvrGROQEYOgOkzRFNJDJKpgSd
 X9ztrMSWektfAkjZGvJf7ql40GToBYjN6UwtEfIQitzgjr1MYpYO61y71H93T5Alvo7X
 s3Ow==
X-Gm-Message-State: AFq9FYJPmOwiFwKLmd1036IoSchTui/t1zi96SJGqgbn7FoMxHbZVlb6
 97CsysTPia4MyMkEF+fVlVAK9vWnt+VKHPM4JDAVC+n1uz31AcUkIaYd
X-Gm-Gg: AYBFou3zzDTWD6YmK6LyzQwXVTrZZGcsSHxD5ALPpPzKra/MrV0ZEcV1jiY2EKf3uP8
 3h3P8YH0YMNugoTwCAMi3mSexPxH48YPjKcfuh+2UxGKcBS3MVTCzzknM2AuFMtfraGzCu1EjQZ
 ruaIkUIRhTPcRfUtJxVrqN0DHJwQAiYd9A7n7DbiDIKC1RFfvWN4RtK0WCN5CTecVHjpuiFRreH
 N0wTBOkQnqww3dux28TXqo/NwvVT/m0cmsdRSpSJsgxjWp8eB00nP8h6ilDNthiOJY22kGGu9MU
 ugr+VczZV30xSjw/VXwc99DqoPWivBX0s1ZVFyFhEPku+FrYokdouJe54X9gVltlXY0mOlvCN2O
 fsmSPR75jCIbHI01KyCDu2utM7YxqjTFARfZueZD3leRzv5Cc0TGKsXlnRlJXys8qlnsaRFsEeE
 ais9o3VISOjSb79cCImVBPzdKI5JtAZLhk7jD+aXOGftchHhe45dPs34vFAsExFkz52VH9I5AJp
 xVHum1RxwM0pn2/fjKyDyLvThoqcA==
X-Received: by 2002:a05:600c:a48:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a1d7612bf4mr152397805e9.17.1792403854260; 
 Mon, 19 Oct 2026 02:57:34 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd500e75sm21740089f8f.42.2026.10.19.02.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:57:33 -0700 (PDT)
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
Subject: [PATCH v3 5/7] dt-bindings: display: panel: Document Hitachi
 TX10D07VM0BAA and LG LH400WV3 panels
Date: Mon, 19 Oct 2026 12:57:03 +0300
Message-ID: <20261019095705.91062-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019095705.91062-1-clamor95@gmail.com>
References: <20261019095705.91062-1-clamor95@gmail.com>
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
 .../display/panel/hit,tx10d07vm0baa.yaml      | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml b/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
new file mode 100644
index 0000000000000..4642dc14c42eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
@@ -0,0 +1,58 @@
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
+  avci-supply:
+    description: Panel power supply
+
+  iovcc-supply:
+    description: I/O voltage supply
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

