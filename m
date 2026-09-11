Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ED1C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFA010E9C2;
	Sun, 13 Sep 2026 20:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="HCNqyT78";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Wp8XaWvV";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A30910EDA1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1789141090; bh=Vny6u5J0qUp2UCUr8DV3c9l
 qIzc0Lcsk+TpVOnKVth0=; b=HCNqyT78k5HNrqhhqCbB6W9/sIMHi8YLuiNygRk4azgLgrZKkH
 LgRKyvkStxgV4XTlZI3PsujoK2iyVj9C9oDLjvr/GZs2nniZVQip2k52+SwKOjV1HjGl0b7q/Tr
 4ZdaslFKyVkrpmYk8UlozNZsY4N0VnZqQEhGPTGTJGNhRamgaIiSH/oFO6rDgyqEMNolKbLwcr4
 iFPzTf+heTmUdorUzdvBFA0f9+MrCPxntF3zENSCkTtIKvbioXdLEz+/xlU4uekpBAlsA+CI3LU
 zSOPr0b+bU/R2Ff6e3rtojNN/XObRqAVKSCMU7HYbWiIUR13BjI+wcHejzDVgcR82Cg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1789141090; bh=Vny6u5J0qUp2UCUr8DV3c9l
 qIzc0Lcsk+TpVOnKVth0=; b=Wp8XaWvVf/M4BMH//qIg4JDQjZ/5GLLAbZI3QjZ/CdIQ1sAd10
 SfssWucsBJrfKWpzHeVix+IaXrehhnzsF9Bw==;
From: Nickolay Goppen <setotau@mainlining.org>
Subject: [PATCH v2 0/3] Novatek NT51021 DSI panel IC driver
Date: Fri, 11 Sep 2026 18:37:59 +0300
Message-Id: <20260911-qcom-novatek-nt51021-panels-v2-0-135e3190a7fb@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBAAv0J6dg1tQgVP/sNwKGWBVdxiWxsN4
 e8CfsDjJJOZWQT0hEGcs1l4TBTI8QrqkAk7GO4RqF1ZqFzpvFQVPK17ALtkIt6BYyFzJWEyjGM
 AVF3VNmVhKn0Sa2Hy2NF7r1/rH4dXc0Mbt+RmDBSi8599n+Tm/XdKEnKwVlqjZdMqLS8PQzwSE
 /dH53tRL8vyBWkAK6TdAAAA
X-Change-ID: 20260829-qcom-novatek-nt51021-panels-e2f9db85a967
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Nickolay Goppen <setotau@mainlining.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ryanbrue.dev@gmail.com, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141089; l=2128;
 i=setotau@mainlining.org; s=20250815; h=from:subject:message-id;
 bh=Xdk44i7RpTm9gFCaxm9FZ6o/PonWQTyi/28W1AbT/bo=;
 b=JJB0Pc1iutkc2NpPdflPhbCfhjttMi2UZe7nWYNOcRu/qBPKOTQpgKYjXnIA1zcfc6X3hDUxb
 8lAZ7Iz/EMfA4EnP9DYtPF5/p+TUM45voqr93gCaSIkf9Vv9MTS8ShO
X-Developer-Key: i=setotau@mainlining.org; a=ed25519;
 pk=Og7YO6LfW+M2QfcJfjaUaXc8oOr5zoK8+4AtX5ICr4o=
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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
for upcoming xiaomi-clover submission

Although according to datasheet, the IС has three power rails 
in the use case of xiaomi-clover, all of them are wired to one 
fixed regulator

Maybe I should create a dt option for enabling CABC for panel

Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
---
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
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: ryanbrue.dev@gmail.com

---
Nickolay Goppen (3):
      dt-bindings: display: panel: Add bindings for Novatek NT51021
      drivers: gpu: drm: panel: Add BOE NT51021 driver
      MAINTAINERS: Add myself as a maintainer of NT51021 panel driver

 .../bindings/display/panel/novatek,nt51021.yaml    |  89 +++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt51021.c      | 791 +++++++++++++++++++++
 5 files changed, 896 insertions(+)
---
base-commit: 99cc957e3ef3cccd72d2119c8eacbab39af0d1d6
change-id: 20260829-qcom-novatek-nt51021-panels-e2f9db85a967

Best regards,
--  
Nickolay Goppen <setotau@mainlining.org>
