Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89423C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABCA10EEA5;
	Fri, 21 Aug 2026 14:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FVo8wKvz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A43510ED90
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F87C6136F;
 Fri, 21 Aug 2026 14:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8341F00A3A;
 Fri, 21 Aug 2026 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323189;
 bh=hwxL7XtcEAZjaVbDHCW+agdAGFexEJhyXRtDWZOhhHs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FVo8wKvznr/UdNjOv4+3cIE/erZ6Mxiv1IlPcdqOhw6eTTED5QueF5TF2nvJyotCd
 aGJXs4Iw05/mTGccrq2b4EKP7gCsbGQjq94bJgOqiFZQBC6LTWWaGvjPDGYo/yQg6C
 W2l09pHC+OH0mjDi8ENvnvNC31Y6KatbfmzGtR0/UKMAhGY+kunhdvhvJgFrlKwzTF
 vBlTaYTIytCnpxzWe3dV3zyiHwo/S7EZVFHQB+joOOf6hIfwPTRpgoPD0I2kA7Gj1U
 rOSElbferaAI87/NDB/fVPG6APd24sRQFfoLUPBm7NayeEUjLzPon438MLSVyNVkbX
 5GwjcDehQsheA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:47 +0200
Subject: [PATCH 11/70] drm/imx: dc: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-11-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tsTVkYe0Maw90V4DKAaothNCGq7ljO8IchXBfzTS0U4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSX/Y3ffv8vru79HcnmX6wMU/xmCN/Jadfh9f6gc3v
 PsiYu3WMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYysYOx4a90Vu2N1M5Wb+e/
 p3s7202mcm+Re3x6/5qkG6fmHqx1j1jtmqnN8f+yddyseM7VNmabGOtDm6Jf3Mp+XGV6JKLD3eG
 LYWdf5BKhP2GGzOufTVCtrlYQ++6zVub42lsdn/X2M4kobAIA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The imx dc crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Liu Ying <victor.liu@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: imx@lists.linux.dev
---
 drivers/gpu/drm/imx/dc/dc-crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index 764510ff90a4..0d64186a9901 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -96,11 +96,11 @@ static void dc_crtc_disable_vblank(struct drm_crtc *crtc)
 	/* nosync due to atomic context */
 	disable_irq_nosync(dc_crtc->irq_dec_framecomplete);
 }
 
 static const struct drm_crtc_funcs dc_crtc_funcs = {
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

