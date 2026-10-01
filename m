Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE7FCA5FE1
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BCF10F15D;
	Thu,  1 Oct 2026 22:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZuSDbCZ3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6300A10E90D;
 Thu,  1 Oct 2026 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790892402; x=1822428402;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nShlwXN3ugnLH6PEjrBBAK63VVeVaCaBg/2DmPXujvY=;
 b=ZuSDbCZ3RCOpqRb352gTPe/bEmcqUtmU8uV9j81lWqAhx+zPVWPf7wcx
 5NXzomeIEWvIO8Bak5kWZQT8EJ0v+jaA1t37fs3gMUUu8V7Q33a+lAsMa
 Tc0hNiVr1m5mKim0etNiTcY3U0GX8781WgYWE+p3v+X6+cxxeqnarpC08
 JLeE+pcm6uSXKPTTGQ+8kcgZnLPU7bv9geI8mRrKL5UG29Nf8qr4lkY3x
 xeEakXfV5vWbe+XBswW8iU618FI+ezahvv4IUb9avw4z/8NvV9EO/6+cE
 2cndt2G2Mv2LjflJO8mWCqX5Y4Hx8fLhR4p/Czgac4EkzoinPrcW+quwB Q==;
X-CSE-ConnectionGUID: kozaVphJQeygN+qJMkPQEg==
X-CSE-MsgGUID: 8RMgdHYMSAS/7vq1D33D4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91526901"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="91526901"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:06:39 -0700
X-CSE-ConnectionGUID: EVoH8hZLQmOkrzcczCffOQ==
X-CSE-MsgGUID: CZ7be2fDROOrygK9oWL/zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="274190036"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:06:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Liviu Dudau <liviu.dudau@arm.com>, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 8/8] drm/nouveau: lock the resident BOs of an exec last
Date: Thu,  1 Oct 2026 15:06:32 -0700
Message-Id: <20261001220632.3190896-9-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001220632.3190896-1-matthew.brost@intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

nouveau_exec_job_submit() locks every BO mapped in the VM, then
validates the evicted ones while holding all of those locks. A client
paging a large working set back in therefore keeps the dma-resv of every
BO it shares, e.g. with the compositor it presents to, locked for as
long as that takes, stalling the other side for no reason.

Use the two-pass locking drm_gpuvm now provides. Validation moves from
after drm_gpuvm_exec_lock() into its per-pass extra.fn callback, so the
early pass validates the evicted BOs while the resident external ones
are still unlocked, and the late pass locks those and validates
anything that was evicted in the meantime. drm_gpuvm_exec_lock() falls
back to a single pass when nothing is evicted.

Validation now runs under the uvmm mutex, like it already does for bind
jobs in bind_lock_validate().

Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Antonino Maniscalco <antomani103@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Steven Price <steven.price@arm.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: LLM
---
v3:
 - New patch (Danilo)
---
 drivers/gpu/drm/nouveau/nouveau_exec.c | 27 +++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
index eea6619cffaa..b9ab7da125b1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_exec.c
+++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
@@ -85,6 +85,18 @@
  * the corresponding VM_BIND jobs they depend on - attached to them.
  */
 
+/*
+ * Called once per pass of drm_gpuvm_exec_lock(), validating whatever that pass
+ * locked. The early pass validates the evicted BOs before the resident ones
+ * are locked, so that a BO shared with another client, e.g. a compositor, is
+ * not held locked while this job's evicted BOs are moved back in.
+ */
+static int
+nouveau_exec_job_validate(struct drm_gpuvm_exec *vme)
+{
+	return drm_gpuvm_exec_validate(vme);
+}
+
 static int
 nouveau_exec_job_submit(struct nouveau_job *job,
 			struct drm_gpuvm_exec *vme)
@@ -99,21 +111,14 @@ nouveau_exec_job_submit(struct nouveau_job *job,
 	if (ret)
 		return ret;
 
+	vme->two_pass = true;
+	vme->extra.fn = nouveau_exec_job_validate;
+
 	nouveau_uvmm_lock(uvmm);
 	ret = drm_gpuvm_exec_lock(vme);
-	if (ret) {
-		nouveau_uvmm_unlock(uvmm);
-		return ret;
-	}
 	nouveau_uvmm_unlock(uvmm);
 
-	ret = drm_gpuvm_exec_validate(vme);
-	if (ret) {
-		drm_gpuvm_exec_unlock(vme);
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static void
-- 
2.34.1

