Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9354CD5BCB
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F0E10E3F4;
	Mon, 25 May 2026 06:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2xKswx8";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A963A10E104
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 16:57:36 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c801b30188dso3799990a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779555456; x=1780160256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhLvA3TfrJzOyIZPC1ppqWVZ5nG/suASGnYJNqiPlkY=;
 b=U2xKswx8PFGgaa26u0e+rvpnyx+4DPpPKX6LvvWIQunGSipvR60SAqcx9CAkH5HtoN
 12d0sXffFbwcEDDBmd8KPwT4EFjoIhpJC5rZ2nTqjwdwCSjra/70rOzG5Bm/K9OVYLwI
 SyfjwLpz1QbIBvWdv0+Nw2A/Kc2njvkwDXC5Pbt/HpwECmlAl28+KoRyGX7elmslxub9
 5sYdJbjAoUi4F67RG36KuTF3Ec+B3RVnRKFUnsszbMcJPL6LAcDOlhw0Gp3ZKsX02Fno
 XCwbIboY4SRS2ba3SBec0o1RuiXyG5JxdCPkH7tG2CZoOOdz5Al0/lYRae3O9QJzMZlg
 iSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779555456; x=1780160256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XhLvA3TfrJzOyIZPC1ppqWVZ5nG/suASGnYJNqiPlkY=;
 b=qY/xHYGxz8TzfsnMIdOrglVIYZd7JkhtWiff/XOtKGDKm4QMTi9VXXIppT8C3QBggJ
 cZcThE4yGHjATlmw6tsoLjFsx4E4Y8BGrrnX5mDweQsahIbSFcg0gljtjVApigNLsVrc
 0aChuJOHVsIS/flTYfF/823imiGnoQFxorYOWUqh/aay0UXc89a7BUVBGrXIn2rdY8fR
 XnXYUMc+ChMwSjkD+UsWEIqDMBvhPnr8r4zPlSZOekdH+2SsYqCoMl2FHUaP3f8VsbPI
 HffiZ1SNCgpnSKeCJ+LczNgUk/HmFAA+DoTzBxB6OF5QHJGXeWRhUzODMiUOVcgM44Xr
 C52A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8n+98VDLaFL7XaA/kpSn/N7uiNHknN3AzRc/U4hBECZPUlIhbSLpwKv8zaIv7J4fjHBMvVHRgABrk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzkxV9khv8aJwOz6VdgP0fl6Wh5uetuw2GNo734vXTy0RYS2k7
 OHpNpGXMxNEp+9HycrUqLavSThOO0x4dkhQdY9oduKzwdPtlYs19wKJe
X-Gm-Gg: Acq92OHP0yTBhDfvydLgBmPtyjFNwy/Z+e6ogj4g3TJZ3Qm3IHOHC0oJL9NMJM2C5sn
 iI6SkWHug9tqfaRyG5J8moMdfj1P6ap1Vh60VDud8MJJCjIw/4z84nW8hr9r5D8TYkp0F4NgAkt
 a2brA5XIhVpb0yehS+QbjwcaXFpbLqPOJcIo1AXcqWlYxrmw3AjmaHsMOxDqgwAuvdocekm++9z
 89sgR5gyO/jrYvtnoUYSmqN8Iq+b3jStzUrOvQW1Ha80F80G9/HpQcS2OJ+CQK4HUL0ZeOKksAG
 5+GKhUEpaoeASxYDNWijNmU1ZcqLOY9FrZw4GcXGbRy1DmmyElrAInhM5oPV49f/TpRmRGsO1wN
 6EfeFP6ss7d12NoQ4Z7OHOldXaqSbKhpa6esMmaiZC1MH/uY8RY1ny/tddNgDuumnT33sGt5YaE
 rpPul70tlhFT4tlkryivRUxvuVfnmwLCu9DghruZIkpRTvzZR+Hagd4GxKWB0JrHTcvdl8R1HHN
 sk0avvTX6pF/0iJNnoKpX9xRC6l6tRjXs8aBCyrkcv1JeZTDpHIw0Vp7OC6eJA/egiG7Rp1XWf3
 FXlbD0Tzw/k=
X-Received: by 2002:a17:903:2b0c:b0:2ae:825b:49a5 with SMTP id
 d9443c01a7336-2beb0582ba0mr82866055ad.0.1779555456134; 
 Sat, 23 May 2026 09:57:36 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.193]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58c69a0sm47832065ad.59.2026.05.23.09.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 09:57:35 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Felix.Kuehling@amd.com
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] drm/amdkfd: fix NULL dereference in get_queue_ids()
Date: Sat, 23 May 2026 16:56:46 +0000
Message-ID: <20260523165646.25645-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523142645.39102-1-meatuni001@gmail.com>
References: <20260523142645.39102-1-meatuni001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 06:20:29 +0000
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

When usr_queue_id_array is NULL and num_queues is non-zero,
get_queue_ids() returns NULL. The callers check only IS_ERR() on the
return value; since IS_ERR(NULL) == false the check passes, and
suspend_queues() calls q_array_invalidate() which immediately
dereferences NULL while iterating num_queues times.

Userspace can trigger this via kfd_ioctl_set_debug_trap() by supplying
num_queues > 0 with a zero queue_array_ptr, causing a kernel panic.

A NULL usr_queue_id_array with num_queues == 0 is a legitimate no-op
(q_array_invalidate never executes, and resume_queues already guards
all queue_ids dereferences behind a NULL check). Return ERR_PTR(-EINVAL)
only when num_queues is non-zero and the pointer is absent; both callers
already propagate IS_ERR() returns correctly to userspace.

Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process queues operation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c08ad718dbd7..8488b3a6c2ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3312,7 +3312,7 @@ static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array
 	size_t array_size;
 
 	if (!usr_queue_id_array)
-		return NULL;
+		return num_queues ? ERR_PTR(-EINVAL) : NULL;
 
 	if (check_mul_overflow((size_t)num_queues, sizeof(uint32_t), &array_size))
 		return ERR_PTR(-EINVAL);
-- 
2.53.0

