Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC172C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 23:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C2710E2DA;
	Tue, 30 Jun 2026 23:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qa4ycMEN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151EF10E2C0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 23:07:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 694456001D;
 Tue, 30 Jun 2026 23:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71191F00A3A;
 Tue, 30 Jun 2026 23:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782860854;
 bh=Stg7AjDBiczf2/4Kj0vYqepZBBQYqeaJ/+PGUOKm+cI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qa4ycMENFl1HPE6hZTpRK7T8y+p1EoYB0ru1wQovl5MlTNJ5qf8fckpjRXYNsr3a6
 IWe/uBaXoNgWcL/z7/VziMnbtiPT1UY8It9SC5ZCeQGl6A0GyJZfiwuyy8GafC2iDv
 FOZvUVIcaTrzkFoYKtLR4Sw5+1B68kW29Jl0L+p/upzTpunR36eDGP0He2D28yrPvA
 pxo1ncWjV0/YERQZIE0+saefE+/5Mk0yVkGA2Km9enj+EHXMQKBjIvlSLz6KyQcx6M
 Zfx+JaGW8/m830Vp1SJURoobF3ZiJF7Ls+hFge0MhpfBHUHasSiDXhoIDvZH3oT1QQ
 TKLKBD+kO8gRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/4] PCI/TPH: Add requester/completer type helpers
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260630224328.3218796-2-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 23:07:33 +0000
Message-Id: <20260630230733.E71191F00A3A@smtp.kernel.org>
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
- [Medium] The internal `get_rp_completer_type()` function was not updated =
to use the new `pcie_tph_completer_type()` helper, leading to an API contra=
ct violation in `pcie_tph_enabled_req_type()`.
--

commit d64d0831457ed161ad198682067e0f147ca1411e
Author: Zhiping Zhang <zhipingz@meta.com>

PCI/TPH: Add requester/completer type helpers

This patch introduces pcie_tph_enabled_req_type() and
pcie_tph_completer_type() to allow drivers to query TPH requester mode
and completer capabilities without accessing pci_dev internals directly.
It also ensures the reserved 0b10 completer capability encoding is
folded into a "not supported" value for callers.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 655ffd60e62f6..e7693fd9d6763 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -173,6 +173,51 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> =20
> +/**
> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester=
 type
> + * @pdev: PCI device to query
> + *
> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_=
TPH.
> + */
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{
> +	return pdev->tph_req_type;
> +}

[Severity: Medium]
Could this helper return an undocumented value of 2 if a Root Port's TPH
Completer Supported field incorrectly exposes the reserved 0b10 value?

The internal get_rp_completer_type() function was not updated to use the new
pcie_tph_completer_type() helper, so it retains its manual decoding:

drivers/pci/tph.c:get_rp_completer_type() {
    ...
    return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
}

If get_rp_completer_type() returns 2, pcie_enable_tph() can assign this to
pdev->tph_req_type via the min() calculation:

drivers/pci/tph.c:pcie_enable_tph() {
    ...
    rp_req_type =3D get_rp_completer_type(pdev);
   =20
    /* Final req_type is the smallest value of two */
    pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
}

Should get_rp_completer_type() be refactored to use pcie_tph_completer_type=
()
to properly fold the reserved 0b10 encoding and avoid this API contract
violation?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630224328.3218=
796-1-zhipingz@meta.com?part=3D1
