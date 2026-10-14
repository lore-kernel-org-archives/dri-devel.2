Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F098FC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5C910FF06;
	Wed, 14 Oct 2026 17:31:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D20210FF04
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BEE66022E;
 Wed, 14 Oct 2026 17:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68DE1F000C5;
 Wed, 14 Oct 2026 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999054;
 bh=axNUJMhhnxKQtQYDsX+DThuVPCWOkI5w9f6H3PvyWtg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=L297U/obPdPP8e6ICJuDBar1WwFIfCTxAgFssiWoQ10gpYVYtSFTAnQNlkG5y2zfM
 V4tm8F+1uQ7XWKNnEwzCpTQZusqAMUcua0b8TNsfxqBum1uMJ3bZL8xgfiNQ8SD/FP
 uAYMpIo8FO7mDOu2n+PodpQE5fwoLW1ho2vip4eIZpNFkMbaMDktQx6zPDiKK0Dc02
 orzhkviERWymsOOXcDGCB3b7NzbEvdLtvKY+DSxZ02FOQZf87/UAU8p/dbnhU7o531
 X2LrmldVxmMTTtE6VUMacwbPSYFZbdge+Ok+ciDYZgpCHKYcu1pw5e5bg4t/4hTz1X
 rcyVf/IWXdhEQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:24 +0200
Subject: [PATCH 61/75] drm/sun4i: tv: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-61-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=mripard@kernel.org;
 h=from:subject:message-id; bh=LdgN7Ly8DOeZP0rhAFtQr7JjeNlItSMFEwC6teFOK9Y=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrPu2Wh/cotqwiQQKGdx/TEF0TxfVsf/71THk/WVDi4LOg2m
 oiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrPu2UACgkQJ1/OGaI9vnbhKAGA/oLD
 UE32/nSIMkid7mqxYmAajX/Zdu3iJZtoXhBwTDKMPJpTb84WmgoVeZH/ax7MAYDcva6HztCqqpY
 c4fngyAO3RHzb4tZmS+i/8URffWUQrUjl8qUvxB0LJ1Bp6A4vkI0=
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

The sun4i TV connector reset implementation creates a pristine state
and initializes the analog TV properties. It does not perform any
hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-sunxi@lists.linux.dev
---
 drivers/gpu/drm/sun4i/sun4i_tv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index ea86f8a6a35e..a68e5f7a03d2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -403,20 +403,28 @@ static const struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
 static const struct drm_connector_helper_funcs sun4i_tv_comp_connector_helper_funcs = {
 	.atomic_check	= drm_atomic_helper_connector_tv_check,
 	.get_modes	= drm_connector_helper_tv_get_modes,
 };
 
-static void sun4i_tv_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+sun4i_tv_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	drm_atomic_helper_connector_tv_state_init(connector->state, connector);
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	drm_atomic_helper_connector_tv_state_init(connector_state, connector);
+
+	return connector_state;
 }
 
 static const struct drm_connector_funcs sun4i_tv_comp_connector_funcs = {
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
-	.reset			= sun4i_tv_connector_reset,
+	.atomic_create_state	= sun4i_tv_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
 static const struct regmap_config sun4i_tv_regmap_config = {

-- 
2.55.0

