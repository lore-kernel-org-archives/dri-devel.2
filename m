Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C954C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B140110E7CA;
	Mon,  7 Sep 2026 12:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLXEDBDZ";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F8110E7CA
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:29:18 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-861145fc841so28234877b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788784158; x=1789388958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E15zTz6LSPQ0+KOjqcr732bl7v4sHhRkFWWTNxNbp1E=;
 b=LLXEDBDZMGwW2NpNg7TFCGXZpqhEspu0a5BihlBqrRkt4pWAG9MJlfXy6tS5Rpw3+5
 X+Kp+fcjXch7wHxFWECss6F+CqFQdBd1z6dblsf8AAP6n9dhu7OekgE+dAO0CL1ec6rZ
 LfztdHu8I+zDLAuurqzExbOv63DK7oWkGo2fydiFbYtGkURGEQaLyYavOhoAQj6HUSSA
 K/Ty1kGM5KNQVK30ynUWRTn6SUi8V4wswdXPLozzGNADolYuo6TUiQ2REKg8TQe4u01c
 kIvk+uXokRVUDxZK4hk4V3fVCuvRlvFwd1swArTdZgm/XxiOZGC5hDiwkuj1HxjAeG40
 IAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788784158; x=1789388958;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E15zTz6LSPQ0+KOjqcr732bl7v4sHhRkFWWTNxNbp1E=;
 b=j+6EuujfVmpUBDC+Y2aqFW/TruF0pU0oik6uh2ZuKGlD0QR2aUiYr1KoKgGg4G4/bG
 3jvKm140e1EQ9OSsZytB4WTXHd9EKYherP/zbvhCy8F7cxNIYMoQf8goow89K4NS7CP+
 vpkcR8rcH856tW4KV5keDDNC/TYIgHXTWXsfe80Yf7V766eaYRcWX+5/apTXPwj5UK14
 6tkq4ByyDb40sKH5vs6BP2EnUGrSaPwMd3NZjbd9mL0a0pvmj4X9BGUV4ir5jNBHAq1C
 dq1+gCTKkVdpk0WMjyHNaS7Lkr5RthpnD2Wl098P+w95XpRfRTJsDabmy7hky167/OCZ
 NCsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXWPkG6TOAylwAHQNSxmaAJhe0aKaE+kRjIYwZ6Bq6USc1ldYG7tm+eGVsAwAOm1zSf2q8lwH3XeY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kFRWKDJwVvCv6XcweQa7K1/rO6mtMJgwqxaPrlVnY9i+jtf+bh
 jsazcb7/5S5y3ScT3HlgKRhnSRp9X65DsxEv7BUBuldtGaTTQSr32kk=
X-Gm-Gg: AYBFou2LXYQ3kAC2HS9GOH5VpmHzGqazvaIhOkopXDTkGxZdSINSbKSbYFSsxUpfRZy
 VUvteML5JJ/2oyi7nNz/HpMxjbQZ2k+saR9yft9KbQx6my9FURjZPr9JpFpKUNENHHZ7KPLB+Yg
 vhYc/Xu3lsDG3TzLqME47NBXJq2j4gdZoXWHPQEepq3T9Krc8B9FF25pGRMIWv+FtY1f/6vVenv
 g50LPjoG1G9hBdmVNGXVttNxCIVxylw2G8iFjPtF6dKlwDGYbv/P1cCsLMBFNnQwOOg5XE/6y3y
 41QNYNDZxuNI79AiOvTKmJ71oGByXNUZ9zm70IYz/rZJKfmuLQ7dD9q8HBtWrzyIaUfEchEqNl1
 XTJXDLOQ+TkMsSHIDDYXkoPUstir8fZLC/vEhcEYgQwvK5ftEhoWFXauNVkCDZR0qxQHmSkq/N3
 H6s7DXkSue4dzpaoPw+2ldOEmphrHbMmT74mHmIWq9jAxXdUpPBV2Yjh8jCbNbDBGj6qvqWXSnJ
 PJFTY5odlrnN2QxJVN9qRs74Xy79iwuBOL6zK8=
X-Received: by 2002:a05:690c:e18c:10b0:858:6dab:206f with SMTP id
 00721157ae682-87124c827c4mr65766617b3.5.1788784157765; 
 Mon, 07 Sep 2026 05:29:17 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8714bb0efc1sm70511967b3.45.2026.09.07.05.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 05:29:16 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/3] dt-bindings: display: add Chipwealth CH1115 OLED
 Controller
Date: Mon,  7 Sep 2026 09:23:29 -0300
Message-ID: <b961c25f0b67968b6ef891f2dd3527508a374261.1788711082.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788711082.git.nico.antinori.7@gmail.com>
References: <cover.1788711082.git.nico.antinori.7@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
Notes:
- Patch series based on 7.3-rc1
- Carried "Reviewed-by: Krzysztof Kozlowski <...>" from v3 since this
  patch did not change.

 .../bindings/display/chipwealth,ch1115.yaml   | 81 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml

diff --git a/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
new file mode 100644
index 000000000000..6b037c40242e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
@@ -0,0 +1,81 @@
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
+  chipwealth,inverted:
+    type: boolean
+    description:
+      Display pixels are inverted, i.e. 0 is white and 1 is black.
+
+  chipwealth,offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 63
+    default: 0
+    description:
+      Display start line offset. Specifies the vertical alignment and row shift
+      along the Y-coordinate.
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@3c {
+            compatible = "chipwealth,ch1115";
+            reg = <0x3c>;
+            width-mm = <12>;
+            height-mm = <8>;
+            chipwealth,offset = <8>;
+            panel-timing {
+                clock-frequency = <0>;
+                hactive = <88>;
+                vactive = <48>;
+                hfront-porch = <0>;
+                hback-porch = <0>;
+                hsync-len = <0>;
+                vsync-len = <0>;
+                vfront-porch = <0>;
+                vback-porch = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 73acf72c01f6..16a4a7a158ab 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -331,6 +331,8 @@ patternProperties:
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

