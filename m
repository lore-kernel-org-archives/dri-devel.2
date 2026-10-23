Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C258606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AS3SWZrd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E026C10E740;
	Fri, 23 Oct 2026 23:41:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F17A10E740
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:41:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 842166022B;
 Fri, 23 Oct 2026 23:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218D61F01825;
 Fri, 23 Oct 2026 23:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792798895;
 bh=Fjvvw/L8cyBtNTtIjDJBeUzZ7aU82f51gjpHeQfYguI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AS3SWZrdbjzDmKJuG1bl28hxvZKVzv4lglNNpGCYqH+ljwxfjooUIg6ZHdi/Vz9nJ
 S1kfUDJVnAOfDeXVp1lb438xFgjNOxcCT4Udwp9CqpgrCZyozaAsRq1SVjJWW+lGEI
 hxhFvUHZgs0mZjJXHUBIEbKjNXTIXLfxHIeqa50AYUdPrusVLjSR+OcNFdlxH5nNWH
 NFAxZRccwNFYvhxM/lSU75QsnFYqT+zGK7VgfDOAyRGO9/xQyt8l0O8Z4Yy4ykVHqH
 AXBZsiQc6F4SKdxnMJBF+m7zAbErFRbKH3pb3UOjDPxL81xARLR/IAYkmztBeDAyk9
 ySiUIEN7+2tlA==
Message-ID: <sashiko-outbox-183424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/14] drm/msm: order the display snapshot sources
 around its worker
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-4-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
 <20261024-msm-kms-destroy-fixes-v3-4-66a30120a5ea@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:41:34 +0000
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
- [High] drm/msm: unsynchronized fault handler clear in msm_drm_kms_uninit()
--

commit a95d27af7e4b3b82df2fddca01a3fd982e834f6d
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: order the display snapshot sources around its worker

This commit reorders the registration and teardown of the display IOMMU fau=
lt
handler and the display snapshot worker in msm_drm_kms_init() and
msm_drm_kms_uninit() so that snapshot sources are started after KMS setup a=
nd
stopped before the snapshot worker is destroyed.

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

[Severity: High]
Can clearing the fault handler in msm_drm_kms_uninit() still race with an
in-flight display IOMMU fault and cause a NULL function pointer call or a
use-after-free on kms->dump_worker?

In drivers/gpu/drm/msm/msm_mmu.h, msm_mmu_set_fault_handler() performs plain
unlocked stores:

static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
		int (*handler)(void *arg, unsigned long iova, int flags, void *data))
{
	mmu->arg =3D arg;
	mmu->handler =3D handler;
}

And in drivers/gpu/drm/msm/msm_iommu.c, msm_disp_fault_handler() checks and
calls iommu->base.handler without locking or READ_ONCE():

static int msm_disp_fault_handler(struct iommu_domain *domain, struct devic=
e *dev,
				  unsigned long iova, int flags, void *arg)
{
	struct msm_iommu *iommu =3D arg;

	if (iommu->base.handler)
		return iommu->base.handler(iommu->base.arg, iova, flags, NULL);

	return -ENOSYS;
}

First, without READ_ONCE() / WRITE_ONCE() or a lock, can the compiler reload
iommu->base.handler after the NULL check in msm_disp_fault_handler() while
msm_drm_kms_uninit() clears it, calling NULL?

Second, if a display SMMU context fault (for example, via the threaded IRQ
handler qcom_smmu_context_fault() -> report_iommu_fault() ->
msm_disp_fault_handler() -> msm_kms_fault_handler()) is already running when
msm_drm_kms_uninit() sets mmu->handler to NULL, nothing between
msm_mmu_set_fault_handler() and msm_disp_snapshot_destroy() waits for that
in-flight fault handler to complete (msm_irq_uninstall() only frees kms->ir=
q,
while the SMMU domain and its fault IRQ are only torn down later in
kms->funcs->destroy(kms)).

If msm_kms_fault_handler() is preempted or running on another CPU, couldn't=
 it
call msm_disp_snapshot_state() -> kthread_queue_work(kms->dump_worker,
&kms->dump_work) concurrently with or after msm_disp_snapshot_destroy() cal=
ls
kthread_destroy_worker(kms->dump_worker)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-msm-kms-de=
stroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com?part=3D4
