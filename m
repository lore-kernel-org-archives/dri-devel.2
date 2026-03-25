Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F12FEA830
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4024310E803;
	Wed, 25 Mar 2026 07:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dPD8Mh/5";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3D410E803
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:58:35 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2b0603ee486so15131745ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774425514; x=1775030314;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqEMkNh7cnEi3XsvgS5g5ei3L+mxqRTbNamH2sCwDdU=;
 b=dPD8Mh/5OC/sBUxDTdgPO6Cwg/qj1JoMvYSFhrf7eNFSa0O28+zrXg/4exdKxdMTjE
 ECcnSPpXqboGzTY8Sd6l/qVz4WdvNfojB55XO/9ik1vjZpuyZdxwll6pGewwakv61i2T
 iXzoL2Mi4AChPIYmbnn2i8SyUHccEuufEjnSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774425514; x=1775030314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WqEMkNh7cnEi3XsvgS5g5ei3L+mxqRTbNamH2sCwDdU=;
 b=CubVe7qiK0a8puFT/KX6P2BS27xmddtrPxK0gl44L4GCZ6aBTaqZUcjNzDPXqleP+L
 umCPKlCA8ybpVxTnHOEyEN2I3pfrs2uBuSOI0SmuN5cGUkCatpEkYBRZUI6NyicPQmYF
 YZk7u84pUc+eXBj8D7+vLIhwgyQHK9Q97sV2lq1EQe+xnJ0F4fUQry0hEw1rrS0wMj9r
 EBy9iwOwtYkwBGESqXqAX4ysL1QSCsZS+8BXIsnXicpMW4Z3MF3H9HrgVAqa7AMl8N+X
 rxgktyP8MDjyrp1NMsaLiZcdPOjAYY+tVnp9OWa43d2oFeb4h/Ybgv+LDctmFwZthuBJ
 nLbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX2ihaU24ps1seXoSgg2peQ6vZ1ChDLSjr4HXAimjiFpCNB+0pnhrtIU9Y3LoPpVE5jHSYXlnevt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+fCVjAoibYPYZszwoSaXJ9h26zNTYNCO6oGsMZHulzhXHIu/c
 mYjkWujy0jCfmebDtAlzVz5d7QiM01R6GFAfXLgmzkDqGWuAFwFmZy5tmGO2ouey2uHhARs6+60
 ypz8=
X-Gm-Gg: ATEYQzzmrsiWwCAFt5A/5bX+mZV+gydvoBkULYtuO2s/+GZdN0FBgJGqsWxDMNRF1kr
 KVDYQheGwllBYjByiKPH19qiflZgW8a0IAwcu4x0Mall0HXiKdvJ01PCDfvB3LAUJE+JgWJIjcO
 pPo0ibgEE7SbZYMDR4w0FmaaP7L1WY4kHV3eobQGhUNNUmboGN7XjHhl55pN8Rsp0m+HC2tPA8u
 EsO7lR5Gc289wFaXnq2X1M69cM2tE89KKU+l7LywcI+kgPSFrXPfT1iOel2yP24Fa1H5Wtfo6bc
 FMalKsYBEgh0AApzVqrtW9paLil5wjEOpoIStCm+EgluV/a533X/ZSuOP+1hsk5bu9AYXAdv945
 ndSCQTsiAIcvQiS3N6ozk02+qz3SyySxxU85K8pRlHEiEO+lEraWeiqBkQXJ9M4mHwdAGTfSEe4
 E2TCvjHphCTbtI+uGX1YOU8CDfc8fi7LdNAGRKAFH3ZdQtI05Te4phqad6RBXQy2sDMcanmjpQj
 fLXnWI=
X-Received: by 2002:a17:903:904:b0:2ae:c5fc:b2ef with SMTP id
 d9443c01a7336-2b0b0ab4cdbmr26299735ad.30.1774425514658; 
 Wed, 25 Mar 2026 00:58:34 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:7ff0:bee3:7d45:eab])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08366c3f7sm219682465ad.60.2026.03.25.00.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:58:34 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Icenowy Zheng <icenowy@aosc.io>,
 Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 3/5] dt-bindings: gpu: powervr-rogue: Add MediaTek MT8173
 GPU
Date: Wed, 25 Mar 2026 15:19:47 +0800
Message-ID: <20260325071951.544031-4-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325071951.544031-1-wenst@chromium.org>
References: <20260325071951.544031-1-wenst@chromium.org>
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

The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is one
of the Series6XT GPUs, another sub-family of the Rogue family.

This was part of the very first few versions of the PowerVR submission,
but was later dropped.

[1] https://lore.kernel.org/dri-devel/6eeccb26e09aad67fb30ffcd523c793a43c79c2a.camel@imgtec.com/

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v1:
- Adapted to recent changes, now only adds SoC-specific compatible string
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index a1f54dbae3f3..53131cd4cc2a 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -15,6 +15,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - mediatek,mt8173-gpu
               - renesas,r8a7796-gpu
               - renesas,r8a77961-gpu
           - const: img,img-gx6250
-- 
2.53.0.1018.g2bb0e51243-goog

