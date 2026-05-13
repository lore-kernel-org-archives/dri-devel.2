Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE50ECD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8240910E309;
	Wed, 13 May 2026 13:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vZolVgoY";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCAA10E309
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:17:59 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D29322A27;
 Wed, 13 May 2026 15:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778678269;
 bh=o2udw3Crr9J1QuXaXPV5drvL6Y5aZAKT/0GYJ/rqNtE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=vZolVgoYklIUglijceeQe7Fu95R4gzz0omMRLvGmJKSseg1AWtCVgQQRlnokoqGt6
 TO9GUBGql3/ZH8TAptGhMUtEztqs7mIbRLNxEpphiaNQiJShorIoxdtsAmceDGpzh8
 d703xckHqdq4AUm74fCWbGSeA3uHVujdCDDUtXHw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:17:24 +0300
Subject: [PATCH v2 02/16] dt-bindings: display: ti,am65x-dss: Simplify binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-beagley-ai-display-v2-2-9e9bcefde6bc@ideasonboard.com>
References: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
In-Reply-To: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4169;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=o2udw3Crr9J1QuXaXPV5drvL6Y5aZAKT/0GYJ/rqNtE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHn80Ad+XRSTUuelDFgjSErBUG8JbAIrPKQ2y
 FVOufLshO2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR5/AAKCRD6PaqMvJYe
 9XrOD/4icJtb8qOGFJrTWSOhePdRV2E6qdo5J0a8UujWjVBjSUfNEFtlMOcV0AgYOeRyQTrc3Ah
 ar1In2AgwcjYrHMowZSy2myjcyzQ1hu0venSiUr51DLTIxOet0fn84RVHWhqke0L2k2i9Z9GGTi
 vPdT3xu2nkR1sr9sDysF7ETxMXfrvjsLpD6MBsDNZ9NgYgvSbCYc3kAPK15UQEM8Z7JVM4lk/yd
 H5+A2SwQhDZXxRAKrLkjtSm0X4/4gbD0ckU7q3zn8MYu7UgR2PG9SCgLV/RvzZtrJ3T4vrR91Yp
 Wf4gv2As+NxoipQgLH90FhGAuLm/upzygvhbQ2SMNdQIW+gd1hldBZpYMQhXLsqVAyTGK2fu6fK
 QNRKGmgLqx+DYPm+X9kVf7yGWzP+zn/K8no3VDGnfCNTn5x+Um7o5jkohuKNEKyCXZPEq6sf1gc
 UDeMy+6qS8EnC/XwsyII/UBII/OFsj1ETr4snHrj9DAFMofJHajzXlXtC7t9BP7HUu/x0qUOhbj
 wqAsavkKjtOzvVkZKaXNkDNn8DUGClcTZn3F9KMHKpRSJon05wgKHUSiwIv5Sr9bzNjLHGuwBCV
 98lEEvYOcIGmSjNiKV663ey85kQ0sIWXF8M4OzFYkdOYRsmCHymwKNfyoKHEK5vCgXnSJLgwtYG
 ISgZ0zsH+RwiFjA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

In principle the DT binding for the DSS IP should mainly cover the DSS
IP. The current binding also covers the SoC integration topics outside
the DSS, mainly via the endpoint related rules and descriptions.

A more recent SoC, AM62P, has two instances of the DSS IP, and while
both DSS IPs are identical, they are integrated slightly differently
(e.g. which DSS output goes to an in-SoC DSI bridge, which goes to
DPI pins, etc.).

To make the bindings usable for both DSS instances, relax the binding
slightly: remove the explicit endpoint rules, and generalize the
descriptions.

Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Tested-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../bindings/display/ti/ti,am65x-dss.yaml          | 55 ++++++++--------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 75d9640398f0..588d72d4ec0d 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -12,12 +12,21 @@ maintainers:
   - Tomi Valkeinen <tomi.valkeinen@ti.com>
 
 description: |
-  The AM625 and AM65x TI Keystone Display SubSystem has two output
-  ports and two video planes. In AM65x DSS, the first video port
-  supports 1 OLDI TX and in AM625 DSS, the first video port output is
-  internally routed to 2 OLDI TXes. The second video port supports DPI
-  format. The first plane is full video plane with all features and the
-  second is a "lite plane" without scaling support.
+  The Display Subsystem (DSS) used in e.g. AM65x and AM625 SoCs has two output
+  video ports (VP) and two video planes. The integration varies from SoC to SoC,
+  affecting the routing of the video ports.
+
+  The first plane is full video plane with all features and the second is a
+  "lite plane" without scaling support.
+
+  On AM65x, the first VP has an integrated OLDI TX, thus the first output port
+  is OLDI output. The second VP is routed to external MIPI DPI pins.
+
+  On AM625, the first VP is connected to two OLDI TX instances, and the second
+  VP is routed to external MIPI DPI pins.
+
+  On AM62A7, the first VP is tied off in the SoC, and the second VP is routed to
+  external MIPI DPI pins.
 
 properties:
   compatible:
@@ -85,34 +94,15 @@ properties:
     properties:
       port@0:
         $ref: /schemas/graph.yaml#/properties/port
-        description:
-          For AM65x DSS, the OLDI output port node from video port 1.
-          For AM625 DSS, the internal DPI output port node from video
-          port 1.
-          For AM62A7 DSS, the port is tied off inside the SoC.
-        properties:
-          endpoint@0:
-            $ref: /schemas/graph.yaml#/properties/endpoint
-            description:
-              For AM625 DSS, VP Connection to OLDI0.
-              For AM65X DSS, OLDI output from the SoC.
-
-          endpoint@1:
-            $ref: /schemas/graph.yaml#/properties/endpoint
-            description:
-              For AM625 DSS, VP Connection to OLDI1.
-
-        anyOf:
-          - required:
-              - endpoint
-          - required:
-              - endpoint@0
-              - endpoint@1
+        description: |
+          AM65x: OLDI output from video port 1
+          AM62A7: Not available, tied off inside the SoC
+          Other SoCs: Parallel video from video port 1
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description:
-          The DSS DPI output port node from video port 2
+          Parallel video from video port 2
 
   ti,am65x-oldi-io-ctrl:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -168,11 +158,6 @@ allOf:
     then:
       properties:
         oldi-transmitters: false
-        ports:
-          properties:
-            port@0:
-              properties:
-                endpoint@1: false
 
 required:
   - compatible

-- 
2.43.0

