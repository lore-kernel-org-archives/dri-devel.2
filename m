Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD8DCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FF210F6EC;
	Mon,  8 Jun 2026 16:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bFdpIo9V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF3010F6EC
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:29:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2C9460098;
 Mon,  8 Jun 2026 16:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588671F00893;
 Mon,  8 Jun 2026 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780936140;
 bh=WvDCmbIqSiWrOPmRde9VeNR/godR/Z3VTXE8gQwK8KY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bFdpIo9Vhbu+e3suVz6R154TCwVxYprRg0y006bDvnzHtV+2ogxnJcJnsba+uwKpu
 Bx92pi0bI9T4WcjISwilyTWglK/1BmhBdied1AuM0owqyDRg3tnZfMLlVI9e23Yntc
 HswMFrB1gv1h4WDk/sncYaRdhVTRYy3aTytmJqq2/jGDRdEroGBxYZoTjBSRkdUtdN
 1BU3ahbPHBkWdqsdIPMaxnP1P8/Dw70vaJMCc4TiP4NPhO19/aEkoUhcryMPCncejO
 sWG7JlcgHOpzLX4KiNI4/h8yq7cWVOxZuwQ6J5PfrSdo/Kx5XHvs0e29z3+uUv3NVm
 c/QpYGMWHKlRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 3/3] accel/amdxdna: Fix amdxdna_client race in
 amdxdna_show_fdinfo()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608161418.2748988-3-lizhi.hou@amd.com>
References: <20260608161418.2748988-3-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:28:59 +0000
Message-Id: <20260608162900.588671F00893@smtp.kernel.org>
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
- [Critical] The patch addresses a Use-After-Free in `amdxdna_show_fdinfo()=
`, but identical UAF vulnerabilities exist across most ioctls and GEM destr=
uction paths due to broken client lifecycle management.
- [Critical] Premature destruction of `notifier_wq` in `amdxdna_remove()` c=
auses a Use-After-Free when GEM objects are subsequently freed.
- [High] `amdxdna_sva_init()` leaves `client->sva` as a dangling pointer if=
 `iommu_sva_get_pasid()` fails, leading to a double `iommu_sva_unbind_devic=
e()` on client cleanup.
--

commit 225c80eb0fc36a5511f44ce636794ce0b887dbc7
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix amdxdna_client race in amdxdna_show_fdinfo()

This patch guards the show_fdinfo path with drm_dev_enter() and
drm_dev_exit() to prevent use-after-free of the amdxdna_client structure
after the device has been unplugged.

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index c18ddad9f6459..e6b541db38981 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -296,6 +296,10 @@ static void amdxdna_show_fdinfo(struct drm_printer *=
p, struct drm_file *filp)
>  	struct amdxdna_client *client =3D filp->driver_priv;
>  	size_t heap_usage, external_usage, internal_usage;
>  	char *drv_name =3D filp->minor->dev->driver->name;
> +	int idx;
> +
> +	if (!drm_dev_enter(filp->minor->dev, &idx))
> +		return;

[Severity: Critical]
This is a pre-existing issue, but while this patch addresses the UAF in
amdxdna_show_fdinfo(), do the same vulnerabilities exist across other ioctls
and GEM destruction paths due to broken client lifecycle management?

For example, amdxdna_remove() forcefully frees each amdxdna_client struct
by calling amdxdna_client_cleanup() while file descriptors might still be
open:

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_remove() {
    ...
    client =3D list_first_entry_or_null(&xdna->client_list, ...);
    while (client) {
        amdxdna_client_cleanup(client);
        ...
    }
}

Meanwhile, IOCTL handlers like amdxdna_drm_submit_cmd_ioctl(),
amdxdna_drm_config_hwctx_ioctl(), and amdxdna_drm_wait_cmd_ioctl() omit
drm_dev_enter(), extracting the client pointer directly from
filp->driver_priv:

drivers/accel/amdxdna/amdxdna_ctx.c:amdxdna_drm_submit_cmd_ioctl() {
    struct amdxdna_client *client =3D filp->driver_priv;
    ...
    return amdxdna_drm_submit_execbuf(client, args);
}

If amdxdna_remove() runs concurrently, will these IOCTLs access the freed
client structure, causing a Use-After-Free? Similarly, when the file
descriptor is eventually closed post-unplug, will GEM destruction paths
like amdxdna_gem_obj_close() and amdxdna_gem_dev_obj_free() dereference the
already-freed abo->client pointer?


> =20
>  	mutex_lock(&client->mm_lock);
> =20

[ ... ]

[Severity: High]
This is a pre-existing issue, but does amdxdna_sva_init() leave client->sva
as a dangling pointer if iommu_sva_get_pasid() fails?

In amdxdna_sva_init(), if iommu_sva_bind_device() succeeds but getting the
pasid fails, the device is unbound but client->sva is not set to NULL:

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_sva_init() {
    ...
    client->pasid =3D iommu_sva_get_pasid(client->sva);
    if (client->pasid =3D=3D IOMMU_PASID_INVALID) {
        iommu_sva_unbind_device(client->sva);
        XDNA_ERR(xdna, "SVA get pasid failed");
        return -ENODEV;
    }
}

Then in amdxdna_drm_open(), if amdxdna_sva_init() fails but
amdxdna_use_carveout(xdna) is true, the driver issues a warning and allows
the client initialization to succeed.

When the file descriptor is closed and amdxdna_client_cleanup() calls
amdxdna_sva_fini(), will this dangling pointer bypass the IS_ERR_OR_NULL()
check and cause a double iommu_sva_unbind_device()?

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_sva_fini() {
    if (IS_ERR_OR_NULL(client->sva))
        return;

    iommu_sva_unbind_device(client->sva);
}

[Severity: Critical]
This is a pre-existing issue, but does the premature destruction of
notifier_wq in amdxdna_remove() cause a Use-After-Free when GEM objects
are subsequently freed?

amdxdna_remove() destroys the workqueue before GEM objects are completely
released:

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_remove() {
    ...
    destroy_workqueue(xdna->notifier_wq);
    ...
    drm_dev_unplug(&xdna->ddev);
}

When a GEM object's refcount drops to zero later, amdxdna_gem_obj_free()
is invoked and unconditionally calls flush_workqueue() on the destroyed
workqueue:

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_gem_obj_free() {
    ...
    amdxdna_hmm_unregister(abo, NULL);
    flush_workqueue(xdna->notifier_wq);
}

Could the destruction of the workqueue be deferred to the DRM device release
callback instead of the PCI remove callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608161418.2748=
988-1-lizhi.hou@amd.com?part=3D3
