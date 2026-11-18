Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255AB606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PbfX+rYF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1579A10FCBE;
	Wed, 18 Nov 2026 13:47:10 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A852310FB79
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:07:23 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so589198f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795003642; x=1795608442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
 b=PbfX+rYFDmpEp74VNL27RbIa4/GKhwG0pOWxQAoS5NX9Vq9seicr5vV1t6xW2fLjtG
 VEActmJIJ22xr6CTPr/9YZ/4RjJUtCf2mADB4Fz/C8kgNn5qHsXEFR5flIK09G+9+i09
 y5i5pam/xPPwyws3Cq56S+TxICgYyhI4YeJMd4X/ilL56jZQl91wJF6syf6MJOS4puNT
 KzssbIBRUBb27V0o6CtPwVev1ivFEY2iHIVQJIEJrmYgrzSzCrzmmzuCs8Xx+BK1ejP3
 5pTe3Ugx3q3ARBXgjwGevXpzbUUQNV3OUaUktFfUmcnvdIkFH+vaOlvQ3fcZyL6vm7U2
 IoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003642; x=1795608442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
 b=Jye9a9bXuWKneegRLGiJnC3292gx7loC9JQRcqDjo8LLkzLUC9zLOzXpV1CsTcOE7s
 MNW1Ipo5QvGRPatczFrHV+XA2o2s34nh8wd8XEk/myUMj3SZXPSLbff0DJgyZCjgp6hJ
 DEuqZwaOWKm0WVGZwlQwVmJ4GxHazANIx+pbbzb6P+jTrAZHjCmS4PFTXAWQuXCBytgE
 ElcM1nhH7yNmFE7CtqaZeSwjHPKdzTN8k9harTffVD6BfjgrkMl9XlsZUqJGhfXFs/h3
 1GnguTmdKbma+ES6wvhTXtMyBc+rnPE6S6WmGKSBNpxJbLR7PhmpRUs6WxH872j+lwwh
 DjRg==
X-Forwarded-Encrypted: i=1;
 AL+hErF7LJJtdHX9+N0pFeXjTcm5BEmdb9BzvYFKO6USbJn79+u83cYYG8KI5TvzbbgPCkOV6H37eoTH6M8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Xivt8KaUCmMHHhNOzoJZgrsoXRBTaGMUoXixyyd7bCgK6EKD1
 I6M5UsH8KUqC6J+IexT6grBStXPUH1t5u05dfQW5fjF5OJAuulVY5IvT
X-Gm-Gg: AZFdTZeViWo8uMw24RfTiJCI3lnMqIVt3H7tqbExhCvhid8TF99DkMI/2bY5jGoVQ2C
 xNGWjpqz+i35r/fjbH5fyPvWloPxuUynLk54wau4YFZlxSmAlJ5/Esf1YQECnZRDGpVU8bt5HGt
 pUJauACZ2ayxfJIePK8K0n05TeDSun7JRmpIZ6SZwH06/zQ2Ug280Y4XDnoTqQoq519qrUqxM7b
 cq7Z9UG7RTarRhB4s7USa0nHq5fcoSWsXaTPUmvOq1AZ8RNvZ7WA5eZtGEG9RBz62/Ssj/WSBZD
 BbxrF9DJw49kLb1rMomM5t1/rh1VWx53anpNuZtyrYURL28k0QxAAvrj/pz0QMVeLczHu3h20nZ
 m+2Kb7qTddX4qk7WHJJTO79k1VwzHxIp/Ykn+dDvMlf8FimiUC9QMz/hxkqx4QTasNds3NGPK1x
 GiLAHXVPB5gfFn2ufsVZcTcGE5OMjQGa/k6e7boMfCsP6UQ9sCEp/J3hG7cUR9QGspVlxynP+cV
 8ttvgsT2t2Ya3UcTbSc3s83R5iOIOO+4oeqdonZjGSLNpRAOp8j5vwP+pF/F3iQyLv1Gs97vzWw
 7utMZoMWGc+Z7qOowNndHh4kjiaAPsOGt6D/4O2r9nB9L1kZvSmrYklHCX+c/wwz9O80UJpUdv8
 =
X-Received: by 2002:a05:6000:46c7:b0:49c:192f:cf1e with SMTP id
 ffacd0b85a97d-4a63b13855amr3763095f8f.32.1795003641960; 
 Wed, 18 Nov 2026 04:07:21 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:07:21 -0800 (PST)
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
 Ivon Argel <ivonargel13@gmail.com>, Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v2 05/10] dt-bindings: input: touchscreen: add Silicon Works
 SW42902
Date: Wed, 18 Nov 2026 13:07:09 +0100
Message-Id: <20261118120714.31505-6-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
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
 .../input/touchscreen/lg,sw42902.yaml         | 73 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..c5ec3bf4e545b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,73 @@
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
+            interrupt-parent = <&tlmm>;
+            interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
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

