Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7DA606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S5OPk5AI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3415C10FCC8;
	Wed, 18 Nov 2026 13:47:11 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80AF10F6A3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:39:54 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so32234935e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919193; x=1795523993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T5qIDqJW1HylN9V1krTTvvmwCzdpLearj6f6TGS/cFE=;
 b=S5OPk5AI94O3RPMCBjlpMDGl8nuik5ypeLCJnrBjq3rfvTjHNIM1C80i3pXsF4/9ca
 IHbaOfqnVc78le4Gv5Xk4vY6ih8DMuJqqa6dCdiSoeY71UCYqHvzUh/3bRpTK8Qow7Vn
 sX9K0aEUQ7sg04SK4Qwk6s0Fv2/6QjLYrTSWZsrYav8qVbHwDI/qgZRFuD0x3Vf+N5B9
 Gq6Gjh/4SU7VQPIklyzhkzg3/DddsDr3b24Omkf/aspj5n/f5YV70DXtQh5qFGZcrfQn
 QqRTK3tAfuhM3C54Q1RhZwHOSryS2UFPdQtF0HEQe/fdOQcTiTuBYq9aWsH9ehjxPjon
 W+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919193; x=1795523993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T5qIDqJW1HylN9V1krTTvvmwCzdpLearj6f6TGS/cFE=;
 b=o+ukPY6/sNRQfI8SquIH6b/wBsNkXC+D2U2Rf6GPzYrLgBO0VNGNDZ7wTJFtygJaiC
 LPze/RdF0eLYXZIZy1VkZxyUJ+TGLZ2DhEB7g/9BiOs7HEi/iaCl8wPJJZJYLJ1+gZ1T
 C96wF8IuC9yavWcicQD9Ct/JMIY9wC6jGl+wkxys7rNl4JFDeQRZ+vKSA8SFLx6iJZp8
 Iu/EsHIwVAjSQHJYboc4j/tUXnRPGa9grNl600N21tWDTgRikixDgTlUu1zrh5eKcy0O
 yHGvyX5bJZiEQ1zYf8YCtJDLeDgbE1vg80XAjz9R9jOT4iO7K8ZNZ5G/ecTusxERNtbj
 DjCA==
X-Forwarded-Encrypted: i=1;
 AL+hErGthTnoCAcVWgBeig70Oh0myOGnojnsnN1vjvE0Fipczy9yd7koDP7nk/0taLT8h+3tfVW7aOKjxfM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+cbPqzVUa6YD2QNLc9OlztyLUtAllrw7v29frGJ5RhV4CgokYs
 mgT0tcXiMRQ1ZgKj9Am6KtpBRfm31NCfooGsr+gU5yoGBy4L1aLtfU5K
X-Gm-Gg: AYBFou2pc4MAkPsfOwWtUkErW9mc8rcl0QPXPcVJLWdzQt+YGS1pIBUadw2FyCmBT7g
 Idg18jgnZIojeEu2TJDu7VuFviUVC906vo7xclGIKymOidyQZvWivl84vCQx8Vb7CiX/UBvPdZD
 4JWMiBff8HI23i1/gHMMW4a1qfKaqx+rgwozLUeCo9wg9O3W0D2ipsbuzGtb6/cayJc3Qe9iKib
 TzsaCTOJBd9b+eqs0PmnX7FG6wig+KSUnQYWd/zird3BXsFqL3d+bME54J3oRIoDeo0Ic0A7uQG
 jHU0TyeZp7/Fu27U2jX2GSpxTpy517bN08LuBC6V1ehMONAsqojTCjnr562DGBN0CZ3WNsl5h38
 ELupiAfrcblpAANuMRsQfS0tNO8wwDdhbK1dlh9jgX5g5+qA1QZ3QWZ6Qve3ZvYU39KSyBVPZGK
 ZDsEPpEQV34j+B1LkAhc3jcWFOZH5qNFbiPhOWPPnUEZAzxs1bav+xmODjpIyaRy3IVBfdhjUnB
 IiqEYjBBkjN6CC4MMVOtcvDvdSRJ+5yl5bRPiM/i81TgHsfWptTsvmOZ7xv80t/K62arS2sGST7
 LQZxDqCOPhrroSODqhcVh1chFt4yAxUz/ZJScv1kEkqAFBNU6m1QCWlfrWORIzVjdxkTqg==
X-Received: by 2002:a05:600c:3152:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4bb55aac0bfmr303633355e9.34.1794919192859; 
 Tue, 17 Nov 2026 04:39:52 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:52 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 04/11] dt-bindings: display: panel: add LG SW43103
Date: Tue, 17 Nov 2026 13:39:39 +0100
Message-Id: <20261117123946.668557-5-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the SW43103 FHD+ AMOLED panel used by the LG V60. The panel
uses DSI command mode with DSC and DCS backlight control.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../bindings/display/panel/lg,sw43103.yaml    | 70 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
new file mode 100644
index 0000000000000..edd007e2c0d76
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,sw43103.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG / BOE SW43103 1080x2460 DSI cmd mode panel
+
+maintainers:
+  - rofikkerneldev <rofikcoga@gmail.com>
+
+description:
+  This panel is used on the LG V60 ThinQ 5G (timelm). It is a 60 Hz FHD+ AMOLED
+  panel driven by a Silicon Works SW43103 DDIC, operating in DSI Command Mode
+  with DSC (Display Stream Compression).
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - lg,sw43103
+      - boe,sw43103
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
index 315a4a000b405..bca5065166c25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15231,6 +15231,11 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/mkrufky/tuners.git
 F:	drivers/media/dvb-frontends/lgdt3305.*
 
+LG SW43103 PANEL DRIVER
+M:	rofikkerneldev <rofikcoga@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
+
 LG V60 THINQ 5G (TIMELM) SUPPORT
 M:	rofikkerneldev <rofikcoga@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
-- 
2.39.5

