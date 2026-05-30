Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26506CD6E58
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEE0112831;
	Sat, 30 May 2026 14:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NVtQXKp8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B6B112824
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF2B8600CB;
 Sat, 30 May 2026 14:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CA31F00893;
 Sat, 30 May 2026 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149702;
 bh=0ZvSseZz8yDy8eTWtmrDADKaYL26eKaK4CKN2qMt9xI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NVtQXKp8IgCYIGNyZ7A9MYC0PZRDL6UmLhfoLbff72I1Ib9z5o2sWwquLsM02BkuT
 W/sWTcijBT2PuViVJlWjSJeIIXEjrxtReFUnFp5JNAPQSKO8UlL/SPlivjpJJWB79/
 M+v7nPDycoHheN0RGg9Z8SAgF/Zx5JNu5Ry0bE01YLWeWElUkUZoV5DlxvvdnLX8CB
 kBH4g+S7E136B2ljFy2E91PaO/dfZicSYxBDKY6fVXqJuzjQyX1t2rktWK8s39OAWl
 mVHOyl1qLB2xGBOKt6h3JNsqGm/qNYeX0meWb86m/LvDlLl0r1AdWy+FbMei+5Ombm
 Kgp3iEbwDD2gg==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:45 +0200
Subject: [PATCH 40/76] drm/bridge: ti-dlpc3433: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-40-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vkhhUX0gJIQKSe5JxUpeqtvRjXUC26NiXR5VSj5tllA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb90/Gsx/fibxk9oOA9eSH9UbDCc+/drMsSFtl59fj
 WH4pIb0jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRf82MDXc/pfCvdpm2a5HZ
 /yWvOplXmbkU/XNQLjr7MvjhzQWv0ljCH5uvaHhku9Vtts6KyTtuKzPW2dZMWtrFvUPgmo/aZvs
 EewOpeF8VweUNJglPrgnaqz3eY3/nj+5xfvbChbssq+cVi50DAA==
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
 drivers/gpu/drm/bridge/ti-dlpc3433.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
index 9c35eade0a78..c16eb3a05cfa 100644
--- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
+++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
@@ -252,11 +252,11 @@ static int dlpc_attach(struct drm_bridge *bridge, struct drm_encoder *encoder,
 
 static const struct drm_bridge_funcs dlpc_bridge_funcs = {
 	.atomic_duplicate_state		= drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts	= dlpc_atomic_get_input_bus_fmts,
-	.atomic_reset			= drm_atomic_helper_bridge_reset,
+	.atomic_create_state			= drm_atomic_helper_bridge_create_state,
 	.atomic_pre_enable		= dlpc_atomic_pre_enable,
 	.atomic_enable			= dlpc_atomic_enable,
 	.atomic_post_disable		= dlpc_atomic_post_disable,
 	.mode_set			= dlpc_mode_set,
 	.attach				= dlpc_attach,

-- 
2.54.0

