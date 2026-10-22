Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F25606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nO4KgITd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C92211125C2;
	Thu, 22 Oct 2026 12:36:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29AA51125C1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89ADB60200;
 Thu, 22 Oct 2026 12:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDBD1F000C1;
 Thu, 22 Oct 2026 12:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672574;
 bh=JV0+hDXKStKI5k15ediYrUt3eXeXdrAVMPA+rGZ5BsM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nO4KgITdLOXp+DT3ZZlyonzv8rREQkKD1yPffwCAj1tHpSHdcCk4dLUOcyWSAINRl
 86Sm9tWQHX90UTDhfMIA+bgEFXidaAMpSt4q2ukOO/0X06vsfYzdGH9QxvUTsc7Eh0
 hjfhQPx2C9q3ssJ5PDMHgFMHLqyaqNYUVe875mKs9yzkYO2L1oMpIeBtLW2bcwtrBV
 UAbfM5Rpt7LqW2f5rZzDnueD48pzk+X7bitwSs2x9mw9tLPva+Hz8dmunzln9Rq+v4
 +zY4ykSQ1S5faG2lxMumqRzvouK03lUaSDwWPW8VU5+DgpSbPVYp3DgdfMweVH4PhG
 AUullOaCcOPpA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:40 +0200
Subject: [PATCH v2 41/59] drm/virtio: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-41-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mOZHvFMKTAxNZ1n84M8aNw7rOQfV229UcP+u5Q44q
 93LsUCxYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyk4xVjQ4fZs/x/pXEH99wX
 zd/d3pH1Mr7hnr6wW1bfIbGCjds8uK9v4uY4pC5+K0Sn+hQLe2wfY51N16JCeTdu8QhppUfqbOd
 /Bx9V14t66rj8hfqzGY7TF90risv+x1+5/pp2yVSOFAuzGwA=
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

