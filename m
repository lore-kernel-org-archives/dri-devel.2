Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B764CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2537E10E3C6;
	Mon, 15 Jun 2026 12:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="Sdtzkth+";
	dkim-atps=neutral
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Mon, 15 Jun 2026 12:14:03 UTC
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9204510E3C6
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 12:14:03 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 2026061512035839fb20f26500020702
 for <dri-devel@lists.freedesktop.org>;
 Mon, 15 Jun 2026 14:03:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Xz6nCVPweiRhv904vuI6Sdj8uMkOdjwCRi1d8097nvw=;
 b=Sdtzkth+3PIHjyY2UXv2FeZV0gnPita2a3sykTGPaSIBNta968LbZmEaA4nmrUTcy0/wMp
 q6t+fzXVizcDmEbSwVf2WuYZomYaAoOHYYJomCmzPwY3lQU+Ff45k9eA4QSpMOx4muTyihPY
 Vr1RnCIaRGB+TKU3otTUbredSgsw8Rr3eOLttGbVP5XvewKRsrWtaQhayQVHpagrAMx6R+h/
 n3R6d5LyyQvCPsenONGLWFyPErOBcf7mLZoQozffUIqmKHh7sJ0Xw3fBzeCwOfguTeOMvOX0
 vGkxMz2CXB9sHoPepUExwKo4zV8yzyI5PoRDbn5LjMyuEhS8Az5vnyEA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-leds@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 Andrew Davis <afd@ti.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: backlight: ti,
 lp8864: Add backlight class properties
Date: Mon, 15 Jun 2026 14:03:47 +0200
Message-ID: <20260615120353.3409035-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260615120353.3409035-1-alexander.sverdlin@siemens.com>
References: <20260615120353.3409035-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Extend the TI LP8864/LP8866 device-tree binding to support backlight
class properties alongside the existing LED class child node.

This is a preparatory change for converting the LP8864 driver from a
pure LED class driver to additionally register a backlight class device,
motivated by a use case on a hot-pluggable segment of an I2C bus. The
generic led-backlight driver (led_bl.c) is a platform driver and thus
inherently non-hotpluggable, which makes it unsuitable for hardware
topologies where the backlight controller resides on a hot-pluggable I2C
bus segment. By making the LP8864 driver itself register a backlight
class device, it becomes a native I2C driver that properly supports
hot-plug/unplug events.

The binding is updated to:
- Reference backlight common.yaml at the top level, making
  default-brightness and max-brightness valid optional properties
- Make the "led" child node optional rather than required, since the
  backlight class device is now the primary interface
- Use unevaluatedProperties instead of additionalProperties to properly
  allow properties inherited from the referenced common schema

The LED child node is preserved for backward compatibility with existing
device-trees. No in-tree device-trees reference this binding, so this
change has no impact on existing mainline users.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 .../bindings/leds/backlight/ti,lp8864.yaml       | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
index d44232d462bde..11d7e3840c6fb 100644
--- a/Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/leds/backlight/ti,lp8864.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Texas Instruments - LP8864/LP8866 4/6-Channel LED Driver family
+title: Texas Instruments - LP8864/LP8866 4/6-Channel LED Backlight Driver family
 
 maintainers:
   - Andrew Davis <afd@ti.com>
@@ -21,6 +21,9 @@ description: |
     https://www.ti.com/product/LP8866-Q1
     https://www.ti.com/product/LP8866S-Q1
 
+allOf:
+  - $ref: common.yaml#
+
 properties:
   compatible:
     const: ti,lp8864
@@ -36,9 +39,15 @@ properties:
   vled-supply:
     description: LED supply
 
+  default-brightness:
+    maximum: 65535
+
+  max-brightness:
+    maximum: 65535
+
   led:
     type: object
-    $ref: common.yaml#
+    $ref: /schemas/leds/common.yaml#
     properties:
       function: true
       color: true
@@ -50,9 +59,8 @@ properties:
 required:
   - compatible
   - reg
-  - led
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.54.0

