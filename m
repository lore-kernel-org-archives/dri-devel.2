Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F72C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5BA10F36E;
	Thu, 10 Sep 2026 08:19:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44B510F36B;
 Thu, 10 Sep 2026 08:19:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6BA9600C8;
 Thu, 10 Sep 2026 08:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151421F000FF;
 Thu, 10 Sep 2026 08:19:19 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anh Nguyen <anh.nguyen.pv@renesas.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/3] dt-bindings: gpu: img,
 powervr-rogue: Document R-Car V4H and V4M support
Date: Thu, 10 Sep 2026 10:19:09 +0200
Message-ID: <1c2771f8882cde0fde694b9f5aae50c02a2ae4cb.1789028076.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789028076.git.geert+renesas@glider.be>
References: <cover.1789028076.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Renesas R-Car V4H SoC integrates an Imagination Technologies IMG
AXM-8-256 GPU, while R-Car V4M integrates an Imagination Technologies
IMG BXS-4-64 GPU.  Both variants can generate 8 interrupts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/gpu/img,powervr-rogue.yaml       | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index e9218e0f363d1848..9bea037602c137a7 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -35,6 +35,11 @@ properties:
           # work with newer dts.
           - const: img,img-axe
           - const: img,img-rogue
+      - items:
+          - enum:
+              - renesas,r8a779g0-gpu
+          - const: img,img-axm-8-256
+          - const: img,img-rogue
       - items:
           - enum:
               - thead,th1520-gpu
@@ -44,6 +49,7 @@ properties:
           - enum:
               - ti,am62p-gpu
               - ti,j721s2-gpu
+              - renesas,r8a779h0-gpu
           - const: img,img-bxs-4-64
           - const: img,img-rogue
 
@@ -70,7 +76,8 @@ properties:
     minItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 8
 
   power-domains:
     minItems: 1
@@ -173,6 +180,19 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,r8a779g0-gpu
+                - renesas,r8a779h0-gpu
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.43.0

