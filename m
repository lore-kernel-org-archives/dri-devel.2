Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DD2CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA65D10EE6F;
	Thu, 11 Jun 2026 10:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jFhYfg28";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4564D10E7D1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 08:33:23 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so4804539f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781080401; x=1781685201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=42JyeNN6hbRFmmAETFft87Ynwj8c8+fcuTymho+Tavk=;
 b=jFhYfg280sYZ1JOeR+tyM2EPV/OLIi3zLKCYzDA5RoxARblV6Cg5QeXQkHtXDe8KPW
 O9R+FFDyVdzQejH6Lef6yh++4uDXjLTcmj340iMTnbEbetrYiqElnKE8e1vXwX4dIdR5
 qSoH7pM2sxvVSg5L/Gyx9e+sgx0uO+SVa/eXe7UGRwssBG9YBONPOyfCoJ1tWjQu7cmR
 jXmiRgxNwz5LDy7GxnQ8tTqf18zybdzuEr9eXhv73vMZurA3lRFTM15YRQbQVZYYYVs1
 RA/TXPKPVMBlnj/tb7HePaawQLzHY1Kux1A3XDnB5OPTOcnAa5QiMOiJdhI7j6su7GA7
 5Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781080401; x=1781685201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42JyeNN6hbRFmmAETFft87Ynwj8c8+fcuTymho+Tavk=;
 b=j5uUCYPaneVX+eL63M25cNh+JT2XGT0uqLmrqhK2I4AJ8vIAHJy90EqUOcgEEeE1zU
 fnJIqlsl9/mrt3LoNxEA7wCx7UiJFcviod2hTYbpDEljY/yzWtEkdDCkEdEX7L18NsO3
 04g/ddC4oAjm+KRN/2bCsegR/90VXfDFdn3iiNjdvQOGN2AL+OF2/8y4ubFgy5bYq+Lx
 es29n8fpAf6Kk0W4Re+yJe//9j8o8QOpXPezscVciQtBqGWzInz886pFS+6JtWuyUmO2
 MDq6HZJRmWmjHxAaKWRIa5+tZaDAde08u5Xzi2nPpJ+L3kLocXj8MkvXE1f9GvOyW7Id
 rUVw==
X-Gm-Message-State: AOJu0YxR1yp/iyvlAeLWlT6QOoq/HU8QPCBD5/0EqygfJB5UGAe+Q8hv
 coh8/UeuTQPugLLmYrm/SMWrwu4VkadSXdhJVjpuJKAxi1iTz/Qh9j1+
X-Gm-Gg: Acq92OFs2E1qepY2GzHRmYTF+q1fhrCjMxG8paWCaFH8jzSVwVtxyN+J3zozI5Rmc6y
 N91Qb5SMSntX0S+5n06WzlrDvC/6rVL2uRpeQCzrmPqrS8bqHakIUP4ajn/Ga2951/U0QXZ5VRZ
 ZtQzAu+hMWg2zIliLQrGRs6s/XlmXdMv5WXhiMad8MlKJja/uaaqJa0+CisYTPxtSDw6Hwm0pUZ
 +Mw0qDG+qakL7h4nI49fK+m9gmDhSqJI3UjS6LgM4/NPkMEn0xXUaQVIrQmQ8RCFUBeQ09r6Guc
 FIAedr0cC4sJyxeJFThOsYoQljwe3ib1pxmC2jD64oFzqDZRQfWK6qy0b1/9mCcKTmOM3HuFPSY
 L79XVlu10ip5gQ/4fazQULqDpXzX37VVb5KMHlejwh/Fqb7tObYNQrl+B/YQvQZLfHbgDOfTF7R
 9TpjQpsRSlOE2njL2sXMRCxR+zysMsJS35eOlo2imLQgppnoC3TYqsAX0rMe1DuVhFWqh7B88=
