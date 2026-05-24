Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B84BCD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F85010E3F5;
	Mon, 25 May 2026 06:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MtgN50LH";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A91F10E16E
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 06:07:02 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso3950611b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 23:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779602822; x=1780207622; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/5rmJ0MMc9nuHByS4ezujVFP1BbYR7lj+NuMOXCZLY=;
 b=MtgN50LHK5lBo7ONcVLnyeM9wqY8oD0ZUjOjNTR0kDfi64IPXW4Lzce1m3sxoo3jef
 fQsE8dDXE33Gsy/8C4S3Ve7tSy8l1l+N4K1JUwlT7m9cggWmQHBQeI8wwNrTeTiXJ0As
 OAK7VWp22DT/jM84u83+XCZ13bA8ySB2O7sG4MaA2/2pk4lEo0CSO00eiPWHyDeS2CgQ
 51u74M075T7uVH3XH/Vaw2KwPyAY9m8L0HC6Q2IjhPS9ga6CWOrHGOcXMORuwgTP9uz+
 qJTUicS0uEtliJlZX64SsizR9Iuj29L7uRB5egw9xSUeKFjXP1lPjl0wgJ/B8LJGP/EP
 ucRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779602822; x=1780207622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C/5rmJ0MMc9nuHByS4ezujVFP1BbYR7lj+NuMOXCZLY=;
 b=Hw51bphkHmKk28lImFTQz4aN+fG8G9YxsCsljA0VBrTpVmT1KsMoirYT4lQ6wv2vSz
 +Fk7qVwwhaL7G7BMZ/hRfbt5y9IFx+MbDJekKSob9UUJeJbztXtwzBnOkTUnP7JHWfXE
 tNkwUeQE0uATUoKjWy5L/FSQOY+aUcHz1Qh2VBsN9mvefVduSMC6dSIZ7wtUdx66PFjS
 IvwmgqfL68MtGel/7warq/mXd5rUuLs7JtnQImsgfgEwLICxTh2QKYh/myFbci3ps5St
 XeLysCOHSN3LIvS5S9SNDI5h6+l/0u1rCUqroyiwbBBK27wv5ZwvV0e7gRK+WQOmMqVw
 rgYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EGSxp+XaXmP9Ipr4f0A2c6+Cw6lgD5994xiI6PYWA9bg3oXTZgtd+4hVeJDBvbDgBXDOnS1S1NEs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzb5RHW57Vg9LltPEvO49mYQfEYizuyOHfqn0zlbZD8IW6SrqVu
 NS5DTTXEorP24IagFYu8B/8pSD+Ailb5nbNuIXeSAW8r2nKT+eDo+7ax
X-Gm-Gg: Acq92OGNUtOQsYAVjM7yyWSoLdDPRHYRUqr458Exsz0PSDID4jgmZpOQFvXw7J9q+c1
 rH/Zn17VNepDZDTEvYhMM83zU6D5zW6gYEC6i2FPlTnM6XUUitcNuNIqLkVrqCoWA1pO8OUuDwz
 MDK1Olf7aFdcppXL9RyjGnJv9qtUEOA4n2SDDqhF74vcb5yMDFunA71Pp6kribXChLa+UH79e5Q
 p/WFUIV0if7XKyLxHs+SWRX0E/BpxOrs5ce5AFfgt9gQvAbJV541P7f25pK1PLZEvJiHgD75r3F
 zrEvxKh0JfCtQcjFNUJuuX1+nqQguW3bd3rlL45E1i8pyj/toH6EER5gLP+xrQVBEC+0ah5FqF4
 v/wi0fKbtVLJ7jIEGPxW5gny8OKKpd1wFKpb3uCt1k6l6GEwDelNDi7RehgZNtfNlIzNhICpbz+
 zYBgyedlcf3IOC/+xhyKbotkKAUD3+T41X10zOwvKuS1AKGDrpDQ2GASF6jBd1D43E4HhU5nOWG
 3tA74pw64tjr2yxHT5HsaSDYfUo4bTnKdddGLAUrOtgmWhAcyPCVSw+sXtgVfFqJtY/GtsnU565
 7h+Nl5jhr0RZ03y+sgKy7g==
X-Received: by 2002:aa7:9067:0:b0:834:efcb:12b4 with SMTP id
 d2e1a72fcca58-8415f406722mr9473675b3a.28.1779602821789; 
 Sat, 23 May 2026 23:07:01 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.196]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164fb00b6sm7310818b3a.40.2026.05.23.23.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 23:07:01 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] accel/ethosu: fix integer overflow and underflow in
 dma_length()
Date: Sun, 24 May 2026 06:06:44 +0000
Message-ID: <20260524060644.106635-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524051659.70654-1-meatuni001@gmail.com>
References: <20260524051659.70654-1-meatuni001@gmail.com>
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

Two bugs exist:

1. Integer overflow: the final multiplication by size1 (up to 65535)
   on an intermediate result that can already be ~2^55 easily exceeds
   2^64, wrapping the u64 result to a small positive value. This
   wrapped value passes the region_size[i] <= gem->size check in
   ethosu_job.c while the hardware executes DMA with the original
   large strides, accessing memory outside the GEM buffer.

2. Negative stride underflow: stride[0] and stride[1] are signed
   64-bit values sign-extended from 40-bit user input, and can be
   negative. Adding a large negative stride to a small u64 len wraps
   to a huge value. With size0 or size1 == 1, check_mul_overflow()
   does not trigger, and len + offset can wrap back to a small value,
   bypassing the bounds check while the hardware accesses memory below
   the GEM buffer base.

3. Missing caller check: dma_length() returned U64_MAX on error but
   the caller only used the result for dev_dbg(), never checking for
   U64_MAX. This left info->region_size[] at 0, causing ethosu_job.c
   to skip the region entirely and allow hardware to run with stale
   physical addresses.

Fix by adding underflow checks before each stride addition, replacing
the unchecked multiplications with check_mul_overflow(), and adding
a U64_MAX check in the caller that returns -EINVAL.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 5a02285a4986..0383b7a6c3d3 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -2,6 +2,7 @@
 /* Copyright 2025 Arm, Ltd. */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <drm/ethosu_accel.h>
@@ -164,12 +165,18 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 	u64 len = dma->len;
 
 	if (mode >= 1) {
+		if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
+			return U64_MAX;
 		len += dma->stride[0];
-		len *= dma_st->size0;
+		if (check_mul_overflow(len, (u64)dma_st->size0, &len))
+			return U64_MAX;
 	}
 	if (mode == 2) {
+		if (dma->stride[1] < 0 && (u64)(-dma->stride[1]) > len)
+			return U64_MAX;
 		len += dma->stride[1];
-		len *= dma_st->size1;
+		if (check_mul_overflow(len, (u64)dma_st->size1, &len))
+			return U64_MAX;
 	}
 	if (dma->region >= 0)
 		info->region_size[dma->region] = max(info->region_size[dma->region],
@@ -397,6 +404,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_OP_DMA_START:
 			srclen = dma_length(info, &st.dma, &st.dma.src);
 			dstlen = dma_length(info, &st.dma, &st.dma.dst);
+			if (srclen == U64_MAX || dstlen == U64_MAX)
+				return -EINVAL;
 
 			if (st.dma.dst.region >= 0)
 				info->output_region[st.dma.dst.region] = true;
-- 
2.53.0

