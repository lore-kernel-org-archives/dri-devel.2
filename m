Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAF6F99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1704110F035;
	Thu, 23 Apr 2026 10:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i7z4N6Y6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757AC10F075
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EA76D60052;
 Thu, 23 Apr 2026 10:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D596C2BCB5;
 Thu, 23 Apr 2026 10:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939562;
 bh=M0DI3IdcW65y3o2L1ziOAG5YYDhmXOczwUugss1u7ZU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=i7z4N6Y6D+1rzKrj90VWd67eB5lzFI021Hswbe0Nthz0nGc6k8DPUS56P/nG/HauL
 o/nsxUmqBsM/Hs12laBqiXedDfqjQpk+WO8YVnpN1myxUD5dHgyjA0hdF9izD67GVj
 m65GhAZMAzBzbTN+bIUW5HRKOfggrqucnwJUP3AP/Opu/ZSdrGDTj31F7qBc6R5PRP
 CW1gpn8kHlO3OgKOZzUtYQYThVXjruat/a5ZNE3HJ+Csa6Wg9laMUuvuBx+TQywvfp
 Lp2s/u2D/UBCtTlArIlOD8NdM5j+J137YhCyDJtjkjS1vlG65LTlbS/B8pujyj8eSp
 sofkuBnqVb0HQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:31 +0200
Subject: [PATCH v2 18/28] drm/atomic_helper: Pass nonblock to commit_tail
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-18-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=mripard@kernel.org;
 h=from:subject:message-id; bh=M0DI3IdcW65y3o2L1ziOAG5YYDhmXOczwUugss1u7ZU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP75/2zr92JENsc+X57DkXdm6fNHq1MDV901nHbc/U
 vyj9+LLCx1TWRiEORlkxRRZnsiEnV7evrjKwX7lD5g5rEwgQxi4OAVgIjEfGRtmGP/102fd+d2b
 XcAl8aFKRHhF1X4blahUx02rTsnc/H/riF+q8mLmJSWv+W73CclNv8lYK/UoSa/+V2j2tDjLolK
 3SNaU/Jccb4/eWpdqunXj2XLWStXqMznXpttJTpvpNsPjvaAIAA==
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

The state comparison infrastructure will need to know if a
commit is blocking or non-blocking in commit_tail. Pass the nonblock
flag along.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 26953ed6b53e..9deb3dad34a6 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2029,11 +2029,11 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state)
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_tail_rpm);
 
-static void commit_tail(struct drm_atomic_state *state)
+static void commit_tail(struct drm_atomic_state *state, bool nonblock)
 {
 	struct drm_device *dev = state->dev;
 	const struct drm_mode_config_helper_funcs *funcs;
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_crtc *crtc;
@@ -2087,11 +2087,11 @@ static void commit_tail(struct drm_atomic_state *state)
 static void commit_work(struct work_struct *work)
 {
 	struct drm_atomic_state *state = container_of(work,
 						      struct drm_atomic_state,
 						      commit_work);
-	commit_tail(state);
+	commit_tail(state, true);
 }
 
 /**
  * drm_atomic_helper_async_check - check if state can be committed asynchronously
  * @dev: DRM device
@@ -2307,11 +2307,11 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 
 	drm_atomic_state_get(state);
 	if (nonblock)
 		queue_work(system_dfl_wq, &state->commit_work);
 	else
-		commit_tail(state);
+		commit_tail(state, false);
 
 	return 0;
 
 err:
 	drm_atomic_helper_unprepare_planes(dev, state);

-- 
2.53.0

