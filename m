Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F308CA5FDD
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F3F910EEE3;
	Thu,  1 Oct 2026 22:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iEI2WB5C";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 451E410F545;
 Thu,  1 Oct 2026 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790892401; x=1822428401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s6ONHpc3kyNJlFqJhHIWVmku7fpp5RWYhuz+gzqKsS8=;
 b=iEI2WB5C5gcN+sxscHtfi3QeLwIfgbjrVQsyHF0TQOG7GybbmZm5l0Sn
 QekwCVUWfS59Z48lG9mOZVSegPpxe6kFc75HH9MNHM/HAvgiE8W4kCPyM
 qlqUrGxkjFeN7dQM3aJVdqyVtTbfv+t1TrjAXuTVdDrZQtDcXB4A5Apnk
 mAUEZOSTSYrhHwohQabg0MzqVy7tScTcZQMzla+pBUKP7S96Z7BmCWgGn
 Zlplw/fL1eC+ZzmQQTketp4VQRleXEAsc0T483zMz9OCC3vdABePxATiZ
 +IunS9n/pCqJYajfd+iLaJkrg5FYfG7w+lfJLZL+GmAi4pN/bptBSj0pP w==;
X-CSE-ConnectionGUID: I0c7D9udS5OehiDA76Q6Fg==
X-CSE-MsgGUID: 9Sy9D3lBQMWC+yQABvBU6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91526854"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="91526854"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:06:39 -0700
X-CSE-ConnectionGUID: Hfq6XexbQc6RAvToOBE25g==
X-CSE-MsgGUID: pzb4RZRLTRyIlJCCyMTaVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="274190026"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:06:38 -0700
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
Subject: [PATCH v3 5/8] drm/msm: use DRM_GPUVM_RESV_PROTECTED for VM_BIND VMs
Date: Thu,  1 Oct 2026 15:06:29 -0700
Message-Id: <20261001220632.3190896-6-matthew.brost@intel.com>
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

msm_gem_vm_create() creates every drm_gpuvm without
DRM_GPUVM_RESV_PROTECTED, on the grounds that it makes
drm_gpuvm_bo_evict() lose track of evicted external objects. It does not:
drm_gpuvm_bo_evict() still sets drm_gpuvm_bo::evicted on an extobj, and
drm_gpuvm_prepare_objects() moves any such extobj onto the evicted list
before drm_gpuvm_validate() looks at it. The VM_BIND submit path always
calls the two in that order.

Userspace managed VMs already touch the extobj and evicted lists only
with the VM's resv held: VMAs are created and linked by VM_BIND under
the VM resv, msm_gem_vma_close() asserts it, and every drm_gpuvm_bo_put()
which can drop the last reference of a VM_BIND vm_bo runs with it held,
via msm_gem_lock_vm_and_obj(), with_vm_locks() or the object free path.
The internal spinlocks buy nothing there, so set
DRM_GPUVM_RESV_PROTECTED for those VMs.

Kernel managed VMs are left alone. The legacy submit path holds a vm_bo
reference per BO and drops it in msm_submit_retire() with only the
object's resv held, which could be the last reference once the VMA is
gone. VM_BIND contexts never get there, the previous patch having made
MSM_GEM_SUBMIT reject a submit_bo table from them.

This is also what two pass locking in drm_gpuvm requires, which a
following patch makes use of.

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
 - Rely on VM_BIND contexts not being able to pass a submit_bo table,
   now enforced by the previous patch (Sashiko)
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 1badec3caa7b..c2b2415e86c9 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -818,11 +818,19 @@ msm_gem_vm_create(struct drm_device *drm, struct msm_mmu *mmu, const char *name,
 		  u64 va_start, u64 va_size, bool managed)
 {
 	/*
-	 * We mostly want to use DRM_GPUVM_RESV_PROTECTED, except that
-	 * makes drm_gpuvm_bo_evict() a no-op for extobjs (ie. we loose
-	 * tracking that an extobj is evicted) :facepalm:
+	 * Userspace managed (VM_BIND) VMs only ever touch the gpuvm's extobj
+	 * and evicted lists with the VM's resv held, so use
+	 * DRM_GPUVM_RESV_PROTECTED for those.  drm_gpuvm_bo_evict() cannot
+	 * put an extobj on the evicted list there, but it records the
+	 * eviction and drm_gpuvm_prepare_objects() moves it onto the list
+	 * before drm_gpuvm_validate() runs, so nothing is lost.
+	 *
+	 * Kernel managed VMs keep the internal spinlocks, since the legacy
+	 * submit path can drop the last vm_bo reference with only the
+	 * object's resv held (see msm_submit_retire()).  VM_BIND contexts
+	 * cannot reach that path, as they may not pass a submit_bo table.
 	 */
-	enum drm_gpuvm_flags flags = 0;
+	enum drm_gpuvm_flags flags = managed ? 0 : DRM_GPUVM_RESV_PROTECTED;
 	struct msm_gem_vm *vm;
 	struct drm_gem_object *dummy_gem;
 	int ret = 0;
-- 
2.34.1

