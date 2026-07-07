Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0095C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0618110F42D;
	Thu,  9 Jul 2026 07:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s+6fpv0j";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199A310EC10
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 09:30:29 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cacd69a9c0so33878095ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783416628; x=1784021428; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QzQpFHJ/fNpPESLWciMsNy0ig1nfmSqgUNKGC1J6yuU=;
 b=s+6fpv0jyxKFq8HhedApX8xMxNViSMTg6de5SVtqddsHLOaAwt7cb0eYaOGta4qOfw
 9KOegJcDDzpMf0q59q8m40uAkSnGNrio/Abnx1Q/OWps9irFewSsAAP1FO2pLeMWiR89
 oSuEEwqv+4w6lN70Pf1/FmFQAQ967PCcb/qphtKgm8PVeefQDEUdmZ4iXsArefCHWqyh
 nc9CD5Lbav1csj+CpyO7vdtqrg/thUCBFgzkR+IuEo7WMTRvoB4OINCp2glXXDi+/1Gu
 Td809LiKND21wtlwbuo42AMWWc1hwl2AWiJt/8wC3xGLUiAogdmgFriLBJE0FWDi9AGz
 MZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783416628; x=1784021428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QzQpFHJ/fNpPESLWciMsNy0ig1nfmSqgUNKGC1J6yuU=;
 b=OLqJUnEi7TzA4BSeASYt/zO/MspWSdcVBOVQrKzi68+5ONUeUPkYFssXO2D05DXeFz
 h4JT43o1/vG4Y+G1YKtBqFHg9TMom6Eece7JxjxRM+pl9ERUs9CN93hEGDjUZ7VGHfDJ
 7Sm7sRr46zQUktmc1c/r0G/aSn7m50nM7acZn2tSsrwLc5UWwuQ18WQVVoqDIy71UzmP
 uvmcBo4bfeqTS+v4jAl5Okzwe8TtDMg+WtDBjW2CddDMlw/GX1K65nrgmE1Um+kvBxBj
 3QClRhsNji2AiG2yz3owqSkVihubqwi/LLenARhbnYMSbzGbrZErU7WkjqxHqoL+UgOY
 O2pw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqH56/x/qcVxTT8P77XXjKDXuEVH/1orjQckcuMbeUBWdezGNBMiU1ST7QxdAloMvO0WIYCb3U27Ts=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGU5JJQlhN0TM21VQDpCjAVTjNAO37tAB8wEYCNmvEkrlEOGab
 76HwcuOZoRei0Hsm8HLpi27Qs2lvT0c9xOvJ3armLt6wjv0yO2j5OD3L
X-Gm-Gg: AfdE7cnekht7171svjO+vc3sIZYy5rtipABGKAz3lcI3b/teuoW7DuaSQ/DRUNBdZac
 ltXRvVizWlTRDJRTi9YQa44+KzwIvHGUZ59v5O2J6eQgfZSFSXPRGoEwL/PW6nvx1bH38QaM9QJ
 uIij2r3Mm86JwV+6O5T+2hoJKtj0L1uMeRyjEZJeyCMi094ZDxyPBn/w36vl3YNzDKZPp2nVIdE
 fMWZFXxVt4rSW4O3cbOI4MtGpkZD3jKTsfGuhdUBRSGbKdMQv0tPVFNOLvP4lGj3Y7DeM5hLRS+
 OzzokOFlW9njEz4BVI5gIh6s0SqlzaCXDGWW7+yiAparnvfNTKFosxITcKeM6qw6zBUq6JDHjEg
 0C3UD235PqxcwuamwNrKYyFUorNbxnpbVsvFbyXaLVesfYtTkDdYusNEmy7Ip8TJM0vmuYzOWD/
 jVjYULOQIX2PaSC4Qs3gdVhjwxkx+zcigiAW9kWY+fB3bPBO4=
