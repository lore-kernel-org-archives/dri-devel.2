Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8008606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FbnKmlOP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DD610FC34;
	Thu, 19 Nov 2026 07:48:52 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 594EF10E664
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:35:58 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-380b40319bdso2593754eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795055758; x=1795660558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zKeouwKUhSCp57RcBwxtpS4g2a3Z83++Bwx1acJHrfU=;
 b=FbnKmlOPkVwGEqNMDxg3mPSpoWsuvrE+V+dft95dK8mF+vefSK/ZfYR5tKVRJ66Kfv
 8AEl2cGBIKPqy4MGorYruCn6lvhfbHYKzfV18uhYt4jigt6/qyd1uXMeS/AQAQisLnda
 hzws6mUVZG5ICLP240un2XydQoKZbd4zUcBSFQTntU5d8D+M48ceyw9Ok09rG5jWv4LX
 8pJtTdpSr7OgRIAdf1+euGIEsqOo/5YULgXC4YSv9ltj0XrB1UF+iJfVrpC7L23jIZD3
 xLB9/bRRFV11t6HHPCPdKnFejuJUAdv2PzftUuTJ7MPIkwXyVtylTor6HwZNvF2xv1IO
 w4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795055758; x=1795660558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zKeouwKUhSCp57RcBwxtpS4g2a3Z83++Bwx1acJHrfU=;
 b=o4G4II95pWOHp/gz63puG+vR++FCYnmWK3snsJtxmv1UKCR6+Twre8/7vuxtQr73cy
 ha/IB2BGIboWtBeo197a3VSlejzUTiCO9inQ8YhXQVed5MyBgRvTI9GewR4L7vPZSXpk
 75vA1vHH/kbuVowpt3zyy8bMsIZSQN0lr9KJV0icTwT9h+HS95slTUtxuwC2uyFVa09G
 w7036MzvmNbADlMJY5qNlun2Vls1yyoHjI0EPg2gB2mHtPCcONHBflIUCh/LY5KO+5hT
 4ImkB4sF5Ihj23eNHwmP8gDW3i9pg5Pc+yTjtclH440g0UyAobO7V+prVmO9wOHJwwYl
 7UmA==
X-Gm-Message-State: APuU4Z93SMHYReOl0vghyzyjV1jUN3U8hzGWjz7dPjurHceemhSjUulD
 5AtDl741bF0UAoiexhmQvvCxHbB0LP8sA2Vmsy+aidOfWQrOHOfWO8dJ
X-Gm-Gg: AZFdTZdan/0pV8C21BrRNadbikD4cqkfXeJMis0IWFEWqMtXVeM8nCg+rsEI7hO4S7T
 3EepHUrOKnhEWBKwVE13JbJJFDsAQkUyzO60uKYj7FgXiVGmgFUV9h6ErsueHdTvQ6lI2vCv1KH
 qCQk1Z0yHY9nTENCIrof91wsXMmU8oL8whC6ZAs/bv3gUwCGz/CarxcRwqEQZKn6i8DovWhxylg
 ggaMUygdUhlt1nH1t7Dy2q+d2bfb+F+YgOucAlglnidRly6ggAqqf+1wPHRP5RSOb/Tl/TDSPZ2
 WyrF/9Dt1VvibpvZFfJ8bydiKrFR/21O/TAQmVFYy+mVxEDZt/XVMOFy+Ncf2xpAhHCQII4H6u8
 eNqu2/dhPP517HTqHw7eCSDqPJWbS0mKJTUTlv/NfDHetWdP9kIcFRGt9lsTWaZaBNEfnHYWdOq
 1u+WMmb1zbbAgUPk3cHwBPcgu0jgXjzGxG5RbGrVKb706oOcheyoOlgQqmJK5bsYoQ0ElGmX0A/
 TGYOyyrantZR6vS39lKyJxp/QlWLmHMWgwrnAFVIl6VIMhpf/wPWjApUyDo76FufIaaH8TcveDl
 MEnFbCZO7xF2XEk1uzV/jgyC63MmULSBgho/1cksCmWx+auwoYmxpgxXIyMlbmdfgfWI4tH1n2V
 dKPHWVulFK6a/VZPgyTDfKEAoBEuTVSDb0Pu22d8a9ryx046m8GjH0IaZfoHh9A==
X-Received: by 2002:a05:7301:5504:b0:383:6eb6:5730 with SMTP id
 5a478bee46e88-3836eb67772mr2251726eec.32.1795055757524; 
 Wed, 18 Nov 2026 18:35:57 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:38a8:0:f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a73e0aa6sm11983567eec.19.2026.11.18.18.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 18:35:57 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com
Cc: dri-devel@lists.freedesktop.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/exynos: queue the IPP cleanup work before waking the
 caller
Date: Thu, 19 Nov 2026 10:35:50 +0800
Message-Id: <20261119023550.1495565-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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

exynos_drm_ipp_task_done() marks the task done, wakes the waiters and only
then decides whether the task has to be released by the cleanup work.  A
commit ioctl that waits for the task is woken by that wake_up() and frees
the task itself as soon as it sees the DONE flag, so the task->flags read
that follows touches memory that may already be gone.

Read the flag while the task is still guaranteed to be alive, together
with the other task state under ipp->lock, and queue the cleanup work
before the wakeup.  A task that is handed to the work is then always
queued while it still exists.

Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64 with aarch64-linux-gnu-gcc 11.4
and CONFIG_DRM_EXYNOS=m with the IPP drivers.  The affected hardware was not
available, so the teardown path was not exercised and no fault or
race injection was run.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.
---
 drivers/gpu/drm/exynos/exynos_drm_ipp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index 43bc4f63bb84..49ae8ce9b95a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -764,6 +764,7 @@ void exynos_drm_ipp_task_done(struct exynos_drm_ipp_task *task, int ret)
 {
 	struct exynos_drm_ipp *ipp = task->ipp;
 	unsigned long flags;
+	bool async;
 
 	DRM_DEV_DEBUG_DRIVER(task->dev, "ipp: %d, task %p done: %d\n",
 			     ipp->id, task, ret);
@@ -773,15 +774,22 @@ void exynos_drm_ipp_task_done(struct exynos_drm_ipp_task *task, int ret)
 		ipp->task = NULL;
 	task->flags |= DRM_EXYNOS_IPP_TASK_DONE;
 	task->ret = ret;
+	async = task->flags & DRM_EXYNOS_IPP_TASK_ASYNC;
 	spin_unlock_irqrestore(&ipp->lock, flags);
 
 	exynos_drm_ipp_next_task(ipp);
-	wake_up(&ipp->done_wq);
 
-	if (task->flags & DRM_EXYNOS_IPP_TASK_ASYNC) {
+	/*
+	 * Hand the task over to the cleanup work before a synchronous caller
+	 * is woken up: once wake_up() returns, that caller may have released
+	 * the task already.
+	 */
+	if (async) {
 		INIT_WORK(&task->cleanup_work, exynos_drm_ipp_cleanup_work);
 		schedule_work(&task->cleanup_work);
 	}
+
+	wake_up(&ipp->done_wq);
 }
 
 static void exynos_drm_ipp_next_task(struct exynos_drm_ipp *ipp)
-- 
2.34.1

