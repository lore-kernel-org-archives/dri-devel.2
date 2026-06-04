Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4234CCD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9977D10E3B7;
	Thu,  4 Jun 2026 20:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Crs0f3XP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4C210E03D
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:10:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DA9041B03;
 Thu,  4 Jun 2026 20:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340341F0089A;
 Thu,  4 Jun 2026 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780603813;
 bh=1Il3Ss9bEXi/aaB2Zx56DrumfAtht5KpRfO81pcidCQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Crs0f3XP0pMqJGfrM3pc7Y/YxatL7XYXyMgLKOiR3oq/f9lY0r4e0GIA+sgouq+6x
 vslqGxZWLR8OdS090nNIv2JD3IZ3W6GZID0bekWLLWv7jYRQx/+bfOlRf1u0iz0LUJ
 S2gzgAXv6zcaGgYvB6LE8Lu1F+w12Mdz8NKKwYoyPEIvEMQkvz9XCPDIVQ1LfVRVcy
 UJTEdjNiEL07cCdEvYAASXln1YRste8qUVRfvqlWserXe7loJPeJjbYJurCowdpQNe
 XGJ8bcegwo1Eelj2N5RvicJkQFRAo2sAe9GMqiC1dSANzBCINr13iLJDpYWMMYY6HH
 Uk/2V8gIogTJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Require carveout when PASID and
 force_iova are disabled
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604195459.2423279-1-lizhi.hou@amd.com>
References: <20260604195459.2423279-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:10:12 +0000
Message-Id: <20260604201013.340341F0089A@smtp.kernel.org>
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
- [High] Dangling pointer in `client->sva` leads to a Use-After-Free and do=
uble-free during DRM close if `iommu_sva_get_pasid()` fails.
--

commit a925d70753a15e6bc99a30d4fbc4ec99fe4b925e
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Require carveout when PASID and force_iova are disabled
   =20
When both PASID and force_iova are disabled, this patch ensures carveout
memory is configured, returning an error during DRM open if it is not.

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index c677293c1ae7f..1f066ed8d2365 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -120,8 +120,14 @@ static int amdxdna_drm_open(struct drm_device *ddev,=
 struct drm_file *filp)
> =20
>  	if (!amdxdna_iova_on(xdna)) {
>  		/* No need to fail open since user may use pa + carveout later. */
> -		if (amdxdna_sva_init(client))
> +		if (amdxdna_sva_init(client)) {
>  			XDNA_WARN(xdna, "PASID not available for pid %d", client->pid);
> +			if (!amdxdna_use_carveout(xdna)) {
> +				XDNA_ERR(xdna, "PASID unavailable and carveout not configured");
> +				kfree(client);
> +				return -EINVAL;
> +			}
> +		}

[Severity: High]
This is a pre-existing issue, but since this patch relies on the fallback
behavior when amdxdna_sva_init() fails, does this leave a dangling pointer =
in
client->sva?

Looking at amdxdna_sva_init(), if iommu_sva_bind_device() succeeds but
iommu_sva_get_pasid() fails, the sva handle is unbound but the pointer isn't
cleared:

amdxdna_sva_init() {
    ...
    client->pasid =3D iommu_sva_get_pasid(client->sva);
    if (client->pasid =3D=3D IOMMU_PASID_INVALID) {
        iommu_sva_unbind_device(client->sva);
        XDNA_ERR(xdna, "SVA get pasid failed");
        return -ENODEV;
    }
    ...
}

If amdxdna_use_carveout() returns true, amdxdna_drm_open() continues
successfully, keeping the client object alive.

When the DRM file is later closed, amdxdna_sva_fini() is called:

amdxdna_sva_fini() {
    if (IS_ERR_OR_NULL(client->sva))
        return;

    iommu_sva_unbind_device(client->sva);
}

Since client->sva still holds the old pointer instead of NULL or an error
pointer, the IS_ERR_OR_NULL check will pass, and iommu_sva_unbind_device()
will be called a second time. Can this cause a double-free or use-after-free
of the iommu_sva structure during cleanup?

>  	}
>  	mmgrab(client->mm);
>  	init_srcu_struct(&client->hwctx_srcu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604195459.2423=
279-1-lizhi.hou@amd.com?part=3D1
