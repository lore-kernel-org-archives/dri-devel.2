Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE7606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwBvG3Ku
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1549910E5CE;
	Mon,  9 Nov 2026 18:48:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4A510E5CE
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 18:48:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9799061133;
 Mon,  9 Nov 2026 18:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39181F0089F;
 Mon,  9 Nov 2026 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794250091;
 bh=wzcq643kxqzm6dmiI//QkyvyRvgf5SDiG72cWiaVszc=;
 h=From:To:Cc:Subject:Date;
 b=ZwBvG3Ku4ZEwKSKey17VtGpJlOGR7qSBiroi5pBDv8Aw5R1tZ2MCU/eWgnF/33DS5
 h/zqFPVc3LQLug14ppeQv8CNu8NpLAY2BCrW4zPdB/CQ/0Bzs94BOHpadBvfwE+EU/
 SOcbuPHL3VQouyX0LpqkU8K3pTzhsrIbX3cNouXEzVs900C3ZbuzJUcGAbxZOUTULy
 tcOVZ8yYFL5Xu5yeijdEdnBtUBjsAulBNpkYv0OfITgqxP6nmRLYZmx07/j7w59dtp
 fVFxaE4Is5/s6PjIETaMJOSGL6/Z2v3G4eHnueTyipoMnLHhvtS3Za2Nuqty0uefsz
 2lsBotMH0L9Jw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Yan <andy.yan@rock-chip.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: rockchip: Allow single 'port' node for
 DP input port
Date: Mon,  9 Nov 2026 12:47:58 -0600
Message-ID: <20261109184759.467215-1-robh@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Existing RK3399 users have only a single 'port' node. This was common before
connector nodes were defined. Allow for this since there are already stable
users.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../rockchip/rockchip,rk3399-cdn-dp.yaml      | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3399-cdn-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3399-cdn-dp.yaml
index 195f665970bf..425b27346132 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3399-cdn-dp.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3399-cdn-dp.yaml
@@ -63,7 +63,12 @@ properties:
     $ref: /schemas/graph.yaml#/properties/ports
 
     properties:
-      port@0:
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output of the CDN DP
+
+    patternProperties:
+      '^port(@0)?$':
         $ref: /schemas/graph.yaml#/properties/port
         description: Input of the CDN DP
 
@@ -74,13 +79,11 @@ properties:
           endpoint@1:
             description: Connection to the VOPL
 
-      port@1:
-        $ref: /schemas/graph.yaml#/properties/port
-        description: Output of the CDN DP
-
-    required:
-      - port@0
-      - port@1
+    oneOf:
+      - required:
+          - port@0
+      - required:
+          - port
 
   power-domains:
     maxItems: 1
-- 
2.53.0

