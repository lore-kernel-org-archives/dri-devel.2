Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8C2E6400F
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 04:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED03710E0F8;
	Sun,  5 Apr 2026 04:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="MoGCs1TA";
	dkim-atps=neutral
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8099210E0F8
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 04:48:01 +0000 (UTC)
Message-ID: <559ef477-1d93-4c52-b90e-4a790758d598@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1775364479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bf/9MBFSOja6BUaWbfBKRjL1h5PXO9yGtHvj7Ksf3NQ=;
 b=MoGCs1TAPgggMYBSB6mILFsHFKCC8yILxZUyPExWIAr2TcPm0WfgraVsmrl5VVCrsnlzX5
 +V8eGuBi6whJanO4bv/45U73/mA8QFTGG6U/9yHQQIcOxInosslhqS1jXVMRLZEoJKAZ3V
 /nfrSqXB24H5ccy+zAzW4caLuTRri2g=
Date: Sun, 5 Apr 2026 12:47:52 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] lib: test_hmm: Implement a device release method
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 david@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 dri-devel@lists.freedesktop.org, balbirs@nvidia.com
References: <20260331063445.3551404-1-apopple@nvidia.com>
 <20260331063445.3551404-4-apopple@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260331063445.3551404-4-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 3/31/26 2:34 PM, Alistair Popple wrote:
> Unloading the HMM test module produces the following warning:
> 
> [ 3782.224783] ------------[ cut here ]------------
> [ 3782.226323] Device 'hmm_dmirror0' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
> [ 3782.230570] WARNING: drivers/base/core.c:2567 at device_release+0x185/0x210, CPU#20: rmmod/1924
> [ 3782.233949] Modules linked in: test_hmm(-) nvidia_uvm(O) nvidia(O)
> [ 3782.236321] CPU: 20 UID: 0 PID: 1924 Comm: rmmod Tainted: G           O        7.0.0-rc1+ #374 PREEMPT(full)
> [ 3782.240226] Tainted: [O]=OOT_MODULE
> [ 3782.241639] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [ 3782.246193] RIP: 0010:device_release+0x185/0x210
> [ 3782.247860] Code: 00 00 fc ff df 48 8d 7b 50 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 86 00 00 00 48 8b 73 50 48 85 f6 74 11 48 8d 3d db 25 29 03 <67> 48 0f b9 3a e9 0d ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 89
> [ 3782.254211] RSP: 0018:ffff888126577d98 EFLAGS: 00010246
> [ 3782.256054] RAX: dffffc0000000000 RBX: ffffffffc2b70310 RCX: ffffffff8fe61ba1
> [ 3782.258512] RDX: 1ffffffff856e062 RSI: ffff88811341eea0 RDI: ffffffff91bbacb0
> [ 3782.261041] RBP: ffff888111475000 R08: 0000000000000001 R09: fffffbfff856e069
> [ 3782.263471] R10: ffffffffc2b7034b R11: 00000000ffffffff R12: 0000000000000000
> [ 3782.265983] R13: dffffc0000000000 R14: ffff88811341eea0 R15: 0000000000000000
> [ 3782.268443] FS:  00007fd5a3689040(0000) GS:ffff88842c8d0000(0000) knlGS:0000000000000000
> [ 3782.271236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3782.273251] CR2: 00007fd5a36d2c10 CR3: 00000001242b8000 CR4: 00000000000006f0
> [ 3782.275362] Call Trace:
> [ 3782.276071]  <TASK>
> [ 3782.276678]  kobject_put+0x146/0x270
> [ 3782.277731]  hmm_dmirror_exit+0x7a/0x130 [test_hmm]
> [ 3782.279135]  __do_sys_delete_module+0x341/0x510
> [ 3782.280438]  ? module_flags+0x300/0x300
> [ 3782.281547]  do_syscall_64+0x111/0x670
> [ 3782.282620]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [ 3782.284091] RIP: 0033:0x7fd5a3793b37
> [ 3782.285303] Code: 73 01 c3 48 8b 0d c9 82 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 82 0c 00 f7 d8 64 89 01 48
> [ 3782.290708] RSP: 002b:00007ffd68b7dc68 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [ 3782.292817] RAX: ffffffffffffffda RBX: 000055e3c0d1c770 RCX: 00007fd5a3793b37
> [ 3782.294735] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055e3c0d1c7d8
> [ 3782.296661] RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
> [ 3782.298622] R10: 00007fd5a3806ac0 R11: 0000000000000206 R12: 00007ffd68b7deb0
> [ 3782.300576] R13: 00007ffd68b7e781 R14: 000055e3c0d1b2a0 R15: 00007ffd68b7deb8
> [ 3782.301963]  </TASK>
> [ 3782.302371] irq event stamp: 5019
> [ 3782.302987] hardirqs last  enabled at (5027): [<ffffffff8cf1f062>] __up_console_sem+0x52/0x60
> [ 3782.304507] hardirqs last disabled at (5036): [<ffffffff8cf1f047>] __up_console_sem+0x37/0x60
> [ 3782.306086] softirqs last  enabled at (4940): [<ffffffff8cd9a4b0>] __irq_exit_rcu+0xc0/0xf0
> [ 3782.307567] softirqs last disabled at (4929): [<ffffffff8cd9a4b0>] __irq_exit_rcu+0xc0/0xf0
> [ 3782.309105] ---[ end trace 0000000000000000 ]---
> 
> This is because the test module doesn't have a device.release method. In
> this case one probably isn't needed for correctness - the device structs
> are in a static array so don't need freeing when the final reference
> goes away.
> 
> However some device state is freed on exit, so to ensure this happens at
> the right time and to silence the warning move the deinitialisation to
> a release method and assign that as the device release callback. Whilst
> here also fix a minor error handling bug where cdev_device_del() wasn't
> being called if allocation failed.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Tested-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Thanks,
Zenghui
