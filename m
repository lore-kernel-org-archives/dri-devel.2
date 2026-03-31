Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07681FF60CF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62FD810E8B6;
	Tue, 31 Mar 2026 07:31:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Bk+G/VD4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4CF10E8B6
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774942314;
 bh=0Dcz6zVA6PKIwhW4Tsb1JO6a1ZraRnp80v262+5hZ2k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Bk+G/VD430PhNxWJYCvXTflAsPGbhrLSdPyZksxcr++Dhat+4YSx1pLiOybf015s9
 cvPxoH7BywoRD2ePLmDKm+Sr6Tlcf7xn/5E82zjutjB2o5BYxpe9J9SuS3ZyAUf0M9
 2uxrWYTqQbLI6bNn+Jhkukx3N7aYl7fyWYcSXv/ZCPtjTLNDfFaPJJbyh4ZQpJubWo
 SGQecNvAT1WM6AYg/ucuKt2lR9sLZuUyx3sSoIwZ+mvo/yAOpoDpfFboOaS9DLIET1
 7caYWnusIGgDFynuyP5qXWgaUuiYRG3FCqBIhx1CcEPBZYtDpsgsJKp8pcGvlN2XqR
 DTZj9N2nS29LA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BDDF917E5AFF;
 Tue, 31 Mar 2026 09:31:53 +0200 (CEST)
Date: Tue, 31 Mar 2026 09:31:49 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, =?UTF-8?B?QWRyacOhbg==?= Larumbe
 <adrian.larumbe@collabora.com>, dri-devel@lists.freedesktop.org, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Akash Goel
 <akash.goel@arm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul
 <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, Akhil P Oommen
 <akhilpo@oss.qualcomm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Chris Diamand <chris.diamand@arm.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>,
 Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com
Subject: Re: [PATCH v6 0/9] drm/panthor: Add a GEM shrinker
Message-ID: <20260331093149.20c28332@fedora>
In-Reply-To: <8b2b65a3-3db8-469f-90ae-6abccdb3c71a@arm.com>
References: <20260330094848.2169422-1-boris.brezillon@collabora.com>
 <8b2b65a3-3db8-469f-90ae-6abccdb3c71a@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 30 Mar 2026 11:39:00 +0100
Steven Price <steven.price@arm.com> wrote:

