Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8ADCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E629E10F49A;
	Fri, 15 May 2026 09:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V+arvoFP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6028C10F4AA;
 Fri, 15 May 2026 09:11:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 24DDB419F0;
 Fri, 15 May 2026 09:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86632C2BCB0;
 Fri, 15 May 2026 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778836270;
 bh=h6wPzr4wnwGKqTUyJYMkReLJPI/jZqHAvOssNtJ63fo=;
 h=From:To:Cc:Subject:Date:From;
 b=V+arvoFPmuYK8J3wE/whgApnk2q9+ZDDsT3v0oI9YkJKHTR7Vrvfj1SWcXcqkknDB
 S/imkJHjbOM8J/VP/bJ04sB8lTiUB4baBXrObxhnGWZEz0MyG+Dqo5Zwul0/k1lQDs
 FoNYTS6MMb8Cvtk/XXob+Okd7wEiydcsJ0JpsTmTIstQxEzozyFR5/lmuX4khFGgko
 TwTLAK0IJf4zAGunY6JlSOUvgPYHa51/xXXXbk1yzKfHT3Cw46qDAdvm7up9YRupx1
 e7O7FSkmLFodObDDjOvT5SZ08iQeVP6xcmJH5H4XgMm3P+sH7EPmweLDAhc0Po3nZT
 ODk56nN9ngjcA==
From: Arnd Bergmann <arnd@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, Jerome Glisse <jglisse@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Down <chris@chrisdown.name>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: avoid printing NULL strings
Date: Fri, 15 May 2026 11:10:26 +0200
Message-Id: <20260515091054.529610-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Arnd Bergmann <arnd@arndb.de>

gcc-10 warns about some printf format strings that are used to
unconditionally print a NULL string pointer from some call
sites:

In function 'evergreen_surface_check',
    inlined from 'evergreen_cs_track_validate_stencil' at drivers/gpu/drm/radeon/evergreen_cs.c:592:6,
    inlined from 'evergreen_cs_track_check' at drivers/gpu/drm/radeon/evergreen_cs.c:995:8:
include/linux/dev_printk.h:156:24: error: '%s' directive argument is null [-Werror=format-overflow=]
  156 |  dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)

This is harmless here because the kernel prints them as "(null)", but
still breaks the build when compiling with -Werror.

Pass empty strings instead to avoid these warnings.

Fixes: 285484e2d55e ("drm/radeon: add support for evergreen/ni tiling informations v11")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/radeon/evergreen_cs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index daaeae6ba141..550e8f35c7d2 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -589,7 +589,7 @@ static int evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
 		return r;
 	}
 
-	r = evergreen_surface_check(p, &surf, NULL);
+	r = evergreen_surface_check(p, &surf, "");
 	if (r) {
 		/* old userspace doesn't compute proper depth/stencil alignment
 		 * check that alignment against a bigger byte per elements and
@@ -818,7 +818,7 @@ static int evergreen_cs_track_validate_texture(struct radeon_cs_parser *p,
 	}
 
 	/* align height */
-	evergreen_surface_check(p, &surf, NULL);
+	evergreen_surface_check(p, &surf, "");
 	surf.nby = ALIGN(surf.nby, surf.halign);
 
 	r = evergreen_surface_check(p, &surf, "texture");
@@ -881,7 +881,7 @@ static int evergreen_cs_track_validate_texture(struct radeon_cs_parser *p,
 				surf.mode = ARRAY_1D_TILED_THIN1;
 			}
 			/* recompute alignment */
-			evergreen_surface_check(p, &surf, NULL);
+			evergreen_surface_check(p, &surf, "");
 			break;
 		case ARRAY_LINEAR_GENERAL:
 		case ARRAY_LINEAR_ALIGNED:
-- 
2.39.5

