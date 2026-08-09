Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF7CC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDABA10E67B;
	Mon, 10 Aug 2026 06:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vby2HHiU";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED2810E11A
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:52:06 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cace91f112so8814475ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265526; x=1786870326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c/m4TAD904Gpx4jOO1f1keOOyQGwoQabIUB++Z17kjo=;
 b=Vby2HHiUSTa0dlvG7FaLi5H5IXH7AfPzr/dSjYLSdWUFxufhBztSfQ/t1F45eVEG53
 AjrpOumeYpruhzOUVzMBwm9aF6Y+lVPDzGN7VkihsbyJq/BCemWGrRMUisTyfSJApr9a
 NdPI4E7YB6EUDTT20hT1msD9K0I4L9fHzr9KCx6vGVSiOUsfWNcZFV+V4rr7Q7yA0Lcs
 AeJa+FSpM8OezbYGv1gRDVUtOmtSLsbTXBdIEoNjSNxpBGf5T5Vv9JPGXabp+ieVeLMf
 b5+np4SQYU6TW27OswGI2EAHZ5makFEriDUBUt2MSsV3/iwOZKXbAUYlNdrx7Pyx5RpX
 N2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265526; x=1786870326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c/m4TAD904Gpx4jOO1f1keOOyQGwoQabIUB++Z17kjo=;
 b=DSy49sr3vk+hvRY/SMM7A+W61Ru5ReHA9R+PUu8VLvGYsndL7NvAcpGPK1igow0Zwj
 1jMptVAIOGYWO1ev3JUJ2D8QqD8epKhAhXWsLonAnZGZxYHAr21bCeMiRsxUHMCGWIQA
 FuWewRtJvBQFuWZBg+0iq/k1ZB7AZ+QrlpDclpxsNywLC1MePhJcA7q+Az4zBTP4HV6Z
 bBEd6ERnW2+UmEW+7N9GS0obws4SzHXueflqNnaHvgo1XCSGHfe75Zk0uPrFj1EShTFL
 6nEIJvUlBtGnup1AeIsMTSjaMLWMM1ztONsp6Z3KvYgS5JY92QxXBL2XF3hIfkH97DSi
 TFLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYCYdZmblku3ipDEKv3j/jfx1bMvz0xw6tBwkQb5gin31BXFLq0sC6lv2tK5RrhYdMV4L3JO/Jpnw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGSd0J0vjqFsdDCkAr8b17SjRhpOtGHHrJdwpsufP/C3QWiMPR
 +9FcEec1Zun1+TJPukmcBDrLKZXTYnfbhy8BsqWS5jlsa+uCFgSTo4Ym
X-Gm-Gg: AR+sD10bD3jZSzMU4bWb3Mxl8Yviv/GHzfkVElkSFVI5mZvgTDw6deq+M9whDioi2/y
 H+BNJYIDMOob2esuZGeB5ll1SXs483oWhRmpVN1yXUNY0xYGNIcaBp33Z5oJPOVfLfqOcFe08sP
 SUBrywHq64MYbIdPvZ7NOveeLhL6ZUXZzewzuc7UDXOJht0PZjHApFUayR/Ty3Kbz98WYX+Opj6
 aIrdPUlGCk/2A3WhuFKkIWCTLiJBVn4m3Gj9Huiv0cSBWVOWpnEA9P+KguRhTpQyQne2HINcGj1
 XcC9a3dlCHNpJFPxp4XXRjOXUtbI8/6rDQ59GvhtSqB7NK+L3mEausksqQGWAkuo+g8dB5bgZjk
 R8ywQF91WUIorT68wjRHO1Y0vRQ/WEGtuxhn4aMBO83XdND7FShf1bGrZLYCy8TjdJjHE1u/khm
 GNuAgVP4QkavrFJYNtD+wuzI3LjEIcXtFImWWmQaIOZR8bFfrOzWcwX9/LF1Djtvlj0vbYP5lWF
 tCA+pUKyfE=
X-Received: by 2002:a05:6a20:a111:b0:3bf:7eb5:9459 with SMTP id
 adf61e73a8af0-3cb85ef9202mr36500133637.20.1786265525696; 
 Sun, 09 Aug 2026 01:52:05 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:52:05 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 6/6] drm/amdgpu/ras: Fix delayed work cancellation order
 during teardown
Date: Sun,  9 Aug 2026 08:47:35 +0000
Message-ID: <20260809084735.9743-7-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

In amdgpu_ras_fini(), cancel_delayed_work_sync() is currently called
after ACA subsystems and locks are destroyed. Similarly, in
amdgpu_ras_recovery_fini(), mutex_destroy(&con->page_rsv_lock) is
called before cancel_delayed_work_sync(&con->page_retirement_dwork).

If delayed work runs while teardown is in progress, it can attempt
to acquire destroyed mutexes, leading to locking violations and
potential use-after-free conditions.

Fix this by moving cancel_delayed_work_sync() and cancel_work_sync()
prior to mutex destruction and subsystem teardown in both functions,
ensuring all pending work is synchronously canceled while locks
remain intact.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 764cd4950408..23b9844d9f1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3994,15 +3994,14 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 	if (con->page_retirement_thread)
 		kthread_stop(con->page_retirement_thread);
 
+	cancel_work_sync(&con->recovery_work);
+	cancel_delayed_work_sync(&con->page_retirement_dwork);
+
 	atomic_set(&con->page_retirement_req_cnt, 0);
 	atomic_set(&con->poison_creation_count, 0);
 
 	mutex_destroy(&con->page_rsv_lock);
 
-	cancel_work_sync(&con->recovery_work);
-
-	cancel_delayed_work_sync(&con->page_retirement_dwork);
-
 	amdgpu_ras_ecc_log_fini(&con->umc_ecc_log);
 
 	mutex_lock(&con->recovery_lock);
@@ -4751,6 +4750,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	if (!adev->ras_enabled || !con)
 		return 0;
 
+	cancel_delayed_work_sync(&con->ras_counte_delay_work);
+
 	amdgpu_ras_critical_region_fini(adev);
 	mutex_destroy(&con->critical_region_lock);
 
@@ -4785,8 +4786,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	if (AMDGPU_RAS_GET_FEATURES(con->features))
 		amdgpu_ras_disable_all_features(adev, 0);
 
-	cancel_delayed_work_sync(&con->ras_counte_delay_work);
-
 	amdgpu_ras_set_context(adev, NULL);
 	kfree(con);
 
-- 
2.54.0

