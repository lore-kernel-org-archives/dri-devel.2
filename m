Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EA606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1c0VAsA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB76010E696;
	Fri, 23 Oct 2026 16:00:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D18310E6B4
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:00:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCFD743243;
 Fri, 23 Oct 2026 16:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F3B1F01828;
 Fri, 23 Oct 2026 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792771214;
 bh=aaUG1WEMoiePtPMHaU3bEseP9u28pCg5CTORnOaQ3RM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j1c0VAsAiv7MMLzvdU9Ri8E7ziI8MVM1usTysyDPUBHLDGnpRv2mY4mKd6+zniAgh
 dMnTVWAiYxPMbOp+8sb9bKiv3zIR5KeRPxyOhVxkcvS4UI277ljBLpv62wK0ZDcDs1
 bO57A0jdFnkycXD4LJiFI7kGA40D10g+bF48NrBPvoNLONHqZQsufIQhdKiT56AEEK
 j7dJXCVZO25xJPcKjb2S7PdiJESVwEz3li3084uhw6cwL+yrfaAWwzyHzay3PjgbBf
 I3Xt2EF9iCIQ/sHvBfCq6I7lC0Q4L1SdW2lgmkWFRJnSv/GicqL1zoDAc6X7CLLvb/
 l0qw1ZBQwCORA==
Message-ID: <sashiko-outbox-182936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/14] drm/msm: order the display snapshot sources
 around its worker
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-4-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
 <20261023-msm-kms-destroy-fixes-v2-4-83727c122de7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:00:14 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm: unsynchronized fault handler update in msm_mmu_set_fault_=
handler()
--

commit 9dc038a2fc1d880292f387fc89c8359b97d9cf93
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: order the display snapshot sources around its worker

This commit reorders the registration and teardown of the display IOMMU
fault handler and display snapshot worker in msm_drm_kms_init() and
msm_drm_kms_uninit() so that snapshot sources are only active while the
KMS and its dump worker are initialized.

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
> @@ -339,6 +337,8 @@ int msm_drm_kms_init(struct device *dev, const struct=
 drm_driver *drv)
> =20
>  	drm_mode_config_reset(ddev);
> =20
> +	msm_mmu_set_fault_handler(to_msm_vm(kms->vm)->mmu, kms, msm_kms_fault_h=
andler);

[Severity: High]
Can msm_mmu_set_fault_handler() in drivers/gpu/drm/msm/msm_kms.c race with
an in-flight display IOMMU fault during msm_drm_kms_init() or
msm_drm_kms_uninit()?

In drivers/gpu/drm/msm/msm_mmu.h, msm_mmu_set_fault_handler() performs
plain unlocked stores:

static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
		int (*handler)(void *arg, unsigned long iova, int flags, void *data))
{
	mmu->arg =3D arg;
	mmu->handler =3D handler;
}

And in drivers/gpu/drm/msm/msm_iommu.c, msm_disp_fault_handler() reads and
calls those fields without locking or memory barriers:

static int msm_disp_fault_handler(struct iommu_domain *domain, struct devic=
e *dev,
				  unsigned long iova, int flags, void *arg)
{
	struct msm_iommu *iommu =3D arg;

	if (iommu->base.handler)
		return iommu->base.handler(iommu->base.arg, iova, flags, NULL);

	return -ENOSYS;
}

During msm_drm_kms_uninit(), msm_irq_uninstall() only frees the display
controller interrupt (kms->irq), while the SMMU context fault interrupt
remains active until kms->funcs->destroy(kms) detaches the IOMMU at the end
of msm_drm_kms_uninit().

If msm_disp_fault_handler() is already executing on another CPU when
msm_drm_kms_uninit() clears mmu->handler to NULL, nothing waits for
msm_disp_fault_handler() -> msm_kms_fault_handler() to finish before
msm_disp_snapshot_destroy() calls kthread_destroy_worker(kms->dump_worker).
Could an in-flight msm_kms_fault_handler() then call
msm_disp_snapshot_state() and queue kms->dump_work onto the freed
kms->dump_worker, or could a compiler reload of iommu->base.handler in
msm_disp_fault_handler() call a NULL function pointer?

Similarly, during msm_drm_kms_init(), msm_kms_init_vm() ->
msm_iommu_disp_new() attaches the IOMMU domain before
msm_mmu_set_fault_handler() is called. Without release/acquire ordering
when publishing mmu->arg and mmu->handler, could a concurrent fault on
weakly ordered architectures observe a non-NULL iommu->base.handler while
iommu->base.arg is still NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-msm-kms-de=
stroy-fixes-v2-0-83727c122de7@oss.qualcomm.com?part=3D4
