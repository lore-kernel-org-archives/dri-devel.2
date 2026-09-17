Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AA3C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3EE410EEBD;
	Thu, 17 Sep 2026 12:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="bjCNbwJ6";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="S1sj6Hzk";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5DE10EEB8
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1789649490; bh=HQqFrcyVByninqC2k5tKSdW
 i1Wj8ZnUSQzwicAMA28E=; b=bjCNbwJ68P1t+wrpBz7rE/ynQxy3zCKHWQAcRVdEJVuD9nL7Il
 M3YcnBKm9xGZM78gwEzaI4oMEHZ8hICYqhMRRHnLmleX2/HRBgF4t5aZpDfCAxpvLH53cdIIwk8
 /6+3hX4c87cbdXL8eZOCPvN1Ma5hTt3XMgYiMdlP2PozmMGrbM1FFdBSLa1p3R2I7UCe7exGbpS
 Qug0gjem9pCgJ8nqKkszESWcnkA10Sfj/jFaJL/R6g5asJMNlRMF9hIQ97s8RX8GCf2Mn6bdGn1
 fYW4Smdi3vAOinMtejBNuUNKDwMVBM6ah21W7YpnNY1t+0hNOCfn33/O+388rac5yHw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1789649490; bh=HQqFrcyVByninqC2k5tKSdW
 i1Wj8ZnUSQzwicAMA28E=; b=S1sj6HzkqNHx6mL7S9CTJ4ti0fFKxEZ6vA/8LEB/QK+9jhr5W5
 LfxLVGf2FF3zt3FD79I6pMT3YPDBF4zeGOBw==;
From: Nickolay Goppen <setotau@mainlining.org>
Date: Thu, 17 Sep 2026 15:51:22 +0300
Subject: [PATCH v4 3/3] MAINTAINERS: Add myself and Ryan Brue as
 maintainers of NT51021 panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-qcom-novatek-nt51021-panels-v4-3-30afbc35d70c@mainlining.org>
References: <20260917-qcom-novatek-nt51021-panels-v4-0-30afbc35d70c@mainlining.org>
In-Reply-To: <20260917-qcom-novatek-nt51021-panels-v4-0-30afbc35d70c@mainlining.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nickolay Goppen <setotau@mainlining.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789649485; l=813;
 i=setotau@mainlining.org; s=20250815; h=from:subject:message-id;
 bh=mrTB1LmsmAc8ZgfJPlblJeFyOy7amRAcdDErDv0bjPo=;
 b=XJG5fwDNqb3oqRKq80kWerbR148kMKw/HbkR21vvC8jsWTY/JWaFlUZ5FygjPSCUqnEb4O/Du
 koy2gKp20YhDifBBC16lxETOzC2qSEGDdQ3V2yVAoHOOuOvI0YdYhee
X-Developer-Key: i=setotau@mainlining.org; a=ed25519;
 pk=Og7YO6LfW+M2QfcJfjaUaXc8oOr5zoK8+4AtX5ICr4o=
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

Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7291238bc09f..743c785b4558 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8354,6 +8354,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
 F:	drivers/gpu/drm/panel/panel-novatek-nt37801.c
 
+DRM DRIVER FOR NOVATEK NT51021 PANELS
+M:	Ryan Brue <ryanbrue.dev@gmail.com>
+M:	Nickolay Goppen <setotau@mainlining.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
+F:	drivers/gpu/drm/panel/panel-novatek-nt51021.c
+
 DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS
 M:	Lyude Paul <lyude@redhat.com>
 M:	Danilo Krummrich <dakr@kernel.org>

-- 
2.55.0
