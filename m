Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B10C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFF710FEF8;
	Wed, 14 Oct 2026 17:30:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9AB10FEEB
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D31D46022E;
 Wed, 14 Oct 2026 17:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF881F000C4;
 Wed, 14 Oct 2026 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999021;
 bh=zRJQ8BGMbAOnp/rvE0+RdIyNcCA0jD4VwebdD+8Nq5c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XHH+iYzMSctBIjX6cYXRXVwKRtFXsZ/yD0N4/RdPx2Abg80YEN3p+CTLU+OUs1uzt
 EJbMkUKGk1cj5eFuesx0t9RgaiIgCAtw9Ea0Gr/Ugi+5SBiqGmEyQSUsmursVofM2l
 gAapX2oTRW2bQeN57IFKUti6Ll0nIocwZ2uhmpnsHJPGq8TYwLx7vljS4ovufBlBr2
 s8jxNKDnN4ejw+d81ZtHxTr4cWK8RMtnD+8nXQvA04PW1QGWON8MhXN86PEGnuOiPy
 +8JRO20LLzbK0/s1SVDUOBQsqap6NKp1S13GiD8RF6k7MuYaCCt4OFSwwaU5vw6W5S
 rcnbYEQ/ix7xg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:15 +0200
Subject: [PATCH 52/75] drm/virtio: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-52-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kGMdDttyNhDYgu9OXIpibrgOeAy+z20/ZBmsJbJHIHI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndyeufbk0WcuV9aHkDYbHMvIHBdjm/MrWnfLhisGT3
 XWn0xXkOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEvixibNjWvXvpV6PQiuwF
 s9TOftC1ubM3U7pcMsqx0etmwU5PddHIE7zXNoZ8+PbCfUvly/VySxkbvjxfEa3h88XjzMM+c93
 fD7tlojdZGj+6edH64qPX1afa7ofc+3XV+qWXueIjY+7Q3PQkAA==
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

The virtio connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index b60aab07e78d..f0ed9bd27a91 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -268,11 +268,11 @@ static void virtio_gpu_conn_destroy(struct drm_connector *connector)
 
 static const struct drm_connector_funcs virtio_gpu_connector_funcs = {
 	.detect = virtio_gpu_conn_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = virtio_gpu_conn_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)

-- 
2.55.0

