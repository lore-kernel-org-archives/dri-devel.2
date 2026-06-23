Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09BCCD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B2D010E9B6;
	Tue, 23 Jun 2026 08:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NMb4quNE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1C110E9B6
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:03:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71DF06001D;
 Tue, 23 Jun 2026 08:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147D91F000E9;
 Tue, 23 Jun 2026 08:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782201782;
 bh=MeBtZLAHnWNKswo7uz/sARlhCSP8rmNqfTs+vT/SAJI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NMb4quNEfct8T2/FSTjHVwhUHgPJ3m9Cpl9PKfHlLaoOH0jGLaier+4QzO3ldbVtZ
 R5fq8gDFYVhMSl6lGRhecRj9QmGBA/bhRTpg+Ho75uocnUb36GodkMNKxFjqAvAZwI
 +f3AIsUON+cecvS++XxXauXJkoTtlMUWFudzwISuy4chyTxZp98VTumENogL1uJiC3
 13v0jQ/mpKFf0iZ9D4rKrzvCpewNDOWvMuCQ3M6U4az1Splh5QPL1znwrFekP/t/bD
 pqa2AvpSx5YIBr66mX7Gle79E6k+bqYN+w21m1LfDcG6ATvD0kN2/LNkEp5sAoYLmC
 aiSJSa1mBQaiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] agp: efficeon: Disable PCI device on probe failure
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623075300.42474-1-mhun512@gmail.com>
References: <20260623075300.42474-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 08:03:01 +0000
Message-Id: <20260623080302.147D91F000E9@smtp.kernel.org>
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
- [High] The global agp_bridges list is accessed and modified locklessly, r=
isking list corruption.
- [High] The global agp_bridge pointer becomes a dangling pointer (Use-Afte=
r-Free) if the primary AGP bridge is removed while another bridge exists.
- [High] The efficeon AGP probe workaround for unassigned GART resources is=
 dead code due to premature pci_enable_device() failure.
--

commit 36a9a4194e2f3dcd5be646e083175ac41ccbc0a0
Author: Myeonghun Pak <mhun512@gmail.com>
Subject: agp: efficeon: Disable PCI device on probe failure

agp_efficeon_probe() enables the PCI device before checking whether the
GART resource can be assigned and before registering the AGP bridge. If
either of those later steps fails, the probe path can return without
dropping the enable reference. Route the resource-assignment failure
through a shared unwind path that puts the bridge before disabling the
PCI device.

> diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-=
agp.c
> index 0d25bbdc7e6af..8c8f0cfcb04d8 100644
> --- a/drivers/char/agp/efficeon-agp.c
> +++ b/drivers/char/agp/efficeon-agp.c
[ ... ]
> @@ -388,8 +389,8 @@ static int agp_efficeon_probe(struct pci_dev *pdev,
>  	if (!r->start && r->end) {
>  		if (pci_assign_resource(pdev, 0)) {
>  			printk(KERN_ERR PFX "could not assign resource 0\n");
> -			agp_put_bridge(bridge);
> -			return -ENODEV;
> +			err =3D -ENODEV;
> +			goto err_put_bridge;

[Severity: High]
This isn't a bug introduced by this patch, but is the Efficeon AGP probe
workaround for unassigned GART resources completely dead code?

In agp_efficeon_probe(), pci_enable_device() is called before we reach this
pci_assign_resource() fallback. Because pci_enable_device() internally calls
pci_enable_resources(), it will return -EINVAL if any mandatory resource is
unassigned.=20

If the BIOS failed to assign the GART resource, pci_enable_device() will fa=
il
and abort the probe prematurely, making this pci_assign_resource() logic
unreachable.

>  		}
>  	}
> =20
> @@ -401,7 +402,17 @@ static int agp_efficeon_probe(struct pci_dev *pdev,
>  	}
> =20
>  	pci_set_drvdata(pdev, bridge);
> -	return agp_add_bridge(bridge);
> +	err =3D agp_add_bridge(bridge);

[Severity: High]
This is a pre-existing issue, but does modifying the global agp_bridges list
here risk list corruption?

In drivers/char/agp/backend.c, agp_add_bridge() calls:
    list_add(&bridge->list, &agp_bridges);

And later in agp_remove_bridge():
    list_del(&bridge->list);

Both access the global agp_bridges list locklessly. If asynchronous PCI
probing is enabled or a parallel sysfs unbind occurs while another bridge is
probed or accessed by a client driver, could concurrent modifications corru=
pt
the linked list pointers?

> +	if (err)
> +		goto err_disable_device;
> +
> +	return 0;
> +
> +err_put_bridge:
> +	agp_put_bridge(bridge);

[Severity: High]
This is a pre-existing issue, but does agp_put_bridge() leave a dangling
pointer in the global agp_bridge variable if the primary AGP bridge is remo=
ved
while another bridge exists?

Looking at drivers/char/agp/backend.c:agp_put_bridge():

    kfree(bridge);
    if (list_empty(&agp_bridges))
            agp_bridge =3D NULL;

If multiple AGP bridges are probed, agp_bridge points to the first one. When
this first bridge is removed (e.g. via sysfs unbind), agp_put_bridge() frees
it using kfree(). However, since the second bridge is still in the list,
list_empty() evaluates to false, and agp_bridge remains unchanged, pointing
to freed memory.

Could subsequent accesses to the global agp_bridge pointer result in a
use-after-free?

> +err_disable_device:
> +	pci_disable_device(pdev);
> +	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623075300.4247=
4-1-mhun512@gmail.com?part=3D1
