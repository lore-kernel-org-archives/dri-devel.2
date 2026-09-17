Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4141C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA2710E4DC;
	Thu, 17 Sep 2026 12:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="kLKg422F";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sjKBYD4Y";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEDE10E4DC
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1789649486; bh=JCh5u0qrsxmo4PorbVlTDZ9
 F06/RO12i+RkQJomWIuc=; b=kLKg422F4H4sIwRsoc89rlV+OjXR+tWSTToNIbrc0Y0+oOWO9W
 Oqp+wSmSbY+5bsp3Jm4BZ27vCdNuMsJnJOPw0LOh8uT90EmkiaLswxgs/rSbBmQm9agYB7QE5iS
 yRUjCxijewzDv82ATPzN9pZV5IdLkX7tz0/w9Ft11rB+h2i0VPufd28vqZ5DhMsuOv4Mt7mtsWo
 2yrxeGDkoQnLUifOXN+WQJTzrnJVmjbtX6Vx/T+uja14Rn4kgH9GXtzPy1fxqBb16SQFJVjrR4W
 i3lz8vx0HmXPPckJFfY0zeHSwCCAAUSVH42PFadl6qZxqM5H1CqppbFINJ1gqHtE4kQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1789649486; bh=JCh5u0qrsxmo4PorbVlTDZ9
 F06/RO12i+RkQJomWIuc=; b=sjKBYD4Y12o8VfZvqvj8Mb14tPf+t2TFIfXTqi57M4/e7/2TOa
 0w/izAunBgNOTUvzsSef52PO7LkpQJBrfIDw==;
From: Nickolay Goppen <setotau@mainlining.org>
Subject: [PATCH v4 0/3] Novatek NT51021 DSI panel IC driver
Date: Thu, 17 Sep 2026 15:51:19 +0300
Message-Id: <20260917-qcom-novatek-nt51021-panels-v4-0-30afbc35d70c@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQU7DMBCF4atUXmPkGRMnZsU9EAvbmaQDrV3sY
 IGq3B2nLEACVSx/6el7Z1EoMxVxvzuLTJULp9ji7mYnwt7FmSSPrQUqNGpAK19DOsqYqlvoRca
 lA4UgTy7SoUjCyY5+6Jw1vWjCKdPE7xf98emry5t/prBs5LbYc1lS/rjcV9h2/3uqIJUMAYIz4
 Ec08HB0HA8cOc63Kc9iu6v4DVqA6yA2EHRHGqxy/eT/BPVPUF8HdQPRGB+6sach2F/guq6fx4P
 8BH8BAAA=
X-Change-ID: 20260829-qcom-novatek-nt51021-panels-e2f9db85a967
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
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789649485; l=2863;
 i=setotau@mainlining.org; s=20250815; h=from:subject:message-id;
 bh=eINicxrztFBllo+GpKEbg0TQ1UGHj1Vft8utsnkPzFA=;
 b=fzBBe/lSa9X+DU+I0C5AtbyJxWMv7pfHKDXfJEAmGEY4rsqLrKc2w0YWGayrZhCo4M/Pnhvyj
 V9fpD/B4oMpDVndE7Z3mft/BVssTnYbLD20+26CmTog3xe/Tlnd3amf
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

This series adds support for Novatek NT51021-based panels 
for upcoming xiaomi-clover submission.

Although according to datasheet, the IС has three power rails 
in the use case of xiaomi-clover, all of them are wired to one 
fixed regulator.

Maybe I should create a dt option for enabling CABC for panel.

Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
---
Changes in v4:
- Fixed bindings (Krzysztof).
- Added R-b and T-b.
- Added an off function without touching CABC (Sashiko)
- Link to v3: https://patch.msgid.link/20260913-qcom-novatek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org

Changes in v3:
- Fixed bindings (Krzysztof)
- Fixed probe function (Sashiko)
- Added BOE-TV101WUM-NM0 support (Ryan)
- Link to v2: https://patch.msgid.link/20260911-qcom-novatek-nt51021-panels-v2-0-135e3190a7fb@mainlining.org

Changes in v2:
- Use devm_functions and renamed structs and functions (Neil)
- Added delay before deasserting reset for stable initialization (Sashiko and Ryan)
- Fixed dt-bindings (Sashiko and Neil)
- Added a comment about set_display_on command
- Link to v1: https://patch.msgid.link/20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org

To: Nickolay Goppen <setotau@mainlining.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Alexey Minnekhanov <alexeymin@minlexx.ru>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org

---
Nickolay Goppen (3):
      dt-bindings: display: panel: Add Novatek NT51021
      drivers: gpu: drm: panel: Add BOE NT51021 driver
      MAINTAINERS: Add myself and Ryan Brue as maintainers of NT51021 panel driver

 .../bindings/display/panel/novatek,nt51021.yaml    |  87 ++
 MAINTAINERS                                        |   7 +
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt51021.c      | 875 +++++++++++++++++++++
 5 files changed, 979 insertions(+)
---
base-commit: 99cc957e3ef3cccd72d2119c8eacbab39af0d1d6
change-id: 20260829-qcom-novatek-nt51021-panels-e2f9db85a967

Best regards,
--  
Nickolay Goppen <setotau@mainlining.org>
