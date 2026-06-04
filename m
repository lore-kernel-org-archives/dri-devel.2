Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D320CCD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD4610E0BB;
	Thu,  4 Jun 2026 20:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C/+s6YHz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 270DC10E0BB
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:44:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 753736001A;
 Thu,  4 Jun 2026 20:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F2B1F00893;
 Thu,  4 Jun 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780605887;
 bh=M1VIcVUyAWn03ui1zRSU5VEuk0K0RuKqomxEDhF1JDk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C/+s6YHz915nkajps4vTcW5zsgx6BEOKaII6P54wx0yFZzNVG9qq0jlIZtCgFZTGz
 WqxkB06UcUFcAkMrpRbeBtZ7PcQzOQmcE6yKSt6gKgk4ZmW2WwWBT4W36E7kbFkOeo
 GG4xOckTzm4jHpqlnqQ/5rUf0cDZqfB3mwEAbSEaezWNNnb0S2pi+1J7+iveJJYVPZ
 gGlUm7QT9lSd2zyMFe2lXJPb+vSC9rjn+olLYlpuJN133OkqgqZUgQotJMABi03Kjb
 q3+DD2RRoImREP/Fypo91pJjwxqcLQJd92Wf/VgBM2BPC4dGe/t5K3jMTrrQ5yvENe
 XxmZfoxuRU0eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Clear sva pointer after unbind
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604202815.2425882-1-lizhi.hou@amd.com>
References: <20260604202815.2425882-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:44:46 +0000
Message-Id: <20260604204447.11F2B1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The device removal path forcibly frees `amdxdna_client` struct=
ures while their corresponding file descriptors remain open, causing system=
atic Use-After-Free (UAF) vulnerabilities in IOCTLs, mmap, and closure path=
s.
- [High] AIE4 hardware context creation unconditionally sets the PASID as v=
alid and sends an invalid PASID value to the firmware on non-IOMMU/carveout=
 systems.
- [High] In `amdxdna_drm_open()`, the newly allocated `client` structure is=
 added to the global `xdna->client_list` before its initialization is compl=
ete, causing a TOCTOU race condition.
- [High] The return value of init_srcu_struct() is ignored, potentially lea=
ding to a NULL pointer dereference on its per-CPU arrays under memory press=
ure.
--

commit 38ba86620597fb9bb1ac8b2c38ecbef54add17c2
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Clear sva pointer after unbind

Add client->sva =3D NULL after the unbind makes it consistent with how
amdxdna_sva_fini() already clears the pointer after unbinding. The
IS_ERR_OR_NULL guard in sva_fini will then correctly skip the second
unbind.

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index c677293c1ae7f..70410c5e8fd47 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -87,6 +87,7 @@ static int amdxdna_sva_init(struct amdxdna_client *clie=
nt)
>  	client->pasid =3D iommu_sva_get_pasid(client->sva);
>  	if (client->pasid =3D=3D IOMMU_PASID_INVALID) {
>  		iommu_sva_unbind_device(client->sva);
> +		client->sva =3D NULL;

[Severity: High]
This is a pre-existing issue, but I noticed that when the pasid is
IOMMU_PASID_INVALID (which is a permitted state for physical address/carveo=
ut
mode), aie4_hwctx_create() might send an invalid pasid to the firmware.

drivers/accel/amdxdna/aie4_ctx.c:aie4_hwctx_create() {
    ...
    req.pasid =3D FIELD_PREP(AIE4_MSG_PASID, client->pasid) |
                FIELD_PREP(AIE4_MSG_PASID_VLD, 1);
    ...
}

Does this unconditionally mask client->pasid and set AIE4_MSG_PASID_VLD to =
1?
Sending an all-1s pasid with the valid bit set might lead to iommu faults or
hardware hangs.

AIE2 seems to check amdxdna_pasid_on() and passes 0 if the pasid is invalid.
Should AIE4 do something similar?

[Severity: Critical]
This isn't a bug introduced by this patch, but the device removal path
appears to forcibly free amdxdna_client structures while their file
descriptors might still be open.

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_remove() {
    ...
    while (client) {
        amdxdna_client_cleanup(client);
        client =3D list_first_entry_or_null(&xdna->client_list, ...
    ...
}

Since drm_dev_unplug() does not force the closure of open files, can vfs
or drm file descriptors remain open after amdxdna_client_cleanup() frees
the client memory?

If the file descriptor is later closed by the process exiting,
amdxdna_drm_close() accesses client->pid before calling drm_dev_enter():

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_drm_close() {
    ...
    struct amdxdna_client *client =3D filp->driver_priv;
    ...
    XDNA_DBG(xdna, "closing pid %d", client->pid);
    ...
}

Similarly, ioctls like amdxdna_drm_get_info_ioctl() dereference the freed
client structure without drm_dev_enter() protection. Can this lead to a
use-after-free?

[Severity: High]
This is a pre-existing issue, but there might be a race condition in
amdxdna_drm_open() during client initialization.

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_drm_open() {
    ...
    list_add_tail(&client->node, &xdna->client_list);
    mutex_unlock(&xdna->dev_lock);

    filp->driver_priv =3D client;
    client->filp =3D filp;
    ...
}

Since accel_open() avoids calling drm_dev_enter(), could amdxdna_remove()
execute concurrently and find this partially initialized client in the list?

If amdxdna_remove() frees the client before amdxdna_drm_open() finishes,
could the assignment to filp->driver_priv result in a dangling pointer?

[Severity: High]
This isn't a bug introduced by this patch, but the return value of
init_srcu_struct() seems to be ignored.

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_drm_open() {
    ...
    init_srcu_struct(&client->hwctx_srcu);
    ...
}

Since init_srcu_struct() allocates per-CPU memory and can return -ENOMEM,
what happens if the allocation fails? Will the srcu_struct be left
partially initialized?

If subsequent ioctls invoke srcu_read_lock(&client->hwctx_srcu), could
this dereference unallocated pointers and cause a kernel panic?

>  		XDNA_ERR(xdna, "SVA get pasid failed");
>  		return -ENODEV;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604202815.2425=
882-1-lizhi.hou@amd.com?part=3D1
