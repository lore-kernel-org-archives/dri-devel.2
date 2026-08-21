Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C215C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05EFC10EFD2;
	Fri, 21 Aug 2026 14:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CiIEdLep";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0378510EFD2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7AAA061126;
 Fri, 21 Aug 2026 14:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8E61F00A3A;
 Fri, 21 Aug 2026 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323206;
 bh=D0lUkrAQlr++RiEMuffFxdy0SaqY5GeUs95SJkXf9OQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CiIEdLepXAW4vOL7vkwwWSHk8Te9lmMgJgk0qcfZzP2nrncaMXSFT5MaQHTSlaJ0n
 A2dlZetF3zOkvWdbI8pAtP/fuVtsYJSAUB5mAtq6woz4DluTai10XeE1Ohszwly9ss
 qFupadEAN8/AtcBJWwkkRIl8qCV67ycIoO4oRcxLxEAKDLsoU8eWMcB+sqt9/G66UV
 sVA9Q/+1BeKLh3aO/lal5bLg8OycgtMAnxMqVeW2eL1VUErCn6wgdyfONb84/DT1I1
 m71Ozn33fUe3kxDIe5Nkmdiy635r+RuK0v12yDx39lnmGUDjyah/yE3flkFGOq/4kM
 XDScHmthYwwIA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:54 +0200
Subject: [PATCH 18/70] drm/mxs: mxsfb: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-18-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, 
 imx@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9KjCYRU0wOenhcS0ecAFcdhIl9zfzsL4a0GtqTOOk0M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSf/f2qv6nw94dOJn/v8JNVzx1y3YzdpPfRaMOr9AK
 L5wM5NOx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIpV2M9VXWr6NPynO57JUv
 urmaf4l76rL+mqfyLfPkmvV2Sii2/YlnFpv/+Zdgp3NM5wHPMvcoxoY+2Ztp/7REWLyea/98aq/
 3PlfYh7cgPfyc7ElVjl6Vr8oi82SCzz2avuu0GaODhAmTIwA=
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

The mxsfb crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Stefan Agner <stefan@agner.ch>
Cc: imx@lists.linux.dev
---
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index d8ebebc5314b..36ea285182b4 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -482,22 +482,22 @@ static const struct drm_crtc_helper_funcs mxsfb_crtc_helper_funcs = {
 	.atomic_enable = mxsfb_crtc_atomic_enable,
 	.atomic_disable = mxsfb_crtc_atomic_disable,
 };
 
 static const struct drm_crtc_funcs mxsfb_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank = mxsfb_crtc_enable_vblank,
 	.disable_vblank = mxsfb_crtc_disable_vblank,
 };
 
 static const struct drm_crtc_funcs mxsfb_crtc_with_crc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

