Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE98C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A2210EF4D;
	Wed,  1 Jul 2026 12:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dHDcqsed";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A7610EF4C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908450;
 bh=D8xSYkpIyl50Azpbz1Ovm3/ITMW8MoCD/TiEbkzX/jw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dHDcqsedFd/kZVRR/4ve7GtOgmycdE7Op4ya+bnevyvQ4lEMNiPk8jVTkC7ZgK2dB
 Qf6PS8wvdQMpISu4N7Kx8hUhWl3ngEECh95NDu7LdsRdiynLKL0Qfx0aOrQxGVv1T+
 zg5UmZRT7D0qozy4TVFPr+tGn8uHAAmUH9mzCVCZNVeAok8t+7/XgGIAXdNStFFHWs
 DKKPwvTdEDXCGzP/ZUM0aMow6xmbg0NGKwHR37z9LFQ70L5HMa/guK9XMTJb97dGJB
 FHcJczU+HF6PBSSTlbF4KoDX3npb9AWdoulnD/x3pxJEVO98UvYOEHRNgCPqNxQfra
 RDfs0mhzLLisQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 54A5817E0CA2;
 Wed,  1 Jul 2026 14:20:49 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 andi.shyti@kernel.org, djakov@kernel.org, broonie@kernel.org,
 jitao.shi@mediatek.com, ck.hu@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: [PATCH 3/6] dt-bindings: display: mediatek: Allow trigger-sources on
 relevant HW
Date: Wed,  1 Jul 2026 14:20:40 +0200
Message-ID: <20260701122043.19612-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122043.19612-1-angelogioacchino.delregno@collabora.com>
References: <20260701122043.19612-1-angelogioacchino.delregno@collabora.com>
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

Most of the MediaTek Display Controller hardware sub-IPs need a
specific (and reserved to them) MuteX trigger.

Since now MuteX is a trigger source, allow specifying trigger
sources in all of the display IPs that support one.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,aal.yaml     | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml   | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,color.yaml   | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,dither.yaml  | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,dp.yaml      | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml     | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,dsc.yaml     | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,dsi.yaml     | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,ethdr.yaml   | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml   | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,merge.yaml   | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,od.yaml      | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml  | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml     | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,padding.yaml | 3 +++
 .../bindings/display/mediatek/mediatek,postmask.yaml           | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml    | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,split.yaml   | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,ufoe.yaml    | 3 +++
 .../devicetree/bindings/display/mediatek/mediatek,wdma.yaml    | 3 +++
 20 files changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
index 4bbea72b292a..41d60a3d8007 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
@@ -55,6 +55,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: AAL Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index 5c5068128d0c..e148aa57b1b9 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -47,6 +47,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: CCORR Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
index 5564f4063317..7c0985d0f9ea 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
@@ -57,6 +57,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: COLOR Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index 891c95be15b9..85a1746965b9 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -45,6 +45,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: DITHER Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
index 3a752a99949a..d8cfac0326ba 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
@@ -42,6 +42,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  trigger-sources:
+    maxItems: 1
+
   interrupts:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index eb4f276e8dc4..f5be6c1e4b0e 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -109,6 +109,9 @@ properties:
     items:
       - const: dpi
 
+  trigger-sources:
+    maxItems: 1
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
index c8b3e86943e4..4863db6aba6e 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yaml
@@ -43,6 +43,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   mediatek,gce-client-reg:
     description:
       The register of client driver can be configured by gce with 4 arguments
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
index b5cdfe0eaca4..a9793b274070 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
@@ -73,6 +73,9 @@ properties:
     items:
       - const: dphy
 
+  trigger-sources:
+    maxItems: 1
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description:
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
index 98db47894eeb..89370690ee71 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
@@ -100,6 +100,9 @@ properties:
       - const: gfx_fe1_async
       - const: vdo_be_async
 
+  trigger-sources:
+    maxItems: 1
+
   mediatek,gce-client-reg:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
index ec1054bb06d4..4d06085e6014 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
@@ -54,6 +54,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: GAMMA Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
index 3798a25402d3..656df51335b5 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
@@ -47,6 +47,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     minItems: 1
     maxItems: 2
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
index 930c088a722a..c912ae2493c3 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,od.yaml
@@ -60,6 +60,9 @@ properties:
       - port@0
       - port@1
 
+  trigger-sources:
+    maxItems: 1
+
   mediatek,gce-client-reg:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: describes how to locate the GCE client register
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
index ac0d924a451b..326223b36112 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
@@ -40,6 +40,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: OVL-2L Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
index 4df5c7b410c6..dc200068d617 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
@@ -61,6 +61,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: OVL Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
index 86787866ced0..9dac0319dd60 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
@@ -34,6 +34,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: Padding's clocks
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
index fb6fe4742624..caef5194371f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
@@ -40,6 +40,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: POSTMASK Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
index d914c06640df..13deb7c87ee6 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
@@ -60,6 +60,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: RDMA Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
index 4b6ff546757e..7307a50fa30f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
@@ -40,6 +40,9 @@ properties:
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
     maxItems: 1
 
+  trigger-sources:
+    maxItems: 1
+
   mediatek,gce-client-reg:
     description:
       The register of display function block to be set by gce. There are 4 arguments,
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
index 036a66ed42e7..31e0863dd815 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
@@ -39,6 +39,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: UFOe Clock
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
index c3ed867d058d..3e6b346baa11 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
@@ -45,6 +45,9 @@ properties:
       the power controller specified by phandle. See
       Documentation/devicetree/bindings/power/power-domain.yaml for details.
 
+  trigger-sources:
+    maxItems: 1
+
   clocks:
     items:
       - description: WDMA Clock
-- 
2.54.0

