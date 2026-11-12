Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8B606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=kW/gNmuv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F364611224B;
	Thu, 12 Nov 2026 17:12:24 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19EF811225B
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:12:19 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cdab8873d9dso41409a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1794503538; x=1795108338; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7qKiaMfPXurmREX1W524fvP1dWjjQw0qkmJh5bTsW7M=;
 b=kW/gNmuvKwgAGJloVINQ44gcJY3UnawlW7LzmTyu3IoqkAUmF85nxVSmKddOb9TFxW
 JczETcRae1ROTXG0ExvibpRV0KZLINuPcBuqZcUFwX/vAXxRTm7VIFqitWxumKje/uWI
 kp/qn5mk9/28zaZz9zpftnk4btUMqf2wZim1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503538; x=1795108338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7qKiaMfPXurmREX1W524fvP1dWjjQw0qkmJh5bTsW7M=;
 b=YxhBEtbRi9Ui1m9tox+G8dxwHlxamNYUp1/wZG0+TwPdCAY7gvGWl7aQWSCZlUT8ZO
 Zo0H0qmUpQwEAPgUFwR6URWzWba7jVXvLz5N910aWZczQtAhIPGJ6dltHOnmYDsP2HFz
 Us8HwPXu+eaB86n+Ja7IE3jMv3iBlFneVx5vQdMUyKZIVEJUwEx5XQHehmMfjpcOcui6
 mxNOIruknV6BF+csqpVyrO1NzdTf80BHARxP2cz+Gl0WJp3glw6Yv1dt/st5LvgTMXmw
 LP9oKre2N4PV12kZLo9db9tMPtaADI3YWGwF1b9XE3ujPxlb8vc1lFPSWgzSIAMjkjae
 TrTA==
X-Forwarded-Encrypted: i=1;
 AL+hErF/TlVx5ugxXzqTou4JXbkIXfIyF87/TlvPsaah1+7+07qadnSgp2pOPPi70woJ/kLDyyqC8CNs/a8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ZNqGGJV54Ed+9wgD8eTgx4PKC41/8ajXZx/9XzYch5M8Vtizx
 D3CxXbgoswMbRATafrPan97kYRRtELhSxtWdOMkeM2wdXW4AK5njRQZWWrnjP+v/M5w=
X-Gm-Gg: AYBFou327ILnFYZoVGorc8E8WQShk166nOmLCMZnhjUUkl71yR8CRbn6UcAwyLuLQob
 lukBhDFXJGQtb1q1/ovtrKzGeXyj9cU07nSc/eGKBH8pwPwN0iZQ1t4q4YujDGGXYekD4PZcpQ0
 /UKGYRDrEwZH8ZDVkqlwUhXH5Vr9dB//c0Gp0RCV/0sTliRBOsCRut0/9cR1E7C30OQwWpNzg5i
 eCmcZx2Hi9i3+YMkQqzzR8WcC4u7lva3mLcdM6rTy7yK/QJqJE+OQ/v7FlBuAeVFLRywK21E2lK
 GssBUcdnByJ40oS7uLp1gdRO6qaTn+wFndnj7JS1z0fHYy994HU0NylLe4B50GiiaPlp+thMwH9
 zQo4jJ2yinERq28oj1ntLgY7tkl1kPDwGwA4n9HpAy+d9GGls3R7b2d/b/bIGmRu6ANbrtsPBqj
 /pVFLMQKdiwObJIWIbHKR9U8b0kHkXxdmvzJVSfxACDyN/XGsnRXRI/zjQ+M6vTzwPMy8VtKGHE
 iIUtxV+CSo8lVBUo3nMybW19dc4HxcnY9O5TRM05ds5PQOjiP5VsaT4OBi/1nylJCNR0l6lNjzF
 uajHS5XRi0zCK+uphH6gj4AEh+lVWyjm9lab/GtaR6T6Q/NEvErkB48z/JMoKlKeUYTimky2sF8
 AB+kQf1BFEXKkQ1GKtnK2NGDWBvujiSWR9A==
X-Received: by 2002:a17:90b:2fd0:b0:3ac:7842:bd50 with SMTP id
 98e67ed59e1d1-3b182f6607amr6241433a91.15.1794503538590; 
 Thu, 12 Nov 2026 09:12:18 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1ae981c55sm263682a91.1.2026.11.12.09.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:12:18 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, mcanal@igalia.com,
 Heiko Stuebner <heiko@sntech.de>, Gyeyoung Baek <gye976@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH v5 1/2] drm/sched: Add drm_sched_entity_get_runtime()
Date: Fri, 13 Nov 2026 02:11:43 +0900
Message-ID: <20261112171144.3151554-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
References: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
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
---
 drivers/gpu/drm/scheduler/sched_entity.c | 25 ++++++++++++++++++++++++
 include/drm/gpu_scheduler.h              |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 03e68b4102d5..ac040f95876a 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -238,6 +238,31 @@ int drm_sched_entity_error(struct drm_sched_entity *entity)
 }
 EXPORT_SYMBOL(drm_sched_entity_error);
 
+/**
+ * drm_sched_entity_get_runtime - Get the time an entity's jobs have run
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
+u64 drm_sched_entity_get_runtime(struct drm_sched_entity *entity)
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
+EXPORT_SYMBOL(drm_sched_entity_get_runtime);
+
 static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
 					  struct dma_fence_cb *cb);
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 3b0978fa8cf0..96a3401d4c88 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -730,6 +730,7 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity);
 void drm_sched_entity_set_priority(struct drm_sched_entity *entity,
 				   enum drm_sched_priority priority);
 int drm_sched_entity_error(struct drm_sched_entity *entity);
+u64 drm_sched_entity_get_runtime(struct drm_sched_entity *entity);
 void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 				   struct drm_gpu_scheduler **sched_list,
 				   unsigned int num_sched_list);
-- 
2.53.0

