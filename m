Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDEC606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0kmni+I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792FC112944;
	Fri, 30 Oct 2026 17:18:37 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC68112957
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:18:31 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3ab752f6244so1392539a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793380711; x=1793985511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bvi5ysW072lSJORWkYMVzsyAYOUWuxONOWbZatRvF7Q=;
 b=t0kmni+I/cJiVoBqkLrTzjq0Vf4hsOCRvDxIvYRehk6jpFoNXvr/zI5nUnViAvROFr
 sClPkxtQpfUn62N4PE7ogWS4/CaYx0V4nw89eiC3yfJKtFWpJNtA2HNP1nPUhSsARH9P
 BNml0wuDoDMnEinJVLgSsZQ0wtPL8jRX8ad5q6rsCsXEDfHZ6Xp405F/ur+h/X61gr1r
 FDvfzZ9UJbH627N3ZFMcL+LMvJfLO0YN8cgOyjOXIGBlMGz9g1GSuSt+MpFUBSnOIg/k
 ECDpXYAwqSNJqfy45PjKth4KTbt+rpso9Q9fTwf8wjN/aCXU/HRgV4Jsdtarkjh4n0F7
 Gmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380711; x=1793985511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bvi5ysW072lSJORWkYMVzsyAYOUWuxONOWbZatRvF7Q=;
 b=O8hPHmGUQilDGtA/iygzrKBfmPG/3W0lGHhPT8zb5QMAhfhtaQkCJiwCxTAKa+qOW8
 aQC3b1CSrby6K/mTJ65xUajVz/8W7sBVxi7ds+21h1jWujglO5vEPps6bPiqqztwLQbK
 1PDNEOUqj5ac0Kx+QD+K3W4kWLrEUGgV1UlyK/dfWu6hOh1mU0Ct4aEUFwWKCDZkwzjU
 K530epCUhB/zCgZGfoYeLkh2l7IZ/BM22eieJmb/p1BiKTFX79eF92gxAW+cu8XZ1Edw
 lhbABUU2i8wBET/wXUIXCdMJYeH5epaUdrufV25+F+4M3bvUYaVJjerOAD2SCd93Y6QT
 ZrHg==
X-Gm-Message-State: AFq9FYKVNXMizjUKLBQ5dF07TOe56/doWTEzN46lBkDRXEpnCDnKy2JW
 0LytS7B//BNSojAyEDiU3vE4nH6bVTWc/dzjBqbCCnCy7SilQuxpSkBN
X-Gm-Gg: AYBFou1760bpb2h5Xtppsdb4O5E4wwd9B6t4nKVwW22QQCz2RzoS5xfKU8RPSWpDH0W
 wsqy7yBAZSkAum2uLUwmV4TKPJHF18OwS5teE67bBn04nDBoyIhfD9g2g8tKcPhJiparKaM+oYw
 hSrPYz2OhVEtYG5oEPheTnvJ6o0yb26CYWL6TknjicS0qpQ5WSiOHoojYjWXyv0EL5liuO1S/If
 qKKtzyRcAGMhle1F3xdo4ZOXDXTeJj+ksAgY9Vz81IRyNkm+zmX85VR39ih6hGHcpLO4ZLXb+Ks
 IO0EDMEW+sWxXDgOrnVLFMs1XpCEu+zVf6GKLc4LIGgz0rBG2C3EfpBoROr+bX2JlLD3vBRh4nV
 IglUmV69nzoKORQ7B5RYf4AFnSOzmnFTzI4ZkpOzu+ofjqks5DFx2ZaLHJw8jHPT0f7zEW1eHto
 7bSJsysNDYo2cmf9DQc43UwpI3KjRM5Bk0HTadv/GhUojvQEucWN/pzQB2QQ+Hw4ZW4C7ygkmR5
 nqhXS1Z0z0CYn+ZQbonm8xQ7WdHLFpYAMIr2QXHF/MOYqfLpj2RUdAiKUzb16UYjK0IfpS+yBOZ
 dun3meW7PrTMvVw1t8jyGZUQQ/c=
X-Received: by 2002:a17:90b:390c:b0:3ab:e588:c2a8 with SMTP id
 98e67ed59e1d1-3ae8985c4e4mr2415454a91.64.1793380710858; 
 Fri, 30 Oct 2026 10:18:30 -0700 (PDT)
Received: from DPBox.lan ([45.207.158.52]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845432e4sm4762387a91.3.2026.10.30.10.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:18:30 -0700 (PDT)
From: MuXian Chen <a18165943161@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, simona@ffwll.ch,
 MuXian Chen <a18165943161@gmail.com>
Subject: [PATCH RESEND] drm/amd/display: drop RGBA8888 from plane format lists
Date: Sat, 31 Oct 2026 01:18:16 +0800
Message-ID: <20261030171816.11610-1-a18165943161@gmail.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DC's enum surface_pixel_format has no RGBA8888 (memory order A,B,G,R):
fill_dc_plane_info_and_addr() has no case for it and returns -EINVAL.
Yet rgb_formats[] and overlay_formats[] advertise DRM_FORMAT_RGBA8888, so
compositors (KWin on Wayland) pick it for layers with alpha and every
atomic commit fails once per frame, flooding dmesg with

  amdgpu 0000:06:00.0: [drm] *ERROR* Unsupported screen format RA24
  little-endian (0x34324152)

and forcing a fallback to composition on every frame.

Remove the two entries.  No working configuration is lost: a plane that
advertises RGBA8888 can never convert it in fill_dc_plane_info_and_addr(),
on any display generation.

Tested on Raphael 610M (DCN 3.1.5): before, ~240 atomic commits per second
failed with -EINVAL; after, the plane format list no longer contains RA24
and dmesg is clean.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5339
Signed-off-by: MuXian Chen <a18165943161@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 9139823..6d5454f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -49,11 +49,13 @@
  * For future use cases we should either initialize them dynamically based on
  * plane capabilities, or initialize this array to all formats, so internal drm
  * check will succeed, and let DC implement proper check
+ *
+ * DC has no surface format for DRM_FORMAT_RGBA8888, so it must not be
+ * advertised here or in overlay_formats.
  */
 static const uint32_t rgb_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_XRGB2101010,
 	DRM_FORMAT_XBGR2101010,
 	DRM_FORMAT_ARGB2101010,
@@ -70,7 +72,6 @@ static const uint32_t rgb_formats[] = {
 static const uint32_t overlay_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_RGB565,
-- 
2.56.0

