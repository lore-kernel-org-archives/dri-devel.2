Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1109ECD6E7D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3A011A0D5;
	Thu,  4 Jun 2026 13:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nAAq0hw2";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7872511A0C1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:53:02 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-45eedcdaeaaso514607f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581181; x=1781185981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OH9hQQFNIkDpasnao4boz8/RAiMZ7MOKPgy4BqZR+6c=;
 b=nAAq0hw2JNRtlaamGY5H1q9W5OrLFluzc+9Ja5vyg5ja5T9Xl8wIvyaqAklLyBL8be
 tmF4y4CxfxJa88QZ6W7w77l7zIPShW8nw/dXe1bqm3Hr0dj68nE7MsPxGxiqnPRZZrFe
 SvrFBQRBr/QBDy53YTGHVtX8ah8vLTDbWqUk2sZvlRNc04kFJoVcEca89lGcEyl0YAsj
 R5JgXBL4P2uQu77w5ZvK1NliddOf5qEHbTQiUjW0uJSm7c17r093ZUE9iUnAF3Cy38/W
 OHccgI8TctWsjdnDa6FcM3hMWGp9wseWrbWFgLLDvm4HnAUNisLXV0ua1ZF0IH7vbgJu
 Y92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581181; x=1781185981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OH9hQQFNIkDpasnao4boz8/RAiMZ7MOKPgy4BqZR+6c=;
 b=gbcc5hXdZJjRGW9D7udUJxdHY2r8QEo/J1QQlb35sq7bcN8vGvhJbeX5yUvPVa3b2M
 nZEtlvO51mLLI6XyK1b7LWNJ3bRX8EAnkjANmc9UiRVcR1jlon6urz/tmtbMlxi9lIIV
 raDcvoa07HDAuyQQtlXM4Zah0qepyS0ORCrId6t2Nuibe6tFzw+cHtESnDxFB51GDieg
 VzBBQb6wLgIF3SyKha7VByVu8imAUVzRZ5t4ZWbnOCcymtVbw8QIuuTUPGng4akVRS3K
 oyI9El6RJ7CJlHbrOvTiwdNXGST5OFUfVpbR1GkNOoShZqk8ctH3iBVfySRUSDWvGM7e
 x3Xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UzPEv9/jcEDWesLhNIrjwMlLOcJvERMiKR+r2nABa/zSJ7kWH8gsR7KONfXMz5WyMi4J/08R4wdY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiUmoLwTvAUNlbT8V+S0RS4f/NgKpznbnNGj84NZ0clKyFixtJ
 OA3cL1YRLd9gSBWxQQfQVJUzVivZkTrgLE5aQfLP+EHo/nnOGitBvc9+
X-Gm-Gg: Acq92OGZcjLR3jjk1b/AGYlYkAi/MNbWeWpXZUbrczyUPW8PRH/ozs6D1kcnMr1cJ++
 nzC6DBTPuaJ08MWSMzIphkUc92ROKtMJLWJcOFZKV6Z5Mak5YTeJ+5EBUh7rp3PfZjTl5C+/jQH
 glIAcbuVtT//AaF/txlodd30TUl+pZHtuu83a4vE/qmw56kNgQH+cbRHvn89uDfJdZiXjvZJ3hY
 OjhXJlFissNcfS04RqlU/huImWy9/6OIpnh1HjEXqtrJV2yh1clyohDQkQfBBNSY+giAabxI7sq
 oT9fNzRk9kqtIxwNr+Qi1+pDx2yjpE8L2cBrFN5I6KZHsJUIwO3D17axVgLj4xOTYFMsfQV/X9F
 98OxiCL+PakC1SjhCvLea6tS05hPmx0RFuSc2bAFz+WuFqBBxWRg8Om+ldsxP80bHmn9i9wgeqt
 tLSuhwlkYkv7F5K8qNAcRpveaceBdbJJkLhvYnhIBT9VGZFT+WrgV9O3UVRkO1inc=
X-Received: by 2002:adf:eed2:0:b0:452:6aaf:76cb with SMTP id
 ffacd0b85a97d-4602178b717mr9418813f8f.1.1780581180807; 
 Thu, 04 Jun 2026 06:53:00 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:53:00 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 4/9] accel: rocket: Reset the NPU before detaching the
 IOMMU on timeout
Date: Thu,  4 Jun 2026 13:52:50 +0000
Message-Id: <20260604135255.62682-5-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
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

On a job timeout the NPU AXI master can be left wedged with
outstanding transactions. rocket_reset() detached the IOMMU group
before resetting the hardware, so iommu_detach_group() ->
__iommu_group_set_core_domain() asked the rk_iommu to stall and wait
for the in-flight transactions to drain. They never did, the stall
request timed out (-ETIMEDOUT) and the IOMMU core WARNed:

  WARNING: drivers/iommu/iommu.c:157 __iommu_group_set_core_domain
    iommu_detach_group
    rocket_reset
    rocket_job_timedout

Assert the core reset first: it quiesces the AXI master so the
following IOMMU detach completes cleanly. Move the detach after
rocket_core_reset() and out of the job_lock (it does not touch
in_flight_job).

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833f..e25234261536b 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -364,14 +364,20 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 		if (core->in_flight_job)
 			pm_runtime_put_noidle(core->dev);
 
-		iommu_detach_group(NULL, core->iommu_group);
-
 		core->in_flight_job = NULL;
 	}
 
-	/* Proceed with reset now. */
+	/*
+	 * Reset the NPU hardware before detaching the IOMMU. A timed-out job
+	 * leaves the NPU AXI master wedged; detaching the IOMMU then issues a
+	 * stall request that never drains and times out (warning in the IOMMU
+	 * core). Asserting the core reset first quiesces the master so the
+	 * detach completes cleanly.
+	 */
 	rocket_core_reset(core);
 
+	iommu_detach_group(NULL, core->iommu_group);
+
 	/* NPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&core->reset.pending, 0);
 
-- 
2.39.5

