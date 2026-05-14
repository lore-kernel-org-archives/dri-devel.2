Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E612ACD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 10:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42E010E3D7;
	Thu, 14 May 2026 10:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="XTBhfK6S";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F4310E3BC
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:38:27 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so83821075e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778755106; x=1779359906; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8DzazZTLe3LM7etn2uuEKbASQrBr9SpY+ktz6nHGRc=;
 b=XTBhfK6SyFOZhECcxYjE6AE47hXjOxqMwU4tOa7UW44iRV4zEW11if8/0xT4EnDrxD
 +PG5qbrENR0WoXczaPyLtpQoH0DUdXs5vIZacA11IRevewcsnXiQzF4XSKhebxd//WIc
 qgmJJkYu9gyYXrflBDMM8NLmmIzLnW903VCox4Lj2HLh56S1kdBDh5mHrfKNtm4xw8fY
 +yURRCX9n1jOGasN85Z7Dd96KUTmaSWSlu2D3QjuIo5I6CKvn9z9TLg+OybEtYALb3yN
 lWP+ehseF0IpV8iDEPOeq7Rfv9XMbT8M3tuINzaJMpvtI6/Jcx4WltsAdms1AQD7NbKc
 4l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755106; x=1779359906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T8DzazZTLe3LM7etn2uuEKbASQrBr9SpY+ktz6nHGRc=;
 b=Qat+ftECxvWzRXTSG02QJcBsxFN3HgOH/5FnHmQM0xzHGqNDBhijc8HQ5xOM8PuVcl
 PgbwCbeOVAVHj+q7jjt1+b3hMNq74ZSuWxbiE4+b4i+v687DuWMO1hhC27KyAu5eII6g
 j7IFoCDOoX39R3R4EDYNh1wVN1N/RzX3yCfJlof/d8bl0ixaYlqRSZS5r3ppS0cbacoB
 4uPf8OTEXnv3tkUF4PLf3s5W/Qd+lMDwVYIMA7iBc2eaRcH9nTq2nO0O/kke6UPWBYOm
 SslcRFQkdCqDRPlOjiINJzaDgOtxnlAj0lDzJeR6Yt2i96V8GWF2uG8Fm81DO1ELRU/s
 umiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ86W2fHYvIB8acr6i2c829/7HKdBkem6bkuXgOguvob8khTDgrSCyXzY6qPRELIgm+OYNhZ66lfba8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTK/WLSeyLUQaPpTh9OS9fYI6jW8eTJsopI/z1iH3Q9sABy/K6
 BU7RmhVabwH4nIAamROeqO17340CDuYJpLuz1hOnd++SDAGmZ8ajnnKeWApxUqddDfs=
X-Gm-Gg: Acq92OGAuLOKRE/RE9LcremAIB+WVG33CfbDPevgeyTRCTULkMec8vna4gLXXk3x/og
 WZg3zqsJhf8pfoAEi9JhauCZF3umtcNZ8BOVzhHDKUbHB5wX3FfpwNHPcdmshNv1aaw0NgLXvdo
 +T7n1kLkdhJPA6q6FJgHB4f2X2Gbu6ScFfOKexvhk6tJzMjZLRAxEPnuvqOVP3PKfZqn7Yvl4GM
 mmHzw4v7cyStqHbUX1GXXZdCsJYa5RvjsRYerUTjF6QlT7aeS4RUtBt8T/lzi/dO8jK5dgqYPOi
 5wQmpA7OYgrN9dIz7GueV8wkp8Hyqd5ae3S7G8gbmCihr1cpzKb7sWIYCq6k8CB6o24GXOpmTl/
 +Dj7MZeqHMMpLdtZb0jFd0abzsGfDW7yWpSA098RGQkYK//x0asTXMHpuVJ2Q9tOvJnLEyF0k6D
 pa1r79fM3wVRZX00z8SALhdVWkDcyJxCoxSSVul26BbJccnn8=
X-Received: by 2002:a05:600c:6303:b0:48a:592c:e632 with SMTP id
 5b1f17b1804b1-48fc9a2b921mr113942445e9.16.1778755105775; 
 Thu, 14 May 2026 03:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64e2132sm57788365e9.15.2026.05.14.03.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:38:25 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ray Wu <ray.wu@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/2] drm/amd/display: Replace use of system_unbound_wq with
 system_dfl_wq
Date: Thu, 14 May 2026 12:38:08 +0200
Message-ID: <20260514103815.190628-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514103815.190628-1-marco.crivellari@suse.com>
References: <20260514103815.190628-1-marco.crivellari@suse.com>
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

Cc: Ray Wu <ray.wu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index a64e95860e99..e83f7f71e242 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -383,7 +383,7 @@ static enum amdgpu_dm_ism_event dm_ism_dispatch_power_state(
 		}
 
 		/* Schedule worker */
-		mod_delayed_work(system_unbound_wq, &ism->delayed_work,
+		mod_delayed_work(system_dfl_wq, &ism->delayed_work,
 				 nsecs_to_jiffies(delay_ns));
 
 		break;
@@ -399,14 +399,14 @@ static enum amdgpu_dm_ism_event dm_ism_dispatch_power_state(
 			 * have a negative power impact. Skip idle allow here,
 			 * and let the sso_delayed_work handle it.
 			 */
-			mod_delayed_work(system_unbound_wq,
+			mod_delayed_work(system_dfl_wq,
 					 &ism->sso_delayed_work,
 					 nsecs_to_jiffies(sso_delay_ns));
 		} else {
 			/* Enable idle optimization without SSO */
 			dm_ism_commit_idle_optimization_state(
 				ism, acrtc_state->stream, false, false);
-			mod_delayed_work(system_unbound_wq,
+			mod_delayed_work(system_dfl_wq,
 					 &ism->sso_delayed_work,
 					 nsecs_to_jiffies(sso_delay_ns));
 		}
-- 
2.54.0

