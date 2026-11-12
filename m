Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C487606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BvWKuxHZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E2210F53D;
	Thu, 12 Nov 2026 15:16:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB1F410EA09;
 Thu, 12 Nov 2026 15:16:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E719E60D3B;
 Thu, 12 Nov 2026 15:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616F41F000CC;
 Thu, 12 Nov 2026 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794496559;
 bh=ihTikQnngLCaaZX8lP+0LoBoNDzWzbZHkU/7q+5fmEc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=BvWKuxHZRGcY0gw0AxjTH1zWFmICb9rhoHWMYNBTVdEaxOVxVrSc3JxUGMp6oe3HW
 YdVkePrjMsbRxeHlhkeAMzQlRp37Q7i0Z8ziuFEIB4fvH2i6ULBsubBkJ558nA2wkL
 7lc/LozcZz4X7AlkCIu5YqVAdJQHoUaK0PeaSHBylb3FTXw7OdecPYgsGzDRBo0D8K
 V+AuIkNfiyvJXFVclsLMtLbdF1J1TDdVAispPGPeq2e7MXI3hIqwUyuFc1LTJzLRkO
 XgGrugW7B1j7U7AmTo+ncgM2/b6Vf/Zf81JSoDhDY8S7mRlpPmSG8Svp7IUj2JGFr+
 Cut/hr3faW2gw==
Message-ID: <sashiko-outbox-211419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] CI_ONLY: Hold a device reference across deferred VM
To: "Arvind Yadav" <arvind.yadav@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261112150302.3837896-2-arvind.yadav@intel.com>
References: <20261112150302.3837896-1-arvind.yadav@intel.com>
 <20261112150302.3837896-2-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 15:15:58 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/xe: self-deadlock in vm_destroy_work_func() on
  xe->destroy_wq
--

commit a82e5f7cac31a25d1e51cdc2f9e9c8bed2db07a4
Author: Arvind Yadav <arvind.yadav@intel.com>

CI_ONLY: Hold a device reference across deferred VM

This commit acquires a drm_device reference in xe_vm_free() and releases
it at the end of vm_destroy_work_func() so the device remains valid across
deferred VM destruction.

> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index dd855876f571c..d94a27db2cf40 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -2109,6 +2109,8 @@ static void vm_destroy_work_func(struct work_struct=
 *w)
>  		xe_file_put(vm->xef);
> =20
>  	kfree(vm);
> +
> +	drm_dev_put(&xe->drm);
>  }
> =20
>  static void xe_vm_free(struct drm_gpuvm *gpuvm)
> @@ -2116,10 +2118,13 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
>  	struct xe_vm *vm =3D container_of(gpuvm, struct xe_vm, gpuvm);
> =20
>  	/*
> -	 * To destroy the VM we need to be able to sleep.
> -	 * drm_gpuvm keeps at least one device reference at this
> -	 * point so xe->destroy_wq must still be alive.
> +	 * drm_gpuvm drops its device reference as soon as this callback
> +	 * returns, but vm_destroy_work_func() still uses device state. Hold a
> +	 * reference across the deferred work.
>  	 */
> +	drm_dev_get(&vm->xe->drm);
> +
> +	/* To destroy the VM we need to be able to sleep */
>  	queue_work(vm->xe->destroy_wq, &vm->destroy_work);
>  }

[Severity: High]
Can dropping the last drm_device reference in vm_destroy_work_func()
self-deadlock on xe->destroy_wq?

When the freed VM holds the final device reference (for example, after PCI
device unbind), drm_gpuvm_free() drops its reference as soon as
xe_vm_free() returns, leaving the reference taken here as the last one.
When vm_destroy_work_func() runs on xe->destroy_wq and calls
drm_dev_put(&xe->drm), it synchronously triggers drm_dev_release() ->
drm_managed_release() -> xe_device_destroy():

drivers/gpu/drm/xe/xe_device.c:xe_device_destroy() {
	...
	if (xe->destroy_wq)
		destroy_workqueue(xe->destroy_wq);
	...
}

destroy_workqueue(xe->destroy_wq) then tries to drain xe->destroy_wq from
inside vm_destroy_work_func() running on that same workqueue, triggering a
lockdep recursive-locking warning and hanging forever waiting for the
current work item to finish.

As done in vma_destroy_cb(), vm->destroy_work should be queued on the
module-wide destroy workqueue via xe_destroy_wq_queue(&vm->destroy_work);
a later patch in this series, commit "CI-ONLY:Defer VM teardown until exec
queue cleanup", makes that change, which is needed here to avoid breaking
bisectability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112150302.3837=
896-1-arvind.yadav@intel.com?part=3D1
