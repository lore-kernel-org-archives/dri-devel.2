Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DDAF9B5F5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFD110EDD2;
	Wed, 22 Apr 2026 09:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qoFz7fog";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C4610EE02
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:48:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AF16E40C1D;
 Wed, 22 Apr 2026 09:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CFE9C2BCB8;
 Wed, 22 Apr 2026 09:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776851322;
 bh=dEStAOYvvTqP4eZwbeu8ORXA+TxQlnJ46bVxEwIV+/M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=qoFz7foguRFAeG3cyQlS1m3t2+25J5B7wzYAlDX2Mol3YT6vlKMmhzy85JNqHZMKi
 idac5xA8VyU+McWBOfr6OHpO8rI/PRP6DLyYGL2pc1Vd4OwQGG8WH+fC3cMeoJlVon
 aKcZWz760K79GZTRTlHAgKBcxMhUyG6fgDd8Q4SqD+ZxNi+NaCi+efFMJxhWpmlKuT
 M2a3VeYAyqgIcfX03Y7OpVMjAVSdkbLlhelgRY4/T6Qiybb5hHZaQHR1x0TMwJTrgR
 rzvfZmUt27LCMHUtEncnMM2z1PiBXUFJDGVdcgVD8Buq2o0NJRfz+7pFAycYGQGfry
 Fq4uFe4BN7OzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 811A5F9B5F5;
 Wed, 22 Apr 2026 09:48:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 22 Apr 2026 11:48:37 +0200
Subject: [PATCH RESEND 3/4] drm/panel: Clean up S6E3HA2 config dependencies
 and fill help text
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-panel-clean-up-kconfig-dep-v1-3-d825e9ffe911@ixit.cz>
References: <20260422-panel-clean-up-kconfig-dep-v1-0-d825e9ffe911@ixit.cz>
In-Reply-To: <20260422-panel-clean-up-kconfig-dep-v1-0-d825e9ffe911@ixit.cz>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 marijn.suijten@somainline.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=6btRlHpzFWcpsPVnKzj/ASpL7mxJeb/wvSMA84mBejw=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBp6Jl4Yj7VBbvMjvojVvl+CxxCBLgHAW9g3nU3Z
 ElNpVGBBXeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaeiZeAAKCRBgAj/E00kg
 cs/VEACSzK8B/mOtJAB8GVBdcF4dDL1JH8JUOVbrc4eQbDruTr9/S8+n4IOTVA1Vdu+pjStQm84
 /7Gjh/bOZjf3/VdmhMZn/0AnBvwViXU1WbrwWN19UySL31Ahfw9MoYFact0jRn/M0NwJqYuwUpc
 ehrWi8pXTc8cIkEQI+v/KvGihbaD1F11asRvPg8Ga8QwNqAjeOb+WcBoqffmUv01DpDjhiiGAEe
 faUKFDLIRXsA1i9BYcCRY/D+/zsGFsLfSC2gcFS0/lv5Bvmv8Dq4p5Zv/lE2zxRtB5eniZf85nY
 gboqq2ifR7rZkKZ5V+3aZSwmgQKl5YM1Ux/PQH7vDAjTzXj++Jh9a879E/T8uPCpS95Vz8FJ1jC
 u6ylOCky7PSy0oZF9kzueYi9xmix3/5KjJrXpBisSUgifYFmPocPiNVxPbsDHq7PpjiiUzzEBlM
 fuPR0edzLtFv6u64A0+mRgcVLBswqyLQwgTueNB0kq2sj44FrUFrr2Jz1qX56dtNpK7HbYaxP7o
 MQNxAp9MI9kyKuo4URGfVGqnHaa91QPROsaZqHqjMuUV7sGSUfBJdcRxViJy1KxMBjQ56LVxW4p
 /vMRPTCeV2YQ1RU7d7sm5ftZL9mfHEjIRgxtAx+CgKTtV3VBmadXxl3mQ/fzeSWOECajKOG09nn
 V1mvxs83l+BYabQ==
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

As per the config name this Display IC features a DSI command-mode
interface (or the command to switch to video mode is not
known/documented) and does not use any of the video-mode helper
utilities, hence should not select VIDEOMODE_HELPERS. In addition it
uses devm_gpiod_get() and related functions from GPIOLIB.

Fixes: 779679d3c164 ("drm/panel: Add support for S6E3HA8 panel driver")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/Kconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index a81ea7755c03f..4e7b4808f6e7c 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -844,21 +844,27 @@ config DRM_PANEL_SAMSUNG_S6E3HA2
 	tristate "Samsung S6E3HA2 DSI video mode panel"
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
 	select VIDEOMODE_HELPERS
 
 config DRM_PANEL_SAMSUNG_S6E3HA8
 	tristate "Samsung S6E3HA8 DSI video mode panel"
-	depends on OF
+	depends on OF && GPIOLIB
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
 	select DRM_DISPLAY_DSC_HELPER
-	select VIDEOMODE_HELPERS
+	help
+	  Say Y or M here if you want to enable support for the
+	  Samsung S6E3HA8 DDIC and connected MIPI DSI panel.
+	  Currently supported panels:
+
+	    Samsung AMB577PX01 (found in the Samsung S9 smartphone)
+
 
 config DRM_PANEL_SAMSUNG_S6E63J0X03
 	tristate "Samsung S6E63J0X03 DSI command mode panel"
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
 	select VIDEOMODE_HELPERS
 

-- 
2.53.0


