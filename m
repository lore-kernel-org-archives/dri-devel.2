Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CE0105F7AF
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4022010EC74;
	Fri, 13 Mar 2026 14:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="KiTGQShY";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878D810EC6D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:47:34 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso20997425e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773413253; x=1774018053; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hwuj/ezVd8q3XBeXipLijWROjE/A37RRQZ4CHLHIBcs=;
 b=KiTGQShYKqUMJrojmk8HfU80euBocJMBAPhJId1hR2Mr21RtZn4+GU4TKNDFs8bM3Y
 DoYzWHzImHHp7OPACFGB7WM200GdUhskXsBGunD0PvJ97HRfsNAA/8+Mu8pCPBg4JonR
 wvi294NPEDskBgU8Fy2Yt/VACC3afMiw1wxuKSCm6lqF8PZnJCg1quO4Yemi6ekvgmiK
 uBfRPwFpzpZo1lhZjKNo7tGqmkINE0Nc+2Kt2juRaPtkStaljQvKzAtjTjnY3DgJbmQp
 X0T1RC1SGnbmXcB7a6zleijsknBY+Fqy1EtW4e039eTcB4R8O4JvOnKr7L1VzHFFdsTW
 xsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773413253; x=1774018053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hwuj/ezVd8q3XBeXipLijWROjE/A37RRQZ4CHLHIBcs=;
 b=pcAlWSmPS/nQiTn0+WUJ0WV9uA0E7OXGEobCU5khwNZVXaDfdMEdwRndOXahvJgRTj
 rai6wroWcbMac/2Qqz4eGoqP/1I1q1EUl91YCb4VvGVO5KO4B33d4X74dG/l6ov09Mv5
 Xsk8NKVffS+N63hbNXf4HFhoWltHqw/7fTIJzok9jq5xed6qe4jlKwwhbvzQ0j8gLSk7
 NQHYMrfH7rHEM1Higdgj5NEXUzyP1LV5ZeaDFtOoK2KLpBOrCbrdbRdG0Ndsjv2v1jK7
 gOsJvGhU7mfhrwF4yitLsM6kV0cRH6WqqFOnrKgTMxF9PbgGc+eSmLx73k5c3IdogoRG
 PS0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVy9kIdvXtvi63z5nM9IwhRdoqurGBYRKBBhghTKJ5KFs9r2YYP/oB+b5BK4J0H2wk/vZOIkfCGpk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsPvVfw4QrZvMfHmb/bvbCzEXHb2TJpGbQevO2A2wXqJjzfcPK
 dTC0BWSSWA7/j1p4h4o9BEBV6rBB2fvebmtODqy1aJ/v4z0tBOPJrirdiTsZ5uRNjtg=
X-Gm-Gg: ATEYQzxOeFEzJM5SSnuIeRS5kPAAqcm+1xUhj8rhVIyA9xbr6eXIkFrD7/UGT1Wxe0/
 gnYOcsc81LLEgNYEYTNgLDuNQ31AahYgeeoNjPPMpArS19VNuKrY6xwq9FafCW8wMFb0zxpk3VU
 dZsfvv6/OCPxtYB5MWLNLsTR8buyeorQvsjZ73rnTfuN68GgnvN9F5fdp3t18ZfsW2vk5A+/uNg
 vWt6f4JtVbiHSzk7YQw1iAHbYrbj7bFtV+mKbrHBtKWF3fSJpai2zrHzrTN++oYrZ+uTlp9DvT3
 TJiDbIC6hdEPU0hDKGb/DaB7EZHr6Ox+NfF3BVxnbU50vpJISY/SE+ICj26OMFneM6/UXwBFJz+
 TzSChDPrDGM5bluEyOkCqmAUprGxHExZFXwZST8GKt5FZPDbo4dMsyDA27xlVe9rJ0k4A0pO42e
 embf3oNbIeeNRzSCAVVJ17y3VG25NX0Lj9G6SH+TpyUnj7soS3Rg==
X-Received: by 2002:a05:600c:3590:b0:485:3b34:2f61 with SMTP id
 5b1f17b1804b1-485566c9464mr61968075e9.7.1773413252920; 
 Fri, 13 Mar 2026 07:47:32 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe22f3a4sm18375071f8f.38.2026.03.13.07.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:47:32 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/amd/display: Replace use of system_wq with
 system_percpu_wq
Date: Fri, 13 Mar 2026 15:47:15 +0100
Message-ID: <20260313144715.252069-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
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

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6..04f09eb30e41 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -568,7 +568,7 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	offload_work->stream = stream;
 	offload_work->adjust = adjust_copy;
 
-	queue_work(system_wq, &offload_work->work);
+	queue_work(system_percpu_wq, &offload_work->work);
 }
 
 static void dm_vupdate_high_irq(void *interrupt_params)
@@ -4117,7 +4117,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			dc_sink_retain(aconnector->hdmi_prev_sink);
 
 		/* Schedule delayed detection. */
-		if (mod_delayed_work(system_wq,
+		if (mod_delayed_work(system_percpu_wq,
 				 &aconnector->hdmi_hpd_debounce_work,
 				 msecs_to_jiffies(aconnector->hdmi_hpd_debounce_delay_ms)))
 			drm_dbg_kms(dev, "HDMI HPD: Re-scheduled debounce work\n");
-- 
2.53.0

