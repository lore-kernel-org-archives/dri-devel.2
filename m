Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFDEC5AC67
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 00:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7F110E0C3;
	Sun,  9 Aug 2026 00:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lzWfThO0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8FFA10E0C3
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 00:04:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DA0A43EDB;
 Sun,  9 Aug 2026 00:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E55C2BCF4;
 Sun,  9 Aug 2026 00:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786233873;
 bh=Q5gz2v8bYWQslzNBTJ1xlxfRqwopRF15rgQ23wMNCuc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=lzWfThO0wMIfgMFYJHlZmZ8yjnNSQxQbYhCs+jzFbFVYvrJRgmE5ZRnwkE2cyBUkM
 I9ThtoH5173vWCdfHmJvRudXzdmFi995Q69wfa/dolEKPTjXE9Au2kIZvkCIFUZfjy
 RYjCv2CNdHdOkJp7J9HyaORUSQcpVkAfeqCeoux9WrfDMA1sXzJQ/npb7zX7cRlsXh
 nREz0m6sjxK1loABlz17q58Ap6C51+XZG9YuKRAJIM2GRA+m6mejbD13jquj8Wv78E
 rgWP2LI1btbOrvC6a321HKZrTc9VOshxLH9BvnrGPqX85dRWs8XORyVxgI5d7boQcY
 738uKvl7QovVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D6225C5AD56;
 Sun,  9 Aug 2026 00:04:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 09 Aug 2026 02:04:30 +0200
Subject: [PATCH 2/2] drm/panel: lg-sw43408: use the full DCS brightness range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-fix-blueline-panel-v1-2-e7f3a6beb1fa@ixit.cz>
References: <20260809-fix-blueline-panel-v1-0-e7f3a6beb1fa@ixit.cz>
In-Reply-To: <20260809-fix-blueline-panel-v1-0-e7f3a6beb1fa@ixit.cz>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=9Sj5Sfou+YL+MgcWCgbCBmFq0YdzuWI03Hr+YrwTrPw=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqd8QPDMiWGz8fmUCuEv9NIEAGDI1RWROZ0cwgr
 NyhfPKqjg6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCanfEDwAKCRBgAj/E00kg
 clwzD/wJz5nN78t32Wzxp27u+8kzstzpq+6tlucYY9SEarB8lgv5YRGnAlK0jh1LjHugJC2ZH0d
 V4j7nXhQQ7EM/axe9lIj1Lkf8g6nfnBiIy5i3B//bc72Jap8wZAp4y9CoG5qUj+F0H0h84F/jUo
 7fCcgG4hcP9ve6yYylIsZXQMX7s9mVRLqYC62j5VFWK/vVyHcVi4dx+GmgJpeUCFHvk/9ObnvxG
 7kqL1JW/Jo/eN2xJ/6caHpTOnlouIK+ehySXSaDQZ69k5a8+9zcnZTys4flHboabf8n4WuMJynF
 2XyREMZe0gyUI214ah4Mm2fXziud1/J8V53VMCLmwk/TNuTd/LMF7j4Dyyn90UZejoAUoQ6EhY5
 Cgb3jwazQLJnuz9gMFXGbih+EmA2vKzFWS7zSOGMHYT/4Tt9TOhO84hBDWH/FK7RLQIjZqgaExT
 wUpdL+5dNVK8XE6fLFoXUXEDJRF1uMdRycvguWtUwjpN+13tG/ulnLFvqIJnoMva93BcLj3H9MU
 uo8rR1xQOpQ7GovuymgbNzAcy5X+YGlwPDkBlf9GibhVHyZLVfXQDHdNLLSQii8UOAhHHamDHC+
 JGczGRVFt6d1BABNe3mhSehM6LUvycZsdiM4jqqwjq3unFDhq5l/I0efmlYORRxMWakoT77tzHW
 WrSywwZcLtuu1vA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

The vendor firmware panel configuration (XBL DisplayDxe panel XML)
declares DCSMaxBrightness 0x332 with a two-byte brightness command,
and the driver already sends two bytes via
mipi_dsi_dcs_set_display_brightness_large().

Capping max_brightness at 255 therefore limits the panel to ~31% of
its real brightness range. Use the firmware maximum.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 0bf8e08f10b9c..332b15b6a4c94 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -202,18 +202,18 @@ static const struct backlight_ops sw43408_backlight_ops = {
 	.update_status = sw43408_backlight_update_status,
 };
 
 static int sw43408_backlight_init(struct sw43408_panel *ctx)
 {
 	struct device *dev = &ctx->link->dev;
 	const struct backlight_properties props = {
 		.type = BACKLIGHT_PLATFORM,
-		.brightness = 255,
-		.max_brightness = 255,
+		.brightness = 256,
+		.max_brightness = 818,
 	};
 
 	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
 							     ctx->link,
 							     &sw43408_backlight_ops,
 							     &props);
 
 	if (IS_ERR(ctx->base.backlight))

-- 
2.55.0


