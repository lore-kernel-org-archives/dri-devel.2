Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77616CD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808ED10E3EF;
	Mon, 25 May 2026 06:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pRkV6Csi";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A298510E166
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 15:57:32 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3699cdeec05so3687234a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779638252; x=1780243052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5pGO8hezM1yTgC77jiIpPHRz4G800mj82NUOkgOlqoc=;
 b=pRkV6CsiEOzUF4zrI85+6DvjetlPCHgVfaXHwIUaoBOdES7ZxX/upPZ4zuDQOFZXyJ
 ltn8YoGQ4Y1ngfKQyCgo7QXa007zahUNIu+dQbEApr5ep+oy+VELec62XFJ3BgQX8bFj
 5/mdG38DAz7R1sYq7rWT5+Da12TeCoArA+nwk9HHrRvhcAYrsg21ZSpEi9KT10oIWIh4
 hLjyRLSqZDv4+T0q6yfqB85pUapeJbFVjmjT1rwW0PTCJ2IVPjEhGBs4b5QoAG3gCHal
 s6/HMjc9otMW61L18+AYhi2NXIJh6wPAgqeAjmbuRqrdR4bTO7f7B0t7dLHYCAum3Rfo
 Ccsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779638252; x=1780243052;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pGO8hezM1yTgC77jiIpPHRz4G800mj82NUOkgOlqoc=;
 b=RV1DREAW8zCm4PFqtgt6N6vV4vk6R6YEYqHY+HSUT5BDhaxz1LPKgxfz/UHMpzJEGW
 A6SZKGNeJdf0/myjj/78zaSyiZCtIVVq5/FEt0MKP+YvBgwl81FQhSHyyxLLGROe5SzC
 SHP39kHc2aeGCjvEUeCt8eT/lzk8ZfQCZLY1/Xm2cf0lm9R30ycUcrSKzd4mJkZRNYE+
 Gv6Hzrq8L7w29qQ1HbKVArLNmE3MEQxkvJOGkiRsImX0hWerDdVVg3oDhRlO+owNU9Iu
 aenWW2z4EZL956iIxEe71NT0wIdYmKoMFP7nPdUmgdYdnXWbSDM+CGYslNZHvpl4qJXD
 GXMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SKfWddYx84u9HwFy+7i58DjDB3xR2b9Y7FEfBMIr7DpiXg/JjrcxNp36mkDbWAqHoSz47rF0UdXo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySa5R50uDSWABhnME4yBjMVPljxglnF+Q1+jTs37CT4VAO8Hl8
 wQGmmUm2wEQwpEGioPka79Ap4/4Ud1DHv/lB3jW+p2zDmRZ5k+RO2pVp
X-Gm-Gg: Acq92OGVbO3cDRPL7UHr6tEzlxUp/zSsnaMUkMoqsfE5DlBPX7xA8aJGrRtdFyKJCwh
 P3wcMwcKYADi7DXrZumIrkc9NvmbCOngmosCMnQtWLx4pHB7jHCzpL+g9F3gJWLAkB/FoSCXyJ/
 dNmZvpa24/iCdzRqpbHVIW/Tb+HBVaIlEwqPgumNFf8anTQqLPNasL63iw0qlwtWK+Aod+2U6gI
 dz5saPfkfxk5fTGT7vBizwm2+ct5ySqZLba8M/ZCTWr+Ej0U28X1uiqFwhG9+9253knRq6ESHXk
 ms6QpoYEjhU+pZU7SsPSYvzvxcVN5bfQwZdPATDmFjpL2SeWHWGdCMfIc5dBeKKgYlgwwV5IaZQ
 8Yc6QIKGwr370Q9PNoWeA3q/smpe7ahpbvGn04kJ0tPobvDuKom61gGsV8IF80DHM4OD0KtJ0iy
 z+qSoIukcYNIGqgQXBX1S2z9W0lnM3EmciPjWPDEXjwEoTSyaOq+mQffyTVFRYcVbGHaiZC0OEe
 fmIsrFTq9rb6II2L+q9E6eXkw2DO5abG+H+5xkU4ljmaTYYxXWSMEIjZZK0srQ9q6LqYZefQ1Mf
 zshnI8gkZJOWdeK4TId5og==
X-Received: by 2002:a05:6300:2795:10b0:3b3:62be:3584 with SMTP id
 adf61e73a8af0-3b362be393dmr2496390637.11.1779638251896; 
 Sun, 24 May 2026 08:57:31 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.193]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164fbb66bsm6973381b3a.45.2026.05.24.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 08:57:31 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: tomeu@tomeuvizoso.net
Cc: ogabbay@kernel.org, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/rocket: fix NULL dereference and integer overflow in
 rocket_job_push()
Date: Sun, 24 May 2026 15:57:16 +0000
Message-ID: <20260524155716.90955-1-meatuni001@gmail.com>
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

rocket_job_push() allocates a temporary array to hold all input and
output GEM object pointers:

    bos = kvmalloc_array(job->in_bo_count + job->out_bo_count,
                         sizeof(void *), GFP_KERNEL);
    memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
    memcpy(&bos[job->in_bo_count], job->out_bos, ...);

Two bugs exist:

1. Missing NULL check: if kvmalloc_array() fails, bos is NULL and
   the subsequent memcpy() dereferences it, causing a kernel NULL
   pointer dereference.

2. Integer overflow: in_bo_count and out_bo_count are both u32, set
   directly from userspace-supplied in_bo_handle_count and
   out_bo_handle_count with no prior validation. Their sum is computed
   in u32 arithmetic and can wrap to a smaller value, causing the
   allocation count passed to kvmalloc_array() to be smaller than
   intended. Subsequent uses still operate on the original counts when
   copying and locking objects, which may lead to out-of-bounds accesses
   on the temporary array.

Fix by using check_add_overflow() to detect count overflow before the
allocation, and adding a NULL check on the allocation result.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..71f64bf2bb7f 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -8,6 +8,7 @@
 #include <drm/drm_gem.h>
 #include <drm/rocket_accel.h>
 #include <linux/interrupt.h>
+#include <linux/overflow.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -188,14 +189,19 @@ static int rocket_job_push(struct rocket_job *job)
 	struct rocket_device *rdev = job->rdev;
 	struct drm_gem_object **bos;
 	struct ww_acquire_ctx acquire_ctx;
+	u32 bo_count;
 	int ret = 0;
 
-	bos = kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(void *),
-			     GFP_KERNEL);
+	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bo_count))
+		return -EINVAL;
+
+	bos = kvmalloc_array(bo_count, sizeof(*bos), GFP_KERNEL);
+	if (!bos)
+		return -ENOMEM;
 	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
 	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof(void *));
 
-	ret = drm_gem_lock_reservations(bos, job->in_bo_count + job->out_bo_count, &acquire_ctx);
+	ret = drm_gem_lock_reservations(bos, bo_count, &acquire_ctx);
 	if (ret)
 		goto err;
 
@@ -220,7 +226,7 @@ static int rocket_job_push(struct rocket_job *job)
 	rocket_attach_object_fences(job->out_bos, job->out_bo_count, job->inference_done_fence);
 
 err_unlock:
-	drm_gem_unlock_reservations(bos, job->in_bo_count + job->out_bo_count, &acquire_ctx);
+	drm_gem_unlock_reservations(bos, bo_count, &acquire_ctx);
 err:
 	kvfree(bos);
 
-- 
2.53.0

