Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4B9E9904A
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E9810E89E;
	Fri, 10 Apr 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VqtlobN3";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015E610E004
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 16:41:59 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8d76492e51bso107920585a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775752919; x=1776357719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uih4IkEdnJDVtHqKmPWCYNbfi2V3Eeb0IfkSkkn7OLw=;
 b=VqtlobN3HOY6FW0SO0XBYpPmvQsMSDGAuI8hod4/u4d5kiYuR30GE1fnD/TduX2vv4
 Wf70A+lMuxPAhCV1ktD9xBSr67uvTsDcybHBXYZjKwX79q4qdp7604eswILjm484ujnr
 otV6ke5R874I+3dB8gobmNkRLVpAFWJjTSvyG5jY3fRuKTfjc3szW7CcoUZmUW2+txyO
 IxWRf2GbuhPvUs/d/W5crKcq+fed9RBSFmhI5wOezKliCVopop1Dkjb8unh/tP3oE3bH
 Rj2fcIgi7OBpiO6LE7sVHQkfE4GNxl8Awx3EmfpKTL7yZdZ3LPuvzkrYAcmfD9htmU9M
 FBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775752919; x=1776357719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uih4IkEdnJDVtHqKmPWCYNbfi2V3Eeb0IfkSkkn7OLw=;
 b=Mq29u+kkX8BHUTNDJ+uRZpVUjIRNaRVRtNJfkkW0JvfnbHH76eefHDx319X0MOYZp1
 h1nQm/z5JU5tHzEpHWdj5JuVPpZmWCxKteOwI0CN5H7CKffbKLubKn4DOfASuMuy6LKL
 VFZbw1g2FY92fuGfgpSH1Kj7ikQIplbtownLw+gYN4LIjVdXd93Fm+1uD/cNnDvwyhJA
 3MJT08i/K2QSjoDvYbn3GG/WmUrVHC1OxU2JpOjzWK71P4JUoRhbGeSqZWW+a/sYeu/n
 fw29uTmN2o2UX7ULoZ7sar1Hg0BIoVsrVw3uVTvb8GmFYauB8gMIoF+XJ88h9BcTD4a5
 a0Ag==
X-Gm-Message-State: AOJu0YwFEha4dx7iDM74eWhIg0IFWST2p1+KexiCE0d3W6//JWGM4vs/
 jyexVfaCrFR35jqlzxzBAEe1DSKhNfTk2yeDxu5UVsn3ycbRpQ2Gz2qq
X-Gm-Gg: AeBDiesLXXOvUy6/fQL8rN0ELwZbNyTlg6KaqGwtUJGNrLj/9/LNqhM1Cle5c22+5GQ
 8nt0+5HHTBedU9FQSBJIzEsMEzVehis5EGVgojXoAY3jiXIoHMASib3wo+Fl0CU93I4emoctDRZ
 BqjPgSgg1UAm9PXxqJUj9HI0qpafOnfxLfDyEcN4pIaeqN3O443r76qbTbXdao3prN6BzwOUdqN
 eUFAuH0yIL7cEDF4eVXeS3ov39MiEwHiu3+eGN0j3bl37lX3SDzaXoKcj6FP9yAA/6msJcqZ7oC
 nVKZI4nk0hiZCr05ro4j/9DLQWN19e5MhxUujk33hJ9rPGrdqALyUUiuO6Uq7vf+Vi/HRzwyLtL
 qk/3Oh+7BMQOvU6Afn2UXyEugR/MOUhvQldPjeMKeYoxiRPd2Ssag7zq0Lgz6HX2ljl0E5s5BOX
 8AITSOpdAnYsVMjXcwTxhJHgxyQrwABQKmAzcMWBlRPIfSMSd/PJUGBV6d2H1eFdWY8hDrDl8QN
 xZmelU5DuptPa0mgGeNjBdHcUQv
X-Received: by 2002:a05:622a:5d0f:b0:50d:bc78:5ff6 with SMTP id
 d75a77b69052e-50dbc78892dmr70800001cf.61.1775752918681; 
 Thu, 09 Apr 2026 09:41:58 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac849e2891sm622556d6.5.2026.04.09.09.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 09:41:58 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] drm/gem: Fix inconsistent plane dimension calculation in
 drm_gem_fb_init_with_funcs()
Date: Thu,  9 Apr 2026 16:41:56 +0000
Message-Id: <20260409164156.2235189-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:06:48 +0000
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

drm_gem_fb_init_with_funcs() computes sub-sampled plane dimensions
using plain integer division:

  unsigned int width  = mode_cmd->width  / (i ? info->hsub : 1);
  unsigned int height = mode_cmd->height / (i ? info->vsub : 1);

However, the ioctl-level framebuffer_check() in drm_framebuffer.c uses
drm_format_info_plane_width/height() which round up dimensions via
DIV_ROUND_UP(). This inconsistency corrupts the subsequent GEM object
size check for certain pixel format and dimension combinations.

For example, with NV12 (vsub=2) and a 1-pixel-tall framebuffer the
GEM size validation path sees height=0 instead of height=1. The
expression (height - 1) then wraps to UINT_MAX as an unsigned int,
causing min_size to overflow and wrap back to a small value. A tiny
GEM object therefore passes the size guard, yet when the GPU accesses
the chroma plane it will read or write memory beyond the object's
bounds.

Fix by replacing the open-coded divisions with drm_format_info_plane_width()
and drm_format_info_plane_height(), which use DIV_ROUND_UP() and match
the calculation already used in framebuffer_check().

Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 9166c353f..88808e972 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -172,8 +172,8 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
 	}
 
 	for (i = 0; i < info->num_planes; i++) {
-		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
-		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
+		unsigned int width = drm_format_info_plane_width(info, mode_cmd->width, i);
+		unsigned int height = drm_format_info_plane_height(info, mode_cmd->height, i);
 		unsigned int min_size;
 
 		objs[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
-- 
2.34.1

