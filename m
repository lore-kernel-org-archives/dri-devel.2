Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B407C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6FB810F355;
	Wed,  2 Sep 2026 21:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DBuTsW+V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFD510F355;
 Wed,  2 Sep 2026 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788385451; x=1819921451;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Wqny6CjZTsdaVrnuEzf0jnl+Z0+B17vt/EwoBnJqTR4=;
 b=DBuTsW+VzPsNNv9MwgIkf2SMo8LI8N+xiP0R98rS8XAMqPGgprAxM8kR
 u1ykIcChQqoG08XijHmdIVWVgyIy1L1gUfzDsx7ezIYmggkkHVAICCsFd
 sQXsXkK72Gi9RXhyw0kETwUPjCSXS/gfq/LBcvLaL53+EibGKGjJ0l9kV
 6y0YjWsGrvAbS1dUaPeoVTxoNGTGknVCp4FaEEjO+SJ4Vrdd7cphQNmS2
 6ah+CPwxadQMrDfkLEhqsnQ61f2k7Nisgx7gEDXMYecqD1smaZuFv9c6k
 YH3cNVcUoz2m51vp2J6ffee0TK4bAbg7Yy50/TuQpDNEGlRGaxOco4xUH A==;
X-CSE-ConnectionGUID: 6DMcw0A0T5+uWiTb9P0Zlg==
X-CSE-MsgGUID: ladEM3kdSAGe0LqORgGM9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="87997792"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="87997792"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 14:44:11 -0700
X-CSE-ConnectionGUID: oFwGUgfGRZSlTRS8vDG33A==
X-CSE-MsgGUID: vTTYqlIBRMqzan19QOzzbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="266929212"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 14:44:08 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, jonathan.cavitt@intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, Rodrigo.vivi@intel.com,
 matthew.brost@intel.com, maarten.lankhorst@linux.intel.com,
 thomas.hellstrom@linux.intel.com, tzimmermann@suse.de
Subject: [PATCH v7 2/2] drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault
 report
Date: Thu,  3 Sep 2026 05:43:58 +0800
Message-ID: <20260902214358.348399-3-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902214358.348399-1-jonathan.cavitt@intel.com>
References: <20260902214358.348399-1-jonathan.cavitt@intel.com>
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

v2:
- Readd pad check, as the pad in the ioctl struct was not changed
  (jcavitt)

v3:
- Squash SRCID with ASID to keep the struct compact (Matthew)

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/xe/xe_vm.c       | 8 ++++++++
 drivers/gpu/drm/xe/xe_vm_types.h | 2 ++
 include/uapi/drm/xe_drm.h        | 4 ++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 19b3d0be79282..753a5fc55baa0 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -655,6 +655,7 @@ void xe_vm_add_fault_entry_pf(struct xe_vm *vm, struct xe_pagefault *pf)
 				  pf->consumer.fault_type_level);
 	e->fault_level = FIELD_GET(XE_PAGEFAULT_LEVEL_MASK,
 				   pf->consumer.fault_type_level);
+	e->srcid = FIELD_GET(XE_PAGEFAULT_SRCID_MASK, pf->consumer.id);
 
 	list_add_tail(&e->list, &vm->faults.list);
 	vm->faults.len++;
@@ -4277,6 +4278,11 @@ static u8 xe_to_user_fault_level(u8 fault_level)
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
@@ -4304,6 +4310,8 @@ static int fill_faults(struct xe_vm *vm,
 		fault_entry.fault_type = xe_to_user_fault_type(entry->fault_type);
 		fault_entry.fault_level = xe_to_user_fault_level(entry->fault_level);
 
+		fault_entry.srcid = xe_to_user_srcid(entry->srcid);
+
 		memcpy(&fault_list[i], &fault_entry, entry_size);
 
 		i++;
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 68588b6242121..648031e641451 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -202,6 +202,7 @@ struct xe_device;
  * @access_type: type of address access that resulted in fault
  * @fault_type: type of fault reported
  * @fault_level: fault level of the fault
+ * @srcid: ID of the faulting hardware unit
  */
 struct xe_vm_fault_entry {
 	struct list_head list;
@@ -210,6 +211,7 @@ struct xe_vm_fault_entry {
 	u8 access_type;
 	u8 fault_type;
 	u8 fault_level;
+	u8 srcid;
 };
 
 struct xe_vm {
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 509202a7b13eb..8c852abcacf0d 100644
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

