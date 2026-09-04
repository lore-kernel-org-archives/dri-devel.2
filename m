Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DF0C79F85
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA0210F99A;
	Fri,  4 Sep 2026 09:07:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GyARnHrn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7C310F99A;
 Fri,  4 Sep 2026 09:07:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3245040AF9;
 Fri,  4 Sep 2026 09:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BFA1F00A3D;
 Fri,  4 Sep 2026 09:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512860;
 bh=7QPJ1a0uSHGGju3qMuv+Mq0tRypQw9BlcTk/DvPawGY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GyARnHrncjWYzgvI7vz9BGi9mnBrSDBZ3ll8Q1G75FEZbJfELIfdMipbvQKBqGWI3
 zAN+lWFradQvEkDn2EcTicfu3P/HTZyXUAPSOggdUbKs07u/AiE7VaUWz7ayYHJbdz
 zTDrbC07f9kYV4plgLaZxMSTUyO04hGQtfDHAa4qs1Vy8Pg90cPnCLO54PAlIScy43
 gEEZGUCnF7RhIMg5CjAfTS3EtpEnEMONFsIF1Ftv+RaZW0LlPtaPfY8bxxswA9adMD
 tOOpQDigeiYe+F2D+Ns5EfLG+Q0x/s6tmqjMgoptKz3C+Vn5dV9sSLO2Ermg71NAFC
 AP0ER4YaHCUAg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 04 Sep 2026 11:07:20 +0200
Subject: [PATCH v3 02/13] drm/amdgpu: vkms: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-drm-no-more-crtc-reset-v3-2-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tB9W9rD2KSX3g1sWsvFMesk0h4jhznKPqsIRNFw3TOg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzurxD5lr/rt/TwM69YvabW8myW46tn83JVnxF/miN/
 e/9E431O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEcucwNmxRlbNqu9rv8S1N
 Krr1x+P0Sd+Dbp2ccrFrqu+EQ3sMi3y3sc59aSEow5wQIqOyKEHBn7HhknDmcquQ1KyZXI8Yz5h
 kOMrlMpZH2aWoPv6gzNBc4ttmtLdvznH+JQu+fbTM/zbhmw4A
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

The amdgpu vkms crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index c835504fdf2b..592c5c253938 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -45,11 +45,11 @@ static const u32 amdgpu_vkms_formats[] = {
 
 static const struct drm_crtc_funcs amdgpu_vkms_crtc_funcs = {
 	.set_config             = drm_atomic_helper_set_config,
 	.destroy                = drm_crtc_cleanup,
 	.page_flip              = drm_atomic_helper_page_flip,
-	.reset                  = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_crtc_destroy_state,
 	DRM_CRTC_VBLANK_TIMER_FUNCS,
 };
 

-- 
2.55.0

