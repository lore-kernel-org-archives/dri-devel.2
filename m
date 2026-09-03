Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41218C624DE
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F9810E4A9;
	Thu,  3 Sep 2026 23:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ItimFC9c";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04EEF10E1E7;
 Thu,  3 Sep 2026 23:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788477397; x=1820013397;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FKUXkLgR8jw224z2qZM2P9XUHGjb/3qYlCiP/W6sxog=;
 b=ItimFC9c/Dc5baGUU2UNp310zW3i/XFB/ZBD0HweAQMLcheAvEQ5NIr5
 R0qQN2gRaCA3B9TwoamIhzL9qAa4CkWMI5K+gCuca02U1FZS+T+qzm88e
 e7RCaV+K3VRHEm4bKnl3779W9kYnMKBCYVWSRpriS8IAZS5ekFvjxHlwK
 9Z7rndYjJFrSZKsHV/5UxC8aBDH3je1mVQXLC9fWs2szShUals8/F42oQ
 8UdkZ1d9U6sjtfuk7IJYTnpqZhj8A4uFj/FczFny9FhyAEla16ikv1otT
 4r7LHT8n7m6gkpi/MrW6F8ka5BuEZov+lkk3RLyPq5XGzk8+sxzyZQnLs w==;
X-CSE-ConnectionGUID: 1hsqUhH9RjSDdpz93jo10w==
X-CSE-MsgGUID: 5+OjY0LATfe3mJHD43SuNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92847224"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="92847224"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 16:16:36 -0700
X-CSE-ConnectionGUID: HkSh0FnMQlmDR5sCYyM+xQ==
X-CSE-MsgGUID: fvt8v3PmRyCHKKbTFkpF/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="269343204"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 16:16:35 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, jonathan.cavitt@intel.com,
 intel-xe@lists.freedesktop.org, matthew.brost@intel.com
Subject: [PATCH] drm/xe: Rename xe_vm_fault to drm_xe_vm_fault
Date: Fri,  4 Sep 2026 07:16:32 +0800
Message-ID: <20260903231632.399765-1-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

Rename xe_vm_fault to drm_xe_vm_fault to better align with uAPI struct
naming conventions.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 14 +++++++-------
 include/uapi/drm/xe_drm.h  |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 753a5fc55baa0..22ce6f8dfb783 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -4286,15 +4286,15 @@ static u8 xe_to_user_srcid(u8 srcid)
 static int fill_faults(struct xe_vm *vm,
 		       struct drm_xe_vm_get_property *args)
 {
-	struct xe_vm_fault __user *usr_ptr = u64_to_user_ptr(args->data);
-	struct xe_vm_fault *fault_list, fault_entry = { 0 };
+	struct drm_xe_vm_fault __user *usr_ptr = u64_to_user_ptr(args->data);
+	struct drm_xe_vm_fault *fault_list, fault_entry = { 0 };
 	struct xe_vm_fault_entry *entry;
 	int ret = 0, i = 0, count, entry_size;
 
-	entry_size = sizeof(struct xe_vm_fault);
+	entry_size = sizeof(struct drm_xe_vm_fault);
 	count = args->size / entry_size;
 
-	fault_list = kcalloc(count, sizeof(struct xe_vm_fault), GFP_KERNEL);
+	fault_list = kcalloc(count, sizeof(struct drm_xe_vm_fault), GFP_KERNEL);
 	if (!fault_list)
 		return -ENOMEM;
 
@@ -4332,7 +4332,7 @@ static int xe_vm_get_property_helper(struct xe_vm *vm,
 	switch (args->property) {
 	case DRM_XE_VM_GET_PROPERTY_FAULTS:
 		spin_lock(&vm->faults.lock);
-		size = size_mul(sizeof(struct xe_vm_fault), vm->faults.len);
+		size = size_mul(sizeof(struct drm_xe_vm_fault), vm->faults.len);
 		spin_unlock(&vm->faults.lock);
 
 		if (!args->size) {
@@ -4347,9 +4347,9 @@ static int xe_vm_get_property_helper(struct xe_vm *vm,
 		 * the number of faults in the VM fault array.
 		 *
 		 * We should also at least assert that the args->size value
-		 * is a multiple of the xe_vm_fault struct size.
+		 * is a multiple of the drm_xe_vm_fault struct size.
 		 */
-		if (args->size > size || args->size % sizeof(struct xe_vm_fault))
+		if (args->size > size || args->size % sizeof(struct drm_xe_vm_fault))
 			return -EINVAL;
 
 		return fill_faults(vm, args);
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 8c852abcacf0d..89c0dbe227dd7 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1271,8 +1271,8 @@ struct drm_xe_vm_bind {
 	__u64 reserved[2];
 };
 
-/** struct xe_vm_fault - Describes faults for %DRM_XE_VM_GET_PROPERTY_FAULTS */
-struct xe_vm_fault {
+/** struct drm_xe_vm_fault - Describes faults for %DRM_XE_VM_GET_PROPERTY_FAULTS */
+struct drm_xe_vm_fault {
 	/** @address: Canonical address of the fault */
 	__u64 address;
 	/** @address_precision: Precision of faulted address */
-- 
2.53.0

