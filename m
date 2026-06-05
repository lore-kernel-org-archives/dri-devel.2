Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1C7CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B6711AA3B;
	Fri,  5 Jun 2026 18:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FN/e9FGm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E991311AA3B
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 18:18:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45CBD601DD;
 Fri,  5 Jun 2026 18:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03571F00899;
 Fri,  5 Jun 2026 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780683515;
 bh=EERYNU0m2Ntb24dijZAyF+zNguZLZjPBXfEaxmKoryY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FN/e9FGmBW17gPNPAeGTjDUf0uXLROk9WQDNd4CQwa64eBzO3H3DohzolT1JsUJRM
 XrNzdAqwl7K9MqC7czBwWg0ae4xLotiaA3bUpUMych7/kLTHDZo0vzwdCw3ax2/BjH
 X6jUPGwzr3v013HWmXx2Dqm1awstC9SQRNAFZ6eVxS15IyVTvFq8HLL7S2sI8h8Obo
 4cbftupYeq0BeoYn+N3dHucmGM++Kya5A2P1Wm7ANhk6IY2jfSnAvlozd0wPehRAIL
 bwhZdBoy5smFqPM4e4QfK/ErG++i+aTdOSKDx85s5AM3obfPPWegvMFdb6nK97uXIE
 kCb7WsOwGsR/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Fix amdxdna_client lifetime race
 during device removal
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605175351.2496830-1-lizhi.hou@amd.com>
References: <20260605175351.2496830-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 18:18:34 +0000
Message-Id: <20260605181834.D03571F00899@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Dropping dev_lock during amdxdna_remove() list iteration causes a =
Use-After-Free if a file is closed concurrently.
- [High] Deferring IOMMU SVA unbind to amdxdna_drm_close() causes a NULL po=
inter dereference in the IOMMU core.

Pre-existing issues:
- [High] Deferred GEM object freeing accesses destroyed IOMMU domain struct=
ures, causing a Use-After-Free.
- [High] Deferred GEM object freeing calls flush_workqueue() on a destroyed=
 workqueue pointer.
--

commit ec7bb08ec6d7a0837cd580d24a3f76e7ed06a6c6
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix amdxdna_client lifetime race during device removal

This patch changes the client cleanup logic during device removal.
It decouples hardware teardown from client cleanup to avoid a use-after-free
if amdxdna_drm_close() is called concurrently with amdxdna_remove().

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index c677293c1ae7f..3016db07c7cad 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -167,18 +167,12 @@ static void amdxdna_drm_close(struct drm_device *dd=
ev, struct drm_file *filp)
>  {
>  	struct amdxdna_client *client =3D filp->driver_priv;
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(ddev);
> -	int idx;
> =20
>  	XDNA_DBG(xdna, "closing pid %d", client->pid);
> =20
> -	if (!drm_dev_enter(&xdna->ddev, &idx))
> -		return;
> -
>  	mutex_lock(&xdna->dev_lock);
>  	amdxdna_client_cleanup(client);

[Severity: High]
Since amdxdna_client_cleanup() is now deferred until file close, could this
trigger a NULL pointer dereference during SVA teardown?

When a device is removed, the PCI subsystem unlinks it from its IOMMU group.
Later, when this file is closed, amdxdna_sva_fini() calls=20
iommu_sva_unbind_device().

Inside the IOMMU core, iommu_detach_device_pasid() dereferences the group
pointer:

	struct iommu_group *group =3D dev->iommu_group;

	mutex_lock(&group->mutex);

If the device was already removed, dev->iommu_group would be NULL, causing a
crash. Does the SVA unbind need to happen earlier during device removal?

>  	mutex_unlock(&xdna->dev_lock);
> -
> -	drm_dev_exit(idx);
>  }
> =20
> [ ... ]
> @@ -436,14 +430,8 @@ static void amdxdna_remove(struct pci_dev *pdev)
>  	amdxdna_sysfs_fini(xdna);
> =20
>  	mutex_lock(&xdna->dev_lock);
> -	client =3D list_first_entry_or_null(&xdna->client_list,
> -					  struct amdxdna_client, node);
> -	while (client) {
> -		amdxdna_client_cleanup(client);
> -
> -		client =3D list_first_entry_or_null(&xdna->client_list,
> -						  struct amdxdna_client, node);
> -	}
> +	list_for_each_entry(client, &xdna->client_list, node)

[Severity: High]
Does this list_for_each_entry() loop have a use-after-free risk if the lock
is dropped internally?

The loop calls amdxdna_hwctx_remove_all(), which invokes aie2_hwctx_fini().
Inside aie2_hwctx_fini(), xdna->dev_lock is temporarily dropped to wait for
hardware idle:

	mutex_unlock(&xdna->dev_lock);

Since this patch removes the drm_dev_enter() safeguard from
amdxdna_drm_close(), a concurrent file close can acquire dev_lock while it
is dropped here. The concurrent close would remove the client from the list
via list_del() and free the client structure.

When the lock is re-acquired and list_for_each_entry() attempts to fetch the
next element, won't it dereference the freed client->node.next pointer?

> +		amdxdna_hwctx_remove_all(client);
> =20
>  	xdna->dev_info->ops->fini(xdna);
>  	mutex_unlock(&xdna->dev_lock);

[Severity: High]
This is a pre-existing issue, but does this function leave xdna->domain
dangling, leading to a use-after-free on deferred file close?

During device removal, amdxdna_remove() calls amdxdna_iommu_fini(), which
frees the domain but leaves the pointer intact:

	iommu_domain_free(xdna->domain);

If the application keeps the file descriptor open, drm_gem_object_put() will
later invoke amdxdna_gem_obj_free() during cleanup. This calls
amdxdna_dma_unmap_bo():

	if (amdxdna_iova_on(xdna)) {
		size =3D iova_align(&xdna->iovad, abo->mem.size);
		iommu_unmap(xdna->domain, abo->mem.dma_addr, size);

Since xdna->domain is not NULL, amdxdna_iova_on() returns true, and
iommu_unmap() is called on the freed domain. Should the domain pointer
be set to NULL after being freed?


[Severity: High]
This is a pre-existing issue, but could deferred GEM cleanup trigger a
use-after-free on the notifier workqueue?

Earlier in amdxdna_remove(), destroy_workqueue(xdna->notifier_wq) frees the
workqueue structure.

When a process retains an open file descriptor past device removal, the DRM
core defers GEM cleanup to the eventual file close. When
drm_gem_object_put() calls amdxdna_gem_obj_free(), it unconditionally does:

	flush_workqueue(xdna->notifier_wq);

Since the workqueue was already destroyed and freed, won't this result in
a use-after-free crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605175351.2496=
830-1-lizhi.hou@amd.com?part=3D1
