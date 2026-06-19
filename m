Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFCCCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5996110F58A;
	Fri, 19 Jun 2026 12:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gk1SK59p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED06B10F585
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:26:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA40E4376E;
 Fri, 19 Jun 2026 12:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250791F00A3A;
 Fri, 19 Jun 2026 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871970;
 bh=TQpfGd0dxmxC59iLt6jThwL6XaiClHJh/ik01H8MLbo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gk1SK59pov9oWpTywvpBldlTIacz/FVZiULhguEk25qR6OMRYox8KPLIl9ktA11PF
 1dFiCtYu0cKKP0rZBYmPFIgb89Ot57aZlc3ycorochere0pGG9TfoYAG5IgyXKj7yx
 TcNcXVKYO6O16kwDN+9f5O90rOg/DhhiDhfGpXxOn65hNKMwVozDNY31YSbHhEz70v
 ctxIZ/6Jz0tY4GV/qJ3T8YZa1k3VcYG4sogv2JkoJzrfFJU+4HRQT23Su0fRH2ijUL
 hn5zyX9sfeSmKh9ARxrYaLTXZ2qvc1YH68r0eNdmmPF2OzTpH9PPDqvWjXNGaUzzqO
 9qDpdVZuSCn3A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:36 +0200
Subject: [PATCH v3 31/78] drm/bridge: sii902x: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-31-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EHtS/3KkSTZlCeOdWlRxPF+akr7opr6n9PJ/097Af/o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJt+Xz7bb06l81f7pwXapLR8YcrO/hW+tlJh6r27Bp
 7Q7v3v0OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE2v4y1lfwlM6VNqoUW51e
 Wn37P7Nj7d9vfY4ebp3T556u4fFJZWGv2h53l9X10YHorsn5Hn+9GBtWG872r/VmCxeKnvX81Re
 ZHRmOzu3Jt/OP1dsf2nLUfYtRwA6jp3rnp7l++ftyRphRwyMA
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

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 38d176d4eef2..f575b2dbe32b 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -542,11 +542,11 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.mode_set = sii902x_bridge_mode_set,
 	.atomic_disable = sii902x_bridge_atomic_disable,
 	.atomic_enable = sii902x_bridge_atomic_enable,
 	.detect = sii902x_bridge_detect,
 	.edid_read = sii902x_bridge_edid_read,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
 	.atomic_check = sii902x_bridge_atomic_check,
 	.mode_valid = sii902x_bridge_mode_valid,

-- 
2.54.0

