Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1528C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 11:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F28610E02F;
	Sat, 12 Sep 2026 11:29:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="d7ldoOUo";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1956410E02F
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 11:29:45 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2db3305f94fso26164705ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1789212584; x=1789817384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w255+3K8FAv+3tRtSRmVnHCmz5J/V0IKovZZCjW8Bfc=;
 b=d7ldoOUoGj39UIMzHEMM3S1EFEOeD8Jd6cmSft3oEDAC1jowHu562zgV/GwV+3F44b
 IS6l5+3sHqfropbDHHJQ8amMeWZCXxusyXaVmhAR5pRc2Eh3qlZZXOU3SrxHYRETvi4m
 1fENuBbzXflXMLOd3JJJTP48JAlRM4+JMPkkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789212584; x=1789817384;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w255+3K8FAv+3tRtSRmVnHCmz5J/V0IKovZZCjW8Bfc=;
 b=UpUT3CKCT1RzZ4k0LePJK7I+5KUdsAkZ9pexvfI4D6HannuyQh7XN+LjY90RQvjk7B
 Sn/2XquOoiQKhaZ/U7qR036sAhGciTo5QCEM5v4oyrOmss4Bac3jlJTvYGTL/80/Hs0C
 EdOqGkEZftuQdTHAog/gpprYwAAEYccwmk7oRMcq6UDQbkeVpXMxJX80pntPvYFI6SNz
 6hivLh2eRAVNfU8Hadt3xvTiaPIY8b7D8GBIjiT6Od0WuoENuMA3vwb9RoazhKMMI7//
 tAydcc52BytL3z+cUVh6OUkKwAm6EIg12ePy5+OUnbUtFnAY/+NCjGzGwyo7TRC6MMqz
 9g9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8OE/U1kgQVZED1ZxpcsyIHj39UZonfESbcLawVHZIoMStHQG1mlA3GZDB1sIIELIbJu/5cQmEN84=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNbF96S0pR6fHsQQDjTCIZ+V8W66x04gep0GIHCAXen5tPawAU
 yzooV+xB7CiXkgAoMboi98V00eGkgXDSPXR5Weqp1FhhKxYwLYfcItGLAa/9MPrAP24=
X-Gm-Gg: AYBFou1orip58ob5xN3MNcMkfj3DGYYLFa/tzXfY5uCNdVlucFOxvs3Tn4UV0ZcBzuM
 0s2SUCWDtt67gSCxcm+xGbOEfPGqrg4fKtMqUuxI3WAxborFwBNHkjpHf+H/cgY6M18Q0+qCbB/
 TOBAE70PY+b1d43dTZfuTtZ+0XLkkC4pHocYPosrgNsuwjAUn0o+PVLbClqPeHp+M+4DJe6mYyF
 kUjsVPRw9AfH/jC44mysnZ6eKfjoBf4lAMkxpJFZrTa4Ka6IsLZsqxySFURSz4MC+T5z8a+dnkJ
 sr0og2jnlVkdCNMXzxrs44X0w5yWG8G0GZ7wUk7BPpbnZFyz/cQsjuVTjIcLWqCmXTa7E6Tr+nj
 WXUedHrJMZEODKlKzwlc/qbvQo9ubVkkOHC+Sw+US7krgFwin+ZpOIbo6INItJs6v0hX7r8tiV+
 GmXv9Vq3/MZu6JNOOA5MQOGZerI0EWBgarn8wRCCTvVIu1rILBwUNEC8D+1z1eyloyXjezEtMui
 w==
X-Received: by 2002:a17:903:198e:b0:2bf:dd0:c8b1 with SMTP id
 d9443c01a7336-2dd29ffa6b4mr164443135ad.0.1789212584566; 
 Sat, 12 Sep 2026 04:29:44 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cec7ee5sm23666565ad.42.2026.09.12.04.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 04:29:44 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Sidong Yang <sidong.yang@furiosa.ai>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] accel/rocket: Validate task regcmd address and count
 on submission
Date: Sat, 12 Sep 2026 20:29:22 +0900
Message-ID: <178921240194.10.15893724064993644797.rocket-regcmd-resend@furiosa.ai>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Resending unchanged since the July 11 submission.
Applies cleanly to drm-misc-next at
9d4c98219598e77ca7044c453ae6994519ac0a96.

Previous submission:
https://lore.kernel.org/dri-devel/20260711062137.36044-1-sidong.yang@furiosa.ai/

A review would be appreciated.

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


