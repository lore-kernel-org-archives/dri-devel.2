Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA4CCD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 10:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D5110E3BC;
	Thu, 14 May 2026 10:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="gq9O/3HC";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CAA10E3BD
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:38:28 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so49049205e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778755107; x=1779359907; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nitUXTwczWASa+N4nk3OM4knbU1wDNvKAJHSRzcwWjc=;
 b=gq9O/3HCOCXFFWWWJsUNhUe2j2+dc92BlMAhWXfjfd8tf9Wdf8yAk6vCGeLdA9wFz5
 KbW3V7uIrblFRe/mJS5UiFAOLnT4cEDxvxelxDWPSXWLX5cxp9LHk3dwetfC1Yl+S8uC
 z025Del13vj4hDGUpnMjIGpS1rXHeiwAh+tTMMFkRhsKfAXkv9zVfGtTX/Wu4k+CDg2Z
 +g4SnKP5T+E25DXIAier7VAmh8LNfjpPKkzrWxNadBHZDTGx3WkTkHXvDuGsL5zV6dnp
 6Bd041tZVMy/e4y0kGmSdMavPBcCpp2RP5gU8XTjQpQiHOkAh51JEo3gmTWUCk1NSr0T
 l+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755107; x=1779359907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nitUXTwczWASa+N4nk3OM4knbU1wDNvKAJHSRzcwWjc=;
 b=fkx8c882Yid08ezNFOHEM3CAevd7SueIsrL3d87y8rEcAKk3w228Rusbz7vEhrQPZC
 PZkWBriFNrqU53piXzFTXr+xn4wvTd1/dy+rkiBZT+kyGi4urxYpBHGozSdMwcIj0XCL
 qLZiDKCHXolo0WPcms5gahX29nsBzfPXMhJN4gQS+lxascW0OETTyGiG31sOG8XaCncK
 JJ6YSvq3V6pZB6AGAM2rozqK79uBFURwrMe7TUyAarXbCNE0xHdFqP5c/cOahpTweo1f
 kqFHul69V5GOX4UlaRGBCPukAjYwFMkEVJnwOKUZv8KkkNdntfTt2rXDSNMEhk+qVZVM
 BFqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xMKdvwzoA15zywYoSdignPV2CYUy7y9XVfgvw5z1mRqRlUPanvHE6dGdHxVJpVC8zyaCCVv+8ztI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwV2HEEOAp4TYNC8oirJ53QH58Y+OOr9iFyWd2dI6856oKnPniT
 AZnHoQi81TU9O6Y8hh2wN6BJXS/CHIeB3nxFR/BN6GHewgjG87dYt2F/w9QGouvjIZE=
X-Gm-Gg: Acq92OGXcaEcvUiHIVbhiD1G+Ptun/KNq40CpuBgWfDnPZd9XXmQ3wImuagY+NpWO1k
 RAch/Ia3GtqR9AfLvm7W5Ln85wuH60JlegBdGmREpHZmDZM4gP5Go36XTnnMKmgm56i+A+i8M3X
 tDHV11HbZTqQs3gxC2iyZAcrPXIbCEeR1sXg0+VwaAhgUY22BPbDpq/1d1cWa9+Tmf4VVku6euh
 UaYRJD/fQ0Omx1AMs6BRjrsommJ4JJfhNAanhoo5A6XZEVCGrrgoBZcemwNlxmvw0ouPmbxf04g
 3cjMryqgMRXb8woJuhED6zE8kofP9h5dUjXujPhdOSVMZnrddlaeaJqTNTs8kGqlVUIj/xUKVSp
 KCWet1dEsp8ZPgdmO2wTgBhwRxhzdF5SYKUd/HdK4FNRI7VT6iDxJfDmAxxinG5CDu/mab0eI6B
 QWeNv75WnFhEj44hNpE7Ou3P97cP0dKSjFXc65Meh2vUwLkvro54cXS1oDWA==
X-Received: by 2002:a05:600c:1990:b0:48e:75fd:9f9e with SMTP id
 5b1f17b1804b1-48fc9a3e58fmr99666465e9.20.1778755106750; 
 Thu, 14 May 2026 03:38:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64e2132sm57788365e9.15.2026.05.14.03.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:38:26 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 2/2] drm/amdgpu: Replace use of system_unbound_wq with
 system_dfl_wq
Date: Thu, 14 May 2026 12:38:09 +0200
Message-ID: <20260514103815.190628-3-marco.crivellari@suse.com>
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

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index d386bc775d03..0811593fca7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -586,7 +586,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	 */
 	adev->coredump = coredump;
 	/* Kick off coredump formatting to a worker thread. */
-	queue_work(system_unbound_wq, &adev->coredump_work);
+	queue_work(system_dfl_wq, &adev->coredump_work);
 
 	drm_info(dev, "AMDGPU device coredump file has been created\n");
 	drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
-- 
2.54.0

