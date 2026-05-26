Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2443ACD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 21:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F1A410E640;
	Tue, 26 May 2026 21:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P3l3G596";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D72B610E640;
 Tue, 26 May 2026 21:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779831901; x=1811367901;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RHbP52B3F3Fi7OHHYqLmeRwNQOtGKCJ6lubNGn1D+u0=;
 b=P3l3G596Yi/h8Xbx4I24+6DUF8Gl2d3z5G79Pi6CsUiAc4Vzu8chi5X7
 c1cV864YpAf6tzPTuO5QFjXPLvOJ+REpY/quppbxWwciDvXZKoSWhVI4f
 btRw73pKo83YPjPMIBgHuuiy3ukeDtEZoU5uIiXCK4wN4bsafesS7oT8v
 qFaPyewhsVitoqi8E/9Nwq+tBplEaDpvGGvK7fxVmkPthTFyfnKM0gkO2
 8vjQ67mqRCXZeHYsBT5XC0C/YQMxeWRS/72rGSXkJBC1ex49Qr205lIgU
 sAHqS4FnIjIpwOIKF/NtfQYbbw0g1gJN6iYAbB7vPTVsnobGeGvbn1ZMZ Q==;
X-CSE-ConnectionGUID: FQoJGPlrQvaqupcl+pK2iA==
X-CSE-MsgGUID: jbQxHYbJRcW9OhHGuNn/5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80843906"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="80843906"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 14:45:00 -0700
X-CSE-ConnectionGUID: BmVcZRAwQ6W931YgZXgBzA==
X-CSE-MsgGUID: +lwW+EsISSuQNWEWSlBWQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="242110114"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 14:44:56 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Subject: [PATCH 2/2] drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault
 report
Date: Wed, 27 May 2026 05:44:46 +0800
Message-ID: <20260526214446.3638616-3-jonathan.cavitt@intel.com>
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

Add the SRCID of the faulting hardware unit to the return of the
xe_vm_get_property_ioctl fault report.

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/xe/xe_vm.c       | 11 +++++++++--
 drivers/gpu/drm/xe/xe_vm_types.h |  2 ++
 include/uapi/drm/xe_drm.h        |  4 ++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 080c2fff0e95..18d5cdafd76b 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -636,6 +636,7 @@ void xe_vm_add_fault_entry_pf(struct xe_vm *vm, struct xe_pagefault *pf)
 				  pf->consumer.fault_type_level);
 	e->fault_level = FIELD_GET(XE_PAGEFAULT_LEVEL_MASK,
 				   pf->consumer.fault_type_level);
+	e->srcid = pf->consumer.srcid;
 
 	list_add_tail(&e->list, &vm->faults.list);
 	vm->faults.len++;
@@ -4108,6 +4109,11 @@ static u8 xe_to_user_fault_level(u8 fault_level)
 	return fault_level;
 }
 
+static u8 xe_to_user_srcid(u8 srcid)
+{
+	return srcid;
+}
+
 static int fill_faults(struct xe_vm *vm,
 		       struct drm_xe_vm_get_property *args)
 {
@@ -4135,6 +4141,8 @@ static int fill_faults(struct xe_vm *vm,
 		fault_entry.fault_type = xe_to_user_fault_type(entry->fault_type);
 		fault_entry.fault_level = xe_to_user_fault_level(entry->fault_level);
 
+		fault_entry.srcid = xe_to_user_srcid(entry->srcid);
+
 		memcpy(&fault_list[i], &fault_entry, entry_size);
 
 		i++;
@@ -4190,8 +4198,7 @@ int xe_vm_get_property_ioctl(struct drm_device *drm, void *data,
 	int ret = 0;
 
 	if (XE_IOCTL_DBG(xe, (args->reserved[0] || args->reserved[1] ||
-			      args->reserved[2] || args->extensions ||
-			      args->pad)))
+			      args->reserved[2] || args->extensions)))
 		return -EINVAL;
 
 	vm = xe_vm_lookup(xef, args->vm_id);
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 635ed29b9a69..e8aea75341cc 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -196,6 +196,7 @@ struct xe_device;
  * @access_type: type of address access that resulted in fault
  * @fault_type: type of fault reported
  * @fault_level: fault level of the fault
+ * @srcid: ID of the faulting hardware unit
  */
 struct xe_vm_fault_entry {
 	struct list_head list;
@@ -204,6 +205,7 @@ struct xe_vm_fault_entry {
 	u8 access_type;
 	u8 fault_type;
 	u8 fault_level;
+	u8 srcid;
 };
 
 struct xe_vm {
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 48e9f1fdb78d..2b45b691a032 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1294,8 +1294,8 @@ struct xe_vm_fault {
 #define FAULT_LEVEL_PML4	3
 #define FAULT_LEVEL_PML5	4
 	__u8 fault_level;
-	/** @pad: MBZ */
-	__u8 pad;
+	/** @srcid: ID of the faulting hardware unit */
+	__u8 srcid;
 	/** @reserved: MBZ */
 	__u64 reserved[4];
 };
-- 
2.53.0

