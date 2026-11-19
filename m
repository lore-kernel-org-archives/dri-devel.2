Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1AA606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUDeJw6g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB48F10F0AB;
	Thu, 19 Nov 2026 19:01:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3375A10F0AB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:01:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E787C437DC;
 Thu, 19 Nov 2026 19:01:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795114876;
 b=vPKrw4OqgfgYXw034zo31HVDeLOgVM/l6wtW0uD77ecmHBZaB+8vxeLlzOFeDlguHAtg
 uH0kEN5gbqzjCs3M8CPFLV/OkG9UhyWuysXe0kXC7Lo1ppPaYeHIG30BhRr02nt9+D7E4
 Hdx+WCSucZgl/8/WKV/ii8JLS9Xllzs1hrf5xy8jGBBD8bgG2523K0bVvt2CdbCiNZRBe
 xLG/wsCro89xNQRxwnh3FRXKdHPm2Jwra+mAcdJrYwpz8eth7xihy69JczXMVdSFgbm/j
 G94rG1DG/rC3LFe48uJWY9oNCw02tcdQaObMbsJgbCnF0hvFjMa+3SfLNitXtS1IxxQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795114876;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=VL3of2GZ4aGBezOahQR6AAnHBnjn53yrop77hBWEOUA=;
 b=qHYVgU6tgAno4VvQE21xpDsrJ0kQs2Jjlvb1tAA34GLub5kn0lAnERdxeKPKjDzBb+7j
 83pWCi6vtjfArVJNlVamLOmSwBizH/Wnu2A+cjfzroj1nGwPRhb4VaCPxxVStAuPhGplC
 z6Tpl8oWxRD0arqsXQ0kKYv4l0OPmbqSnM0rtuGxR2Vab8EMPmkzI+F866+IqRcSm3IYr
 tIEIDKHY72Tdhh75YtRRWyKveNz2wewCgexaxY0Ej8kFGfCLPH62xXMqCuXNmS7pdz+Wt
 gEFVe2AGD1jek2i0WJZgY4PC5dW/t1PQFppfhLzDpdAWwhtoFoNQEpIQ2Ooc3vtFc2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3184F1F000C5;
 Thu, 19 Nov 2026 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795114876;
 bh=VL3of2GZ4aGBezOahQR6AAnHBnjn53yrop77hBWEOUA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ZUDeJw6g/+bKeO+wFg5dk1e77sSV/najdncPAL051knB0kwgmmBuO46j5l/dB1l8H
 wY5tXA1AejSLedFvGO00RUik+gvAITFoCQw0zklrKReZoaDVuPP6vgN/ENNPypfNdC
 k0sHZAbPyZoPcoI57L44mBXbYZCyX5jSoIkKnFUeDuHDYk474xpCRCPLIR7w+3Kl1V
 fNpUNcAB+wSvW+r8yjcbPOHDId/58QdiJ/XlxqnCO7cQlTApwwseTJPi2mtoIFKeYq
 p2VJHL888nnb4GNOxr65DYrltlxQlLV7ZcEoF2cT02iycljbRbeoZbtkSXp2Tm4iBU
 j8ZnkJvpXzVjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A69E14B3D5;
 Thu, 19 Nov 2026 19:01:15 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Thu, 19 Nov 2026 20:01:12 +0100
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Anapass
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-b4-ana38407-v2-1-bddc251bd43f@dxdmail.cc>
References: <20261119-b4-ana38407-v2-0-bddc251bd43f@dxdmail.cc>
In-Reply-To: <20261119-b4-ana38407-v2-0-bddc251bd43f@dxdmail.cc>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Nizat Mikayilli <nacht@dxdmail.cc>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795114874; l=864;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=71KJwo/U3Etw4IsyPrxttnuaukQ5Gsqk1irCLfj/QNE=;
 b=klgVonqsiny9q+pQJHnCw+x9mFvazXk/UtvtLvt7puherNw0cddORww0DNUeXOtjCMQw6B1E/
 pmd9+SCrtBTDUrzA/uIRyS8n0haJDm0hi859zqvDxLU3uXvxOClbW+8
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Content-Transfer-Encoding: 7bit
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
Reply-To: nacht@dxdmail.cc
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nizat Mikayilli <nacht@dxdmail.cc>

Add a vendor prefix for Anapass, Inc., a display driver IC vendor.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..b117fce91102 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -136,6 +136,8 @@ patternProperties:
     description: AMS-Taos Inc.
   "^analogix,.*":
     description: Analogix Semiconductor, Inc.
+  "^anapass,.*":
+    description: Anapass, Inc.
   "^anbernic,.*":
     description: Anbernic
   "^andestech,.*":

-- 
2.56.1


