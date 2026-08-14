Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80297C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B8910E58A;
	Fri, 14 Aug 2026 18:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I8wfFn+s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC0E10E18E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 18:17:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B4AD243FA0;
 Fri, 14 Aug 2026 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84001C2BCF4;
 Fri, 14 Aug 2026 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786731445;
 bh=Gv1Ja9rXOy+qt4Q/cn2nHzoCvAUeO/JKq+rbKEBiDXg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=I8wfFn+sv02WU0/0WmnNPNBdd1Q5AreHmD5FS9guoaNreL6Mhsw3UdXlRt68xIY2o
 6ceaWR9rCYzTJIRgxhVdCHuLKzUw8NypcuObNtTw8rumuMJCA4/tL9zPqgvD84PK9u
 jFNY7Oec4ZzWEH4YywXjpJQm7/Qzrwa5cJ9r3/Mlrbkb8k8AQlQZb4A2u5DqRDiybP
 yPUI9t2AN+GSOep5bguo4owgc4h11J/vfGZF3/qoEDIHAmWN5sFfybS6gVlRdnlTD1
 lG0QO7Z2tuS/XWdhIl2nFhuk5AzzFlINxP4iOzQzX1p1i1lskl6S+fzCz5/PPYRosB
 IGDry10yRPZjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 64A0BC5CFCF;
 Fri, 14 Aug 2026 18:17:25 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 14 Aug 2026 13:17:15 -0500
Subject: [PATCH 1/4] dt-bindings: display: visionox,vtdr6130: Add Retroid
 Pocket 6 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rp6-panel-v1-1-111c1aeccf0f@gmail.com>
References: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
In-Reply-To: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786731444; l=1399;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=cQAQT+SLMV+AccWuQQKaYy2+/aNZWvo6kpA1OLjfeeY=;
 b=A+OJcGc0F92v2IjBPJqtFUxJPBwVQP3I5db3lJXiaBz0ehSB6z9WkgxJyWku6MwVq9Xs2tiUp
 Gu2NF5e4thSDn7/DDNVVnVojfvHStxAXVgJgh1TocmUg1RXOynWzqA2
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Aaron Kling <webgeek1234@gmail.com>

The vtdr6130 is a display driver integrated circuit, a common chip used
for various panels. One such panel is used in the Retroid Pocket 6.

The RP6 panel only lists the regulators vddio and vci, so drop vdd as a
required property. The panel is rotated 270 degrees to natural, so also
add rotation as an allowed property.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 .../devicetree/bindings/display/panel/visionox,vtdr6130.yaml      | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
index c99f4146f1bb0..682f30dc9ee43 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: visionox,vtdr6130
+    oneOf:
+      - const: visionox,vtdr6130
+      - items:
+          - const: retroidpocket,rp6-panel
+          - const: visionox,vtdr6130
 
   reg:
     maxItems: 1
@@ -25,13 +29,13 @@ properties:
   vdd-supply: true
   port: true
   reset-gpios: true
+  rotation: true
 
 required:
   - compatible
   - reg
   - vddio-supply
   - vci-supply
-  - vdd-supply
   - reset-gpios
   - port
 

-- 
2.54.0


