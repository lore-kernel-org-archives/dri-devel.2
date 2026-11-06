Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B3606A337
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jLEhCmgB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89E9112FE0;
	Fri,  6 Nov 2026 20:18:56 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9769E10E460
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793996328;
 bh=BVsbCP7VqTFCT6SRxxFnhfIQzfF14Yh2kgAKnHLQtg8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jLEhCmgBPR/s938BKJcGd8KJUbiznoxxmrXL4a+z5hu/kpzgG/bOo4KZG1rYkx4vn
 Fut4ynUn5ispg67nOVUXaK/zZs36/qkmT2E49oROyo1/bQn/z0cy/X1AAx5IrvlvrP
 sEIAWBZI5WhszfzBkMS1KmgYnFQ2xeh4yNtwJWRW7LWQ5vVxRv7f1xDzuynCQGrLug
 yv6dzHrR4j21fgUTI6SX17ovIPE/kQkTp09vuPe4Hm/Sh+vPKBVC8LK39ngOAXnjsE
 uBJY49tfdbVuUeZQu2SItkclwntLwwbbC3A2TjPx6xxJ/v805aNAdVfnOWFqNYDz9O
 RaF+BnfTLJYFQ==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5FBBD17E0885;
 Fri, 06 Nov 2026 21:18:43 +0100 (CET)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com,
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 02/12] vkms: properly compute gamma LUT size in
 vkms_atomic_check()
Date: Fri,  6 Nov 2026 17:18:03 -0300
Message-ID: <20261106201813.129911-3-leandro.ribeiro@collabora.com>
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

Gamma LUT size is being computed wrongly, dividing blob size by
sizeof(struct drm_color_lut *). But the blob is an array of struct
drm_color_lut.

Replace sizeof(struct drm_color_lut *) with sizeof(struct
drm_color_lut), properly validating the userspace gamma LUT size.

Issue caught by Sashiko bot:
https://sashiko.dev/#/patchset/20260804203351.148521-1-leandro.ribeiro@collabora.com?part=1

Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Robert Mader <robert.mader@collabora.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 86a8a95694fd..28b99511f186 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -112,7 +112,7 @@ static int vkms_atomic_check(struct drm_device *dev, struct drm_atomic_commit *s
 		if (!new_crtc_state->gamma_lut || !new_crtc_state->color_mgmt_changed)
 			continue;
 
-		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut *)
+		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut)
 		    > VKMS_GAMMA_LUT_SIZE)
 			return -EINVAL;
 	}
-- 
2.56.0

