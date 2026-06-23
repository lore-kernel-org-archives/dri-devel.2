Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF2CCD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C458E10EB79;
	Tue, 23 Jun 2026 13:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QftOpnfe";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123C310EB66
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:58:08 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso80758755e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782223086; x=1782827886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qm9QBhEQ0YB2AXes3jM+Kp4ITvGr2+JfvL/tfEuQ2tI=;
 b=QftOpnfeAjhHbbdKa39CICRRwv27sVBZFN3pthY9xCIZffWRgJukgSDTKmng24PPxP
 i6MNkktA3IgWy7PdZH+dl+wjm/Dg6n/9slLWHQZxBe/foyE4vjsrfhnwtDmiOmBBvDs5
 5IYy/olAEIWsJE2dFOHs0m2xTLD0sna4Azanre0m/LFGe5yqfSckisoyUfHWYTsG91U6
 3yiduc/+DkOVkpARwMdWiGtVPCQ6yrCuaec/LVaLcoOGlqPxtqBVfbDepayUqnoD2GJr
 s7gfn9Tcuz8UIHCykckbqibRW1hTa4r9wwje83JNtfDWYsD8H4Smt2XegGDr4v6CpUfv
 9QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782223086; x=1782827886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qm9QBhEQ0YB2AXes3jM+Kp4ITvGr2+JfvL/tfEuQ2tI=;
 b=lkNQwcdyPHhKkkXYEFHgceuzMCXSqKNZUFDjXqV//CmNo+2fMOTD2Ovc4iBqjbaL9G
 nmWecIY0v9wCioR1oWZHuHLgufnh3HkpL4pnrRM5cCqeSFACrknCecXmVbSIgcJmF7wP
 FOOTY2ttXhdc0xpoJ+0C1GYVfYscvuztHd9nbnBCHEa4w/zjhVBHEBj3pMrkmAai9gWb
 zDMUrA7lnEb08oBqWbPQV1/Zuc11zfOaUazYMFHzErvdjke43DXrM5MxB0QG3jYjvwW8
 U+G0jdgHp30nmdk+DzHcH0IPEKf+PPh/0i9jGthGMMOW5gV8AdjQLxP+Y3YAW5pc1/ic
 a+2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2nRKFWpMx7g62il3c7Sh3YodBQtgyeya55NDSK4mks/Tor8kOvnSFysensMVSkzwQ3v9YGLPZqoA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWbTb0bAKKoC0ZXQxioi+TF9+92Nq7WP9vfKva1Wx2pX1s8U1d
 eLd435I5LgK2pMC5iqRpHRWJyGXKYYKhq/KyHwn3etnP3gT8U7CGt4v+
X-Gm-Gg: AfdE7cksjGOGvnk33l+iFpZRtmOONjQXp3U5L6ocfmsWYozEccSRHg74zMy+o/zTkSH
 r9Cy37H+tSzjKlQQGDsgFUjArHilSYdD181wsJNi8kwS+yAnCosP8GMKQ7YROL05OXHfFmFKCd1
 Bkd8WqI5TlEBRxi3SE0UG8xCVA1RBNZI8LmZAnRqHHBRYislh68vJQXDL83Pe4+H4mNLssqtU/V
 mG/UmRW93j2i0VexI/V0aGdG71T6xfy/ViTF6yczewiHMVE8+K5NrIagLvs6/G7DIgWI20qOp62
 r6IFcVurDY3E2LODJjV3FWstqPdznrV2YZDV4ZBKZIzlVPAvu+v7dd4ALtevIewcQsghRKfpnZP
 7mXSt2U9HC23YRpAGReZUyzdye30PEGq/a+fhNgfVq5y0s/hyYgh2FHZQ6ZPxdAHXgOfXXaMcEz
 jXBzz3gg==
X-Received: by 2002:a05:600c:3110:b0:492:463d:b2af with SMTP id
 5b1f17b1804b1-4925b38ca04mr38947105e9.31.1782223086132; 
 Tue, 23 Jun 2026 06:58:06 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f56aasm35145716f8f.6.2026.06.23.06.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:58:05 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: mediatek: cec: Correct the compatibles for
 mt7623-mt8167
Date: Tue, 23 Jun 2026 15:57:53 +0200
Message-ID: <20260623135757.5111-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The HDMI CEC driver for both mt7623 and mt8167 is actually the same as
mt8173-cec and the mt7623n.dtsi board include file already uses mt8173-cec
compatible as a fallback, but the documentation lists them as separate
entries. Correct the binding by adding the correct fallback.

This change fixes a dtbs_check error.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../bindings/display/mediatek/mediatek,cec.yaml       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
index 080cf321209e..4d741ba415e8 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
@@ -15,10 +15,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt7623-cec
-      - mediatek,mt8167-cec
-      - mediatek,mt8173-cec
+    oneOf:
+      - const: mediatek,mt8173-cec
+      - items:
+        - enum:
+          - mediatek,mt7623-cec
+          - mediatek,mt8167-cec
+        - const: mediatek,mt8173-cec
 
   reg:
     maxItems: 1
-- 
2.43.0

