Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D9606A32D
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nvY4Lc5X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D3810E52F;
	Sat,  7 Nov 2026 14:27:50 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FD7E10E78E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 11:21:20 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so3397065e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 03:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793964079; x=1794568879;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uXU0cGie9RgBAnl9s8QiGJKFP3ILXbj0HPLmva/mBOw=;
 b=nvY4Lc5X+bNzLlePdPhimGalphKTV3yRjEq2LO19nD+e46IlQdVz3EYZelbHacMLr2
 slW+H98ikFYCoAsKW7o6OjnraXbqR98GSnsUFhYpLWx9KBlMAbZY2PQ4+boltYTKqo0j
 twOpbysga/bQkF1K3JXHLqJ+6lVVPTjiOk1jOCxpXKql9SxlDeupoKnQofOnpWf/fd3w
 xeTo+PugwUIGWUSB7wUD0pDe4I1pUNEWNF+Sjne5vjOFUDzUwTZQHoNNJCH5S3i5jR7w
 IE3YimG3NSOK46sCh1YZHf9FS8pjw60O8Ze/JkQbEda+hFsaWQBvYkRqzsyz5PIMw1Gb
 UykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964079; x=1794568879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uXU0cGie9RgBAnl9s8QiGJKFP3ILXbj0HPLmva/mBOw=;
 b=g1cTskUbZzqYC9QME2/dqq+aEAqrWtl9i2o7lzsYOygYUu9/prs0RSVsACKAj7oo8s
 I11aaB2aIJt4qus9gwIihMj2WTpd0mMPHoZJJY7rby9VJpWoe0v4mbL8ExcBu0Vzi8tz
 wrT9+sgbb6s34SZ38CbiD6bsStKlPa4YOG6PFDaRXWzHmchDcVSVBOJ+4LO45Gpd2VGn
 Wg638GXh77ucBw+46kxxb7Ktyfk20zRKTgOZqgYE1aK+wajpLI9PEskSV7iDZQcqkRZ+
 7RZ3JliWIBfYQaDbnq0LYXX+FvOJHBYhLpi9xN9EuqY+LtEDjA9QJ7BZpbQGHCQT6tQx
 6RMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz51MYUbk50dYZ6+nqBwhLjE9mqI74FK5626+5wMyA5XUfjvx5o4t5u8/GXGBrWzg0EiYcR2e30o/w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+izc882uWiLxZ4FurdQlQoiAjUFbAPPQPoi3/tEic0G/i7LIUc
 qlSvmX9/oaOcHIXObdIoJaCkpLFllubuOlUeBA/fUvQYPug+P+Ld8RycBrKStnlHBfI=
X-Gm-Gg: AYBFou10++sOsu6h/gBIznQAlXyCe2cRCvHGrSh0K72ecC0H1PKEqzCj3U0QVwMCLNR
 tCk2IUomyd9VTxXsOxQ095vryEk7POENo/20cZueUhdKuGjnQUj3lmvfPRItg0qynIKgmctn+mY
 giDhwlTdqlMZwy6diQZfTqTsKpYYuEOW2iJScqKDGoCs0b2iffzqURY+a64FRQxWChc705jhO8f
 xKC673Xu7YuXzPWDrjaPQArLL5aD6yWt78fyf+cfwnqXwsM31QltRS4SXwgxS6z6Mjw2qa51Lsd
 ikKmZZsdzgUz8g7UW3mFpu/xbsOzuo1buYK/Bo/ylkgVqXrhJP4MHvy63cDX3ZomdS/1RSh3SnA
 OaSg0l/2Hv0gcsBPVxit+4xlGRQ1LGOqe8yqb3bQ2Wx6yIpkWaEykZWbTWYQ+4jl3vh6v6VYHzO
 MrdHq7R/vp/8Mn7wCUgVV2Ialv5RyNSowgCEACwBMMKEzzVXXKs6ZHJgkKTqOM4OxdrCewsHEgr
 oshRz8VTJNVYFlORMEX/vDWhMScRDB9xSyIlgehotQ2oQw6v4sMqKrhV37H04F3qswmaZS8VfpW
 eppY3lv0G0+2PrAAI2eVpd9qpw/O4tvd8K/jBQUUuhoXitqxHFH0Wvy/OnCF/jM=
X-Received: by 2002:a05:600c:530d:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4b6dd82ab4bmr29802925e9.5.1793964078897; 
 Fri, 06 Nov 2026 03:21:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:5c25:f8d1:d9d7:54c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e2028d9bsm102404695e9.9.2026.11.06.03.21.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Nov 2026 03:21:18 -0800 (PST)
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
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v3 2/5] dt-bindings: display: Add the Ingenic X1600 display
 controller
Date: Fri,  6 Nov 2026 12:19:57 +0100
Message-ID: <20261106112000.1612-3-olivier@mgcrea.io>
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

The X1600's display controller fetches frames through descriptors and
keeps its interface and timings in register blocks of their own (X1600
programming manual, chapter 10), so it shares nothing with the
controllers ingenic,lcd.yaml describes. Its registers are those of the
X2000's display controller without the composer, which the X2000 and
X2600 manuals call the DPU, as the X1600 manual does in its register and
clock names: hence ingenic,x1600-dpu, which an X2000 binding can extend.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
v3:
- ingenic,x1600-dpu, titled "display controller (DPU)" (Nikolaus).
- No $nodename, no clock-names (Krzysztof); example node
  display-controller@.

 .../bindings/display/ingenic,x1600-dpu.yaml   | 61 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml b/Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml
new file mode 100644
index 000000000000..0e9f4442e4b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/ingenic,x1600-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic X1600 display controller (DPU)
+
+maintainers:
+  - Olivier Louvignes <olivier@mgcrea.io>
+
+description:
+  The display controller of the Ingenic X1600 SoC, the DPU of the X2000
+  without its composer. It fetches frames through descriptors in memory
+  and drives a parallel RGB panel or a smart panel; its registers have
+  nothing in common with the controllers described in ingenic,lcd.yaml.
+
+properties:
+  compatible:
+    const: ingenic,x1600-dpu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: The pixel clock, whose gate also gates the controller
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: The output, to the panel or bridge.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    display-controller@13050000 {
+        compatible = "ingenic,x1600-dpu";
+        reg = <0x13050000 0x10000>;
+
+        interrupt-parent = <&intc>;
+        interrupts = <31>;
+
+        clocks = <&cgu 16>;
+
+        port {
+            dpu_out: endpoint {
+                remote-endpoint = <&panel_in>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c10342aa32f3..a5160860ae26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13176,6 +13176,11 @@ F:	include/linux/mfd/ingenic-tcu.h
 F:	sound/soc/codecs/jz47*
 F:	sound/soc/jz4740/
 
+INGENIC X1600 DRM DRIVER
+M:	Olivier Louvignes <olivier@mgcrea.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/ingenic,x1600-dpu.yaml
+
 INJOINIC IP5xxx POWER BANK IC DRIVER
 M:	Samuel Holland <samuel@sholland.org>
 S:	Maintained
-- 
2.39.5

