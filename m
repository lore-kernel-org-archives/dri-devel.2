Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C34FF60EE
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D8410EA3C;
	Tue, 31 Mar 2026 09:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ENVVw76M";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC2410EA35;
 Tue, 31 Mar 2026 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774948861; x=1806484861;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wtLD7RzGGtUF5HRqMN10l/cSDtJ8iDS5SncsgRFTjYM=;
 b=ENVVw76MCu7Jgf3oJV8/5DUwWXtNryPLjB6A/VlpPSnviT5pWIBL7+iZ
 HtXErcriVbboMnMYxD4L1RcbaL3AIbcAC3u6Hc9CZUMb5OcWa3+o7GQIR
 09my8FxQyaklgPTK7s6PfBkb7fdOhqhZSBEswGnz3hmBUsA4SAhoS5u5k
 AlpVXg9II6tfaOAdxiW9UrsKVlVWL23L5dH/qutXnvbQuB+fxBabW6YEn
 2zb+Wm/y0Vm5QSgvQbCLk8Ms2nE5bEbCjMOUgzZNI2Njboh9Fd35Qcx1j
 M4R7tgaXB52z8M1kdCYDn3v4sameP9qyzkyTr6DNdt512gH8ha3hqYccL Q==;
X-CSE-ConnectionGUID: zkBv744pTeGKQV0xL2QsYw==
X-CSE-MsgGUID: uLNn18ORR1ChGi70aaaYOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="74988519"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="74988519"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:21:00 -0700
X-CSE-ConnectionGUID: kxIufajmTEyw3r7qxrGStA==
X-CSE-MsgGUID: o3tm2YXcSJGR1mlm/jahqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226288531"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.28])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:20:56 -0700
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
Subject: [PATCH 2/5] drm/msm: Remove abuse of drm_exec internals
Date: Tue, 31 Mar 2026 11:20:20 +0200
Message-ID: <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
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

The code was reading drm_exec internal state to determine whether
the drm_exec structure had been initialized or not, and therefore
needed cleaning up, relying on undocumented behaviour.

Instead add a bool to struct msm_gem_submit to indicate whether
drm_exec cleaning up is needed.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/msm/msm_gem.h        | 1 +
 drivers/gpu/drm/msm/msm_gem_submit.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index cb32093fda47..762e546d25ef 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -452,6 +452,7 @@ struct msm_gem_submit {
 	bool bos_pinned : 1;
 	bool fault_dumped:1;/* Limit devcoredump dumping to one per submit */
 	bool in_rb : 1;     /* "sudo" mode, copy cmds into RB */
+	bool has_exec : 1;  /* @exec is initialized. */
 	struct msm_ringbuffer *ring;
 	unsigned int nr_cmds;
 	unsigned int nr_bos;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 75d9f3574370..26ea8a28be47 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -278,6 +278,7 @@ static int submit_lock_objects_vmbind(struct msm_gem_submit *submit)
 	int ret = 0;
 
 	drm_exec_init(&submit->exec, flags, submit->nr_bos);
+	submit->has_exec = true;
 
 	drm_exec_until_all_locked (&submit->exec) {
 		ret = drm_gpuvm_prepare_vm(submit->vm, exec, 1);
@@ -304,6 +305,7 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
 		return submit_lock_objects_vmbind(submit);
 
 	drm_exec_init(&submit->exec, flags, submit->nr_bos);
+	submit->has_exec = true;
 
 	drm_exec_until_all_locked (&submit->exec) {
 		ret = drm_exec_lock_obj(&submit->exec,
@@ -523,7 +525,7 @@ static void submit_cleanup(struct msm_gem_submit *submit, bool error)
 	if (error)
 		submit_unpin_objects(submit);
 
-	if (submit->exec.objects)
+	if (submit->has_exec)
 		drm_exec_fini(&submit->exec);
 
 	/* if job wasn't enqueued to scheduler, early retirement: */
-- 
2.53.0

