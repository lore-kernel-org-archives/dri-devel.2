Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5ECCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 21:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BCC710E63E;
	Tue, 26 May 2026 21:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LZt6l3TV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE5510E630;
 Tue, 26 May 2026 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779831897; x=1811367897;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7Okvw+fsV9Qg1R8JgSR+HzZFPxVLT2qPwpZWC2AiPSo=;
 b=LZt6l3TVEksamkWeXISo4W0xLt5H8PYz+LmgfAVXpwFD7Jrm5S38Fozh
 7IABb0t08lIjASrFP3BfF1+cGwqcHMajBdEaJ6KxzFH5QfNcnel3IUCMo
 2cicf0ab8UuZmYpLULAvk2w/qMkjmHka4TQ/ONLSw2OTAWBaYljfH9I3D
 ZF4Xd/X/N0WVs+OwbyxgtALY5M4tHzVhL8EE6O9yufxTz5f8tKPTFoJPd
 qoDotHaN9Ihqm2FvseaAVTsKPNiatJYvPxXzV6XyIae6+kKWEGNdRTgRL
 zVFjX1Tz4G/JQoEJSgeWrlc7sDHz+oaG7wQQHJ1fooDoW2HN8yfVjQ9sY g==;
X-CSE-ConnectionGUID: BM2qPCuXSKuuMt24qJnckg==
X-CSE-MsgGUID: j1zYTLLTTkGr9RUGfdqTww==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80843897"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="80843897"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 14:44:56 -0700
X-CSE-ConnectionGUID: xkkUlb4IQuqIl3fWImk06g==
X-CSE-MsgGUID: 6awH5U5HR7uF/fd1HTDk5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="242110103"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 14:44:53 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Subject: [PATCH 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
Date: Wed, 27 May 2026 05:44:45 +0800
Message-ID: <20260526214446.3638616-2-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526214446.3638616-1-jonathan.cavitt@intel.com>
References: <20260526214446.3638616-1-jonathan.cavitt@intel.com>
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

Add SRCID information to pagefault struct for the purpose of reporting
the hardware unit that resulted in the pagefault.

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/xe/xe_guc_pagefault.c   | 1 +
 drivers/gpu/drm/xe/xe_pagefault.c       | 6 ++++--
 drivers/gpu/drm/xe/xe_pagefault_types.h | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_pagefault.c b/drivers/gpu/drm/xe/xe_guc_pagefault.c
index 607e32392f46..17cb7f359261 100644
--- a/drivers/gpu/drm/xe/xe_guc_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_guc_pagefault.c
@@ -91,6 +91,7 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
 				   FIELD_GET(PFD_FAULT_TYPE, msg[2]));
 	pf.consumer.engine_class = FIELD_GET(PFD_ENG_CLASS, msg[0]);
 	pf.consumer.engine_instance = FIELD_GET(PFD_ENG_INSTANCE, msg[0]);
+	pf.consumer.srcid = FIELD_GET(PFD_SRC_ID, msg[0]);
 
 	pf.producer.private = guc;
 	pf.producer.ops = &guc_pagefault_ops;
diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index dd3c068e1a39..42b682ba5f9b 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -248,7 +248,8 @@ static void xe_pagefault_print(struct xe_pagefault *pf)
 		   "\tAccessType: %lu\n"
 		   "\tFaultLevel: %lu\n"
 		   "\tEngineClass: %d %s\n"
-		   "\tEngineInstance: %d\n",
+		   "\tEngineInstance: %d\n"
+		   "\tSRCID: 0x%02x\n",
 		   pf->consumer.asid,
 		   upper_32_bits(pf->consumer.page_addr),
 		   lower_32_bits(pf->consumer.page_addr),
@@ -260,7 +261,8 @@ static void xe_pagefault_print(struct xe_pagefault *pf)
 			     pf->consumer.fault_type_level),
 		   pf->consumer.engine_class,
 		   xe_hw_engine_class_to_str(pf->consumer.engine_class),
-		   pf->consumer.engine_instance);
+		   pf->consumer.engine_instance,
+		   pf->consumer.srcid);
 }
 
 static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *pf)
diff --git a/drivers/gpu/drm/xe/xe_pagefault_types.h b/drivers/gpu/drm/xe/xe_pagefault_types.h
index c4ee625b93dd..60cc269aeea3 100644
--- a/drivers/gpu/drm/xe/xe_pagefault_types.h
+++ b/drivers/gpu/drm/xe/xe_pagefault_types.h
@@ -86,8 +86,10 @@ struct xe_pagefault {
 		u8 engine_class;
 		/** @consumer.engine_instance: engine instance */
 		u8 engine_instance;
+		/** @consumer.srcid: ID of hardware unit producing fault */
+		u8 srcid;
 		/** @consumer.reserved: reserved bits for future expansion */
-		u64 reserved;
+		u8 reserved[7];
 	} consumer;
 	/**
 	 * @producer: State for the producer (i.e., HW/FW interface). Populated
-- 
2.53.0

