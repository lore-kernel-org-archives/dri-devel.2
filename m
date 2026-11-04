Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAFA6083636
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyEhxh0i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4A010FD79;
	Wed,  4 Nov 2026 17:29:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CAEE10FD79
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:29:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 031B943EA7;
 Wed,  4 Nov 2026 17:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121B81F000C1;
 Wed,  4 Nov 2026 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793813351;
 bh=BBw8pv978i++9C5yzqWVC2xo/MJFHYabt1uQ3NtXX7M=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=HyEhxh0iBGoIeyP/Fo7EH6JIMdoYK3imbV1V8/+yf5yonNlx5K99avg/gljSk2jWU
 bE1Kte9Xd/TDA2BEPNmyynaus9m2BgNVBtcyRkfpYEUHPsalnxwE7OkJLyWBPA0RgD
 5MAlwTBDgpIDcM8DvNaFpIYqsp1ZiILdZKYaLNYq9t7ztGOFZifG3RSeeZNd/bxxOJ
 NLNw0AubbzKxxUmHhZoyw4II6iUcK2+Wch4IjsicvLVe9cijkEV8UcCw7Ov0NhfbDi
 ZtRJefVRfhe2b9Fh4YJ+r0HT12ZFolbqs+WfSfvoIIm0R1xlavZLXXjezqzFD7k8ad
 3bwWgZGroJZhw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:29:02 +0100
Message-Id: <DMMLRD778LTH.89GHGWLB950B@kernel.org>
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
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
Subject: Re: [PATCH v5 5/9] rust: pci: drop driver data before remove returns
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-6-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-6-xinmengs@nvidia.com>
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

On Fri Oct 30, 2026 at 6:12 PM CET, Simon Song wrote:
> From: Zhi Wang <zhiw@nvidia.com>
>
> Drop PCI private data before the remove callback returns, so its
> destructors run within PCI core's removal context.
>
> Call unbind while private data remains installed, then take and release
> the data. Taking it clears drvdata, so post_unbind does not release it
> again. All borrows must end before the data is removed.

This should explain the reason this is needed:

VF drivers will store a vfio::pci::Registration, which calls
vfio_pci_core_register_device() when created and
vfio_pci_core_unregister_device() when destroyed.

Now, vfio_pci_core_unregister_device() expects to be called from PCI's bus
remove() callback and hence can't be deferred beyond remove() (which also m=
akes
it incompatible with devres, i.e a devm_vfio_pci_core_register_device() hel=
per
wouldn't work either).

> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>
> ---
>  rust/kernel/device.rs | 4 ++--
>  rust/kernel/pci.rs    | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2291d85b684..1f6bb58396e 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -243,8 +243,8 @@ impl<Ctx: InternalBoundContext> Device<Ctx> {
>      ///
>      /// # Safety
>      ///
> -    /// - Must only be called after a preceding call to [`Device::set_dr=
vdata`] and before the
> -    ///   device is fully unbound.
> +    /// - The data stored by [`Device::set_drvdata`] must still be insta=
lled and remain valid
> +    ///   for the returned borrow.

This is what the original comment should have expressed better regardless o=
f
this change. Can you please make this a separate commit?

>      /// - The type `T` must match the type of the `ForeignOwnable` previ=
ously stored by
>      ///   [`Device::set_drvdata`].
>      pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 9e1d02588af..8092f56ee2b 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -150,6 +150,12 @@ extern "C" fn remove_callback(pdev: *mut bindings::p=
ci_dev) {
>          let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> =20
>          T::unbind(pdev, data);
> +
> +        // SAFETY: The driver's unbind callback has returned, and no cal=
lbacks retain a borrow.
> +        let data =3D unsafe { pdev.as_ref().drvdata_obtain::<T::Data<'_>=
>() };
> +
> +        // Drop private data before returning to PCI core, while its rem=
oval context is valid.

Please add a brief note similar to the above rationale, as I consider this =
a
workaround (or special case) for VFIO-PCI.

In general, objects stored in the driver's bus device private data should *=
not*
make assumptions about implementation details of the underlying bus and
therefore require to be dropped from the underlying bus's remove() callback=
.

Any point between after the driver's remove() callback and before
devres_release_all() in device_unbind_cleanup() is perfectly sufficient.

> +        drop(data);
>      }
>  }
> =20
> --=20
> 2.43.7

