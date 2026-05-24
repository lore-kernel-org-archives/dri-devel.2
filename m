Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3DBCD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8F710E3FF;
	Mon, 25 May 2026 06:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IpLmrm4w";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079CB10E065
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:37:20 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-838d0b7c950so6300530b3a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779619040; x=1780223840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Srn/gFRHpPCBsHxpWI/ceV1wqLaO51KjDzwp1tS24PQ=;
 b=IpLmrm4wierRFenN2+z9Wj+QNqmUiffGj5PJHWQt5hPEG+BMj7RUvExw1b740mpBLy
 tY8YyfMWWySTjHz8EiURKheBJZgeTI28sL5r49gvy9Rdd0eNbGA8eDDQ0LcE7j5bx1PO
 dJA+LVsxzCEnArCXDFnNRsBNLNCGIB67QJVyyItoygNJ42/wzl8vwdANVFzn00caMhdo
 zdsoElHmBN2MazRJ/RHPXTuvqQ4aX6dAAohljD3yxs9UR5YkxXo6yaqmtFkWhEv2hmY4
 5BvhUUEACRp9Rolw+Q6WnUXMEP6OTNTc2X4yuW2TQFyXZaXM8cw9aT21+dkH6Wa68XqO
 aLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779619040; x=1780223840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Srn/gFRHpPCBsHxpWI/ceV1wqLaO51KjDzwp1tS24PQ=;
 b=VueDwvs6NFlifpzaQPbEiJk2GMmuPpRW53l9cnUZB7XOW66n5ZyFoYjUL4ky9M7Tvr
 i024GHHjkHZf+jWHwjQyolv0pfoXFjWBASMJB12RqUMsGcACZjRR9iImQ8xG5DaGOATy
 c52cNX6X7+kP/YR1fB+HDHI57ce8JpCTKMllxrFlGvZ6e0pKIpYVFqmMALq/dKHqGqD0
 eGw73Yr6IzuAy5xC/KO9ABQ8hzjVoEalSfN7Jo4RmZpFn9/qYfRUrtIfX5AoP+4P8+wt
 TOT5UTNJUEPi1nkrBxjzkSggImpWJyl/SRtZApVAIE70k//+uRO1e+AuSioJ86XH3f3E
 Z5yQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dW2T2Jchkni3KVYi9K//eQOtxNAjS0Y9HHunlEb4pMJnbQr6BLI6Cj/AFcIwWWgiLmw0jVrRtiEY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPI7t9cTndqSbQ9c5yJJBFFz4+DmtHExV4yiQXqqaGVwIhPcvO
 brcCcqay/dFs+1FvoWKJJJwsWAHv1fISF+cKEanmKKs6b8Zvs+xooi7v
X-Gm-Gg: Acq92OHKY1b29ZpH4ggozs9A5R6IlRLeCtLGyJnnLjHIL+9ruS7xqCvp+4KHIRHbcqS
 dWmDfZWGo7H0u0z0xyOaSZmrJ4hpOJceL6qPoy6ZUpDKr48UQPXzpTY6uU1NeRsRnWpil/35+WS
 KRsK3ePql/u2nXOi/1ZFL2O7Plj/tD2iQFOwffRUv5SQwI3bLnhXb0E+K3vRs3ExXi+eJWdhDsB
 LqPL4dRkhWHsUned0QpkgUYVpWV9WtEcrlJXtozaAkgKPMmBtmsKZ8eUWuvCCMfKzFDBjH8FmFn
 nSPLVgDZ+tDbTLf1os7l+S1tlC/6n8epCd/zhtPC9He+5X619Ei3ivLwnHxYWHKgSG9uYc+vMkK
 buhhXcjoRtY9Q3C8kjjdLASalU3i33bvF4xA7dyjtqMoSCOh21gglzIYrbnLRPDxuHve4ehN1Dl
 1OjoKBBGG3yKKrmBVMxqFOO8lzNPsvTqbX8+6DCsp1YflT+8x0u2Hzu8emYSPKQrnXoAjepLwVx
 XQNQzrRl/b8NK2drwPT72rCPZVljwdkJktZhy41qqI9ERrmEnXnEh+qLz+EqXpI9YT/eJYxyQKv
 /PF9KFyt7AI=
X-Received: by 2002:a05:6a00:4f94:b0:83d:b11f:796c with SMTP id
 d2e1a72fcca58-8415f3d3adbmr10063728b3a.49.1779619040399; 
 Sun, 24 May 2026 03:37:20 -0700 (PDT)
Received: from
 codespaces-78f0a7.dxrpqgqhlb3ehogrxrezr215ye.rx.internal.cloudapp.net
 ([20.192.21.56]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe338sm6763005b3a.18.2026.05.24.03.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 03:37:19 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3] accel/ethosu: fix arithmetic issues in dma_length()
Date: Sun, 24 May 2026 10:37:10 +0000
Message-ID: <20260524103710.47397-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524060644.106635-1-meatuni001@gmail.com>
References: <20260524060644.106635-1-meatuni001@gmail.com>
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

dma_length() derives DMA region usage from command stream values and
updates region_size[]:

    len = ((len + stride[0]) * size0 + stride[1]) * size1
    region_size[region] = max(..., len + dma->offset)

Several arithmetic issues can corrupt the derived region size:

- signed stride values may underflow when added to len
- intermediate multiplications may overflow
- len + dma->offset may overflow during region_size updates
- dma_length() error returns were not validated by the caller

region_size[] is later used by ethosu_job.c to validate command stream
accesses against GEM buffer sizes. Arithmetic wraparound can therefore
under-report region usage and bypass the bounds validation.

Fix by validating signed additions, using overflow helpers for
multiplications and offset updates, and propagating dma_length()
failures to the caller.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---

v3:
- add check_add_overflow() for len + dma->offset
- validate dma_length() return value in caller
- rework commit message to avoid unproven claims

v2:
- add negative stride underflow checks before each addition
- replace unchecked multiplications with check_mul_overflow()
 drivers/accel/ethosu/ethosu_gem.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 5a02285a4986..8e95539da98f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -2,6 +2,7 @@
 /* Copyright 2025 Arm, Ltd. */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <drm/ethosu_accel.h>
@@ -164,16 +165,26 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
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
+	}
+	if (dma->region >= 0) {
+		u64 end;
+
+		if (check_add_overflow(len, dma->offset, &end))
+			return U64_MAX;
+		info->region_size[dma->region] = max(info->region_size[dma->region], end);
 	}
-	if (dma->region >= 0)
-		info->region_size[dma->region] = max(info->region_size[dma->region],
-						     len + dma->offset);
 
 	return len;
 }
@@ -397,6 +408,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_OP_DMA_START:
 			srclen = dma_length(info, &st.dma, &st.dma.src);
 			dstlen = dma_length(info, &st.dma, &st.dma.dst);
+			if (srclen == U64_MAX || dstlen == U64_MAX)
+				return -EINVAL;
 
 			if (st.dma.dst.region >= 0)
 				info->output_region[st.dma.dst.region] = true;
-- 
2.53.0

