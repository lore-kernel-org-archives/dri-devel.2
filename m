Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCF606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pU3Mwfap
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6094510F03A;
	Sat, 14 Nov 2026 16:25:14 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAB010E16F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:20:33 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-37123334649so194370eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 00:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794644433; x=1795249233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hp5f15bouPR2UtUnvKHkGzva3ieusdxkwfWzQA5rd1U=;
 b=pU3MwfapjBB9IC1GnHreMW+UXNEETPrHfoC/tcFP6cbE385pQ15CkkKhXKKx3VOQNR
 yqcnFr2J/RolKWdbjB7OML6A9o6ACDHc3zCXCIk11DJi/0mmXPkdQh1cgk/7mplqq/h5
 ACebsgf5vVg+y7rglsEpRH/srPYYGQAtEV4fCrsbgG4GZohUsAGslaWG7HT1rWqZh0Bb
 pK/z/wNQJ1njVYxNLsLvLvsK9xgZBJIzTC8qLNrQVcy3xCEtCovqbQXFeQc0HIVBsaTY
 UqOqeo4v3Sg340o+U6nDvM3kszwRpci6mK6myVFC+PvqHEws7eCrYPDlwwgOkh0KoU4/
 D+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794644433; x=1795249233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hp5f15bouPR2UtUnvKHkGzva3ieusdxkwfWzQA5rd1U=;
 b=WPEylprO4roXzOfFq1o5Pi//T9fkQ1VHB9e9+c7dm8hmk4mEJOXRhIf3TouriAIgkv
 BmX9VkCPEu3Hn8anPeeHqbX2BntT13fRE2lFZlC3yQYr2S/Kjev0aXQCrU8dE7a0XlDB
 M5GYK0i3eATytCXEZaaxS4A16fmxMGYycGcwMO90bOQzUfG7/rDnR5wfk07m7byLS0/d
 Oe4hpWt/ooyC2MK0ZXg2xzfmsx4bTe/6W9vcY8w2JU1NMEAI0tfZtr7spuVkuBjuxXq5
 /rqdP9W8PxXEp/Cu3hWgHYOi3M3sS8N7aK/CzbssG3WagYa9xAFz/hNhRUDKadOnKBRF
 UMxw==
X-Forwarded-Encrypted: i=1;
 AL+hErEOTdIe+37QlX/4TR8hMSMXaDsFhYNUjwEvxNPhll/tOmOBuUROIwbACGz107qMvi0P4iQTPHfr66I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Gj/9PTYT4wBIrnhx1ADQfr3YeUNaX/7yZ+VYCtcFQRLG7nEVe
 rRpfEzgjEIfbxdq+7EsJeDQmKX2WfaaujOtXqU0+CgMonmkvuMSkX5d/
X-Gm-Gg: AYBFou0qg8I97UuppH2xW8ECMFInZZSfoBBdqgSUGU5QB7C9OCRCuVbXCEK2iUHl+Ey
 3+UNo3Ih4eq7YqI8z7Z+jFkr7akPNjY1mDHHDiS/MnWoznAyJG2A055/P+qNuLV2s9n1sQov/Y7
 maJxjLgoqGn41rWrVOhCH2Ml8XzC10UBDdw46i0iEDv6p5RSHGVyD0eAItP8p0JHLuFZp7S69lb
 2BITtaDuyK76PWpzZ158xdqqWMuxXB7ebJFb+EXhvQYGuFlcMkc2xg0ndXJNmYErMq7WwLv25AK
 MJ/BBKxKBLv1XqvIDNYGsELC/miBJ5vY919tPgzpSLkMO0FuS+uLpYYEvWwCSdqUq5wNrQc0fp2
 Q+QmVhq404QQzN40nGeymVq0hkaLF+MHkZSbDjIQ5zGAk/SMkWIE1/LucSmCmR3Ye9wgtVi9Crn
 egC1+GeCUApbJR2poRYJtKGzj+uz6jf4ZcnPRpw3WeFF96gjRnZE1lAAbi3diTUMnfVcONFN8JJ
 VD+/mFf9Ildtkh/5xE1rXh6zEIVlNjJMpFrI1joww9dvStOwWTnxlbh/cE+rVq+yBcOc7mDY5Ny
 2G9zqd1VHpmWn6R/GQ+dPBQ3AdPAUZhqM3WzYMLG50lSiS86A3zh9NTG6igsTecT2uoMvfhPMhP
 QmLM=
X-Received: by 2002:a05:7300:c00e:20b0:35e:d21c:f33e with SMTP id
 5a478bee46e88-379651ecb3emr8108167eec.1.1794644432522; 
 Sat, 14 Nov 2026 00:20:32 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031918c7sm19524043c88.9.2026.11.14.00.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 00:20:31 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 2/4] drm/panfrost: Find the jobs of a destroyed JM context
 by their context
Date: Sat, 14 Nov 2026 17:20:14 +0900
Message-ID: <20261114082016.2454-3-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114082016.2454-1-arpe1618@gmail.com>
References: <20261114082016.2454-1-arpe1618@gmail.com>
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

panfrost_jm_ctx_destroy(), which runs on JM_CTX_DESTROY and when the
file is closed, looks for the jobs of the context in pfdev->jobs[] by
comparing job->base.entity with the entities of the context. Since
commit 96c7c2f4d5bd ("drm/scheduler: set entity to NULL in
drm_sched_entity_pop_job()"), the scheduler clears job->base.entity
when it pops a job, before it calls run_job(), so the entity of every
job in pfdev->jobs[] is NULL and the comparison never matches.

The jobs of a destroyed context are therefore neither stopped nor
detached from the file: they keep running after the file is closed,
and with profiling enabled, panfrost_dequeue_job() writes their
engine_usage to the panfrost_file_priv that panfrost_postclose() has
freed. The same comparison was used in panfrost_job_close() before
commit 6aa8bc58ac88 ("drm/panfrost: Introduce JM contexts for manging
job resources").

Match the jobs by job->ctx instead, which a job holds a reference to
until it is cleaned up.

The patch and its changelog were drafted with an AI coding assistant.
The issue has not been reproduced, and the change has only been
compile-tested.

Fixes: 96c7c2f4d5bd ("drm/scheduler: set entity to NULL in drm_sched_entity_pop_job()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-214229@kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
Trees from before commit 6aa8bc58ac88 ("drm/panfrost: Introduce JM
contexts for manging job resources") have the same comparison in
panfrost_job_close() and need a separate backport; there, the jobs of
the file can be matched by job->mmu instead.

 drivers/gpu/drm/panfrost/panfrost_job.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7022b1b2e020..7a3137dacb9d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -1105,13 +1105,15 @@ int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 	/* Kill in-flight jobs */
 	spin_lock(&pfdev->js->job_lock);
 	for (u32 i = 0; i < ARRAY_SIZE(jm_ctx->slot_entity); i++) {
-		struct drm_sched_entity *entity = &jm_ctx->slot_entity[i];
-
 		for (int j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
 			struct panfrost_job *job = pfdev->jobs[i][j];
 			u32 cmd;
 
-			if (!job || job->base.entity != entity)
+			/*
+			 * The scheduler clears job->base.entity when it pops the
+			 * job, so match the job by its context.
+			 */
+			if (!job || job->ctx != jm_ctx)
 				continue;
 
 			if (j == 1) {
-- 
2.43.0

