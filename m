Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2F606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T//uoOT4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7B510F361;
	Mon,  9 Nov 2026 14:12:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D160710E5A6;
 Mon,  9 Nov 2026 14:12:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE842614AA;
 Mon,  9 Nov 2026 14:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A891F0089F;
 Mon,  9 Nov 2026 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794233525;
 bh=FB8+CIMK7Lwwps8gLEuzj+E79IB9zMq2g1tf0BLAZ28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T//uoOT4R7sqgACCUn7cc3shNXcaFVsiK7gCwPAT40GtW06NsTZcp3C6ZgcZfwIci
 kTNCcFLD6LwOrm/JzJki6nL+4g+c+DzYeLfbWfkTFF00EK1Olk3CWlpcJM3CzQmrMz
 /qlqyZpbfD4lAmkWwX2hTOzUQTFVgGwgypX0E0x4aNfa/m3OZTbDlwYfo9K2o9mplA
 5K090aJ9Bqr2Ram0CT/mRr4tJyuuHPzGqXl6f87X7PE/MTUYongXdmNV8krUom7K2c
 riAFTL1j9I9s8O4PtpBCtOuQOnIeemSoZATY0gOIS805TRgA7i2MME7RyVkgD3ZXK0
 dgiB6qFFHm4sA==
Message-ID: <sashiko-outbox-205066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/20] drm/xe/eudebug: Introduce vm bind and vm bind
 debug data events
To: "Mika Kuoppala" <mika.kuoppala@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109135549.4128280-12-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-12-mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:12:05 +0000
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
- [Medium] drm/xe/eudebug: missed bind events in xe_vm_bind_ioctl() on
  prefetch -ENODATA
--

commit cd195b3b0e2ac13dc8ba630c0ab3fbbd171bde93
Author: Christoph Manszewski <c.manszewski@gmail.com>

drm/xe/eudebug: Introduce vm bind and vm bind debug data events

This commit adds eudebug VM bind and debug data operation events to notify
an attached debugger when VM bind debug data operations are executed or
discovered.

> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index bfd5a76e953fb..0b6645c86e9a8 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3810,6 +3810,10 @@ static struct dma_fence *vm_bind_ioctl_ops_execute=
(struct xe_vm *vm,
>  		xe_vm_set_validation_exec(vm, &exec);
>  		fence =3D ops_execute(vm, vops);
>  		xe_vm_set_validation_exec(vm, NULL);
> +
> +		if (!IS_ERR(fence) || PTR_ERR(fence) =3D=3D -ENODATA)
> +			xe_eudebug_vm_bind_execute(vm, vops);
> +
>  		if (IS_ERR(fence)) {
>  			if (PTR_ERR(fence) =3D=3D -ENODATA)
>  				vm_bind_ioctl_ops_fini(vm, vops, NULL);

[Severity: Medium]
Can a multi-operation VM bind skip xe_eudebug_vm_bind_execute() while still
leaving debug data changes committed?

In xe_vm_bind_ioctl(), debug data add and remove operations are committed to
vm->debug_data.list during vm_bind_ioctl_process_user_extensions().  If the
same bind array also includes an SVM prefetch operation and
vm_bind_ioctl_ops_prefetch_ranges() returns -ENODATA (for example, when
prefetch_thread_func() hits a VRAM allocation failure or
xe_svm_range_get_pages() returns -EFAULT), xe_vm_bind_ioctl() jumps to
unwind_ops without calling vm_bind_ioctl_ops_execute():

drivers/gpu/drm/xe/xe_vm.c:xe_vm_bind_ioctl() {
    ...
	err =3D vm_bind_ioctl_ops_prefetch_ranges(vm, &vops);
	if (err)
		goto unwind_ops;

	fence =3D vm_bind_ioctl_ops_execute(vm, &vops);
    ...
unwind_ops:
	if (err && err !=3D -ENODATA)
		vm_bind_ioctl_ops_unwind(vm, ops, args->num_binds);
	xe_vma_ops_fini(&vops);
    ...
free_syncs:
	if (err =3D=3D -ENODATA)
		err =3D vm_bind_ioctl_signal_fences(vm, q, syncs, num_syncs);
    ...
}

Because -ENODATA skips vm_bind_ioctl_ops_unwind(), signals the out-fences,
and returns 0 to userspace, the debug data changes stay on
vm->debug_data.list without delivering the bind and debug data events to the
debugger.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109135549.4128=
280-1-mika.kuoppala@linux.intel.com?part=3D11
