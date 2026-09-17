Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51632C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2B410ECE8;
	Thu, 17 Sep 2026 10:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="K/PHteSu";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A31410ECE8;
 Thu, 17 Sep 2026 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=HLXXIBSDaLCaNbNGcsaN0ZmcQwuvRRSfXuFAjX3/AOU=; b=K/PHteSu/MZ3gmPtgaShvXuL97
 QaetK+vFlaTp1893Q5XnQ9UPqjqd9maZ2XOxL3p+u+JDs3dc+LI9QZR5vLTEgwU96r2qkWrwNCeZB
 fpmmzcQO5/35/FCFHbysAJmu2pbBLdCMQA1HIDpUkoUYjdg66g4CCq9z21b2tnP57fUFyYHWfBD89
 PqRSsOdZLAzxtoW8hI+CXay9lyv5+kT1HcADiesalNno1Y6FIxqX/JWLVTPYZfmd/lUysFdv3FN3M
 9iv+1gR9pVDGzk+q3RXCw7Y7o+9LNHxPP1v50jIxeAzM2dQRcEwI/IkKXZM0+eJCuHKxupqBN6AXt
 iz/xLGaQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x794J-003LGe-Fv; Thu, 17 Sep 2026 12:10:15 +0200
Message-ID: <2b9a4a22-0cb6-423a-b3a7-abd20820ff2e@igalia.com>
Date: Thu, 17 Sep 2026 11:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t] tests/intel/xe_sync_file: Exercise sync file access
 post queue destruction
To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 phasta@kernel.org
References: <20260907123308.52055-1-tvrtko.ursulin@igalia.com>
 <20260917094828.fttmqyv26b3bxxqy@kamilkon-DESK.igk.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260917094828.fttmqyv26b3bxxqy@kamilkon-DESK.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 17/09/2026 10:48, Kamil Konieczny wrote:
