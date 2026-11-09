Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08E606A331
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFPEv7h6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7FD10E412;
	Mon,  9 Nov 2026 22:18:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F99F10E8F7
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 22:18:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75F7D61474;
 Mon,  9 Nov 2026 22:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7471F0089F;
 Mon,  9 Nov 2026 22:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794262724;
 bh=PqUsSI/pBW0rMqLjhQm3/UP4yO+Dz7g7JjNH+6EZEDY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=aFPEv7h6r7yMyqPCdYuvWZeoCafV4GMiKfXZ8i/fnK9zNF9PScUH0IbWVczxKBG6D
 HS9IpMwORTUxGo13ghNVXq28enxfRb0ZliuziNYNRBpQqsNewztyqV0uTxNdAc4E17
 oydVSDTRWuK657KGrVDTICg/DXrLBTW2iasXqusiOS0ac0ZhPuKfeJh130Goep/qN3
 TV8tUNnhmW/Bdth4nHudVjoznxgGs3MBP8gP/hHRdaQsG9VxAoE31juenTlQLeVliM
 6yqKgkNuio4ZUSfLkXZbXvT72WqiYWcYyg5DKxoV4SenSHcbzS2KFAHf+//hJgejXG
 RA4evd+EM6Nxw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 23:18:34 +0100
Message-Id: <DMR11RZ87ZS1.36616ZBZT4MVE@kernel.org>
Subject: Re: [PATCH v2 03/12] rust: pci: allow drivers to manage DMA ownership
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-4-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-4-xinmengs@nvidia.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 23, 2026 at 5:39 PM CEST, Simon Song wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 10864ffda4e..a156927e23d 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -108,6 +108,7 @@ unsafe fn register(
>              (*pdrv.get()).probe =3D Some(Self::probe_callback);
>              (*pdrv.get()).remove =3D Some(Self::remove_callback);
>              (*pdrv.get()).id_table =3D T::ID_TABLE.as_ptr();
> +            (*pdrv.get()).driver_managed_dma =3D T::DRIVER_MANAGED_DMA;
>              #[cfg(CONFIG_PCI_IOV)]
>              if T::HAS_SRIOV_ENABLE {
>                  (*pdrv.get()).sriov_configure =3D Some(Self::sriov_confi=
gure_callback);
> @@ -345,6 +346,9 @@ pub trait Driver {
>      /// The table of device ids supported by the driver.
>      const ID_TABLE: IdTable<Self::IdInfo>;
> =20
> +    /// Whether the driver manages DMA ownership instead of using the de=
fault DMA domain.
> +    const DRIVER_MANAGED_DMA: bool =3D false;

The problem with this is that it doesn't prevent drivers from calling into =
the
safe dma::* APIs and hence is unsound (the IOMMU core relies on this contra=
ct
AFAIK).

This completely goes away once we implement the InitTokens and dma::Setup t=
oken
idea [1] from Alex and me.

I.e. you'd have something like this passed to probe():

	#[non_exhaustive]
	pub struct InitTokens<'bound> {
	    /// None when the driver manages DMA ownership.
	    pub dma: Option<dma::Setup<'bound>>,
	}

In order to not make this a blocker for this series, we could also do somet=
hing
like this in the meantime:

	pub struct DriverManagedDma<D: ?Sized>(
	    PhantomData<fn() -> *mut D>,
	);
=09
	impl<D: ?Sized> DriverManagedDma<D> {
	    /// # Safety
	    ///
	    /// The caller must ensure that devices bound to `D` are not used
	    /// for DMA allocations or mappings through the kernel DMA API,
	    /// directly or through helpers.
	    pub const unsafe fn new() -> Self {
	        Self(PhantomData)
	    }
	}
=09
	pub trait Driver {
	    const DRIVER_MANAGED_DMA: Option<DriverManagedDma<Self>> =3D None;
	}
=09
	impl pci::Driver for MyDriver {
	    // SAFETY: This driver never uses the kernel DMA API for its devices,
	    // directly or through helpers.
	    const DRIVER_MANAGED_DMA: Option<pci::DriverManagedDma<Self>> =3D
	        Some(unsafe { pci::DriverManagedDma::new() });
	}

[1] https://lore.kernel.org/all/DLUTSDP614AJ.2JU6SDKECJOCU@nvidia.com/
