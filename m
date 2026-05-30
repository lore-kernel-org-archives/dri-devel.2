Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6F6CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E4210E370;
	Sat, 30 May 2026 14:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XUbrrPzj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6D910E368
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7004660121;
 Sat, 30 May 2026 14:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B851F0089F;
 Sat, 30 May 2026 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149619;
 bh=eg+hgJrj+yn9c0ZYBE62/l6kqiWyIDFNUS0bwrjHW6g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XUbrrPzjWnUTjSVVmUtpNZAmhrP2rKE1+Ai08A4a8XjWmiF0Lba+g42Qzl2tDLq0y
 S3TbN7UEpg675ms3j0jzzpmkl5U7Vcxerh5oFJ88HQ3x7DpBNTjJCS4vm1W1vXj70z
 TMRRmhBd45Sm9dD2ObFffIIODYEUq61KxN9y3HKx5QYphyLNPmQOrallEArGj/4iwf
 zw7vnHhXKoZdxKgwnoHcKe1R+FX5xred7Os7xI9ZaC66crjRfAShd3mlLpafY+qDfx
 lbX67USp23jme4lgH6HfVaTUxE7XjLxOWC+TmbLCZj2pKGmI8wIbz4eiQgJEUc25TD
 7B+G2naXYqX0Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:14 +0200
Subject: [PATCH 09/76] drm/bridge: chipone-icn6211: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-9-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=mripard@kernel.org;
 h=from:subject:message-id; bh=g4+L0loBxvyqjGiqXjCzoCNDFMaox8DQvct931ZPlAE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSby2PWU0prP38Z3vspxvKH1ZN3/ayPOTRFmYuvUfKh
 0WLyqfGdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJuK9irNOpVOYq0k77/lGB
 30Od+63Ok+cccS/WmB1Yfs/h669FlpN/Rt2OYEt3rRNbUNx80ureV8aG/tuv3y0R/P9OSmT34um
 f/k6dNWmGp/jhC7srPIT8FnWYrv+1quF4m/qJFbcbIr4dfxibBgA=
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
To: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index d8344e011818..eb628a0ce6ec 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -616,11 +616,11 @@ chipone_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs chipone_bridge_funcs = {
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable	= chipone_atomic_pre_enable,
 	.atomic_enable		= chipone_atomic_enable,
 	.atomic_post_disable	= chipone_atomic_post_disable,
 	.mode_set		= chipone_mode_set,
 	.attach			= chipone_attach,

-- 
2.54.0

