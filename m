Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F5606A9AE
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=NnwxaBDN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5B510EC96;
	Tue, 10 Nov 2026 08:33:35 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E1B10F48F
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:48:01 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so8808215e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mgcrea.io; s=google; t=1794246480; x=1794851280; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9tc6qWhK3kP9eo7gTGV93XNa5b2XRSF41IUa/oigVXY=;
 b=NnwxaBDNHoyR7E0aE2vMzx20IvTo7c2wU/y1OzVd5LmBucAAzofWoQUcjDPHqt9y68
 FMGrroAqDtrrJ8SwUkQh18CDgf4Eg6WcgcInBCgeERusrvSO9b2S0iKRfdiLVmAn/zqe
 cK5SrQj7HAvcoNypX3UNWbxFggvAi4L2z9t9x4DPxjwOAJ78Z1yzcPt7HlQAv4SB/vqB
 YTvkW79lsBf8aY5bUuwHlZvc4plpIjmS/XXnKZ/Y99UATHFEGakg6E9/+DCZHTmZ/L26
 P7QipUZW7EucyGB0dMptrvvi9iiChv/AvMVAzk3bdllbPNf1uTh+XbaJ8wo6zwu18nIn
 XYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794246480; x=1794851280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9tc6qWhK3kP9eo7gTGV93XNa5b2XRSF41IUa/oigVXY=;
 b=F5JBEs8MGuxDhO9QYjWo2ZWaHHTmw9u1nCvDDN5OysdVyqdUZopg0KN5FEHiqtb6I0
 DzhPsbFEfQVOQsWR1n1FTznoN+SRfyh2OxQdIhLBvE9zOBMjdZNnj8A5ecdYutXsbXBT
 W16EvliTILxYUHV6aRV3d9zvmQfFE3z58Xd3EjH4QiCSIVY2nm+9bqAiFl4rCpCB2mtT
 /Vh1qfvq4wpGz60pxEkdunwxKytVIVL2XR9bdDSfNhSqn9f3IIUxg3fLi6ZSFNT/1I0f
 o5iuJCJKV199kJYSB3at/QW+2kb03dg6thQXPlY+Z2l1X7cMCkaFPyugFGhR4u0lMiU5
 T6aA==
X-Forwarded-Encrypted: i=1;
 AL+hErEvwW45ta4Kl1sUapAqUd6mvxsv6fyVE/dBYYZFkQZWiQu6PF2d+xz5vnPfRT7hEP5+AlMexk8dvHU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Nft5jdS3jRNM3todqbOfXN4JZ7MnN8oVBAaGkQHVdtkOElUtI
 9fNQ/CcLlkbh3Al3w80bC+8c/nP53Bgb16Thk+9ggrFpFqKBx74q8unWw0mPUWzdXbM=
X-Gm-Gg: AYBFou2hM63ip4hwa2UdCJJsy5F3otLLfKrbKi9Wp2L7yrifvS34a4Gqs4m8R0BDlXJ
 mDJLDyaHbDBqTsHJHCLNjkRjFjWwAGsn5baGFYn09gujVX8c/PkuJOxhRx59Nch52YFs1dcbuTT
 uk+luoPByuCchk1uKcMBs/JquISBtK2RuIP5FP1cYPxka3Bd4BcCHNlM+eAcUQMYT1flNEo/DM7
 IDbb5t70O9B8btCJ0DsFABNA9hXC8Bzjag2AzpnDZt5Wgsni9sHd8UqMYdsG38yWMj56htIHFuC
 di9goGwTBVQxWIcQ+XEDSOSS0tqRIo4QZksWI68x7dOu/V/0AGAjH7Ut215dc+TOlNuTaxrWU1O
 uutQmt+Qe2lJurH2Ya/fX8TnppOEldNKKEVgD3oGCDnHA+3P1AfF+a/tzAizCoDUfpo0TEWCn3H
 73Xi7Rrd8qDzqA4XbjcRinQH0rVpHC4OCQcCrBh/qaIEJ1nxnSwPGkKhCL0/xtbgol4OCgL3CG7
 39KTXR+9DSDEyB/lNHI8g5qQl0WYZy3zixy+KdAtgqPIw5n8jaSbwvlpU+0kr18XgjsCooxn/y7
 MShbRtnwtTpiPxnv0MkVlI6xsqYMHTIssZ4AqucicjN+ATBSe1j6s2JPPNQInRk=
X-Received: by 2002:a05:600c:314f:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4b963c73aa2mr94357825e9.25.1794246479866; 
 Mon, 09 Nov 2026 09:47:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:e834:fd4d:2ecb:b787])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm167322f8f.53.2026.11.09.09.47.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 09:47:59 -0800 (PST)
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
 Olivier Louvignes <olivier@mgcrea.io>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 4/5] dt-bindings: display: panel: Add the HiBy LG35583
Date: Mon,  9 Nov 2026 18:46:39 +0100
Message-ID: <20261109174640.96951-5-olivier@mgcrea.io>
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

The 480x800 parallel RGB panel of the HiBy R1, set up over a 3-wire SPI
bus with 16-bit words.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/display/panel/hiby,lg35583.yaml  | 67 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml b/Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
new file mode 100644
index 000000000000..efdaf6241e60
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/hiby,lg35583.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiBy LG35583 480x800 panel
+
+maintainers:
+  - Olivier Louvignes <olivier@mgcrea.io>
+
+description:
+  The 480x800 parallel RGB panel of the HiBy R1, which HiBy calls the
+  LG35583. It is set up over a 3-wire SPI bus with 16-bit words.
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: hiby,lg35583
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: Panel power supply
+
+  vccio-supply:
+    description: I/O power supply
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+  - vccio-supply
+  - reset-gpios
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "hiby,lg35583";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+
+            vcc-supply = <&vcc_lcd>;
+            vccio-supply = <&vccio_lcd>;
+            reset-gpios = <&gpa 31 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dpu_out>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c3e8d1a55d28..ddc559cac674 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8346,6 +8346,11 @@ S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/tiny/gm12u320.c
 
+DRM DRIVER FOR HIBY LG35583 PANEL
+M:	Olivier Louvignes <olivier@mgcrea.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
+
 DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
 M:	Ondrej Jirman <megi@xff.cz>
 M:	Javier Martinez Canillas <javierm@redhat.com>
-- 
2.39.5