> Hi Boris,
> 
> On 30/03/2026 10:48, Boris Brezillon wrote:
> > Hello,
> > 
> > This is an attempt at adding a GEM shrinker to panthor so the system
> > can finally reclaim GPU memory.
> > 
> > This implementation is losely based on the MSM shrinker (which is why
> > I added the MSM maintainers in Cc), and it's relying on the drm_gpuvm
> > eviction/validation infrastructure.
> > 
> > I've only done very basic IGT-based [1] and chromium-based (opening
> > a lot of tabs on Aquarium until the system starts reclaiming+swapping
> > out GPU buffers) testing, but I'm posting this early so I can get
> > preliminary feedback on the implementation. If someone knows about
> > better tools/ways to test the shrinker, please let me know.  
> 
> I did my own pretty basic testing (glmark with memhog) and managed to hit this:
> 
> [  265.053172] ============================================
> [  265.053667] WARNING: possible recursive locking detected
> [  265.054159] 7.0.0-rc3-00694-gadfa5ca08767 #1 Not tainted
> [  265.054655] --------------------------------------------
> [  265.055143] glmark2-es2-drm/443 is trying to acquire lock:
> [  265.055651] ffff0001194011a8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: drm_gpuvm_bo_deferred_cleanup+0x100/0x2c0 [drm_gpuvm]
> [  265.056738] 
> [  265.056738] but task is already holding lock:
> [  265.057278] ffff80008b7c79e8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: panthor_ioctl_group_submit+0x424/0x560 [panthor]
> [  265.058324] 
> [  265.058324] other info that might help us debug this:
> [  265.058927]  Possible unsafe locking scenario:
> [  265.058927] 
> [  265.059475]        CPU0
> [  265.059706]        ----
> [  265.059939]   lock(reservation_ww_class_mutex);
> [  265.060365]   lock(reservation_ww_class_mutex);
> [  265.060788] 
> [  265.060788]  *** DEADLOCK ***
> [  265.060788] 
> [  265.061338]  May be due to missing lock nesting notation
> [  265.061338] 
> [  265.061964] 3 locks held by glmark2-es2-drm/443:
> [  265.062395]  #0: ffff80008493c458 (drm_unplug_srcu){.+.+}-{0:0}, at: drm_dev_enter+0x0/0x140
> [  265.063188]  #1: ffff80008b7c79c0 (reservation_ww_class_acquire){+.+.}-{0:0}, at: panthor_ioctl_group_submit+0x424/0x560 [panthor]
> [  265.064288]  #2: ffff80008b7c79e8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: panthor_ioctl_group_submit+0x424/0x560 [panthor]
> [  265.065370] 
> [  265.065370] stack backtrace:
> [  265.065780] CPU: 4 UID: 1000 PID: 443 Comm: glmark2-es2-drm Not tainted 7.0.0-rc3-00694-gadfa5ca08767 #1 PREEMPT 
> [  265.065787] Hardware name: Radxa ROCK 5B (DT)
> [  265.065791] Call trace:
> [  265.065793]  show_stack+0x18/0x24 (C)
> [  265.065802]  dump_stack_lvl+0x6c/0x94
> [  265.065810]  dump_stack+0x1c/0x28
> [  265.065815]  print_deadlock_bug+0x224/0x238
> [  265.065822]  __lock_acquire+0xe54/0x1600
> [  265.065829]  lock_acquire+0x3cc/0x420
> [  265.065834]  __ww_mutex_lock.constprop.0+0x1fc/0x2c40
> [  265.065844]  ww_mutex_lock+0x50/0x168
> [  265.065850]  drm_gpuvm_bo_deferred_cleanup+0x100/0x2c0 [drm_gpuvm]
> [  265.065862]  panthor_vm_cleanup_op_ctx+0x188/0x270 [panthor]
> [  265.065881]  panthor_vm_bo_validate+0x404/0x758 [panthor]
> [  265.065898]  drm_gpuvm_validate+0x28c/0xf50 [drm_gpuvm]
> [  265.065907]  panthor_vm_prepare_mapped_bos_resvs+0x64/0x80 [panthor]
> [  265.065925]  panthor_ioctl_group_submit+0x418/0x560 [panthor]
> [  265.065942]  drm_ioctl_kernel+0x15c/0x2c0
> [  265.065947]  drm_ioctl+0x56c/0xb1c
> [  265.065952]  __arm64_sys_ioctl+0x124/0x1a4
> [  265.065961]  invoke_syscall+0x70/0x260
> [  265.065967]  el0_svc_common.constprop.0+0xac/0x230
> [  265.065972]  do_el0_svc+0x40/0x58
> [  265.065976]  el0_svc+0x4c/0x210
> [  265.065981]  el0t_64_sync_handler+0xa0/0xe4
> [  265.065986]  el0t_64_sync+0x198/0x19c
> 

Nice catch! I've fixed it by skipping the
drm_gpuvm_bo_deferred_cleanup() call in panthor_vm_cleanup_op_ctx()
when the operation is a VMA repopulation. In that case, the VM resv
lock will be held (because the SUBMIT logic acquires it), and the very
same lock is taken in drm_gpuvm_bo_deferred_cleanup(). We could have
added a drm_gpuvm_bo_deferred_cleanup_locked() variant, but in
practice, the VMA repopulation never calls drm_gpuvm_bo_put_deferred(),
so there's nothing for us to cleanup, and the only reason we were going
past the if (!bo_defer) test in drm_gpuvm_bo_deferred_cleanup() is
because other threads can race with the VMA repopulation and queue
vm_bos to the deferred cleanup list.

TLDR; this should be sorted out in v7, which I plan to post soon (I'd
like to maximize the time this patch series spends in linux-next so we
can detect issues early and fix them before it hits Linus' tree).
