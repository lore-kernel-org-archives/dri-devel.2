Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078EBCD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 19:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B731129B0;
	Sat, 30 May 2026 19:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UFM7yqKR";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583C01129B0
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 19:57:54 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2bf2247e38eso15473775ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780171074; x=1780775874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6JdPRt5Sj7atB5C54yq538d+n7joSXC6oGZ8RIIc9kY=;
 b=UFM7yqKRQzLZqQaRZMWgp/BjB7ontWwePeJGSgS/K5zizGZLaBUTyvdTpafE9PJD8G
 Fe1MFgZPci5p57qBjsUROEtBHc6ZPOzdj2oW1Cx34v8js4xK6GHPmsUFRkifkWTT5GMX
 2PS63PvMoFRIn+bNRgzkI70P4fvp/lpbUhbSyxOVz+xxMrrgOiEjg/5TGzFL98rRXVvn
 SvPjYkCoJwTslveA1ACJVfLSTb7iTN8iRA5W6h+F0YZtlPthXl0sjy65oy0BCEjpM3Qm
 GoObDumYEiNBdwRzbvD6saF+tmCITJOJeehmvNQdnrQNTcCwBUDRnzouFxWLTDHr/Umt
 uVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780171074; x=1780775874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JdPRt5Sj7atB5C54yq538d+n7joSXC6oGZ8RIIc9kY=;
 b=C84zq0i3b38vhddDwIrgHtyE/4+VW2CpGrjtz8aDMfn/+dvRa64QpcR3VFECk+NI+V
 pIlhaj88MO5VxtnC83N0Np+bT8U39PasdcwPBpvLfYTFx6DxCf/LgRdIIXiumjCWy6vo
 99hk+yfaa+5P4/xvnkcPC4o3tLHlboJKOVIxi7RTJ0nzSzquXA028buP1b0dgtnS3rMq
 mj8FvokgXlzpeHGCTdfxF7t8SsOFmFfJuctSaYQlvE16Mtkk8SSGvcS5o8eM8IsHY0YP
 4s9E0UWQQh+UvLqMODKqf10bpGsz8oCoCNWFAm5jp5Jod9+CZdT5vcqDPb6DvBrSiYkF
 IlHg==
X-Gm-Message-State: AOJu0YztVjaowHs2AJHyXLFJ/ClqemFi6AYZfrriapq6wl5Y17xXRCk9
 2lRfbTvubHiniA3DCu2gevyQ0WQHv1VouTYEcHn9de3dHlkHJTCXf0ykXFscBiFI
X-Gm-Gg: Acq92OFiSUZDnFyRneloJTk2SC6Lm/9oReTdAdMLQKFT+l0jIMJjKEVCrq/1sIXuw5w
 zNHf/iUmrE6hcrIj1gcL7VtrpGUR9dWCWRxjd73ryqcCurmh+zRHRSvmFdE91sRsRKU1pe7IUfj
 PjTgi04wpqKv+uiVFH2ISdNfIAHdSuBVbXOGhIqjHpWXVsAtRUBHVbdSgXoLpeSy4hdox5K/H9O
 h/ZF5P2XS5J3P+OuhQro9SHg9Ms/g3quiQ+LrrgVoqTGWnJ8xar2HEDqbfbL3YF6HLpjSf3p1bm
 J2aJbAxMl+7mthoqQHhp9dhux1GegszuGVhM5mxz9iI56EmYGbxn3JwGhzybrw2+ZXW1E/P0Th8
 QWoNmh/Y7+/KaLQDw/A2rd60PIpSfxYvlPzGoBWqo+Uk8LBZnQbPwRT0/AQbywMmJt5Cb/355pn
 zkJAeNB/XITnHNAj7/JxYYAjanvMGxHFUVigrJN3I2iOd3LSPz9BHoCu86Hiiimh2gqJ/DyohFc
 EtvbjxZwEjEgkj3a10ezUwXkh6NYk6OCH/OENBp8Q23vA==
X-Received: by 2002:a17:902:d4c4:b0:2bf:2256:732e with SMTP id
 d9443c01a7336-2bf3684da42mr61527675ad.23.1780171073812; 
 Sat, 30 May 2026 12:57:53 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c0751asm60719925ad.55.2026.05.30.12.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 12:57:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: buddy: remove stale @p parameter from gpu_buddy_print
 kernel-doc
Date: Sat, 30 May 2026 12:57:36 -0700
Message-ID: <20260530195736.5321-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

gpu_buddy_print() has only one parameter (mm), but the kernel-doc also
documented a non-existent @p parameter.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/buddy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index eb1457376307..67533a92c247 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1479,7 +1479,6 @@ EXPORT_SYMBOL(gpu_buddy_block_print);
  * gpu_buddy_print - print allocator state
  *
  * @mm: GPU buddy manager
- * @p: GPU printer to use
  */
 void gpu_buddy_print(struct gpu_buddy *mm)
 {
--
2.54.0

