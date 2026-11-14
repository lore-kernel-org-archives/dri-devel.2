Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D4606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnZ9MZC/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304F310F03E;
	Sat, 14 Nov 2026 16:25:18 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2C510E125
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:26:48 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-33c10faf6easo223779eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794637607; x=1795242407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/2KQ4epDEV2h9oQK2IfA2VbZzNQVtXN1l25yFvOTJmg=;
 b=HnZ9MZC/6Bjw26QOwfX0gyCR2RA3NzCqMfra2wW60xVs6hE3nUCqJpUjjw5m5LIZIF
 jB6ZgzHxg7yKmGUl1V1VdMRisdAvxBNuMxKD09op6Fk7M7JERDmTroD8myNoQU2R5LH3
 ZT5MMZ9UEivLkz/qcMWqHW5Lm7qmuHclE7hzDD7+clWvSapdMgxMSWMJ/CnWaDV/+zCb
 aVvmI7C+8ZKAUkX0LPUr8RbuUbYgJw1c9Tcv0TfAO6scuXQcHE7dhe/FUjMegSpw34qM
 9Iz9Sg8/rb8YG9Civ73y2e7Cwxic0Sl+S3f01FTn8zYp3uvIx+zZicDjaiuTZzx0dRqL
 9kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794637607; x=1795242407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/2KQ4epDEV2h9oQK2IfA2VbZzNQVtXN1l25yFvOTJmg=;
 b=JOUPMhqe3+VIbTzl2nk1vy2uvwxi1E2QVjJWqf3Mm1duRY1eNO93HGA+IvoE5TzQKm
 8+vALIvjWZSvCDC3T0616UaTUzZq9FUtKAJ3YCp9CAH7BIWBJNA7VoRu92JvMffji0ep
 3FfPalge5AP7ZBoSrh6u9AyoKHRFt94E/izEJEPl3A1yCiFEnAWkZIFy9YM4QUNtgY2v
 5bDc8bjrkbQzkSPEM8GONW88AzB6PAKwDGIfUF/CrYP1MpTH2YFtIYVWX4ZPzusykRg0
 qcyKeG9YV9JHCgsc45pmyTR2GJAEGLGJVGFvDQQJUbE2tiDq8qPGBPBwlplEKhTiW/c9
 XU/w==
X-Forwarded-Encrypted: i=1;
 AL+hErF/FkCrd80ixXkjam/3sf832m7WAroMkOYb2KyuDAWuC8QxiAdCN/tBMCGsY/Vfi+Rd5yp0LKO3nfo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KpuT3Sm3Z8VyuoEZVAyqhsiZSxhD6yxVWtp+FWpnDIcBujCiG
 uVGkK3IKoV4yAysUQP7nV5VttWC5FFCs3A0ADS4tZshHb/BSDHPVNUJ0
X-Gm-Gg: AYBFou1gtECKX356bOTO8WNdQfmO+rRsTVq6HYqvIFHN6S/9B6+ijw57w0+k3vGJEUu
 zukbtGCSOYabi2mVAKDPu1LZ11E03TqXOym/Mcphy5/76GuEf3OWmD7z769Zkx8keE7rGZ3Bidy
 fE/2TagPukON4fWZ++42ab91Ygs9doLaR/JV41pvH6JVJYoEPSnuCx6sxPwKJo6E2Bdm8uZpgC7
 REs1ypvznA9G0DaBOfCsTY8/GpvvmFN83mWrBr5bL08tIhaYE/qQKu51H8nmr9NlLxtyDrR1O/f
 jkqZKC3NOuoMvbin8/NzkDKOYXoWZgEa6IdH5aQtfSbWzbAMm80a46d9AGIckeNyB81lE/ezqly
 tTrpbaL/zW2Ywc17DXsawTat2sJkjS+ikIMY45W6GkGzeq+wXskANeru7YW4jfI7P9GW2ZtnW5E
 1Vb5oz8U9ySY18vMpbZ+PG8RntRqyC1yv6vVedJirC9bwQEbFeatDNrBa0uhMJCoQ/C4W4GKoPu
 iGVgWZIOs9Lo3gtI11eJQaa6QQ0cVTwTo3nCHWLhY0J4fCfKKpSQ719GS65KjIDKg6fJo2sG7yo
 Ge1vwzhrslaKjpyGeaZUabKi/dDC8uKShTjUhwFGO+pFgLvzFJZQxtow7wTRepCzlMPR77rx53e
 RT84=
X-Received: by 2002:a05:693c:8204:b0:372:c0ee:875b with SMTP id
 5a478bee46e88-3796057b529mr6474936eec.0.1794637607266; 
 Fri, 13 Nov 2026 22:26:47 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955ffcbc9sm19762863eec.18.2026.11.13.22.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 22:26:45 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/2] drm/panfrost: Hold a reference to the MMU context of a job
Date: Sat, 14 Nov 2026 15:26:36 +0900
Message-ID: <20261114062637.2447-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A job stores the MMU context of its file in job->mmu without taking a
reference to it. Once the file is closed, the context is only kept
alive by the BO mappings that still reference it, and a job may be
submitted with no BOs at all.

When the file is closed while such a job is still running,
panfrost_jm_close() only hard-stops the job without waiting for it, and
panfrost_postclose() then drops the file's reference to the context,
which frees it unless BO mappings of other jobs still hold it. The job
interrupt handling that follows calls panfrost_mmu_as_put() on the
freed job->mmu, and panfrost_core_dump() also reads job->mmu if the job
times out.

Take a reference to the MMU context when the job is created and drop
it when the job is cleaned up.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 6e516faf0431 ("drm/panfrost: Job should reference MMU not file_priv")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
1/2 and 2/2 fix separate lifetime problems and do not depend on each
other.

 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 7c348a0bf1ee..afda794e2aeb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -331,7 +331,7 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 	job->jc = args->jc;
 	job->requirements = args->requirements;
 	job->flush_id = panfrost_gpu_get_latest_flush_id(pfdev);
-	job->mmu = file_priv->mmu;
+	job->mmu = panfrost_mmu_ctx_get(file_priv->mmu);
 	job->ctx = panfrost_jm_ctx_get(jm_ctx);
 	job->engine_usage = &file_priv->engine_usage;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 4ddf4b722ddf..7022b1b2e020 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -377,6 +377,7 @@ static void panfrost_job_cleanup(struct kref *ref)
 		kvfree(job->bos);
 	}
 
+	panfrost_mmu_ctx_put(job->mmu);
 	panfrost_jm_ctx_put(job->ctx);
 	kfree(job);
 }

base-commit: d48ea86919434695da12d280dccab72b094397e1
-- 
2.43.0

