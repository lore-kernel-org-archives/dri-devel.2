Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F31F107528A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB7F10E931;
	Thu, 19 Mar 2026 09:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jAXZ7e87";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7508C10E8E8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:32:24 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2b056b7f783so3239045ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773909144; x=1774513944; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VqOOQO8G00f+NnUwp116p4eShMIJWuolK06DttQTATw=;
 b=jAXZ7e871fsBBQklw4JK8t8FRs2+nyDr58hApkXAssiPMOdnhTbE1rfqeT5Zch5P2a
 VVnxEjRh/arnfnWuxUV4lKfDf5r7TDdhNrBgIeAKKB2KlDthsD9ibbNHJXbNPkihys57
 O6luYVwP3/NZvyXy53muXB6Kiyx2hq6YT52bol3psnWxAFhbcBoucBK+EdZ5WDwmIGQv
 o0vmrPuscanOUXPGWHAZ0y8xlusmBtb00+6M7DjdphJx+ihFBhWHvWNU4rsnjFlAgmM4
 fIEh5bnjYe8fCU/pPPjx+K1Qv0RyHmNWhR1c07VZMK+058FqRAdrMFFoYm2JDGIqXgBI
 msew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773909144; x=1774513944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqOOQO8G00f+NnUwp116p4eShMIJWuolK06DttQTATw=;
 b=JwWfmSsD8MSMJyiW60xQ5a/F8r2LM6dDdnTWNbq00Guy3IiVv+oDCtNnCvjvgZM+Uz
 wAQJacNA7YuYce/fKp++ZrvE6GrzSXJtOcLybQdcc9rJOR2DD6YVF/C0vENqxquOPEuw
 hsg7pD7b+NrrmqUlN8Ysv1DUR/b5zn1hCfQakO42Xm9IJ1txg2LK0TxXxNXZ5/+7Opiq
 HF6t1iGR3+H2lMeWBg+JL0pdGEVS7CEftLTmh19VHgnR3MHrecwDWBOnotrEdIBVA9Ek
 XjwI3sxer+JXYKRNdM7kokAEBxEccyUDdt439PxT6SkqWNDhUTDqN/XOLfXUj3EF8+E+
 PJOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoraa+aHg1FFhIeDL8FeosdOT3i/vb184cQJH+45rcBQe8H7I3u5L4GIBvhDDG3dgC5mVZrJAi67o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzECSCqw8RUguTRtVdbJSabVOrklZbmKAlGtQPesJnKepaR5ILV
 EGRa+InEYfTE/REaGX0tK44NLrDEcEs4fZiv5QmTmmZeeWbWlDbYsnl9
X-Gm-Gg: ATEYQzyoKNu6GS9wXzN3jkOv+CSkguc0s0hqyGosNvG9xz2XwrmprrzKEMcDvMTRntC
 LQ/NFKAoXKVAXcNq/Qu3yMNYpBgmLz4BtU7CYRZIOBBEe8z/zeY2AuYVxucZr5+4ZOawg9QW67C
 cmqNp+5eXHtWm+KgVqnSjw0eh2zVCpMf84N2qTdl9euIDIB0Iuj/ycd/Rza8Tmh6ZTvxgevdsO/
 4oqny40hehRLgiF9pzOp9HZg80GvIyNXOlkhe9Kg7aHdHrhxUVbDL4Llr4wob6Jd7EEGKBRpT+8
 sYa3hUcuq05K8+/sG+zcwgD0UtoZT56u1tbut5eAn934+pUZDz6quI2twN/jct4HTezLZORzhi9
 AwkLH8tnzPRObMHFC2skmeBxrDVNWlpDnKsRNnzA89GvS1+x9ACUPW+YqynIKkBeLI6HHOz1nXL
 XECmD96OV45cp+L1/h2FDVGg2+h4SkLIdCd9BN00ECjc35BrUNDEAegIoyLQ==
X-Received: by 2002:a17:903:38c5:b0:2b0:6ba2:3d32 with SMTP id
 d9443c01a7336-2b07716eb19mr29493095ad.2.1773909143843; 
 Thu, 19 Mar 2026 01:32:23 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e603b2asm53581615ad.55.2026.03.19.01.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 01:32:23 -0700 (PDT)
From: phucduc.bui@gmail.com
To: 
Cc: phucduc.bui@gmail.com, airlied@gmail.com, dri-devel@lists.freedesktop.org,
 geert@linux-m68k.org, laurent.pinchart@ideasonboard.com,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, wsa+renesas@sang-engineering.com,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] drm: shmobile: Fix white screen after resume when LCDC is
 stopped
Date: Thu, 19 Mar 2026 15:31:49 +0700
Message-ID: <20260319083207.17195-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Mar 2026 09:42:18 +0000
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
index b61fda52d17a..23c8489dba71 100644
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

