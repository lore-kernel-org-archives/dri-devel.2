Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CA2606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1FPaTqA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D129F10E658;
	Fri, 27 Nov 2026 19:57:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125CA10E658
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:57:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE9BE44F7B;
 Fri, 27 Nov 2026 19:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE891F00897;
 Fri, 27 Nov 2026 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795809445;
 bh=Uo3eriBVsgEER4Y43CBzS8XCFfU01Kzmrq6jVq0D2O4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y1FPaTqAkXs0HwUb0z5Aq5VVKyIUxa5EYYzVD5JQpWRFN09lIlEhgFBG3EwxIjOSP
 w8msFDJDhjjOSpaR3YOmxMQ3oKjEXVAFf7LhkU/GjBXVqsB8LZO4h4bp1GJvLWLEpY
 sv+cZsoyrqH5tbYD9Z9oIhcaQb/0HSLpTJR6SiWpHCpTT/SpTR70lqCuXz+xfkLrbl
 IZFhHynzX/e/uW5UmxEUXdS1WkE8/W4wpuZvQhgkV10NbTneVkgnjmu9g0JRpyBZ4l
 I65qsVbh2zBuzImCeV8bHG16oT0uCz3TU7cNBfy3VKRsH+kXP1qvG5hyLhZidkPggg
 0puTZsa5v+HaQ==
Message-ID: <sashiko-outbox-238188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/14] drm/msm: order the display snapshot sources
 around its worker
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-msm-kms-destroy-fixes-v4-4-242b0a3f8e47@oss.qualcomm.com>
References: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
 <20261127-msm-kms-destroy-fixes-v4-4-242b0a3f8e47@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 19:57:25 +0000
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
- [High] drm/msm: unsynchronized fault handler clear in
  msm_drm_kms_uninit()
--

commit e1772847baca24cdc32b6b0a89748cda0bfad94c
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: order the display snapshot sources around its worker

This commit moves registration of the KMS IOMMU fault handler to the end of
msm_drm_kms_init(), unregisters it at the beginning of msm_drm_kms_uninit(),
and destroys the display snapshot worker after uninstalling interrupts.

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index f3e39c3907a93..a94d2888a21e5 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
[ ... ]
> @@ -245,6 +241,8 @@ void msm_drm_kms_uninit(struct device *dev)
> =20
>  	BUG_ON(!kms);
> =20
> +	msm_mmu_set_fault_handler(to_msm_vm(kms->vm)->mmu, kms, NULL);
> +
>  	/* We must cancel and cleanup any pending vblank enable/disable
>  	 * work before msm_irq_uninstall() to avoid work re-enabling an
>  	 * irq after uninstall has disabled it.
> @@ -256,12 +254,12 @@ void msm_drm_kms_uninit(struct device *dev)
> =20
>  	drm_kms_helper_poll_fini(ddev);
> =20
> -	msm_disp_snapshot_destroy(ddev);
> -
>  	pm_runtime_get_sync(dev);
>  	msm_irq_uninstall(ddev);
>  	pm_runtime_put_sync(dev);
> =20
> +	msm_disp_snapshot_destroy(ddev);
> +
>  	if (kms && kms->funcs)
>  		kms->funcs->destroy(kms);
>  }

[Severity: High]
Can an in-flight IOMMU fault handler still race with
msm_disp_snapshot_destroy() and cause a use-after-free on kms->dump_worker
(or a NULL function pointer call)?

msm_mmu_set_fault_handler() does an unlocked store to mmu->handler, and
msm_disp_fault_handler() reads and calls iommu->base.handler without locking
or synchronization:

drivers/gpu/drm/msm/msm_iommu.c:msm_disp_fault_handler() {
	struct msm_iommu *iommu =3D arg;

	if (iommu->base.handler)
		return iommu->base.handler(iommu->base.arg, iova, flags, NULL);

	return -ENOSYS;
}

Nothing between msm_mmu_set_fault_handler(..., NULL) and
msm_disp_snapshot_destroy() waits for the SMMU context fault threaded IRQ to
finish (msm_irq_uninstall() only frees the display controller IRQ kms->irq,
while the IOMMU domain is destroyed later in kms->funcs->destroy()):

CPU0                                  CPU1
msm_disp_fault_handler()
  if (iommu->base.handler)
                                      msm_drm_kms_uninit()
                                        msm_mmu_set_fault_handler(..., NULL)
                                        ...
                                        msm_disp_snapshot_destroy()
                                          kthread_destroy_worker(
                                            kms->dump_worker)
    msm_kms_fault_handler()
      msm_disp_snapshot_state()
        kthread_queue_work(
          kms->dump_worker, ...)  <-- use-after-free

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-msm-kms-de=
stroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com?part=3D4
