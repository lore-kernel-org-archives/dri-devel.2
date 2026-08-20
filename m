Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89FEC5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB55210E22A;
	Thu, 20 Aug 2026 18:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lTARxJLk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CS+3Os0J";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D5810E22A
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:55:17 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hQt0z5PGYzMlKM;
 Thu, 20 Aug 2026 20:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787252115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dBf226F5J7L2G3nMkBqVcELYd3BwALU/nWm1qUUhSRs=;
 b=lTARxJLkQM3jX9Wmx8Vb7oSi3/lSwtHTKxhWUJyYLlMyP+C7l2GFRj5V3knHO5f27JwF4z
 vPczfUL5W0TSM4NMrDgyM2Z4A6ULC0FR+p4Ttck+cKA/IHi8ihl5/8DFpV/Nm48Ah43WsY
 k2NvA5fse8tW0UR6DOR3WE+NbHusufIezZmnV0mEegQcETZ9EL5aMFqTeVno9uGt2/nuZF
 yzBDvr8LoGo00uSCcIaiL4b5XeQg2fKT0mLz2EiMqIEfwY7FlR+HRMlPPGPZxwjyKo3sXY
 O3/yLMYbgH0mBX6NOtRIAVGaIx7UGVML+XaXCXYm8ZwVPtXhNQYYf4Vt74MA0A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CS+3Os0J;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787252114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dBf226F5J7L2G3nMkBqVcELYd3BwALU/nWm1qUUhSRs=;
 b=CS+3Os0JUcOk7RYqWvxIFjinh1VF2oYhMhkG9Klu1BkLEBOBw/GMgyienCY8oPOJaxu9hQ
 wJgfVOew0dEnP5KWfMn7KXlTex3MqRvikBf+F9jYer0NzBppi1B21kNf0OI5GWQSs5Q3yR
 uvmodV+0i5DWmR3l8vucbuKzgHI9ddqrNFxABhpyTAy7wg44vgd/wBXpGEP5XBSA4Y4xle
 gMb+lSmTjIvTkmN467mypbmXOjbCMMyrEqtRXq9Ug94HsNHKfzHwWJUBFctmpSX2ceUnXt
 ZGcQJXPB4HxvAwQ65w/eBPwh/FK5jvy1t6/dDzzDRSHewa34WcKSKShOfH8acA==
To: dri-devel@lists.freedesktop.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: display: panel: Document 10" Raspberry Pi
 Touch Display 2
Date: Thu, 20 Aug 2026 20:54:27 +0200
Message-ID: <20260820185506.84448-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: df6b2c1fc4a1281fe41
X-MBO-RS-META: 7hh6gdmyeaxzz17b8rgd5q1ssxdpz8bs
X-Rspamd-Queue-Id: 4hQt0z5PGYzMlKM
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

Document the 10" Raspberry Pi Touch Display 2 MIPI-DSI TFT LCD panel.
The panel is based on the Ilitek ILI79600A controller.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Extend existing ilitek,il79900a.yaml document instead of introducing
    new one. Note that the il79900a should likely be il_i_79900a, but the
    binding document already shipped in Linux 6.19.y , so this can not be
    fixed anymore ?
---
 .../bindings/display/panel/ilitek,il79900a.yaml     | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
index 02f7fb1f16dc7..f8644e9a4478d 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
@@ -14,10 +14,15 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - tianma,tl121bvms07-00
-      - const: ilitek,il79900a
+    oneOf:
+      - items:
+          - enum:
+              - raspberrypi,dsi-10inch
+          - const: ilitek,ili79600a
+      - items:
+          - enum:
+              - tianma,tl121bvms07-00
+          - const: ilitek,il79900a
 
   reg:
     maxItems: 1
-- 
2.53.0

