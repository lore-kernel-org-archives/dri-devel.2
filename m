Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CABC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A486110F565;
	Thu,  2 Jul 2026 18:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JrfErFCW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D47710F565
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 18:33:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0B0943E7F;
 Thu,  2 Jul 2026 18:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C6F1F000E9;
 Thu,  2 Jul 2026 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783017210;
 bh=FHAky5wZpURiKAuKpOMSDAxCLNyYScJoczXMQgVugvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JrfErFCW7E0sIDfoIEn9m1UFz+f5fbKXMNai1AcRfa0Hz8QNwoGfE2SWC4F/Em1Y3
 ANORQx4/kPPAwUnbaVsaf1uezZwk0CpH+bvWn2kf+KPALWDCXS9eQXIMKXnvA3I8Bp
 KxaMkAWLOz1jS9ClEPTQqJ1o9jUvseH1spJVbS0irIkAT62/+Qs07KjIr5IqPoTxtf
 nttE8fvoikoDOZIR5vCXkfsgNQy/9fbKGLegECDZo6BaFyz5zSYfHy/yyYGvJdDNoa
 va+MCzsO0VyiBmJ/sNj2BvmTSfWxmJRNq3wc9mZbh83EpSLOdzG5iGcqTfTWf/kXNr
 ndTiIM5CdUN8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/4] PCI/TPH: Add requester/completer type helpers
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260702181025.2694961-2-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
 <20260702181025.2694961-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:33:30 +0000
Message-Id: <20260702183330.A5C6F1F000E9@smtp.kernel.org>
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
- [High] The newly added `pcie_tph_enabled_req_type()` can return an invali=
d reserved value (2 / 0b10) because a pre-existing internal function, `get_=
rp_completer_type()`, lacks the safety checks introduced in this patch and =
was not refactored.
--

commit e4c05b2d02aee077c988b64f210719a661f03806
Author: Zhiping Zhang <zhipingz@meta.com>

PCI/TPH: Add requester/completer type helpers

This commit adds pcie_tph_enabled_req_type() to query the enabled TPH
requester mode and pcie_tph_completer_type() to check TPH completer support.
The new completer helper safely folds the reserved 0b10 encoding into "not
supported".

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 655ffd60e62f6..e7693fd9d6763 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

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

[Severity: High]
This is a pre-existing issue, but could pdev->tph_req_type hold the reserved
value 2 (0b10) here?

While this patch safely decodes the completer field via
pcie_tph_completer_type(), the pre-existing get_rp_completer_type() function
accesses the same capability on the Root Port but lacks this bounds checkin=
g.

If a Root Port presents the reserved value 0b10, get_rp_completer_type()
propagates it:

drivers/pci/tph.c:get_rp_completer_type() {
    ...
    return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
}

This unvalidated value can then be assigned to pdev->tph_req_type during
setup:

drivers/pci/tph.c:pcie_enable_tph() {
    ...
    pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
    ...
}

Since the newly added pcie_tph_enabled_req_type() API is documented to retu=
rn
only 0, 1, or 3, returning the reserved value 2 violates this contract and
could risk logic errors in callers.=20

Writing this undocumented value to the TPH Control register could also cause
undefined hardware behavior or AER panics.

Should get_rp_completer_type() be refactored to fold the reserved value
identically to how pcie_tph_completer_type() handles it?

> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702181025.2694=
961-1-zhipingz@meta.com?part=3D1
