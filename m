Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38D2CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7C610EAA8;
	Sun,  4 Oct 2026 16:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="gCoL3RBG";
	dkim-atps=neutral
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73CEE10EAA7
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:48:02 +0000 (UTC)
Received: by mail-pj2-f38.google.com with SMTP id
 d9443c01a7336-2e2d58a3b05so6403965ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1791132482; x=1791737282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oO6c655YlcffNU2PNOxSK+WlZvvM5uQY49LVUr45wK8=;
 b=gCoL3RBGaTtVpjtpSx8bnwHfHLbD8nC61kQb35E8qpzZ5oitntgw02Q1nyyxyPJvzR
 rGkDwJIBvOQaPSpf0XW5KUPVxHKyarjQB/rzutcnRzc48ktyjFy3hvd73EYKmWghPY6k
 lG+y+gcYZAlM3oKR4SJKxuMlqzmKZ8e1uzMno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791132482; x=1791737282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oO6c655YlcffNU2PNOxSK+WlZvvM5uQY49LVUr45wK8=;
 b=vwTUwhwBX6+0b7PmaZCi8m11VEowVnfnvn2ADrCamEF170d3iM7lf7tAc0JDtJd12I
 xJFtqEKfQIaKx88L4oDeBQtdixLvUsZJRBpl6KjQYHRO0RsdSZZYZE3SiPMLhu/Wj7ub
 dpy+XswGHLDxi2PGWbkptzqw0fCoP/8BjFTWh1rjm+edBs/puWX0jzMRQHI0A3TcCOLX
 klNoP5dBIQgmaGzYnG3TKeDWuk3xtiuak1G88JZLZ/xYNVMgW/WHGAEWRr1gj86WrAiu
 BXqMli0I1ekfPTYfheyT+nwJu0Md1FVYCuyqqOT0/hH8DHiAJpxbI0WtTJxuXoiu1V2P
 TiwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3R4uUWaMyGbq3x1aVOQSSwtTtjhrfyxV2A3l51Ime3dnTOFwe/LevSkcq3bNTJ27zUVcZJtje7Ww=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLAKFhOt6mM0CCKP9jHVGroKi10PdxKQsYzRrbrRp2sTGk5r1/t
 rurpY0N4zduEDsRsp5oeA0a43bty0MdyoP5cx3fFWFt4FVlnYP5E4PKbrPl2ioua3BA=
X-Gm-Gg: AYBFou3HgApiZQL4wEJaPCZQovPJFKFz6ZrX4a16L5zDScfciUUTuHKedDb4ObN6YBG
 QfpQR5ujfWsa+0U4fqmPjZMM0xe2jUssVzfKXjb7DZTWHrrrnDQEKyUg/DsATlAKo72GeuBWf58
 Cm0WI6kacnlYr+3bUQPDi88B1xwxa2RoUwcpTA2SZ5QZR+WMbfwZ0SF5nKKsIBcSQ6xE2U8RLoP
 GE8DSyhqA3BAeZcy6H7l3Q0Ap/FVtfuP+AM6zikMJPyOnPteGSFw4SKORXMU38vi/hTyBXroZXp
 09CHyAoLKwXqA1aiq+S8SffHx32R/6qPyFLYbvCc345n8hj0E6YaaDLjidMTM2DtJc3na9QbixK
 OHD13LbmY4kxiV6cRAZDTstZvok8C3GcNcpBL7mTb11TvRQ8dSLtgVkYYJP7LP6Z8QogewWgufX
 wLiEENsziJ4M8DlXMMb8g/8bB4ln4mdmLASViaqYXUPO3To5Kd5QRuNcVWqkfK8pfIBjvx1NnE
X-Received: by 2002:a17:90b:4b11:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a6cec9b3bamr7206297a91.39.1791132481955; 
 Sun, 04 Oct 2026 09:48:01 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6dd0cd76bsm6500454a91.2.2026.10.04.09.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:48:01 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH v2 3/3] accel/rocket: Validate task regcmd address and count
 on submission
Date: Mon,  5 Oct 2026 01:47:27 +0900
Message-ID: <20261004164727.466164-4-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004164727.466164-1-sidong.yang@furiosa.ai>
References: <20261004164727.466164-1-sidong.yang@furiosa.ai>
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

The regcmd fields in drm_rocket_task come from userspace and are
programmed into the PC unit without any validation.

Bits 31:4 of PC_BASE_ADDRESS hold the register command DMA address
and bit 0 selects slave mode, so a misaligned regcmd silently drops
its low bits, and an odd address flips the PC unit into slave mode.
Similarly, pc_data_amount is a 16-bit field holding
(regcmd_count + 1) / 2 - 1, so a larger regcmd_count is silently
truncated by the register encoding.

Reject unaligned regcmd addresses and out-of-range regcmd_count with
-EINVAL at submission time. Existing userspace is not affected: Mesa
places regcmd buffers at 64-byte aligned offsets, and its regcmd
counts stay far below the limit.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_job.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 428de5a7cb03..ce994748dd5d 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -7,6 +7,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/rocket_accel.h>
+#include <linux/align.h>
 #include <linux/interrupt.h>
 #include <linux/overflow.h>
 #include <linux/iommu.h>
@@ -21,6 +22,15 @@
 
 #define JOB_TIMEOUT_MS 500
 
+/*
+ * The PC unit fetches two 64-bit register commands per pc_data_amount unit,
+ * and the field holds (regcmd_count + 1) / 2 - 1.
+ */
+#define ROCKET_MAX_REGCMDS	((PC_REGISTER_AMOUNTS_PC_DATA_AMOUNT__MASK + 1) * 2U)
+
+/* Bits 3:0 of PC_BASE_ADDRESS hold the mode selection bit and reserved bits */
+#define ROCKET_REGCMD_ALIGN	16
+
 static struct rocket_job *
 to_rocket_job(struct drm_sched_job *sched_job)
 {
@@ -95,6 +105,20 @@ rocket_copy_tasks(struct drm_device *dev,
 			goto fail;
 		}
 
+		if (task.regcmd_count > ROCKET_MAX_REGCMDS) {
+			drm_dbg(dev, "regcmd_count field in drm_rocket_task should be <= %u.\n",
+				ROCKET_MAX_REGCMDS);
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		if (!IS_ALIGNED(task.regcmd, ROCKET_REGCMD_ALIGN)) {
+			drm_dbg(dev, "regcmd field in drm_rocket_task should be aligned to %u bytes.\n",
+				ROCKET_REGCMD_ALIGN);
+			ret = -EINVAL;
+			goto fail;
+		}
+
 		rjob->tasks[i].regcmd = task.regcmd;
 		rjob->tasks[i].regcmd_count = task.regcmd_count;
 	}
-- 
2.53.0

