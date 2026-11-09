Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52957606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzviV9+n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1B110F3AB;
	Mon,  9 Nov 2026 14:22:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C538C10F3AF;
 Mon,  9 Nov 2026 14:22:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B4A2459C5;
 Mon,  9 Nov 2026 14:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477461F008A1;
 Mon,  9 Nov 2026 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794234131;
 bh=+tTUt+CTwfyVSfFmNqCDSXDfZ5ricemvfRv9D8dNoBo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gzviV9+nfWllI2mUpws+dQ21U21LlkA2C0b5mNZazjxBNa457hgI5uNbRau2peFDZ
 EG+3/T5W9YRHNw20w1DVqcPnBRbg2pyxqJNl+t7bxNEN3F6XYNLCzvlJXMxRuGAdgv
 MFLwydNAbIxw5+jXcx5/COQ+JS6Ho121HRiXVor8QLlCaiPUsFWvMGYASJe67GPfzq
 JJsJ2MB2VJY896clf9SYJSwMFplQHRpRNFgfXP7/pQYM2lLlvtMaGrqPJ7b7BtBoh/
 VtGnuNjqsmwJ0167pRgYYKNCWNcXPor68xGDYHdc/KWRD4pwiIwlebQ/burP3/FIN9
 JE35T3hw6bqUA==
Message-ID: <sashiko-outbox-205080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/20] drm/xe/eudebug: Add vm open/pread/pwrite
To: "Mika Kuoppala" <mika.kuoppala@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109135549.4128280-14-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-14-mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:22:10 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/xe/eudebug: unlocked vm->size reads in
  __xe_eudebug_vm_access()
- [Low] drm/xe/eudebug: detach race in __xe_eudebug_vm_access() returns
  -EINVAL
--

commit a3a16f65fbfea0ccc25672bcf54427e90a80cace
Author: Mika Kuoppala <mika.kuoppala@linux.intel.com>

drm/xe/eudebug: Add vm open/pread/pwrite

This commit adds the DRM_XE_EUDEBUG_IOCTL_VM_OPEN ioctl and file operations
for reading, writing, and syncing a target client's BO-backed VM mappings.

> diff --git a/drivers/gpu/drm/xe/xe_eudebug_vm.c b/drivers/gpu/drm/xe/xe_e=
udebug_vm.c
> new file mode 100644
> index 0000000000000..385fcc7e8f5c2
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_eudebug_vm.c

[ ... ]

> +static ssize_t __xe_eudebug_vm_access(struct file *file,
> +				      char __user *r_buffer,
> +				      const char __user *w_buffer,
> +				      size_t count, loff_t *__pos)
> +{
> +	struct vm_file *vmf =3D file->private_data;
> +	struct xe_eudebug * const d =3D vmf->debugger;
> +	struct xe_device * const xe =3D d->xe;
> +	const bool write =3D !!w_buffer;
> +	struct xe_vm *vm;
> +	ssize_t copied =3D 0;
> +	ssize_t bytes_left;
> +	ssize_t ret;
> +	unsigned long alloc_len;
> +	loff_t pos =3D *__pos;
> +	void *k_buffer;
> +
> +	if (XE_IOCTL_DBG(d->xe, xe_eudebug_is_detached(d)))
> +		return -ENOTCONN;
> +
> +	if (XE_IOCTL_DBG(xe, write && r_buffer))
> +		return -EINVAL;
> +
> +	vm =3D xe_eudebug_vm_get(d, vmf->vm_handle);
> +	if (XE_IOCTL_DBG(xe, !vm))
> +		return -EINVAL;

[Severity: Low]
Can __xe_eudebug_vm_access() return -EINVAL instead of -ENOTCONN if the
target detaches between xe_eudebug_is_detached() and xe_eudebug_vm_get()?

CPU0                              CPU1
__xe_eudebug_vm_access()
  xe_eudebug_is_detached(d)
    -> false
                                  xe_eudebug_detach()
                                    d->target.xef =3D NULL
                                    xe_eudebug_resources_clear(d)
  xe_eudebug_vm_get(d, ...)
    -> NULL
  return -EINVAL;  <-- expected -ENOTCONN

Checking xe_eudebug_is_detached(d) when !vm, as xe_eudebug_vm_open_ioctl()
does, would return -ENOTCONN as documented in the UAPI header.

> +
> +	if (XE_IOCTL_DBG(xe, vm !=3D vmf->vm)) {
> +		eu_warn(d, "vm_access(%s): vm handle mismatch vm_handle=3D%llu, flags=
=3D0x%llx, pos=3D%llu, count=3D%zu\n",
> +			str_write_read(write),
> +			vmf->vm_handle, vmf->flags, pos, count);
> +		xe_vm_put(vm);
> +		return -EINVAL;
> +	}
> +
> +	if (!count) {
> +		xe_vm_put(vm);
> +		return 0;
> +	}
> +
> +	if (pos >=3D vm->size) {
> +		xe_vm_put(vm);
> +		return write ? -ENOSPC : 0;
> +	}
> +
> +	count =3D min_t(u64, count, vm->size - pos);
> +	bytes_left =3D count;
> +
> +	alloc_len =3D min_t(unsigned long, ALIGN(count, PAGE_SIZE), 64 * SZ_1M);
> +	do  {
> +		k_buffer =3D __vmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);

[Severity: Medium]
Can reading vm->size twice without holding vm->lock race with xe_vm_close()
zeroing vm->size?

drivers/gpu/drm/xe/xe_vm.c:xe_vm_close() {
	down_write(&vm->lock);
	xe_vm_lock(vm, false);

	if (xe_vm_in_fault_mode(vm))
		xe_svm_notifier_lock(vm);

	vm->size =3D 0;
    ...
}

CPU0                              CPU1
__xe_eudebug_vm_access()
  vm =3D xe_eudebug_vm_get(...)
                                  xe_vm_close(vm)
                                    down_write(&vm->lock)
  if (pos >=3D vm->size)
    -> false (pos =3D=3D 0)
                                    vm->size =3D 0
                                    up_write(&vm->lock)
  count =3D min_t(u64, count,
                vm->size - pos)
    -> 0
  alloc_len =3D 0
  __vmalloc(0, ...)               <-- hits WARN_ON_ONCE(!size)

If pos > 0 when vm->size becomes 0 between the two reads, vm->size - pos
underflows u64; if vm->size is already 0 at the first read, pread() returns
0 (EOF) and pwrite() returns -ENOSPC instead of -EINVAL for a closed VM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109135549.4128=
280-1-mika.kuoppala@linux.intel.com?part=3D13
