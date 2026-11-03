Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52639606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r2anjki0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A630610F839;
	Tue,  3 Nov 2026 20:47:20 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB26E10F842
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:47:14 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-5ead4026fe6so1890763e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 12:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793738834; x=1794343634; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fiW5hM0LTMUxH6fsk06/qcEbiBGXuvdygHyz52E4fRI=;
 b=r2anjki0V5I23nqSTZbbI6XBTTegTRhVFvX5BWkDZih+YG+Y4CHOgK0FsPgHk/cODX
 dLVxKaYlU+q4JvLgIWNd1PEj0S8oysaN7xy5f2PwD9pxOsrdegG7B9SzcRoxHxBxD6Jz
 MVG7KeJP3kVYhKTbkEEOiby/jguJPgnYA6qexIGZ05Zwisol3ZGTQwjACVRIRIYz+GBv
 uFT/1tM+QarTGb1xyoaNPqsY4s3nlaw8WrdeFXm85sqR2byeVpC99EUnjMt7kIAhYk+P
 HEjhyvcrWNG1yyma/hDe12vkKATTXQhE3Rz/oAR3Fm+AeI1DBMuQZ27d7/c8X8B4lkQb
 gFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793738834; x=1794343634;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fiW5hM0LTMUxH6fsk06/qcEbiBGXuvdygHyz52E4fRI=;
 b=yRlzu3BLUkEe+OqvfSLeJkEGXtR7WHqk0Ac7FXsg5XmkFLI25lr7/maLj15zTx0UDb
 wuvxlEicDwVr2FL1tK6LVyjvf+eoc+5/SV0ebxbxBTvhRLZKRpSho781/ebf2i3nXth+
 82QFVLrUqfgeLX0x4yTqoxm4z+mOr6vBlRo2m7UwpoR0wPHeqXBwxY7CwWmzq6uMQEyk
 DLZYtqQlAh8Ls+4JUmskpA21Dl77FoevyX2OYDJN9vmTGIxTNpuqKzGpIjYfKCXTiiyJ
 GrB8ew2KCDH4b2n4lFnWwmCP7NMmgCodME+KA/PuuFZbPZ+QxxJU7Pu9wykf0uce1ssn
 Ylmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2rdyalz7GY3q0LCNHCrqLhdEHBjkBeqjSEZtDjJXcSONKO1DGzcPbNY1atbXkyil6owrvA7JDhuQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/M6GZp6QVK2GNphTjjVUB0zI+vsobU20zvOOUJv7oeMRMTmYit
 9HCDkb7a8gRG6WngRQTpRdAX9OWoua2oju37KDWEatXOm8To5mMbE2M=
X-Gm-Gg: AYBFou1dsfwI4H5Rb7g5nWuuij1aj3FuE07Y8cXSK+b2xvj7kziMkg6FC9psEdVqN4b
 +SwgdpvPo/0BcHvNOVoewI6ilvSf80yCaSnXAl0T9KvsGOxZYDFq50MwclJMxHC/0paCi/HMmxd
 QwIiUQVw237tkQkjyQ20bFax8IHRtSmyEjGKLdlNbba6LoAdMtyGl8B3fB66KY9RZvmgp8xP9t0
 IIkhzhJLk7XfnCSuJWXWwUWiwxUvGpbPq7MbV36nsTizO4v1J+hA81BJz5Xs/C7tja2rqRbicu4
 Zlt85xWNBiOsD4hDDnVGFjoMuKYdfIvBfeMbpTEWKpkJIhDrzJrEFkakVJ0Gi5YW8v5AIXDeehA
 A62MZJ5FmsVsF4SBHmUBBVUMrADKJYEzrYm0I1B5ut+sfgAiE8A7hT1GPJCOTXeDj8SJ1hLLoWC
 XiiCqO9cmAug6GANqDS2p3HRt+dzeDDy28lr6tlUt+Ae7b/FMneTDiVVArH+NCJhiKhedphFLaD
 Za94TccHtmZf9YoXeUTpw1i8istiIP2oXCODD8DTvFVCl0ft4tCyp63DucYhQ5jwGre7ywkhU8/
 DG9vHTldRbpXaicG6YnmY2K3nTlSQ3/cOVPJfyf8X5RkE323PLXK/IzHFZFuC6QTZVR5X0cOR5n
 IIdbJ
X-Received: by 2002:a05:6122:210a:b0:5ea:f399:7820 with SMTP id
 71dfb90a1353d-5ec6883a5a5mr5727843e0c.10.1793738833755; 
 Tue, 03 Nov 2026 12:47:13 -0800 (PST)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5eca89b81b3sm119618e0c.2.2026.11.03.12.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:47:13 -0800 (PST)
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
 Javier Martinez Canillas <javierm@redhat.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/3] dt-bindings: display: add Chipwealth CH1115 OLED
 Controller
Date: Tue,  3 Nov 2026 17:46:51 -0300
Message-ID: <eafb1a147cc8e3c8c8a1f863fb47d8f6c52655d8.1793735996.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793735996.git.nico.antinori.7@gmail.com>
References: <cover.1793735996.git.nico.antinori.7@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
Carried "Reviewed-by: Krzysztof Kozlowski <...>" from v3 since the only
change was the removal of adding Chipwealth to vendor-prefixes.yml. This
was added in commit 058ee00216a1 ("dt-bindings: vendor-prefixes: Add
Chip Wealth Technology").

 .../bindings/display/chipwealth,ch1115.yaml   | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
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
--
2.47.3

