Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4317CC5B560
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A7E10E667;
	Mon, 10 Aug 2026 06:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LJcSjUok";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831E710E0CB
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:45 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso459481b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252425; x=1786857225; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jxy36nydTdeDBb8ceeDdse8qoQ8B4JIq+QDkrcZSSIw=;
 b=LJcSjUokiCclrB5Xspc5rh5W9gAweGlVDZeRieIPm5F6UDSLvuuiiCtFOMZ16qKzP/
 5ttYtrgcXIIQTg3+tH9EqRM67n2sW82bhcDK5qyvUC4DfaW2d8xBz8eOUIVWbb9oGLKc
 EwSotZQUo9EwkedMCT8OTYcYRsjOpTLoX3LT6pVLyGczHe5D5p41tQJwZoikpsVPOxrg
 PQOzRBQ+bDGeI4ZVxJWSnSEdwawCZzHm2jjt+0KGP+E/qEi20Fqx6ZV65NMnpWrdQWOt
 4v+7/uidBfhDgEMyu1GEuqCmwZAeoqaCDG4IS5l+ByRTk3lKtIKOx95udyH+LRgK93jz
 4h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252425; x=1786857225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jxy36nydTdeDBb8ceeDdse8qoQ8B4JIq+QDkrcZSSIw=;
 b=aSLnTGCPkijqv5CSouyoimWqvqQMCQAU6VUVbejmhCVbu0c8Pow7fCb8F/2vkXCwWH
 XcgzhrOYMJTT2qghNI6TTDi86nstxyvTS5hcRH4wUSfGifOlYi9rQ6ljcY6Bm87PE/bI
 c7M4xLB5D4unRCez5Jx/Z/c89AAK3jk2qcI/m73d/QftjJceKP00qP81neoTCeBXGTN0
 iyaB6bt18RYWhJV+OxX7kEPtcYmKj7JMfMxhv07YASFu3qW2SDr0DT9sYZbuNThkd6p5
 VN5vN+4cNaLBkfebkZuWAs6LD8hVvhCHymJrOTI/NHfIBmTjO4O/+AbE2UJY7soIGVzO
 7BOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUD5/vAvIfUROH1hJOJHJJfIeN6iu9sbJVrYb953XEdEPA+dndIYZR8RJ6PxpPj7Mw0iaDE9tp8uk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHgNwRYS6o9D5xh0AtddGC5W66d1HEyYuNgwXaPNrlf0dlP511
 MhxcGCUQ4YMW9tXUHSNsrmab6JqqRWWMttjFq2km78Be+k/8DRbFxUb0
X-Gm-Gg: AR+sD103rz934GTGArtvcoAz2x7wVDMDQREIWhuT5ZLgq4XxJ12G/i426JBfm/lM22e
 7WETpaTeWIPHN5/D/aIQURhueDRlxjYHEzaiQeDLnfuXPp+1JwNannYO1IhkA4+KCDWy/Vqcquy
 zYJDhrIwWWxhPbw84E09cDYs7DC9n3uCXJk35b3kT3RRjhgsw/spltYviaogRDv2UWr756r8FIX
 bDdcN2PMlXsWZwPi1fBelzr3AZQN3fpgwXg7EBuZnhxyI/7AnazWA95kBNdRuvkdx5tWQl8ZBaw
 YG4THQdI9xiB58bDTBHyZxQcgo2MNeUQAp3Y8kSM62x28UJz1wv4pFHGARlaUi4ofFKX0Q0noK0
 k7bOkQXUIdIG82180ePeS3/L9NjqJO4S1MewZ/siAwwtHBjGesJsnaCTnk+uhEx414lPuH5rpv8
 l+ez5RnUDnr15a+hVOrOn+kTStWGSwI55oLY4y7WIaKckyIEUe4kK8r03ThNv4tv2C/aN9UYmeP
 RI6ubv81I6C
X-Received: by 2002:a05:6a21:69a:b0:3c8:e313:8d42 with SMTP id
 adf61e73a8af0-3cbce96f6dcmr12821608637.31.1786252424949; 
 Sat, 08 Aug 2026 22:13:44 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:44 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 6/6] drm/amdgpu/ras: Cancel delayed work before ACA
 teardown in amdgpu_ras_fini
Date: Sun,  9 Aug 2026 05:12:00 +0000
Message-ID: <20260809051200.3276-7-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
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
after ACA subsystems and locks are destroyed. If the delayed work
(ras_counte_delay_work) runs concurrently during teardown, it can
evaluate aca_handle_is_valid() right before remove_aca_handle()
frees the handle and destroys its mutex, resulting in a use-after-free
and locking violation.

Move cancel_delayed_work_sync() to the beginning of amdgpu_ras_fini()
to ensure all pending work is flushed and stopped before resource
deallocation starts.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 764cd4950408..118716ad0437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4751,6 +4751,7 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	if (!adev->ras_enabled || !con)
 		return 0;
 
+	cancel_delayed_work_sync(&con->ras_counte_delay_work);
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

