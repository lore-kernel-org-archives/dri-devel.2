Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624D5C9830D
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 03:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9CE810F2B0;
	Thu, 24 Sep 2026 03:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kyBEjEPJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994E810F2B0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 03:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790220701; x=1821756701;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=H1jkAmvIJl45FG24xogw+kSeZTMxdV3R3wMWwJodV+U=;
 b=kyBEjEPJdkZOUnwZyiy9SLaEFCmxQttGdSjGOPWpei9j7Ywv+WGnuBC4
 xsXQZev87ZRa9+TgrJSG5aQTyoKAeegDsI16Lj6u4nUTH/tBCEbFpftsv
 AKORys6evXeJWTAHMfehOuutMwW6TPAGkcNV091k7VhfXjHYutNs072XN
 pjzAPi/3EVTRNXOSToxxwm9hfbn2nHjNOXpxLamNSxI3Sz5+nVDQWdn72
 H28hsq3xIIRL1BFcq7ye3hOYKE+q3ilc/jpAxxT4IXXWHVtBsvw6YnAyg
 03W+FUsVs+mcgLpx3j7yxaNivsZC4OL6QIxGp9L/PQmiTTFJyleOPDuXA w==;
X-CSE-ConnectionGUID: g2yRD2IzR0agtF2FdzvL+Q==
X-CSE-MsgGUID: mLuzn5hUSiatMybIfKCj3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1492886"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="1492886"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 20:31:40 -0700
X-CSE-ConnectionGUID: f27awtTlTCacrCx3gHSrVQ==
X-CSE-MsgGUID: kezlQk1OTY+VOjIGFLjHtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; d="scan'208";a="272484925"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation)
 ([10.239.182.64])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 20:31:38 -0700
Date: Thu, 24 Sep 2026 11:31:35 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, dri-devel@lists.freedesktop.org,
 yi1.lai@intel.com
Subject: [mripard:drm/reset-state-flag] [drm/vkms]  3d18732b92:
 WARNING:at_drivers/gpu/drm/drm_property.c:#drm_property_create
Message-ID: <202609240921.8ca95532-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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



Hello,

kernel test robot noticed "WARNING:at_drivers/gpu/drm/drm_property.c:#drm_property_create" on:

commit: 3d18732b927902aaa841e0ebb77f3feaf8e519a9 ("drm/vkms: Add driver-specific plane property for testing") https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git drm/reset-state-flag

in testcase: boot

config: x86_64-randconfig-123-20260911
compiler: clang-22
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 4 -m 16G

If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202609240921.8ca95532-lkp@intel.com



