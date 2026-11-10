Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E4606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCj5FFRq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF94010E1F6;
	Tue, 10 Nov 2026 00:10:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38D910E1F6
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:10:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A74B432A5;
 Tue, 10 Nov 2026 00:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F9A1F0089F;
 Tue, 10 Nov 2026 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794269425;
 bh=dz2fvkSwnZplQkX1U9pzrU7rFR3GRdiaB6bhtOf/H60=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=fCj5FFRqRM5NX6wqVhMfGWJhXWGI7k4HNPP5SYpZXp6fIJhbYuBhGZKgm1VP/hYUx
 X7pD03O7uixBW0BaNJND7Bid20cISEoxJZKHTeonSfF2sT0j9AeQBu/5YoeeymcnCX
 LSiPs/fChguo2+aRIj3pwETTiHs8H007sRY4/6XgYpJFi5tAKCKADUSjxZFIXquoI6
 C8CTEFVTVb1vZpgDfBIBvwf0R3fS8wUvLVWW7NYCzivSwM+cCoP5TmPssSeFD5zO+O
 ShBEsE7tgGUR0AXBmBb+GQiZMRtQXA1eXAntv/bny6a5v1fR5quH6iyfGteoEmSUxU
 DftRxsHV17FjA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 01:10:16 +0100
Message-Id: <DMR3FALTBPDB.15ASJDTIC5GXS@kernel.org>
Subject: Re: [PATCH v2 06/12] rust: pci: add a bind callback after
 installing driver data
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
 <peter@colberg.org>, <beata.michalska@arm.com>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-7-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-7-xinmengs@nvidia.com>
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

On Fri Oct 23, 2026 at 5:40 PM CEST, Simon Song wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index adc7e92d44e..1951b3c8a5c 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -154,6 +154,13 @@ extern "C" fn probe_callback(
>              let data =3D T::probe(pdev, info);
> =20
>              pdev.as_ref().set_drvdata(data)?;
> +            // SAFETY: `set_drvdata` installed the pinned `T::Data` abov=
e.
> +            let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data=
<'_>>() };
> +            if let Err(error) =3D T::bind(pdev, data) {
> +                // SAFETY: Failed bind leaves no callbacks borrowing the=
 installed data.
> +                drop(unsafe { pdev.as_ref().drvdata_obtain::<T::Data<'_>=
>() });
> +                return Err(error);
> +            }
>              Ok(0)
>          })
>      }
> @@ -416,6 +423,15 @@ fn probe<'bound>(
>          id_info: Option<&'bound Self::IdInfo>,
>      ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
> =20
> +    /// Complete probe after the pinned driver data has been installed.
> +    ///
> +    /// Called with the PCI device lock held. On error, the data is drop=
ped without calling
> +    /// [`Self::unbind`]. Any callbacks started here must be stopped bef=
ore returning an error.
> +    fn bind<'bound>(dev: &Device<device::Core<'_>>, this: Pin<&Self::Dat=
a<'bound>>) -> Result {
> +        let _ =3D (dev, this);
> +        Ok(())
> +    }

No, please don't introduce a new bus callback for the sake of ordering
registrations against each other, it does not scale.

The answer is almost always to use a new registration data container and, w=
here
needed, self-referential pin-init in order to represent ordering dependenci=
es.

Fixed ordering imposed by bus callbacks falls apart with different driver n=
eeds,
whereas separate registration data containers and self-referential pin-init=
 are
flexible and represent data dependencies and lifetimes directly.

IIUC, this comes down to the runtime PM implementation in this series, so p=
lease
base your code on the generic runtime PM work [1] from Beata (Cc) instead.

If you respin this series before Beata respins the runtime PM work, please =
take
my latest feedback on her series into account, since it may affect how this
series integrates with it.

I'd also suggest splitting out the runtime PM support as separate patches a=
t the
end of this series, so we can start landing the rest independently.

[1] https://lore.kernel.org/all/20261026120523.526942-2-beata.michalska@arm=
.com/
