Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4C5CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906C210EE2E;
	Wed, 24 Jun 2026 17:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X1fxMZ1r";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769DF10EE2E
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:35:53 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso1066045e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782322552; x=1782927352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3ESHjFhIcPG4hvwDoMj3pKaSJ5JAGh6fCIgpcDiAdw=;
 b=X1fxMZ1rMSZPD6jhPlIYkBSyOsxL+UgIeATLgyGr62Fvv0STRpS4cTU7ojw4LMSkXl
 MZmdKtjf+iWXMm8R5U+DP8LEAtG16QyTmUwTVITXrpGtWGwHVnJcH28XU8wrqJRwhdu/
 /BPUYuHDDmhMRF8oHUxrrjZ7D/ICxVZeJUez7fFd8L4WpO0QWCakiHaTI8DAlNaL0Txx
 QMArQvLP829CVIz/4lbM7/ikkCaWT3eyEqze4qOxotBLKusbZX7o4fnQcw/sQ0sQRdXR
 Z1sBPBWDQOOV8SJNAXKwINS4q6BlMp2tQTUKsPE1igcZCJF+GwsIkxIvR/WtLkJufT4i
 mZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782322552; x=1782927352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3ESHjFhIcPG4hvwDoMj3pKaSJ5JAGh6fCIgpcDiAdw=;
 b=OqqKYqFA2rsfoAoZqWfQavdMe/EtBv4V3ThHSVX+2sKhqOHaPlJNOqHtKzNcw6gpJ5
 r3PXNc5TKwa73LVDgiHA1MmPtodWpKl4qOPtFJ2+66zo+w2BpbZ5Q+78ggHTICPSMdA3
 qtm+yFKLCrqrg77yBBGSpvVljazORCRsBzDMNVLAkdB4Ut32SLEg5P6Qi4Z6ifsaMXW3
 tDKNXdA2o1BjD/XJXpXcQtdWyrKguPDYgXIH3BuzBkJ1DBA6n5lAu7cCUbsI2fAmlu8d
 RSLfaITyAxAwxqaJfRag7GCby7Gtq9iEx1SVdapmnP8ho+Gnl2UB+Cqjy/NPGqq/bYjD
 TrLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wVPa/M7Fx9ma36y3PJlYbjK/aM6iic2vBbM6lnAUAanlg+Kr8bPeBDAP4KkqvSl2kMwylc3s6eGc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2fvxej9a3CUYlFidzIX3q8TAYeVmOu67NxKBpwWpbcKDchi3C
 /cGuV6ukJxAFARP4bYGjHsscZ6979GXcFuRfhUoVjMxg4AkPl2QUjZCq
X-Gm-Gg: AfdE7clzSEsMLvxAWOyoByD0Ed4hY/XfwLE5mP1h/RhY9f5tHkhO/bLgR6dlZ0eoCSL
 mFchkwFJ5YyCNQ4hmTEDiPvZ6Q+bBYhpo5duq3+TqdynRCYcfXAENBIg2SG4/oWgJ2/M31KYFs9
 Fs4tb3k8gSyVTNKKYovVaM3e92fJnTY6dRdLcMtW9boBz+LSUaRUVcB7cHQCNplLh0dCzXLY+6n
 zdgS1WMTcn2D+zrYj76WCT1K7E5sZ4rT62LMuWEQGS7ovjGCCv/I0mfztQJBzkoDBkhKDt1EUlI
 5W0lEaOYy/wxutclU5oECvPbUnJplAZO3JymRJGTZfgvOMVp7luYIKCOdw4sbjlRw7t5aNt0+gg
 oyietySepYWqaFieatrahoIRxtG3V8QjTIfpzEudSfrkP0egClorpZLzqETMdXz+Evq6Hu14cig
 Q2JVNV2g==
X-Received: by 2002:a05:600c:4503:b0:492:6348:d7b0 with SMTP id
 5b1f17b1804b1-4926348d7e5mr17448505e9.18.1782322551566; 
 Wed, 24 Jun 2026 10:35:51 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49260d917a5sm41336865e9.2.2026.06.24.10.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:35:51 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
Subject: [PATCH] dt-bindings: mediatek: hdmi-ddc: Correct the compatibles for
 mt7623-mt8167
Date: Wed, 24 Jun 2026 19:34:56 +0200
Message-ID: <20260624173514.19752-1-l.scorcia@gmail.com>
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

This change fixes the following dtbs_check errors:

DTC [C] arch/arm/boot/dts/mediatek/mt7623n-rfb-emmc.dtb
i2c@11013000 (mediatek,mt7623-hdmi-ddc): compatible:
  ['mediatek,mt7623-hdmi-ddc', 'mediatek,mt8173-hdmi-ddc'] is too long
DTC [C] arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dtb
i2c@11013000 (mediatek,mt7623-hdmi-ddc): compatible:
  ['mediatek,mt7623-hdmi-ddc', 'mediatek,mt8173-hdmi-ddc'] is too long

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
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

