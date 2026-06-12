Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE86CD98D8
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C57D10E0D3;
	Sun, 14 Jun 2026 15:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6GcBRCS";
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C197E10EABA
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:41:08 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-39661f81eacso12106071fa.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781282467; x=1781887267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TftuUnxE9Lrtjc/EIh1Zv1ggKOyOeIDF4rAIqHU2nvc=;
 b=C6GcBRCSd7FnOpXWfjUT2kbr5t+JmEXUFlJJAZYOU9YJyEd90b4eVWtSd9UOgXblEJ
 mzRZ9m57rQicg1LyAXIow/qTDDHUtI4TqIPmTLPDEOJy5FOIImrsdju0YrVa5b/x/kSd
 BXd4qGmsanCFAZ8sIDECqPEwVjrCzdg7G5Jk2HkglKDxoEKmEtnw8mHU0E1lz+cTR599
 V4Q4rdb+wM7nV8sCg03Lk5sNHj7UFVUYQhKtVCm6c9LrsoCyuI9luFGknWUIim4RBnqG
 UlJLnhRAF4ymlpxLWMnjYM1P9t/spDdLqQiL/2zPkgKqkHHfystEW/3EjT35f6OHVFVc
 wzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781282467; x=1781887267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TftuUnxE9Lrtjc/EIh1Zv1ggKOyOeIDF4rAIqHU2nvc=;
 b=mTHD+V0ESgTQwzL6WF/eNk9dJ6oVrvrLcLhwDllhuELL7BAOK7EnfnR6mmZRLXvaym
 J8rw7xKOsP0snnDohyXxFnbhalnOYMFAjhxIBfGfqnr5j6k9gbtObW1V5BXDFF8gfryz
 7OyJhdwj/SCOmVXmEyk5YmzTdH7TEFhwR4Rs6cug65RjBjNq9tK8Xg/ovCKPeZ0FML30
 mfrES6h5ldn7fesjCVLnczBCjNfavLcBc0thQtDVSCgkwIh6ZY9DDxih+/01AE3VmKy8
 UhWSobWx+UMmOEQoO6eZWEaMnOFve3K9yjikJrkXYpj7IvAzxB/xFHLhCj6r58cAchjn
 +HjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9D0Jv9UpKXM/YWHGAxMCbp7d7HjHYxp5wPq8ZwNe2WC3msDbHEa9nBLuZ0zGYJPTmKqushOV2R2Qo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycYKp+5aISAhXoXpfkPq62BYyDc4nHrSI7Zzlpbp0UikEW8MAL
 OxcTP6bT9zHJIo3dRQxmBTWhOEKMNBVkWoTpLvDa83xxzawVGjj24+Qv
X-Gm-Gg: Acq92OFdOEsOdTvvun854uiZyhk5DYisS8TbraS1Ut/Ow16FGXwELF1r3KN1IkGyzuf
 WcLgoAK9bQoTvWiIALRB96z5EdbYJwWn+39zpXbLL2VRXw2yAWBEwBHbUpyvEyE2jUSaNwn/UmX
 S9FBVOQMomvwvNuT/Ys7xIF7hsjQ9tBoGkMCycCrhjL2JAqfbHuxhp997ie48eqN8T/m+G4wewx
 gijfDI3pHxmKM9Irob1l5zrWPsbYdK53zItkA2buEVSmUH3kDovG4Pu9UDYmrQC8dfb6cXi1lmq
 PMsqrT2p1/Vjt6eQT+IJlnVFLPiBruMTVEentwsp1YpKnTl9B4uvokEt+PsZA2HWaleCalou0Iv
 NAanCh1GOeEQkRyn1nF3Jm9YOVSHNG4ghqJb8i0Cf++s5KDKWnZzCUmL4lBHd8uDLZDfxkgByYa
 dwede9OpNGLVt/VEO/TYEmVHRMAiZHHpQClW40c/aPRpNJH/rI9A9vYXPx683hljCiIUnpi9c=
X-Received: by 2002:a05:651c:1473:b0:38e:8357:c5ae with SMTP id
 38308e7fff4ca-3992bdb782fmr8104031fa.9.1781282466664; 
 Fri, 12 Jun 2026 09:41:06 -0700 (PDT)
Received: from maverickamd.dyn.int.numascale.com (fwa5e61-57.bb.online.no.
 [88.94.97.57]) by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-39929f18210sm7484111fa.22.2026.06.12.09.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:41:05 -0700 (PDT)
From: Steffen Persvold <spersvold@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Steffen Persvold <spersvold@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] fbdev: modedb: Fix misaligned fields in the 1920x1080-60 mode
Date: Fri, 12 Jun 2026 18:40:41 +0200
Message-Id: <20260612164041.3652599-1-spersvold@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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

The 1920x1080@60 modedb entry has one too many initializers before
its sync field: a stray "0" occupies the sync slot, which shifts the
remaining values by one field. The entry therefore decodes as
sync = 0, vmode = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT (0x3,
i.e. FB_VMODE_INTERLACED | FB_VMODE_DOUBLE), and flag =
FB_VMODE_NONINTERLACED, instead of the intended sync = positive H/V,
vmode = non-interlaced.

fb_find_mode() then returns a 1920x1080 mode flagged as interlaced +
doublescan with active-low syncs. Drivers that honour var->vmode and
var->sync when programming display timing enable doublescan and the
wrong sync polarity, corrupting the output.

Drop the stray initializer so sync and vmode hold their intended
values (positive H/V sync, non-interlaced), matching the adjacent
1920x1200 entry.

Fixes: c8902258b2b8 ("fbdev: modedb: Add 1920x1080 at 60 Hz video mode")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Persvold <spersvold@gmail.com>
---
 drivers/video/fbdev/core/modedb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 7196b055..333b3d9a 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -258,7 +258,7 @@ static const struct fb_videomode modedb[] = {
 		FB_VMODE_DOUBLE },
 
 	/* 1920x1080 @ 60 Hz, 67.3 kHz hsync */
-	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5, 0,
+	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 		FB_VMODE_NONINTERLACED },
 
-- 
2.40.1

