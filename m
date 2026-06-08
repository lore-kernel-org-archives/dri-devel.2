Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714B2CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B932210F6F6;
	Mon,  8 Jun 2026 16:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RczLuQSL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054D110F6F4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:30:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4DE74183F;
 Mon,  8 Jun 2026 16:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EE21F00893;
 Mon,  8 Jun 2026 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780936233;
 bh=HpvInkPdsOJ478WnGU8QQfhp89u07cX+G45IqufC+Hk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RczLuQSLoEKFdwED71MvtDzyNlMrA3+Md85Nc/TiWJoqhpdejVOlnBxXbEwOtcw8G
 JjoF+gfNemWpiOvaatZKbIVQSbQ15tC2K62nCIpO6OcyzIWerKE/UUoEj9uYZY3XGS
 cOhmQFGwBXED0IVxs5MQJB2JGd9CL+ci0Gr/GuKAVgQL4rTzC8UpjtPqcPOH8HH1y/
 DqGwch9LAGm749LDFvLdHYgVY9zxx4uAnLugFTjlzg1GwWtthnDYfvvFpYW4NXfTe7
 8HezSPj0oYwFw3n6uclVs9akI+TcwcWP5ud5NST3R3PL70ksvTgq0IjIp+ebUhTG4j
 6FCI7GyxRpgzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 1/3] accel/amdxdna: Fix amdxdna_client lifetime race
 during device removal
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608161418.2748988-1-lizhi.hou@amd.com>
References: <20260608161418.2748988-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:30:33 +0000
Message-Id: <20260608163033.88EE21F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in IOCTLs due to lack of device unplug synchronizat=
ion
- [High] Deterministic Use-After-Free in GEM callbacks when userspace close=
s the file descriptor after device removal
- [High] Double free/unbind of the IOMMU SVA device handle on PASID failure
--

commit 8636266787707619953362d31190f3d7097a3d27
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix amdxdna_client lifetime race during device removal

In amdxdna_remove(), all amdxdna_client structures are freed after
calling drm_dev_unplug(). However, drm_dev_unplug() does not force
existing file descriptors to be closed, so amdxdna_drm_close() may be
called after amdxdna_remove() has completed.

As a result, accessing client->pid for debug output in
amdxdna_drm_close() can lead to a use-after-free, since the access is
not protected by drm_dev_enter().

Fix this by moving the debug output after drm_dev_enter(). Similarly,
add the drm_dev_enter() protection for amdxdna_drm_open().

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index 1f066ed8d2365..a22c986f1b331 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -108,10 +108,16 @@ static int amdxdna_drm_open(struct drm_device *ddev=
, struct drm_file *filp)
>  {
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(ddev);
>  	struct amdxdna_client *client;
> +	int ret =3D 0, idx;
> +
> +	if (!drm_dev_enter(ddev, &idx))
> +		return -ENODEV;
> =20
>  	client =3D kzalloc_obj(*client);
> -	if (!client)
> -		return -ENOMEM;
> +	if (!client) {
> +		ret =3D -ENOMEM;
> +		goto dev_exit;
> +	}
> =20
>  	client->pid =3D pid_nr(rcu_access_pointer(filp->pid));
>  	client->xdna =3D xdna;
> @@ -125,7 +131,8 @@ static int amdxdna_drm_open(struct drm_device *ddev, =
struct drm_file *filp)
>  			if (!amdxdna_use_carveout(xdna)) {
>  				XDNA_ERR(xdna, "PASID unavailable and carveout not configured");
>  				kfree(client);
> -				return -EINVAL;
> +				ret =3D -EINVAL;
> +				goto dev_exit;
>  			}

[Severity: High]
This isn't a bug introduced by this patch, but does this error handling path
lead to a double-free of the SVA device handle?

In amdxdna_sva_init(), if iommu_sva_get_pasid() fails, the code calls
iommu_sva_unbind_device(client->sva) but leaves client->sva pointing to the
unbound handle:

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_sva_init() {
	client->pasid =3D iommu_sva_get_pasid(client->sva);
	if (client->pasid =3D=3D IOMMU_PASID_INVALID) {
		iommu_sva_unbind_device(client->sva);
		XDNA_ERR(xdna, "SVA get pasid failed");
		return -ENODEV;
	}
}

If amdxdna_use_carveout() is true, the error is ignored here, and the open
succeeds.

Later, when amdxdna_client_cleanup() calls amdxdna_sva_fini(), the
IS_ERR_OR_NULL(client->sva) check passes since client->sva is a dangling
pointer, leading to a second call to iommu_sva_unbind_device(client->sva).

[ ... ]
> @@ -175,11 +186,10 @@ static void amdxdna_drm_close(struct drm_device *dd=
ev, struct drm_file *filp)
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(ddev);
>  	int idx;
> =20
> -	XDNA_DBG(xdna, "closing pid %d", client->pid);
> -
>  	if (!drm_dev_enter(&xdna->ddev, &idx))
>  		return;
> =20
> +	XDNA_DBG(xdna, "closing pid %d", client->pid);
>  	mutex_lock(&xdna->dev_lock);
>  	amdxdna_client_cleanup(client);
>  	mutex_unlock(&xdna->dev_lock);

[Severity: High]
This is a pre-existing issue, but while drm_dev_enter() now protects open
and close, are the ioctl handlers still vulnerable to a use-after-free duri=
ng
device removal?

The DRM core's drm_ioctl() does not hold drm_dev_enter() and only performs a
lockless check of drm_dev_is_unplugged(). If an ioctl is running concurrent=
ly
with amdxdna_remove(), drm_dev_unplug() will not wait for the ioctl to fini=
sh.
The client structure can be freed while concurrently running ioctls try to
access it.

For example, in amdxdna_drm_create_bo_ioctl():

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_drm_create_bo_ioctl() {
	struct amdxdna_client *client =3D filp->driver_priv;
	...
}

Should drm_dev_enter() be added to the ioctl handlers as well to prevent
accessing a freed client structure?


[Severity: High]
This is a pre-existing issue, but does freeing the client structure during
device removal cause a deterministic use-after-free when GEM objects are
eventually closed?

When amdxdna_remove() forcefully frees the client structure via
amdxdna_client_cleanup(), active GEM objects created by this client are not
destroyed because the DRM core holds references to them as long as the user=
's
file descriptor remains open.

When the user eventually closes the file descriptor or unmaps the GEM objec=
ts,
amdxdna_gem_obj_close() is invoked, which accesses the freed client structu=
re:

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_gem_del_bo_usage() {
	guard(mutex)(&client->mm_lock);
	...
}

Could the client structure be kept alive until all GEM objects drop their
references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608161418.2748=
988-1-lizhi.hou@amd.com?part=3D1
