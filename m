Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD5606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPXfE8jH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC65810E77B;
	Fri, 13 Nov 2026 08:08:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758BB10E3AC
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:07:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74433623AC;
 Fri, 13 Nov 2026 08:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED5F1F000C5;
 Fri, 13 Nov 2026 08:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794557247;
 bh=QsRRtDVgwopOo2I9FfGM2qqA7XAoM8tcAV0BKp1IgIA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UPXfE8jHYgz0muNAkhIR+9uEwBBSkH2FuJ81/Q8v8Px3gRlAY3TGfHCKNVxweCrt9
 Q4bEJKXiO19jrhGqsNVZphfWGZDzVPNspx55JC3coZB/nXFf0QY6WKcbQC/P6a2bvM
 MNRo2oxdyfdDnppxqnSS/NvGHtDEhycMezgog7uGKEK7FxP8dWLTTXoJK56gCccM9p
 5u+Ed3741Z5K5BcMfvCYOqWK2H73mra4CFfFIIH3oggm+Nhfp2+nVeZjhH9lfvbNyW
 VYZdEodGQrEv8X0RQNU7O5Ft5D34MEpx8NnQl5T79NRGMRKyNwDciswTLjgdHJy7K/
 AX0d9tmu7XSBg==
Message-ID: <sashiko-outbox-212382@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpu: nova-core: mm: keep a page table page before
 installing its PDE
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>, dakr@kernel.org,
 joelagnelf@nvidia.com
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, aliceryhl@google.com,
 ecourtney@nvidia.com, gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261113075422.943779-1-vladazaharova2018@gmail.com>
References: <20261113075422.943779-1-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:07:26 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] gpu: nova-core: mm: dangling child pt_pages entries in
  install_mappings()
--

commit f3589ce920c77d23cb7e6ccb885a516db848c4b9
Author: Vladislav Zaharov <vladazaharova2018@gmail.com>

gpu: nova-core: mm: keep a page table page before installing its PDE

This commit moves the page_table_allocs.push_within_capacity() call in
install_mappings() ahead of writing the PDE for each prepared page table
page.

> diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova=
-core/mm/pagetable/map.rs
> index f7774b9cc972f..e678197ec009c 100644
> --- a/drivers/gpu/nova-core/mm/pagetable/map.rs
> +++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
> @@ -209,8 +209,15 @@ pub(super) fn install_mappings(
>                  let (install_addr, page) =3D node.to_key_value();
>                  let page_vram =3D
>                      VramAddress::from_raw(page.alloc.iter().next().ok_or=
(ENOMEM)?.offset());
> +                let level =3D page.level;
> =20
> -                if page.level =3D=3D M::DUAL_PDE_LEVEL {
> +                // Keep the page before pointing a PDE at it, so that a =
failure here cannot leave a
> +                // PDE pointing at freed VRAM.
> +                page_table_allocs
> +                    .push_within_capacity(page.alloc)
> +                    .map_err(|_| ENOMEM)?;

[Severity: Medium]
Does failing in push_within_capacity() or the following PDE write still
leave child entries in pt_pages pointing into freed or unlinked parent
page table VRAM?

ensure_single_pte_path() inserts missing page table levels top-down into
Vmm::pt_pages, where a child node's install_addr key is a physical address
inside its prepared parent page's VRAM allocation.  In install_mappings(),
c.remove_current() removes the current node before push_within_capacity()
is called.

If a parent node is visited before its child and push_within_capacity()
fails on the parent, dropping page.alloc frees the parent's VRAM while the
child node remains in Vmm::pt_pages (which Vmm::execute_map() does not
clear on error); a later Vmm::execute_map() or Vmm::map_pages() call then
drains Vmm::pt_pages and writes the child PDE into the freed parent VRAM
page.  Conversely, if the child is visited first in VramAddress order, its
PDE is written into the parent page and its allocation is kept in
page_table_allocs before the parent fails and is freed, and if the PDE
write itself fails after push_within_capacity() succeeds, the parent page
is kept in page_table_allocs without being linked into the hardware page
tables while remaining children in pt_pages still target it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113075422.9437=
79-1-vladazaharova2018@gmail.com?part=3D1
