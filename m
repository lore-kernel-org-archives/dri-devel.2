Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6FE606A33C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFp6H0UD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A091F10E2F4;
	Fri, 20 Nov 2026 15:55:05 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6E510E940
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:54:58 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so10170575e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795190097; x=1795794897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t5vfznkr0ETpK/dRsbewXSnBOXbKtjjAozkIrt96x4M=;
 b=CFp6H0UDlT41arbmY9vZCmiHkjJimzjiyB7yNlr3XU7WroEQB6zCLGgcGJTBETj9+p
 td2e+PTnxJhpje49uwkUKKl2Aws+YlQU1CwmfB/pZXXZRkGWA5Ph4XdbfQOrCHVj4JQ7
 8E4LeEGaYGKudpr0YySswEB9hCY5Q0NcoX/vjkfioyfeGQok1jOVWjm1DGiBFE+H51Gj
 keol8L31waXME5su5mz2lLAj8zuOctaydOUpS2rYTu/zt6IH9m3z3+oBGoKcuG0RAcl4
 S2ciQG1Yf4073ajw+MGsxjvIq1wUq/TVoMv0/ngW/R+0dVxJwmJZCSg+1s7ElhyRRjCd
 t3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190097; x=1795794897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t5vfznkr0ETpK/dRsbewXSnBOXbKtjjAozkIrt96x4M=;
 b=MBai20aiI8IWxzIqiH4+Jk1wPjd0MLBOcK4X+GTyMEs6YeRpCVCaoTEmt4jmu2whHy
 NfRLJSnTBD3pr9c2Puk9Qbc8M9yw6l/93DjFBrhsUc9KSdRHb9QzbjZ8L3iLotaTs9Rz
 3ApPnTa7ftidHADS+INUHP9p67ObwBT2vbLbSo/7LMoY0uDpALtVBXhdbDJJ5ZlTMjpR
 4Y7oZCWfKMeIXe3HJ5xZNMbJEO8+bwXDkalMBHjLPO1BO17gMhy3MKoov8h/0ZWPXntA
 x4OpmE1sFoUkCWppQBCnZ5hAbWSwcYh3GfjH7GyqnleYHOyduoa5orp6t2jRlrrJAIu7
 3NtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEUWfdAxfGoA3YLGRcW4YHsCRduPgCDlW5TR6iVI9wuzWGts/i1zF1ja/ncF9Vrn667v5Ne9SY9drg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jX4Wvp3qrJ7hdQkVDnPRttQb3ItOFAOKpBLG2Lwq/iOyeEwo1
 AgczRxV2Wg+yBSYzpF17rA+Wc8a1iWmaZWW1Bl0AW931+AYIPRFvAvah
X-Gm-Gg: AYBFou2b0mGZpVQRFgqg6htjejLpJI4an52NZYTrYTRhn329uj1KfOQx3RpJvNicCbO
 cbTCuhKNJBGRlBdK7VXdKvRjj/1Tu3QV2XtcmHjD9IaCsIGX8bLWtNqhwzgPyz8hR8ZRaKnpf2y
 oET5ruyhIPj8yC8KiGHnucbGL3RQ5Cl8fwMPAT41IV3TCzh6YxZf4SAWqRFgxNWu+96EzFNww57
 l+Gj/axaFKyD3SOTJwDUeuRNACA7Ym1+e3pcr/1AfWGbUmTYnjE0GEF1tNDRDnTiMlpGbBtx4Sj
 A7wfDIBZyAKm0uQFcQjQghInewyePakDss100OggWzQARpRMhA6QqcsgoWjiKwful5p/Nty0oyx
 rtUnmYv95M2Kngog7VME5PXYJkcrAxygg+PD54Q85MfjN4X1ATyy9OvSZFSreB8evLPjWClN3t+
 B2xPHbS5EYMj31h9vMe0oRa90BrKsoD4laAKG8T5lUrfxOAoyFv3mtg/uzJSth23E1nvr60kI0Y
 GXk+FL26MiIshQRuh9vmt4sXuWqpqlYRw2ToYXhauu+/UDnAK2sovMlGdGgXI4VSgv/yAblupbV
 8iat87S2AtmpQlhbe66oDLynEq5HqJJVi/pU/8IudCVtuugz3MKzlrILAfSp/me9xh0IrM2qBUg
 =
X-Received: by 2002:a05:600c:3ba3:b0:4bb:6118:4c9a with SMTP id
 5b1f17b1804b1-4bb88819940mr86535245e9.30.1795190097249; 
 Fri, 20 Nov 2026 07:54:57 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:54:56 -0800 (PST)
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
Subject: [PATCH v5 05/10] dt-bindings: input: touchscreen: add Silicon Works
 SW42902
Date: Fri, 20 Nov 2026 16:54:44 +0100
Message-Id: <20261120155450.7719-6-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120155450.7719-1-rofikcoga@gmail.com>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
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

Document the Silicon Works SW42902 I2C touchscreen controller, including
its interrupt, reset GPIO, power supplies, and panel touch properties.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 72 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..2d6d9b1500faf
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Works SW42902 Touchscreen Controller
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description: |
+  The SW42902 is an I2C capacitive touchscreen controller used on the
+  LG V60 (timelm).
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: lg,sw42902
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: Active-low hardware reset
+
+  vcl-supply:
+    description: 3.3 V power supply
+
+  vdd-supply:
+    description: 1.8 V power supply
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcl-supply
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@48 {
+            compatible = "lg,sw42902";
+            reg = <0x48>;
+
+            interrupts-extended = <&tlmm 39 IRQ_TYPE_LEVEL_LOW>;
+
+            reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+            vcl-supply = <&reg_ts_vcl>;
+            vdd-supply = <&reg_ts_vdd>;
+
+            touchscreen-size-x = <1080>;
+            touchscreen-size-y = <2460>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 28e4aac18d44a..a29019d984393 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25835,6 +25835,12 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SILICON WORKS SW42902 TOUCHSCREEN DRIVER
+M:	Abdur Rofik <rofikcoga@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Frank Li <Frank.Li@nxp.com>
-- 
2.39.5

