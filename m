Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0C606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAQwLl+z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E606210E1AE;
	Thu,  5 Nov 2026 05:50:29 +0000 (UTC)
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F7810E1AE
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 05:50:23 +0000 (UTC)
Received: by mail-oo2-f5.google.com with SMTP id
 006d021491bc7-7033e26cb19so645797eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 21:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793857823; x=1794462623; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+g9gPB3NPHJMq13L+EnItb3VxEDWriLeBj7+7fau5JU=;
 b=vAQwLl+zE6oAv15v33Zwu/vooUMv7qqDinsLziSfW4JAHNPbJEASgNgb6HZJF2MERX
 qq+45HEwDOd9ecH415eD4n8NvMLotVVLSbOC8d87oeTmhichXj2YtZi3AKauk8pNb/qg
 tGy1TLXSOqa7kJhIhFzKdftsmJznbkum4gQImKVjkh3uWnnvFYidJu2EteTwrxjG+xdD
 dK8zNeiknj1ZXtin6omrwfxho8AA849d+10T8vGWDtd4kx36BqDIylRZv0KoenbiM6hz
 /q0jfa3h+BqdYbNbZxZcvdHqyjfKVsJP6qCTFIZCPMESpd1Pvq4s4JTEcCHgn+H3rUI6
 1NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793857823; x=1794462623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+g9gPB3NPHJMq13L+EnItb3VxEDWriLeBj7+7fau5JU=;
 b=Is42QgrZTH6Tok+cjooKOz+jiSQFKkWj7T5zh6Z1R2gbooGmdCjT29aebkXFoFgJ2h
 uMP9MtSVTDe5Tv12UhY0ojnZe2hV6izYZhIMqrwMVvA4Aanz5bhC8xho3Mf3qBVY+xJf
 3GzyCxN9Lm4R9C6v9Ayi8U+JbcOCW5RS7LfXkiTFyrhU4jbbn/hW/nUAS0f4EpR7I6V5
 WCRxD4JrFP0nUwdrYjUXN6DSCTEMYUTCBsDaY/a23oyQPO2MybLUWhkkOO8UxZhsjpBJ
 Dr60wIfEvhpzP4/Klh0FVs5OIkR0JuXJbapgVuAT0TT5Q2YTvgQuoCFufiKhY+/D/LHb
 Ss5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEdPQVcL3FMuGon7Qj5qCbthK8osX1+KF6W6+492LdForvuhx08aAYBCiCrhRXHSgBEc/WUigVi/I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/BCbg6iAnaHhy7fNbmu8Jsme7NH9mrkOJcr3uvd8+2ct2KZV7g
 jfG8YKWAbEJ3GExtUsh1swXdpJYXgduuHRlbkodDuqR29oAgHvHipbkk
X-Gm-Gg: AYBFou0Gf4+3eWb7junjSkZ7DMEST0Ua2NhYzB0ekLmy/mNjh5HvBsPm+zes/iKkZdy
 2mrFBhds8vMhKAa6i/2YOQ1h7TOLUTabKFtErLCZr6AKH28vs6ruZPReV/lkQymbKnjDF4StkDq
 n+1DC3b0xfDLR6C3XOE+rPjcOk/hK9ZdYroGTBVnsAcmX/NIaPc5GlenCvLI71OLxp90RxNY/8J
 MnpVAyG9Vji5bNK8UwH+m6oGEgNd+PXLOXQXvNj7tOg2xWCpQ7LZ1yU6lUs/XwGo43tPrR1eBfS
 cWmFamsbOELfRL1n0o7OaBA0nqk2iW+xCUJKGhkuEWyWkdt18lvnaViW0sQCuk3bvTCRnZPGL1D
 Aw5Rd7pvCOCwINILq0xPXeeYuoLyfLFy/o03bqhwKZnWGTJf2atBQjifzx6tHS1St3Uxy84vnrv
 Xa8MiNUotysoTx3GbBg1oRlZEVhtOwAlB7efure5baR08zgOHSqT+zALQgzcOqaEmfsoSTmJrMB
 Bhj5CFzWSw7NnjebAbnY+uuS4OciVLivD965vYLHCC7DdGQFTii77RHMZYSAjg0dzMS5AE8dmgi
 K+PdwLjzWQK1UvGng4R3zQ+7badR/7Upgz0rnmfAkIl0aYHNgbAarVxtOtv2h/JIZk5NLq7dR3K
 ywiUWKfQmE4CZ
X-Received: by 2002:a05:6820:f001:b0:716:caab:5347 with SMTP id
 006d021491bc7-716caab604dmr2386765eaf.75.1793857822678; 
 Wed, 04 Nov 2026 21:50:22 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.180])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4acea48fd55sm3919776fac.4.2026.11.04.21.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 21:50:20 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: kraxel@redhat.com
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, Henry Martin <bsdhenrymartin@gmail.com>,
 zeroday zhao <zerodayzhao@tencent.com>, stable@vger.kernel.org
Subject: [PATCH] drm/bochs: fix VRAM out-of-bounds blit with oversized fb pitch
Date: Thu,  5 Nov 2026 13:50:00 +0800
Message-ID: <20261105055000.1873029-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The primary plane's atomic_update() copies the shadow framebuffer
into the ioremapped VRAM with the fb pitch as the row stride.  The
blit offset and length grow with the pitch, but nothing checks them
against the size of the VRAM mapping.

Addfb2 only enforces a minimum pitch, so userspace can pick an
arbitrarily large one.  A single atomic commit then writes
framebuffer content beyond the VRAM mapping, e.g. on mainline
v7.4-rc1 (KASAN build):

    BUG: unable to handle page fault for address: ffffc90002800000
    Oops: Oops: 0002 [#1] SMP KASAN NOPTI
    CPU: 2 UID: 1000 PID: 1258 Comm: poc Not tainted 7.4.0-rc1 #1
    RIP: 0010:memcpy_toio+0x22/0x50
    CR2: ffffc90002800000 CR3: 0000000110f75000 CR4: 00000000003006f0
    Call Trace:
     drm_fb_memcpy+0x37c/0x6b0
     bochs_primary_plane_helper_atomic_update+0x36c/0xa20

Reject framebuffers whose pitch * height exceeds the VRAM size in
the primary plane's atomic_check(), same as the hyperv DRM driver
does.

This issue was discovered by Tencent CodeBuddy Security.

Reported-by: zeroday zhao <zerodayzhao@tencent.com>
Fixes: c3ac343c14485 ("drm/bochs: Use GEM SHMEM helpers for memory management")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8192decddbc1e..527ddd8bcf369 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -422,7 +422,9 @@ static const uint32_t bochs_primary_plane_formats[] = {
 static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
 						   struct drm_atomic_commit *state)
 {
+	struct bochs_device *bochs = to_bochs_device(plane->dev);
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_framebuffer *fb = new_plane_state->fb;
 	struct drm_crtc *new_crtc = new_plane_state->crtc;
 	struct drm_crtc_state *new_crtc_state = NULL;
 	int ret;
@@ -439,6 +441,15 @@ static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	else if (!new_plane_state->visible)
 		return 0;
 
+	/*
+	 * atomic_update() blits the shadow framebuffer into the
+	 * ioremapped VRAM with the fb pitch as the row stride. The
+	 * blit offset and length grow with the pitch, so make sure
+	 * the framebuffer fits into the VRAM mapping.
+	 */
+	if ((u64)fb->pitches[0] * fb->height > bochs->fb_size)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.43.7

