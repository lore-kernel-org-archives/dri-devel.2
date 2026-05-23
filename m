Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89014CD5BCB
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA65910E3FC;
	Mon, 25 May 2026 06:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fGatEwr5";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FD510E33F
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 19:52:19 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-365d8e43759so4353650a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779565939; x=1780170739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lWrWJYufhREX3pTpYqP+nOLGz+ztZIkOJ8+XyiCxrpo=;
 b=fGatEwr5USrkA6ogH/xkIaTgOPxUhThuNfmyPCjJznJMm3gtMtPcAZkgOGk5Ec71qt
 FRBa+EHBR6QZWtijtZCIo6NiwVd5bz05E7wNiU9l3QefAH2y4XB/LtPOyVrBBcMkCW4o
 L925UV55VmniK10sHWYoeoluoq5/iltynysV5Tcdbm3xfYiV16cgZKD6hhVAW4WBUeMB
 bp1u+tbrfTVuLqVzS+6SldxeUnYpE5Q9/Yfl/buQx5r9qTLqIvbbOMSlBMyhWN0yCh75
 SdqKZ2aUW9WKsxvHXiMrfwC6laxzKr41onEqTipfIxK6XGbVveZSieVJtGoBupsCGD6q
 hiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779565939; x=1780170739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWrWJYufhREX3pTpYqP+nOLGz+ztZIkOJ8+XyiCxrpo=;
 b=P3kbyn6PmMlaLzakEY8zEqyf7VM1lJZ/G2bA+8EjPzbcIue8eW2AxMjHdGiiSgth3t
 qTNX7EZ7F/5z+h061ajxKkgoAJo36oujyCcmDWpoTxbhzCY2bFoX1VYliMZt8/B7/t4K
 P3AXHwgApkFaJlaeoGUY9udXk+zvgFgT5bYXXjKgHI5wvwcgZ7GLrKSsQwmXR4UC7fwJ
 YaVf2Sqn1LYJPsRYrj1obqCIR+7IIN4w5R9gs27IBLoPCcxgJMvmKORx7erkuDiCtLsY
 IdBfCLdjtvnLPFINzRpnrP2F5dojFRCgekhnz5J1NWj2q5KQdxbH8fjpgtNcI2x1jTSx
 C5IQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eXJbE6Yld1t0g3yEa0PnqD0SSj3m4wBCwc2cdI64dKfNhq06aqGXbdKkMQmwyqFUdkxwDCwVWzn8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyf5vz4+x0xrqDbChwHxNFP1CUIYyxlF6kAAiTikA+fO3efTWyH
 B7KBmJrrRTnmEBYU1deO3EQmnuQCFhF0rrMhopKILW7BC8QpthumA/jA
X-Gm-Gg: Acq92OF2on0c18exqpphb1xA4h7J9u+X4Az5kb50XuHTo99qfYY+Mg/JgP7xnDCUODu
 z80vRRqGXO6nXnChT8qaoBas26an/9RuinQa2IhmF17TQVAHohtDffn4bImub8gUukksOxQuahj
 x4z7ZnGDJ2BsNnR7q3bsVC/m5Po0C4ymuBC7MGbCr1BBhKcWFUp0pxjj5Ns2ezGu8TEYkLAoIs8
 9inf4JCZVTLfQVyznBoSVhMd7HAPzBJvRPsCvH/wXRCrY1bsOVnKBkW0In0G5bUOIguEqG4Ia41
 AHURBXp1Xztbpj+ztR7D7IZ8D2jjqrmgImhbm/j0s+UOfWqwS87wv0+tVymlK3n5hCo46vk2fb0
 cc3ssyxeh7ET7MW4MgwSjD29ea9Kh74Elvudu+QqGZo0DvGhPznrZmU3cmdkz0AzFxnkCiFVHJE
 v7tYWUQedOIOCAFk7e1RRJXeDx2rWxKoXrckAslVUzqNuyipuWPxEK3kA4OV519DJ26HNNqzc/S
 VxiOyVApbu6H0AU1EGsD9mp6gsTL6BEHhWFPgpKcP8r5N1Re1wsYFCw74Myu8zp0Th0ks4A/hme
 4DRWFXpo9i0JA3OHLbjzQQ==
X-Received: by 2002:a17:90b:1d44:b0:369:7944:d723 with SMTP id
 98e67ed59e1d1-36a6bb5a6bfmr5964578a91.4.1779565939265; 
 Sat, 23 May 2026 12:52:19 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7212aa06sm2993459a91.3.2026.05.23.12.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:52:17 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: fix IFM region index out-of-bounds in command
 stream parser
Date: Sat, 23 May 2026 19:51:59 +0000
Message-ID: <20260523195159.55801-1-meatuni001@gmail.com>
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

NPU_SET_IFM_REGION extracts the region index with param & 0x7f, giving
a maximum value of 127. However region_size[] and output_region[] in
struct ethosu_validated_cmdstream_info are both sized to
NPU_BASEP_REGION_MAX (8), giving valid indices [0..7].

Every other region assignment in the same switch uses param & 0x7:
  NPU_SET_OFM_REGION:  st.ofm.region  = param & 0x7;
  NPU_SET_IFM2_REGION: st.ifm2.region = param & 0x7;
  NPU_SET_WEIGHT_REGION: st.weight[0].region = param & 0x7;
  NPU_SET_SCALE_REGION:  st.scale[0].region  = param & 0x7;

The 0x7f mask on IFM is inconsistent and appears to be a typo.

feat_matrix_length() and calc_sizes() use the region index directly
as an array subscript into the kzalloc'd info struct:
  info->region_size[fm->region] = max(...);

A userspace caller supplying NPU_SET_IFM_REGION with param > 7 causes
a write up to 127*8 = 1016 bytes past the start of region_size[],
corrupting adjacent kernel heap data.

Fix by applying the same & 0x7 mask used by all other region
assignments.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index f526f4aedffd..80d4bc21c28f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -466,7 +466,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			st.ifm.broadcast = param;
 			break;
 		case NPU_SET_IFM_REGION:
-			st.ifm.region = param & 0x7f;
+			st.ifm.region = param & 0x7;
 			break;
 		case NPU_SET_IFM_WIDTH0_M1:
 			st.ifm.width0 = param;
-- 
2.53.0

