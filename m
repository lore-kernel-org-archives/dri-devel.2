Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A26CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2042D10F008;
	Wed, 20 May 2026 10:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J+OQfKQi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C98810EFF7;
 Wed, 20 May 2026 10:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779272242; x=1810808242;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Eyqg+cXE3zQi+HGwpHNc4vqhQE2TgtWXcssaKXnp8L0=;
 b=J+OQfKQigk92ozm/BSHbO8Kbvp0SGSo1Y29Zr0fM7EgYQ0i7KAj7HAE8
 1tpsA/z4yH3UNmVpbv2nO1kHqb/LjrLxspMkQRpDXnjG2ctAtYqaKhN0+
 E/czi/o2vnS7O1wbtRSZUfkiBcrLaSjCiTY59TeaE0m4iEuBEZvac+CdC
 7E8UP1EfliwobCf1w0OZ578zmb+DFKvcVaZ8KdmOAQqgj1ysUUyXmI2x4
 3lUJjyYSBSQpJ4YXBNmK6ev19YEjSwDtIrpJ2BvtjpjyiWqoiwXc846GV
 r4uUjKl3bnRrqXTTFqOQPj/Fn4qSphmU0RjHvq1g02TNnTQdT9aAmF4ft Q==;
X-CSE-ConnectionGUID: wQ1NiPQmTyqFBox8HcHBUA==
X-CSE-MsgGUID: 5NeTvn8oTOGrGF5JnEtnsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="102843291"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="102843291"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:17:21 -0700
X-CSE-ConnectionGUID: ieDKYrn4R0WJGtIaIh7CfA==
X-CSE-MsgGUID: 0Qjo2TgJQcCyXtlrUbycng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="244114093"
Received: from vpanait-mobl.ger.corp.intel.com (HELO fedora) ([10.245.245.175])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:17:17 -0700
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
Subject: [PATCH v2 2/4] drm/exec: Make the drm_exec_until_all_locked() macro
 more readable
Date: Wed, 20 May 2026 12:16:14 +0200
Message-ID: <20260520101616.41284-3-thomas.hellstrom@linux.intel.com>
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

Use __UNIQUE_ID as done elsewhere in the kernel rather than a
hand-rolled __PASTE to craft a unique id.

Also use __maybe_unused rather than (void) to signify that a
variable, althrough written to, may not actually be used.

v2:
- Move assignment to declaration (Christian)
- Declare the retry pointer as void *const.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/drm/drm_exec.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index dee6ebdbe416..18f84faabbb9 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -95,6 +95,17 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
 #define drm_exec_for_each_locked_object_reverse(exec, obj)		\
 	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
 
+/*
+ * Helper to drm_exec_until_all_locked(). Don't use directly.
+ *
+ * Since labels can't be defined local to the loop's body we use a jump pointer
+ * to make sure that the retry is only used from within the loop's body.
+ */
+#define __drm_exec_until_all_locked(exec, _label)			 \
+_label:									 \
+	for (void *const __maybe_unused __drm_exec_retry_ptr = &&_label; \
+	     drm_exec_cleanup(exec);)
+
 /**
  * drm_exec_until_all_locked - loop until all GEM objects are locked
  * @exec: drm_exec object
@@ -102,17 +113,9 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
  * Core functionality of the drm_exec object. Loops until all GEM objects are
  * locked and no more contention exists. At the beginning of the loop it is
  * guaranteed that no GEM object is locked.
- *
- * Since labels can't be defined local to the loops body we use a jump pointer
- * to make sure that the retry is only used from within the loops body.
  */
 #define drm_exec_until_all_locked(exec)					\
-__PASTE(__drm_exec_, __LINE__):						\
-	for (void *__drm_exec_retry_ptr; ({				\
-		__drm_exec_retry_ptr = &&__PASTE(__drm_exec_, __LINE__);\
-		(void)__drm_exec_retry_ptr;				\
-		drm_exec_cleanup(exec);					\
-	});)
+	__drm_exec_until_all_locked(exec, __UNIQUE_ID(drm_exec))
 
 /**
  * drm_exec_retry_on_contention - restart the loop to grap all locks
-- 
2.54.0

