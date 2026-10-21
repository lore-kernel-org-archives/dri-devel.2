Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C88606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LBtTFIqt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05D010E2A6;
	Wed, 21 Oct 2026 12:43:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0783610E2A6
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:43:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B36916F8;
 Wed, 21 Oct 2026 05:43:35 -0700 (PDT)
Received: from [10.57.58.237] (unknown [10.57.58.237])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93D1C3F7B4;
 Wed, 21 Oct 2026 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792586618; bh=cjAvjns15MXV2cIQJYlP4P40G/iW76jQ0gfloKZ0dew=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LBtTFIqtLzouGPYCiZEW+rOhdH5yj+hOeNzs50f1FZtljJbiJvPIpC7uzEsy9LucK
 YpTTQB8ccJ95sCH9XF79WC5GFH6QEyT2r7lbrS+1p3/zPF9PNNSWJC6l2W9IEssqF3
 VNbU3btxd+6vKDqf7q25ao/DRUNvwqpMfqFYlYKw=
Message-ID: <cea31016-bffe-4d15-8fd2-1131b1e63aaa@arm.com>
Date: Wed, 21 Oct 2026 13:43:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] drm/panfrost: GPU fault cascade ends in kernel memory
 corruption on Mali-G52 (RK3566)
To: Joel Winarske <joel.winarske@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?=
 <adrian.larumbe@collabora.com>
Cc: Joel Winarske <joel.winarske@linux.com>, dri-devel@lists.freedesktop.org
References: <20261020152450.2901040-1-joel.winarske@linux.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261020152450.2901040-1-joel.winarske@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 20/10/2026 16:24, Joel Winarske wrote:
> Hi,
> 
> On a Mali-G52 (Rockchip RK3566), a run of job timeouts and soft-stop
> failures ends with the kernel taking paging requests at corrupt
> addresses, and an oops on the next fork(). The machine does not panic:
> it keeps running and keeps routing packets, but every process that
> clones a VMA dies, so it is unusable and needs a power cycle.
> 
> I have ruled out the obvious candidate before writing -- details below
> -- so I am fairly sure this is not the 2019 per-slot reset race.
> Happy to be told otherwise.
> 
> The sequence
> ============
> 
> Captured over netconsole, because everything on the box stops before it
> can write to disk:
> 
>   panfrost fde60000.gpu: Soft-stop failed
>   panfrost fde60000.gpu: Soft-stop failed
>   panfrost fde60000.gpu: gpu sched timeout, js=1, config=0x7300,
>                          status=0x8, head=0xd73cf480, tail=0xd73cecc0,
>                          sched_job=00000000317fe955
>   panfrost fde60000.gpu: Unhandled Page fault in AS0 at VA 0x000000001E0C2900
>             raw fault status: 0x664003C2
>             decoded fault status: SLAVE FAULT
>             exception type 0xC2: TRANSLATION_FAULT_2
>             access type 0x3: WRITE
>             source id 0x6640
>   panfrost fde60000.gpu: js fault, js=0, status=DATA_INVALID_FAULT,
>                          head=0xd496dfc0, tail=0xd496dfc0
>   Unable to handle kernel paging request at virtual address 3f87ae4e3f41d124
>   Unable to handle kernel paging request at virtual address ffff3a2c0129b997
>   Internal error: Oops: 0000000096000004 [#1] SMP
>     EC = 0x25: DABT (current EL), FSC = 0x04: level 0 translation fault
>   CPU: 0 PID: 1 Comm: systemd Tainted: G        W  O
>        6.1.84-10-rk2410-nocsf #10

This is a vendor kernel... Generally we try not to spend much time on
bug reports from a vendor kernel because we don't know what changes
might have been made. I note you claim there isn't much difference
(checking the panfrost code), but we don't even know whether this is a
panfrost issue or if something else in the kernel is broken.

>   Hardware name: Radxa ZERO 3 (DT)
>   pc : anon_vma_interval_tree_insert+0x90/0xb4
>   Call trace:
>     anon_vma_interval_tree_insert+0x90/0xb4
>     anon_vma_clone+0x110/0x144
>     anon_vma_fork+0x30/0x134
>     dup_mmap+0x2c4/0x4bc
>     copy_process+0xa84/0x1314
>     kernel_clone+0xb0/0x288
>     __do_sys_clone+0x68/0x9c
>     __arm64_sys_clone+0x20/0x28
> 

[...]

> What I do not have
> ==================
> 
> - A mainline reproduction. It is a vendor kernel, though as above its
>   panfrost is upstream's to nine API-signature lines, so "vendor
>   kernel" is not by itself the explanation. If reproducing on mainline
>   is the precondition for looking at this, say so and I will see what
>   I can arrange.

It would be a very good start to see if this happens with mainline.
Ideally test with the newly released v7.3 so we can see if there are any
recent fixes.

Obviously one outcome might be that a bug fix needs to be backported to
a stable branch - but if we know mainline doesn't reproduce then "git
bisect" can be used to track down the fix. Or if it does reproduce then
obviously we want to fix it upstream.

> - A minimal reproducer. The trigger is a full application rendering a
>   large scene.

The most useful thing is a reliable reproducer - if you can produce a
minimal reproducer then others can help out with testing, but I wouldn't
spend much time on that at this point. But see below.

> - A devcoredump: the driver logs "failed to allocate devcoredump file"
>   at exactly the moment one would be most useful.

devcoredump is unlikely to help. There's a small possibility of
identifying why the soft-stop failed - but the far more interesting
thing is why the kernel faults afterwards occurred. And most likely they
have the same root cause.

>   panfrost_core_dump(job) is called from panfrost_job_timedout()
>   immediately before the reset, so that may deserve its own look.
> - Determinism. Five runs in an identical environment gave one cascade
>   and four clean runs.

If you can make the test reliably show the issue then debugging would be
much easier - otherwise you'll have to run the test multiple times and
hope that e.g. 20 runs without issue isn't just fluke but actually
points to the issue being fixed.

> Environment
> ===========
> 
>   Mali-G52 r1 MC1 on Rockchip RK3566
>   mali-g52 id 0x7402 major 0x1 minor 0x0
>   [drm] Initialized panfrost 1.2.0 20180908 for fde60000.gpu on minor 1
>   features: 00000000,00000cf7  issues: 00000000,00000400
>   kernel 6.1.84-10-rk2410-nocsf #10 (Rockchip BSP), aarch64
>   taint G W O -- out-of-tree panel_mipi_dbi, gpio_backlight
> 
> Userspace is panvk (Mesa 26.3.0-devel), which needs
> PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1. A separate userspace problem on
> the same hardware is filed as mesa/mesa#16595; this report is only
> about the kernel turning a GPU fault into memory corruption, which no
> userspace submission should be able to do.

User space shouldn't be able to break the kernel - so that's fine. We
can debug the kernel issues. Although clearly if you want a reliable
driver for user space you should be wary of that
PAN_I_WANT_A_BROKEN_VULKAN_DRIVER flag.

Finally I'd appreciate it if you limit the use of AI to write your
emails. Panfrost recently merged an AI policy for Mesa[1], and this part
is particularly relevant:

> We also do not want AI-generated issue reports and other project communication.
> This is because reports like that tend to be overly verbose and often
> confusing to read. We prefer a short report written by a human over a wall of
> text written by a machine. We can always ask for more details when needed.

[1]
https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/docs/drivers/panfrost.rst?ref_type=heads#ai-policy

Thanks,
Steve

