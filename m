Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF160A2601
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRH+YUZt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FDF3112656;
	Thu, 19 Nov 2026 16:54:37 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCBC112587
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:54:28 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so1774086f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795107266; x=1795712066; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
 b=IRH+YUZt2eAI55nlzn+NSRN8r3fiGYZLrvsCC2lfGSB8NAUrtNc7lMIJeOENt0Wwdi
 8PvgHCwlUzyqp7A9IssfNVcFY0+129h/K6RFG1Tq/W4K/BUhANdEpaz3RuGJtWmCc81B
 /pYFgVurGNnAPtZYxPl8D42/HwqfiPOgL5TY1vy6JRS0n94T+XG0OTLoa9uAxPKbSnOF
 a8XfySlHvleHpQCtDTehwnzwS+v9IzQLD297ZdGH/NB10BoMVgOM8Fh82BjA9zPQe91M
 eBQ6OeOvunqkG+1cN9QnTx0PQNp6kktd/sSV3iJurnFlXDj3HHu1CTOTPRqOMls3kdbA
 prvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107266; x=1795712066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
 b=Te0gfZ5ks4P+FTp1gdMIeKmstg2i8Wg9zlApRhqir+XSmkX0vtKBpkNbrC3JAUSZXq
 RqZ3km84CRNHLTXImG+DTgRiyVyGdKdXdOcS25y0ajl5MN0x4doVS7HCmBRNVu65aOh8
 6+FI7IH4KPK+LhnsEATovsgNZ8bBBSAHogbQx7iaLBDqSFAnGvUQj/16SHTOkCyZ6iMM
 EFhfEg9rGdSfoGfjIY3gANp/XREaUmRXsZ4uC8GTFzkEYQWM4w08A7Hb2bM76t5lDZvh
 Whrm/FQhhSbayuSB1pRRr52c8noiSIP6Aiip2AIUGQL/hcI5wNUOtoMZ8ISaJ4cogFYD
 q/uA==
X-Forwarded-Encrypted: i=1;
 AL+hErFPm8ElPAcGZZ/rG2Rgc/WvSkrGyK4uS8vZLS9+DgtNOpG+Gfy9n/sjtAA7jJSuWSP24pPgQu5s4u0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+06V92th9j+kj0ZKLmdQwlcVKJLcF3FLKkA1ksfRZRrq2WDbTf
 c9pOzX6Pq9PT12V9cgi5SCmYhn9DsUmzjZwtBo+NCdo/LMfZpMtZ2v9J
X-Gm-Gg: AYBFou3FA/g7lXOyD0f91HFAoSLv9CXEytyjIo/hsflFDJeNx3Bjow3YKxFkswX9r3W
 1rtbSllMeb28Ub0a38ti9he97WoEc62VfZ9674U26lDFIO3p2a4EcqBRUmXmMAO8zxlTN28+1UU
 ZGD0rCX1EOsklDSXwutVS/yCSohNC/tp17rcjwBxUGnSFJKmKOtQbuOzSU9NYjk4jWgmDMAjQcX
 YJJsRvh1I27v3tKiERVMLdlu7hvOFMa0EfmT6zgb3LeVcjT33l9oZs/Y2b4t1wBo40YDyBZemJS
 SdrDLuzgDnweTB0XevdeT0zaiWhTOderCzDyS1xocBNLQbXyMU/H1spgIbMrcscaU+yOZa6VbjM
 xDihbiRVKV7kW6Sflpy2BZDjft9Y0i1M2DdQ04FFR3y29d59IKCImnOabHAL08s0C8qj9bYvpWz
 6BxCFzsqExzOCv5d+pOEjF5jEwasFg0OvuyBg9tgBzcSmbXOCzDcaGzfGf7n6m9eH/CiZ9KqZJf
 itekuyFi1Pqub93Nw9YQO7cLhTy5MWtRxpS3TLPSKvOm46Ka4E/CVrGmv+SWEgLabERBdtOYRJX
 oT9A4EhIXNLCjTaBi1uHdWtzLV4olDBXt7XMwzXwzorSCm9Qy0hqaK/5FPtheyy0f9tL7fAeIJ0
 =
X-Received: by 2002:a05:600c:310f:b0:4b5:d95c:2378 with SMTP id
 5b1f17b1804b1-4bb8881f9b7mr1875815e9.34.1795107266548; 
 Thu, 19 Nov 2026 08:54:26 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:54:26 -0800 (PST)
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
Subject: [PATCH v3 03/10] dt-bindings: display: panel: add LG SW43103
Date: Thu, 19 Nov 2026 17:54:13 +0100
Message-Id: <20261119165420.24466-4-rofikcoga@gmail.com>
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

