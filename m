Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A785606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=HYd8UDcP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A7010EC92;
	Mon, 26 Oct 2026 08:38:23 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1CA10E86F
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 08:58:21 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so15180125e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792918699; x=1793523499;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fXRuDl/kfmEcnVDe/qo2rO7Ex+8Z1Yq/lHQYrnrvp8k=;
 b=HYd8UDcP/SGDlwsSG/cuNVqPxYvGI0Qj2BZKzoepEcqBiMYv3wd0V5eovs0iZVeya3
 ud4KjDSVPBxcPFj/SvK8WFOVCfcasz+MeinZWjBd+h4vJ3GwC0i3fx9inaR2tnrLM79U
 pQUm8XMHJ85OEkPf9/tBto44Oik1q/XJDmtM0IeomLWI+OM3CZNRKrOV7BUP/WAQJgjb
 Oz3qTV3XIkdlYDAhbIpZG8ic3pESXPuIkayjZL+y1/yDSM98oTMijc7KM383qLkik7lx
 Udju0omtjSbSBzOfshHYYYvfOPfObGQsBCnX+E8qGU8goHo47QfdoaW9Dd8+yKsDFDUD
 0AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792918699; x=1793523499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fXRuDl/kfmEcnVDe/qo2rO7Ex+8Z1Yq/lHQYrnrvp8k=;
 b=IqYT96wunKb3OOKa/3nwnhlPyTgf+yXAVLFO8UJW842dEpUM905cB8gBXroozhftSz
 2IbogiR+XvMAh8vkcwpXT01ZxoPS0Djw7wU0+VWhcY+OPjN6lUKf3Iy/XWY0pw4bLWy9
 yQgQg8yVj/dUS9v2Fgh7G2yacScXXKTmDMI9LhWHk9TPOznhseUr7eHeQi4F6Kxt4uSz
 57giSUvJoqkbFP4iyIkggRsfv653gqnnSn1tb4uh6Te7EPVON06Ef7CErtC5OTXMYR6E
 q7pGOfhSalexFflCNLw7JC6laMukbaLKSV2ZSRA0jcg5kBFuIRtFm+tZd7yfohGIQUIq
 dEqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbRSqqpBMufttvi8fEJI80tmAHBV5lrpi5r4noP5UyEKHAdn7oA7MOeKMsrpN2uCNh0VYLHea1T0s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLZ4v4/lz6UpSmXgB6e8U6xwdZnJdJz93EhCZX6IgQPgR0SRMsV
 NZ/M/dpFVMN6zrOwL9ApghGNp1JZod9Ow0XGSKmDHvIyBOx9TkwwB/ZbM9d/gO6IYeU=
X-Gm-Gg: AYBFou0d+iTQKI7yPzHHwLvz7uRfVPmzFL+zgJROaRG9JP+ONQnaKSpIEC7LNSPorXy
 AYdbMH80C5mEqDMIt1oqQ/j8Bipr3EJYPQ+gh2fiKqFsv3kM09pHMqKxWFuB5GdNeHfTqPlQvVI
 M/k+cz7BqOCaXxygX40lsNjHYoD1qYRpYBCz7vlbxOepcYFjJ8/FIQTqCWVB53lW1NBg+HxOcmR
 XmMdJDgwaOEYOFuGJ+hS3FHEmDfMi3xRR0nm1WPbcCC4IjYtTH1z9sDz8IJ0LTQkJVlHTGBEHxc
 QQsvGceOMG172RoR+WkHjk1EqaeQLtcCoT8wL7SRzM39qpeqQSTMRzWaJ3aDwmviB39aSVrGJ+5
 swigCIFsYc2flMejHu8UaSv8TOxfjgUEGMCYnHuDi/5KUV5+MKvjfUyU5VzhoDPaOEAge451CeW
 67gwN34RMMSgpI7mD/BlsC8w04g12vEZoW5zXo9B2gKF3aen53xMphD//byqNGT69qzINntdu5w
 WxJ2SvPirUxbUOrSiS4plo2uEB8hEfHJK/abDq9w6kQrXmMSanywWK1DaEdetBajlWlm1Z+RnHZ
 jKz5s54O6btNWyUB8gAWfmA1rhKHlCHXl0QX/GAjoPhGkAupfLY4kwV3qsHDopzCSKgho43BiQ=
 =
X-Received: by 2002:a05:600d:c:b0:4a3:7344:13b5 with SMTP id
 5b1f17b1804b1-4a373be2a9emr37807865e9.16.1792918699556; 
 Sun, 25 Oct 2026 01:58:19 -0700 (PDT)
Received: from localhost.localdomain
 (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr.
 [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3cfasm9094542f8f.17.2026.10.25.01.58.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 01:58:19 -0700 (PDT)
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
Subject: [PATCH 2/5] dt-bindings: display: Add the Ingenic X1600 LCD controller
Date: Sun, 25 Oct 2026 09:58:13 +0100
Message-ID: <20261025085816.60405-3-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025085816.60405-1-olivier@mgcrea.io>
References: <20261025085816.60405-1-olivier@mgcrea.io>
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

