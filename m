Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90960CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B4310E562;
	Fri,  2 Oct 2026 11:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YEcNIxcI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40AA410E562;
 Fri,  2 Oct 2026 11:49:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEECB4034F;
 Fri,  2 Oct 2026 11:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6CE1F000FF;
 Fri,  2 Oct 2026 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790941780;
 bh=UK90ShrRXd2QL2PxPL4IaGENXrV3kz0MwijSBNAuHGw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YEcNIxcIok6PLZ2ljTngF7uPIfJCv0mYaC4D0zNequPYTXNEjmufkWTWSvK178mmo
 iLvzFauqbuenHWchs/qqufn/dW9ZekEpno1YOkT+kXkWuUesYdHW0kuD8JLiYJDKxo
 0DLX5m0nc/iEdzSnNEZJaukGziwlvhICvnE7eWYFU//JrSlV9MJEisLytA+WIIxyw9
 PpClaIpx22ZniWekb63GvoHFgTrkX+YY7KKdDWKxisde+qPXBXj8zozDb0isL8k3a/
 MGGk61YhIuw1bYsURY5nInnzwe6oJxlSoHdsFFkG6X6iiH+aaPtsezClKdd5GEUJ87
 HRqoEs4Nx6yoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] PCI: Honor alignment overrides
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261002113319.6652-4-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:49:39 +0000
Message-Id: <20261002114940.9B6CE1F000FF@smtp.kernel.org>
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
- [Medium] pci: pci_init_pci_resreq_data() confuses default alignment with =
user override
--

commit 9d8429783cc0cbfe47ed3509438a7591dc940ce5
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Honor alignment overrides

This commit introduces struct pci_resreq_data to hold device and user-given
alignment information so that pci_align_resource() can honor the
pci=3Dresource_alignment argument. When a user-given alignment is found, any
remainder movement is skipped to avoid violating the requested alignment.

Link: https://lore.kernel.org/linux-pci/20260923133202.07DF61F000FF@smtp.ke=
rnel.org/

[ ... ]

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 376f09630a4ab..441a62807719d 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -265,17 +265,21 @@ resource_size_t pci_resource_alignment(const struct=
 pci_dev *dev,
>   * before res->start if there's enough free space there. This enables
>   * tighter packing for resources.
>   */
> -resource_size_t pci_align_resource(struct pci_dev *dev,
> +resource_size_t pci_align_resource(struct pci_resreq_data *rr,
>  				   const struct resource *res,
>  				   const struct resource *empty_res,
>  				   resource_size_t size,
>  				   resource_size_t align)
>  {
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t remainder, start_addr;
> =20
>  	if (!(res->flags & IORESOURCE_MEM))
>  		return res->start;
> =20
> +	if (rr->user_align)
> +		return res->start;
> +
[Severity: Medium]
Does this inadvertently skip remainder movement for all devices on platforms
with non-zero default alignments?

On platforms where pcibios_default_alignment() returns a non-zero value
(such as PowerPC), rr->user_align might be populated with that default
rather than specifically a user-requested override. If this condition
evaluates as true for those defaults, it appears it would entirely disable
the remainder movement logic and limit PCI resource packing efficiency acro=
ss
the platform.

Note that follow-up modifications to this condition (such as checking if the
index is 1 or 3) would still incorrectly trigger based on a default alignme=
nt
if the distinction between user overrides and defaults is lost.

[ ... ]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1ef..fe0233f0d9e6e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1217,12 +1217,34 @@ int __must_check pcibios_enable_device(struct pci=
_dev *, int mask);
>  /* Architecture-specific versions may override this (weak) */
>  char *pcibios_setup(char *str);
> =20
> -/* Used only when drivers/pci/setup.c is used */
> +/* Resource assignment request handling */
> +/**
> + * struct pci_resreq_data - Data passed to pcibios_align_resource()
> + * @dev: PCI device
> + * @user_align: User provided alignment override (pci=3Dresource_alignme=
nt param)
> + */
> +struct pci_resreq_data {
> +	struct pci_dev *dev;
> +	resource_size_t user_align;
> +};
> +
> +resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> +						 bool *resize);
> +static inline void pci_init_pci_resreq_data(struct pci_resreq_data *rr,
> +					    struct pci_dev *dev)
> +{
> +	bool user_aligned;
> +
> +	memset(rr, 0, sizeof(*rr));
> +	rr->dev =3D dev;
> +	rr->user_align =3D pci_specified_resource_alignment(dev, &user_aligned);
> +}
> +
[Severity: Medium]
Does this initialize rr->user_align with the returned alignment size while
ignoring the boolean flag that indicates if it was actually requested by
the user?

Looking at pci_specified_resource_alignment() in drivers/pci/pci.c, it
falls back to pcibios_default_alignment() if no user override matches. The
user_aligned flag is set to true only when a specific override is found.
Because the return value is assigned directly to rr->user_align, it seems
struct pci_resreq_data cannot differentiate between a default alignment and=
 an
actual user override.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002113319.6652=
-1-ilpo.jarvinen@linux.intel.com?part=3D3
