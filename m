Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50289C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A212610E9EA;
	Wed, 30 Sep 2026 03:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AeVzRd9e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1B410F177
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:59:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B67B601DE;
 Wed, 30 Sep 2026 03:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315161F000FF;
 Wed, 30 Sep 2026 03:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790740768;
 bh=9skE9S0M7S5tQdYJ2NWP6PYTEv+Vm5X8FmVuQw7fbcg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AeVzRd9eB7MwVehrhY83VdQipre0DLkS8seIc7Q1SgIhX0U976Q440kWuqv1RlqZL
 UIO8IkqXDSQkadtVK9mUe2d42Ujgfzb9aVLeNZJuhSXUvy+7BfKZxWWvclQaE5fFh3
 YkeiVEmpoYG88z1RN7pi3S4vhYVlcNl1fYO/5E+NrMb1AnRfkcsMJK6JtEP0rrkRGF
 POaRkkw/z+wB1uV8NB2iU0irhOJTtRciGoMOW5y64E/e7HVtuCA4RtY1D6UydtMx2G
 xNy29zbHKig5FMvN3ehR0DJ36AdJervtD40ygMmYByOjw2xT0WDNS8DoO6EAeuujmO
 BoM/QfdiOBXNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 17/20] accel/amdxdna: Link SR-IOV VFs for power
 management sequencing
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-18-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-18-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:59:27 +0000
Message-Id: <20260930035928.315161F000FF@smtp.kernel.org>
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
- [High] pm: device link between PF and VF permanently lost on first VF unb=
ind
--

commit 2785e7a8d2421554408eee0ed2983e10f0090091
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Link SR-IOV VFs for power management sequencing

This commit adds PM device links between the Physical Function (PF) and
Virtual Functions (VFs) when SR-IOV is enabled. This ensures proper PM
sequencing so that VFs are suspended before the PF, and the PF is
resumed before VFs.

> diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/a=
ie4_sriov.c
> index 0eea28f626763..bfea6ff00ec04 100644
> --- a/drivers/accel/amdxdna/aie4_sriov.c
> +++ b/drivers/accel/amdxdna/aie4_sriov.c

[ ... ]

> +static int aie4_link_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_v=
f)
> +{
> +	struct pci_dev *pdev_pf =3D to_pci_dev(xdna->ddev.dev);
> +	struct device_link *link;
> +
> +	link =3D device_link_add(&pdev_vf->dev,   /* consumer =3D VF */
> +			       &pdev_pf->dev,   /* supplier =3D PF */
> +			       DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER);

[Severity: High]
Could this device link be permanently lost on the first VF driver unbind?

The DL_FLAG_AUTOREMOVE_CONSUMER flag automatically deletes the device link
when the consumer (VF) driver unbinds. Since the link is only created by the
PF driver during aie4_sriov_start() when SR-IOV is first enabled, it appears
it won't be recreated if a driver is subsequently re-bound to the VF.

If an administrator unbinds and rebinds a VF driver, would the missing
PM device link allow the PM core to runtime-suspend the PF while the
newly-bound VF is actively using it? Removing DL_FLAG_AUTOREMOVE_CONSUMER
might ensure the link remains tied to the device lifecycle instead.

> +	if (!link) {
> +		XDNA_ERR(xdna, "Failed to link VF %s", pci_name(pdev_vf));
> +		return -EINVAL;
> +	}
> +
> +	XDNA_DBG(xdna, "Linked VF %s", pci_name(pdev_vf));
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D17
