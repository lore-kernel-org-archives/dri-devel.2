Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBF3C982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC8210E387;
	Sat, 19 Sep 2026 16:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kMjKw3sw";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECC010E387
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 16:55:25 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8674704dab1so2543781b3a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789836925; x=1790441725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EBON69wGqa+UQkdsinIc8KziB78dqC2CQ1FksjSvMsE=;
 b=kMjKw3swrZOtWVdUWhSCss4vcU5/bjNL9yq8z4BdiOV5onGjfHNiXvAcdg/WgoB9fU
 JC3uzW19/ua3skDeg57VvmgleCbQvVBAjjk9ljBjtadQlMP/O0nCDwXFP9HBNfQO8h6W
 cu6aoquM8Cokx3Cy+Ef2XnYpeTrf7j+h3LTs+JxBJmlqPvg3Ow2xqP3N2CMQQh1oVr5D
 dmFEBGOrII8zUf1EsO2w2z9aYqgMY7X6QdNYEZAE974N4l6pkMVdDF3XtHFHFCA8vYef
 NBaIl2GwCvtQV3x0Hipwa0pVbgQUIcUYZFB6WDUec+uuY91gA4CrsIVXKiBX9b+xuWBK
 XH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836925; x=1790441725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EBON69wGqa+UQkdsinIc8KziB78dqC2CQ1FksjSvMsE=;
 b=Z+jGkVI3yyKMkBsNLP6sgrD2JjlN3CBK/dQeR9463IejQ9myjHGGTaTU9YtO4zaA3j
 QYCgenPltdNEZHq14lL4LaFUnkvcRiaSECV/fOQMfaevU2NLL+Vft4Oad5J6F84RcPet
 MFLRum9T0mT/MsVq+0nZRXSui6/8CGSGYh+1MBU9wOWchJxYwNWFxxe8Xt6anBcaB7Qg
 fYGCcMdNbeyXdT9rWKxhB+oz7YRLUs98qo7j1Q1JVdQB8RmCM/JBBP0eXoo07lpBb93N
 VATfsg/+U/3NpSwwqaLQwK1YzHMk28ulTWVJR1ZxqZwfcdESsAKyaFwvg8apz3VDIOrW
 q1Gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWdvWbbkliThX+bTCHvSe2Mb9vXqDE2QOT02VUuU64N00eGPfdnRS6dTqVmBoMW2FG5LCl92sNQvc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLl/kB9Y7tPC0iSMU/YTfeemx/S9Pyu/yBWUHBrqg7+D/ktuxR
 0J3VhelfFwvZrNBGazV0Zq2zLkc0lrYEIoo8/C6hCW8b7Qzcs+aQnANt
X-Gm-Gg: AYBFou24ZThy3EWaVaolwDJV92svBUSGkEIN1DUn6BtzZrJUEHr3YdEGE8vNRbysfcU
 NJKKPswJbvZRxDcSCg1h/2jMKra8s1WFdS/6h3cHlf/xtz4/z0k+g55Dhvl9vDfC/4QS0T8Mdpw
 fad1popFPYHG6DiPnbsoa/KcPUGmVgnHDAGG+iraz8Kvj1Db+C0gmuoWoKHrJD/IB3FrOikHo5r
 +ccrCCSZMnjeuY1W+QfUrICV69Dk28ZuC6p6OlWV8Yf5wIV0VOngeNKCuZuTHwXlSnNJzyMHdIN
 YL2lHOCGK1QiP/ljRC4PJUQgTBU4tPRwf90ELR3Cx4QsSuSq6dbtju/Bj3UC+uG9ZnTOHyZzH9O
 u913eR/zpP99SGH++eQsqTZcbmfP1uHEnAicWVCxiFGz9Y4hKviG9FHvMQ6yNxYRXJIBCPwIl5B
 XwHs3gybU92L8EhRg8xcA7JX0zoE/EXDoU3+bxXNSsRt9mEbpIJSp7Kw==
X-Received: by 2002:a05:6a00:2d1e:b0:878:34d7:6a34 with SMTP id
 d2e1a72fcca58-87834d76ed2mr2182854b3a.40.1789836924948; 
 Sat, 19 Sep 2026 09:55:24 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-877a94f238csm1146617b3a.21.2026.09.19.09.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:55:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Tim Huang <tim.huang@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix IP instance memory leak on kobject add failure
Date: Sun, 20 Sep 2026 00:55:11 +0800
Message-ID: <20260919165511.3687822-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

amdgpu_discovery_sysfs_ips() allocates ip_hw_instance with
kzalloc_flex() and initializes its embedded kobject before calling
kobject_add().

If kobject_add() fails, the return value is ignored and execution
continues without dropping the initial kobject reference. The failed
kobject is not retained in the kset list, so the normal sysfs teardown
path cannot find it. As a result, ip_hw_instance_release() is never
called and the ip_hw_instance allocation is leaked.

Call kobject_put() when kobject_add() fails so the initial reference is
dropped and ip_hw_instance_release() can free the allocation. Keep the
existing best-effort sysfs behavior by continuing with the remaining IP
entries after the failed registration.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a404d8aa13ee..4b1ad1c0a10b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1314,6 +1314,8 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
 			res = kobject_add(&ip_hw_instance->kobj, NULL,
 					  "%d", ip_hw_instance->num_instance);
+			if (res)
+				kobject_put(&ip_hw_instance->kobj);
 next_ip:
 			if (reg_base_64)
 				ip_offset += struct_size(ip, base_address_64,
-- 
2.43.0

