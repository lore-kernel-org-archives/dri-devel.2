Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAA9CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F7D010F5C3;
	Thu,  1 Oct 2026 22:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H8vD6LMr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0215110F093;
 Thu,  1 Oct 2026 22:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790892401; x=1822428401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/0rpXvCEYl3M3/IjhOh69upqcQPcxCIOt5r3HdbbRyQ=;
 b=H8vD6LMrdHv4ejxy6DOq/piinTbsf6MWFvWNih9GJYXliXYh7SO1yMo3
 6Y6bVMqxIUMnpWpQgyEvCIhHy2xBXh/gnk6aBTIzfO2yFAJuamm9utw47
 AxljgQUubV5RD7IYgdjLBGH/WKu0MJM4uNvqbVC4k9Nq11On+uDqibRdL
 MduMQvv7BxOHRmDCR5iBsfzv+HqkMQhOuopGNEr2hdf6jx2C7JFUbQ8no
 l+qneVycYgDc7Zh6pqALDanPO2wJYKBCmqylPZT6NhmKYoImoa+J1TheY
 nK7F5hskjnSi/DCABDT3ZUEQoX/sZYek5fqSpf2M0LqtLT9rI/Rlqkg8G Q==;
X-CSE-ConnectionGUID: JgFfLxcESeagJx77fDa6VQ==
X-CSE-MsgGUID: fFIYfuMsRgCCXuGb2j3PNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91526839"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="91526839"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:06:38 -0700
X-CSE-ConnectionGUID: vOM17GT+QWeKWI52GJEiuw==
X-CSE-MsgGUID: 1ktvFavwSGC7o8MBrDEPGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="274190023"
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
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH v3 4/8] drm/msm: reject a submit_bo table on VM_BIND contexts
Date: Thu,  1 Oct 2026 15:06:28 -0700
Message-Id: <20261001220632.3190896-5-matthew.brost@intel.com>
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

The uapi says a VM_BIND context must not pass a submit_bo table to
MSM_GEM_SUBMIT and that one will be rejected, but nothing checks
nr_bos. A VM_BIND context which passes one anyway runs the legacy BO
handling against its userspace managed VM:

 - submit_lock_objects_vmbind() only locks the objects mapped in the
   VM, yet submit_pin_objects() calls msm_gem_get_vma_locked() on every
   submit BO. For a BO not mapped in the VM that walks and modifies the
   object's gpuva list without its resv held, and has the kernel
   allocate a VMA spanning [0, U64_MAX) in a VM whose address space
   belongs to userspace.

 - Every submit BO holds a vm_bo reference which msm_submit_retire()
   drops with only the object's resv held. If userspace unmaps the BO
   with VM_BIND while the submit is in flight, that is the last
   reference, and drm_gpuvm_bo_destroy() runs without the VM's resv.

Reject nr_bos != 0 on VM_BIND contexts, as documented. Mesa only passes
a submit_bo table when VM_BIND is not enabled.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
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
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: LLM
---
v3:
 - New patch (Sashiko)
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 5862db05297a..1215b388cb40 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -598,6 +598,12 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		goto out_post_unlock;
 	}
 
+	/* The resident set of a VM_BIND context comes from its VM_BIND ops */
+	if (msm_context_is_vmbind(ctx) && args->nr_bos) {
+		ret = UERR(EINVAL, dev, "submit_bo table not allowed with VM_BIND");
+		goto out_post_unlock;
+	}
+
 	ring = gpu->rb[queue->ring_nr];
 
 	if (args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
-- 
2.34.1

