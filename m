Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1304606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hy8dG936
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4F211264C;
	Thu, 19 Nov 2026 16:54:47 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76AC2112636
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:54:30 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so14782125e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795107269; x=1795712069; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
 b=Hy8dG936wki7t5uU8lYOczhqw5d1QS2DIafasexlMeJg9ZAJKnL0kDo1RMIIkTvPJU
 xgbK+2A5nZmPbL8Xm5jnfeFal1jBYpkISyp4II8gsq67iCcuw3YqJByWyDLC+dempthx
 VuwBK+9+nvazsFnAwivmy6oR3hxigJhRLwd9+6B2yX6C+702931VW6Rn/x0Tp/WvP4OL
 oW6IzI6wbV9uKI4Dum2ZVAAZcw/Ac3Pd+1NAv8BMkwHBv8keHt4XHvucv1bdY8HGCzqV
 Y4N0U9Ib7QYgxGs5DQTXnzrxvQiXy8mIKJ03oz4uVu9AojSwpgvccX4wocF83XDLVU4f
 B0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107269; x=1795712069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
 b=LvWdD1WyorZqQG0SbJxF13n8fmjsTJPbthqnpago5iOPdh+O4gVjJ5oGCcPmqW9g3T
 WkMpShRvY9Z0qnRiYI6tzzWV4OqxTgKom7dbGovSBVyWrvSTaJj+jQWy04ihI10T8Yfh
 Wj0dFincn6J8mfKbDGVsAkdku2sJaBl2pk+a5NkPialcIJzTrE2lIE/sIRpu+C8e2Muv
 MX8cPX5/zUSnj34aI13TmH/Ozbo0LPyHhU7Au3FJl5+3RK8Pg3UqsR+RR67imUpKtqaz
 GIajY67ljnkokj1aEku1AdMkHseqqYH7+3fx6MGoGsiBCgT8F8KgPyNrmPtOuMdtRgnz
 XBZA==
X-Forwarded-Encrypted: i=1;
 AL+hErGhx1ewOm3N2ZITHepo0duChhizJfjLmRi5F3aHhwPHACh8++zwTe6chBedDusHHgEeXtm7GkrU3+Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+HMhvf/+q5tZNK2fxPGknbcmc4tbX16ZTRYgx302L79DoN/xlC
 v4svuASOgHbC7XhpRssAbszF5hmpYigb4ozNqrIe4SDA8lOhb/0VLsdd
X-Gm-Gg: AYBFou0mLmC9ACCsah81QXEcecL/XHnUpF3MSYAEiF5T4FpDVQVAXIzDx6WH/JnzZbp
 FmCV/K8TvEsD7Lo0WPT3jRlu1dQaVrOaEAQPgs0Fu5eePMWUa1BOCsjAUqzW3tNVG6c7aG0EbBl
 hnwZFFyKshi2Phoqiw3iP1gHz+4tmwRwZlyfpVKE7SxyF1UhRvh5DxXI+HdeeoKSlcErhlnsCMe
 25DzgxizJVGtxbrCOuIx8qo46T8twAA5EUaBSw7mbdyUvdNe75TOOZvZodQP53qQ6autNS0snW3
 m4xD5KHsGeasBh1FD104gfIZyr71PidIhOUiKKXFLTA19IVbpNZc8T+8NZIiAbOHOATMxW7f/y0
 rpJyCgHBdqhj3ivTaxgE1UUe4l2nnse4rM4dHj+sOTuBSLqZYEV5NtjNKcXQyhBs3MIZU6mWY3H
 vd2VZTK5Pp/8BDFataSnFAG9FOFaxsjtQuIA65z3FS5l3Kr2fPgjrCT2+9/I115eKKGJTIM3IjN
 5w/57iVzC7Whni1qWzKY0lZW0woTHslhLpzlR/9Pq7hOvEaLegOhqeWRzTMD6y3PEHgE7Ps4p5F
 4xgqs93hVJo7AIWp3s64GEhph9jt3BwCFypZhUff4Y7vCUVFX2IziuEYMoRgBhNieHm2oBEiIkk
 =
X-Received: by 2002:a05:600c:3b98:b0:4bb:7033:c92f with SMTP id
 5b1f17b1804b1-4bb88826810mr1542285e9.11.1795107268658; 
 Thu, 19 Nov 2026 08:54:28 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:54:28 -0800 (PST)
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
Subject: [PATCH v3 05/10] dt-bindings: input: touchscreen: add Silicon Works
 SW42902
Date: Thu, 19 Nov 2026 17:54:15 +0100
Message-Id: <20261119165420.24466-6-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261119165420.24466-1-rofikcoga@gmail.com>
References: <20261119165420.24466-1-rofikcoga@gmail.com>
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

