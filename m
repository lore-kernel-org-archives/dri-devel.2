Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164E0C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3F110F4FD;
	Fri,  7 Aug 2026 14:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oikhy3m4";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2940210F4FD
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:22:32 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c9e30214d8fso2979572a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786112552; x=1786717352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FXqORpQuFukFf4CtgnQuCcVwYnWDFuCVbv8LufyxBXY=;
 b=oikhy3m4Wt+M1ZsdOJx0y1F6gpsUmoQy15FpzANi3bgPbtbAVp8zWhE56twFFs2uaZ
 58XmeXBorPOygByKAAX1qj1dQ8eFBorq7kDgO+n0LWai4ZGWEGNsT2bxpypXDk0WnUAY
 oaKkj2YkXCFHBFtnyWVz0OBEZRnjlelCdUYue1/RetE3MkvHbpEyfGeXtx86E5A5jk1C
 uBs+dopK+880fGf5O+GtjQPbRHbujYexc2et8qKW/iWKbUXBdVS7XWPhS5pgMK1E0Nkp
 aQrBoOaHrp3Dw+nce3AGP7BL18Kn5GjGTmfQCzpFCUJL7tqlbFLCr3+l/t29Dl4wRti0
 +P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786112552; x=1786717352;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FXqORpQuFukFf4CtgnQuCcVwYnWDFuCVbv8LufyxBXY=;
 b=rwa579mXOLAO2qk6pmy2JVWSOoB1JNz/WPcTcltXn164O2C8ak/+9bX6spq51JgvAV
 1Kn2NGKtmvIMjlBh7kyvPybZP5xKST2+eEhMI/+3YhLKA+N3j8JXLQnSTVwqOmggXF1K
 yq9+WtCq98WHSDFtIbaOCToYSxYP6D6EAVMZeiOKTnVC1zmQgrw1RPkAuoOugMmSi5co
 pWmpKhjHkjRj9Fx3haKGI/P5kQzH2nv3nODncJzja3TUS/A2HCOq2QdDMfYV5Rx75gYY
 kHmC7qhQZ1/F1MfEIZ8hkCKkTEDWdpI7YHTJmZw30P/n9FT7Ofn3cDUG0n+x91B2w6rQ
 Wf/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8010Km9kr+JsxHuctkEuMo/BGmL1Cdkebto2hp0sb28JWXuqVOM8ogEqwfPimQNo9vfVf0WPqV8o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze8n/Kf7gNig15m3X6nqiY5ZMEzWf9fn2MfpZ5Rw2eHvsIvMTc
 R57d01ODJJ2pctWZY6g23eGN7YazbIJ9SuWCL+aSi3l1Govk0kw1mTA=
X-Gm-Gg: AR+sD13Xkyvoe79334CupsCHtHUTKM8W3GwHqouS9qHVBWhCkJ3FouVgMNZtCaqTLK6
 ZDc+FD6eKGmfYBA4g+sFIRSv8TlgGU0vys9NixrbDO2aILmVr88rjuVSGvBuZDxkA6fkNhN3g3o
 HY9mtzGSeOG+nkD8Y8NRtCVefb5WBzIymfVO8QdyuwAlNp11whXHcPaNsuEueRu/PTycziw6+U3
 HEAVuWpyCRMPBPgWAvvl4u0sVyhJY6HgvursmqFt49/vCa7UeDBMWt4gbQDowrjXcvoa/RVZtkM
 lNYaMztaOUrT41RMK7s0d3CDRuNmxjJw1s0SrZ8VLO3bq20skKrXJCOHEpc/LnR8oBgapmp4Pj5
 hk80Dp7F/nOSnc0Ssg6NukgoYofS68sFuX6zskqQUyAIbjAhlWieGjPNalYor0+lyBWW1VLS+pA
 8YL0HjCrNAdYCdSaajzdI4vRh9Bag8RCn9YIDFd9A/NMHuSLbSr2cRj9wVkfwEZh994EtbMiiOr
 ePSYR3QM0bcU8j+c5Ju5VcIZ1rTT2sd8/5pZowN
X-Received: by 2002:a05:6a20:1602:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3cbce98a610mr966402637.33.1786112551619; 
 Fri, 07 Aug 2026 07:22:31 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm8521868eec.9.2026.08.07.07.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:22:31 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 1/3] dt-bindings: display: add Chipwealth CH1115 OLED
 controller
Date: Fri,  7 Aug 2026 11:19:50 -0300
Message-ID: <cf9b02d618db4eca88e2d32b4bf779011fcd550d.1786110720.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786110720.git.nico.antinori.7@gmail.com>
References: <cover.1786110720.git.nico.antinori.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 .../bindings/display/chipwealth,ch1115.yaml   | 73 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml

diff --git a/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
new file mode 100644
index 000000000000..29d55da85d21
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/chipwealth,ch1115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chipwealth CH1115 Display Controller
+
+maintainers:
+  - Nicolás Antinori <nico.antinori.7@gmail.com>
+
+description:
+  Chipwealth CH1115 is a controller for monochrome dot matrix OLED
+  panels.
+
+  https://datasheet4u.com/download/1576606/CH1115.html
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+
+properties:
+  compatible:
+    const: chipwealth,ch1115
+
+  reg:
+    maxItems: 1
+
+  invert:
+    type: boolean
+    description:
+      Display pixels are inverted, i.e. 0 is white and 1 is black.
+
+  width-mm: true
+  height-mm: true
+  panel-timing: true
+
+required:
+  - compatible
+  - reg
+  - width-mm
+  - height-mm
+  - panel-timing
+  - first-page
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      status = "okay";
+
+      display@3c {
+        compatible = "chipwealth,ch1115";
+        reg = <0x3c>;
+        width-mm = <12>;
+        height-mm = <8>;
+        contrast = <127>;
+        first-page = <1>;
+        panel-timing {
+          clock-frequency = <0>;
+          hactive = <88>;
+          vactive = <48>;
+          hfront-porch = <0>;
+          hback-porch = <0>;
+          hsync-len = <0>;
+          vsync-len = <0>;
+          vfront-porch = <0>;
+          vback-porch = <0>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d2ba67c4c8e0..1d158ac83ce9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -325,6 +325,8 @@ patternProperties:
     description: ChipOne
   "^chipspark,.*":
     description: ChipSPARK
+  "^chipwealth,.*":
+    description: Chip Wealth Technology, Ltd.
   "^chongzhou,.*":
     description: Shenzhen Chongzhou Electronic Technology Co., Ltd
   "^chrontel,.*":
--
2.47.3

