Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B53C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C813310E574;
	Sun,  9 Aug 2026 13:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F8iBKFgh";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F7410E57C
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:23:45 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-480033bdcf4so466967f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786281823; x=1786886623; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jiE5KveVgNl9XkJ4WjLCf6DiWT0Rzjhuj8+wghGG/qQ=;
 b=F8iBKFghdADUTC0liR2dv2tNOPCO7HJxv/UzcG9rOOhK8I4BJIZqdBJayvmiouCkuG
 +ZUbk6OlJ9/Pxjban7EpEGQM1zRpRRXHs8w1aZcZeWAgkz6m1u0XbfiMl4OQfBEi+SCv
 vFtsQULfxGWWznd/eQIqHfRr/W62qMG4wRK2Y5bzftOx9tIOyJUz1Il6kEU2HfJUzss1
 8T/QSBKlAziAzHSCpBBWfZBeA33tvLLGdwfvSBy9UUAiwNlvpsnGqvO0y+9478/9q7tG
 RRXs3r8wvMCHm/xekzAXvX4oPUTdwOYNvZNy/9+5q2ybff4xwlL492gbwl5yCuZjC+dm
 7LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786281823; x=1786886623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jiE5KveVgNl9XkJ4WjLCf6DiWT0Rzjhuj8+wghGG/qQ=;
 b=hEI3Fn8+VgpwpML7Ce7oeO76nysUoJryCZLSfOR1jqQOzrmRT4/5ydffFITz9iMdeU
 dRFSS2d2TEP9D8F5EJDpXL1b16NmsVGcZV84ZyYg+AvR5yTNObjD5fbVRtMAtkYLUobc
 VCMDMuhNmq0l/yyFPOzbxeFgS0dd5fhWaMzr/6D05G+NaGVMe5sb5Iy2mWAB8ecfBw5m
 kkkH0suvLOdspSVXi7nioT7QOswojyTawPwA1TdiDW4CL7Yt4w92u3ddkzWX1hQuVohO
 QfE4dI0gQJevuCt1tOFEtyW/GDAGEYKR+WyOeWbe1krsaV9xW4SQNjjNWkt77XqvzDKy
 /m1A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4hIrTbKJTu22Rf5z/ZPz7o5Sbf1P9QKCU0oXBh1vDW6DzqvNtz1VCRoBmP067g+fA+vfAFxIaUBw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvRuo3gNx88cz0RO7QeIos6oEQ1PtA/OCnIpqUbmiWBv4D9qp3
 ycT6RdhLhiuRDqV+sy7DRygL6mYvJINB6MbLqY8sYuXlOgEw6RvXNzM0
X-Gm-Gg: AR+sD12qqcrFZK3X5EQgYxDwkMRk5yQ6L8eNNNfPGO0fv32SDaSqP/YXxmMCh4ob/J3
 3bnndt8JikZM/6rIp3WoUv5BM/wLx/6SrMDJO+yRZJYvTtAGDmbIYV5acDpVSWUHkEcLUCIrc9l
 2hhOZu3xU+YIBSwl2/24Rjinl4ZewUL4UIOD/Q8sNICOIHTw7M6/UCeLi17BGJ2Fp6BDjPVBTgD
 2gEmszYELx8VlBzkugoN81Xyke40zlXmHhCT1HuVoA3R2gnNFjqY0sJaiezbN+MftFiT+/tZnsI
 drEppI5cy8kygFlhBHtto1NROdXnsxkPbqS04GgTMHFyBDrWOUPbQo3I4ZK9aUyglwNeclKR3s6
 rB0TSOvz4xW3BXbYCLY8eNMb5CGmEQ3OgLkv/63PhCaunaEK6lC7hU/U/ifXqHpxLqs6kBXnGWy
 8Prw750Kr0gvakdKseZQK9rJ8wp5XfpQE/dSRYHvx1bdFYIW+JDA6M4A==
X-Received: by 2002:a05:6000:2913:b0:47f:973b:71c8 with SMTP id
 ffacd0b85a97d-47fec62e4eamr46608879f8f.21.1786281823240; 
 Sun, 09 Aug 2026 06:23:43 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800214557esm22476356f8f.2.2026.08.09.06.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 06:23:42 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: mediatek: hdmi-ddc: Correct the compatibles
 for mt7623-mt8167
Date: Sun,  9 Aug 2026 15:22:24 +0200
Message-ID: <20260809132241.6153-1-l.scorcia@gmail.com>
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

The HDMI DDC driver for both mt7623 and mt8167 is actually the same as
mt8173-hdmi-ddc and the mt7623n.dtsi board include file already uses
mt8173-hdmi-ddc compatible as a fallback, but the documentation lists
them as separate entries. Correct the binding by adding the correct
fallback.

Fixes the following dtbs_check error in mt7623n-rfb-emmc.dts and
mt7623n-bananapi-bpi-r2.dts:

i2c@11013000 (mediatek,mt7623-hdmi-ddc): compatible:
  ['mediatek,mt7623-hdmi-ddc', 'mediatek,mt8173-hdmi-ddc'] is too long

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v2: Simplified error description in commit message.
Initial version: [1]

[1] https://lore.kernel.org/linux-mediatek/20260624173514.19752-1-l.scorcia@gmail.com/

 .../bindings/display/mediatek/mediatek,hdmi-ddc.yaml  | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
index bd8f7b8ae0ff..966127e1ee63 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
@@ -15,10 +15,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt7623-hdmi-ddc
-      - mediatek,mt8167-hdmi-ddc
-      - mediatek,mt8173-hdmi-ddc
+    oneOf:
+      - const: mediatek,mt8173-hdmi-ddc
+      - items:
+          - enum:
+              - mediatek,mt7623-hdmi-ddc
+              - mediatek,mt8167-hdmi-ddc
+          - const: mediatek,mt8173-hdmi-ddc
 
   reg:
     maxItems: 1
-- 
2.43.0

