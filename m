Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD7CCDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4934510EFF4;
	Wed, 24 Jun 2026 17:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ENt/vtD7";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6FB10EFF4
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:36:38 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-463b2f6fc9dso1462111f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782322596; x=1782927396; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G06cM7MjeSchS2SfjoxKf8C946GFsoGL3igB1cEOCFY=;
 b=ENt/vtD7Op0BhZl+1pMVAD8ElCEwVJreEDstwe1sv7+Dx5DEfW7uJSgN5CwsrhwGAQ
 VG63oACY/msmiHoLwOOGZtBEHcTNQpYU3Ual6XgjDVJRkSq+gaF46jVRDGcsVDYaVPRg
 a+3OtPEt8ZxDrehWPVCI1l8BV76ytXGscvlKdujMk0ElIPhjgY2PW1M/ExgreFpykboC
 yTNrF6Nd/Ww83enmKGjZ5LNgIXipP7L7XERV42aR+vQ+VH+wsI9vg5xixiO3jtqz67XU
 POAoSOANGYbBIWblTjpZUkYlNr5OFVWo+6/QRttcPjv+WINVxTXHygOtuSrvSui61LFV
 J04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782322596; x=1782927396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G06cM7MjeSchS2SfjoxKf8C946GFsoGL3igB1cEOCFY=;
 b=CrsRRKn8gQHxxq0FNWQ7aValCrrMlawp/8IUnPtujRylmCsgagJOmYVtUOUHGQmX4A
 pHEpgo5v86lEX6ZMmArW+wSK/ph8CGVDrNUdBcrYu5v6V0gNacUoY0LVOdqrgSOqQe3z
 qJdvhF5CoL+B9UuT4KFybuoiVNaRtdvf8hFxr/iyFLg8XcvMGcSdo/Lj1oudWT/t7oQF
 aID95w65SbEVfjoOGhWodS3Ca4j1Cix++lVcERQEnsLeM2R7zavIRz5lsmMXPqLEc+fk
 jy49cjPl3ICrQ15kfNPQPVDfegmSbOEd4jd9ZyRkk0MY8q+ZwnIzlS0LTa1/Cl5LmEew
 InWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/4HmRA0jl/PYz9XmY9kiwqsv+rCXiV9qT+82BThRFh3DGhh/GuVNrPxUOUoG5pn14oiqjbQvDd74=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQeAOY46neOq4lULOTJI+0CizBJtD/BSuaP3R5lQ0WkHIudRIr
 SPUTeDKnML3NQdRP9lxlun0M/s1mWriyMDpVSlJsJIR01fzunMmgYydB
X-Gm-Gg: AfdE7ckHpYDoXCfaYLiR623bfSWUdEohq6ovfQwyQjejb3UZSbfCnjaswHAJrQyKl0m
 XeCBBLWUYLtBIrNqn4vWzNPF9i1eKwc5rFgxL6hKaM98kyni3aKajdK0zI7mSnQCgyOIVQVXZ0r
 5IBg+Vk+/RPWRc2maB1da/1cCJCQ3QIGiOaNp83w1WikdXZGENmfOzK4s3vF+g9KmJvepv/sguU
 JVoNYnK9UHmvM4I9CuCOBPDKd0drkM/XaPgQ6ZyPGlpcubpC//1hUeB8lS1qUvsl5Ur5xzZr361
 /cDrwMC5nYIAiI0w/D55XgU+WtAYBaJ+LpCAukJlPLUetxY2DBKr0P8nBlDonFSQXxDrWQuB2YQ
 zgt1Dqfjwwn8/Hi+dcYmz7GS3YV4PcYFAOhQXQt4Jt7Z7v27kfRF7Nuqu7wePPTHS20hlOSSqbI
 MmAj6pyA==
X-Received: by 2002:a05:6000:2581:b0:45e:d8dc:922e with SMTP id
 ffacd0b85a97d-46c0b3e3a86mr7091212f8f.20.1782322596297; 
 Wed, 24 Jun 2026 10:36:36 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1b754471sm8165914f8f.0.2026.06.24.10.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:36:35 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: mediatek: cec: Correct the compatibles for
 mt7623-mt8167
Date: Wed, 24 Jun 2026 19:36:15 +0200
Message-ID: <20260624173627.19785-1-l.scorcia@gmail.com>
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

This change fixes the following dtbs_check errors:

DTC [C] arch/arm/boot/dts/mediatek/mt7623n-rfb-emmc.dtb
cec@10012000 (mediatek,mt7623-cec): compatible: ['mediatek,mt7623-cec',
  'mediatek,mt8173-cec'] is too long
DTC [C] arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dtb
cec@10012000 (mediatek,mt7623-cec): compatible: ['mediatek,mt7623-cec',
  'mediatek,mt8173-cec'] is too long

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
Changes in v2:
* Fixed yaml indent (sorry about that, I ran checks multiple times but
  it did not show anything - I had to clean everything and run them again
  to get them to show...).
* Added details about the errors that are fixed with this patch.

Initial version: [1]

[1] https://lore.kernel.org/linux-mediatek/20260623135757.5111-1-l.scorcia@gmail.com/

 .../bindings/display/mediatek/mediatek,cec.yaml       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
index 080cf321209e..bc288b1c6f07 100644
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
+          - enum:
+              - mediatek,mt7623-cec
+              - mediatek,mt8167-cec
+          - const: mediatek,mt8173-cec
 
   reg:
     maxItems: 1
-- 
2.43.0

