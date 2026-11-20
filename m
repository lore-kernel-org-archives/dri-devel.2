Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8D606C8B4
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VPg7jHAO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B574310E940;
	Fri, 20 Nov 2026 15:55:05 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D2C10E91A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:54:56 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so790107f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795190095; x=1795794895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
 b=VPg7jHAOfUdFpLtXfLzAJeDxoYI6uGcQlvGVu0jhx8yGOnllZAXc2Ep8IJcl/puLR9
 n7pker0DiDxI3goFGnfdeMu18WvW2qYsppp5BpJJI98hhYn1es1CtfBwxnGjQlM9JCVL
 fuEMDcTPLOwLQmZxUqDQaepw4afhsOzDeetjistvuNNk2+Sc5XNpkcG8XfKBrPLzd1qf
 HMKwuvz5Ov1Fwblp1UWe776+pfgj8Rq+QFZ/O5do+pfxoLdEanVuF5jIAd16vS733G/8
 yezHl3yns/M26GVUK1lOrHOXaTvRXDFm7Kmp5qG014VfohR/xjQUiFffF+jerRMqXqbd
 VS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190095; x=1795794895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
 b=PTeH699LmEvIRLun3meKIuOo45ZgH7VknrEuf1Wy0xGiHFAmdlrrYGJqioNGSFJvm9
 5+VvB4nu/It9vhLd9dEPL7APaIWUrJUlu7/EZayjk80RYne6G90E6/LqH7eJeWLkLd2W
 3wCvxRoyJGAgJcXddigLjepMXLj+StVq4IsXrePvZNnCvHtl7iT4a/R54vuCe6wr83Vq
 mktP6ZE5w96otUZJRzxXKDbIjNwEID9+yQzMamfVFk/rnbPZnj5H4k6mQzG9xONNx9z/
 eK0uKxbG98mODU683EbtYV3JZrZrVyRPFYDntC2AZE0EkT0S8PCxfQyRMTWseLcf2BwN
 yQOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHAJtEbc6j5WJanimfpx97zLclVlfAP2vS3hGF1t00daYhqUe+IqINlq52qSbDx2pAKp0Q1SK7CkFc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/l25qVQmqT+LSxEZBHaUiqACDb9kgdLhhvP93Tjmq4Onprc7uA
 9obGgFnkEXx1MXQv30dFc67JuEdgX4BbS4QiaBBcFIT7zTMper/ZO5WS
X-Gm-Gg: AYBFou1fCFPiUmCtGrmdo6pTLbFyGB29j7ryhoyUudWO7sQnmx1wdSOzrJ+o8OMdsKp
 1GpclzNEirDbZO8j4lfRLrPrg7cNp6XXr1XrM+DhvaQDlfXt0AXG0U47mlvAFagXJi5j5cwsOY1
 N9a65t42Wsh03lo7kS+6kzpHw/Ol5I9khka/CLQGFEpCIMYk5PcPpJEOXf2oYAEWqQINMpDY2jM
 z2zCvoXmdH/BMbVR8UYHZMrw2tzc42imrg3k7e+uchJa7Vk6E0B69Awx6hNfckUKcmMyC3OK0LQ
 YJZC90GFYEapFn6DM/5KskcFonVQJ5BKCxvHv+/Bo5hz5H8MGmN6WxpzuRxsVfS074SBTxQ+ftB
 2Wgp5c971RDNCUY9exJelI73yg4JRb4xq4GuHUkA7YZ9HUU22W9IvbVBSNcSDCjjrdPnsAKMeVg
 WJBjAwWqFz0/Ui8HbNdw33ZxlTDo5Vh5EMigtI9rfG3yBmVTxC3MSxJchYXw30n9Hbvje/Sjdzc
 cts5OVIUwmWK29qLaIj2Mecs14FSwnyCgBFd0NOu/zr7jQ/ipsgbPJLoZBV1SegvXRjW2WsDM2V
 YAofhStUB98dNcVeDRyLwdNSOuXbelUR4L25SZf+5J42tsFh3Bt0LJmrCJplAMuH/MqqB8pycNs
 =
X-Received: by 2002:a05:600d:82d0:b0:4bb:818d:8d8f with SMTP id
 5b1f17b1804b1-4bb88818955mr89360365e9.23.1795190095071; 
 Fri, 20 Nov 2026 07:54:55 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:54:54 -0800 (PST)
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
Subject: [PATCH v5 03/10] dt-bindings: display: panel: add LG SW43103
Date: Fri, 20 Nov 2026 16:54:42 +0100
Message-Id: <20261120155450.7719-4-rofikcoga@gmail.com>
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

