Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB294CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B862110E64C;
	Sat,  3 Oct 2026 02:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kccTHx+c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A0910E64C
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:54:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FC744191D;
 Sat,  3 Oct 2026 02:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB311F0089A;
 Sat,  3 Oct 2026 02:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790996099;
 bh=CBrjnXPKXFQu7lWRKTFgHjjbFmTIWKUeMTkXik5/Sy8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kccTHx+cxO3BLNx1W7aPOUSyhpRGIdoQFZ8WUXu9bddJFEUqpvpynNqhIEws0uKd7
 YDbqnakU0Vy27D8qqTnjPxq9wGhLUM32VCGU3Vk7KkBlS92z+spO5lQF4Sn/u7yGMZ
 gg+x10w1ri5rj5eJhSB/FK9YgTvvSCYHNFeELXPdq7/S5fs6j1M9I7S+KGUzTGblEv
 JwUDm25kflCpNG0C7T7Kij6FE95OIFwXdNWo2HBw1xcQaIZ9R82c4/Wpszny90gtQE
 QtlX/BEPYkivwJdx4tXjNSld8b/k24qf9Bi0dWgYXt+xfwT9m+XRIIN/OLHyRYgJ+h
 XGdsYt+VnbdUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] accel/qaic: Replace transfer completion with dma-fence
To: "Carl Vanderlip" <carl.vanderlip@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003023818.1161666-3-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
 <20261003023818.1161666-3-carl.vanderlip@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:54:58 +0000
Message-Id: <20261003025459.0AB311F0089A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] dma-fence: Unsignaled dma-fences and leaked callbacks on the e=
rror cleanup path
- [Critical] qaic: Race condition in qaic_fence_sync_cb_func causes NULL po=
inter dereference
- [Critical] dma-fence: Reusing embedded dma_fence_cb corrupts callback lis=
t pointers
- [High] dma-mapping: Concurrent CPU and device SGT synchronization due to =
fence signaling race
- [High] uapi: QAIC_WAIT_BO ioctl returns -ENOENT for idle buffers
- [High] dma-fence: Reused sequence numbers violate monotonically increasin=
g API contract
- [Medium] dma-mapping: Cancelled BO executions skip CPU DMA synchronization
- [Medium] uapi: Overriding -ERESTARTSYS with -EINTR breaks syscall restart=
 ABI
--

commit cb1752759fe062100cc452aaddf96c2432a9f99c
Author: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
accel/qaic: Replace transfer completion with dma-fence

This commit replaces completion mechanisms with dma-fences to signal finish=
ed
IRQ work. It integrates buffer synchronization with dma_resv and prepares f=
or
drm_sched support.

[Severity: Critical]
In drivers/accel/qaic/qaic_data.c, within the send_bo_list_to_device functi=
on
around line 1357, the error cleanup path removes previously queued buffer
objects from the transfer list without calling dma_fence_signal or
qaic_remove_bo_fence. Can this leak pending unsignaled fences into the
dma_resv object? Because qaic_acquire_bo_fence already added the fence to t=
he
reservation object, it appears the unsignaled fence could remain there
permanently. This might cause a deadlock for kernel or userspace components
waiting on the buffer implicit sync barriers, and the embedded cb might
remain registered to the leaked fence, resulting in a use-after-free when t=
he
buffer is destroyed.

[Severity: High]
Looking at qaic_fence_sync_cb_func in drivers/accel/qaic/qaic_fence.c around
line 42, the CPU DMA sync is performed asynchronously when the fence signal=
s.
However, in send_bo_list_to_device in drivers/accel/qaic/qaic_data.c around
line 1338, the device DMA sync runs upon resubmission. Could this race if t=
he
previous fence callback has not finished? A concurrent qaic_execute_bo_ioctl
could see bo_queued as false, acquire the lock, and resubmit the transfer.
This would allow the scheduler to run dma_sync_sgtable_for_device while the
IRQ thread is still executing dma_sync_sgtable_for_cpu, potentially violati=
ng
DMA API ownership rules and causing data corruption.

[Severity: High]
In the qaic_wait_bo_ioctl function in drivers/accel/qaic/qaic_data.c around
line 1899, the code now returns -ENOENT if the fence is missing. Does this
change break the userspace API behavior? Previously, a buffer with no pendi=
ng
operations returned 0 immediately because it waited on a pre-completed
completion. Applications expecting success when waiting on an already-idle =
or
newly-mapped buffer might now fail when receiving this error code instead.

[Severity: Medium]
When operations are aborted, such as in empty_xfer_list in
drivers/accel/qaic/qaic_data.c around line 2115, the fences are signaled wi=
th
-ECANCELED. Then, in qaic_fence_sync_cb_func in drivers/accel/qaic/qaic_fen=
ce.c
around line 38, the callback explicitly checks the error status and returns
early. Does this permanently skip the required CPU DMA sync for cancelled
operations? If dma_sync_sgtable_for_cpu is skipped, the memory might be left
indefinitely mapped in the device DMA domain, violating API ownership rules.

[Severity: High]
In drivers/accel/qaic/qaic_fence.c around line 77, qaic_create_fence
initializes the dma_fence with a hardcoded sequence number of 1. The context
is allocated once per buffer object in qaic_alloc_init_bo, located in
drivers/accel/qaic/qaic_data.c around line 766. Is it correct to reuse the
same sequence number on the same context for every submission? The dma-fence
API requires sequence numbers on a given context to monotonically increase.
Reusing sequence numbers could cause dma_fence_is_later to evaluate timelin=
es
incorrectly, potentially bypassing synchronization when buffers are shared.

[Severity: Critical]
There appears to be a race condition involving qaic_fence_sync_cb_func in
drivers/accel/qaic/qaic_fence.c around line 41 and qaic_unprepare_bo in
drivers/accel/qaic/qaic_data.c around line 994. The callback executes
locklessly and accesses the device pointer and scatter-gather table.
Concurrently, a thread calling qaic_detach_slice_bo_ioctl could see
bo_queued return false, acquire the lock, and execute qaic_unprepare_bo.
This tears down the DMA mappings and clears the channel pointer. Could the
fence callback on another CPU dereference the newly cleared channel pointer
and access the freed memory, leading to a null pointer dereference?

[Severity: Critical]
In qaic_set_bo_resv_fence in drivers/accel/qaic/qaic_fence.c around line 98,
dma_fence_add_callback adds the embedded callback node to the new fence. Is
it safe to reuse the embedded callback node for subsequent submissions? The
bo_queued check evaluates to false immediately when the signaling thread se=
ts
the signaled bit, which could happen while it is still iterating over the o=
ld
fence callback list. If a concurrent submission thread allocates a new fence
and adds the callback, it could overwrite the node pointers, corrupting the
kernel linked lists.

[Severity: Medium]
In qaic_fence_wait in drivers/accel/qaic/qaic_fence.c around line 54, the
function checks if timeout is less than 0 and sets the return value to -EIN=
TR.
Since dma_fence_wait_timeout typically returns -ERESTARTSYS when interrupted
by a signal, does mapping this internal restart instruction to an explicit
failure break the syscall restart ABI? This change seems to disable the
kernel automatic VFS syscall restart mechanism for the ioctl, forcing
userspace to handle interrupted waits manually.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003023818.1161=
666-1-carl.vanderlip@oss.qualcomm.com?part=3D2
