Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S19MJsBJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D06310E5A2;
	Tue, 17 Nov 2026 11:45:59 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F2C10F18E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:49:28 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso592135066b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:49:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794908966; cv=none;
 d=google.com; s=arc-20260327;
 b=H40ZtP1bkc5SDYS6Ha2iGJiXc+sKWJYLPlfQo2tFwdJ4eFN+DZ47BMwofouEndSX7r
 AsDcP8Vdl0Z0XijgUMKA1rx9rWpb62sVXSJlVqG/njhb2NiO0i2LUdTVonKjQgUERlCU
 sUmsOjPH6mFMVMqpZnvyA6Wc3ByZu04p8KbYY08tpZELfzvyIcHWGgLAGmfbngNm2DQ1
 hfqMcDoATKcIMAepgKcc11xBxoN94TKs/4AQlYz+Jfzm7+HLOYjhjw/12uKQdW+4GosP
 8OgaFD49GAGnLNmOTNPeAbczrrjdiqIRn0TlGj+0T4QY5VWDFc40Tq/Q/lZyXCg2lFE5
 qGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=J9CDqvqYpeJFecYwEjdsw9s1ktTIININYWKKq2RjyQU=;
 fh=4moNiwr8AHY2fsnh86i8gJ5kHZEE1lfEhb010Jp/TRg=;
 b=AkLHNT2l134vRxIOJ0dO65KxQRNlyISWSE+4El7sq1tavIBCOK4dqdFr2mtL4lXcvP
 rz9a+ALzZxvta03H9vmh8Y/cBG5+u1F6e/xoKtnMV222aeC5Aiup8xsxjcDldjbZ8aXj
 fxf5FFbAk84oezGzeNbs9jQGF9TtRpjTDBS94JH5kmZ0d1x5QxDOI65Bz29+klJb8zNL
 JIuCN+AKv/r7oGOWuuW0ziM0kmnDYRj31yp7XSXdGWIZNFMeYTffNurqDI8ZZ6e5SVB4
 qEq2gLkYUWO1UkLgb87lU0CpFdP5VBhmT+przHxyt0FNXo3e66gQiEjQ0udkiPhgsqcY
 pm7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794908966; x=1795513766; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J9CDqvqYpeJFecYwEjdsw9s1ktTIININYWKKq2RjyQU=;
 b=S19MJsBJoJbx6So515Jrp4rpmrh88gi4Th3KKgAOtUJmVDNLrAGpwbTnZPB99Ns0Zo
 FAmxE39sgu6qEbRMQyf+i2VtMoOh84TprhLP/qLPQ5UQlLCLaztem7Bhz9B/mOZDQqzo
 jUiY666o2nVuHNpdNclP6IzXSmV8QkASTnLVtWkaE/cy3QqTVuumVswHMrWfxBJXbVIR
 REe2pQ0jFTdkskrNpxP4K4XluuopKSkHykzeyjhgOPUkrkyXkUwXe3okZroMTa6bRRR+
 QXekBltGBLYAjjLbULJaKWucPOUwl9tWWoMkJs9tLj6W+jZr1HPgqhlnXCSwnTQ42Ilx
 u60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908966; x=1795513766;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J9CDqvqYpeJFecYwEjdsw9s1ktTIININYWKKq2RjyQU=;
 b=WY6wR4jyzj/JYtPK0BoF6a5+FTRbyoqaYp1Z0bslWAH4p1MT3YeAY1GGCfiQ4cwQvl
 lqRCcXjxoN3UbYTg+C6TNUFr4NQmuwVcdHzIwrvi3Dw5/lEeK2d7QO9Tc+Dmmhastdz5
 UW6lojjo2NHQekAclSMhdetZT9ujahlFIqpARAk4H4oEHuxHLP6qe3jYqb4T7i+O80gq
 V9MeR2P0XqIV8+wd8oMYyDs6N3qbjOCJ9mBWDZzZJ9dg8Ntzh20WAhMjb9birWiFRJaQ
 x7JiZUMLpdwieqQiR8fWi5jw6f6io01C3exa3ltStLpk4HaHkzuFIsIO44kVgbl7FT9w
 LS4w==
