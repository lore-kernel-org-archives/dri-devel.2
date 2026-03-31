Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DABFF60EE
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F6710EA4B;
	Tue, 31 Mar 2026 09:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EJrbSYO6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71B410EA49;
 Tue, 31 Mar 2026 09:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774948866; x=1806484866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2rKU7pNuJHeLNYA2RtmGZ0yZNNZYnG3H+Xgt++Wqb44=;
 b=EJrbSYO6vb6/N7zbMAORI8UT6zq3aqS4IU1fDQjl02bh1HEdG8w5FwQG
 cYH8q1o4B+d/PqxORTxqBlYzJsisS+NDRqfwlKlCHo7jF/gs3wgEPg2dB
 bMOxS9wudRsyzd4ZtNTcU3m9QmUZdXcwFEYT+3rTHfyslmZGHLPy70Xqh
 +ogRnROQPQYG0cuLoD/Nr0u/QATg0384c1Cg6lmCLDW5w11CeV4UiwgWq
 Xc6eZ0s0jZvFNLB4qGSaV/onZeEDXGp7WAkFOdvWJwdO4IlLZ4EwM6dad
 JT0v8XE35uBk7SUT4YavJfENRu/k+F9XqwSynxmPNqE+3EAVcT+QcxK/F Q==;
X-CSE-ConnectionGUID: /Ww8YUrFSwCJT9/hef1Wag==
X-CSE-MsgGUID: OwY1VedTS3a7R5n6CAh2xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="74988539"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="74988539"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:21:06 -0700
X-CSE-ConnectionGUID: 4ye3jDkNRXuzUW7kqENdkA==
X-CSE-MsgGUID: T0FqTeu8Qj+1bT4lWUxjmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226288652"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.28])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:21:01 -0700
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
Subject: [PATCH 3/5] drm/exec: Make the drm_exec_until_all_locked() macro more
 readable
Date: Tue, 31 Mar 2026 11:20:21 +0200
Message-ID: <20260331092023.81616-4-thomas.hellstrom@linux.intel.com>
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

Use __UNIQUE_ID as done elsewhere in the kernel rather than a
hand-rolled __PASTE to craft a unique id.

Also use __maybe_unused rather than (void) to signify that a
variable, althrough written to, may not actually be used.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/drm/drm_exec.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index 25db52dd2af0..fc95a979e253 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -89,6 +89,19 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
 	for (unsigned long _index = (exec)->num_objects - 1;				\
 	     ((obj) = drm_exec_obj(exec, _index)); --_index)
 
+/*
+ * Helper to drm_exec_until_all_locked(). Don't use directly.
+ *
+ * Since labels can't be defined local to the loop's body we use a jump pointer
+ * to make sure that the retry is only used from within the loop's body.
+ */
+#define __drm_exec_until_all_locked(exec, _label)			\
+_label:									\
+	for (void * __maybe_unused __drm_exec_retry_ptr; ({		\
+		__drm_exec_retry_ptr = &&_label;			\
+		drm_exec_cleanup(exec);					\
+	});)
+
 /**
  * drm_exec_until_all_locked - loop until all GEM objects are locked
  * @exec: drm_exec object
@@ -96,17 +109,9 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
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
2.53.0

