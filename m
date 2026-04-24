Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE0AFF885A
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 00:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F327210F716;
	Sat, 25 Apr 2026 00:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="WOcbttiG";
	dkim-atps=neutral
X-Greylist: delayed 342 seconds by postgrey-1.36 at gabe;
 Sat, 25 Apr 2026 00:18:32 UTC
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [95.215.58.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFC110F714
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 00:18:32 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
 s=key1; t=1777075974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chJOcd0DtmPp/g4ereI9hdknMHM8JOupi0CaWwBC/z4=;
 b=WOcbttiGekK8ugcVqTepHMYNbWVJqpxhR8MWiyRJ0FBu4kdfvgnWlEOCQK+EqCktZcT8wh
 dUbAFLbkcNLWjfzKzAsAqzZkNW66A8gd8aXtZvkJkazHGML6iwecgcVz/rV3TbNCSWyWRi
 iyvtEr8iTXc7jOYtwGUcswPuMJmZMqbRRY1+uuatkxGxQb1G47eU0aZ07/EIpFQ2qyfPTb
 IStemv5RPQkWWVFB7AFbcgXNQmQIeMEdaWlFjfIPb3VqShJuZvbs7s8Ue2o42zKWT6Nc0M
 29BrYoeJgfa/Tl40AoHV3hKJhVdsVD1kowrFvT5/sL0OtgXKpMIKck6v5XmnCg==
From: Val Packett <val@packett.cool>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/bridge: panel: call the new atomic panel ops
Date: Fri, 24 Apr 2026 20:49:51 -0300
Message-ID: <20260425001130.233935-2-val@packett.cool>
In-Reply-To: <20260425001130.233935-1-val@packett.cool>
References: <20260425001130.233935-1-val@packett.cool>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

As the panel API now includes atomic versions of the power ops, call the
new atomic wrappers in order to allow panel drivers to access CRTC state
like the mode being set.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/gpu/drm/bridge/panel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 184a8b7049a7..3d3aca6416d2 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -126,7 +126,7 @@ static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_prepare(panel_bridge->panel);
+	drm_panel_atomic_prepare(panel_bridge->panel, crtc, atomic_state);
 }
 
 static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
@@ -145,7 +145,7 @@ static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_enable(panel_bridge->panel);
+	drm_panel_atomic_enable(panel_bridge->panel, crtc, atomic_state);
 }
 
 static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
@@ -164,7 +164,7 @@ static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
 	if (new_crtc_state && new_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_disable(panel_bridge->panel);
+	drm_panel_atomic_disable(panel_bridge->panel, crtc, atomic_state);
 }
 
 static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
@@ -183,7 +183,7 @@ static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	if (new_crtc_state && new_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_unprepare(panel_bridge->panel);
+	drm_panel_atomic_unprepare(panel_bridge->panel, crtc, atomic_state);
 }
 
 static int panel_bridge_get_modes(struct drm_bridge *bridge,
-- 
2.53.0

