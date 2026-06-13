Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1951CCD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7042910EC9F;
	Sat, 13 Jun 2026 06:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JoO9ZAsR";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1266410EC9F
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 06:58:37 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso14412765e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 23:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781333916; x=1781938716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKXNGySjUJiX6/3GllpQ7O9YCp87EzXF/WJp8p9p0Qc=;
 b=JoO9ZAsR/f6BKnatuPXLmHj8jdzPsQcp33oT6m2HH4BtnrT37eIPE8Q4MCb7nj9H8V
 60tmndDuoZfFitgk4hHWsF3ojS/LCzUeQU0EYevGfVYOCBnH8bVdlhuBB9CmvtF5h5Rl
 My0mfjq2Ku6iWrk/I0Wacp2mOwSPsTGb1bAKoheZ6mCKSr38HEaQV3e9+spSDK5YnWyh
 s1aQN4riNuajIDSBZT6Str5tIDYTEmWM/v11u2QB2AhN1sb9SF+ciDnSt7ZZxYP4uzTh
 E08LuI/CV9BLXfGGsahxiT2mKV78ANI9fn94Ohpz6Kn9pH804gsnkDrej/K1rVDf3PB5
 yp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781333916; x=1781938716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VKXNGySjUJiX6/3GllpQ7O9YCp87EzXF/WJp8p9p0Qc=;
 b=Ro3OfF6HdV4OyHOEPEOJGB17Tq/DSnjTeABNddBOCjrHjpaag9mB3z2JWXNjEIpJqf
 GAm/YnT26rJ2dJ49IyEiBhl5LzAY05LMhmrM1G01VH+wxPndDgLt4PpyKq+Z9QNxH1jS
 K1Q7jC+rSE228kS5OkSTBWNXgMsrVLQrcs7Y7964YY5FJ6xwW1zm7feULYPC49MamUkd
 rNYAN60+U/dCyp4SqkD8aJS5OzBPEJOtqrZ9X9y2Qo4/U8UKI1SrlGVMBAdSCCjLFivq
 NFAhcnapvDYCJyJLncbaNSTYh49YyJCYJSW7qqbLS5uDwQpnl7MCf85lGVM0MzCvSNuV
 okvg==
X-Gm-Message-State: AOJu0YyP8GAXZRza8yUj+nSLq4LoDtmXEtCjM7Z/l9TrKTZX5ynL/zS8
 82PGuGDxFIEaGk5QDMezi01C4ZFB2plP04hUWozE4xzw4qdT/FaRs3LB
X-Gm-Gg: Acq92OEptzRN7Rllm2+qPLrCFd0OdZXwHrumDUKLxzvagOUJ77/Uexmktyh6fpUR3Ws
 zcD5oQGQK9/uha2z7qIEcD7mqLBA3PGCbe3EQDMrEjoJmlfbuF6utkLgFgaIBIbI7dPRt31bCaL
 AoAOCZkFDF8aIrO0wGIDIzuipKGcnrzgoDdcF96KKU9bnhqIZxzOIpJ42ndmwavpn3XnyfCQnu/
 dwG7bJHGQd/eVi/f7SV1+fVSs5nAM/mge9sksSYZIHHQLIj1y59jM0sARWBXx5yCtLz0Ib41TfA
 CfiO5YkTHpGyJFAkX1u4SMa0OKf5nEPv/fUU8zxR4eTl0dCi/jJQaW789Z7Mi8bYg0RL5El1LPK
 P0Oiu/EGFLFroCMBj3h32q2eAd4QhhXaQjvNrYSm7AqzAeS3RN8XHLaq/tlZpPHHqMlarHhZuzu
 sNvStlVlgkerUcD08THsvuycJvVkCvZmLyDLmItPnjASzW9sqqwRb+
X-Received: by 2002:a05:600c:6287:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-492200516d4mr27804035e9.8.1781333915366; 
 Fri, 12 Jun 2026 23:58:35 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 23:58:34 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xxm@rock-chips.com,
 chaoyi.chen@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, jonas@kwiboo.se, Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 4/9] accel: rocket: Reset the NPU before detaching the
 IOMMU on timeout
Date: Sat, 13 Jun 2026 09:01:11 +0200
Message-Id: <20260613070116.438906-5-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
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

From: Midgy BALON <midgy971@gmail.com>

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

