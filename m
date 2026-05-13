Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D80ECD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1E610EE77;
	Wed, 13 May 2026 13:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WE4N4JwJ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A26110EE74
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:18:02 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33BF32B57;
 Wed, 13 May 2026 15:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778678273;
 bh=AFOi9aqsSdBtds83+Z7S7alO1ZnD/XbMhJoZjnM2lgY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WE4N4JwJ/CQmzHVnMY1ouYvjplftL/miJzsn5ez5up0er3bTncNR4LQDS4jwXS9yj
 /KAJJHesQjVElBQDPBMtnYmCiQsdzyUytlcYDvLQmAzAOKdfvgZ3aR7QPic4l169wF
 qJF+4sR4iMDYTu5CelXQL+JLZV2xozdQTUiB1x3k=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:17:27 +0300
Subject: [PATCH v2 05/16] dt-bindings: display: ti,am65x-dss: Add AM62P DSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-beagley-ai-display-v2-5-9e9bcefde6bc@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3555;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=AFOi9aqsSdBtds83+Z7S7alO1ZnD/XbMhJoZjnM2lgY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHn9cxR/VbmIrYANitAxQv0Ha5gKb2WLGVSo0
 ic8XtdyLU2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR5/QAKCRD6PaqMvJYe
 9YxAD/9fiOBVzu5i+ANya5HJAdJNnNcQiLsc7JQ36j0d9UkEw5FPHOzwWAQ84Kd5/dPmNYZ0zaF
 kHYzIpV5gWqkQBHpUizCbgCct9k/xFKbIvhyO5r5x6ax3Klsbki4syoc5a0h2etruFz4ZoBlf/t
 YVxoYzx1DSn61oBDyOkpgJacz2ukTxpCzde8t2iMD1KKgs7DWsI88wMnNvyrb+5fbgvYPveqzuA
 WMMepPUpvQmZryEdAmRBH42FQ5Ch+Fl4aw6k2G0kZANwc8BTgAzN6nVXkbiMGSt/Dmmcw96Vy+j
 OmNgNEwzngYhLmZJCZabNO6CfMKLflFcTBL4D+dJ6QG+O5NmCoI/k4bWUT2VJTIzRnBkx57PTk5
 FPLscVG2H9b0/EkRsztPa8agqz+ldaCkRC7g6yDXLr7UnhPULwtjA7wolg5zNnj4fOok3vCUHNd
 FJiWsavPY30Qg/OIRTGUFAL/9KenmlINXV9NlMKoawNa8S6rOvGd6/niVigvfUn9I9oWnuC4ubC
 J/sCk8ox9r39N+D1LX27VYK9W9NBCNdiuvJ9UsoTYdybPzCj1/7m36+zKc4sEI0N8141NIIPXcw
 /aU1Tixu6iy1M2lJCMzPU2bbuBjEOOi6gZgE8nvavDe0eITS/Ki4eTGrYqmRS+xPU9JkfAUowI1
 BuyG9E6OCVKdzag==
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

TI's AM62P, J722S and AM67A SoCs contain same implementation of the
display subsystem (DSS). There are two instances of the DSS (DSS0 and
DSS1), each with two video ports (VP) and two video planes.
Additionally the SoCs contain two OLDI TXes (OLDI0 and OLDI1), a MIPI
DSI TX and a MIPI DPI output path.

DSS0 supports:
- VP0: OLDI0 in single-link mode, or OLDI0 and OLDI1 in dual-link or
  clone mode.
- VP1: DPI

DSS1 supports:
- VP0: OLDI1 in single-link mode, or DPI
- VP1: DPI or DSI

The DSI is only connected to VP1 of DSS1, but OLDI and DPI are shared
between the DSS instances. Thus only a single VP can output to DPI, and
a single VP can use an OLDI block. Note that in single-link
configuration OLDI0 can be used by DSS0, and at the same time OLDI1 can
be used by DSS1.

The DSS IP itself is compatible with older SoCs. While we could use
"ti,am625-dss" compatible string, we add a new one "ti,am62p-dss" to be
on the safe side in case the driver needs to do something special for
the dual-DSS case in the future.

Original patch by Swamil Jain <s-jain1@ti.com>

Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Tested-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../bindings/display/ti/ti,am65x-dss.yaml          | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 902ae2122d86..acb7ac635097 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -28,11 +28,38 @@ description: |
   On AM62A7, the first VP is tied off in the SoC, and the second VP is routed to
   external MIPI DPI pins.
 
+  AM62P SoC contains two instances of the DSS:
+  On AM62P DSS0, the first VP is connected to two OLDI TX instances (the second
+  TX shared with DSS1), the second VP to external MIPI DPI pins (shared with
+  DSS1).
+  On AM62P DSS1, the first VP is connected either to the second OLDI TX, or
+  external MIPI DPI pins. The second VP is connected to either the external MIPI
+  DPI pins or a Cadence DSI TX.
+
+  An important note about OLDIs on AM62P:
+
+  There are two OLDI hardware blocks. Each OLDI has certain configuration that
+  has to be done before it can be used. The OLDI blocks get this configuration
+  directly from the DSS block, via DSS registers. However, as a single OLDI
+  block can be used either with DSS0 or DSS1, the source for the configuration
+  changes according to a mux. This mux is set according to the OLDI
+  configuration registers in DSS0. Thus the OLDI control paths change at
+  runtime, and it is not obvious how to structure this in the DT bindings.
+
+  The solution used here is that each DSS node contains the OLDI nodes that can
+  be used with that DSS. Thus the DSS0 node has two OLDI child nodes, OLDI0 and
+  OLDI1, and the DSS1 node has one OLDI child node, OLDI1, so three OLDI DT
+  nodes in total. The two OLDI1 nodes thus refer to the same piece of hardware,
+  and they cannot be used at the same time. The selection which OLDI nodes to
+  use are chosen in the board dts files, so assuming the dts files are correct,
+  no resource conflict can happen.
+
 properties:
   compatible:
     enum:
       - ti,am625-dss
       - ti,am62a7-dss
+      - ti,am62p-dss
       - ti,am65x-dss
 
   reg:

-- 
2.43.0

