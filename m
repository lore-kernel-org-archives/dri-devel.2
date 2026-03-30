Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36579FB3D04
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9643610E617;
	Mon, 30 Mar 2026 10:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="UTGmSygW";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D844F10E61A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:39:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C7661C00;
 Mon, 30 Mar 2026 03:38:59 -0700 (PDT)
Received: from [10.57.61.249] (unknown [10.57.61.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29DCF3F915;
 Mon, 30 Mar 2026 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1774867144; bh=SIk70OLqSrRNeFwNU7snZxxX8G3ys2ug7ym3PFeR8as=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UTGmSygWDkemRNFxhKpu5KuyQIO5EUu2F9oKA3KO/80AbmKHK0oytKygGtHTI8Ctl
 a8J33VrSZ/vkd6brZC5rvEMYJAa4AlrH1Tx8RBOYY4CZ3xnAVQjEl5MahUrejyflxc
 HAGyY5ao+9eBooiPY4U//lXwUy7HTg5fmabRgFmc=
Message-ID: <8b2b65a3-3db8-469f-90ae-6abccdb3c71a@arm.com>
Date: Mon, 30 Mar 2026 11:39:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] drm/panthor: Add a GEM shrinker
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Chris Diamand <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Chia-I Wu <olvaffe@gmail.com>,
 kernel@collabora.com
References: <20260330094848.2169422-1-boris.brezillon@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260330094848.2169422-1-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Boris,

On 30/03/2026 10:48, Boris Brezillon wrote:
> Hello,
> 
> This is an attempt at adding a GEM shrinker to panthor so the system
> can finally reclaim GPU memory.
> 
> This implementation is losely based on the MSM shrinker (which is why
> I added the MSM maintainers in Cc), and it's relying on the drm_gpuvm
> eviction/validation infrastructure.
> 
> I've only done very basic IGT-based [1] and chromium-based (opening
> a lot of tabs on Aquarium until the system starts reclaiming+swapping
> out GPU buffers) testing, but I'm posting this early so I can get
> preliminary feedback on the implementation. If someone knows about
> better tools/ways to test the shrinker, please let me know.

I did my own pretty basic testing (glmark with memhog) and managed to hit this:

[  265.053172] ============================================
[  265.053667] WARNING: possible recursive locking detected
[  265.054159] 7.0.0-rc3-00694-gadfa5ca08767 #1 Not tainted
[  265.054655] --------------------------------------------
[  265.055143] glmark2-es2-drm/443 is trying to acquire lock:
[  265.055651] ffff0001194011a8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: drm_gpuvm_bo_deferred_cleanup+0x100/0x2c0 [drm_gpuvm]
[  265.056738] 
[  265.056738] but task is already holding lock:
[  265.057278] ffff80008b7c79e8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: panthor_ioctl_group_submit+0x424/0x560 [panthor]
[  265.058324] 
[  265.058324] other info that might help us debug this:
[  265.058927]  Possible unsafe locking scenario:
[  265.058927] 
[  265.059475]        CPU0
[  265.059706]        ----
[  265.059939]   lock(reservation_ww_class_mutex);
[  265.060365]   lock(reservation_ww_class_mutex);
[  265.060788] 
[  265.060788]  *** DEADLOCK ***
[  265.060788] 
[  265.061338]  May be due to missing lock nesting notation
[  265.061338] 
[  265.061964] 3 locks held by glmark2-es2-drm/443:
[  265.062395]  #0: ffff80008493c458 (drm_unplug_srcu){.+.+}-{0:0}, at: drm_dev_enter+0x0/0x140
[  265.063188]  #1: ffff80008b7c79c0 (reservation_ww_class_acquire){+.+.}-{0:0}, at: panthor_ioctl_group_submit+0x424/0x560 [panthor]
[  265.064288]  #2: ffff80008b7c79e8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: panthor_ioctl_group_submit+0x424/0x560 [panthor]
[  265.065370] 
[  265.065370] stack backtrace:
[  265.065780] CPU: 4 UID: 1000 PID: 443 Comm: glmark2-es2-drm Not tainted 7.0.0-rc3-00694-gadfa5ca08767 #1 PREEMPT 
[  265.065787] Hardware name: Radxa ROCK 5B (DT)
[  265.065791] Call trace:
[  265.065793]  show_stack+0x18/0x24 (C)
[  265.065802]  dump_stack_lvl+0x6c/0x94
[  265.065810]  dump_stack+0x1c/0x28
[  265.065815]  print_deadlock_bug+0x224/0x238
[  265.065822]  __lock_acquire+0xe54/0x1600
[  265.065829]  lock_acquire+0x3cc/0x420
[  265.065834]  __ww_mutex_lock.constprop.0+0x1fc/0x2c40
[  265.065844]  ww_mutex_lock+0x50/0x168
[  265.065850]  drm_gpuvm_bo_deferred_cleanup+0x100/0x2c0 [drm_gpuvm]
[  265.065862]  panthor_vm_cleanup_op_ctx+0x188/0x270 [panthor]
[  265.065881]  panthor_vm_bo_validate+0x404/0x758 [panthor]
[  265.065898]  drm_gpuvm_validate+0x28c/0xf50 [drm_gpuvm]
[  265.065907]  panthor_vm_prepare_mapped_bos_resvs+0x64/0x80 [panthor]
[  265.065925]  panthor_ioctl_group_submit+0x418/0x560 [panthor]
[  265.065942]  drm_ioctl_kernel+0x15c/0x2c0
[  265.065947]  drm_ioctl+0x56c/0xb1c
[  265.065952]  __arm64_sys_ioctl+0x124/0x1a4
[  265.065961]  invoke_syscall+0x70/0x260
[  265.065967]  el0_svc_common.constprop.0+0xac/0x230
[  265.065972]  do_el0_svc+0x40/0x58
[  265.065976]  el0_svc+0x4c/0x210
[  265.065981]  el0t_64_sync_handler+0xa0/0xe4
[  265.065986]  el0t_64_sync+0x198/0x19c

