Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4560C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C867310E4E4;
	Fri, 28 Aug 2026 23:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nanonej.com header.i=@nanonej.com header.b="ZOemhih4";
	dkim-atps=neutral
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1230610E4E4
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 23:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nanonej.com;
 s=protonmail2; t=1787959825; x=1788219025;
 bh=oE9jj8ORkL3TaBiWH/0hAgJbMPyHDLr/XwfoSplHfPk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ZOemhih4SYZBh4UZ2HPPCu03I+SDAuIl+mR10e+6WEtpcoHIRn1qKe+eyGspenP2L
 ElmTNUJ77vuhGmXRd8udszch35ZLElH4q5mS5hSsUgPX7XUe2ng85M7JSyNicKSkCE
 c07tognmQl3Hgj6HJ8I+dI2hACcmKrG2aNgb+zT2aYGcS67VEmGhUTcWZhE3Dvdl7k
 z/VzrQvC58Yy0IbE6z9I0cksdV617KK5ZN64m4WYpAoMmCKXxKtFpL1H475Hl/ahdy
 roKKTI6Mf+8tuEN+geP8LyuZIKAACgohObp0PqVWhWWYYnjScA2apmdbgN1UvJWPeJ
 MtSJMfrgesVkg==
Date: Fri, 28 Aug 2026 23:30:18 +0000
To: Alexandre Courbot <acourbot@nvidia.com>
From: Nanonej Dev <dev@nanonej.com>
Cc: Antonin Malzieu Ridolfi via B4 Relay <devnull+dev.nanonej.com@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/4] gpu: nova-core: Extract PFALCON register
Message-ID: <kIdb8vQDIzXcbzWMhRY98VQbxMOEgAco-4AUdcK8u3YM1WP8XCjdrqTEGfj3PKMcahDDiizBwLFH6JwMlcUxuIkjsacGqNd7W8YJKeRqmFA=@nanonej.com>
In-Reply-To: <DL06EAP0GF04.2X3P68IPD0Y7X@nvidia.com>
References: <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-0-38351df09084@nanonej.com>
 <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-4-38351df09084@nanonej.com>
 <DL06EAP0GF04.2X3P68IPD0Y7X@nvidia.com>
Feedback-ID: 32181229:user:proton
X-Pm-Message-ID: b3d92543a22933b99e1d613efdf247cfeccd4fed
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------f6c264b48290fb238571f9b6d8a8d3cf3fe281cedf61683b610eb539231980ab";
 charset=utf-8
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------f6c264b48290fb238571f9b6d8a8d3cf3fe281cedf61683b610eb539231980ab
Content-Type: multipart/mixed;boundary=---------------------c60b3c144f71b4d5b4f311311dabe064

-----------------------c60b3c144f71b4d5b4f311311dabe064
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Friday, August 28th, 2026 at 03:12, Alexandre Courbot <acourbot@nvidia.=
com> wrote:

> On Wed Aug 26, 2026 at 8:44 AM JST, Antonin Malzieu Ridolfi via B4 Relay=
 wrote:
> <...>
> > +    // Configure DMA index for the bootloader to fetch the FWSEC firm=
ware from system memory.
> > +    pub(crate) fn set_fbif_transcfg_regs_at(&self, ctx_dma: u32) -> R=
esult {
> > +        self.bar.update(
> > +            regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>()
> > +                .try_at(usize::from_safe_cast(ctx_dma))
> > +                .ok_or(EINVAL)?,
> > +            |v| {
> > +                v.with_target(FalconFbifTarget::CoherentSysmem)
> > +                    .with_mem_type(FalconFbifMemType::Physical)
> > +            },
> > +        );
> > +        Ok(())
> > +    }
>
> Having this will be nice in that it will also enable us to keep
> `pfalcon` private in [1].
>
> [1] https://lore.kernel.org/all/DL068LFDXPM1.7A1482C1UJF@nvidia.com/

Happy to read that!

> But I'd like the method to look at bit less
> ad-hoc and more confined. So would you:
>
> - Move it to `falcon/gsp.rs` and implement it only to `Falcon<Gsp>`, as
>   that's the only case where we need it so far,
> - Make `ctx_dma` a `usize` (it's the caller's problem to provide the
>   correct type),
> - Add the `FalconFbifTarget` and `FalconFbifMemType` as arguments of the
>   method,
> - Maybe rename it to `set_fbif_transcfg`, because the fact we touch
>   registers is an abstraction detail.
>
> As a side-note, the series is going to clash heavily with Gary's, and
> will need to be rebased on top of it after Gary's series is merged
> (which as far as I'm concerned should be the next version).

Thanks for the review I'll refacto on a v2 like that then and wait for
Gary's series to rebase and send it.

> Apologies
> for the inconvenience, but thankfully this should be mostly mechanical.

No problem that's part of SDLC, so
it's expected to happen from time to time :D
-----------------------c60b3c144f71b4d5b4f311311dabe064--

--------f6c264b48290fb238571f9b6d8a8d3cf3fe281cedf61683b610eb539231980ab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqSGfIJEFKmzSsu6sDwRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfGCWgi60DGAWo3WxSJhe2VsaHjx6b3hGS8hnCQ
8LsyjxYhBI+99gDJjAW7MoHJ0VKmzSsu6sDwAADucQD+KyehPT+fWPqy7hNP
3x2w9UcCcU9l1AnQWXAB88YWwdQBANQoz6LKjUPfOUY4CX8fZjLlCvhpArOb
9DwP9hscS/AP
=uzpr
-----END PGP SIGNATURE-----


--------f6c264b48290fb238571f9b6d8a8d3cf3fe281cedf61683b610eb539231980ab--

