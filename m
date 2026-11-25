Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16B606A331
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=LwSqyR9F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878F810F984;
	Wed, 25 Nov 2026 02:11:46 +0000 (UTC)
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com
 [203.205.221.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCE310F988
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795572693; bh=8o2eFM0hEp3bckqxilWkip4AP0ZcM1uxjRx6JW35CV4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LwSqyR9FinMF2GqLFeKIfBJawu578qDXFqpgOGpNAcDThJfsxf92O0FYdsnBnOb8k
 MSjP7oa+ODnuauiMmafW3eGsDyo1Htbh706/HmjWEEDbhGEHOvL9bgxptJNl2Ks3D7
 UuV2tCULHEX+ZQmPZ6+UAfMFheDLW4Nhhe7XAegc=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 2DCBA053; Wed, 25 Nov 2026 10:11:28 +0800
X-QQ-mid: xmsmtpt1795572691tyvcjf7qq
Message-ID: <tencent_33047574BCFD03DA2AE57B9890EB09FE7705@qq.com>
X-QQ-XMAILINFO: NzySSbD1GC1pcVD57Xnya8DhHHMG1EvHVQuHE+tByQDsplbVpFv95635k00Tx6
 7Ltk46lYiNJjMJQ/Ae2T4zbFSjdvflu4hZZw2yjkaJalpKIWFu7ctbPPuR0zBnKwG9gsEjwtdvck
 w/xajG1/trkDFoGPA8wCRSh90pSm9jja+dsd9HwTlwT7q8GF3PtRdGThvbAAUCMvNJYIYSYlUJuZ
 qy0x8fmw8qX3UzBCQQQxaL1pA0VwB/JxRgcjW8flpxqolpFL7IZ0+jAQrDs/0dzmT0EcyQSlBAb4
 rdD1J/Nbdgv084WH5iV5QrnxvJOK4VVPocaIig6hFMSDx/Qf54StdnBEKpNd2xWrWHXnm9Elnk70
 vKLVD8mQ0XWZBy4TAiS0NJiVDZIUQ002D7GNCnXcslTw+7WXnjkCASjpooBcPln1w7NefcRNVjZm
 1IgHYryL48cLNOIkFJEP6dHQh/KPrNW2GzePUjwKeQmfUZpHPz2MGGjCqmPuDw5VeGq35B7KMcpt
 nkgPiOikl5Co87qBylIWwr63iDY5XAdj6Rfni5mR9+eupGsf1ifUM/U75HSIIvE46SkbL0irPRJf
 ZdOXJt7bTHuDM9Ke31Jxh9ibCkmhfR1kh+py1tL1YjOdLD9QuYW3lxrywLS3ZTO5FEtPi0JUf42J
 eezdUs5vKAtIov20MTZa1w+5g0X6Zi/VqeKhX0V9F1rNsSRmLjK8Bxdq16cx9GFazSf29NkfjgDY
 vPVd/L6uOTuP/JnV7qmJPyjvY/9lAAS8Z4wjL8ehtwuGGC7t/IhjJppiU3/Gh26DEQYjiDo4pHpJ
 m7hUA6IjoZqJoF3HxIftRe3roqFOUXmKHUr+43twyoEGzOwOHQFIyZyRU+ooRtfbvWMnzbkSEU8X
 V2QAv7+BBZeD8Ikbnlbu6hACFx+HkOtDNbbmQwJs9Iwi/7N5oCrSMGR3pTQhxCvCTBFoKsWXcQtl
 tzbpl7o/C5Idoxrs44Cw+VzJxsUJiF08UCL9LDQ7AN8UXPvC+FvFOuETwJzgiWyJmo8EWIzl3wee
 0R2CY01c6gI+SvtLSyZJ5G/RSxJQGfxCJimwS/03tuAbdr/HobcYlxRlWE7q+r1wcrDTlNi9nJRW
 ByVq1kBwUkDhwOk4p9/FWDMTJo8kJlVtunB8uZVtFKwcZqsQYLawDXc4vSt8ww2YUrUMXHIRa+JH
 VDKEtlYoiyQVi6Ew==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v3 3/6] dt-bindings: backlight: add VIEWE I2C backlight binding
Date: Wed, 25 Nov 2026 10:11:24 +0800
X-OQ-MSGID: <20261125021127.1430-4-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125021127.1430-1-3066883572@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
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

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../leds/backlight/viewe,i2c-backlight.yaml   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
new file mode 100644
index 0000000..9be4bc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIEWE 7KF82 I2C panel backlight
+
+maintainers:
+  - Hefei <3066883572@qq.com>
+
+description: |
+  I2C backlight MCU used on the VIEWE 7KF82 DSI module. Protocol is device
+  address 0x45, register 0x86, brightness 0..255. A discrete MCU part number
+  is not exposed on the FPC silk; the binding is therefore keyed to the
+  module.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: viewe,7kf82-backlight
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@45 {
+            compatible = "viewe,7kf82-backlight";
+            reg = <0x45>;
+            default-brightness = <200>;
+        };
+    };
+...
-- 
2.55.0.windows.5