Thanks,
Steve

> A few words about some design/implementation choices:
> - No MADVISE support because I want to see if we can live with just
>   transparent reclaim
> - We considered basing this implementation on the generic shrinker work
>   started by Dmitry [2], but
>   1. with the activeness/idleness tracking happening at the VM
>      granularity, having per-BO LRUs would caused a lot of
>      list_move()s that are not really needed (the VM as a whole
>      become active/idle, we can track individual BOs)
>   2. Thomas Zimmermann recently suggested that we should have our
>      own GEM implementation instead of trying to add this extra reclaim
>      complexity to gem-shmem. There are some plans to create a
>      gem-uma (Unified Memory Architecture) lib that would do more
>      than gem-shmem but in a way that doesn't force all its users
>      to pay the overhead (size overhead of the gem object, mostly)
>      for features they don't use. Patch "Part ways with
>      drm_gem_shmem_object" is showing what this component-based lib
>      API could look like if it were to be extracted
> - At the moment we only support swapout, but we could add an
>   extra flag to specify when buffer content doesn't need to be
>   preserved to avoid the swapout/swapin dance. First candidate for
>   this DISCARD_ON_RECLAIM flag would probably be the tiler heap chunks.
> - Reclaim uses _try_lock() all the way because of the various lock order
>   inversions between the reclaim path and submission paths. That means
>   we don't try very hard to reclaim hot GPU buffers, but the locking is
>   such a mess that I don't really see a better option to be honest.
> 
> 
> Changes in v2:
> - No fundamental changes in this v2, since the feedback I got were more
>   focused on bugs than the overall approach. Check the changelog in each
>   patch for more details.
> 
> Changes in v3:
> - Mostly fixes (see the changelog in each patch)
> 
> Changes in v4:
> - Only fixes (see the changelog in each patch)
> 
> Changes in v5:
> - Only fixes (see the changelog in each patch)
> 
> Changes in v6:
> - Fix huge fault handling and various other things reported by Adrian
>   and the review bot (see the changelog in each patch for more)
> 
> Regards,
> 
> Boris
> 
> [1]https://gitlab.freedesktop.org/bbrezillon/igt-gpu-tools/-/commit/fc76934a5579767d2aabe787d40e38a17c3f4ea4
> [2]https://lkml.org/lkml/2024/1/5/665
> 
> Akash Goel (1):
>   drm/panthor: Add a GEM shrinker
> 
> Boris Brezillon (8):
>   drm/gem: Consider GEM object reclaimable if shrinking fails
>   drm/panthor: Move panthor_gems_debugfs_init() to panthor_gem.c
>   drm/panthor: Group panthor_kernel_bo_xxx() helpers
>   drm/panthor: Don't call drm_gpuvm_bo_extobj_add() if the object is
>     private
>   drm/panthor: Part ways with drm_gem_shmem_object
>   drm/panthor: Lazily allocate pages on mmap()
>   drm/panthor: Split panthor_vm_prepare_map_op_ctx() to prepare for
>     reclaim
>   drm/panthor: Track the number of mmap on a BO
> 
>  drivers/gpu/drm/drm_gem.c                |   10 +
>  drivers/gpu/drm/panthor/Kconfig          |    1 -
>  drivers/gpu/drm/panthor/panthor_device.c |   11 +-
>  drivers/gpu/drm/panthor/panthor_device.h |   73 ++
>  drivers/gpu/drm/panthor/panthor_drv.c    |   33 +-
>  drivers/gpu/drm/panthor/panthor_fw.c     |   16 +-
>  drivers/gpu/drm/panthor/panthor_gem.c    | 1453 ++++++++++++++++++----
>  drivers/gpu/drm/panthor/panthor_gem.h    |  136 +-
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  502 ++++++--
>  drivers/gpu/drm/panthor/panthor_mmu.h    |    8 +
>  drivers/gpu/drm/panthor/panthor_sched.c  |    9 +-
>  11 files changed, 1911 insertions(+), 341 deletions(-)
> 

