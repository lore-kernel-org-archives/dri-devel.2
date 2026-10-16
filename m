Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B543CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3A310E30F;
	Fri, 16 Oct 2026 16:07:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AF310E239;
 Fri, 16 Oct 2026 16:07:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 085B6434B9;
 Fri, 16 Oct 2026 16:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B491F000C6;
 Fri, 16 Oct 2026 16:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792166825;
 bh=EyhMIFki24z/GS7kQ9MxTJlK5fDdy74J09DSaxUb78g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oSiy7S7F/4VWlSrLEKyL8T7zav3l+9kgUofPlfdPeVnZVIL6SOtZQaJE6VFYcbcne
 u5aJq0t3Ep7iW7oTnJFKvH9aBSl62KQ0S/AcdZm8axc4Dtt5e4tdElIyKfUIfZt3vx
 OqwY5h5TcOBQkhWwRT42CpUnVkXd1N7vBC8maYs/IRi8ogF782d0aXvdVQpm2nhA7C
 jz9o3/ipk3gHBGfBT9A+saejHnahRrKRjPjLp31snRs8pMPwtNBDCGE1TdyEHXIIQ4
 iAiKjt82eYacWqbo3OtG5R06//eUNIs+QpVfLK0uZca5lIpClHhQtiWfx+70N4jwHJ
 TAv8ND+khwkrA==
From: Sasha Levin <sashal@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Aaron Kling <webgeek1234@gmail.com>, Diogo Ivo <diogo.ivo@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: gpu: nvidia, gk20a: Require the fuse clock
Date: Fri, 16 Oct 2026 12:06:54 -0400
Message-ID: <20261016160700.3831336-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016160700.3831336-1-sashal@kernel.org>
References: <20261016160700.3831336-1-sashal@kernel.org>
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

The GM20B on Tegra210 often fails to initialize unless the fuse clock
is running while the GPU is powered, and the GPUs on the other Tegra
generations are expected to have the same requirement. Tegra194 already
describes the fuse clock for its GV11B.

Make the fuse clock required for all of them, and list the exact clocks
for each GPU instead of allowing either the reference or the fuse clock
as the third one: GM20B takes the fuse clock after its reference clock,
the others take it after the GPU and power clocks.

The nouveau driver keeps treating the fuse clock as optional, so device
trees that lack it continue to work as before.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/gpu/nvidia,gk20a.yaml | 52 ++++++++++++++-----
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
index 4d856a8b674c5..af0ada6e02557 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
+++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
@@ -39,18 +39,12 @@ properties:
       Regulator for GPU supply voltage
 
   clocks:
-    minItems: 2
-    items:
-      - description: GPU clock
-      - description: Power clock
-      - description: Reference or fuse clock
+    minItems: 3
+    maxItems: 4
 
   clock-names:
-    minItems: 2
-    items:
-      - const: gpu
-      - const: pwr
-      - enum: [ ref, fuse ]
+    minItems: 3
+    maxItems: 4
 
   resets:
     maxItems: 1
@@ -86,6 +80,39 @@ required:
   - reset-names
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,gm20b
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GPU clock
+            - description: Power clock
+            - description: Reference clock
+            - description: Fuse clock
+
+        clock-names:
+          items:
+            - const: gpu
+            - const: pwr
+            - const: ref
+            - const: fuse
+    else:
+      properties:
+        clocks:
+          items:
+            - description: GPU clock
+            - description: Power clock
+            - description: Fuse clock
+
+        clock-names:
+          items:
+            - const: gpu
+            - const: pwr
+            - const: fuse
   - if:
       properties:
         compatible:
@@ -163,8 +190,9 @@ examples:
         interrupt-names = "stall", "nonstall";
         vdd-supply = <&vdd_gpu>;
         clocks = <&tegra_car TEGRA124_CLK_GPU>,
-                 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>;
-        clock-names = "gpu", "pwr";
+                 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>,
+                 <&tegra_car TEGRA124_CLK_FUSE>;
+        clock-names = "gpu", "pwr", "fuse";
         resets = <&tegra_car 184>;
         reset-names = "gpu";
         iommus = <&mc TEGRA_SWGROUP_GPU>;
-- 
2.53.0

