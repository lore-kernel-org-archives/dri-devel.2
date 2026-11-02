Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE9606F23F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilReywkt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A0E10EF28;
	Mon,  2 Nov 2026 14:28:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DE110EF28
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 14:28:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4391F437D6;
 Mon,  2 Nov 2026 14:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C661F00A1A;
 Mon,  2 Nov 2026 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793629688;
 bh=uXG5ng9UK2dketrcnTT7J+p4mT8docKS72kpHf0+r7A=;
 h=From:To:Cc:Subject:Date;
 b=ilReywktqKg7UxMpVX3VwvO+FxchoepfEWWl9xM3aIbIGYJTNC//IEhj52mE021e0
 u8JVf7Vm3gCL/vzJT7Jw7LzWoDnLjc2UwTc0o0wTIiGqDoivbNdKjGfKfSZ+hzG3ma
 rOsEb80QHYwOvBIfoqxStgdfQyuPUgcVB8TgoGGb2uDmPMWv0TruIPqA++KQfu+KeQ
 mSASEWsHE2DJphbsEFLqxCq8Mn4QKAzsFLonlyQ3AKTDBFJ7HKyuAdfObBlmY07KK0
 uBEeeGJoXGFY6uLOKOulXLEYpsnaH83vG+kwEU3mHl84605GwuYSgHyBtZaAw/6Qub
 V1IJawuhScecg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: nvidia,
 tegra20-dc: Move 'rgb' node properties
Date: Mon,  2 Nov 2026 08:28:01 -0600
Message-ID: <20261102142802.2742565-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Properties are supposed to be defined in the main schema and not in
conditional schemas. Move the properties for the 'rgb' node to the main
schema.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../display/tegra/nvidia,tegra20-dc.yaml      | 43 ++++++++++---------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
index 69be95afd562..a42bf7ed37a2 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
@@ -77,8 +77,27 @@ properties:
     description: A list of phandles of outputs that this display controller can drive.
 
   rgb:
+    description: Each display controller node has a child node that represents the
+      RGB output associated with the controller.
     type: object
 
+    properties:
+      nvidia,ddc-i2c-bus:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle of an I2C controller used for DDC EDID probing
+
+      nvidia,hpd-gpio:
+        description: specifies a GPIO used for hotplug detection
+        maxItems: 1
+
+      nvidia,edid:
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+        description: supplies a binary EDID blob
+
+      nvidia,panel:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle of a display panel
+
 allOf:
   - if:
       properties:
@@ -105,27 +124,9 @@ allOf:
             - const: winb-vfilter
             - const: winc
             - const: cursor
-
-        rgb:
-          description: Each display controller node has a child node, named "rgb", that represents
-            the RGB output associated with the controller.
-          type: object
-          properties:
-            nvidia,ddc-i2c-bus:
-              $ref: /schemas/types.yaml#/definitions/phandle
-              description: phandle of an I2C controller used for DDC EDID probing
-
-            nvidia,hpd-gpio:
-              description: specifies a GPIO used for hotplug detection
-              maxItems: 1
-
-            nvidia,edid:
-              $ref: /schemas/types.yaml#/definitions/uint8-array
-              description: supplies a binary EDID blob
-
-            nvidia,panel:
-              $ref: /schemas/types.yaml#/definitions/phandle
-              description: phandle of a display panel
+    else:
+      properties:
+        rgb: false
 
   - if:
       properties:
-- 
2.53.0

