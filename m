Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADBDC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 682DC10F288;
	Fri, 14 Aug 2026 07:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="psUKvRik";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9245310E295
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:22:14 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cc97653887so10281215ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786627334; x=1787232134; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TVWNuYas/MOMOGJWvOzXANfSQQ0qHMRR18n7cjmi/E0=;
 b=psUKvRikaZZsYEUaDBDEhGV/0URMzVEttvow+OHvIkYba70HjiSIBwH2Fk84JrP7rp
 vd48Gy960wCeVnbOw4eddCBc2E9APvO31f1KO+4eLgp2ZGMfRwmRwz9o5h0Jf5CGk21U
 KFQFbw0Recq89/7QVwsKgMg124AlKKtqnBjlxICaXac7Q30gso1lyHcx3nUVM0qn9Fth
 dydy/ZSa8qNQmypAp6Whfhmh9x0pPZQo9fTNwp4QoF0bBzPyBdBYyoWuclEg5bznb4WI
 /sd7pPnbHLyKrIWMY85BI7M+saDUR38ivzS5qIRYysp3IFK7X6QtfvayBM7Pi4fQHse1
 K0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786627334; x=1787232134;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TVWNuYas/MOMOGJWvOzXANfSQQ0qHMRR18n7cjmi/E0=;
 b=LasTtSFnS9LZhXk+30hc9oByC1kOBFqQ8zl6v/Y9czxBODuUIbkAa6/ulDWzuIy1IV
 QjOh+YhO5quOCpMXbIoefFo41dJssSrPDraMdaWTzqElZiGPToCZaXXn2ScG14n3HNsn
 ad12LCCXNq+w3EakafLfL0FyiIidmvm55H3Zs+cJbc5dHgddHe2ifFdg6ibYvgOpzMvO
 lN3lWVZbhvf0BYqzcv+fEuQNi6JcAxdirAtXLMyvp1662RUZ8ELcTj+P00bOjDRBwDu8
 9Hj6dIoV0ijwc6hQhr6kixUUPJghSAe3Dy5/aMxFPBlJd9+lNvgpSDguMglvcx6he9KF
 UeAQ==
X-Gm-Message-State: AOJu0YxJcqZL8BhcaX6KH/Lgmg5g86qxRq3duwEGhXv4L+MTz+tISQOM
 ZIQrwBISmcFRcHIE0Z81nuy4KwwTGsioRoc7SUHeM7mt7atoUnTouvWf
X-Gm-Gg: AR+sD10iuVpsqQLlj6I9hzxJXVSs4LYjWMKQBNGlRlyXYGtw1wcmwbfVaeHWEnywHW/
 HhXO/WgRgFp04kF33LY111zCdMGEAhOgs04YoJo4NBEDrWdJzq4DZXITmb8+v79zx0ekd1NUzjc
 frA1IPhEUTHtJpq4J1lXgvBhf+YKD/nCHtttDoVoqAWmr6a8BQ+LxP7eJrD1duWv2K7ZtnEujRO
 vQKi3vM4/+ftA4s7QgV5zD1+0SHCCryBifmMz+hdAarEH2WDYj33bvRLE93tW3Yf/+y7FhKxtGI
 +ePy7dle8Pw1IpsBARJTrA+O9OfsN1TH09trAWVxeZrrAavWc+8rZeWX0SV0QZ/i5vJWhSpVt4g
 o5t59jd7ya8zS4N+m4r7l33EwMSRTMWAKD5vNRruaZujtmiclRmM/d2tr2mWDxWWBaSoHn3lkXy
 PKzNQ4Rl/f5Vy8DcRFs6naZsSRAil0qshaEF5I+2V4KZ108KYPTIqxfhdrfG0=
X-Received: by 2002:a17:903:468e:b0:2ce:7563:70a5 with SMTP id
 d9443c01a7336-2d37d577d92mr68447035ad.6.1786627333851; 
 Thu, 13 Aug 2026 06:22:13 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d37c4947cfsm9509705ad.65.2026.08.13.06.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:22:13 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Thu, 13 Aug 2026 21:21:42 +0800
Subject: [PATCH] drm/nouveau/svm: drain fault handler before freeing svmm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nouveau-svm-svmm-uaf-v1-1-2d3112dea734@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOXEfWoC/yXMQQqDMBCF4avIrDugEYP0KsXFJE7qFIwl04SCe
 PdGu3iLb/H+HZSTsMK92SFxEZUtVnS3BvxC8ckoczWY1th27HqMWy5MGbWs51bMFNA5H3pr7EB
 EUK/vxEG+V/Yx/a3Zvdh/zhYcxw/7gCVYeAAAAA==
X-Change-ID: 20260813-nouveau-svm-svmm-uaf-bbcf36265aaa
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786627329; l=2616;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=MkqdAWdWz0lutQb8l1T1yO7gmyXKQ04Cgj/5wL4FwHI=;
 b=yWyApmq3N/iL78hHvscIOIj2yoIsiORxcfjfAjWEf97XuifNnsE4SSw4ljisawH+utDwbmttv
 3Ei8K0VW84RAFRxr9ixUgqc/R/yxG9hg5HPCQE6XMJo06un1mFjA9V1
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

The SVM fault handler nouveau_svm_fault() looks up each fault's
nouveau_svmm from the per-device instance list under svm->mutex, caches
it in the fault array, then drops svm->mutex and dereferences the svmm
across blocking faults (mmu_interval_notifier_insert(), hmm_range_fault()),
taking svmm->mutex and touching svmm->vmm.

nouveau_svmm has no reference of its own. It is freed on DRM file close,
via nouveau_svmm_fini() -> mmu_notifier_put(), which frees asynchronously
through call_srcu() without waiting for the handler; svm->mutex is not
held during the dereference, and mmget_not_zero() pins the mm, not the
svmm. A fault handled concurrently with a close can therefore dereference
a freed svmm. flush_work() on the fault buffer otherwise runs only at
device removal and suspend, never on the per-client close path.

The instance is already unlinked earlier in the same close, by
nouveau_svmm_part(), so no new fault can resolve to this svmm. Drain the
fault handler in nouveau_svmm_fini() before the free, so any handler that
cached the pointer has completed. nouveau_cli_fini() already flushes
cli->work here, and device-scope teardown already uses the same idiom.

Fixes: eeaf06ac1a55 ("drm/nouveau/svm: initial support for shared virtual memory")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..01191b126be5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -304,6 +304,17 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
 {
 	struct nouveau_svmm *svmm = *psvmm;
 	if (svmm) {
+		struct nouveau_svm *svm = svmm->vmm->cli->drm->svm;
+
+		/* The fault handler caches svmm pointers looked up under
+		 * svm->mutex and then dereferences them after dropping it,
+		 * across blocking faults.  The instance has already been
+		 * unlinked (nouveau_svmm_part), so no new fault can resolve to
+		 * this svmm; drain the handler to release any in-flight
+		 * reference before the svmm is freed.
+		 */
+		flush_work(&svm->buffer[0].work);
+
 		mutex_lock(&svmm->mutex);
 		svmm->vmm = NULL;
 		mutex_unlock(&svmm->mutex);

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260813-nouveau-svm-svmm-uaf-bbcf36265aaa

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

