Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14B4C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BB910ED38;
	Tue,  8 Sep 2026 18:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HgI+/1mb";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AEE10ED38
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 18:41:39 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso53225095e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788892898; x=1789497698; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cr8h1Yq/NnZMM4WE8/4qnlK3saUP4YTKFSQMTgTF9Wk=;
 b=HgI+/1mbz9z/tnWmuy9VZIz2WQ6M1UwLdLiRg/ElfVbO9U1wdpdm8ovhNFc/36rbE8
 AT6D+5rYiD6RD6gWHgEF5E/SnJyJSbHJMOh/KuZd+n/qH92IOipRfQFBP+/71tG+FZzo
 IfRVWIV7glWcK7bECZQ1Qk2KBc9ABYHnsys/elReXa0AmqQyNZdwu3qHGDlM4dPHT6XV
 iQlpmReaFbrBjYAaCdL2/VCpJoi9COk+WF4+vlhq5wyzDnyh9ng1+lrF/LKXAs1gBkM8
 krCkYkpg5BHWYiaTxOSnt2ySIgaD79Gz/3Icb+j/QJH2fxsdt/DZx4rj7XO5ysXEE07j
 AWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788892898; x=1789497698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cr8h1Yq/NnZMM4WE8/4qnlK3saUP4YTKFSQMTgTF9Wk=;
 b=n81fTL/ISiCoy/IbtPu+JZIMrCnYxjik9DUCYXtZ/X7jW2KokHJwjRzXQ7UyE4pALv
 gWeapNe8/ujZH6wpSxEfHPdUtAgH/9ah9Djb6IYVAN5ym/+4bFSqrgjSfhoFLu32ltdx
 JBSqMv2HKBz4xSJVm8Xt+5O3mYR4lROBwtaxmQ3IUF0YduTN6x4/kTJ1c2fvs4lYnur7
 u9KV6oeSgKYrwfHl47zWeDF5Ydsz0gaKLBaTVP4tuRLd2Idr2Wg+tjmlev7ZVkb7lxKX
 yVNHyA4zejJBEiAOKBY5GgGrrznxVrmcs3HgipEBbGjmQpQBSzHlWoWS7z+wmNmbak61
 GvGA==
X-Forwarded-Encrypted: i=1;
 AKwUvByTGN/Uiugd9WdeKC52+4SKe1gFf2t3hm8hPbuw39wqy4J0BO5GBKuA1D+E4G863Ta+6S2XWAeXE6Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kBipxRQ82CismB2NL44Qo6Kk3n1UDkbulUpI+822Z+wwP66nsA
 1lcx3oXCjli2S6Nd2TzMJql540SAmqkJbdOKtj8SdFCIDxzKGHIntBx3
X-Gm-Gg: AYBFou02ApciTSIc8rn1goLxwGBVaPSi6VocZVZNXEUCNMICmytdb+A2x0Jhxxntm9e
 UuRm4cbm0+0pubkreufIeQyPyOUIU42ouysLTDnBkvoJ8fKYvQgWYWDclwei4FWCj8njrdYR+if
 sBouhYPWqxrGg2Snck1dG4BUpz3nvXWFN1Mdd+xPtD40NsdCrntpSNRZa0o7Lup+pZvEKhq9Prs
 ShBrbzE7IH0GDO60wx2re7bBWQbkd9ohG4JQFQJ+b8O7RyR/wz7xzBoFHURq6L5jHM3yozrKi5X
 mJ/qmUjDriRhC1knPa5Ec9C6aH5noUxpP7rSigITBRshV9UhY6i6/Qkdv3Xr0x+HetRHgsMnOYm
 AwynbzcykOVg4BeUIlszjIxsIf85QnnFaEAHj5wWIP7gUbipvLx535ltkojJNdKq1UUlXYverSr
 LxtDo8SgdFdAfgQtL87vGQw4XjJpjaf9+lrBsXVHd/Ut1VdJ175pWmyhmx
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49cf825a530mr371178485e9.12.1788892897552; 
 Tue, 08 Sep 2026 11:41:37 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm38558775f8f.26.2026.09.08.11.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:41:37 -0700 (PDT)
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
Subject: [PATCH RESEND v2] dt-bindings: mediatek: hdmi-ddc: Correct the
 compatibles for mt7623-mt8167
Date: Tue,  8 Sep 2026 20:41:05 +0200
Message-ID: <20260908184125.10916-1-l.scorcia@gmail.com>
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

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Fixes the following dtbs_check error in mt7623n-rfb-emmc.dts and
mt7623n-bananapi-bpi-r2.dts:

i2c@11013000 (mediatek,mt7623-hdmi-ddc): compatible:
  ['mediatek,mt7623-hdmi-ddc', 'mediatek,mt8173-hdmi-ddc'] is too long

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

