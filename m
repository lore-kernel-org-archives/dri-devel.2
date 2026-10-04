Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EEACA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC26E10EA8C;
	Sun,  4 Oct 2026 16:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gFxnHa6p";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28CB710EA81
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:31:38 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso11803525e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131496; x=1791736296; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CrA01rti7Ay/Y5eHy2dsofO3a17OwFZMN974VKrytcs=;
 b=gFxnHa6p1fOTseA8bTxeDn1amRvAI1uWCQfMesYGkRhyxxydRH6/sLDjGK8IhV2hjA
 ZhQSdXeJzcMjS9sWKXcPnqV/8QI1/6c1C0rXN9SHCiTcOP92aHH1i8SBqvm823P3ylb5
 CLAz65MIOE5skTGZK0kfh+ubWGlHhI9GNaiaYa1XrFdUIPN+REzaNDyhrC5URAGL4ufc
 QAjuDjKRaxnoxCh3PTSeRtrqim7sQexCd/xvDL0zoql2lkQgU7ea0T0DfYHMNZc6bjW3
 CHhUE8CESRodBMOcutFygF/22DGIgEmHtUO1FOy5mTQWIYru0vPBUQ6RQE5eOmgKxlZM
 uWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131496; x=1791736296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CrA01rti7Ay/Y5eHy2dsofO3a17OwFZMN974VKrytcs=;
 b=jmWapTi9rlmPjMxRMYht6ZMCv+Gv+1cAfvlogn12N5cL/nVxZCOw+0lxFXulmnuIap
 WsPojkBQ3SQmn50vYP27d/hEt33vMP2g8N+8CTOktvu+X0zmibdXWehT7e+Qj4raZ4Ic
 pWC9/cc286NQUiyAH3SKWJ2COcv8sayuWja4ThoeLdflybjoXEK8bB9rYq4cxzNTaZ8Q
 5pyUppJk+qlhP+PoaMF3IE5hLg0cdN+7vQhsE9uWo6vF/TuwutSspymkQQUnfwnmtV/l
 Qst9eqYbgL6L4iPylS8TOzX8c4hRu+4HnT+0HzKNsalDuunx0Gu2DpC2Lw9gS2JuRciN
 dn0Q==
X-Gm-Message-State: AFuF++n9GRXH9Efq9KN72CJPkOuH+uL08hRVd0HLK6wtOJiy4h/JjMct
 fraZPP5+1jxCdXFEudlRvpjhLoRQIh565FW9hxZLG4ykWCcJi3Mg3ePk
X-Gm-Gg: AYBFou2a2XBB8HRJYvRXIo/IobXhzJHSPSV/hfGK5TF62UdEQIL9h5PdZMW6HJz1Io7
 wT050b81aVKun71U9Z/Zu69k/RzuaA4wJgqwYcgM93yLIYkfbyTPKdTKxzOB4rVYFJpJbIpjFbC
 mJ/W+HaK8+nPwA+3ROQTC+MSJbFhEzvCNZld6oCuwItfEQZkl8tnw6kgoUreCArlFPAmP+8tsxE
 WLLVlgi8VFwYANp9Ge3r7JEx76s/LabllxOnmA8EA81g5zzIt2WRo2TVjS3RxcKCsCsTqpN9QZY
 L1yF4F8liq24YLYwGe4mqFwK4y7EcafwLZxHWOKpaFwHUzm02/uhWmCBGTx9Rgl1cHpSLvlaIFi
 GXWeMeVrGWQmsFs1a3R/9oapliFwnXUzIrT3OtSmJkN1JqdPhno81DIxpIe+iJjSJWANVbdQ0kr
 LFZfcmTIE6talVZX0mvJuDA47tkdbXJE4Y6F0qsgdegGN2POXrjxBig8ziXI/tQZaS9rIfe5a/a
 1WBUMX7T9HMK8dBRREYgYlO91yKaw==
X-Received: by 2002:a05:600c:1c04:b0:4a1:6be0:2926 with SMTP id
 5b1f17b1804b1-4a16be02b8fmr80963555e9.18.1791131496375; 
 Sun, 04 Oct 2026 09:31:36 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0316b2524sm315365035e9.1.2026.10.04.09.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:31:35 -0700 (PDT)
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
Subject: [PATCH v2 5/7] dt-bindings: display: panel: Document Hitachi
 TX10D07VM0BAA and LG LH400WV3 panels
Date: Sun,  4 Oct 2026 19:31:12 +0300
Message-ID: <20261004163114.181800-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004163114.181800-1-clamor95@gmail.com>
References: <20261004163114.181800-1-clamor95@gmail.com>
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

