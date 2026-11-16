Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30673606A885
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPcAUl4t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4796F10EF03;
	Mon, 16 Nov 2026 10:32:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE99510EE50
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D70F04051E;
 Mon, 16 Nov 2026 10:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9AD1F000C5;
 Mon, 16 Nov 2026 10:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825131;
 bh=Ik9s7zHABhslFaBkohGAlCRXA+3RkcAiVe0El12BRwk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SPcAUl4t5Kv+RQ+cOl00XwSC8NnoN5D+08v7lfwfBJf/mQG9l4jsSshLLw3BsiRjP
 hXPL/elfau08z9puLgMMMQP63RcO1NzGk1SgSdg2XGiCxfwFDfXGCnnj+WMntJ+V+2
 HEDMT9hHJM6HJ2W3aXZInH74JmsMh95NZyVbUojgQiPm/uXOp0hD3BhzSKQ6rgQP01
 wRMjJEH/qtC+9KPznUn6lmJ8p5eSjr5mdnVHVtmEGAkSW0T4gHY+bQ/1moZwMuzxzu
 O2YPFasz+5J4Gf1Qkbu8EFXJHWiO9ajydUBEP6IWORCQTIFjJM9qhiSpwKyIdaqzPV
 GgNflWh4LM7hQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:39 +0100
Subject: [PATCH v2 23/64] drm/qxl: Destroy the monitors object on the
 modeset init error path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-23-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xoBUO5Iyitm6N7CJ7p4XM520aW8Xt4IYjML8AJI1ttY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bnv9j70f7qoo8WtJ4oLnKo6v9+x9uHZquRsbc3km3
 5ZXgcVHOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE/rIzNszxtbjQeVI4br7s
 nsUpcRk73wTc7E+cfe3LFVbbaYsz/9e+ntgS1+BpNskiMCf3I+eW64wNHTa1x2U3LZltuWhey5q
 WPUHOFwsOxod8KfRfWzN5zlxLrv78/9GLbVZ3rfnr+t9109w+AA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qxl_modeset_init() calls qxl_create_monitors_object() early on: it
allocates, pins and vmaps the monitors_config_bo buffer object, and
points qdev->ram_header->monitors_config to its physical address.

If drm_vblank_init() fails later on, qxl_modeset_init() returns an
error and qxl_pci_probe() jumps to the unload label, which calls
qxl_device_fini(). qxl_gem_fini() then force-frees the still pinned
and mapped monitors_config_bo, and iounmap() unmaps the RAM header.

The devres cleanup of the DRM device later calls qxl_drm_release(),
which in turn calls qxl_modeset_fini() and
qxl_destroy_monitors_object(). Those write to the unmapped RAM header,
and unmap and unreference the freed buffer object.

Destroy the monitors object on the error path, so that
qxl_destroy_monitors_object() has nothing left to do when it runs
again during the device release.

It will also be needed when drm_mode_config_reset() gets replaced by
drm_mode_config_create_initial_state(), whose state allocation can
fail.

Fixes: e485883c815ee ("drm/qxl: Use vblank timer")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-199921@kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/qxl/qxl_display.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 204c47d61373..77fbf3c864cc 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1308,14 +1308,18 @@ int qxl_modeset_init(struct qxl_device *qdev)
 
 	qxl_display_read_client_monitors_config(qdev);
 
 	ret = drm_vblank_init(&qdev->ddev, qxl_num_crtc);
 	if (ret)
-		return ret;
+		goto destroy_monitors_object;
 
 	drm_mode_config_reset(&qdev->ddev);
 	return 0;
+
+destroy_monitors_object:
+	qxl_destroy_monitors_object(qdev);
+	return ret;
 }
 
 void qxl_modeset_fini(struct qxl_device *qdev)
 {
 	if (qdev->dumb_shadow_bo) {

-- 
2.56.1

