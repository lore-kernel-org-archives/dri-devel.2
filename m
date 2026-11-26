Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13E4606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKPy7iDP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B2911272F;
	Thu, 26 Nov 2026 21:38:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49EC11272F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:38:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D61A61ECE;
 Thu, 26 Nov 2026 21:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534771F000C1;
 Thu, 26 Nov 2026 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795729127;
 bh=le0OILRxgvc/hUwSc0GSpHpYWxUpD6OdgP9vLsaiIbk=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=AKPy7iDPt/3jLSg1ILgmyKSkFOltCY3Ucnzt5Hl7PX6j8e0Lxz+e88gkonwy0iB3w
 oXn8TzcdYJKNy9BhpU5/ZEG8iy1nTE6N6h3QP9Su/m/dNb4gAonlk9zFG9aGx4CEbi
 BUf6VM87VU4wxGkdsUvyztLA4catj3jXsC+AcrLxCg4dt8J8z+fx842cr+azOI7crz
 TzhTc1utDtT25sVqdnZ7jApzTBlIEQXOpQxutWJOgEirKtkzn5EZAa0aN1Qv15FZd9
 +J018XK8m3xzNH/z3bTiSH/0iwihYID8VQ7JVV5zm185giQqttiy9/Hjp25Y1J5+6z
 90VGWeq31swRg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 22:38:37 +0100
Message-Id: <DN5GUG9ZOIR0.1MSRUTV4H8B67@kernel.org>
Subject: Re: [PATCH v5 15/35] gpu: nova-core: mm: add SharedGpuMm
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
 <kjaju@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
To: "Alok Kumar" <alkumar@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261124135937.18583-1-alkumar@nvidia.com>
 <20261124135937.18583-16-alkumar@nvidia.com>
In-Reply-To: <20261124135937.18583-16-alkumar@nvidia.com>
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

On Tue Nov 24, 2026 at 2:59 PM CET, Alok Kumar wrote:
> +/// A [`GpuMm`] shared between several users, serialized by a mutex.
> +#[pin_data]
> +pub(crate) struct SharedGpuMm<'gpu>
> +where
> +    // Hide the mutex's invariant resource lifetime so `SharedGpuMm` rem=
ains covariant.
> +    exists<'res>: 'gpu,
> +{
> +    #[pin]
> +    #[uses('res: invariant)]
> +    inner: Mutex<GpuMm<'res>>,
> +}

I don't think GpuMm should have a global lock; it contains GpuBuddy, Pramin=
 and
Tlb.

The reason some APIs want &mut GpuMm<'a> is that the contained Pramin does =
not
implement mutal exclusion; GpuBuddy and Tlb already have inner locks.

Please also consider, if GpuBuddy, Pramin and Tlb share a common lock, this
would violate DMA fence rules if Pramin and Tlb are used from the fence
signaling critical path.

I just came across this independently from this series and sent out a patch
series [1] for this.

[1] https://lore.kernel.org/nova-gpu/20261126213652.3716162-1-dakr@kernel.o=
rg/
