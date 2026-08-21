Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79292C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C8C10E2F8;
	Fri, 21 Aug 2026 14:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z+T3Ni+j";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D7010E302
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:38:34 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-836ce6cbe1eso16772257b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787323113; x=1787927913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FpnrrgVBkCseeH30s/+2qScfilYBiNsJRVekRnVKb/Y=;
 b=Z+T3Ni+jb5phIfbZFx7qjZFKkq0i9fVndi8JyCGNQhXqJDGN/ajlWU2NBl3ElrQTbQ
 4MO1g116mg0e0Tl//LVcKL0qTfAsTxWEF2PbJF3xFGiGWFVE/2Ce+NaCgsUU04C4C2No
 UoDtgZVyDyCvQB6IUYRHomKDmpW4p5xdKgEDnKVGdL6r/krYLOjKLgNtGRn3JoKpWZYI
 UAZq3nGxIpkOnC6VTswlLUaNqGRRiVGPJoRFV9owEyw+MCUI3bDD5Q4QYWjtsShVzvKC
 SCqA/6Iq+N5JS9gLgJ2QWXxdhtR8SIpqP4Ok6TmswV1um3YmN97gfrz0fYHltV/i5IeX
 6T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787323113; x=1787927913;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FpnrrgVBkCseeH30s/+2qScfilYBiNsJRVekRnVKb/Y=;
 b=fUP+iqUX3F2+AL5Pl1QRgbGZA4fnSE3/V4QuCVSXX46lfZ//H0N7RjfKkWudL0Z9sC
 6sCC9C22ta3Z0bxq3HwxUEAbZ1ejugFRUFF3iZy5tKYI95+f5bauSXVckpH0Bez/M8Hg
 TPngGVCvDWv4MnisKYmzk5rKldlRO2f4w24KmrcAV3RQV7ZTCQ+o42BuEH20xta1VKOV
 NSKqXULZ7Jl2YJ4oa7ErWXzMIkvQ7PlibtwM1ODIVxXS3Kwsd4+0AOUbslq/PPAzejXL
 Jh3wIIvjFFWfB8xRnIGe8hgRB0nHcCoB/Mj2vK+jd+Xw4Z52P7APLVAdP1ehRNGBLtVA
 iP4A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1yuHA9IY8Bj2svkwykCBPSSeLpcKIIc0Xf+upiHu81eHSE2caQ9wFsGYgWgf0jKMu6KWSLzCwGkk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nIiIhHGk0lCSRyEoEAWcV8gKGNTS2ybGCkEQ4rpmr39mFt1oI/
 dLyeQxCQW1gbafCXAysgUigeMwjaAwm8HreXPgt0IMrHGPaQA5nZ+xw=
X-Gm-Gg: AR+sD11iH4Qp5F3rr7Y3jDeEaxop47ts4DHrOzbvThJWa6hzLPJ6e3U+7i0yxxrRSKr
 AV2qoJwjKSaOV7P1F833thmDjebREct8T4fXJshNJ6K35Rmgt+M4vcxhD9oIcbVHETLKVhIcYMB
 gzzf8rSPFCI3dFdmhP0ixohpEFjMo79jFzXA+IrQH/nKOtnK/USl0zqqSH03fRshXttni1QYSOk
 ZlghoOc5ERjDSDEVEz8k51SnlCv+xuc5BgM0Z7XwgeBzWJm7u3kEG/hJWZBfVXOFxKNIVQ7qtdX
 BCCGCP1mwR//grTZyZBYozPtLQTmxTO3VuRUkzyb51E+S6BAeDqzHH844wBJcY5wt+Rcg8D+IIH
 x0TVVp7y8mgyOIRG+PCR/AO5U8tjIf1lsgxwdQah6f1+dghrx6aSCdHK7qU/N9qAO9n1XuK8hXy
 voAT2QT5MTJ3jr70FVCaelA9MeLCV/Ptz6fQHz2vYNCKXLCxCTODjWr6MTDTiRbVeUm0pZxC1fy
 094NWjMKmFcooIAHePeRhvsW8Aq5ToZ8TFC9Fu6
X-Received: by 2002:a05:690c:e20c:10b0:81f:d515:8c06 with SMTP id
 00721157ae682-849f61ddfc9mr21942087b3.29.1787323112427; 
 Fri, 21 Aug 2026 07:38:32 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-845188b28f2sm41868277b3.38.2026.08.21.07.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 07:38:32 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: display: add Chipwealth CH1115 OLED
 Controller
Date: Fri, 21 Aug 2026 11:34:16 -0300
Message-ID: <379eb0dbb4a911d80a3af680f647cf13ae0ece32.1787321297.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787321297.git.nico.antinori.7@gmail.com>
References: <cover.1787321297.git.nico.antinori.7@gmail.com>
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
NOTE: patch series based in kernel v7.2

 .../bindings/display/chipwealth,ch1115.yaml   | 89 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml

diff --git a/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
new file mode 100644
index 000000000000..9d9c43722131
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
@@ -0,0 +1,89 @@
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
+  chipwealth,invert:
+    type: boolean
+    description:
+      Display pixels are inverted, i.e. 0 is white and 1 is black.
+
+  chipwealth,offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 63
+    description:
+      Display start line offset. Specifies the vertical alignment and row shift along the
+      Y-coordinate.
+
+  chipwealth,contrast:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 255
+    description:
+      Panel contrast.
+
+  width-mm: true
+  height-mm: true
+  flip-horizontal: true
+  flip-vertical: true
+  panel-timing: true
+
+required:
+  - compatible
+  - reg
+  - width-mm
+  - height-mm
+  - panel-timing
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
+        chipwealth,contrast = <127>;
+        chipwealth,offset = <8>;
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

