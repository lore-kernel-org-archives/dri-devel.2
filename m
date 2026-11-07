Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C74606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmUWukzR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5386910E0A6;
	Sat,  7 Nov 2026 18:00:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D6E10E0A6
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 18:00:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A3AF41FEE;
 Sat,  7 Nov 2026 18:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299451F008A6;
 Sat,  7 Nov 2026 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794074407;
 bh=GC0kwBO+om31hEY6Nc13FDZny99t9p2RFqqe2BCrtiA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TmUWukzRk7gAngVwXmGEnNTsLK22LeyxttOLEoQG8wwTQ+X6C7xXu/x4a4qCVMytK
 FzgCv34C31PUhOecj5PexstBD3M5PHpTaQ+6fJ/rV452Ih4vHijumlGH6CVP6+JXUV
 v/8hEBhpLrYalZI1XdhZATIcI2EGc8UzcFVCWwDJEPm1n+2lvC1PdfZgOGjQo3AF4m
 RIe9S/MM4TbZqq4zw3VAO5AaqnidTyPnKx78Elkqj0TzVIEIghnHiVBxbL2IbFZo+D
 +qAwU3mo0KTbrMezY+5EF5mioTkgoCG7uOHTiOo/HScpHz1fDkUyQNzf/yv0KP5k7a
 UEXpS5IZlbqtA==
Message-ID: <sashiko-outbox-203142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Disable recovery work on probe failure
To: "Daksh Sahni" <swizzguy76@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261107174215.15818-1-swizzguy76@gmail.com>
References: <20261107174215.15818-1-swizzguy76@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:00:06 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] accel/ivpu: ivpu_pm_recovery_work() races with ivpu_boot()
  during probe
--

commit 9885035bb27e3920959278569c3258e9ccfc3b7e
Author: Daksh Sahni <swizzguy76@gmail.com>

accel/ivpu: Disable recovery work on probe failure

This commit calls ivpu_pm_disable_recovery() on the err_ipc_fini error
path in ivpu_dev_init() to flush and disable recovery_work before device
teardown.

> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 247ed6b2ff62a..4fcccf78ec5db 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -852,6 +852,7 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
>  	return 0;
> =20
>  err_ipc_fini:
> +	ivpu_pm_disable_recovery(vdev);
>  	ivpu_ipc_fini(vdev);
>  err_fw_fini:
>  	ivpu_fw_fini(vdev);

[Severity: Medium]
Can ivpu_pm_recovery_work() still race with ivpu_boot() before
ivpu_dev_init() reaches err_ipc_fini?

ivpu_pm_init() leaves recovery_work enabled before ivpu_boot() enables
IRQs.  When an error IRQ queues recovery_work during ivpu_boot(), both the
probe thread and the worker tear down the device concurrently:

CPU0 (probe)                      CPU1 (kworker)
ivpu_dev_init()
  ivpu_boot()
    enable_irq(vdev->irq)
    <error IRQ>
      ivpu_pm_trigger_recovery()
        queue_work(recovery_work)
                                  ivpu_pm_recovery_work()
                                    ivpu_suspend()
                                      ivpu_prepare_for_reset()
                                        disable_irq(vdev->irq)
                                        ivpu_ipc_disable()
    err_disable_ipc:
      disable_irq(vdev->irq)
      ivpu_mmu_evtq_dump()
                                      ivpu_shutdown()
                                    ivpu_pm_reset_complete()
                                      ivpu_resume()
                                        ivpu_boot()
                                          enable_irq(vdev->irq)
                                          ...
                                        ivpu_hw_power_down()
  err_ipc_fini:
    ivpu_pm_disable_recovery()
    ...
    ivpu_shutdown()  <-- already in PCI_D3hot

Because both ivpu_prepare_for_reset() and err_disable_ipc call
disable_irq(vdev->irq), the single enable_irq() in ivpu_resume() leaves
vdev->irq disabled, causing the recovery boot to time out and power down
the device into PCI_D3hot.  Once disable_work_sync() in
ivpu_pm_disable_recovery() returns, err_shutdown calls ivpu_shutdown() a
second time while already in PCI_D3hot, accessing MMIO registers and
overwriting the saved PCI state.

Conversely, if ivpu_resume() in recovery_work succeeds, the NPU is left
powered on in PCI_D0 with IRQs, IPC, and MMU active while err_ipc_fini
frees the IPC, firmware, and MMU buffers without calling
ivpu_prepare_for_reset() first; and if ivpu_boot() in ivpu_dev_init()
finishes before recovery_work calls ivpu_ipc_disable(), probe returns 0
while recovery_work runs with runtime PM disabled, dropping the
autosuspend request from ivpu_pm_enable().

Initializing recovery_work in the disabled state in ivpu_pm_init() and
enabling it in ivpu_pm_enable() would prevent IRQ handlers from queuing
recovery until probe succeeds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107174215.1581=
8-1-swizzguy76@gmail.com?part=3D1
