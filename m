Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95936CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C735910E8E4;
	Tue, 13 Oct 2026 14:37:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C04110E8E4
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:37:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 67F3D42202;
 Tue, 13 Oct 2026 14:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E700C1F000FF;
 Tue, 13 Oct 2026 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791902259;
 bh=3xHLXtkWQqlyDGWx00uFDUUYhCcz7ualavf3DytNyic=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lrcNYprIU8NVDrpuELs2hhzWpp6f864UPr1Fz8qnc5P9GiFuj+gtTxas4MJ26EDES
 rYxmS10Mw6IJA2fb7/MH73O6S/6UbLqEHxPEuVwB4WGZqv5nOG84ddcgicjaxLy97/
 2zpCqNu/yqkTVVPsaD6nQtlFYn3645ibzc4ima9QGfHQhNeQjCBgLARstLFhuPNR8Q
 iwJcUBPscc7E05pHBBinfdhfC+hgZxYBF+kqYF5R9JR4YqPj4gWXDFWtYejp7VZUlv
 fER+JKiwry5vEegESThlptJoXsdSv+TYF6ZmZwGLc70d+P3Os7qvSYv6+tSUsYn1oH
 Pqim5/toy4fYA==
Message-ID: <sashiko-outbox-169923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/19] PCI/P2PDMA: Route Relaxed Ordering
 Completions directly
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261013-fix-p2p-acs-v4-0-v11-9-72cf8c96e617@nvidia.com>
References: <20261013-fix-p2p-acs-v4-0-v11-0-72cf8c96e617@nvidia.com>
 <20261013-fix-p2p-acs-v4-0-v11-9-72cf8c96e617@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:37:38 +0000
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
- [Low] pci/p2pdma: false positive warning if Relaxed Ordering route succee=
ds
--

commit e6e15dbbdb2b5d6dee258b1197f71025a221015f
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Route Relaxed Ordering Completions directly

ACS P2P Completion Redirect leaves Completions carrying Relaxed Ordering
alone, per PCIe r7.0 sec 6.12.1.1. A Completion copies that attribute from
its Request, so a client setting it on Non-Posted Requests need not use the
host bridge solely because Completion Redirect is enabled.

Route Completions directly for PCI_P2PDMA_TLP_RELAXED_CPL unless a device
quirk redirects them or the Completer lacks an internal route to its
sibling. Neither restriction promises a Relaxed Ordering exception. No
caller selects these classes yet.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9d416329aa4b8..785e4668a2af5 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -580,11 +580,15 @@ pci_acs_p2pdma_request(u16 ctrl, unsigned int tlp_f=
lags)
>  /*
>   * Decide how a peer-to-peer Completion at an ACS-capable ingress port r=
outes.
>   * PCIe r7.0 sec 6.12.1.1: no ACS control other than P2P Completion Redi=
rect
> - * affects a Completion.
> + * affects a Completion, and that one leaves Completions carrying the Re=
laxed
> + * Ordering attribute alone.
>   */
>  static enum pci_acs_p2pdma_state
>  pci_acs_p2pdma_completion(u16 ctrl, unsigned int tlp_flags)
>  {
> +	if (tlp_flags & PCI_P2PDMA_TLP_RELAXED_CPL)
> +		return PCI_ACS_P2PDMA_DIRECT;
> +

[Severity: Low]
Now that Relaxed Ordering completions can route directly while strict order=
ing
might still redirect, does this cause a false positive warning in
calc_map_type_and_dist() in drivers/pci/p2pdma.c?

calc_map_type_and_dist() iterates over all PCI_P2PDMA_TLP_CLASSES and sets
host_fallback =3D true if any class requires the host bridge:

	for (flags =3D 0; flags < PCI_P2PDMA_TLP_CLASSES; flags++) {
		map_type[flags] =3D pci_p2pdma_route(&path, flags);
		if (map_type[flags] =3D=3D PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
			host_fallback =3D true;
	}

Later, if the host bridge does not support P2PDMA, it emits an unconditional
warning for the device:

	if (!cpu_p2pdma && !host_whitelisted) {
		if (verbose)
			pci_warn(client, "cannot be used for peer-to-peer DMA...");
	}

If a caller successfully requests a Relaxed Ordering route that maps direct=
ly,
but the strict ordering route required the host bridge, will this
unconditional warning mislead users into thinking P2P DMA is completely
broken for their setup?

>  	return ctrl & PCI_ACS_CR ? PCI_ACS_P2PDMA_REDIRECT :
>  				   PCI_ACS_P2PDMA_DIRECT;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-fix-p2p-ac=
s-v4-0-v11-0-72cf8c96e617@nvidia.com?part=3D9
