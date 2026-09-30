Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D765DCA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4577D10F44C;
	Wed, 30 Sep 2026 14:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O5AJQ1I0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B999910F448
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:41:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6C1A601DE;
 Wed, 30 Sep 2026 14:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBF71F000FF;
 Wed, 30 Sep 2026 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1790779311;
 bh=jt0GxyzG2JsttSrWPWsOF1LZTeo3YLmqwrBe/UQpLSU=;
 h=Subject:To:Cc:From:Date;
 b=O5AJQ1I0MLuvMBt6jDdu6Via3iGqQjh8Bl/QevUDmYoAtw+yF5r1rvoioXPAGX8Xu
 cDfHUMU9Fb5sQiEwrUXzWMwsnhKSksGS+XoQIV4pFTw4DwUH7HpP2zJBaW5BQVaIWz
 d0PU01DQdW/zVPtdU10h6nYeN9AI7sZcNDXELKxY=
Subject: Patch "accel/ivpu: Drop IRQF_ONESHOT to allow IPC IRQ threading on
 PREEMPT_RT" has been added to the 7.2-stable tree
To: andrzej.kacprowski@linux.intel.com, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, karol.wachowski@linux.intel.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2026 16:41:45 +0200
Message-ID: <2026093045-thank-degree-37a9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    accel/ivpu: Drop IRQF_ONESHOT to allow IPC IRQ threading on PREEMPT_RT

to the 7.2-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     accel-ivpu-drop-irqf_oneshot-to-allow-ipc-irq-threading-on-preempt_rt.patch
and it can be found in the queue-7.2 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 799c8f0b9f3fd728b32594aed3852044703b7e5b Mon Sep 17 00:00:00 2001
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Date: Wed, 17 Jun 2026 11:20:31 +0200
Subject: accel/ivpu: Drop IRQF_ONESHOT to allow IPC IRQ threading on PREEMPT_RT

From: Karol Wachowski <karol.wachowski@linux.intel.com>

commit 799c8f0b9f3fd728b32594aed3852044703b7e5b upstream.

The IPC RX hardirq handler matches consumers under a spinlock and
allocates rx_msg buffers. On PREEMPT_RT these spinlocks become sleeping
locks and the allocation may sleep, neither of which is allowed in true
hardirq context, resulting in "sleeping function called from invalid
context" splats.

IRQF_ONESHOT makes genirq keep the primary handler in hardirq even when
forced threading is enabled, so on PREEMPT_RT the handler cannot be
threaded. Drop the flag so the primary handler is threaded on PREEMPT_RT
and the IPC RX path runs in a context where sleeping is allowed. On the
MSI interrupt chip (IRQCHIP_ONESHOT_SAFE) the flag was stripped anyway,
so non-RT behaviour is unchanged.

Fixes: 85c9cc2d25f8 ("accel/ivpu: Use threaded IRQ for IPC callback processing")
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260617092031.3016582-1-karol.wachowski@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -624,7 +624,7 @@ static int ivpu_irq_init(struct ivpu_dev
 	vdev->irq = pci_irq_vector(pdev, 0);
 
 	ret = devm_request_threaded_irq(vdev->drm.dev, vdev->irq, ivpu_hw_irq_handler,
-					ivpu_ipc_irq_thread_handler, IRQF_NO_AUTOEN | IRQF_ONESHOT,
+					ivpu_ipc_irq_thread_handler, IRQF_NO_AUTOEN,
 					DRIVER_NAME, vdev);
 	if (ret)
 		ivpu_err(vdev, "Failed to request an IRQ %d\n", ret);


Patches currently in stable-queue which might be from karol.wachowski@linux.intel.com are

queue-7.2/accel-ivpu-use-threaded-irq-for-ipc-callback-processing.patch
queue-7.2/accel-ivpu-drop-irqf_oneshot-to-allow-ipc-irq-threading-on-preempt_rt.patch
queue-7.2/accel-ivpu-use-separate-flag-for-job-timeout.patch
