Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC6606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPqXtwi2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B711127D2;
	Thu,  5 Nov 2026 15:35:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13CC11127CB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:35:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F136140BC3;
 Thu,  5 Nov 2026 15:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EF51F000C1;
 Thu,  5 Nov 2026 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892899;
 bh=4MSsUxDulFewsTAdZFuJCjltliXHaoHQchWPzOduXZc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nPqXtwi2fgt1ncQvsKRUB0BoqCTtyWIccvGuCS+NfcJP3ziGm/AfzRWN6b/qfEPQ7
 14os21GLUZamee4uKHC4fubMf46C7TDnNLHinvoUI5rm3kskcULRZsWSIxlfkZpto0
 3u/Y3/vQSGiPUtG115QMD07nyUG4B0Enyj/S6UIA+7X66zsGR4LlrTPgVhdLyc+EOb
 +ZVvX69SMPDsIkMXfbkotv4UHwZLP7YtHq06UAr/jo0rsh6BN0+sYmlW7ojPSa7uf2
 y4Plk2Dmho1Z/EL6KmlQ5xwayVZ+bwKrGGgnw63MuC2bt0JrqKvif3+ybIlx93LWXB
 KY/RDGvSCAYzQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:28 +0100
Subject: [PATCH RESEND 79/83] drm/virtio: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-79-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=mripard@kernel.org;
 h=from:subject:message-id; bh=T+TESsozrvSq97ycIKGAiBu3kqjoAgmAIJUqctHtT0I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjLoz+hr6LoXbWV/YOLemzdqeHPC2bSEWLTOaah7/
 VavcznbMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYyfwVjfajMZEn+3s1rz3Vc
 +Hw/bf5s3esbn3inPbM9pPzx/NIEoVxJxr4LEp0cuz52OFa5fjg7kbFh8dnaG4VvokolzWtdvuo
 u/XrQR3XxB5kVi48lOUlHTdyed0hhz+ebHsKMzPu6W/dZ3EgHAA==
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
@@ -397,6 +397,5 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
 		return ret;
 
-	drm_mode_config_reset(vgdev->ddev);
-	return 0;
+	return drm_mode_config_create_initial_state(vgdev->ddev);
 }
 

-- 
2.55.0