> Hi Tvrtko,
> On 2026-09-07 at 13:33:08 +0100, Tvrtko Ursulin wrote:
>> A new test to roughly simulate the VK CTS suite where
>> dEQP-VK.wsi.android.swapchain.render.* is hitting an use after free when a
>> sync file is accessed after the xe submission queue has been destroyed.
>>
>> Abbreviated KASAN report:
>>
>>   [IGT] xe_sync_file: starting subtest sync_file_race
>>   ==================================================================
>>   BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name+0xa1/0xb0 [gpu_sched]
>>   Read of size 8 at addr ffff888126726020 by task xe_sync_file/2931
>>   ...
>>   Call Trace:
>>    <TASK>
>>    kasan_report+0xeb/0x130
>>    drm_sched_fence_get_timeline_name+0xa1/0xb0 [gpu_sched]
>>    sync_file_ioctl+0x3cb/0xb00
>>   ...
>>   Allocated by task 2931:
>>    __kmalloc_cache_noprof+0x1c2/0x410
>>    guc_exec_queue_init+0x1a8/0x1240 [xe]
>>    xe_exec_queue_create+0xe72/0x13b0 [xe]
>>    xe_exec_queue_create_ioctl+0x10d9/0x1770 [xe]
>>    drm_ioctl_kernel+0x179/0x300
>>    drm_ioctl+0x58f/0xcf0
>>    xe_drm_ioctl+0xe8/0x140 [xe]
>>   ...
>>   Freed by task 1689:
>>    kfree+0x106/0x3e0
>>    __guc_exec_queue_fini_async+0x144/0x2d0 [xe]
>>    process_one_work+0x610/0xdf0
>>    worker_thread+0x7c8/0x14b0
>>
>> Without KASAN this of course turns into a plain null pointer dereference.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: phasta@kernel.org
>> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com> # v2
>> ---
>> v2:
>>   - igt_main and igt_fixture tweaks. (Rodrigo)
>>
>> v3:
>>   - Add driver name checks.
>> ---
>> I dropped the ball upstreaming this old IGT proposal. Now that things
>> got broken with
>> 035219a760ed ("dma-buf: dma-fence: Fix potential NULL pointer dereference")
>> it shows it would have been useful to have this merged and ran in CI.
>> ---
>>   tests/intel/xe_sync_file.c | 154 +++++++++++++++++++++++++++++++++++++
>>   tests/meson.build          |   1 +
>>   2 files changed, 155 insertions(+)
>>   create mode 100644 tests/intel/xe_sync_file.c
>>
>> diff --git a/tests/intel/xe_sync_file.c b/tests/intel/xe_sync_file.c
>> new file mode 100644
>> index 000000000000..842c3856a525
>> --- /dev/null
>> +++ b/tests/intel/xe_sync_file.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright © 2025 Google, Inc.
>> + */
>> +
>> +/**
>> + * TEST: Tests for sync file functionality
>> + * Category: Core
>> + * Mega feature: General Core features
>> + * Sub-category: CMD submission
>> + * Functionality: fences
>> + */
>> +
>> +#include "igt.h"
>> +#include "sync_file.h"
>> +
>> +#include "lib/igt_syncobj.h"
>> +#include "lib/intel_reg.h"
>> +
>> +#include "xe_drm.h"
>> +#include "xe/xe_ioctl.h"
>> +#include "xe/xe_query.h"
>> +
>> +static int sync_file_get_status(int sync_file, char **driver_name)
>> +{
>> +	struct sync_fence_info fence = { };
>> +	struct sync_file_info info = {
>> +		.num_fences = 1,
>> +		.sync_fence_info = to_user_pointer(&fence),
>> +	};
>> +
>> +	do_ioctl(sync_file, SYNC_IOC_FILE_INFO, &info);
>> +	igt_assert_eq(info.num_fences, 1);
>> +
>> +	igt_debug("'%s'/'%s' = %d\n",
>> +		  fence.driver_name, fence.obj_name, fence.status);
>> +
>> +	*driver_name = strdup(fence.driver_name);
>> +
>> +	return fence.status;
>> +}
>> +
>> +/**
>> + * SUBTEST: sync_file_race
>> + * Description: Check that we can safely query an exported sync file fd
>> + * Test category: functionality test
>> + */
>> +static void test_race(int xe, struct drm_xe_engine_class_instance *eci)
>> +{
>> +	uint32_t vm, bo, syncobj, bind_syncobj, *batch;
>> +	struct drm_xe_sync sync[2] = {
>> +		{ .type = DRM_XE_SYNC_TYPE_SYNCOBJ,
>> +		  .flags = DRM_XE_SYNC_FLAG_SIGNAL,
>> +		},
>> +		{ .type = DRM_XE_SYNC_TYPE_SYNCOBJ,
>> +		  .flags = DRM_XE_SYNC_FLAG_SIGNAL,
>> +		},
>> +	};
>> +	const uint32_t bbend = MI_BATCH_BUFFER_END;
>> +	struct drm_xe_exec exec = {
>> +		.address = 0x100000,
>> +		.num_batch_buffer = 1,
>> +		.num_syncs = 2,
>> +		.syncs = to_user_pointer(sync),
>> +	};
>> +	char *driver_name;
>> +	int sync_fence;
>> +	size_t size;
>> +
>> +	vm = xe_vm_create(xe, 0, 0);
>> +
>> +	size = xe_bb_size(xe, sizeof(bbend));
>> +	bo = xe_bo_create(xe, vm, size, vram_if_possible(xe, eci->gt_id),
>> +			  DRM_XE_GEM_CREATE_FLAG_NEEDS_VISIBLE_VRAM);
>> +
>> +	batch = xe_bo_map(xe, bo, size);
>> +	*batch = bbend;
>> +
>> +	exec.exec_queue_id  = xe_exec_queue_create(xe, vm, eci, 0);
>> +
>> +	syncobj = syncobj_create(xe, 0);
>> +	bind_syncobj = syncobj_create(xe, 0);
>> +
>> +	sync[0].handle = bind_syncobj;
>> +	xe_vm_bind_async(xe, vm, 0, bo, 0, exec.address, size, sync, 1);
>> +
>> +	sync[0].flags &= ~DRM_XE_SYNC_FLAG_SIGNAL;
>> +	sync[0].handle = bind_syncobj;
>> +	sync[1].flags |= DRM_XE_SYNC_FLAG_SIGNAL;
>> +	sync[1].handle = syncobj;
>> +	xe_exec(xe, &exec);
>> +
>> +	/* Export a sync file fence. */
>> +	sync_fence = syncobj_handle_to_fd(xe, sync[1].handle,
>> +					  DRM_SYNCOBJ_HANDLE_TO_FD_FLAGS_EXPORT_SYNC_FILE);
>> +
>> +	igt_assert(syncobj_wait(xe, &syncobj, 1, INT64_MAX, 0, NULL));
>> +	igt_assert(syncobj_wait(xe, &bind_syncobj, 1, INT64_MAX, 0, NULL));
>> +
>> +	driver_name = NULL;
>> +	igt_assert_eq(sync_file_get_status(sync_fence, &driver_name), 1);
>> +	igt_assert(driver_name);
>> +	igt_assert(!strcmp(driver_name, "drm_sched"));
>> +	free(driver_name);
>> +
>> +	sync[0].flags |= DRM_XE_SYNC_FLAG_SIGNAL;
>> +	syncobj_reset(xe, &sync[0].handle, 1);
>> +	xe_vm_unbind_async(xe, vm, 0, 0, exec.address, size, sync, 1);
>> +	igt_assert(syncobj_wait(xe, &sync[0].handle, 1, INT64_MAX, 0, NULL));
>> +
>> +	syncobj_destroy(xe, syncobj);
>> +	xe_exec_queue_destroy(xe, exec.exec_queue_id);
>> +
>> +	munmap(batch, size);
>> +	gem_close(xe, bo);
>> +
>> +	syncobj_destroy(xe, bind_syncobj);
>> +	xe_vm_destroy(xe, vm);
>> +
>> +	/* Give any delayed freeing time to run. */
>> +	sleep(1);
>> +
>> +	/* This should still work and not crash the kernel. */
>> +	driver_name = NULL;
>> +	igt_assert_eq(sync_file_get_status(sync_fence, &driver_name), 1);
>> +
>> +	/* And must not read the original timeline/driver name either! */
>> +	igt_assert(driver_name);
>> +	igt_assert(!strcmp(driver_name, "detached-driver"));
>> +	free(driver_name);
>> +
>> +	close(sync_fence);
>> +}
>> +
>> +int igt_main()
>> +{
>> +	struct drm_xe_engine_class_instance *eci;
>> +	int xe;
>> +
>> +	igt_fixture() {
>> +		xe = drm_open_driver(DRIVER_XE);
>> +	}
>> +
>> +	igt_subtest("sync_file_race") {
>> +		xe_for_each_engine(xe, eci) {
>> +			test_race(xe, eci);
>> +			break;
>> +		}
>> +	}
>> +
>> +	igt_fixture() {
>> +		drm_close_driver(xe);
>> +	}
>> +}
>> diff --git a/tests/meson.build b/tests/meson.build
>> index 1ac89bab7e15..f83368695a0e 100644
>> --- a/tests/meson.build
>> +++ b/tests/meson.build
>> @@ -351,6 +351,7 @@ intel_xe_progs = [
>>   	'xe_sysfs_preempt_timeout',
>>   	'xe_sysfs_scheduler',
>>           'xe_sysfs_timeslice_duration',
>> +	'xe_sync_file',
> 
> Why it moved down? In v2 it was in proper place, just before
> xe_sysfs tests. Please move it back to keep alphabetical order.

No idea TBH. Maybe it was a rebase conflict and I messed up the 
resolution. Will fix.

Regards,

Tvrtko

