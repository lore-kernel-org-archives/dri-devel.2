Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A747C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 11:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFD910E032;
	Sat,  8 Aug 2026 11:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jSdLMsL+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CB910E032
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 11:35:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52C4A60054;
 Sat,  8 Aug 2026 11:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFF71F000E9;
 Sat,  8 Aug 2026 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786188945;
 bh=W74QYNzqIRXU4zHRK3Vdcn4XqIOBUDOVe/qi3IGruXs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jSdLMsL+N9ahbYBhVtKRItIGcvL5jNMJQvKPh49W909DbB/7aL66iY0KTaoGcwQnZ
 VZp6179RyUr5sGNbK7vicWQfd84DerbtPLiu3WB0/li+pnvQgQFS28zutsifscpPAD
 kJzVgfcSVdwUdQQYlyDNSgGPHPoEgiWALkFOyxO7F1rw08ZjO1PUO0AVaO9FXfUYkT
 hX12+3dyD6UguVM3WUdUZ1rLldXcNyQWFREfdbpaoAwkY2dtgzHAhDF2YAX5l5dB2u
 uuS3MSCZQDmLsftQQQNFkK9z2KoKkhI5BD1QKGsUvRtZ/LdKMz/ibDWXtoeZ/q+xXK
 Qu4QsNoaP9KFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/nouveau/uvmm: reject a second VM_INIT
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808-nouveau-fixes-v1-2-c3ebdc17a89c@outlook.com>
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
 <20260808-nouveau-fixes-v1-2-c3ebdc17a89c@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 11:35:43 +0000
Message-Id: <20260808113544.CDFF71F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `cli->uvmm.ptr` lacks memory barriers, potentia=
lly allowing readers to observe a partially initialized `uvmm` struct.
--

--- Patch [2]: [PATCH 2/2] drm/nouveau/uvmm: reject a second VM_INIT ---
commit 8aef81c8581a1b964e410ee072207a76a4098339
Author: Junrui Luo <moonafterrain@outlook.com>

drm/nouveau/uvmm: reject a second VM_INIT

nouveau_uvmm_ioctl_vm_init() sets up the GPU VA space for a drm_file and
is reachable from an unprivileged render node client. The patch prevents
DRM_IOCTL_NOUVEAU_VM_INIT from dropping the previous nouveau_uvmm and
leaking kernel memory by checking if cli->uvmm.ptr is already set.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index bced1481674e7..26d2a57b5aacc 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1929,6 +1929,12 @@ nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
>  		goto out_unlock;
>  	}
> =20
> +	/* Check that a GPU VA space isn't already set up for the client. */
> +	if (cli->uvmm.ptr) {
> +		ret =3D -EBUSY;
> +		goto out_unlock;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but since we are checking cli->uvmm.ptr here,
is it safe that the writer publishes this pointer locklessly later in this
same function?

Further down in nouveau_uvmm_ioctl_vm_init(), the pointer is assigned witho=
ut
memory barriers:

	uvmm->vmm.cli =3D cli;
	cli->uvmm.ptr =3D uvmm;
	mutex_unlock(&cli->mutex);

Could the compiler or CPU reorder this store before the uvmm structure is
fully initialized, causing readers to see a partially initialized struct?

For example, concurrent calls to nouveau_cli_uvmm() load cli->uvmm.ptr with=
out
READ_ONCE() or smp_load_acquire():

drivers/gpu/drm/nouveau/nouveau_drv.h:nouveau_cli_uvmm() {
	return cli ? cli->uvmm.ptr : NULL;
}

If another thread executes DRM_IOCTL_MODE_CREATE_DUMB, it can follow a lock=
less
path through nouveau_gem_new() into nouveau_bo_alloc() which dereferences t=
he
vmm structure:

drivers/gpu/drm/nouveau/nouveau_bo.c:nouveau_bo_alloc() {
	...
	struct nvif_vmm *vmm =3D &nouveau_cli_vmm(cli)->vmm;
	...
		for (i =3D 0; i < vmm->page_nr; i++) {
	...
}

Alternatively, nouveau_debugfs_gpuva() iterates clients and locklessly reads
cli->uvmm.ptr, then immediately calls nouveau_uvmm_lock() on it. Could this
trigger a crash if the mutex appears uninitialized?

Would using smp_store_release() for the assignment and smp_load_acquire()
for the readers ensure proper visibility of the initialized structure?

>  	uvmm =3D kzalloc_obj(*uvmm);
>  	if (!uvmm) {
>  		ret =3D -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808-nouveau-fi=
xes-v1-0-c3ebdc17a89c@outlook.com?part=3D2
