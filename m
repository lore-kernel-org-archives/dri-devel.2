Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F64CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C38B10F577;
	Fri, 19 Jun 2026 12:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ofsge0f9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2602710F576
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EE54601F4;
 Fri, 19 Jun 2026 12:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF78F1F00A3D;
 Fri, 19 Jun 2026 12:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871941;
 bh=8rw8VSfUt4qY8H3lK9K84MQRce9BuitCLyVZsRf7laY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ofsge0f9eEN3FygJnxNd7dXZKYbsU3fNscHZETHiixe0fN3jMskPP1zbhxuORmRzj
 LgyHsy9YOzxgf3qeW9LBPVfDaTDLrv3JGLwWwP5r+Nt2LDYNjQ0achcRhrdqjtsTrN
 XwV+qrke4Ey0O+XWGDgRAYnUjJDZAAEdkKmVE+I+4W5nS/g6f1I7tepzmJCRT7yqzP
 coRTMzSGVcIOnVni6yoxlIktgjYPR66xo38Eh2KWa2DkwdFEb6dIz/wqk7AbtCqyUz
 OtR9jweplowpHRlKmCMwuw/6CAtICzQ0a65b5kJxASbhM5FDIGEkLMGOLir1Ts5mGQ
 E5I4Qcn5URo+g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:25 +0200
Subject: [PATCH v3 20/78] drm/bridge: inno-hdmi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-20-ff399263111b@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Andy Yan <andy.yan@rock-chips.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Z7W/2pyMgTacesqvth5Nffvalz5jI0BnWx0gW6jpcCQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJp+Wc2jtq67rN3wxbXrDju9iIZOezrrm1/j9uuJju
 1kVMvVJHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiLO2MtfJG+96WZiw4V87a
 kZ5zNDX79qk4h1JH48Uhiw0C845dM0k8Kq7Rf0FD1b/w1MKOR3MOMzacmuR24Vj3P3uhBfPS1ln
 4HLp74Fqpl5ZX9/aP5kbRjS0KF15Pf/Kd51ZVsZ6nc1XA1Q0A
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
To: Andy Yan <andy.yan@rock-chips.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 5fa533a4eb34..1e2a039cf9e8 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -877,11 +877,11 @@ static void inno_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs inno_hdmi_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = inno_hdmi_bridge_atomic_enable,
 	.atomic_disable = inno_hdmi_bridge_atomic_disable,
 	.detect = inno_hdmi_bridge_detect,
 	.edid_read = inno_hdmi_bridge_edid_read,
 	.hdmi_clear_avi_infoframe = inno_hdmi_bridge_clear_avi_infoframe,

-- 
2.54.0

