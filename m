Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C9CC61DDA
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AC110F01E;
	Thu, 27 Aug 2026 12:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Du3sDW4n";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A336810F018
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:49:22 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so19136235e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787834961; x=1788439761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3CHxWs/Md4mrbf4xKUbJKKgRpO4/sfgLi1L7Ppk/eX4=;
 b=Du3sDW4nEH+nZlbBm1/dnFG3Otmv9JAbOjHCTZt270Xs8FSAQ7YWZQw2NRpe0gt5Xo
 88/T5d4OIR72B5ctFfpaUBBnFJIjyJyv2hK/egYUWQKMhpTkc3asGpNCwEzX8WJuCUto
 iUB/N93yQbYpxpM3466C1n1nVOvjaunWGHEVL9Bt6+BEWcuhcl6Fx7P649v/gv9p6ezO
 cklflpmh+Zbq5MLFnHSIac9BwI58+9Fo3ZZOf/SJwGK6xzwGf8joZQrPdHAJI7VwA6eD
 4Du3Pj/sH2wbTGCv2Yny2L8NkCk8AWGMJP4IJI0aCsXaX9QJOI9C9oUlkUtbYl35uEDc
 T6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834961; x=1788439761;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3CHxWs/Md4mrbf4xKUbJKKgRpO4/sfgLi1L7Ppk/eX4=;
 b=bLJk3ErC5k+wCX7eGUiIkFxu7MzV11vcF3K9xV5v76kN8ans25AiebQeKvoSlB5VFU
 5YgU6yZ55P2obX/Fr7B+1BRhOmjsQZq+XEslRiuxA9o0CutOh1gHfjpVejxuXP+344/O
 vojKii17YShc5c7T1SdSl0o5K8bXcaZekjpadhox4ZP+lw8H8XGv/4ETxWkD/IXuKWas
 qd5mjzahL6pJmJZ9PX4R2MZt6W15k+sBjHWVEAB296nYFlrZgqGfkg7q5zM8Yfv35YYe
 ZVP/HMLvo51Hlx7l9zmA1zay/VaR6vsuISbiz9S0WjvZuvGod335Ahxm49qIR+z0If9v
 R0Bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RraLx37TX3AC4vXOzYdqBh10KJBOFlk9C5/pRxq1I1fiUWykRA7EITsuQPZ2MmieDsSxlQep18T4hQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mc0AJOuN3rvHJ8dxGAXkO5xDzHzr/DU1dFwItch/VNQCwlHQeW
 ojuXF9hh6FWIG+p/5Z6eLeuH/qOwmIgeBEhj544F908z1Ysnzy+pRHe8
X-Gm-Gg: AR+sD122yFbijXPkvRt1VQbgKEH0v52vAPNcGTWr2MJsOJtjrkvGcguBDMGU7A4TTIV
 bKS0a2l0pMQm+nCA/qUiy5tKr1wg/h85V+SKXvW2Ss+h8fvbnTlEIpdMmFfg1u2yNj1sa/TSXnk
 M3bOwDks1JD4tZjpKQNvtwchrLj8YeTjTRUFobseCWZrLxjcOx4joIsnCRFO+5A/d/ZFyMKvWF8
 HCjyAJgLk5dftUFH7ovoZJl0qqhTm9EaoH2vBH2Zp0d9w4+gjKI0bE6ccGnPpN6ILsv7ehzDRnJ
 fGWBDDDEceb9PuLkybMFp1TK0OEwlGqAujsg52TIBfOsFnDFWRM4SbId3gl+gLVv7H+BSY0/iIj
 75E6vEmFbtKZEq51He5GYOky1qwJXEYgVuXAi1/qLNtiDmvaSJqwtOFRAOOsBZ9nSG02rzTmPzu
 SJfSEIbUc7WLPtUNhU8LzfMmp2HPwrKYbu0V7fdZzrR6x7+tLTnDne3jrAuo2CDjLXbG8hlNLuy
 IXBcqJ3iaNxPg==
X-Received: by 2002:a05:600c:4fc7:b0:499:dbae:86be with SMTP id
 5b1f17b1804b1-499dc72675dmr173963305e9.14.1787834960864; 
 Thu, 27 Aug 2026 05:49:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1524:4300:a4b8:720e:f64f:4778])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b465226d8sm52089985e9.0.2026.08.27.05.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:49:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/10] drm/xe: Use dma_resv_alloc for lockdep annotation
Date: Thu, 27 Aug 2026 14:38:55 +0200
Message-ID: <20260827124910.2245-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827124910.2245-1-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Replace the stack-allocated dma_resv in xe_pm_runtime_lockdep_prime()
with a dynamically allocated one using dma_resv_alloc(). This aligns
with the move away from embedded dma_resv structures and towards
reference-counted dynamic allocation.

The lockdep priming function is used to establish lock ordering
dependencies between runtime PM and dma_resv locks. The resv is only
used temporarily for lockdep annotation and is immediately freed after
use with dma_resv_put().

If allocation fails, we silently return since this is optional lockdep
annotation that only affects dependency checking, not functional
behavior.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/gpu/drm/xe/xe_pm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 99562f691080..33b19bcb6f71 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -762,15 +762,20 @@ static void xe_rpm_might_enter_cb(const struct xe_device *xe)
  */
 static void xe_pm_runtime_lockdep_prime(void)
 {
-	struct dma_resv lockdep_resv;
+	struct dma_resv *lockdep_resv;
+
+	lockdep_resv = dma_resv_alloc();
+	if (!lockdep_resv)
+		return;
 
-	dma_resv_init(&lockdep_resv);
 	lock_map_acquire(&xe_pm_runtime_d3cold_map);
 	/* D3Cold takes the dma_resv locks to evict bos */
-	dma_resv_lock(&lockdep_resv, NULL);
-	dma_resv_unlock(&lockdep_resv);
+	dma_resv_lock(lockdep_resv, NULL);
+	dma_resv_unlock(lockdep_resv);
 	lock_map_release(&xe_pm_runtime_d3cold_map);
 
+	dma_resv_put(lockdep_resv);
+
 	/* Shrinkers might like to wake up the device under reclaim. */
 	fs_reclaim_acquire(GFP_KERNEL);
 	lock_map_acquire(&xe_pm_runtime_nod3cold_map);
-- 
2.43.0

