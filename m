Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBCC606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsWPymX7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1C810E1A6;
	Tue, 10 Nov 2026 12:43:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A5A010E1A6
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:43:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4100B63908;
 Tue, 10 Nov 2026 12:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15C81F0089F;
 Tue, 10 Nov 2026 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794314624;
 bh=XPefT0fr3wupychDfnABDtN7x7rVMQKiNrbW2cLICoA=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=bsWPymX7+lfe73MT5e35/b1PX3m7Vta5PtxMBjI10WgFUUwnrU/Q4C0qJp6T0VKTg
 1SE59OtlHhLqFyp7UB8nK94wEW+5ypzsN92WP2QjGAcdhFm7Dxz5TLJQLxhRA8lzAv
 5zUWiLeaDowhPvo9jsuz1zKsQq3oMmbGwftVORred8EmSkDBWcVSVhQVVkWjFGQ7vj
 kVdj5iaENTuBGloeoyVRgjkcuYnSqE1SYXpVJkG5ZnbG7wnndMd/qFThaC7DkurgBK
 UQyNWYPQTS3h/U288xm1AXdVJk+vef7rgBYOYH2fgP3xun4TMeK4D1EfvTKdPTkEYF
 Q8mHmqdxeDlPA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 13:43:38 +0100
Message-Id: <DMRJG3ZQXY6Q.1WSE0ZB1YLDO8@kernel.org>
Subject: Re: [PATCH 1/2] rust: pci: add domain_nr() accessor
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "LKML"
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261110033655.148487-1-jhubbard@nvidia.com>
 <20261110033655.148487-2-jhubbard@nvidia.com>
In-Reply-To: <20261110033655.148487-2-jhubbard@nvidia.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 4:36 AM CET, John Hubbard wrote:
> The nova-core driver has to send the GPU's PCI location to the GPU's
> firmware as one word that holds the domain, the bus and the device
> number.
>
> The PCI abstraction has dev_id(), which packs the bus, the device and
> the function into one value. It has no accessor that reports the domain.
>
> Add an accessor for the domain number.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>

Is this tag intentional? (Just asking since my tooling flagged it as it was=
n't
present in the first submission of this patch and some other criteria.)

> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/helpers/pci.c |  5 +++++
>  rust/kernel/pci.rs | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index a8540f90b13c..49f2c089d236 100644
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

Rust helpers should generally be transparent wrappers and not provide any
semantics, even if it is just to resolve a pointer.

> +}
> +
>  __rust_helper resource_size_t
>  rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
>  {
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 769d01d23429..57718e48208d 100644
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
> +
> +        // CAST: `pci_domain_nr()` returns an `int`, but a registered bu=
s never has a negative
> +        // domain, because `pci_register_host_bridge()` fails when the d=
omain allocation fails.
> +        // A negative value here is a kernel bug rather than a condition=
 for a caller to handle.
> +        debug_assert!(domain_nr >=3D 0);
> +        domain_nr as u32

NIT: Please move the comment directly above the actual cast statement.

> +    }
