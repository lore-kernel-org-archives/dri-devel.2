Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C3606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=ktNvX+dz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15FA10E8FB;
	Fri, 20 Nov 2026 14:13:03 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF9810E09A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:12:55 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3866a784546so409574eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795183974; x=1795788774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XnW30PHUXx79kYX2nANpqvm3liTJckFdWjtFkWjjHcM=;
 b=ktNvX+dzOW5pTmyqdZ8vqbDT1gA6TIVStHBl2XboLOQhI7PBwbiJOEPB8bLxCZ/5ND
 HzzhoW4nUrEOVyuuKgWIydJWez/llZQbqXBh8pNYeGrMuTQ2OG6l+efcyG01QjEBAFll
 yrTq33II7rQgfAebN89SGYQXV1y7Zr/8D28pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795183974; x=1795788774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XnW30PHUXx79kYX2nANpqvm3liTJckFdWjtFkWjjHcM=;
 b=krRekM46NI5NeTuWPAe0lYLbl4HoT+eSmNC+XfSRKrMgjHHhkpNMor0cx1TevFQmjL
 BqBrBe7V8bIgbl6M3zKVVG2W5EU9h38jRftYtc0LAwGuiV+0IEG6zk/z90njOGjuHrzh
 6K8njcQMD9n0FnM/pLjRjxR+crqv6VIbvkGRYulz2tmOMZfueEi3J/HfzyEpZQP5D62h
 DJzvJsqu8zXIWeSRIqNi/zCUvuUwUqlsQeeiMCagLYNrTpQ5wCsu+HB6yU4ksl1tO6We
 0hweBXjUarth6h1a/6wnhnmkXyPw7Cf/TWRVCiE/dcl84fdBgZZeEis4pF7jmuW7zQ5T
 K1fw==
X-Forwarded-Encrypted: i=1;
 AL+hErEbX8BfGXnlsmeTkk8+gA6BNM0x3HWIxjnMLZNEiOXubwFj9dlu2ahekQlCb7bRYsEej83TpjEDHm0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/H8b7EinSJZd1C0UwM4CHtD35cE3n48lVuKi9K8P2Lm8hkjgR2
 B9il6s0380x2R6S3cV9AvYgEuXx+oROpKS8gomYs+6UjxRWsDaeUbsPfEfTqKypRx2k=
X-Gm-Gg: AZFdTZfhamJu2862Pj0AavGPwLlNqE60UKCLT5loqxJU2LLUtMyFvSqWXXLcFCTkXAx
 TbAcXtDs9Jt71t3IwtxXSF/awueWZjMUSgX/1WRwz3dU1h0XbFMTDGsDrkMzEDxsHOw/Y6CWNay
 FXaCi+U5A/GxUYchIy9Fc/oc4JQ3TMb1NBwZV7jko0+x0MBhBCCXZEqZ+nFnYXt+mhNB4+EagBe
 i5W16bZkFMviXlVmX0uV8oJhHt4srzMbK5QPxUN54RI75Y4jJVPgReumyYtBWEGj+C67RMC8w6U
 KbJDjZMiJHhX1KJUv4ECCHCsoSQ6BgSZWZl+qLn2cN5CgBoR9VFH3Nf66J7mIWKL6UFAaksJjHw
 FluRgxbFPZ9H6/PtR9jguvqkEUIfzfzqrkZiCOO7hTryCnUARyr5hBC98niObHWHiB/gJ3xaV99
 TrT+amDQkn6DgWsS/OgEoJq4A5v9QOcbFh3W+EvJ/UmP1WEiC1MU08ApopvKnyUko5BiUhokl7V
 KR2ZpMGsUxNJYXlbfSXUKLN9PyOkCg56ziu0DfjHlGnwE7s7KDL2X0x+m6qkR4rqiv+ts+xNCfk
 1IlJjdPtQdQ238b5nT0x7XSifK/qKcm0Dj9x16de44nfAQ81wFeHmnZt4aCKDaarYnmMXvvKs+N
 uqkxU4yymXfQi
X-Received: by 2002:a05:7300:1486:b0:383:6eb6:5730 with SMTP id
 5a478bee46e88-38570e24c0fmr3279535eec.32.1795183974401; 
 Fri, 20 Nov 2026 06:12:54 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm11244434eec.5.2026.11.20.06.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 06:12:54 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, mcanal@igalia.com,
 Heiko Stuebner <heiko@sntech.de>, Gyeyoung Baek <gye976@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sidong Yang <sidong.yang@furiosa.ai>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v6 1/2] drm/sched: Add drm_sched_entity_get_runtime_ns()
Date: Fri, 20 Nov 2026 23:12:24 +0900
Message-ID: <20261120141225.789350-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120141225.789350-1-sidong.yang@furiosa.ai>
References: <20261120141225.789350-1-sidong.yang@furiosa.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The scheduler accumulates the time each entity's jobs spend on the
hardware for the fair policy, but drivers cannot read it. Export it so
drivers can report per-client engine time through fdinfo without
keeping their own counter.

The stats object is refcounted and held by the entity and its jobs, so
unlike commit df622729ddbf ("drm/scheduler: track GPU active time per
entity"), which was reverted, accounting a job does not touch the
entity.

Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Acked-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 25 ++++++++++++++++++++++++
 include/drm/gpu_scheduler.h              |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 03e68b4102d5..9b059914556a 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -238,6 +238,31 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
 }
 EXPORT_SYMBOL(drm_sched_entity_error);
 
+/**
+ * drm_sched_entity_get_runtime_ns - Get the time an entity's jobs have run
+ * @entity: scheduler entity
+ *
+ * Returns the time the jobs of @entity have spent on the hardware, measured
+ * from the scheduled to the finished fence of each job. A job is accounted
+ * when the scheduler frees it.
+ *
+ * The caller must ensure @entity has not been finalized.
+ *
+ * Return: Accumulated runtime in nanoseconds.
+ */
+u64 drm_sched_entity_get_runtime_ns(struct drm_sched_entity *entity)
+{
+	struct drm_sched_entity_stats *stats = entity->stats;
+	ktime_t runtime;
+
+	spin_lock(&stats->lock);
+	runtime = stats->runtime;
+	spin_unlock(&stats->lock);
+
+	return ktime_to_ns(runtime);
+}
+EXPORT_SYMBOL(drm_sched_entity_get_runtime_ns);
+
 static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
 					  struct dma_fence_cb *cb);
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 3b0978fa8cf0..ac632e272499 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -730,6 +730,7 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity);
 void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 				   enum drm_sched_priority priority);
 int drm_sched_entity_error(struct drm_sched_entity *entity);
+u64 drm_sched_entity_get_runtime_ns(struct drm_sched_entity *entity);
 void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 				   struct drm_gpu_scheduler **sched_list,
 				   unsigned int num_sched_list);
-- 
2.53.0

