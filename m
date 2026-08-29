Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7935C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F59110E677;
	Mon, 31 Aug 2026 07:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="mEtp9emI";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="aTMLP/LQ";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E13610E12C
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 20:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1788034159; bh=D1D5yRftzRyJg0Ypyl8P/j6
 WTdLdYr1mjt3rnU2v1tM=; b=mEtp9emIimkvUSHzeMF1s711bfFFu7Sc1MJi7O8tc5SeEWjSUf
 qsQ7ynZ9JRlHrA+6Rr6omcu+e6r4JG9+d/9a+YqKUa9DMEutj8121+YDUHL+4o6BpYzTy+R89fe
 H0co+DfeWvVcpatpjCbePXtRwupI0YMBxhT8n7aaA6ZumuctxKmyVjKh2vKRCwOO07NpJOlr8Z2
 CmdvjnEND9iCJ0JjjbmcJtpR1mhNaLcK/A6G6C7PbIh3xPc7B0H8zd0FdbmEVnk7Sz/5EO/aeoF
 hCucnvzLAhNTtNRkQFwpVDbeOvp9rIjpFCHHao8EKbyW0U5iOK9vo5DxsgDpYmN/t2w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Date:Subject:From; t=1788034159; bh=D1D5yRftzRyJg0Ypyl8P/j6
 WTdLdYr1mjt3rnU2v1tM=; b=aTMLP/LQvhMu/kQv+5jAZo+vB/HZ4n13sXgy8uYcLmIiCzovTN
 yNEKkyrs6WOuQzj+rjMkQEOE3Bq+yNqsXLCA==;
From: Nickolay Goppen <setotau@mainlining.org>
Subject: [PATCH RFC 0/2] Novatek NT51021 DSI panel IC driver
Date: Sat, 29 Aug 2026 23:09:12 +0300
Message-Id: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQrCMBBA4auUWTuQBFobt4IH6FZcpOlUx5+kZ
 mIRSu9u1OV7i28BocQksKsWSDSzcAwl9KYCf3HhTMhDaTDKNKo1Fp8+PjDE2WW6Yci1Vkbj5AL
 dBcmMdujb2tlmC0WYEo38/ulH6A57OP2nvPor+fx1YV0/UD967oQAAAA=
X-Change-ID: 20260829-qcom-novatek-nt51021-panels-e2f9db85a967
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nickolay Goppen <setotau@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788034158; l=1077;
 i=setotau@mainlining.org; s=20250815; h=from:subject:message-id;
 bh=5kmSpgALd9GTo3pAxZGgQ31AVpAy1mkPvNU6vZn+7pk=;
 b=kC1ufeMgGc2m9ghrxnRsQs/IbG541xgXBRRFrYDz03UGoqgoWFrFHI4BvPdYbvfpQ+xFE+2yu
 Ii1s0RaaEAoB/Qis/wAGred42z6a9nmhiSLm/Gi7uq5Je6w6mGlEqKP
X-Developer-Key: i=setotau@mainlining.org; a=ed25519;
 pk=Og7YO6LfW+M2QfcJfjaUaXc8oOr5zoK8+4AtX5ICr4o=
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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
Nickolay Goppen (2):
      dt-bindings: display: panel: Add bindings for Novatek NT51021
      drivers: gpu: drm: panel: Add BOE NT51021 driver

 .../bindings/display/panel/novatek,nt51021.yaml    |  93 +++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt51021.c      | 804 +++++++++++++++++++++
 5 files changed, 913 insertions(+)
---
base-commit: 99cc957e3ef3cccd72d2119c8eacbab39af0d1d6
change-id: 20260829-qcom-novatek-nt51021-panels-e2f9db85a967

Best regards,
--  
Nickolay Goppen <setotau@mainlining.org>
