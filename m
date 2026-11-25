Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E3606A335
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OfmTAq/h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D7D10E8B1;
	Wed, 25 Nov 2026 02:42:44 +0000 (UTC)
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com
 [203.205.221.209])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332F410E8B1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795574552; bh=o2ZBOBSK4J6IpmVXYBOJZpEDX+16cuL5L8cVT4NeqK0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OfmTAq/hSZktBWJJmk23Z6EkJvP4bDGrZj5BydV9eVSJ7QJyPqxxCKWfqP292eYQ7
 BfuMexWS15UrZIDkywllQKX9Wer9/lqb9kJiR22yNMAUhbTjL5tKHLQgoRnEPrjPnV
 aZ8Vzavf/oZh54XSpXui6YDMryy5ZdvF1v7THy4E=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id A9B394D4; Wed, 25 Nov 2026 10:42:27 +0800
X-QQ-mid: xmsmtpt1795574550t42d4g49m
Message-ID: <tencent_65A800E3961F185694DF3284554F14BFAD08@qq.com>
X-QQ-XMAILINFO: OZ2MtRmBbS53QTDtoG5ja4yZCowRkSPMV0ca++xAPCZicfMbsGLt0mtfiHI0l0
 P8fziz7431EAbSkLp3CkSId1EGarw1icPIYsvmAIneV6NrB/r2uIZHog7eSWglwKDSHQJxiOouVU
 CZgF5WBXuFv+WUOOPOzkY3zL2JAFDwXpqnkydbNOEBJOedEFXMlLayOgnyK9jTGKZCZYmwvCbFrl
 Wu9Ct9Ko092srZiSUrK4pJgmvnohLlznQivhwTy9SfMQmblhWwwbNooiz4v3YDjLWgEJjQidBmXA
 rX4j7+a3j2p25Vv9e3gvpIvx4kZLlIU5NPW07kDfWNR/+pUwomgfO64xRuIGHINuV4/xoi8JZcTR
 foOi+9Xlzfz4lgOJFzV5QJWpWAuQVAgK71yL/7C6C1GDE6bBHCp4M+DVP2WEiTFkeXeRvklN66NX
 lZcVQcl3RTGwLsOvQZcvKHRuB/9PAx1wrbZhYC4IBmKTDgzBQOdwppYfUiW7edN/UFk6hZq8cZ2u
 EmxxsDljrsd0aHP+UXk4RQHNbTuZAzmwFV0fY4szBF0K+2rTWRhSTH5MVlkpscfRaBjUTaMwi86X
 9IX8be6W/8XTsZRmOdmWvdOxbVxhM8e2i4lgPNG8ZFviajMYyUKAaKKzDlmxCjO9rRBwgFsIFiHA
 q5WlIstrNeKXiAtAc0DrAi6okPhGTJNalAnA05UL5+bNahJhHQaj/vC9FhxtVZHr6YEAHVi8fuWd
 L8we/qPa/uur2mhIVj3ZgI86CN8dbBRBNkkcIi7UKf6abVZsFsAXyWNxW/99cB3rTEDE/UzddrWX
 +gh8010csdFoo6V6y960DkDcSUEOXuS6HLs+wC08uc+FRd3+vKIXq3ItfwgvtCOJ2GCQ400jIx1L
 2XZg/7aSbaseGBk/bMqBfFf8p4OftaQH5ghWxS5f5B9yaKq7Uei8cnlr48B/IGZ64k+fpx/4B3p0
 WrsAcr3iX0Fv2LYQh0AvqUe1B74UJS7aAMxOh0HMSLNimHkRq0cAwq2IIU4oQSE+39FUpbgE1p/1
 TvUy2LTh86e+GsujQ2yCBV0aYNrWsrQtgAa+Biq3cSJeh/9gOvBoOqpxpFVYFbDmZ94PUbsDQ0Eb
 jZlRPECH4oWH8SuaFwaSWvL64AVqH8dPdc3tiN7mPJQVPF+TzOGrgFHUVWpN6x5jg0O2MaGWWsNs
 egAyr525SVseM7Fg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v4 3/6] dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
Date: Wed, 25 Nov 2026 10:42:23 +0800
X-OQ-MSGID: <20261125024226.1293-4-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125024226.1293-1-3066883572@qq.com>
References: <20261125024226.1293-1-3066883572@qq.com>
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

Document the I2C backlight MCU on the VIEWE 7KF82 module
(address 0x45, register 0x86, brightness 0..255).

Signed-off-by: Hefei <3066883572@qq.com>
---
 .../leds/backlight/viewe,7kf82-backlight.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
new file mode 100644
index 0000000..e65aa4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/viewe,7kf82-backlight.yaml#
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

