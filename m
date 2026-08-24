Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934BCC5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E594C10E144;
	Mon, 24 Aug 2026 16:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KSlPArAI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC84510E144
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 16:07:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07C07600E2;
 Mon, 24 Aug 2026 16:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D43E1F000E9;
 Mon, 24 Aug 2026 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787587643;
 bh=20pQvqMreM0ea0iSvkQ0l/JafDIw6QJ6G3Kq50llONw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KSlPArAIDF2d3XsnKZTHVdlZGyQqHNOWEiVS4dBRW/0a2tMsjL4CUeHGXUQAFkRa5
 37DFqLbP3Y+TcX2eykGos7OYiTOmUuAN5ITvStWHmFZEPk5zumu7nsDo3v9lUVJ3Y4
 tENwioiPNnmCxrxA0MNCrxgXxSNfO1m3RsSXC/R0YRtNXZ4GqU/+j4QuWcsMiqqfwV
 QV+9GhfKFiwBthdMQbr3nG4jOmmZLQXhE6hvGDiXGkylhtQ4ei1M3bOuq2jsf9L1UN
 eIp53mS1Q1THGfdVMLd6QTmZjYLP2FArliGfmOeWcInkBTzWD1dJ3fsHwGMc+X2wx6
 5q7/0RbpnKDGQ==
From: sashiko-bot@kernel.org
Subject: Re: [BUG] WARNING: refcount bug in sync_timeline_signal
To: "Jaeyoung Chung" <jjy600901@snu.ac.kr>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260824155629.2370441-1-jjy600901@snu.ac.kr>
References: <20260824155629.2370441-1-jjy600901@snu.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 16:07:23 +0000
Message-Id: <20260824160723.8D43E1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The commit improperly merges fuzzer reproducer code that intention=
ally stalls the kernel, introducing a severe 50ms delay inside a spinlock w=
ith local interrupts disabled.

Pre-existing issues:
- [Critical] Calling `dma_fence_get()` in `sync_timeline_signal()` on a fen=
ce whose refcount may have already dropped to 0 leads to a use-after-free, =
double-free, and rb-tree corruption.
--

--- Patch [1]: [BUG] WARNING: refcount bug in sync_timeline_signal ---
commit 6c2b9513def2f661abe36d3f3a4c129d8212ea60
Author: Jaeyoung Chung <jjy600901@snu.ac.kr>

WARNING: refcount bug in sync_timeline_signal

This commit merges a fuzzer's reproducer delay patch directly into the
sw_sync subsystem. It does not provide a fix for the underlying race
condition, but instead introduces an intentional delay.

> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9e..d30ce9d915ba7 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c

[ ... ]

> @@ -215,6 +216,10 @@ static void sync_timeline_signal(struct sync_timelin=
e *obj, unsigned int inc)
> =20
>  	spin_lock_irq(&obj->lock);
> =20
> +	if (strncmp(current->comm, "syzrepro1", 9) =3D=3D 0) {
> +		mdelay(50);
> +	}
> +

[Severity: High]
Is it intentional to merge reproducer delay code into the tree?

Adding a 50-millisecond busy loop (mdelay(50)) inside a critical section
protected by spin_lock_irq(&obj->lock) in sync_timeline_signal() can cause
severe latency spikes and missed hardware interrupts.

An unprivileged user could trigger this by naming their task 'syzrepro1' and
interacting with the sw_sync subsystem to create a local Denial of Service.

>  	obj->value +=3D inc;
> =20
>  	list_for_each_entry_safe(pt, next, &obj->pt_list, link) {

[Severity: Critical]
This is a pre-existing issue, but does sync_timeline_signal() unsafely
call dma_fence_get() on a fence whose refcount may have already dropped to =
0?

When a userspace program closes a sync_file descriptor, it drops the
underlying sync_pt fence refcount to 0, which triggers
timeline_fence_release().

timeline_fence_release() blocks waiting for obj->lock. Concurrently, if
sync_timeline_signal() holds obj->lock and iterates over obj->pt_list, it
encounters the 0-refcount fence and unconditionally calls
dma_fence_get(&pt->base):

drivers/dma-buf/sw_sync.c:sync_timeline_signal() {
    ...
    dma_fence_get(&pt->base);
    list_move_tail(&pt->link, &signalled);
    rb_erase(&pt->node, &obj->pt_tree);
    ...
}

It then moves the fence to a local list, erases it from the tree, and
unlocks.

timeline_fence_release() then acquires the lock, illegally modifies the oth=
er
thread's local list, performs a double rb_erase() on the tree, and frees the
fence:

drivers/dma-buf/sw_sync.c:timeline_fence_release() {
    ...
    if (!list_empty(&pt->link)) {
        list_del(&pt->link);
        rb_erase(&pt->node, &parent->pt_tree);
    }
    ...
}

Finally, sync_timeline_signal() iterates its local list, accessing and
putting the freed fence, leading to a use-after-free and double free.

Would using dma_fence_get_rcu() in sync_timeline_signal() safely increment
the refcount only if it is non-zero?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824155629.2370=
441-1-jjy600901@snu.ac.kr?part=3D1
