Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4E3C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87C910EB94;
	Tue,  4 Aug 2026 20:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="q1LUtOH4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1759D10EB94
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785875724;
 bh=oyOvCIC0dkg+UAdkOylLepJ5oSgJZ02taUL+sCH+3C4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q1LUtOH4GiU6RFWbRQX7G02iL6x5PSZZKeNIRxO5mNxM758TBkzqfg5nzceIA8+aS
 pFaYOLT9ga+X3hQ1vK/jFhlWeqZRwbq2kG6htt1XkAfpwEzD8MZikZw6FdI78SYh/k
 buSqivyZ8WjCuLMbOvbDVAvJ/SnpZpzHnjY9yvmkThUM9QiezVPgoZuSzQbA/ZgV5o
 dSLj6+94lppynRJjWqz60c+10+r/Ru061qL6ZoYIJUGLUF60Jl1BwdcAY1fNH8SBjw
 xk0cVTAz+5IrO5YHrFyLiYO5vkqbNH3oS+p6ujtZOB4hSHu7RKCjdcglsUpx0OZMc4
 1It6xYOWIe5FA==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 016CF17E0A50;
 Tue, 04 Aug 2026 22:35:19 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] drm/vkms: rename VKMS_LUT_SIZE to VKMS_GAMMA_LUT_SIZE
Date: Tue,  4 Aug 2026 17:33:41 -0300
Message-ID: <20260804203351.148521-2-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
References: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is the size of the CRTC gamma LUT size. So let's specify this
in the name.

Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 4 ++--
 drivers/gpu/drm/vkms/vkms_drv.c  | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 079abfba427d..54ebb112b3b3 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -220,13 +220,13 @@ struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *pri
 
 	drm_crtc_helper_add(crtc, &vkms_crtc_helper_funcs);
 
-	ret = drm_mode_crtc_set_gamma_size(crtc, VKMS_LUT_SIZE);
+	ret = drm_mode_crtc_set_gamma_size(crtc, VKMS_GAMMA_LUT_SIZE);
 	if (ret) {
 		DRM_ERROR("Failed to set gamma size\n");
 		return ERR_PTR(ret);
 	}
 
-	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_LUT_SIZE);
+	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_GAMMA_LUT_SIZE);
 
 	drm_crtc_attach_background_color_property(crtc);
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b531d88..86a8a95694fd 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -113,7 +113,7 @@ static int vkms_atomic_check(struct drm_device *dev, struct drm_atomic_commit *s
 			continue;
 
 		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut *)
-		    > VKMS_LUT_SIZE)
+		    > VKMS_GAMMA_LUT_SIZE)
 			return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 0933e4ce0ff0..1975843abe92 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -25,7 +25,7 @@
 
 #define NUM_OVERLAY_PLANES 8
 
-#define VKMS_LUT_SIZE 256
+#define VKMS_GAMMA_LUT_SIZE 256
 
 /**
  * struct vkms_frame_info - Structure to store the state of a frame
-- 
2.55.0

