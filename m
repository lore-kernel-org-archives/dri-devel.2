Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2014CC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8445B10E4CB;
	Fri, 14 Aug 2026 10:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mdlxLHL/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF3DC10E4CB
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:18:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE1E0600C3;
 Fri, 14 Aug 2026 10:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543031F00A3A;
 Fri, 14 Aug 2026 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786702732;
 bh=NYsKR+60OaRvmTujFb+VtBY7I8ebxfGEWnrofxnCReg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mdlxLHL/jE5jp0t/HBFmxiH/f4ynWehdoEJeBP7WzB5365n8IA9DrwagMwr5rNJ87
 8kmOjGIwHfWRt+CURLoQalT5CZZYeK5zb2olVrbPy8ZdTs2WeANHAdMpDA5Dno5gHl
 aLN7gEpmuddie1OZV+PVLPEhMXbsydlewEkvQRqdZZhlLvHFqjLm17M5ocHFnsF/GL
 FV8v6qE9kZ7YZlWOfu9Y48KpMe2k5w2zH1+1SBG1U2jnRLzmPd2wQZ84DHXeLnmD8b
 pazZWoOnLZKErv2Y271RlTCihq/RYnyGnbPnWW06IbqPjQZz+sfdt5H8mTQQHBbNq1
 mQpk5llSWnUhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/nouveau/svm: drain fault handler before freeing
 svmm
To: "Zhenhao Wan" <whi4ed0g@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-nouveau-svm-svmm-uaf-v2-1-8e6590519f07@gmail.com>
References: <20260814-nouveau-svm-svmm-uaf-v2-1-8e6590519f07@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 10:18:51 +0000
Message-Id: <20260814101852.543031F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Pre-existing NULL pointer dereference in `nouveau_svmm_part()`=
 during device teardown.
- [Critical] Use-After-Free in `nouveau_dmem_migrate_to_ram()` when accessi=
ng `svmm` after the DRM file descriptor is closed.
--

--- Patch [1]: [PATCH v2] drm/nouveau/svm: drain fault handler before freei=
ng svmm ---
commit 6f30e7be0647c66cd039d8a3e352b2a4a7f9858c
Author: Zhenhao Wan <whi4ed0g@gmail.com>

drm/nouveau/svm: drain fault handler before freeing svmm

The SVM fault handler nouveau_svm_fault() looks up each fault's
nouveau_svmm under svm->mutex, caches it in the fault array, then drops
svm->mutex and dereferences the svmm across blocking faults. nouveau_svmm
is not refcounted, so draining the handler before freeing prevents a
concurrently handled fault from dereferencing a freed svmm.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouv=
eau/nouveau_svm.c
> index dcc92131488ea..a87406d3da300 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -304,6 +304,19 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
>  {
>  	struct nouveau_svmm *svmm =3D *psvmm;
>  	if (svmm) {
> +		struct nouveau_svm *svm =3D svmm->vmm->cli->drm->svm;
> +
> +		/* The fault handler caches svmm pointers under svm->mutex and
> +		 * dereferences them after dropping it, across blocking faults.
> +		 * The instance is already unlinked (nouveau_svmm_part), so drain
> +		 * the handler before the free to release any in-flight reference.
> +		 *
> +		 * On device teardown nouveau_svm_fini() ran first and freed
> +		 * drm->svm (NULL) after draining the buffer; nothing to flush.
> +		 */

[Severity: Critical]
This is a pre-existing issue, but since the comment mentions that during de=
vice
teardown nouveau_svm_fini() explicitly clears drm->svm to NULL, does this
result in a NULL pointer dereference in nouveau_svmm_part()?

During device teardown, nouveau_drm_device_fini() calls nouveau_svm_fini()
which clears drm->svm. Later in the same function, it forcefully cleans up
remaining clients, which calls nouveau_svmm_part().

nouveau_svmm_part() unconditionally attempts to lock the mutex:

drivers/gpu/drm/nouveau/nouveau_svm.c:nouveau_svmm_part() {
	...
	mutex_lock(&svmm->vmm->cli->drm->svm->mutex);
	...
}

Could this cause a panic if a user space process holds an SVM-enabled chann=
el
open while the driver is being unbound or unloaded?

> +		if (svm)
> +			flush_work(&svm->buffer[0].work);
> +
>  		mutex_lock(&svmm->mutex);
>  		svmm->vmm =3D NULL;
>  		mutex_unlock(&svmm->mutex);

[Severity: Critical]
This is a pre-existing issue, but does freeing the svmm structure here
create a use-after-free risk during a CPU page fault if the DRM file
descriptor was closed?

If userspace migrates anonymous memory to device memory via the
NOUVEAU_SVM_BIND ioctl, the device-private pages are mapped into the proces=
s's
VMA. Their folio_zone_device_data() is set to the client's per-file svmm
structure.

If userspace then closes the DRM file descriptor but keeps the process aliv=
e,
the svmm structure is freed during cleanup. However, the device-private pag=
es
are not migrated back to RAM or unmapped from the process's page tables.

When the process later accesses this memory, a CPU page fault occurs,
triggering the device pagemap handler which attempts to lock the freed svmm
mutex:

drivers/gpu/drm/nouveau/nouveau_dmem.c:nouveau_dmem_migrate_to_ram() {
	...
	svmm =3D folio_zone_device_data(sfolio);
	mutex_lock(&svmm->mutex);
	...
}

Will this lock attempt trigger a use-after-free memory corruption?

>  		mmu_notifier_put(&svmm->notifier);
>  		*psvmm =3D NULL;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-nouveau-sv=
m-svmm-uaf-v2-1-8e6590519f07@gmail.com?part=3D1
