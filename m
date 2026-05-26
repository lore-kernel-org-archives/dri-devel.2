Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EC7CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 19:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A8910E1DE;
	Tue, 26 May 2026 19:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vC+5haJr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2358B10E1DE
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 19:58:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FA8C60018;
 Tue, 26 May 2026 19:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662251F000E9;
 Tue, 26 May 2026 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1779825500;
 bh=lMQX5cmTdMhyiYzNOAjSjjruf4hIUXjs5/FMA2ixGi8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=vC+5haJrZXcnYfhXlK6XMFGrf8Pa12esbMowF6KHpRCbwN3adLP+YkMOUmlgJLbPX
 uEcdIH+WEbpHFRZtlJLmHKci0Rp4HSrsNhDknaSH2SjbtxwE66P0JVpXjys5uvU0BE
 hzg5G67c9oQ1F744OCJmCB8WNKnTSMwAMGJtxkyw=
Date: Tue, 26 May 2026 12:58:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+5d32c8bd82427f9c77cc@syzkaller.appspotmail.com>
Cc: apopple@nvidia.com, byungchul@sk.com, david@kernel.org,
 gourry@gourry.net, joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, matthew.brost@intel.com, rakie.kim@sk.com,
 syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, dri-devel@lists.freedesktop.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [syzbot] [mm?] WARNING in alloc_frozen_pages_noprof (2)
Message-Id: <20260526125818.d78b7db78d26df094258f8dd@linux-foundation.org>
In-Reply-To: <6a150a33.2b0a0220.185dbd.0005.GAE@google.com>
References: <6a150a33.2b0a0220.185dbd.0005.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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

On Mon, 25 May 2026 19:49:23 -0700 syzbot <syzbot+5d32c8bd82427f9c77cc@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4cbfe4502e3d Merge tag 'v7.1-rc5-ksmbd-server-fixes' of gi..
> git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
> console output: https://syzkaller.appspot.com/x/log.txt?x=146c161f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9475bd041c93289
> dashboard link: https://syzkaller.appspot.com/bug?extid=5d32c8bd82427f9c77cc
> compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11026336580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ab9796580000

Thanks.

> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-4cbfe450.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e825a08fb48d/vmlinux-4cbfe450.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/55037c053ec3/Image-4cbfe450.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5d32c8bd82427f9c77cc@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: mm/page_alloc.c:5202 at __alloc_frozen_pages_noprof+0x734/0x1144 mm/page_alloc.c:5202, CPU#0: syz.2.17/3592

	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))

> Modules linked in:
> CPU: 0 UID: 0 PID: 3592 Comm: syz.2.17 Not tainted syzkaller #0 PREEMPT 
> Hardware name: linux,dummy-virt (DT)
> pstate: 21402009 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : __alloc_frozen_pages_noprof+0x734/0x1144 mm/page_alloc.c:5202
> lr : alloc_pages_mpol+0x70/0x1a4 mm/mempolicy.c:2490
> sp : ffff800085d93900
> x29: ffff800085d93a00 x28: 000000000000000b x27: 0000000000000000
> x26: 0000000000000000 x25: fcf0000014c00000 x24: 0000000000040dc0
> x23: 0000000000000000 x22: 0000000000000000 x21: 000000000000000b
> x20: ffffffffffffffff x19: 0000000000000000 x18: 0000000000000002
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000020000200
> x14: ffff8000828b2000 x13: ffffc1ffc0000000 x12: 0000000000000001
> x11: 0000000000000000 x10: ffff800082b6f4e8 x9 : 0000000000000000
> x8 : 0000000000000030 x7 : ffff800082e9b430 x6 : 0000000000000001
> x5 : 0000000000000000 x4 : f3f00000065c90c0 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffff800082dfd000
> Call trace:
>  __alloc_frozen_pages_noprof+0x734/0x1144 mm/page_alloc.c:5202 (P)
>  alloc_pages_mpol+0x70/0x1a4 mm/mempolicy.c:2490
>  alloc_frozen_pages_noprof+0x48/0xd4 mm/mempolicy.c:2561
>  ___kmalloc_large_node+0x11c/0x13c mm/slub.c:5237
>  __kmalloc_large_node_noprof mm/slub.c:5268 [inline]
>  __do_kmalloc_node mm/slub.c:5284 [inline]
>  __kmalloc_noprof+0x450/0x560 mm/slub.c:5308
>  kmalloc_noprof include/linux/slab.h:954 [inline]
>  kzalloc_noprof include/linux/slab.h:1188 [inline]
>  fill_object_idr drivers/gpu/drm/drm_lease.c:389 [inline]
>  drm_mode_create_lease_ioctl+0x184/0x93c drivers/gpu/drm/drm_lease.c:521
>  drm_ioctl_kernel+0xc0/0x130 drivers/gpu/drm/drm_ioctl.c:804
>  drm_ioctl+0x258/0x580 drivers/gpu/drm/drm_ioctl.c:901
>  vfs_ioctl fs/ioctl.c:51 [inline]

Methinks drm_mode_create_lease_ioctl() wants some more arg checking.

otoh, memdup_user() passes __GFP_NOWARN, so perhaps
__alloc_frozen_pages_noprof() should be taught to honor that.

>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __arm64_sys_ioctl+0xac/0x104 fs/ioctl.c:583
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x54/0x10c arch/arm64/kernel/syscall.c:49
>  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:121
>  do_el0_svc+0x1c/0x34 arch/arm64/kernel/syscall.c:140
>  el0_svc+0x38/0x140 arch/arm64/kernel/entry-common.c:740
>  el0t_64_sync_handler+0xa0/0xf0 arch/arm64/kernel/entry-common.c:759
>  el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:594
> ---[ end trace 0000000000000000 ]---

