Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0391CCD6E57
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179D8112811;
	Sat, 30 May 2026 14:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T8UCkfnc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6C610E36B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AEEF8439B7;
 Sat, 30 May 2026 14:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1781F1F00893;
 Sat, 30 May 2026 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149624;
 bh=2PU1835ktpZB+lauMj/7mnEOwNX1BCjUcPTwO79Wr/g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=T8UCkfncBuIpVDLUvO/srTFpXFtqmH4/NpezInE159m/YWS6he+h/dk5NxlpFZCh0
 MbKBGngoJNqT3kYdd6DkbbTjarV3AIJTt4Z90ifazIXhVIj0fRY/moj4hH2gNsehz5
 wF6iyRjAnKHtIoJw8M0aVEClLnKg6IVXECLUPhmOS1c/RzLF63FFg45tWbgDivdw2k
 HQeERpDjMXbiFQ9+tfqWJ7gxyUOilhOkWcpNuSPWZXkrmETOcYClWxAQL2gbUq7zqt
 QA5qvi5CtsA6/uQtN4dHjF9+HSn43zuozRiB8ri/rMDn8UVdb0dRK4SfXVYtiC+tL6
 FPc6BMAtRYqYg==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:16 +0200
Subject: [PATCH 11/76] drm/bridge: fsl-ldb: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-11-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=mripard@kernel.org;
 h=from:subject:message-id; bh=MyqYihwMOUVq92LvhzrM7pfxuMwTV77IU2E/JdWKbaI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb62sDunaW/Cmy08UC+j5d95hyrpXbS/fH9mqdel+4
 6LyM/keHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAin0MY672/bGqbtsZP5qv1
 qUPvQhb+srd/HHxSJibIfJ/6PlHjhPnhXaI6gp5S73z03kpk1/vNYqzh7f7zwuaJVNDfiY/vNG7
 f2OPuncmh5P38R7eH95x03natJv9zPzoMGVWMNjxmYxQ/uRUA
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
 drivers/gpu/drm/bridge/fsl-ldb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 9bfaa3f93370..cc1f88e7873e 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -287,11 +287,11 @@ static const struct drm_bridge_funcs funcs = {
 	.atomic_enable = fsl_ldb_atomic_enable,
 	.atomic_disable = fsl_ldb_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = fsl_ldb_atomic_get_input_bus_fmts,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.mode_valid = fsl_ldb_mode_valid,
 };
 
 static int fsl_ldb_probe(struct platform_device *pdev)
 {

-- 
2.54.0

