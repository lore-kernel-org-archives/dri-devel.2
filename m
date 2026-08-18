Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B743FC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC26E10ED31;
	Wed, 19 Aug 2026 06:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1SVTt1l";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D77B10E9D4
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 04:15:22 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbedf318752so2871101a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787026522; x=1787631322; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TSUoNKxgsogZ06aAWwzyG9s03gy2yOBd81qFJRq6Ii0=;
 b=A1SVTt1lfP+7diuisHICdu1FucED6qpWYutZLPQXujmtgLCHFepPQwoHc+8LeiPQ2s
 LyJOihDAArBboZL/bbxbgkfBSyT71zQOFfq3yANP1fdM1EMKRGd5vBOTfGtM3G2P1dQy
 D3yhdhq45YZEnj//7ULFVNaIJgEwDbbKFvQTYOZdoWqxuGzWm0qi72gbboMJ/RKFIYj7
 LU+LMYJkvJFuFhLGLW/jkw8fX30NDesooyev0zs9ooB6okXCGM131KOaenIetC5DsFmD
 ycMY1+mFtLAtQkPdHDorO6z8r1ky4BJOZWwECRrSUdmrgKejScEE9Cs/XRHsDQ8Oc5Sc
 ErnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787026522; x=1787631322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TSUoNKxgsogZ06aAWwzyG9s03gy2yOBd81qFJRq6Ii0=;
 b=T9+JduFzV+1NLPFym90FSbu8/kaQuGIrty63MeKiLHjwRG5sTDv2UzEaLaaFwbjqLy
 Htz+hjwtfzBiTGslR+u+xpIouztjU0siW6xStfoX4G1LvTMYrMtxUln34ku5UgLqO/jG
 KEOJXcXZfmRYMCDev/b81dMB7aIELzz2EDTa2u8aZktbngyNFLYhR74bXkooOCxMejVd
 x/KmtYgSmKfmOMHrFXhVcEOfHlj+C9rkaAXGJz0KNCGEN5bnE5b6+MPU1quHl08vQzjQ
 TTqy+shJJINXCL26krezArxBBnmJhflBRNv2/QeFsuhFryqqWU0EEiOEAS8Zc2gMYKk1
 IGpA==
X-Gm-Message-State: AOJu0Yx4kl9q2s+Lk9DxkHVvzSJSzaRlps0+dnDS8yFmIy8wvqkPR932
 ucGNQHDPGW6Z0/y+witowFH8wFJkAessmeGCGCRxGsLfjPem+BR6x+E=
X-Gm-Gg: AR+sD12tbx7GD9bbVC99X9pr3KAseWUEbP2nkl8blKZOUPn9mBI7IuAxvmo96gBOWaC
 ZIdUQoyulXVa5gbd/cnZSwn/1TTMBvtROp1inZY1UWtlFRW8CLLtym+VmCyPEfehQZeeDx2QMxf
 pi8cuhTs36NQJ3y5VjFJhOSymfK2vFN5hkAnzZJ05K1bvuUXoYN3IJ19cdcNAhclauFK+Mi+PRF
 OEZIJJTk1bye16zpXO+Q8ZyeHCrTAY9tPbxlY3aB92Dd4Yyz34SDRJ3an+7tUKjLY6xPhBVMZs6
 TVAaMVkYtwlEqmhfKH8lIeAluiRR63FDL5bTsk1b13Byyy4tie7YatyyEL/HZxQZNsFJy/51uTE
 +NyHO0W+i7rXPDo91jFVlh5z/QygIYZNFNV226dEyWnM0EsjFP9cm3NF3R2bF6YopFqMFDuX/nE
 17bryMqgxjy2bl/m4RL25ZxFItUcVmeo8yzMtfBXzVPcMRqg0h6gLDxyoBKDL7XRFPU+W97j8=
X-Received: by 2002:a17:90b:3c02:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-3933b8938f9mr32518274a91.11.1787026521518; 
 Mon, 17 Aug 2026 21:15:21 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531e84244sm7206458a91.6.2026.08.17.21.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 21:15:20 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, triet.hoang.dev@gmail.com,
 markus.elfring@web.de
Subject: [PATCH v5 2/2] drm/rocket: Keep scheduler allocation in
 rocket_file_priv
Date: Tue, 18 Aug 2026 11:15:05 +0700
Message-ID: <20260818041505.1579320-2-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
 <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Keep the scheduler allocation in rocket_file_priv
and free it unconditionally in rocket_job_close().

Suggested-by: Igor Paunovic <royalnet026@gmail.com>
Link: https://lore.kernel.org/all/20260817093009.22359-1-royalnet026@gmail.com/
Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changses in v5:
- Free rocket_priv->scheds instead of entity->sched_list in rocket_job_close().
---
 drivers/accel/rocket/rocket_drv.h | 1 +
 drivers/accel/rocket/rocket_job.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 2c673bb99ccc..9421e48ec5d8 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -23,6 +23,7 @@ struct rocket_file_priv {
 	struct drm_mm mm;
 	struct mutex mm_lock;
 
+	struct drm_gpu_scheduler **scheds;
 	struct drm_sched_entity sched_entity;
 };
 
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 15e93c355c38..50b6e0e06ed8 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -519,6 +519,8 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
 				    rdev->num_cores, NULL);
 	if (WARN_ON(ret))
 		kfree(scheds);
+	else
+		rocket_priv->scheds = scheds;
 
 	return ret;
 }
@@ -527,7 +529,7 @@ void rocket_job_close(struct rocket_file_priv *rocket_priv)
 {
 	struct drm_sched_entity *entity = &rocket_priv->sched_entity;
 
-	kfree(entity->sched_list);
+	kfree(rocket_priv->scheds);
 	drm_sched_entity_destroy(entity);
 }
 
-- 
2.53.0

