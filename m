Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436DAC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF0510F30F;
	Wed,  8 Jul 2026 22:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJzTImP8";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC27010F30F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 22:21:11 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-80d33d13a23so15746457b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783549270; x=1784154070; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6ryEBOu0tdMaJYn0ZWk82G78CEwzIufJFF6xesijT5I=;
 b=AJzTImP8z5+C4a/AqLFGI6+CP72moPwCjMvpTtdV/+h90bZOV8onysxCNm5hHJFXNm
 Z+FxTzr0paLCu87JzIsgDyycwXTM7AGVWo0PEwLw+qauztUNtrYgBwRZQJDF/klANGvm
 ZypKVkTpjYs+I5tGqtPaASodUISamBIs6YaLnz+f9y/3TbAJD3gC012l1SmhkoIN5oDK
 VwW4y+tZzaLcr1JDYARkgYt2U6ljXZOpwWByJLR2CKYIIqKjJVEvjL6+K89S1qdLHnt9
 jXezdKZR0pItPyULoZ0JC7m8wYxGZOVImTPZMArDQaIE1KblsTAQIH8PGToZPHIStEms
 YUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783549270; x=1784154070;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6ryEBOu0tdMaJYn0ZWk82G78CEwzIufJFF6xesijT5I=;
 b=CfRzZIYo70rxj5CEyUl+7M42at3n56K1iWroG0UsdfMLYpHCZ1U71HIWA1s/C8YZBL
 bO4gv1rgIXSfEKI4PwH7roajjyZjRj2GnT4SnTB7PKu7Dom+DFT+YJHZ24BGD4Lpto8h
 DYF0uCfg1fFpenEuU+nnEcyRDFnLAowtD8wHAWv/wpgs3tqokzpcsBwZgsZQvdUfuyRr
 SZ23iXl6mLJr06lI/bSglN/H3/iolsqs7jXSJbf5Ec1HkYQ7ScvcwyEGCnls9X7KHIeI
 h0uw6Ve7Y3NuevFDCdxnUCr1xQkfSaUyQBxCO7d1K1gsNA5bapnsu6ewwOaOsGkpasGt
 yPBA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrn6js3+Fj4Mv8bBhP/dOALLJxYR3WAPtB5DShqwHEMislh1ex8i2+QMHHST1WZmAQrmHSOcENb8ks=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGIelWA6WHqBiK9ZDc4vPRPNFtur1LY5/OXLAb2VmqlR83dZjH
 JuD3Xut/4og5valG8RJwIA340PAVxmoviJQ1obPGIL/jE/XfP/pnEQo=
X-Gm-Gg: AfdE7cmAgSCOF8MV0rBzcU0pASyJQ0+NmZJCzhjaTKB0DKZyzqGSNJydLqgnaOal1eE
 YEmKh085Eh/UHQW2p0sDyPLX+oVALcFlHIYxhBni/ieit/SNGygxmrUY4yZYoSoyXYw8de12Iqj
 Q5ZEGbjhRG60vPy7iNXbCx1Yw5F1VdQHGVLjMvlJA5QvTWxNQGeGAbgZg62fNTt1eRoGkBFecxb
 ZCmP8SgbZin6SYSeUgUBsyqaJRtPukMymWkQpv+DeAd7mF8l+gOyl0MCAt5IyUNRooBYebW0ssa
 7/Hx6C/d5A0HHENJg6PMCdgXCZxCn4FfEFh+RaTXTn4rysL6XF/n95VeY73gOyhmLSH1A9o0VZ4
 JXEyO5Geqfg53mvunQyhPG2ZreAnxjTKPvZMtK4UBvj3DzWSCmVSIO9mEhsYfQYojAVPhflgMNB
 R33q4Q6uMeF+YzRwqUegqz8NPbfsTDoDRj1JeTkekCNEssY45wU+gwlK5iPKNzKOjKMA==
X-Received: by 2002:a05:690c:4b90:b0:80d:a249:486c with SMTP id
 00721157ae682-81dbbe3b5b4mr36173027b3.3.1783549270397; 
 Wed, 08 Jul 2026 15:21:10 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81e6bf653desm3151417b3.17.2026.07.08.15.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 15:21:09 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 David Airlie <airlied@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Inline drm_simple_encoder_init()
Date: Wed,  8 Jul 2026 19:20:21 -0300
Message-ID: <20260708222035.7324-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Simple KMS helpers are deprecated because they introduce an unnecessary
intermediate layer between atomic modesetting and the DRM driver.

Inline the functionality of drm_simple_encoder_init() to remove
dependencies on these deprecated helpers.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 170adaf7e76a..d5b0692fe860 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -2,7 +2,7 @@

 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
@@ -316,6 +316,10 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 	return plane;
 }

+static const struct drm_encoder_funcs drm_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 				   amdgpu_vkms_output *output, int index)
 {
@@ -342,7 +346,9 @@ static int amdgpu_vkms_output_init(struct drm_device *dev, struct

 	drm_connector_helper_add(connector, &amdgpu_vkms_conn_helper_funcs);

-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, encoder,
+			       &drm_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to init encoder\n");
 		goto err_encoder;
--
2.47.3

