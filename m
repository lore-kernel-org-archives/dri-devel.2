Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0F9CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FC910EAA4;
	Sun,  4 Oct 2026 16:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="G85bxKbu";
	dkim-atps=neutral
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D8D210EAA7
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:47:58 +0000 (UTC)
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-38fd9408220so334671a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1791132478; x=1791737278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dnRFmiKoVvl5Z5wqJW+Iv8p1Oadmf46rxi2VSxWNJRE=;
 b=G85bxKbuMoltj/scmS7mHcAyW2xCAITPY3aDR6DDCrwAXBoE/pOfjzmQgnJRV+MIdD
 LOOATZXKFNdBGvzsdW4Xb8phk1xW79tM/CPnSvoMHLaESVPkXIU/wv3l8uk7vknQXsQJ
 sLKRgi9vqmVJcBT37RQPugxTkRoWXfP4rQkb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791132478; x=1791737278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dnRFmiKoVvl5Z5wqJW+Iv8p1Oadmf46rxi2VSxWNJRE=;
 b=MmNjIQHRAlq8MXrUrmPAAvi/hOMuutHTXzZuXpcfV/62FoxWRex9kScTmOAJ41naYL
 raw6DWfRtud41JwZH/Ldr9S/Yx5wYXZlqTv3vPsrzi+Yh1zGgOPR/creDxMYG/s/SXlU
 pGNioqxrionx7+ETvyMZl3bz87NEohsV8XRmY2tNhwioPNUgLcLdd/W1yMLNLu+XpPEc
 nej575S843Fq5Vy8LV2O/k1HPjbhM9v78iiQl1CJT9nhpGXPEBAWbAhgAiEj2OENkwJK
 fkpZogQCvZOYVMIy1OLo65bO9+I3yxGq5CcoYzuym5HJ6N7vUCmHM26aBK+wHHYEUqyS
 SNxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrlZ9dH8W1SzaKiskjs7uezOFl1nZYxNhbBbOOATIIEQiuahce1vcA3meExxd237g5SiuOBkBhHGk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJPDoHdqX6AhgD2J4koPKd5zOgixppiv2PtYL62FhteaYlJOj27
 XXitQyuZs7dRu7IFi9EVgIEx+C1FTvEg8iJADz0TZEElly0X/TaZeNimwyOZ+BKJSdY=
X-Gm-Gg: AYBFou3SEDK2X/1amHaED1ghXnrWQNv7NZok8dCNzxO5YJPOYO85jCpm+UMgwTpy90G
 wOthOTvn8rKgGWaMYWrBImzlnTnoaj3aFF4xdFtnZOlhj1KPw6W7Jw8N3Rz4utkj/vH1gFX9rVr
 JDEYW7h28v0amiS2iVOO/yi+b7MPBr4kFuXHBCvVxM/ICYVRr2zcocARSVFE2KII8H5i4e+k+jU
 0PZk/FpXs4Gdiu46KPdpG8qxr1tLVSPomtsXMpI+PJ2R/lBQA5KhNl2qCYXG1nONPIe7nA8fHZo
 F2cSPPgNWTQDQ/7lahWrO9Gooi6YbVvWUl+M34oHoJZ74D0ntnwLbEoOkcNfNqXQWMmjvCTd03s
 6YqmQmABE8E16Hhg6jdfKTMjsabt/O7NE370WmY7PBsV1wOfKoecJvcnTMuf0sjvr+6g/Ik7u7i
 NVHajqo5/rD2JT8h/mKnb996gHSk2B1T1+mge8FSUVS2DxBTt2wKF+oHMIUBRTd6QBnOuyFr90
X-Received: by 2002:a17:90b:134c:b0:39e:6a7e:ee1b with SMTP id
 98e67ed59e1d1-3a6ce7db233mr5437577a91.39.1791132477646; 
 Sun, 04 Oct 2026 09:47:57 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6dd0cd76bsm6500454a91.2.2026.10.04.09.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:47:56 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sidong Yang <sidong.yang@furiosa.ai>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 1/3] accel/rocket: Don't tear down the scheduler when
 drm_sched_init() fails
Date: Mon,  5 Oct 2026 01:47:25 +0900
Message-ID: <20261004164727.466164-2-sidong.yang@furiosa.ai>
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

drm_sched_init() cleans up after itself when it fails, but
rocket_job_init() then calls drm_sched_fini() on the same scheduler.
That wakes a wait queue that was never initialised, dereferencing a
NULL pointer, and can destroy the submit workqueue a second time.

Only destroy the reset workqueue on this path.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260912114524.7A6131F00893@smtp.kernel.org/
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 drivers/accel/rocket/rocket_job.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index f40435505818..319365ad7976 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -494,8 +494,6 @@ int rocket_job_init(struct rocket_core *core)
 	return 0;
 
 err_sched:
-	drm_sched_fini(&core->sched);
-
 	destroy_workqueue(core->reset.wq);
 	return ret;
 }
-- 
2.53.0

