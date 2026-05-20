Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601F7CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B70AF10EFE8;
	Wed, 20 May 2026 10:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lEOzUTDE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0108A10EFF7;
 Wed, 20 May 2026 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779272247; x=1810808247;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7GOI7TU6+aMlsbqiB2OTjv7RLHlkrx7pg0DKAoEBQbo=;
 b=lEOzUTDEf0RBQJ/AH6/DU9TfGLhAhDH+K/8LF5t/JVxvrm4cED9tPKMy
 l4V+EpOU9JR76595F5c0YBeLREG7uU7Kj5QvpJ54gDPAASKCJ4HxaACr1
 Eizgce5ASk/0lOYuDja29JFRiYV8tXelWSBD2rKl7JFm9zN4b+2Rfy3WW
 IXons5MaV55esY76fPNNt+vu5HoPOzSkTOqI8E3ARGsqyHoHHQjKFdhKD
 br8/BZ+wSGehqu4cgSBV5HEE8JlpzL+un0RVsKautRT5NihDHCwO+4t5J
 Iw5NbUUOIKpb3OkBXKsHvKCTKZG+Wz0l5OzdNiYVjLrhkX7xoV/aJ+PbU Q==;
X-CSE-ConnectionGUID: cMq42SlyTvW2NpITz793Nw==
X-CSE-MsgGUID: Bccf3vgITj2LN+mTyLvk1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="102843304"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="102843304"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:17:26 -0700
X-CSE-ConnectionGUID: 1wFTdLPSRou64nosWEr3wQ==
X-CSE-MsgGUID: 884+k//wTpqUw+cqruxgHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="244114106"
Received: from vpanait-mobl.ger.corp.intel.com (HELO fedora) ([10.245.245.175])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:17:22 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Alice Ryhl <aliceryhl@google.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: [PATCH v2 3/4] drm/exec,
 drm/xe: Avoid abusing the drm_exec retry pointer
Date: Wed, 20 May 2026 12:16:15 +0200
Message-ID: <20260520101616.41284-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101616.41284-1-thomas.hellstrom@linux.intel.com>
References: <20260520101616.41284-1-thomas.hellstrom@linux.intel.com>
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

The xe driver was using the drm_exec retry pointer directly to
restart the locking loop after out-of-memory errors. This is
relying on undocumented behaviour.

Instead add a drm_exec_retry() macro that can be used in this
situation, and that also warns if the struct drm_exec is
not newly (re-)initialized.

Use that macro in xe.

v2:
- Only allow if the drm_exec context is newly initialized.
  (Christian)

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/drm_exec.c         |  3 ---
 drivers/gpu/drm/xe/xe_validation.h |  2 +-
 include/drm/drm_exec.h             | 19 +++++++++++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 746210f3f6c2..7988f5e7d56a 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -48,9 +48,6 @@
  * See struct dma_exec for more details.
  */
 
-/* Dummy value used to initially enter the retry loop */
-#define DRM_EXEC_DUMMY ((void *)~0)
-
 /* Unlock all objects and drop references */
 static void drm_exec_unlock_all(struct drm_exec *exec)
 {
diff --git a/drivers/gpu/drm/xe/xe_validation.h b/drivers/gpu/drm/xe/xe_validation.h
index a30e732c4d51..4cd955ce6cd2 100644
--- a/drivers/gpu/drm/xe/xe_validation.h
+++ b/drivers/gpu/drm/xe/xe_validation.h
@@ -146,7 +146,7 @@ bool xe_validation_should_retry(struct xe_validation_ctx *ctx, int *ret);
 #define xe_validation_retry_on_oom(_ctx, _ret)				\
 	do {								\
 		if (xe_validation_should_retry(_ctx, _ret))		\
-			goto *__drm_exec_retry_ptr;			\
+			drm_exec_retry((_ctx)->exec);			\
 	} while (0)
 
 /**
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index 18f84faabbb9..99c7e1bb3c5b 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -9,6 +9,12 @@
 #define DRM_EXEC_INTERRUPTIBLE_WAIT	BIT(0)
 #define DRM_EXEC_IGNORE_DUPLICATES	BIT(1)
 
+/*
+ * Dummy value used to initially enter the retry loop.
+ * internal use only.
+ */
+#define DRM_EXEC_DUMMY ((void *)~0)
+
 struct drm_gem_object;
 
 /**
@@ -142,6 +148,19 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
 	return !!exec->contended;
 }
 
+/**
+ * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
+ * @exec: drm_exec object
+ *
+ * Unconditionally retry the loop to lock all objects. For consistency,
+ * the exec object needs to be newly initialized.
+ */
+#define drm_exec_retry(_exec)					\
+	do {							\
+		WARN_ON((_exec)->contended != DRM_EXEC_DUMMY);	\
+		goto *__drm_exec_retry_ptr;			\
+	} while (0)
+
 void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr);
 void drm_exec_fini(struct drm_exec *exec);
 bool drm_exec_cleanup(struct drm_exec *exec);
-- 
2.54.0

