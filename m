Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7024EFF60F1
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D634210EA2C;
	Tue, 31 Mar 2026 09:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Pq25LcCe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48BC10EA4E;
 Tue, 31 Mar 2026 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774948871; x=1806484871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DgyLq6zooOm9qWMAzGTPUEMvJ8LaOuxTIta6t6Kp+/k=;
 b=Pq25LcCex6RIG6lpsK0c9q1xaue0Wehn+f+RAtXwiFCxUjn7n9emIo8b
 8ECgSfIixb4GjWakLGhg/V8Y7EQsUd1KGvCTe/9E8x8f+M3meB5cGzCGg
 3qamX7Jl5svz19SlWnyN4OFi/gbIcMt3PwLiAb5yTZad4jALAlTw/HKsD
 UFCdorAH5a1vG3CXWC3TRFjjcc52SFqD7m4pqkcrHSWJcjK9j0ynqVhvN
 nTVoDGj7ge2bAGvnC5BPS9RoPd6FRBL/jadIfjjNn4FkF3IovKDCSSjWu
 0BpONFraiUOijZ5J3L5gvJECX7b1g2EbPkwE5Z8XMqqRwKsp9Hl5OnodK w==;
X-CSE-ConnectionGUID: AUGBbRLxQomvo0W4H/4mvg==
X-CSE-MsgGUID: mBUmKefHSuuW6N96zmpLOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="74988576"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="74988576"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:21:11 -0700
X-CSE-ConnectionGUID: bPben4aYRJiZ3+GIj+CnLw==
X-CSE-MsgGUID: RncjKU8sSmCg4jSOkIdh0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226288677"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.28])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:21:07 -0700
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
Subject: [PATCH 4/5] drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer
Date: Tue, 31 Mar 2026 11:20:22 +0200
Message-ID: <20260331092023.81616-5-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
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
relying on documented behaviour.

Instead add a drm_exec_retry() macro that can be used in this
situation, and that also asserts that the struct drm_exec is
in a state that is compatible with retrying:
Either newly initialized or in a contended state with all locks
dropped.

Use that macro in xe.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_validation.h |  2 +-
 include/drm/drm_exec.h             | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index fc95a979e253..5ed5be1f8244 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -138,6 +138,19 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
 	return !!exec->contended;
 }
 
+/**
+ * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
+ * @exec: drm_exec object
+ *
+ * Unconditionally retry the loop to lock all objects. For consistency,
+ * the exec object needs to be newly initialized or contended.
+ */
+#define drm_exec_retry(_exec)				\
+	do {						\
+		WARN_ON(!drm_exec_is_contended(_exec)); \
+		goto *__drm_exec_retry_ptr;		\
+	} while (0)
+
 void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr);
 void drm_exec_fini(struct drm_exec *exec);
 bool drm_exec_cleanup(struct drm_exec *exec);
-- 
2.53.0