X-Received: by 2002:a05:6000:2b0b:b0:45e:ea2a:dd79 with SMTP id
 ffacd0b85a97d-460302e0a31mr24547521f8f.4.1781080401290; 
 Wed, 10 Jun 2026 01:33:21 -0700 (PDT)
Received: from aldebaran ([193.165.157.230]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fd33sm76213092f8f.35.2026.06.10.01.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 01:33:20 -0700 (PDT)
From: =?UTF-8?q?Pavel=20Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, stable@vger.kernel.org,
 =?UTF-8?q?Pavel=20Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>
Subject: [PATCH] drm/radeon: fix r100_copy_blit for large BOs
Date: Wed, 10 Jun 2026 10:32:45 +0200
Message-ID: <20260610083245.1057241-1-pavel.ondracka@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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

r100_copy_blit() copies BOs as 1024-pixel-wide ARGB8888 blits, so one
GPU page becomes one blit row. Large copies are split into chunks of at
most 8191 rows.

The kernel register header names the packet coordinate dwords SRC_Y_X
and DST_Y_X. In the BITBLT_MULTI description in
R5xx_Acceleration_v1.5.pdf docs, these correspond to [SRC_X1 | SRC_Y1]
and [DST_X1 | DST_Y1], which are signed 13-bit coordinates in the
-8192..8191 range. The old code kept SRC/DST_PITCH_OFFSET at the BO base
and used SRC_Y_X/DST_Y_X as the chunk address, so large BO moves could
exceed that coordinate range.

Compute per-chunk SRC/DST_PITCH_OFFSET bases and emit zero source and
destination coordinates. r100_copy_blit() already packs
SRC/DST_PITCH_OFFSET as pitch plus base offset, so large chunk addresses
belong there rather than in the coordinate fields.

This fixes Prison Architect corruption with 4096x4096 mipped textures
after they are evicted to GTT under memory pressure on RV530.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/6716
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Ondračka <pavel.ondracka@gmail.com>
---
 drivers/gpu/drm/radeon/r100.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 3ac1a79b6f13..533215d6e9cb 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -906,6 +906,7 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 {
 	struct radeon_ring *ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
 	struct radeon_fence *fence;
+	uint64_t cur_src_offset, cur_dst_offset;
 	uint32_t cur_pages;
 	uint32_t stride_bytes = RADEON_GPU_PAGE_SIZE;
 	uint32_t pitch;
@@ -934,6 +935,10 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 			cur_pages = 8191;
 		}
 		num_gpu_pages -= cur_pages;
+		cur_src_offset = src_offset +
+			(uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
+		cur_dst_offset = dst_offset +
+			(uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
 
 		/* pages are in Y direction - height
 		   page width in X direction - width */
@@ -950,13 +955,13 @@ struct radeon_fence *r100_copy_blit(struct radeon_device *rdev,
 				  RADEON_DP_SRC_SOURCE_MEMORY |
 				  RADEON_GMC_CLR_CMP_CNTL_DIS |
 				  RADEON_GMC_WR_MSK_DIS);
-		radeon_ring_write(ring, (pitch << 22) | (src_offset >> 10));
-		radeon_ring_write(ring, (pitch << 22) | (dst_offset >> 10));
+		radeon_ring_write(ring, (pitch << 22) | (cur_src_offset >> 10));
+		radeon_ring_write(ring, (pitch << 22) | (cur_dst_offset >> 10));
 		radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
 		radeon_ring_write(ring, 0);
 		radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
-		radeon_ring_write(ring, num_gpu_pages);
-		radeon_ring_write(ring, num_gpu_pages);
+		radeon_ring_write(ring, 0);
+		radeon_ring_write(ring, 0);
 		radeon_ring_write(ring, cur_pages | (stride_pixels << 16));
 	}
 	radeon_ring_write(ring, PACKET0(RADEON_DSTCACHE_CTLSTAT, 0));
-- 
2.52.0

