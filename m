Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048B1FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5166610E17B;
	Thu, 30 Apr 2026 09:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="X+QDpSC/";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC02810E17B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:15:43 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so8988855e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777540542; x=1778145342; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e5t1FiQPj6AzB52JircQaBZx/EXB4p7emQ+fZCfnRP8=;
 b=X+QDpSC/c/NVEShXm2fIGcLa9M5oiQCn9PJf/t3zoVus8IxZMG9OlR6CJJ3mRVyaKX
 iuyfF1/6UIAxoJbJNlp9j8DILQ/K2sz2O/lwlFz7YFBgtsHaxwd4HwmojUvnguVZgrgw
 6ffF9jxAOgWzzSSIpQk5U8HhThRfP7vVhv38yziYQ7mmzAL7lph7wQxXGF1xWLwsYZH5
 WLiPwjO/PkBsdNmAoKl5+rWAi3vAOquXVLShlzyqla1I9WtpbAO4VU8s4t8WIMG74M/z
 CNKKwwtfBc32BFGVX6lK8yXdcIqlGgbg7TLjzp5UpJcgjXMpotkP1F1MyV42/lMObWR2
 tY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777540542; x=1778145342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5t1FiQPj6AzB52JircQaBZx/EXB4p7emQ+fZCfnRP8=;
 b=nAEzWmqeKe0NUV91SZodOGGpGPx9kQEyl7zt6Va6FuTozs01NYxxH1D2EjEcIMjoDY
 aAPMzXmb3PL/edVS9Hra5eSrqns015kndWOToLsUEzX+rDGzV+YYpGT/Vs1F7PPgXGSC
 BtKFKTHiEElschHePs6nR6h5v8Y+gWNlk6XP2LjNMIZ2tDrSFyZJkqnLV5yJPla5kbbC
 BfkG8fCNgZ6cpew81y4PemOe+VW8BOTRqG8wlRozqNPHoe0Jmhhbr7uKjMyHQ9b8+s9Y
 0WqV3ZEKMNNupwWDVV3ntPKI8EmAZu3ooY5hWJIgj5pO2kTgyrGoWDJprSb+JkTq8LqR
 MtFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+L8FC6MbkLaD8U4WEc2tnEhxl5aFZLqy2LlickTiQvkPQp7hGzKsrbfMmG0mc2h2qdd/AilqFvqUw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+N9xEzi1j23H2Y4go0Nw5d2RpEhuqV7TuxhyB3lRh2Rj4tE/e
 AfskDwz7RDBxNlzkMNqFKcqyOtaIEE3Vc3n+XUP54MVON9jL3GYsx+IvheonQFyypoXRiBoVuI2
 8KyYeIVY=
X-Gm-Gg: AeBDieszWpN/YZklHjkyYITvBb7vXn1h6fiCQqrCMvDsgs1o1sfsW7L/d1lXOcc92i4
 TJFpIyEoc+sQBUOf8Pp8Kx0il+IrxKQD26hrf1BCvmQSgImqcUtzPQKr9XbmWAIjuK2qPBTwfEQ
 49Bmht831cB7sgxNyJDJggxdyPH7RSV2cIbY5EdQnHIrjMVqSHsFsidkdNL3FBNxeaeUGLyMhxs
 EB7qk7dMCjhS2tIsAU/Nq8aEj9YoSI7rIID/8UII5EACt+tBCI1KVfLDr4H7ngSeCnfhCJUdW3a
 Td68pAerPhrwhIEFuKBc2TPGgWtVa4AAJWHh2J835ka3sccfWPbEOxpm2+h0LEXl2Kf3Oh3mH5C
 SXjctvD9XGBsky9XGZJp6j5cfUakkZg+2N3v4ij3jnzTGpS5Roay0ETbhiQchOJ6wp6ghTJx6zR
 a0QXja5OlB1AURz+mywLKghvx0JToxpt3jY2klitwxuS8qMV2DuwBzuStEPg==
X-Received: by 2002:a05:600c:8289:b0:48a:592c:e632 with SMTP id
 5b1f17b1804b1-48a8444495cmr36955705e9.16.1777540542080; 
 Thu, 30 Apr 2026 02:15:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b4216ecasm12023358f8f.14.2026.04.30.02.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:15:41 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Hans de Goede <hansg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [RFC PATCH] drm/gm12u320: Replace system_long_wq with
 system_dfl_long_wq
Date: Thu, 30 Apr 2026 11:15:32 +0200
Message-ID: <20260430091532.115846-1-marco.crivellari@suse.com>
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

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected, but it is a per-cpu workqueue.

This is important because queue_delayed_work() queue the work using:

   queue_delayed_work_on(WORK_CPU_UNBOUND, ...);

Note that WORK_CPU_UNBOUND = NR_CPUS.

This would end up calling __queue_delayed_work() that does:

    if (housekeeping_enabled(HK_TYPE_TIMER)) {
    //      [....]
    } else {
            if (likely(cpu == WORK_CPU_UNBOUND))
                    add_timer_global(timer);
            else
                    add_timer_on(timer, cpu);
    }

So when cpu == WORK_CPU_UNBOUND the timer is global and is
not using a specific CPU. Later, when __queue_work() is called:

    if (req_cpu == WORK_CPU_UNBOUND) {
            if (wq->flags & WQ_UNBOUND)
                    cpu = wq_select_unbound_cpu(raw_smp_processor_id());
            else
                    cpu = raw_smp_processor_id();
    }

Because the wq is not unbound, it takes the CPU where the timer
fired and enqueue the work on that CPU.
The consequence of all of this is that the work can run anywhere,
depending on where the timer fired.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

So change system_long_wq with system_dfl_long_wq so that the work may
benefit from scheduler task placement.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/tiny/gm12u320.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index d73dfebb4353..4ad074337af0 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -388,7 +388,7 @@ static void gm12u320_fb_update_work(struct work_struct *work)
 	 * We must draw a frame every 2s otherwise the projector
 	 * switches back to showing its logo.
 	 */
-	queue_delayed_work(system_long_wq, &gm12u320->fb_update.work,
+	queue_delayed_work(system_dfl_long_wq, &gm12u320->fb_update.work,
 			   msecs_to_jiffies(IDLE_TIMEOUT));
 
 	return;
@@ -427,7 +427,8 @@ static void gm12u320_fb_mark_dirty(struct drm_framebuffer *fb,
 	mutex_unlock(&gm12u320->fb_update.lock);
 
 	if (wakeup)
-		mod_delayed_work(system_long_wq, &gm12u320->fb_update.work, 0);
+		mod_delayed_work(system_dfl_long_wq,
+				 &gm12u320->fb_update.work, 0);
 
 	if (old_fb)
 		drm_framebuffer_put(old_fb);
-- 
2.53.0