X-Forwarded-Encrypted: i=1;
 AL+hErG4VN1y57xYgjJLYTPGBwCPeYSe6uvgla2jKLiGOz4JGNdsLWSyVN8ljLACccy52fVnJSvHPPWjqoc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/nunPzV6h+7+7CjiaS8sBQq8ulsWaiOdjdV5EzVRmXqgT+/47N
 nfAKtKDg4l2J5lW9N7xNfrZJPZGB4ULt0r8PeLgszvNf+ozuZSp/rAGGYzm/kQbvWjXujdpNX+3
 pwUrrfns9MF0xF7eYU7pMxFF7jroleMg=
X-Gm-Gg: AYBFou1koFfgtPhAegOaFoAMOXbk84e2fR/cDvoldVv1Z+YjrhQfhhhnGt6jJS26lEP
 20LMvPEqcuyVuTI5/v+rPKh1i4SPikWidzIcR+GPclTjTN4t857EM8YA3YEKjy44FHT08CmmCji
 jDHNTVYdpMuspRrGePsmOCGxGtC754+6b9jucU6svM0i9dyMj/Hwg0rLwZIGfHCW/er8yvg3u4D
 oTTla61b3j3dChKFd4OX2oQP6lTWNCoWCLsFQ3SAkvpMhAmrZVs5y2oxYfC3TuFpnHUi7XWW0H+
 az0U8i1Rek/OTBXBYVXcXoIoAj+H677gCXm/m3gGO3xcl+ZF5WYHUlAuSG945Viw+CMF1nkYmbW
 gcPH2bz6NkXIqA2MqHiLOc2Jd6saz45EIrmXF
X-Received: by 2002:a17:906:4fc5:b0:c2d:c739:30e1 with SMTP id
 a640c23a62f3a-c509643c050mr1138802666b.32.1794908966534; Tue, 17 Nov 2026
 01:49:26 -0800 (PST)
Received: from 118528743069 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Nov 2026 04:49:25 -0500
From: Christian <servidorjarvis1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Nov 2026 04:49:25 -0500
X-Gm-Features: AclHuK8TuW9Lwli_wSH5s4uz0F-M4xJLcWjzRm-qOe_9Jd1man4iRPGpyUrD4SQ
Message-ID: <CAMas6S3zMKwb5KZ-UNnTd92hZNN0CONY28bROWbojYHBNFCRgg@mail.gmail.com>
Subject: [PATCH] drm/simpledrm: Use vblank timer
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Nov 2026 11:45:58 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

simpledrm has no vblank interrupt, so DRM_IOCTL_WAIT_VBLANK fails and
Xorg's modesetting driver falls back to a fake vblank of about 1 Hz for
Present. Every client that syncs to vblank on top of it (glxgears, mpv,
Chromium with its default GPU vsync) is paced at roughly one frame a
second.

Use the DRM vblank timer, as bochs and cirrus-qemu do, so vblank events
come at the rate of the display mode (60 Hz for sysfb modes).

Measured on an HP ElitePad 900 G1 (Atom Z2760, simpledrm on the EFI
framebuffer, Xorg modesetting + glamor, kernel 7.3.4): glxgears with
vsync went from 1.4 FPS to 24 FPS; Chromium 150 (ANGLE on GLES)
animating CSS from 1.9 to 13.8 FPS, with the GPU process no longer
idling between frames.

Signed-off-by: Christian <servidorjarvis1@gmail.com>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c
b/drivers/gpu/drm/sysfb/simpledrm.c
index deaeb7d1f..3461a0f98 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -31,6 +31,8 @@
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_vblank_helper.h>

 #include "drm_sysfb_helper.h"

@@ -583,10 +585,12 @@ static const struct drm_plane_funcs
simpledrm_primary_plane_funcs = {

 static const struct drm_crtc_helper_funcs simpledrm_crtc_helper_funcs = {
 	DRM_SYSFB_CRTC_HELPER_FUNCS,
+	DRM_CRTC_HELPER_VBLANK_FUNCS,
 };

 static const struct drm_crtc_funcs simpledrm_crtc_funcs = {
 	DRM_SYSFB_CRTC_FUNCS,
+	DRM_CRTC_VBLANK_TIMER_FUNCS,
 	.destroy = drm_crtc_cleanup,
 };

@@ -874,6 +878,10 @@ static struct simpledrm_device
*simpledrm_device_create(struct drm_driver *drv,
 	if (ret)
 		return ERR_PTR(ret);

+	ret = drm_vblank_init(dev, 1);
+	if (ret)
+		return ERR_PTR(ret);
+
 	drm_mode_config_reset(dev);

 	return sdev;
-- 
2.47.3
