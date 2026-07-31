Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED98C5516F
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A6210E2AB;
	Sat,  1 Aug 2026 07:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=elsta.tech header.i=@elsta.tech header.b="uFIKBSaB";
	dkim-atps=neutral
X-Greylist: delayed 366 seconds by postgrey-1.36 at gabe;
 Fri, 31 Jul 2026 10:52:43 UTC
Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C468F10F213
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 10:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.elsta.tech (Postfix) with ESMTP id ACE5D8D53B3;
 Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Authentication-Results: mail.elsta.tech (amavis); dkim=pass (2048-bit key)
 header.d=elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id iVg-pCXs99Nj; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.elsta.tech (Postfix) with ESMTP id 769268D53B4;
 Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 769268D53B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
 s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1785494793;
 bh=a9WFruF+jsbK+yzittr0qjwlm/b207TqVHPmsDedzSA=;
 h=From:Date:MIME-Version:Message-Id:To;
 b=uFIKBSaBP7PGdlR3G0JgPThh/DPXGqlmxk3c/VId7bQwoQ+WtAXzbl/PTo3tKjZjc
 fv1YYwQn60YR5wOobZN0GZhz2o2VbyMRwOd0iOvDNfHLXWLGmNaBGlP8Nz8cS2GmNX
 heFH/VMt/0WS5YKUjqkong5mzgJXp7VEtq1VINmDM11ltBWabfuDMRJbJUp72MThjm
 R5314p1iP0TG9AhBW8ieFUpRMYSYYB2Ch0GIR7/5wBDsgP1PPUOnwF3yTWr/mf21Yw
 Le1TWtkWrbk3c4Kp9x15F6a2ZMqSqp3Iefp5Gmn642oBCiwc5VmnpJhCumiaEB/hbX
 Xw+xmzzYLvLDA==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id PaCv2EAx1WZP; Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
Received: from [127.0.1.1] (unknown [172.31.0.125])
 by mail.elsta.tech (Postfix) with ESMTPSA id 3EA758D53B2;
 Fri, 31 Jul 2026 12:46:33 +0200 (CEST)
From: Jakub Turek <jakub.turek@elsta.tech>
Date: Fri, 31 Jul 2026 12:46:17 +0200
Subject: [PATCH 2/2] dt-bindings: display: solomon,ssd1307fb: add SH1107
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-feat-sh1107-v1-2-e10977f76e6b@elsta.tech>
References: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
In-Reply-To: <20260731-feat-sh1107-v1-0-e10977f76e6b@elsta.tech>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jakub Turek <jakub.turek@elsta.tech>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

Update the device tree documentation to include "sinowealth,sh1107" as a
recognized compatible string.

Signed-off-by: Jakub Turek  <jakub.turek@elsta.tech>
---
 .../devicetree/bindings/display/solomon,ssd1307fb.yaml  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 153ff86fb405..6b17a701bbaa 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -22,6 +22,7 @@ properties:
         deprecated: true
       - enum:
           - sinowealth,sh1106
+          - sinowealth,sh1107
           - solomon,ssd1305
           - solomon,ssd1306
           - solomon,ssd1307
@@ -140,6 +141,22 @@ allOf:
         solomon,dclk-frq:
           default: 5
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sinowealth,sh1107
+    then:
+      properties:
+        solomon,width:
+          default: 128
+        solomon,height:
+          default: 64
+        solomon,dclk-div:
+          default: 1
+        solomon,dclk-frq:
+          default: 8
+
   - if:
       properties:
         compatible:

-- 
2.34.1

