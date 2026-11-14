Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2E606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgD8SycO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3765D10F049;
	Sat, 14 Nov 2026 16:25:27 +0000 (UTC)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1585810E884
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 14:19:17 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-168de2167deso25072c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794665956; x=1795270756; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QjbH7+OnTujQtkedXacpeWPzVbsofxl7bIa9QcXu1+I=;
 b=hgD8SycOOpdejWYRr4y/f3tVnwBX5c52tOG6HAwp1QPdOdgpN3Cts3hoqJyu3RbFlU
 QKwgsGgYPefilYYjp3xJYSkiLicpM8044D/50Q4JfmHp+42o98BhFdttSaX31DCdycrV
 XZ6Ei/+BheWAfUZjStGZK4fZHnN0DI+CJnrg4wNVcon8NPsAPTw8mZLjl2E7UKw6ADK8
 jOmpiVZpLz1jBWGJ/6mj0v81j/VonHEdHc7zjexJueQdop7RvXxmIBsZ6xajQsd1Fdmi
 urAhJMi2Ykj50ysNI9BwXT4ZLZXnHfmx1KbM3ee1OozACWkSWURCcVhf1h5npwXRqKhA
 LF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794665956; x=1795270756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QjbH7+OnTujQtkedXacpeWPzVbsofxl7bIa9QcXu1+I=;
 b=nVN9fQEh/puowWjX+0YnsZMPE3K9DFCO073u0MpA4EGRtH7TAUWUSDzYkB5BEY+BDu
 upeXZ50RYoXAhDYjIblNnsaWImjkDcRSZcR0a83xzLp6eZvOtdUuyUVkI1HVcjLaQjhg
 zSfW8MRafL26fHD8+9FirRnjA8ACCLrE1zke8g48wqImTSMMW4m3S0TALznhqRzLYhHl
 fm0r8mA9f+7vuuVs8Aw6IuXO+7LS5nE+r6b1ZigTkk01DBkWpDbE+sHw4w2IPtmV8tpQ
 vQ+8CT9Y6pLGILD2jEeaztX/RZI7AVs3OgDcL4O7TkET6LWqKS3zG0nk1BN/ttpPXO+m
 ypeg==
X-Forwarded-Encrypted: i=1;
 AL+hErEsoIqx/ZvGmg3vwvQgfMkQ2BL8wldsItj5c4IJoQeW7g3IRmBfxHhyFysM+clXYGI3/2rKf5LzHuw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+3gemXttsrLe/DgZnTaWIVvnyWVHBEs9Lw+IMvBryfGmycm3/z
 UEnjyciRCwWV3UBxZr1b07jVSYN5wewPgVaZYCo7Gk2cbsH4Kkq3S/LY
X-Gm-Gg: AYBFou1wOtuk34Sculn9+VkwC6Y6EOjMRQu2e6jYLpsjTqljsBh7S1EL4EtTdUl7Wf1
 gBQXjehYTllrte+0m7I76E+/ObRyu94rHUTOd31QR//yE6cdmIGWTlupAMnsxJSSxx4pI5QRI6z
 TFu9gZThy+gVrF/ZSBEeSJL7xbGHNRr6vo+viiW7XWKlhJ2mXYtv185BWoJg63DWEGaBLtaurTA
 2J3Cn0lm+bR4GrZhpWTQ9agmAnxB4Q5k7Gth4MivofB7UzD/+V785iuKqvYHrkguAdQlBnquhaE
 7T4CT/g4JE59QHWu41EWDGNQr17ub5kjb5Jb2yrsfyht36u6bdpJGgJ66G5e+n3azjrdmyzvaj/
 Vjb+1UKw5kPRcsBg88mx4apvwT2FkwWhgNGcs21y4H0HgXqE6rUn365ppEca+Auu3F6iHPycj2r
 UX7y6KI5SZ62vLh13ciBFbqZwKCCiauD3ZJuyCh0IoFiYsuaa/SZu43Dv+SJpw5cFRNK/qKcunQ
 A91T26z3yBXRodvbg4QM7J5IlSq0U88obOsEUU1thGq+SwW1ngKebnZ5MBbItTi6xIYQ6ah3SvS
 nF99UUvau3fIUzyzlgiErV+me4osc9Wb9MYUJ426SGPgbzMITgf/ANg5Sp7azvGj7FRpFzErDpt
 wszY=
X-Received: by 2002:a05:701b:4508:20b0:147:d430:7322 with SMTP id
 a92af1059eb24-1b5030d2df3mr8446285c88.1.1794665956061; 
 Sat, 14 Nov 2026 06:19:16 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b2519sm14745032c88.13.2026.11.14.06.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 06:19:15 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Julius Bairaktaris <julius@bairaktaris.de>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v3 3/3] drm/msm: Put the VM_BIND queue last when freeing a
 VM_BIND job
Date: Sat, 14 Nov 2026 23:18:51 +0900
Message-ID: <20261114141851.134290-4-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114141851.134290-1-arpe1618@gmail.com>
References: <20261114141851.134290-1-arpe1618@gmail.com>
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

vm_bind_job_free() puts the job's submitqueue and then wakes up
vm->prealloc_throttle.wait. The job does not hold a reference to the
VM of its own: the VM is kept alive by the context, which the queue
holds a reference to. When the job holds the last reference to the
queue, as it can once the file has been closed, for example when a
killed job is freed, the put can drop the last reference to the VM,
and the wakeup then uses a VM that msm_gem_vm_free() has released.

Since commit 01c8d1f385f7 ("drm/msm: RCU-free the scheduler-containing
ring and VM objects"), msm_gem_vm_free() frees the VM with kfree_rcu(),
but vm_bind_job_free() is not in an RCU read-side critical section, so
a grace period can still end before the wakeup, e.g. if the task is
preempted in between. Before that commit, the VM was freed right away.

Put the queue only after the last use of the VM.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: b74fae5492d1 ("drm/msm: Add VM_BIND throttling")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index ce9d97582df5..07f427c4afad 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -810,7 +810,6 @@ vm_bind_job_free(struct msm_vm_bind_job *job)
 	job_foreach_bo (obj, job)
 		drm_gem_object_put(obj);
 
-	msm_submitqueue_put(job->queue);
 	dma_fence_put(job->fence);
 
 	/* In error paths, we could have unexecuted ops: */
@@ -823,6 +822,12 @@ vm_bind_job_free(struct msm_vm_bind_job *job)
 
 	wake_up(&vm->prealloc_throttle.wait);
 
+	/*
+	 * The queue may hold the last reference to the context, and so to the
+	 * VM, so put it only once we are done with the VM.
+	 */
+	msm_submitqueue_put(job->queue);
+
 	kfree(job);
 }
 
-- 
2.43.0

