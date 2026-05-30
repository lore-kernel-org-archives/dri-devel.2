Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9CDCD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F3A112843;
	Sat, 30 May 2026 14:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hDWzu0iK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5B711283F
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12CBF441FE;
 Sat, 30 May 2026 14:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FA51F00898;
 Sat, 30 May 2026 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149751;
 bh=FH0eLYkyJ/oKzJ34xAYkiF/Mj+otmL8kz7nE254dpso=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hDWzu0iKdzvUHJ6hzvMvvj3zv2oqTNXnLOb72ihWyj6mjHFn5mcQ/B7am3XGVyw+C
 QHOjnIsXQVpTFL+IIrqWT34qjxu38IxVK5gCPPm1n2lAo6yFHQp8OVY3F2uA4uOpc/
 Bd8lJQxFZH78XS/Ui1kGlV+4B3uIMn1R8QFB2pA20jbDKQPINKzsydcmeDXGDjks8m
 1no6sQ4LCOpCBLyLcTMz3WkQ6SyuiFiRKFtFBw9cbhrHAkGW3O/8biKTHkxKco4Le4
 5rYB+bmuHF9j5QQ0pitSXX8fQs4KMcXqNOrnusqI/AalN/K3ilrH0iSOyd03jL/0Lx
 wu739/MPrtF9w==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:03 +0200
Subject: [PATCH 58/76] drm/omap: hdmi5: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-58-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vLoxZaTDes2km609NiTCBd57bpudKgGSfRLleANGyeY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb/2eLQj5U1l5Imv2DpnT3penh9+u9zR4ILNuRVtiD
 s+//pkSHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiZ9kYG57cneKT2WXT5mRf
 GvbG/XGct+4hbx8eq+LSBbpXTdZOFnBTrnCLOu3OOitU40XDxzUHGOurLnYsyfrWaWLUuoQn6W4
 J753qKycqjm3bH5No1X5dXsS/v+pb9r17rA6JQg8e1n0oaAAA
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/hdmi5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index ab2d4eb6787f..1ee3bbe20583 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -470,11 +470,11 @@ static const struct drm_edid *hdmi5_bridge_edid_read(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs hdmi5_bridge_funcs = {
 	.attach = hdmi5_bridge_attach,
 	.mode_set = hdmi5_bridge_mode_set,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = hdmi5_bridge_enable,
 	.atomic_disable = hdmi5_bridge_disable,
 	.edid_read = hdmi5_bridge_edid_read,
 };
 

-- 
2.54.0

