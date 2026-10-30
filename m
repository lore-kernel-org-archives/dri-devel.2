Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKMVIJbx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C0B11288C;
	Fri, 30 Oct 2026 15:15:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BEF811288C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F634601EE;
 Fri, 30 Oct 2026 15:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C611F000C1;
 Fri, 30 Oct 2026 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373317;
 bh=JV0+hDXKStKI5k15ediYrUt3eXeXdrAVMPA+rGZ5BsM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZKMVIJbxqjB52DroTqc0Llw5xUdK99yYEqexfLBS2K6flEB0k0RiAWXOX15lP/0k5
 AKG8qrAGo6yxQvTb0l8ujzoEN6IAmzlUpJ8k64lJBb6uhX/XolKKu3sLamljh2RK0K
 Y9VB+97VLiPblk5SGGXifli7Iy9zqh/WFdIkrscvjUmtPjOU8TvcFGKGomsTAHlYOx
 CfzEBlW+gdUzRjNHIMJiICUv4RiO6RL902Jcj7/NEXFUYm4OK8IJttNmhLb/dc8+Aw
 Gqd+WiLFC3SIpXRqbZT3BKlMLZHRS++MX2iD3DEoH0IMMxAX9DoXjAs4BdDKcM2ejG
 pRJAnYGSxDWWA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:53 +0100
Subject: [PATCH v3 23/37] drm/virtio: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-23-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+tchhSPJrPxzTPXw7MeGEfbYaaYl1eTMahtrArMuNTc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtqjnuqVfc/ks+Ms803hKEMP1uNrvmknuVSVPK3UD+
 bgqldZ1TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInISTDWlywyuqsbyTXt7Vbl
 xft/3WHRnBtnJL7lVljSyT8sNtypE50YhWMNeVMfy1bGHJFaa13NWGe0Mvomj+CtqlKVf3k+W9l
 DdopWnfy3pWoRT+WVmR9KFzoff/JPa9broJPHGTq2SG5tzgcA
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
@@ -271,5 +271,5 @@ static const struct drm_connector_funcs virtio_gpu_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = virtio_gpu_conn_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

