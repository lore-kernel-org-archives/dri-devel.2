Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E8606A336
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EtGjeGfA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6B710E7D3;
	Wed, 18 Nov 2026 13:47:08 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD0F10FB85
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:07:21 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so6668165e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795003640; x=1795608440; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
 b=EtGjeGfAImNQqmN67kVQNKMz9KduINDvSMafA/EZHotihvcm/2MOMslA1tpjTeXduv
 eYdrg5kOzbXwqyqO5W1lWr7/dvmty3jfXpx8qisAkvUqwXf0OZvaQarCikLbA7EYS2Pr
 1gdX28Z6yQGe6I318aHY6wq/hIrjmH9DGYB2ecPECr0vofLJFPP23FEI+dzxr4fCUySt
 Gov8w+5zdIJQhvCx/pkTGSnuPwc+WRFapAM4jnbhXHLOGcDMHiLD6H/7Veu8pMfgIms3
 sxU0HeCXvUAZ+/gpfyGI9QYB4D9y/BrE9uB6XP8mayc/Jwvb1G+GnWSXhDZEV9RWooYD
 FrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003640; x=1795608440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dsLmXofWh30s/RrFp/am5k44VgINvU+/ItmDuae2D4c=;
 b=yggsADnfWEXr65d9z4L+W+YukNNSdYS7vrKAxMOIaJyaYVj72iS/xijSi++04kjau2
 ujfYkWb0GLJt+WlSgMT4j3Eh3t8ogVzjcBHhGbZcyHm7cs6rSDo299j+ndofJIUli0aD
 6n5Jyj/InZz9T4+flt+pDKHJoJO6i/a63DhgjArA3nDiHWagWckfCZpNFkvqOZR/dZjy
 whfSFWozJz+MnIxKeKLfcMmzVIvxqhe51MZc8/lLcRXoa2TYz4FUBzzQ/DKLNNauvz50
 2PpIBS07E7DMygsppy6/qsv+9WpWzYE9pcU7zPTzaG7VaCn5rZxGM4pwvYexJ5CoqaDA
 FL1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHSXPaVNQIUHqN/zDARi6Ps1nfYzUvEgoWbfD7+gAX2LT6XsjftUAt+GjrFUsd91G7rwfV/1oWmqe4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/tcetVzPh9pzUx+7/LdKcusKu+M5AvTeFm7TTTwwOIJefYKecN
 /2FF9RflKRGhR3CnEleMFg30xMADRjXV3gmv6uMZGUWbGkpkXoVZRNqM
X-Gm-Gg: AYBFou3XQ3G1AS/0H3+wBudtfw2l4sROTqvW5qtmRpQBy/3bZ82x35wgVKZ41dQERby
 Kp1CSB1RHMID7ag74lZzw15VqmLT+YKi1K1E/yz39Ng2QYTZ6+cQVtqzVzPKzIgpXCAnTZbhv+S
 BQtWufR63CZ797fXmbm51NEnul8i5P19hN0zW5dpoq4/q9N4LhTegx8nRZ0kl+j2U1ONLXd1ixN
 ctrmsq4R5KO8dF1i26/5nmwXWUthL05lZDdk8cXDFL+qZNPNeCJpT+MB2I/nqEFSbXPIbI5MBG5
 rw9c4LkQHKKnVeCU0+nLB4zmnVwGkuts/aYicjjRoh0Aw6kiGFUgjPB0vIBSNyIGc6Xak1qRe/V
 mh4XnWEZByTaGIju/5XmKdo1Pvu5q5ZQXcMJXaM6OhMCTTjh7dPk+mUzOph6kO02xe6g73I/ZkR
 oAvyQWzy4wDIAiLROKFtF0hDjmdsqIwbPDYyPc6KaF6ayNKxSvuxvJZxB978jfyK1pR6livMPjw
 9AvWDL8JyisPUh3jf1dslFsRvvTrV0MuIOBnVkURf/blIs4tS2/3E9/qGmg0xAaVy+HqY+kG7zx
 LG3zZSlqK4Y2mdaQZWR0EK9CE9HwuXqPqXM1UF72sPqFKWtYihDAID4f/QuLtxrs9S8CV3RUEs1
 MB/LLlSh5srPbN6MA2ZUnmg==
X-Received: by 2002:a05:600c:354b:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4bb7da4805fmr42799545e9.31.1795003639681; 
 Wed, 18 Nov 2026 04:07:19 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:07:19 -0800 (PST)
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
Subject: [PATCH v2 03/10] dt-bindings: display: panel: add LG SW43103
Date: Wed, 18 Nov 2026 13:07:07 +0100
Message-Id: <20261118120714.31505-4-rofikcoga@gmail.com>
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

