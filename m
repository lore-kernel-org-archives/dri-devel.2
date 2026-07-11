Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D219C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8029810E7E4;
	Mon, 13 Jul 2026 07:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="aZgfseqH";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A610810E2E3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:21:52 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cab973140bso18334875ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 23:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1783750912; x=1784355712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MohOilWXvpBfnew3g4ppmtjZUX4BYD1OOd5Gl7wJD2A=;
 b=aZgfseqHbAv9RQ9Doira0OgWHo8DD3oNaaHWggVmZQWTcumVSUas0BFNuCbkN2hcel
 wPbzBNYq48qc9jDC0iPu2ep3ho/RjZR+t3jVwcDdlZEwzOrsUg6iT3wUKigarlv4mToM
 2NSoc7j8l/UmrBO0H+Ehv0ZmCNZ6HQA8NBvFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783750912; x=1784355712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MohOilWXvpBfnew3g4ppmtjZUX4BYD1OOd5Gl7wJD2A=;
 b=EpLBqQPlYnwubvz6YvyuN4qr1+Ksji9Ur6zfHKHYTkJhSDalmHc4QbMGCLwcOMImV4
 xgosujtFhg1Hg6JwsEIwrfRVgus3T6URL+PI9rcxP82nhoj9PWrJY0iU96Kiq5LX+J5B
 uaGTVkxGi2EvXndp6T2HxvixI8kv+SuWNewvxaJ7NFaGUnim8aSkQi2JwkGA3PXv3OuQ
 x3a+WrNfw0IrsnE8/e/4sOH1hlEm4uM0lPJAY6XEeD1SWTTdC+okEGhPQK4D5fQi3aiu
 fIr1EUBbXEKXZEIRLXtdTrJNv8rbYp9WyXttWKYqZNOMAfNJJRy3t7NoAnWizLAXBw3g
 YdTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHemziyM+DB4fzUWXPaanZMterYGJgUe0jpzYsxNgftk9Y9WuejL1yjfHl/Q/UpAwTOaZwF7Q6do8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvsYLxy0ndmLiVjalJW/vzySdjjldsvlf8m0KYVE4KHIxTiD0D
 HDPwwMV7toeTZZNVROLPszpuJZk3JOBH59IMVqRe/U7ujEfdWfoKoXkoaXIrUrg4hwo=
X-Gm-Gg: AfdE7cl/dK2YBw7aMatySmMbNIQ4obcmThwpsq3TQLUNZuiXFe1j6bht0OEOzPuhGUI
 rlBmQmxw2bzWlEWZ8DGS7OcM9ildcrNsr53TWzgzG14IbI+6GjOq3AaRS3awk8g2YWZBH79Su5y
 rT5sq3UwOo0/G9KZ/bZE9pOI7/RFnLUa4S9tfnFGmeK0HM5nayiVUkGhm8OduXtCEy4Zn2O3BTq
 0f5Zgh2qt7E5E/LGYw0TuJCuhfiJL590NkTmywqVREE/pHSC+VoUrI2ci+b4ib9mkps22xcanaC
 naOjYWIlSGmJwIIJZytrJePgMxCwTT9Z2vnhLV/fv5D9Il1onwnVdk5niTVptt0f2q+N3MA4zgI
 NOHL2VmuCmMMI059Mb3ZD6cnDRlW3KCVkoq9hOCahyJ9kKjtnKiRT09qg0hr0TGTi7++UfuMkl0
 Oynvo3rJGnh3xsJKS4G0CUZ19kY51E4Nhv2HURtMsGAkSX+g==
X-Received: by 2002:a17:902:ea08:b0:2c9:e69f:8b0f with SMTP id
 d9443c01a7336-2ce9eabda1cmr21679715ad.17.1783750912060; 
 Fri, 10 Jul 2026 23:21:52 -0700 (PDT)
Received: from localhost.localdomain ([116.124.210.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf7858sm70071775ad.23.2026.07.10.23.21.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jul 2026 23:21:51 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH] accel/rocket: Validate task regcmd address and count on
 submission
Date: Sat, 11 Jul 2026 15:21:37 +0900
Message-ID: <20260711062137.36044-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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
index bb77b6bf0f23..9ebabf86fe97 100644
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

base-commit: a284476db2653ae893f46cbea408eb412db54eb0
-- 
2.42.0