X-Received: by 2002:a17:903:b87:b0:2c9:97a7:f543 with SMTP id
 d9443c01a7336-2ccbf056ae4mr43993585ad.41.1783416628565; 
 Tue, 07 Jul 2026 02:30:28 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb9bbsm8569795ad.4.2026.07.07.02.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:30:28 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v4] drm: shmobile: Fix white screen after resume when LCDC is
 stopped
Date: Tue,  7 Jul 2026 16:30:04 +0700
Message-ID: <20260707093004.987846-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

From: bui duc phuc <phucduc.bui@gmail.com>

The LCDC on R8A7740 may show a completely white screen after resuming
from suspend (s2idle or s2ram).

After resume, both Set A and Set B registers are reset to 0. As the
Frame End interrupt is not generated while the controller is stopped
(DO=0), the hardware register switching mechanism is not triggered.
Consequently, Set A remains at 0x00000000 even though a valid Start
Address is written to Set B, resulting in a white screen.

This is a timing-dependent race condition. In some configurations,
debug options slow down the resume path enough for a Frame End
interrupt to occur, which can mask the issue.

Fix this by priming both register sets with the Start Address while the
controller is stopped, ensuring a valid base address is available
immediately after resume.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Note:
It was originally posted in March and has already received both 
Reviewed-by and Tested-by tags. I'm resending it to bring it back 
to attention in case it was overlooked.

Changes in v4:
 - No functional changes.
 - Resend.

Changes:
 - v3 
   Update commit message, add Tested-by and Reviewed-by tags 
 - v2 
   Fix incorrect use of lcdc_write_mirror() for LDSA2R in
   the DO=0 path; use lcdc_write() to update both register
   sets as intended.


 .../gpu/drm/renesas/shmobile/shmob_drm_plane.c  | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
index 148de34af785..92e7fb464cb3 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
@@ -70,6 +70,7 @@ static void shmob_drm_primary_plane_setup(struct shmob_drm_plane *splane,
 	struct shmob_drm_plane_state *sstate = to_shmob_plane_state(state);
 	struct shmob_drm_device *sdev = to_shmob_device(splane->base.dev);
 	struct drm_framebuffer *fb = state->fb;
+	u32 ldcnt2r;
 
 	/* TODO: Handle YUV colorspaces. Hardcode REC709 for now. */
 	lcdc_write(sdev, LDDFR, sstate->format->lddfr | LDDFR_CF1);
@@ -78,11 +79,19 @@ static void shmob_drm_primary_plane_setup(struct shmob_drm_plane *splane,
 	/* Word and long word swap. */
 	lcdc_write(sdev, LDDDSR, sstate->format->ldddsr);
 
-	lcdc_write_mirror(sdev, LDSA1R, sstate->dma[0]);
-	if (shmob_drm_format_is_yuv(sstate->format))
-		lcdc_write_mirror(sdev, LDSA2R, sstate->dma[1]);
+	ldcnt2r = lcdc_read(sdev, LDCNT2R);
+
+	if (ldcnt2r & LDCNT2R_DO) {
+		lcdc_write_mirror(sdev, LDSA1R, sstate->dma[0]);
+		if (shmob_drm_format_is_yuv(sstate->format))
+			lcdc_write_mirror(sdev, LDSA2R, sstate->dma[1]);
 
-	lcdc_write(sdev, LDRCNTR, lcdc_read(sdev, LDRCNTR) ^ LDRCNTR_MRS);
+		lcdc_write(sdev, LDRCNTR, lcdc_read(sdev, LDRCNTR) ^ LDRCNTR_MRS);
+	} else {
+		lcdc_write(sdev, LDSA1R, sstate->dma[0]);
+		if (shmob_drm_format_is_yuv(sstate->format))
+			lcdc_write(sdev, LDSA2R, sstate->dma[1]);
+	}
 }
 
 static void shmob_drm_overlay_plane_setup(struct shmob_drm_plane *splane,
-- 
2.43.0

