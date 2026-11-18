Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F6606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=eV7oY9Om
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D3F10FD22;
	Wed, 18 Nov 2026 14:34:10 +0000 (UTC)
X-Greylist: delayed 389 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 14:34:03 UTC
Received: from mail-proxy25266.mail.163.com (mail-proxy25266.mail.163.com
 [103.129.252.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3E210FD22;
 Wed, 18 Nov 2026 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nF
 JbK8/dNKLZ9Wci+tDCATwra1Lrr5nEu4JyZ/1PmU8=; b=eV7oY9OmDxaV1muuwA
 ZCyZiRq4q2g17ZIj1bNvWAuk4UOpfpCfPwm8doX9vGKHE3ZcbkgeLY/dvf4vEqjh
 5zE+MVxPT5dQ/b/MhQBSJgxr4u+gkjngZVC7T87h6nndxkiyavIm4Vky/+fsUjRE
 7uevPiAJKsAzddGRKDs/O0jos=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD39ygTtf1qsV7rIQ--.20297S2; 
 Wed, 18 Nov 2026 22:24:21 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, tzimmermann@suse.de, mripard@kernel.org,
 linux@treblig.org, aurabindo.pillai@amd.com, nico.antinori.7@gmail.com,
 superm1@kernel.org, haoxiang_li2024@163.com,
 pierre-eric.pelloux-prayer@amd.com, Ryan.Taylor@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix VKMS plane memory leaks
Date: Wed, 18 Nov 2026 22:24:19 +0800
Message-Id: <20261118142419.2389009-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD39ygTtf1qsV7rIQ--.20297S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1kArW8GFW5AFykJF4DCFg_yoW8Cr4UpF
 48Xa4jkw4UZaykGa47Ja48Ww4SgF48uFyxtrW8C3Zaq3WYyr93G3W8tr12ga9rGFW7Cw43
 Ary2y3yDCF1YkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUO6pkUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RWM+mr9tRU0cAAA39
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VKMS planes are allocated with kzalloc_obj(), but both the plane
destroy callback and the output initialization error path only call
drm_plane_cleanup().

Add amdgpu_vkms_plane_fini() to clean up the DRM resources and free
the plane structure. Use it as the plane destroy callback and in the
output initialization error path.

Fixes: 84ec374bd580 ("drm/amdgpu: create amdgpu_vkms (v4)")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 5c5fdbec93c2..a511322c1c02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -140,10 +140,16 @@ static const struct drm_connector_helper_funcs amdgpu_vkms_conn_helper_funcs = {
 	.get_modes    = amdgpu_vkms_conn_get_modes,
 };
 
+static void amdgpu_vkms_plane_fini(struct drm_plane *plane)
+{
+	drm_plane_cleanup(plane);
+	kfree(plane);
+}
+
 static const struct drm_plane_funcs amdgpu_vkms_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.destroy		= drm_plane_cleanup,
+	.destroy		= amdgpu_vkms_plane_fini,
 	.atomic_create_state = drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
@@ -375,7 +381,7 @@ static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 	drm_crtc_cleanup(crtc);
 
 err_crtc:
-	drm_plane_cleanup(primary);
+	amdgpu_vkms_plane_fini(primary);
 
 	return ret;
 }
-- 
2.25.1

