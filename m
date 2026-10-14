Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44130C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9668710FED9;
	Wed, 14 Oct 2026 17:28:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD58F10FECF
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:28:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C628B43FDE;
 Wed, 14 Oct 2026 17:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266541F000C8;
 Wed, 14 Oct 2026 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998926;
 bh=Sn2dJqJd+7RqDgM5hgTbU5XJC2cBIQSgz7OZ1JFGbQw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KnU7tmJxo+fJOuaqnMZfD3Je9k4Tio7WmBptnZoH5YIahF7QoiZMm1Am/yVm1oKg3
 f4lIwWxwvXmhMIs5B5lmLxssrd+kfQyrFmeX+jbu8t+beYDYu5SMhN1EjcrE9avzyx
 xgBX+Pj3tbPPr1c+//O5GPsJCDCOHS2XCtrtnKnIxk29yRqjhIRxoO8h/tu3qG99Lh
 t80dfWYM7dwkmmHGLTixR9hP5ZF9CibLEAMnn35zAvPRL2URQdLzwLJ4bD8GSrMFc4
 dirhTqo4wJnr04MQyteo1XsO2awe/FtYMpfPi7NuQuBKngPfdLNASlVcL30NfVwpEw
 lWQcYew7ehnSQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:49 +0200
Subject: [PATCH 26/75] drm/logicvc: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-26-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Paul Kocialkowski <paulk@sys-base.io>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=mripard@kernel.org;
 h=from:subject:message-id; bh=nNeoa+pZlkRh8hr31y8UApEVHEaMmWBU9ERJwgG3XNA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4fOWS92See0ymPvyRzluz+c/PTwVtp2ndR3l1ZcX
 TujJur9446pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAJwk0sYG1av+dnDNLdC3Gdb
 nYrBSmeBCX8yLr6bF3A//Fb3tDTTCYfel8fcT3zkKic2M9tKfH7WbMaGKwK9Ad8lZ7MaPJwy6dx
 vr/jYbOZ3oYkCxvXau7bqHC/wXnNhauPvniiGnJRrja+nXL8DAA==
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

The logicvc connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Paul Kocialkowski <paulk@sys-base.io>
---
 drivers/gpu/drm/logicvc/logicvc_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/drm/logicvc/logicvc_interface.c
index 81f760dc07f8..a2ea22bb4643 100644
--- a/drivers/gpu/drm/logicvc/logicvc_interface.c
+++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
@@ -85,11 +85,11 @@ static int logicvc_connector_get_modes(struct drm_connector *drm_connector)
 static const struct drm_connector_helper_funcs logicvc_connector_helper_funcs = {
 	.get_modes		= logicvc_connector_get_modes,
 };
 
 static const struct drm_connector_funcs logicvc_connector_funcs = {
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

