Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38756606A332
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DNEFXheC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07D010EA6A;
	Fri,  6 Nov 2026 20:18:50 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B6310E460
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793996322;
 bh=kZs66Y8zCDowdLKEog8fI1dLv9mv2m+LG+S1l3NtB5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DNEFXheCXonUAnTjZcsXS/pSGpUUO+xa+x9BYa+SrqzuGepK9FAHiLBp2a2y3CE1j
 I1xBdPMAtJifpI/LApp/LtuZ80F6AAF5R78mqI9ZOuo+AJ0etLKFiG6FE5U0vcmo0H
 VjmWE8AO9gvyyWhZ/PqyrZnem5M8cLm6zSkU5PlFZ7YaXvB0X7rME0kHURMVf1d32A
 csgUfBCxYQRhVTg73MGwPtzOznANQZ8rNG/qNUi3S55MJkuLVGW2RZ7RQGM1wncUMI
 jpHXS5kejrQqojWFQDfuULI/yNAoz5FADLxY6KOzID0YU/Ehm9/9F3YDTSvI2StWy4
 Db4FB8r7H+blw==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EC02317E00AF;
 Fri, 06 Nov 2026 21:18:37 +0100 (CET)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] drm/vkms: rename VKMS_LUT_SIZE to VKMS_GAMMA_LUT_SIZE
Date: Fri,  6 Nov 2026 17:18:02 -0300
Message-ID: <20261106201813.129911-2-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is the size of the CRTC gamma LUT size. So let's specify this
in the name.

Reviewed-by: Robert Mader <robert.mader@collabora.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 4 ++--
 drivers/gpu/drm/vkms/vkms_drv.c  | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index fe17f49305a9..019d7bc90cdc 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -222,13 +222,13 @@ struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *pri
 
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
index dea6cad3f1b9..34b855431af3 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -25,7 +25,7 @@
 
 #define NUM_OVERLAY_PLANES 8
 
-#define VKMS_LUT_SIZE 256
+#define VKMS_GAMMA_LUT_SIZE 256
 
 /**
  * struct vkms_frame_info - Structure to store the state of a frame
-- 
2.56.0

