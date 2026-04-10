Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B33F45A13
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 23:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C32910E9DC;
	Fri, 10 Apr 2026 23:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GwUN1WAk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E259910E05E;
 Fri, 10 Apr 2026 23:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775862232; x=1807398232;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1licrSNtxf0nZ8ajbIrtz7CnCXf8IyTYurmKzQYvq24=;
 b=GwUN1WAkXh09d9ZjrndAJKAvaWvLp6PdGed3goGBwFRG2rqSzwfIwAEb
 IoV3TvcnhB9GYHk2a7gdaIB1S5jiYkBAYJsTuyuFXsfSXK6d9yZ/8YXdr
 JgiOc+8PP+BD9xWKEdu6paangZChneagQKOY8AEMkVz6SMdt/Sm0Md5H4
 5EWrubqnluZdevPVDE/9UkFBoEcbIMhd9GjlJaC5aA/cfD2T0wEzs21wt
 U9NCcMJbvYcmGtCG9Mc8N+M8yOTtXcsZ+pu81lb2KotOMdc9d5uWt4OhL
 DMFDYCdtVafunFAFth0PxGPdCq3ahUH48I5F5z5dJZdVV8eFngtk7ax90 g==;
X-CSE-ConnectionGUID: LOgcw670T/GcE7AABX8B6Q==
X-CSE-MsgGUID: 7TdVt/TwRziSxQLm4dAgAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87587568"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="87587568"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 16:03:51 -0700
X-CSE-ConnectionGUID: MSITso4DSTyIyW4mmq8MTA==
X-CSE-MsgGUID: ISCsgaCJSwCv8FFwW6F0AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="233620050"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 16:03:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/zone_device: Do not touch device folio after calling
 ->folio_free()
Date: Fri, 10 Apr 2026 16:03:46 -0700
Message-Id: <20260410230346.4009855-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

The contents of a device folio can immediately change after calling
->folio_free(), as the folio may be reallocated by a driver with a
different order. Instead of touching the folio again to extract the
pgmap, use the local stack variable when calling percpu_ref_put_many().

Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---
Stack trace:

[  631.875165] [IGT] xe_exec_system_allocator: starting subtest threads-many-new-prefetch
[  632.282992] Oops: general protection fault, probably for non-canonical address 0x900000000000000: 0000 [#1] SMP NOPTI
[  632.293469] CPU: 8 UID: 0 PID: 59267 Comm: xe_exec_system_ Not tainted 7.0.0-rc7-xe+ #281 PREEMPT(full)
[  632.316023] RIP: 0010:free_zone_device_folio+0x149/0x240
[  632.339782] RSP: 0000:ffffc90023d1fd00 EFLAGS: 00010206
[  632.344947] RAX: 0900000000000000 RBX: 0000000000000001 RCX: 0000000094472d4d
[  632.351991] RDX: ffffffff8155c76f RSI: 000000006f2213bf RDI: 000000008e84943a
[  632.359042] RBP: ffffea0ff4030001 R08: 0000000000000000 R09: 0000000000000001
[  632.366094] R10: 0000000000000028 R11: 0000000000000000 R12: ffff88811828e400
[  632.373145] R13: 0000000000000000 R14: 000fffffc0000000 R15: 0000000000100073
[  632.380194] FS:  00007f2f0fdfe6c0(0000) GS:ffff88890a7e7000(0000) knlGS:0000000000000000
[  632.388186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  632.393870] CR2: 00007f2f002e90f8 CR3: 0000000106708002 CR4: 0000000000f70ef0
[  632.400919] PKRU: 55555554
[  632.403605] Call Trace:
[  632.406039]  <TASK>
[  632.408131]  do_swap_page+0x146d/0x18c0
[  632.411938]  ? __pte_offset_map+0x3e/0x190
[  632.415994]  __handle_mm_fault+0x6e8/0x8d0
[  632.420053]  handle_mm_fault+0xbf/0x250
[  632.423855]  ? lock_mm_and_find_vma+0x41/0x6f0
[  632.428256]  do_user_addr_fault+0x168/0x690
[  632.432399]  exc_page_fault+0x74/0x200
[  632.436117]  asm_exc_page_fault+0x26/0x30
[  632.440092] RIP: 0033:0x5587554ff70d
[  632.462142] RSP: 002b:00007f2f0fdfc970 EFLAGS: 00010246
[  632.467308] RAX: 0000000000003fc0 RBX: 00007f2f082e1fc0 RCX: 00007f2f12b3287d
[  632.474355] RDX: 0000000000000000 RSI: 00000000c048644a RDI: 0000000000000003
[  632.481404] RBP: 00007f2f082e1fc0 R08: 00007f2f0fdfc958 R09: 0000000000000066
[  632.488450] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  632.495495] R13: 00007f2f082de000 R14: 0000000000c00002 R15: 00007f2f1319e000
[  632.502547]  </TASK>
---
 mm/memremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index ac7be07e3361..053842d45cb1 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -454,7 +454,7 @@ void free_zone_device_folio(struct folio *folio)
 		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->folio_free))
 			break;
 		pgmap->ops->folio_free(folio);
-		percpu_ref_put_many(&folio->pgmap->ref, nr);
+		percpu_ref_put_many(&pgmap->ref, nr);
 		break;
 
 	case MEMORY_DEVICE_GENERIC:
-- 
2.34.1

