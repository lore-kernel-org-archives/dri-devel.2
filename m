Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CD0CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC50010E3ED;
	Mon, 25 May 2026 06:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OTbotCAh";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B231910E062
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 05:18:36 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso60680475ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779599916; x=1780204716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qirud4yg6ff64Rz1Y6X2KitE2QcTgww2RA7TfD1h/wM=;
 b=OTbotCAhydeYUbvZMp/2nODdhfEMugTb3HGA9Eyo8EPhAL3D6NE4D2aW8bsd9R+VNB
 C9IGiNZyIAbaY1jeQPSCXqQFrWed5pBqFIhNihjjMleXchH/D7VPLuaMMLA7uyOMxQ8z
 nDFsV/lCfRe52RhbfPwVnvoQJnTEmaIXOjgmu69srpwlrx8RqrDzxcCQ75nMtxzxxb21
 gLdjUOHXrZb/v1MDrizmerBDxS6pvtQXSOd/+WeTa+tvfok6b1yHqw1wFXhkymr1gxTt
 zKDb92ejqHk3ai/jn7TCoelZgQ2Y3wx5oc7Z01TZx3btxDk1s4XjEdQWhAX6yjunVPNj
 43Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779599916; x=1780204716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qirud4yg6ff64Rz1Y6X2KitE2QcTgww2RA7TfD1h/wM=;
 b=rlLJy6iKzW+OKThCiPwiMk4zjqDV4uZT781ZyIc6kMASNbG1zxFXjsjw4Y0w6OcPb1
 KDnEMv3mnUyEImmI/WrXDHxDuH1A+d6Ru2drykYOoeaiVKQ3Al/tRsMQxXXKCQVhI2az
 g/W+xpOtbCufYmzEqvuCV6F/dQpBy33Sa5fSguOm8lHktUrF0ozc8insXDkr2LohzNQu
 /U2f6qqL4zvLANZmd+2h0paio7GLTNQI2dON1Ugn2Wq7bXat6v7643ZVczMyBzUfB8pR
 DqAU3f/74s0+zGH+V4F+sxiVa0hoDFIl99QoMME3+pk8jv7TuDHle/u5k7qZcm53Mr2p
 1Vug==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TEOeGnCM5BRjXDQLuLf7PnsKI7rq6CeULs9nzaWkXCrqPPWJNWuqW2o+FMrB7Bqq8z9svQvofirI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZcuh+z3OWbNeHSmzHV6jD/ad3fu6Z8iE4DLj2uXhQPfP3WNtd
 NnCwFXUW7q5CMyOTvHw9AVk10VAauTBpfMH71t0PIEyI24EiysyiwrKC
X-Gm-Gg: Acq92OGEI/7qcLt+zmxOibKhiJg6gVWkMqstxhch+63fCkS8anRSHpaYeJY7hnbjKWZ
 X1sEKO8ZVi2sgwmmyW3xuWQ2LR4+wDyMVZRdlgV+O4sE6RNqSp3ZXSJVnwVqBdnutg/Yro4zhCW
 ZsWE1WhZRIjsukW/NBfPZOjwGEMzPuS3tuD/PZ022a9Z6ZR76LG5LjG+GlHNczYvZ0E4THM2sSn
 UFonknVk/Uzfh46tyrzH7nItyhK45ZVvjP5SjhKjh8kI+4o4g/efgBrl/qlhh4nGpa7ACWQHjF6
 2QjlxXeNIfK4N1oOPqRjE84hHV9SFXTONFYQKvcO5+x9qHjS5wzZiKnoWMD79Ceb4TGfdPsN1g5
 XEMvyqByJ3BfEed6DYfuDiXndTGiR7mh4cELEA+Oojdk0SqyC4qgnmv1I602991H09s8dFuClx9
 EuF9EMsg2qLUBclMI4JgPEN6GuKc9j/9ykMy8fr2TntKYOZ/YThrcOiaemUGqzeDQZvrbrn1ipB
 2N4gDX3e4GT5Xr7JLzL7mu3EQwovjg1oWeuWroF7h/2/Y6MdaQuVOvm0M49mlWLo+46VcEI1gil
 +5ovr2E1yHBaDfY=
X-Received: by 2002:a17:902:f549:b0:2b2:6df1:1112 with SMTP id
 d9443c01a7336-2beb07757ebmr102149795ad.40.1779599916185; 
 Sat, 23 May 2026 22:18:36 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.196]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56c4f8fsm59058805ad.26.2026.05.23.22.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 22:18:35 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: fix integer overflow in dma_length()
Date: Sun, 24 May 2026 05:16:58 +0000
Message-ID: <20260524051659.70654-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 06:20:29 +0000
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

dma_length() computes the total DMA transfer length as:

    len = ((len + stride[0]) * size0 + stride[1]) * size1

where len and stride[] are 64-bit values derived from user-supplied
40-bit command stream fields, and size0/size1 are user-supplied u16
values.

The final multiplication by size1 (up to 65535) on an intermediate
result that can already be ~2^55 easily exceeds 2^64, wrapping the
u64 result to a small positive value.

This wrapped value is then stored in info->region_size[] and compared
against gem->size in ethosu_job.c:

    if (cmd_info->region_size[i] > gem->size)
        return -EOVERFLOW;

A userspace caller can craft stride and size values so that the
calculated length wraps to zero or a small value, passing this check
while the hardware executes a DMA transfer with the original large
strides, accessing memory far outside the GEM buffer.

Fix by replacing the unchecked multiplications with
check_mul_overflow(), returning U64_MAX on overflow. The callers
of dma_length() already treat U64_MAX as an error sentinel.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 5a02285a4986..1f132611a6ce 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -2,6 +2,7 @@
 /* Copyright 2025 Arm, Ltd. */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <drm/ethosu_accel.h>
@@ -165,11 +166,13 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 
 	if (mode >= 1) {
 		len += dma->stride[0];
-		len *= dma_st->size0;
+		if (check_mul_overflow(len, (u64)dma_st->size0, &len))
+			return U64_MAX;
 	}
 	if (mode == 2) {
 		len += dma->stride[1];
-		len *= dma_st->size1;
+		if (check_mul_overflow(len, (u64)dma_st->size1, &len))
+			return U64_MAX;
 	}
 	if (dma->region >= 0)
 		info->region_size[dma->region] = max(info->region_size[dma->region],
-- 
2.53.0

