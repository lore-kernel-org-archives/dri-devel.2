Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA10606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Kmudwuxm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6407210E63F;
	Sat,  7 Nov 2026 14:27:51 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E82710E9E6
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 11:21:22 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so3319915e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 03:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793964080; x=1794568880;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uzrxba9r6cfMWSMaU1sgfqwYz4SAWiJlh1jtjdSz0cQ=;
 b=KmudwuxmspMzkkwteTRXlSa2E3YmcxuSGPfoK5BCRiVD4t4e6R1M+4U9zqJi5czEan
 /nL1AaS+ZsgKzx8YnkWK579PIrEweFp3KDk/9LTTMDQ/OLH+OumRfKHMX5kx9ORZ3m/Q
 nNOaP3k8xwkGZgCfFJh0fCiR96b0fKQz3PZjl1+56lb1TPH4AmJWZhIxXgbwkKhnq33e
 HrC1PA3cZejwLI4BNozsrc0R2GDuX5Ai8s/ocJlbyr05Ybb91ICP5Fls3SYCbTDrIKLl
 1IyGJSk3GhKqW86QmY/Nyl0cGu848CGbKQ+Yof8DLWs5Mpp7HvoRg4KjSgUGI2AeOlre
 Talg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964080; x=1794568880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uzrxba9r6cfMWSMaU1sgfqwYz4SAWiJlh1jtjdSz0cQ=;
 b=hsqGsIl4y4H8KAXbrv3Rs4Bo9oQzPkwMpUy+032OB3n83IP1VRFDnj+dPcLloDEMtD
 tpjUgpv8xt4MFD24S2d8j+g6sxXq+mG+nyQRyBTKTi9qPNhsj58XTsTHQTqTF0eBJoDn
 /KJknpLrIMp3Cxb67Mo9+hufUiK5iE3W9zkCo1rebizgGSOb483+zok8l9Nb4NPLXAuX
 c8NbfjdkSBEDiIlHKbYy4exlSKITqrrqaF175MxvBNMZ3r6sfO9KA4UyCaScK3YT90oZ
 3KCv4Yo/zB3G+G9firYjz6YTK07u7esmOruxQbl1Sf7XhgKZXeQnkqIMdasFx9YujaVE
 utcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOcxUEVOdMtXHNsbl0pMX44OJeCLdbN3EJ+Wookvdd09U4vt5wIcdMZkP1TBPBKZeAuuqIPqQEtP0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8c/d1zl9XEk3XdUrUwhxeEU6A8wCZP5xEnIM/jR6hgWIRWGfiv
 m10mvnVWuaOB86S7vTwBlApZ8sMC5/gjrkkaFYE7mol15XVWUaa/+1uHsq5bJS3T84Q=
X-Gm-Gg: AYBFou0r/rsSv7jVs5hExLFvuyP9tgcLBV8dHvqpWOJqVe0dzWLNGxb3dcuR1Eofdf5
 74rFIMC/3WtKDfYkuLCMvv9UXRw032+kUIIP6yemyHtMOnxpugH6H4/IXuKFPTAfkC+YwZ6rCNn
 XMAlwmR2kLUqADEtSvt/yMYC1pBNwkJCGiFs/WaiTlid/U65pb/7Wi+rdAUOWnQCt6KyTaF4GeQ
 TyI1l3BqhegWs2pBwVq0Tlm5Fzin6jfPlHEhaMeUy2x9jXN0bYwreRoMKeONFVvPtE9sRxw8xLl
 USosSKAXePeMEBEqwaJpx4yEUDnhuyDrF571eCSqPVoqVyIAi4FXzbX7GTlqPLDgmqSN8tdjmrg
 rwwlFHf0Qxtwq3AnXlRMp9HcZmAiz8wOWFzHKolmBdmqW3anImVe3OIp++4LE7hF5Twot5DXQ2R
 M4IKLy6qwcFkJMPlVIaD5XB+p1L4E4pU2HQBWU6zAHE2KosfrwQfjL+Yayw9GfErEBcdjXHxh4j
 fwqoV0JK5KKSLy/ozeqdF60E1BW5zVErHZiPzEvYErPv4CWE+JjfjBjAjS/NcsOaK70Q9jilgze
 npmuUevR4nqif1YlByAKZqR3A6zvxIOhNySPXlZT1zhofl6r/e/TqbjxbvSPI7Ka
X-Received: by 2002:a05:600c:4455:b0:4a1:f720:74cd with SMTP id
 5b1f17b1804b1-4b6de6916b3mr36874875e9.24.1793964080642; 
 Fri, 06 Nov 2026 03:21:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:5c25:f8d1:d9d7:54c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e2028d9bsm102404695e9.9.2026.11.06.03.21.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Nov 2026 03:21:20 -0800 (PST)
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
 Olivier Louvignes <olivier@mgcrea.io>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 4/5] dt-bindings: display: panel: Add the HiBy LG35583
Date: Fri,  6 Nov 2026 12:19:59 +0100
Message-ID: <20261106112000.1612-5-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106112000.1612-1-olivier@mgcrea.io>
References: <20261106112000.1612-1-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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

The 480x800 parallel RGB panel of the HiBy R1, set up over a 3-wire SPI
bus with 16-bit words.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v3:
- reset-gpios, backlight and port dropped: panel-common has them
  (Krzysztof).
- The example's endpoint points at dpu_out.

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
index 5d992133e0d5..474d8a597e1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8343,6 +8343,11 @@ S:	Maintained
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

