Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7260CC4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC04910E783;
	Mon, 20 Jul 2026 07:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="US4t7lxp";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C20B10E00A
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 10:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1784457626; x=1784716826;
 bh=zUxHqzZSBc5RXM72ArQovGGBnJ3WnpK1SD3so7JOaw8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=US4t7lxpZvtGKR4YcO1W14Rg17A91+J1/CaVf7ScGSg+RfMv3/OetOjrlYwd8GyXR
 TVOo3HcE6jgvsId8OR7bzmGHfF434qj54rMwyWjeh0jnc+M2gzYnTcOc/AcHBH6xkk
 DQoYSLMlvLUBVeKoH5f+yfQZf5FSeWBff7baQN4eD/z/6RTm7BW/6pmT3RRIyleyF5
 cRH64Ys282V6dLpx5Y2I8ruKW8FpU/llqT8v9usAhB2m3IHJspuMqJO01i1F7KNBmZ
 /xkkWJLOalMDaOnLleoxJsiZWkurUoFrXGsKcO+x/smAlbIXU/MYeawyrYeXnK6JZ5
 jJfVuowTUp+Mg==
Date: Sun, 19 Jul 2026 10:40:19 +0000
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
From: Lorenzo Delgado <lnsdev@proton.me>
Cc: Lorenzo Delgado <lnsdev@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, John Hubbard <jhubbard@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev
Subject: Re: [PATCH] rust: io: convert ResourceSize into a transparent newtype
Message-ID: <20260719104012.364283-1-lnsdev@proton.me>
In-Reply-To: <DK0BPAHR8IS3.2KLSLH7K448RJ@kernel.org>
References: <20260712113602.389060-1-lnsdev@proton.me>
 <DK0BPAHR8IS3.2KLSLH7K448RJ@kernel.org>
Feedback-ID: 53083996:user:proton
X-Pm-Message-ID: 511a3e7a8a9ded91417d401cf07b2a6e0a605640
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

On Thu Jul 16, 2026 at 11:45 PM CEST, Danilo Krummrich wrote:
> On Sun Jul 12, 2026 at 1:36 PM CEST, Lorenzo Delgado wrote:
> > -        let num_pages =3D usize::from_safe_cast(sg_entry.dma_len()).di=
v_ceil(GSP_PAGE_SIZE);
> > +        let num_pages =3D usize::try_from(sg_entry.dma_len())?.div_cei=
l(GSP_PAGE_SIZE);
>
> I think this is worse, as the conversion becomes fallible.

Agreed, that's a regression for nova-core, where the Kconfig guarantees
the value fits and the conversion should stay infallible. I'll drop the
try_from() there.

> You could implement From<ResourceSize> for u64 and then keep using
> usize::from_safe_cast() in nova-core.

I tried that, but it doesn't build. ResourceSize wraps resource_size_t,
which is u64 on 64-bit (CONFIG_PHYS_ADDR_T_64BIT), so the impl the patch
already has,

    impl From<ResourceSize> for bindings::resource_size_t

is already From<ResourceSize> for u64 there, and a second one conflicts:

    error[E0119]: conflicting implementations of trait
                  `From<ResourceSize>` for type `u64`

There's a simpler way that stays infallible and adds nothing to io.rs.
ResourceSize already has into_raw() (io/resource.rs uses it at the C
boundaries), so nova-core can do:

    let num_pages =3D
        usize::from_safe_cast(sg_entry.dma_len().into_raw()).div_ceil(GSP_P=
AGE_SIZE);

into_raw() gives back resource_size_t, and from_safe_cast handles that
as u32 or u64 depending on the config, so it stays infallible. I'll use
that in v2 unless you'd prefer something else.

> Alternatively, we could also consider moving the FromSafeCast trait to
> rust/kernel/num.rs and add FromSafeCast<ResourceSize> impls for usize.
> [...]
> However, by making it commonly availble I do see a risk with the
> cfg-gated impls silently breaking the build.

Agreed on the risk. A FromSafeCast<ResourceSize> for usize impl would
have to be cfg-gated like the u64 one, which is the same
silent-breakage-under-randconfig case you mention.

Since into_raw() keeps this patch self-contained, moving FromSafeCast
into the kernel crate is a separate change from the newtype conversion.
It seems worth doing on its own, and I'm happy to send it as its own
series so it gets reviewed as a new core API, but it doesn't need to
block this patch. I'll post v2 with the into_raw() change.

Thanks for the review.

Lorenzo

