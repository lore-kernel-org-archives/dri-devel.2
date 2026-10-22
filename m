Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD3606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YndD94Q+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9133110E409;
	Thu, 22 Oct 2026 13:23:31 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AE01125FD
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:23:24 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so4128259a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792675403; x=1793280203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6CPvjoYy7BE0WZR1WCFgrzG3A2OCzgKkq+RlO5AEapY=;
 b=YndD94Q+EQFYKAsyjcDKLJK4GTGL1IrDYqX9AoP3myoCRvru7HYKv0G9uM9H76qOsV
 w+pyHirRpPtf9FGZVjlH8X7pT9e2x+Qq2Ipk1UzV8g/NFyfdoh3T8c6/ecmrDf0O6hev
 Bc4ATVjY4rYjlRCm7mxRnevAlYxS4lxOIetJkBW2oSN0INKLvcYpqsILZ6aKLCFS/DPb
 RwReN8vkpQQr8Se8jAFln/Ir5zIuM1WUS/QznBlLu3xF+JxQUPD1x24SilDQT9o+bo9G
 Bpn0lX4bUlrfJTIQUPIWZqqDSai7fsPJh77n4GBLQPGwbStW77NEnrRB1Q2j58Afbi/B
 ygug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675403; x=1793280203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6CPvjoYy7BE0WZR1WCFgrzG3A2OCzgKkq+RlO5AEapY=;
 b=FL60zuqRHwKU9b+C6DICExoX+NCHMUNJEV6Gv0E3fuc2cN6SRQauttxUv0lpEA0i/o
 h8jJgmVMI4jt4800SQNRDNJfk3zWeK1RUCtxDFFpYGwBC8inbXGsAqTsUf5HQ//o76Wf
 GNOeG/qpZso4fAQyLYmqE1GdMy4Tn+CbYjAmzBqk/ki0WR812Z930y947OO/mu9qVC9K
 Mfad64zxNM2R4fCFUxemhyoeBSvjcynDBrmTvqUqrGxXJhxgtrZIsO+rzmKC/T+fAOnT
 Hq9MjUTWbHzNsIXo/3c1NP41XBQl7tiEvWzfYRrfzZzZEC5PFWG/lnE8ip4oNnErvGx0
 Fe1w==
X-Gm-Message-State: AFq9FYL85uQnCDIfRwuL7vjytWv6vtj14HwGEFNzGTEcxmtYnRUNsokY
 YsKgPnXnRb4pyRX9TBG5h1ZnGs9NoqzG+KC4gK8GuV/QF3WtFZptaTqq
X-Gm-Gg: AYBFou0fmdy5PN4iFJ7TFOZgGadMcAgrMqrr4oz+lBSxsuhwroi4gW67zjNSuWvaDzw
 972YWIK2MKkaearp870m16Qh5nyatjjfw9urhp4CewipKfsWkMWQVLrRzbDm6Z8Prte7xjf1OtD
 PlaFxUk8ME4eDImxfaHJvNAH/yTWGjmPVIhBCZH4qpsti8ouXjpGuWlO/RK/FPlKs3sP6icXeHc
 5RIjxbo1S7A5wZEzWk/lXZei3FYBYSptZLd021YssbjOYjK3OLSHI8+4zouzCIc0/xncLf78N4i
 kzk7XHIqo9UwhYSDEpdR3nGfIv3s0Q8RIlXCEnxSdbTbP4e+yJuoDaimNZkM/heNGlI8j3fGVTm
 Hg4JLLhdYOVmKJLHioZeYxOrkRviQiBOuemtk//2y4WhMZUJ41wfAhPSpCGgoXyIm0uS0TMVqw7
 9k80w6XKQA/1QOsxPlhCVLMh3piM2EKvCiPAPOr0IoAm8RR332XviSf6wteHQ89Sw75SEJhElNc
 x78oQKMdy3WASgtyiYtgUY7eCp5+nicOVi853czZVvaUlZIQ8LCy3Z9bR/jorA4IzGNHPY9rt5k
X-Received: by 2002:a05:6402:1951:b0:6ac:afa3:6f72 with SMTP id
 4fb4d7f45d1cf-6b408dc32d5mr5323394a12.5.1792675402834; 
 Thu, 22 Oct 2026 06:23:22 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b40313074esm1818061a12.27.2026.10.22.06.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:23:22 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 1/7] dt-bindings: display: panel: Document Hitachi
 TX10D07VM0BAA and LG LH400WV3 panels
Date: Thu, 22 Oct 2026 16:22:53 +0300
Message-ID: <20261022132259.240717-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132259.240717-1-clamor95@gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document Hitachi TX10D07VM0BAA and LG LH400WV3 MIPI DBI 4" WVGA panels
found in LG Optimus 2X P990.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/panel/hit,tx10d07vm0baa.yaml      | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml b/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
new file mode 100644
index 0000000000000..4642dc14c42eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/hit,tx10d07vm0baa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hitachi/LG 4" WVGA TFT LCD panel
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - hit,tx10d07vm0baa
+          - lg,lh400wv3-sd04
+
+  avci-supply:
+    description: Panel power supply
+
+  iovcc-supply:
+    description: I/O voltage supply
+
+  reset-gpios: true
+
+  backlight: true
+  port: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    panel {
+        compatible = "lg,lh400wv3-sd04";
+
+        reset-gpios = <&gpio 175 GPIO_ACTIVE_LOW>;
+
+        avci-supply = <&vcc_2v8_lcd>;
+        iovcc-supply = <&iovcc_1v8_lcd>;
+
+        backlight = <&backlight>;
+
+        port {
+            endpoint {
+                remote-endpoint = <&dbi_out>;
+            };
+        };
+    };
+...
-- 
2.53.0

