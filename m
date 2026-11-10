Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA0606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 03:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btWkBDH4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B379A10E0A3;
	Tue, 10 Nov 2026 03:48:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE07910E0A3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 03:48:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D6A76634E9;
 Tue, 10 Nov 2026 03:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74E01F008A6;
 Tue, 10 Nov 2026 03:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794282512;
 bh=PxEd3OjSksbK7+nLb9kkcFQkg3P4HBKGiE8PTgwn2v8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=btWkBDH4lyFeV+0ZZl/xjOdA3NcZ0EepKn7YSJAIt7cNvt9C59fP836Ns/ssZrymf
 +3povOsXK+SGg6hkqJY0tq4LMJwibmuMLhGCtuxR9oIS/2rru+txm/8CO4ZBZOLhec
 AISl44KtYjEcXec+Bsnc7TKp5qWT/ANFKeO8c/nX7QdImwagNi6eLyk0pm+EU9wrEU
 Nd0A1JhIvdnXv5QQlaTqoTp10YZSXdZmH+mr7J26E1HmdpcgOhRp6VFhZsTbwL6lvu
 Np7BjZym669R/KVCWTLfja9vlSKUzSREGYKegrcdC/uiL7OrFssiwDCok7e591LnxD
 XvQLlsI6trbkw==
Message-ID: <sashiko-outbox-206149@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rust: pci: add domain_nr() accessor
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Eliot
 Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, =?utf-8?b?Qmo=?=
 =?utf-8?b?w7ZybiBSb3kgQmFyb24=?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20261110033655.148487-2-jhubbard@nvidia.com>
References: <20261110033655.148487-1-jhubbard@nvidia.com>
 <20261110033655.148487-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:48:31 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] rust: pci: signature mismatch in rust_helper_pci_domain_nr()
  on ppc and s390
--

commit 40ebd2410b826b9813de5dae1bbe6075723a08bc
Author: John Hubbard <jhubbard@nvidia.com>

rust: pci: add domain_nr() accessor

This commit adds a domain_nr() accessor to pci::Device and a corresponding
rust_helper_pci_domain_nr() C helper to retrieve the PCI domain number.

> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index a8540f90b13ce..49f2c089d2369 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -7,6 +7,11 @@ __rust_helper u16 rust_helper_pci_dev_id(struct pci_dev =
*dev)
>  	return PCI_DEVID(dev->bus->number, dev->devfn);
>  }
> =20
> +__rust_helper int rust_helper_pci_domain_nr(struct pci_dev *dev)
> +{
> +	return pci_domain_nr(dev->bus);
> +}
> +
>  __rust_helper resource_size_t
>  rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
>  {
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 769d01d234296..57718e48208d5 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -408,6 +408,20 @@ pub fn dev_id(&self) -> u16 {
>          unsafe { bindings::pci_dev_id(self.as_raw()) }
>      }
> =20
> +    /// Returns the PCI domain number of the bus that this device is on.
> +    #[inline]
> +    pub fn domain_nr(&self) -> u32 {
> +        // SAFETY: By its type invariant `self.as_raw` is always a valid=
 pointer to a
> +        // `struct pci_dev`.
> +        let domain_nr =3D unsafe { bindings::pci_domain_nr(self.as_raw()=
) };

[Severity: Medium]
Does bindings::pci_domain_nr(self.as_raw()) fail to compile on PowerPC and
s390 due to a pointer type mismatch?

In rust/bindings/lib.rs, bindings_generated.rs is included after
pub use super::bindings_helper::*, so any non-inline C function emitted by
bindgen shadows a rust_helper_* wrapper of the same stripped name.  On Powe=
rPC
(arch/powerpc/include/asm/pci.h) and s390 (arch/s390/include/asm/pci.h),
pci_domain_nr() is declared as a non-inline extern function taking
struct pci_bus * rather than a static inline function:

arch/powerpc/include/asm/pci.h:
extern int pci_domain_nr(struct pci_bus *bus);

On those architectures, bindings::pci_domain_nr resolves to the C declarati=
on
expecting *mut bindings::pci_bus instead of the helper's
*mut bindings::pci_dev, breaking the build when CONFIG_RUST and CONFIG_PCI =
are
enabled.  Either rust_helper_pci_domain_nr() should take struct pci_bus *bu=
s to
match the C signature (with domain_nr() passing (*self.as_raw()).bus), or t=
he
helper should use a distinct name that does not collide with C pci_domain_n=
r().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110033655.1484=
87-1-jhubbard@nvidia.com?part=3D1
