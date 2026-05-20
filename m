Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9704FCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2AB810E224;
	Wed, 20 May 2026 10:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JixfUDNQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 906FE10E224
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:55:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46421416F0;
 Wed, 20 May 2026 10:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F031F00893;
 Wed, 20 May 2026 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779274546;
 bh=BH/ZeiiMJHVcYtkkFaqQ7tq3WQRwma5rKgra7kq7jcU=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=JixfUDNQCOhWwN3XTzbdXz/kX13AdJ5UXDldA0Fa0SH7EdeDdcfroHhX5hZCCvvpM
 y9x+O1csq6Qq0MLKrrH/gmod2bd17A4cQfrvmqlkojbZidDWrzq0omFNVvqQ1ADOGt
 vrsxAALMcLsnoznq2c2KEmzbHwt5Cti7ZCjXeaRapPA/7UluRx2GOPKBVg7jB9c55d
 7Al4/qu+Sx887Z7JJ28NQ1UfV5zOlsS3QFidsvf0d5ZMa517BQAB28rDYSV8idgLeA
 O0uKgB2mXo/4Nl8n2BJfEg/WOvgqlVUNi0n7tAyHW4N49Ekfjd7w3DSVUdN4HrXUWx
 m7N2WT5e8g3jQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 12:55:40 +0200
Message-Id: <DING6NMJ97JA.5HC3ONKUPMW5@kernel.org>
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>,
 <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <daniel.almeida@collabora.com>, <acourbot@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <lyude@redhat.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <driver-core@lists.linux.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Boris Brezillon" <boris.brezillon@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/6] rust: drm: Higher-Ranked Lifetime private data
References: <20260506221027.858481-1-dakr@kernel.org>
 <DICCEKZ3HU84.34ES3SW3D1FNI@kernel.org> <agYbppHWXk_hW99M@um790>
 <DIIMVPTLV3O5.3Q3DHU66WQZUA@kernel.org> <20260519205947.3c9d99b3@fedora>
 <DIMWGLNJ922I.3PCET9O1J83TS@kernel.org> <20260520083813.7addec83@fedora>
In-Reply-To: <20260520083813.7addec83@fedora>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed May 20, 2026 at 8:38 AM CEST, Boris Brezillon wrote:
> So, GEM allocation and GPUVM are required are required early on, and
> both want a drm::Device of some sort (Unregistered or Registered). So
> the question is, are you happy with having [1] applied before/after
> your patchset to address this chicken-and-egg issue I mentioned,

Yes, this is exactly what I had in mind for all of my replies, but I think =
I
only implied my key point rather than making it explicit, so let me do that=
 now.

What I'm saying is that we now have all DRM ioctls behind the SRCU guard, w=
hich
means that the drm::Registration data is always available from DRM ioctls.

Now, with this precondition, the real question is whether there are any
resources left that should be bound to the lifetime of the DRM device itsel=
f,
which I don't think is the case.

After device unbind nothing is able to call back into the driver anymore, s=
o
there is no reason to keep the corresponding data alive within the driver's
private data.

There may be resources that are kept alive through a separate reference cou=
nt
while userspace still has open file descriptors, but they are separate refe=
rence
counts and should be independent from the driver's private data.

IWO, the fact that we guard the ioctls makes the whole class of problems go=
 away
that we inherit from having to keep the driver's private data alive until a=
fter
remvoe() -- the DRM device private data becomes obsolete and we should prob=
ably
evene remove it.

Instead, we should use the drm::Registration private data for everything.

With this, your chicken-and-egg issue is already solved; the DRM device is
available, you can populate all the resources you need (GEM, GPUVM, etc.) a=
nd
then pass it into drm::Registration::new().

In terms of making any of the resources you store in the drm::Registration =
data
available in the bus device private data, it becomes the same pattern as fo=
r
everything else, i.e. you need shared ownership.

So, let's say you need IoMem<'bound> in both the drm::Registration data and=
 in
the bus device private data, then you currently need Arc<IoMem<'bound>> in =
both
of them, which is fine, but I think we can do better.

Eventually, once we have landed the series I currently have in flight and o=
nce
Gary finished his self-referencial support in pin-init, I think we can even
avoid the reference count. Here is an example.

	struct TyrPlatformDriverData<'bound> {
	    _device: ARef<TyrDrmDevice>,
	    _reg: drm::Registration<'bound, TyrDrmData<'_>>,
	    iomem: IoMem<'bound>,
	}

	struct TyrDrmData<'bound> {
	    iomem: &'bound IoMem<'bound>,
	}

	fn probe() -> ... {
	    try_pin_init!(TyrPlatformDriverData {
	        _device: ...,
		iomem <- ...,
		_reg <- drm::Registration::new(..., TyrDrmData { iomem: &iomem }),
	    })
	}

I don't know how the pin-init self-referencial stuff will exactly turn out,=
 but
this is pretty much what I hope we can evolve this into.

(And sorry again, now that I spelled this all out, having that left implici=
t in
my first reply was obviously unreasonable. :)

> or are you proposing something else (Option<Subcomponent> so that we star=
t
> with all sub-components set to None and progressively populate those, whi=
ch I
> remember Daniel was strongly opposed to)?

No, I am strongly opposed to do that (as well).
