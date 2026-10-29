Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B29606A33A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UbmeB+69
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53D41123DD;
	Thu, 29 Oct 2026 15:29:50 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688EE1123D5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:29:36 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c315869241fso360028266b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793287775; x=1793892575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6CPvjoYy7BE0WZR1WCFgrzG3A2OCzgKkq+RlO5AEapY=;
 b=UbmeB+696iQykrXNVHC5e5pF1Fep1QqLSpb0r6HxEKgFkl+iGsnOdRDqhbT7VUhd9n
 DYOpKcAZ4PiJH02TAzc03fQ8K0oAk0RsVNrNLMIozxVdhsHqiCskjNl+E9cQAZVnKoUZ
 QTKWv6iL4TwfA1N37G+sGL4zRYxqDRcglMq31/ZLq3txiL23+Wsx+vpe6e+AXSxX32eY
 /D6NFmOyYaBvgJC5LgRG0rr3ZbHOBfgLKy7xa2TUedHNs/wN5BhwPx6JPGFRVFyq3RGS
 ahvGFf7mnxWtAcmGMmWPiO5IMPlXanzRgvIcfU2pSxXPsljjcZzqL02smGoOf/jyx0Ca
 r+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287775; x=1793892575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6CPvjoYy7BE0WZR1WCFgrzG3A2OCzgKkq+RlO5AEapY=;
 b=B19ZkWy1I5+OpXHqF7ppz4vEELUGIzX+67a5Muxeo55ACF+eT1JJOVVTWh5aESoEre
 /Gt/0lKiFI8IiKLBqVq8Mt1T31R1Bt0NWvvmXAqaYcm22CzxWi8Yo5yvIRKTw+tyZ59O
 wV5LBYc0XsU0K35+z2zjIuoh0UUvnT48VyikdHOZMcPfimYqbhjmoApCtdgBuYNr8RgG
 aZG9bohzs44KNdBkx9b44jhRSKkhOLB9ZLJDLB3zWpioVwG057I3Oj6yGyrrygPDjT87
 QvCS+AODF2e2pf5yFGy6TNU8soiDoDdTigrUaqUFo6KiPtHKNGU9M/ou53r276ut8crk
 Bicg==
X-Gm-Message-State: AFq9FYJ13Leu9lkSq54A7YOY8rUZyDLwVXMVnzQCJyQY/eZ6p/YKVOkd
 GNznycLo/snxYWu+5U/BR1P2pSmlJ7eP7N2OAzG7zo7IJp761UwFmpfD
X-Gm-Gg: AYBFou3sWuFSzWziQjNGbXoo3zGbTDMRbqWdCzuil6n3hjMDhQ0iFE7wm8YIg05qiBe
 QXw8IN7zFFZSM6O8mnf5tzwtgVlUMoWM3U474v7WCbDWhP8PyemaZhGFHGyZ4LjgKvhwNHFTzlw
 mpdEQmq1QY9bNmG2EBMqC96oZPXu8qDAkrkj6ut+hVCoP7pBUw0F8LEaUBZRwFzVYhzKW+VmMsX
 Z094KGE9Kn9QMt0FwGIxEN9I+QgqSJYzBvQSajkrJg7GLQPe8YriBpHEaTdLMWvMLa0QI3wNttM
 KzLyET9E5Inx3W+sCRuYDkmRpDgRJg8SPJ+Yyqxl882wpgddGYJZWPo1uKUDklYdHdZiaGGjM6P
 dSnbYGc83SE79GwC5WrjnD9tB/swhnxTR4kvNMGsJX3q5po4ZYfToXh/B+TlbphDBRtx1vbA86S
 Uhohw8bafzgYfSiMiwj+IrJENx7o270ZyeBC4mGggkmWqdInKvwEnGiQbYpRHEMgDPreSYdk4m1
 Zu7eSfrfat7hMdYb0NjpKaraQRQJWB8BU3yu+SzsbULu4WfOxvM29FahspVug/rt93pXpC6yVcC
 fluNNN15gZm8ngM4cgkV/7OMLIiOyrBr3hK46n+eeq8SITkzdQ==
X-Received: by 2002:a17:907:6e8f:b0:c46:7645:86c with SMTP id
 a640c23a62f3a-c49bdff352emr527006466b.47.1793287774682; 
 Thu, 29 Oct 2026 08:29:34 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4ca27984f8sm1252166b.80.2026.10.29.08.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:29:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 02/11] dt-bindings: display: panel: Document Hitachi
 TX10D07VM0BAA and LG LH400WV3 panels
Date: Thu, 29 Oct 2026 17:29:00 +0200
Message-ID: <20261029152909.234584-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029152909.234584-1-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document Hitachi TX10D07VM0BAA and LG LH400WV3 MIPI DBI 4" WVGA panels
found in LG Optimus 2X P990.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

