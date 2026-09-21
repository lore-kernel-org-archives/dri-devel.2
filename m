Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A41CC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A00E10E58F;
	Mon, 21 Sep 2026 23:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EziB2wZY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749C810E58F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 23:28:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71DF5600CB;
 Mon, 21 Sep 2026 23:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E6F1F00899;
 Mon, 21 Sep 2026 23:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790033283;
 bh=EkOF2OKm9prgMnT5W8OmhhbFvcCajkN61ox3piMn6x8=;
 h=From:To:Cc:Subject:Date;
 b=EziB2wZY5ldb6jGtQfjR5xqLKJW8nUkve3p0mr5LX8lubAJxvPMN7Yt48G9NkbaA0
 PcEGdUKG1Q/jUDGSbx7GfDUR2PBEdFcNu7K1SYXRMXW0oOYSsDheBnDsoYdnzvIpjw
 d2roMLD8emkcB7flPaJA2/G6PHqRmfr35b8zZC7nOXE2za+ELroihhZkmshW1mfHmR
 yb5J17j+HpaT+5O8+qb25JVN5XzFU8qxU901x+hmFmKwMHs0R6hoLHo18f0prJ42at
 i86kCaAhTrCBAyQxpWTnv6n1Rz0skOlAttZ9m0aQCrskh/m1++TxuwTfal9ytVKSr8
 3kipa4sxzlIXw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpu: Allow Hi6220 Mali resets
Date: Mon, 21 Sep 2026 18:27:58 -0500
Message-ID: <20260921232758.3136548-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Hi6220 Mali nodes provide both ao_g3d and media_g3d resets. Require
those two resets and their names for the Hi6220 compatible. Other Mali
Utgard nodes have at most one reset and do not use reset names.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/gpu/arm,mali-utgard.yaml         | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index c8d0d9192d92..d68fe8c7d010 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -112,7 +112,13 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: ao_g3d
+      - const: media_g3d
 
   operating-points-v2: true
 
@@ -130,6 +136,23 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hisilicon,hi6220-mali
+    then:
+      properties:
+        resets:
+          minItems: 2
+      required:
+        - reset-names
+    else:
+      properties:
+        resets:
+          maxItems: 1
+        reset-names: false
+
   - if:
       properties:
         compatible:
-- 
2.53.0

