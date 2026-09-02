Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E14C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370B710F3C9;
	Thu,  3 Sep 2026 07:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AHTobRAD";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44FE10E32A
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 01:27:22 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so480820a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 18:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788312442; x=1788917242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wt+LQiGu1u46A6j6YSEB/1Vma9hmj220lRwz/yCk9to=;
 b=AHTobRADICjK8MGFFf3y0ueDIiqwkU+UCuMoxZX2X+RU/vnLP+zfbswsQm2gvGH+bT
 RfE7b+YGei+yCVNeoegDyM/QX73j/OcxVMSKfI0LyjCwONuxNgQB+eAeln7oWWsDjk1Q
 mS6tblnOgU0BoPF8RPHCB4uut56bF+YFwiV9Cv6jMkn2g69ZyAa6PNGR8vOJVFZK6z77
 5bgRSpdN/pq9wqg9uXz2Vo1axa8Gy2LMyc+WlR73C/vYEb0RLghGfvUTF+HTAnrr8bHk
 xMz6SHZ/yBxOx/mdExZeoetKqrjMpEihgbXW6XOYfJ+5zPFTifXIUpiox9DV81Gre2ee
 GeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788312442; x=1788917242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wt+LQiGu1u46A6j6YSEB/1Vma9hmj220lRwz/yCk9to=;
 b=kfrwgmnwhxF3qOMC3h0LIEe+UfOs5MwUhPgy/AaxhUdCrcn5ZysjBsllaQv8dVHc7+
 tzPt7OErU+cQ3aagjmiro2FvIt6yfTBxYMlktBiDUDtMKbnAoM2AdhxRTefJyfkieFrR
 IY1UcNX+MERINdTJCe/1/u0JPLKiG1J7rAumJ/oAI8uiWtFJkg4FhN81xQ+wyPRd/3Je
 D59P8RwBvS3JDH8pTkgUpPLlpx3kcDGEOgII9D2HHjR4ZOQ6ikPBJfVl0PHhg4Qj/Hzw
 u+UTO34BS/Vu3UwQpwD43+ecEdsLSNTD44tnDGopuR6yuFPykHkYwQ/5Cfxxd0lxhHnm
 2Tog==
X-Gm-Message-State: AFuF++lLcptBcQgHKgdlP1AeBJ/yifbJKeJtCc78Dph2seuakYd8iuu3
 tfqGFemU7v8eCwqwliddtchywF565hSxtxgAvxOD1bAZWczPH2Sba8Y=
X-Gm-Gg: AYBFou2GNWtUJ9xudXx6xqxMwIF/0RwbFRx3ZDGGWQewvN49OFZ9RwD9rjDOegX1DDB
 vibVvYWO+FpsuwnC+rC5O2vzKXj7vx5IJB50tXLWOxNWB72yJB/TOFF6EOl6RPCthZopm3QJk45
 yoX6R0NDlpCY3Kq+tRZVQgMwKJbr1BfY6yBeA6iL8lXkaK0hWT/E1ONXIf/1n62nW0iO1mAnGCD
 ivwOkgpHvAjI2TImkfmJhHenwXA4A6k5y6UMwZQMAXottIQyuJXxPOdTLfqx3lKreSlW7czYEJ6
 uTOR74bJwRuj5Jtaif/t90vy+8h+3tyavpI6hlA/MiMYc+jY5RePQavUaIefh6M4ZP6MfocleOF
 qHxSKz0+TvtAo6em6Ykn2W2MdqClnUoTjRigPi8lWa1qd8gS0M5VUC9Rze3MGvBTMoTwp1FeXvz
 OkastAf4dHHOMvpTn1lJD/3f2MAoJ5wYQ4ae+iGJ7v5c6gYmAatWNDjPe+mFi1OwPgeTnCxiPni
 FGN7EMzXahrrFwUMBkuJKmzQzz/
X-Received: by 2002:a17:90b:288a:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-39aee0848bbmr1717405a91.14.1788312442070; 
 Tue, 01 Sep 2026 18:27:22 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm8719236a91.15.2026.09.01.18.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 18:27:21 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: RCU-free the scheduler-containing nouveau_sched
Date: Wed,  2 Sep 2026 10:27:16 +0900
Message-ID: <20260902012717.880724-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

struct nouveau_sched embeds a struct drm_gpu_scheduler (base).
nouveau_sched_destroy() calls nouveau_sched_fini() (which does
drm_sched_fini(&sched->base)) and then frees the object with plain
kfree(sched).

drm_sched_fence_get_timeline_name() returns fence->sched->name, and the
scheduler fence keeps a .release callback so it is not ops-detached on
signalling.  A finished fence exported to userspace via drm_syncobj /
sync_file therefore keeps pointing at &sched->base after nouveau_sched_destroy(),
and a later get_timeline_name() -- reachable unprivileged through
SYNC_IOC_FILE_INFO -- dereferences freed memory (KASAN slab-use-after-free
read).

Per the dma-fence lifetime contract the exporter must keep the data backing a
signalled fence alive for an RCU grace period.  Free the scheduler-containing
object with kfree_rcu() instead of kfree().

Fixes: 5f03a507b29e ("drm/nouveau: implement 1:1 scheduler - entity relationship")
Cc: stable@vger.kernel.org
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index 2cbae003d6de..48dbb851df2f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -516,7 +516,7 @@ nouveau_sched_destroy(struct nouveau_sched **psched)
 	struct nouveau_sched *sched = *psched;
 
 	nouveau_sched_fini(sched);
-	kfree(sched);
+	kfree_rcu(sched, rcu);
 
 	*psched = NULL;
 }
diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.h b/drivers/gpu/drm/nouveau/nouveau_sched.h
index 20cd1da8db73..51ce8dcf6285 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.h
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.h
@@ -98,6 +98,7 @@ void nouveau_job_free(struct nouveau_job *job);
 
 struct nouveau_sched {
 	struct drm_gpu_scheduler base;
+	struct rcu_head rcu;
 	struct drm_sched_entity entity;
 	struct workqueue_struct *wq;
 	struct mutex mutex;
