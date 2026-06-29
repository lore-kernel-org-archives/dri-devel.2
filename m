Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34D4C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C35B210E770;
	Mon, 29 Jun 2026 08:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c+PHMFFn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC1910E764
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:18:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCC34600E2;
 Mon, 29 Jun 2026 08:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFC61F000E9;
 Mon, 29 Jun 2026 08:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721085;
 bh=x1GbfYc0BiNyZbTihXVIo5XZGJoeZoZ9viKkf0/lShw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=c+PHMFFn9IYOvrdbRD362Dp0VJXORn96xP1FXWz6+xur2Vn1qz/dNow3CI12XFrgp
 Xoute1m9zxLlPUwFYeuPbPZ90HyJrtpDHV62HbtuD3zpqHbYIOHBNcyGcZvlbCC2i/
 E0anT1Kh0N8Cx9b6RbYc5F7X9hCD2A7jojSNNLUqwJTxeQsRM7NKtldrqn9SWQKNJC
 8azjHaaVoIebub7IBB+OLgYVBjO5bNzsVSCWWmKoOR2FgPb4B6ruZyHOWcNjERbnnz
 Nqaba/MdmsDa9r5aW//73Bu4DZ6aH0Db7BemYInJkQARUm6dnr1UST6UMxQ5MNI04y
 X3280qFun8UUw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:17 +0200
Subject: [PATCH v4 19/30] drm/atomic_helper: Pass nonblock to commit_tail
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-19-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=mripard@kernel.org;
 h=from:subject:message-id; bh=crSyq+lP6V5+ZBzZOQ8ztyZYB55iw5QIobUIMwCcyCU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWhxFzgqbjxR8W7+N2S7t1I1XT5+JlPYHP++r/s85Q
 1N//3qzjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARbkbGhmu96RPyRTK7hblz
 3q/QexG1c4oPR+164T8JhbfcD/tH3XZZc1U/paqB1+V99GzXiX1TGBt+T/dhUVr0rqu1KnaX4bx
 Xhjb//54VW3VKTrtBtMC/4bqI6u7pb67VzOR/flPxVue1S6EA
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
index 285aac3554df..6405afc5037d 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2035,11 +2035,11 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_commit *state)
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_tail_rpm);
 
-static void commit_tail(struct drm_atomic_commit *state)
+static void commit_tail(struct drm_atomic_commit *state, bool nonblock)
 {
 	struct drm_device *dev = state->dev;
 	const struct drm_mode_config_helper_funcs *funcs;
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_crtc *crtc;
@@ -2093,11 +2093,11 @@ static void commit_tail(struct drm_atomic_commit *state)
 static void commit_work(struct work_struct *work)
 {
 	struct drm_atomic_commit *state = container_of(work,
 						      struct drm_atomic_commit,
 						      commit_work);
-	commit_tail(state);
+	commit_tail(state, true);
 }
 
 /**
  * drm_atomic_helper_async_check - check if state can be committed asynchronously
  * @dev: DRM device
@@ -2313,11 +2313,11 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 
 	drm_atomic_commit_get(state);
 	if (nonblock)
 		queue_work(system_dfl_wq, &state->commit_work);
 	else
-		commit_tail(state);
+		commit_tail(state, false);
 
 	return 0;
 
 err:
 	drm_atomic_helper_unprepare_planes(dev, state);

-- 
2.54.0

