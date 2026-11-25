Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33265606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OInvoTQr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C9410EC9A;
	Wed, 25 Nov 2026 03:28:22 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4152810EBAE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:28:10 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso4612361f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795577288; x=1796182088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SOkOs4X+aYTNF/FE843B5YIM2qcfhLHQtKB0HpI+vVI=;
 b=OInvoTQrR1dD62+1dn6bmQoCMX+OkyLMCt7kEe6924iBjAoBUkIG7+U8ltCXZ/PavB
 sZJvkm4DWv8innxYGCFFMLhGcRHZu0BuMIbQGYNxChJYAhZo/rwzPgcFBeorevSy0++l
 ZKz+AqCuBr5qo/C9sQdtoOqkJWA9sXj65A/OrZ/HzV6xhJSYilTilc/jXRN+0cmLPQRE
 vrGygWb0cLBOFF5QPX2TUO/gewqBBFfZH21FUnzXRrkS3KoAGL7T9Pl5e+eicTNYfvTY
 cHG8Sq8FKTVyeBHXTATCG6rWudOj0pFE56YSiOm83yOxV5d/7CIwyIiZMK7XUaPUPL6b
 2zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795577288; x=1796182088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SOkOs4X+aYTNF/FE843B5YIM2qcfhLHQtKB0HpI+vVI=;
 b=v9AIhYr13PcQ/mJ2Th0zQfZ1lECTxVHAxU39BGy3NEdcY4GvFbEbsqkJBFY2ZONRi6
 CFBRPVR/0FK+R672g/pREOHlIHMca8ggs1a8JX3iC5RH35Z39CrAlCULXNCC48OGa13t
 QEY5nOzWyIlmHTOX0L/0pmrxZGjZWXdMoQJ3PYZoxoZAcJqaTKMKH9XqlsP60l0WgpaB
 nriTbBpBKzAqAD7StqPp/R3hmq74EyAdZ7RR7CGiqu3R+TOjKU/bVUyvRdsq0pryEFUV
 b4EnHhW1cHdsV0U6mh4N/4wlusYo31ypWsbSuL3wPPNn4dykxyb/A9iaVPc3R2nqK9qO
 sH5g==
X-Forwarded-Encrypted: i=1;
 AL+hErFXfGy/O/eYqfbtyRiKf/0pLYxXbE5VoSMDuWYPyRM6Af4CIgekQYowo/bSTdXwzfFfhNlZd+kZyGo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9y5xo3BNbPVSM4YfpA+giVGm3dBl/Se1nssejQNSpxa+ZpVeku
 pp9fM+oV43+LpMPw/Qxm1PYbvJCPn5fwMpe7I8UlV9Ptt0EENnBlFd/WHXP4EHq2m5U=
X-Gm-Gg: AZFdTZf9xOS6JEFxpXr+rPuwkzSGn/n98Vl+HXbPrnrLYN8wAkZ1yMKCtvNiYyPHaef
 /70SHarkldyN27FWkKttZEDmAg8IpBxtTr46vUELW1m1T3Z0RlR/fzGloksdSVZtu6rbjfR9ZZb
 vSZeETDzuECJVdWLSrOFDBiU2hSMaBKT3j1erLarw2SFSUKakbYrjcQM/DdO7bv4OlSpNYybfVc
 e6VY3hUU/8S+eF9/E1N4ot8VaCxegd6hwks0y1+73yJGMHtbkPoWToWsRITB7SDnJWGcG/uc4aq
 kEPm7pMMEnTYy7aVpw5V89dnvgjByo3mt15WwZ+jPn+L1n5MAd0ZF+vC7FyhYuSZiWx7QbHiej7
 qDBD4C3mwFMGJmXrTK2KM7Cbog1pmF9PbnDdRVbAptQ0ei1qw1+sI59fcKy00PDBcZNO+nXjLj+
 rllGglWUhNrReAE/n80JH79G7DdmWotRuxh6BYmaSol1GtJkoYuB+yucFiVmXT5n95DNFmCoAJY
 yMc4WXK/yHMAAATaz2cMqrJ+1XN8baMZx0MIiHIMGaycbxX3/7DQCk9Jn27Nj7Jo05WHT6RufF1
 En/OKyIxCMt7TakOKNDR/E9Ubx54tST6k3l7qrYXJFCO6+nEG5p7xUjKCrtNegeg4EIBP02PKao
 2cCO3Y/5Lq7WEV3DbKLLpCLqLMioVN/c=
X-Received: by 2002:a05:6000:60e:b0:49c:fde4:1af5 with SMTP id
 ffacd0b85a97d-4abb9de7e8bmr30366806f8f.54.1795577288400; 
 Tue, 24 Nov 2026 19:28:08 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe48sm28918822f8f.23.2026.11.24.19.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 19:28:08 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v6 2/6] dt-bindings: display: panel: add LG SW43103
Date: Wed, 25 Nov 2026 04:27:58 +0100
Message-Id: <20261125032802.8460-3-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261125032802.8460-1-rofikcoga@gmail.com>
References: <20261125032802.8460-1-rofikcoga@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the SW43103 FHD+ AMOLED panel used by the LG V60. The panel
uses DSI command mode with DSC and DCS backlight control.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../bindings/display/panel/lg,sw43103.yaml    | 67 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
new file mode 100644
index 0000000000000..971547c48bd6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,sw43103.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG SW43103 1080x2460 DSI cmd mode panel
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description:
+  The SW43103 is a 1080x2460 command-mode AMOLED panel used by LG V60 (timelm).
+  It uses Display Stream Compression (DSC) over a 4-lane MIPI DSI interface.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: lg,sw43103
+
+  reg:
+    maxItems: 1
+
+  port: true
+  vddi-supply: true
+  vpnl-supply: true
+  reset-gpios: true
+  enable-gpios: true
+
+required:
+  - compatible
+  - reg
+  - vddi-supply
+  - vpnl-supply
+  - reset-gpios
+  - port
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
+            compatible = "lg,sw43103";
+            reg = <0>;
+
+            vddi-supply = <&vreg_l14a_1p8>;
+            vpnl-supply = <&vreg_l11c_3p0>;
+
+            reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+            enable-gpios = <&pm8150l_gpios 4 GPIO_ACTIVE_HIGH>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index ccbcdc0799b9f..3386c7dfb9493 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15211,6 +15211,11 @@ F:	Documentation/ABI/testing/sysfs-platform-lg-laptop
 F:	Documentation/admin-guide/laptops/lg-laptop.rst
 F:	drivers/platform/x86/lg-laptop.c
 
+LG SW43103 PANEL DRIVER
+M:	Abdur Rofik <rofikcoga@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
+
 LG2160 MEDIA DRIVER
 M:	Michael Krufky <mkrufky@linuxtv.org>
 L:	linux-media@vger.kernel.org
-- 
2.39.5

