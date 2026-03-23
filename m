Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC0FF4613D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DD210E42D;
	Mon, 23 Mar 2026 16:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="QSMduEjM";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28E310E436
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:01:38 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8cd78a4ce8dso392261985a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1774281697; x=1774886497;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGNB24MNI2cEuLKVW/uGrymPK0BoMZGJRt19xK2nIS0=;
 b=QSMduEjMcy8Eo1rH7R9jTbY7UgIsdyC5q4mrmD/Mr4mvZIbHhrrjmY1aVmVIp978dE
 YSt4f04qBYPGWkK3pEQHwtsXYSE26YgaBShJf6s4J+74+1OHDiVSIkUbQw60rlQ5en4b
 J4TY//x2lFpH5+dBKsFh0rwocElPoGlSqVD0XN2Ve2ZgGq89mj93GABxj8HK7ijFu3QU
 WD1qb4QFT370BfFRRbR/SZ/By/EA8fVrPZ5Nual8lvkY2+fN0hEnztp8XSqv/KGkVtis
 F5OpdUquht9yKY+SS7JthvqZUQYOihFMGKSlkvpqQxA/QPlKupaWN03iLIMkWRBY6wmH
 Re3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281697; x=1774886497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGNB24MNI2cEuLKVW/uGrymPK0BoMZGJRt19xK2nIS0=;
 b=BkejMqio19idB9p6B8iesZBSsS6TzFlUWoByFmvw8reOyZ1/SFHIT2ktIRNtfclowO
 /fUc8Io2I+rjeFLzaspjSvp6w49ggci4l6gOEFwpUfCR0RkxTC3V903cm0ufMI6FPbNo
 xPWg017KnqddUzyhWxrLPJMtVVEWp/ghlWFbardCaLXxR4Y0xdpTosYVokpmUOaqOGWB
 rRUVYf5ulzXLDFlUx/pyfIzEU2ULHDyVuFJhr6sB6nY2l/4JRWIovtLsiNm3Z03pxEk1
 J+R3qTQIfDm2JUfGygQSyQIFd6v5129hp3iQAQcHvlzozY8Wpb8qPemJfWBa27knv12F
 tCmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxTPxDyXveCK//sBEO11lSP7Y9ugc0Uc+y4WUQ2s7b62DImNbD8YQnH6RvgVY4piHKmf0hITytXlA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ7vr4pFFUg0vUgN9Z2YM4HoZqDhJriVA5R8EK5LDZwT4+dp+A
 L+JDVJf/8ZtDUGKDbsTf5ftrhpdHrt0yfYU9pqvrk/hpUjaXefXonxSxPw/tNqidCn8=
X-Gm-Gg: ATEYQzxazRgDjfoAwPqh9LxUplCoa3iXbNKvHUcZzhCrM9bRe52bjXdMS777NPstwAR
 SUgfmnYWSkNiv0gUEuUmN0SXX0lDbMZrLSb1InD0WXd3Q4uFXdP25TpOYIbdRcqR3sgdpCyGeWo
 Kh7VR0pBa98e37hEnM+0yD2V70m1cDND8wWtXxUptSzLkNa4iOQiwrANJZ12foMPgWRBVKnCqQm
 h4BFpuzOM7oHYkt1CPIA7Rjxx7RbPzTqkRDjmwrj44hbG4vBH2VX6CVq/bxgMGDnIWqfs6zX8WA
 Qys0yN4RsBOR7JVX2TgVCVAVi3dxVhwAqKHfZvfQ8znEQQO/OYwvJl9KiRssG2BMhvrgJbdVW8P
 3BXU+NVrVtCuA7h6wEX+ptSvcxleK8KCgB6OCmL28YdqcG6z1FAl93MzqRGrzjFrdHUmVMLSA3h
 8hcZGVHNmF8eo5kf3iZgmv/kNLE65RGgPquYTfcJ7p5/Qr7MmFbb8qptxjuIA3KOrJiA==
X-Received: by 2002:a05:620a:4543:b0:8c6:a539:55d4 with SMTP id
 af79cd13be357-8cfc7f33fd8mr1883458885a.48.1774281685710; 
 Mon, 23 Mar 2026 09:01:25 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net.
 [73.143.21.186]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:01:25 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Liu01 Tong <Tong.Liu01@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Kees Cook <kees@kernel.org>,
 Prike Liang <Prike.Liang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 10/19] drm: Use trace_call__##name() at guarded tracepoint
 call sites
Date: Mon, 23 Mar 2026 12:00:29 -0400
Message-ID: <20260323160052.17528-11-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
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

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/scheduler/sched_entity.c          | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 24e4b4fc91564..99f0e3c9bddcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1012,7 +1012,7 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
 		struct amdgpu_job *job = p->jobs[i];
 
 		for (j = 0; j < job->num_ibs; ++j)
-			trace_amdgpu_cs(p, job, &job->ibs[j]);
+			trace_call__amdgpu_cs(p, job, &job->ibs[j]);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f2beb980e3c3a..69d5723b98580 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1394,7 +1394,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 	if (trace_amdgpu_vm_bo_mapping_enabled()) {
 		list_for_each_entry(mapping, &bo_va->valids, list)
-			trace_amdgpu_vm_bo_mapping(mapping);
+			trace_call__amdgpu_vm_bo_mapping(mapping);
 	}
 
 error_free:
@@ -2167,7 +2167,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
 				continue;
 		}
 
-		trace_amdgpu_vm_bo_cs(mapping);
+		trace_call__amdgpu_vm_bo_cs(mapping);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6f..2c6c8050af269 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5190,7 +5190,7 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	}
 
 	if (trace_amdgpu_dm_brightness_enabled()) {
-		trace_amdgpu_dm_brightness(__builtin_return_address(0),
+		trace_call__amdgpu_dm_brightness(__builtin_return_address(0),
 					   user_brightness,
 					   brightness,
 					   caps->aux_support,
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index fe174a4857be7..93d764d229ca9 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -429,7 +429,7 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity,
 
 	if (trace_drm_sched_job_unschedulable_enabled() &&
 	    !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->flags))
-		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
+		trace_call__drm_sched_job_unschedulable(sched_job, entity->dependency);
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
 				    drm_sched_entity_wakeup))
@@ -586,7 +586,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		unsigned long index;
 
 		xa_for_each(&sched_job->dependencies, index, entry)
-			trace_drm_sched_job_add_dep(sched_job, entry);
+			trace_call__drm_sched_job_add_dep(sched_job, entry);
 	}
 	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
-- 
2.53.0

