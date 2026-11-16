Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E04606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyZDKmkh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E0910EF2E;
	Mon, 16 Nov 2026 10:34:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F345B10EF48
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:34:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77D1C628B5;
 Mon, 16 Nov 2026 10:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9383C1F000C5;
 Mon, 16 Nov 2026 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825255;
 bh=kwWL85DvbL7XKrUJDk10MPgh9+qW3+FduSxZ9X1zd7M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TyZDKmkh6Sn4ckfRxNiEQvxZvHFrEpXcLHBII5UwOhMPUHnzTaCVfTfAHRqTGmCzj
 WsRWlFjctmPrZQGcKcA6cfuyqtKcI0XtwPzAnssmmnIuE7LEpZIs3jvNr35lrskNE9
 8JRPObz9sNK9m46BQ0AepmUSzSBkYK/YgIp0WNgrqdO4h0YQJB0lCahCkiU78znFRJ
 0RUhgPWnZ1tqi2k2T8nUtWarBr/QPHXT3vJ162canEAvwKguw06XMXzsTQ1ojh1V76
 7dpas3YKyO/cIPY0g8FAxyEwOV4NEs8AXmKH1pmFAKjbQMkNTXK0foQZF8o6xKgvth
 knr2O79OPa71g==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:17 +0100
Subject: [PATCH v2 61/64] drm/virtio: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-61-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/KWCci4W0cvR7zHEBm01obn96MRNEVuD0Pd2PNYCxts=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bkcb/BFLf1nB+Etw01T5Wf69bJ4GlmFum2I/fviae
 2GmR7B+x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZgIsxVjfapDj7UIR4LyZLcD
 R74c/fKJZclPpo+Jp79H2ltGP56+Q5F1m6sHn4y2+/6g+Qeuqb9vZmz4bDwjxyJFYvrGv5WdZ5u
 +Riy3uN3BzsEa2/nBfad264KCg1WmV6wtX/VtPjRx7lPd5wsA
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

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index f0ed9bd27a91..dfc3aed03b8e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -394,12 +394,11 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
 
 	ret = drm_vblank_init(vgdev->ddev, vgdev->num_scanouts);
 	if (ret)
 		return ret;
 
-	drm_mode_config_reset(vgdev->ddev);
-	return 0;
+	return drm_mode_config_create_initial_state(vgdev->ddev);
 }
 
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
 {
 	int i;

-- 
2.56.1

