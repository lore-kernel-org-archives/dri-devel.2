Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3C60A2606
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qv5yx2ED
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C331210E391;
	Fri, 20 Nov 2026 07:34:14 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F75510E248
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:34:05 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso4718735e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795160043; x=1795764843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
 b=Qv5yx2EDpOK2Jf1mPfBwmS6laE4eQNX1tf85FZ0hs/3pJftmrEdbDaEdsXMqL4wm+D
 5GqdCvWGaizmGopWo+k8vq0bAFKogclGm6jc2WcrcJHl3vSRhEUoQNHrvcVSLDSeyDGu
 9TmcfNNot6BSa+2ja8uISTfx9tu47cMu+riH1m7Q+K/WG3ljcW3ZihXg1F09IEr3fTUs
 VHy+wsEUOCATodZaO7vjnT8RV5eaK85OT9wK/m1mhBuaWhkUE5VkzjRtJsZhGbCGObYa
 XVB+72asWxeLFH+Bu4Kbh/RkC1rOzOi5TymoIJ/tA5eQMI0O3fBZGQk8c4XF4XQTCktt
 ekrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160043; x=1795764843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
 b=WRXXERUoznEpEgTVYryhbAj1JEd9Be579kAOHjdapaahVB7JL/jU1EJAqwWFT07hkZ
 wMdnKN5ofQIwRDxibvpResWvuRVuuucj57+u1xi6XLQ3DNtwo2cNK8OwfkmMnuIVpgxe
 GsLH3+7EwTaYhukhsQVpJiR0XB6jF+1kK2ppr2FUGo0m0m4F2+yjoRwxsa+Rr7W7AsQj
 /ZFR81w2bq96xcPlAu9G25gOdQ6RKNH1AWIn3FMG5GiVKuFyRBlUHqD8ETjkRVP+WwFF
 juYV3tahzsm9+ZXvWS8lInVdpSVhBHy8ZxuImol9xl6SvjTofK/PCQsbTh9hEjcmA6Tj
 bGIg==
X-Forwarded-Encrypted: i=1;
 AL+hErGinzxsKDGpe+3ZcuJJs2VLzFu6KW0NuZ76n6hDbddx8dtYTS+MUGpFN9nsLc73OqMYl11ECkhxB/0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9tZtrk0uX4Rm413QR5v6mPktJ4ceryjnZM5W/YfjOlEQmIPMQl
 PoEnqu4OF269wdOX54eYQgDEeG7myDneEEY3XorT1/oK7Y39RYVgMo0L
X-Gm-Gg: AYBFou1U2f2KSPAj9CzRoFYXeEXLZtBm5OfjjF5ek9Ho68lf+4AIqAdGlpN2NvuyvQp
 QxH2sIOPA7AA4Lg6iuV2LAof0qGFS/KX2v0RSQaakhi/8TR8xUcsIjc5bGOXXJmYwjhNBjbywI9
 8BHnpbGo85L6cLJ1CMx1s7anEkdmCLopgrD6bJaR+7Z6GXYiQcJj5u5QBvQYG+C2y8FwsIIvohm
 NnJuKObrJnQLUzKVrAd3e6q1ekX/YAoEUgJT6lXq5OX6GenhgrWySIp/LNK20CX4sIzZqrZwUb5
 j/TWOq61qWk7CB7WnFrVuBTQiWPRsRAMEZCWbYIBLSxy96ZId5SXSgdkAt7wceDxt4lapoDLBBW
 Cer+hUefOVvK8BmX7/Xiq8B2OpUS14rBvZJvFnqvrczgAflxXa2RW93bz8I700I2BVpQ0uiZiTq
 q9FrevQ0/6gR17sRyPl217X84T91p5CGbVVJEQ0EOTFMr92Mg3J2+yx75zijZFAb3sDoM85Zqo0
 5uX5nljOjZTB4lNiG+T6WXuidAQU4AljUluOEZIelPKSoNrnMB8H3Qubh5O7sCJ5MQP08v8wQ9d
 3BRg0jJoFDOHSVfQzuWb28dQWzDoaK3dEL5cAQzY7NlFFOjSHdshhNVakQ0wJ5IbVmiOJDlzhaU
 =
X-Received: by 2002:a05:600c:5487:b0:4bb:5de1:e92c with SMTP id
 5b1f17b1804b1-4bb88813157mr44144925e9.26.1795160043279; 
 Thu, 19 Nov 2026 23:34:03 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:34:02 -0800 (PST)
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
Subject: [PATCH v4 03/10] dt-bindings: display: panel: add LG SW43103
Date: Fri, 20 Nov 2026 08:33:51 +0100
Message-Id: <20261120073358.10267-4-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120073358.10267-1-rofikcoga@gmail.com>
References: <20261120073358.10267-1-rofikcoga@gmail.com>
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
 .../bindings/display/panel/lg,sw43103.yaml    | 69 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
new file mode 100644
index 0000000000000..7f44ac6672bda
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,sw43103.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG / BOE SW43103 1080x2460 DSI cmd mode panel
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description: |
+  The SW43103 is a 1080x2460 command-mode AMOLED panel used by LG V60 (timelm).
+  It uses Display Stream Compression (DSC) over a 4-lane MIPI DSI interface.
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
index 80c1bfb66f8cc..594863936fb5c 100644
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
 LG V60 THINQ 5G (TIMELM) SUPPORT
 M:	Abdur Rofik <rofikcoga@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
-- 
2.39.5

