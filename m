Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF2606A330
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuF9HOBs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA56B10F5C7;
	Tue, 10 Nov 2026 00:23:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF4010F5C7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:23:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D5A8C61142;
 Tue, 10 Nov 2026 00:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8191F008A1;
 Tue, 10 Nov 2026 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794270199;
 bh=sKvriVSDBbGJQaP6slnuzJbWvo0ZE+7oinAMAyjKJKQ=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=LuF9HOBs/K6Dwf+7wPbZDpRcyFwILy2slNg/nG69qEjrab0yd/nBL3bMMfWAll7RT
 /PDliEYnMjlbiI/3C9DKbL/VU/1/CxwdwwUobWAP62N3sS8xc/uwhw2BgyTsQMqVIr
 SuRzYHlaAq7hPlqIqjjud5+9/1/1+puzsBOxkdtXV/dgXixC0dqZ7p1k78iVRKmYpy
 LYJa6hk9uMC/wEevhQe7M4dBAB8T0gpd1FVpqMZYo0OMhWe65cXuFoe41ODTumdO0o
 +qMZdzY7Cx/JnncSJaB/L7CFS1BDEH7wOD9ZXFy07tJL4hB5k0d8a9JAzdl3d59C6d
 HAJbE32sI+MaA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 01:23:10 +0100
Message-Id: <DMR3P6C8PXIG.3DU0W7JE95ZL6@kernel.org>
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
Subject: Re: [PATCH v2 08/12] rust: pci: add runtime PM callbacks
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-9-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-9-xinmengs@nvidia.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 23, 2026 at 5:40 PM CEST, Simon Song wrote:
> +    /// Prepare for runtime suspend, without holding the PCI device lock=
.
> +    #[cfg(CONFIG_PM)]
> +    fn runtime_suspend<'bound>(
> +        dev: &Device<device::Bound>,
> +        this: Pin<&Self::Data<'bound>>,
> +    ) -> Result
> +    where
> +        for<'a> Self::Data<'a>: Sync,
> +    {
> +        let _ =3D (dev, this);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Finish runtime resume, without holding the PCI device lock.
> +    #[cfg(CONFIG_PM)]
> +    fn runtime_resume<'bound>(dev: &Device<device::Bound>, this: Pin<&Se=
lf::Data<'bound>>) -> Result
> +    where
> +        for<'a> Self::Data<'a>: Sync,
> +    {
> +        let _ =3D (dev, this);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Runtime PM callbacks, if any. Construct with [`PmOps::new`].
> +    #[cfg(CONFIG_PM)]
> +    const PM_OPS: Option<PmOps<Self>> =3D None;

As mentioned in my reply to patch 6, please use the generic runtime PM code=
.