[   16.128490][    T1] ------------[ cut here ]------------
[   16.131898][    T1] WARNING: drivers/gpu/drm/drm_property.c:107 at drm_property_create+0x44f/0x500, CPU#0: swapper/0/1
[   16.138834][    T1] Modules linked in:
[   16.142626][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   7.3.0-rc1-00366-g3d18732b9279 #1 PREEMPTLAZY
[   16.153490][    T1] Tainted: [T]=RANDSTRUCT
[   16.157939][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   16.173562][    T1] RIP: 0010:drm_property_create (gpu/drm/drm_property.c:107 (discriminator 6))
[   16.177872][    T1] Code: 48 89 df e8 d3 2e 2d fe 4c 89 33 e9 e1 fe ff ff e8 06 44 fc fd e9 6a fd ff ff e8 fc 43 fc fd e9 60 fd ff ff e8 f2 43 fc fd 90 <0f> 0b 90 e9 bc fe ff ff e8 e4 43 fc fd 49 8d 5f 58 48 89 d8 48 c1
All code
========
   0:	48 89 df             	mov    %rbx,%rdi
   3:	e8 d3 2e 2d fe       	call   0xfffffffffe2d2edb
   8:	4c 89 33             	mov    %r14,(%rbx)
   b:	e9 e1 fe ff ff       	jmp    0xfffffffffffffef1
  10:	e8 06 44 fc fd       	call   0xfffffffffdfc441b
  15:	e9 6a fd ff ff       	jmp    0xfffffffffffffd84
  1a:	e8 fc 43 fc fd       	call   0xfffffffffdfc441b
  1f:	e9 60 fd ff ff       	jmp    0xfffffffffffffd84
  24:	e8 f2 43 fc fd       	call   0xfffffffffdfc441b
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	e9 bc fe ff ff       	jmp    0xfffffffffffffeee
  32:	e8 e4 43 fc fd       	call   0xfffffffffdfc441b
  37:	49 8d 5f 58          	lea    0x58(%r15),%rbx
  3b:	48 89 d8             	mov    %rbx,%rax
  3e:	48                   	rex.W
  3f:	c1                   	.byte 0xc1

Code starting with the faulting instruction ===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	e9 bc fe ff ff       	jmp    0xfffffffffffffec4
   8:	e8 e4 43 fc fd       	call   0xfffffffffdfc43f1
   d:	49 8d 5f 58          	lea    0x58(%r15),%rbx
  11:	48 89 d8             	mov    %rbx,%rax
  14:	48                   	rex.W
  15:	c1                   	.byte 0xc1
[   16.191481][    T1] RSP: 0000:ffff88810080f9b8 EFLAGS: 00010293
[   16.195316][    T1] RAX: ffffffff834b20ce RBX: ffffffff85df7840 RCX: ffff888100805400
[   16.200307][    T1] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffff85df7840
[   16.205474][    T1] RBP: 0000000000000002 R08: 00000000ffffffff R09: 0000000000000001
[   16.210508][    T1] R10: ffff888100dd60a9 R11: ffffed10201bac17 R12: ffff8881243cc000
[   16.215541][    T1] R13: 0000000000000002 R14: ffffffff85df7840 R15: 0000000000000000
[   16.220642][    T1] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[   16.226465][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.230647][    T1] CR2: ffff88883ffff000 CR3: 00000000074ab000 CR4: 00000000000406b0
[   16.235620][    T1] Call Trace:
[   16.237793][    T1]  <TASK>
[   16.239612][    T1]  drm_property_create_range (gpu/drm/drm_property.c:248 gpu/drm/drm_property.c:281)
[   16.243716][    T1]  vkms_plane_init (gpu/drm/vkms/vkms_plane.c:335)
[   16.249316][    T1]  vkms_output_init (gpu/drm/vkms/vkms_output.c:23)
[   16.253612][    T1]  vkms_create (gpu/drm/vkms/vkms_drv.c:157)
[   16.257515][    T1]  ? vgem_init (vgem_drv.c:?)
[   16.261493][    T1]  vkms_init (gpu/drm/vkms/vkms_drv.c:240)
[   16.265247][    T1]  do_one_initcall (main.c:1357)
[   16.269406][    T1]  ? kvm_clock_get_cycles (x86/kernel/kvmclock.c:81 (discriminator 257))
[   16.273596][    T1]  ? ktime_get (time/timekeeping.c:1008)
[   16.277336][    T1]  ? lockdep_hardirqs_on_prepare (locking/lockdep.c:470)
[   16.281688][    T1]  ? irqentry_exit (linux/irq-entry-common.h:507)
[   16.284933][    T1]  ? irqentry_exit (linux/irq-entry-common.h:507)
[   16.287804][    T1]  ? lockdep_hardirqs_on (locking/lockdep.c:4488)
[   16.294913][    T1]  ? irqentry_exit (linux/irq-entry-common.h:507)
[   16.298066][    T1]  ? strlen (string.c:402 (discriminator 1))
[   16.300438][    T1]  ? next_arg (cmdline.c:276 (discriminator 1024))
[   16.303260][    T1]  ? parameq (params.c:91 (discriminator 1792))
[   16.305908][    T1]  ? parse_args (params.c:177 (discriminator 1281))
[   16.308825][    T1]  ? __kasan_kmalloc (kasan/common.c:398 kasan/common.c:415)
[   16.311896][    T1]  do_initcall_level (main.c:1419 (discriminator 1))
[   16.315225][    T1]  do_initcalls (main.c:1435)
[   16.317948][    T1]  kernel_init_freeable (main.c:1670)
[   16.321217][    T1]  ? rest_init (main.c:?)
[   16.323799][    T1]  kernel_init (main.c:1560)
[   16.326645][    T1]  ? rest_init (main.c:?)
[   16.329510][    T1]  ret_from_fork (x86/kernel/process.c:158)
[   16.332366][    T1]  ? rest_init (main.c:?)
[   16.335223][    T1]  ret_from_fork_asm (x86/entry/entry_64.S:245)
[   16.338294][    T1]  </TASK>
[   16.340000][    T1] irq event stamp: 158901
[   16.344134][    T1] hardirqs last  enabled at (158921): __console_unlock (printk/printk.c:347 (discriminator 3) printk/printk.c:2932 (discriminator 3))
[   16.353660][    T1] hardirqs last disabled at (158940): __console_unlock (printk/printk.c:345 (discriminator 6) printk/printk.c:2932 (discriminator 6))
[   16.362876][    T1] softirqs last  enabled at (158574): __irq_exit_rcu (softirq.c:679 softirq.c:519 softirq.c:767)
[   16.370862][    T1] softirqs last disabled at (158565): __irq_exit_rcu (softirq.c:679 softirq.c:519 softirq.c:767)
[   16.377646][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260924/202609240921.8ca95532-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


