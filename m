Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE81C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A308510E0AC;
	Mon, 21 Sep 2026 15:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nanonej.com header.i=@nanonej.com header.b="AeCL4Ki1";
	dkim-atps=neutral
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D576410E0AC
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nanonej.com;
 s=protonmail3; t=1790003592; x=1790262792;
 bh=IEWMdJz9YAjjdToPx03hIHKOvrYcQfh3pyhTvkyPGLY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=AeCL4Ki176gOLOE0FuZ4scb2t7W8piULV1nmviKUgKnMkdxzOoQB6H91iPYmUNihS
 G/58oYGeX2Y1cwGK1sg8RSYI03LkTI+sCBEbl0KGF3NTiqL9d8VEtE8/2M4nIdF0mg
 HAA0FIzasQcT/I7rJOC/H6pznBQpA0+TmupgltMpuKcux6Eycwf5N0ssqR75FlDPpt
 J5OxEKskiTyN8Gvkz5mXQlEz+NYo6D5ZOw3fv2tT4AqMyWE5N4SsHiy/dvBa9zT8iQ
 jeWwTPFQ1yuo3z2VA4R2CvnbWBUr/KqgEwOy8sUn/5J47plahik9PwKhtO4hTBdStH
 pBl3VJelGL3IQ==
Date: Mon, 21 Sep 2026 15:13:07 +0000
To: Alexandre Courbot <acourbot@nvidia.com>
From: Nanonej Dev <dev@nanonej.com>
Cc: Antonin Malzieu Ridolfi via B4 Relay <devnull+dev.nanonej.com@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/4] gpu: nova-core: Extract PFALCON register
Message-ID: <2jQVZV73cgrJOjnRVQ-gT1k4iBhKks2rB7H2doPH0l4zkbumXvnyoLEIFmATkIhpfwxRBwOFClJrf0f_iM7-mHyvYFbgyXt25Aqqp50vm18=@nanonej.com>
In-Reply-To: <kIdb8vQDIzXcbzWMhRY98VQbxMOEgAco-4AUdcK8u3YM1WP8XCjdrqTEGfj3PKMcahDDiizBwLFH6JwMlcUxuIkjsacGqNd7W8YJKeRqmFA=@nanonej.com>
References: <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-0-38351df09084@nanonej.com>
 <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-4-38351df09084@nanonej.com>
 <DL06EAP0GF04.2X3P68IPD0Y7X@nvidia.com>
 <kIdb8vQDIzXcbzWMhRY98VQbxMOEgAco-4AUdcK8u3YM1WP8XCjdrqTEGfj3PKMcahDDiizBwLFH6JwMlcUxuIkjsacGqNd7W8YJKeRqmFA=@nanonej.com>
Feedback-ID: 32181229:user:proton
X-Pm-Message-ID: 31651d218434a189031e1a0140893ceba17db1bf
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------7b53ba318633761f155271ac5e47d80a75b0cb03fcc7ffeae3511ada91d502b2";
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
--------7b53ba318633761f155271ac5e47d80a75b0cb03fcc7ffeae3511ada91d502b2
Content-Type: multipart/mixed;boundary=---------------------fb4e9f4b0b317602eaf5f3b1553d6975

-----------------------fb4e9f4b0b317602eaf5f3b1553d6975
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8


> > I'd like the method to look at bit less
> > ad-hoc and more confined. So would you:
> >
> > - Move it to `falcon/gsp.rs` and implement it only to `Falcon<Gsp>`, a=
s
> >   that's the only case where we need it so far,
> > - Make `ctx_dma` a `usize` (it's the caller's problem to provide the
> >   correct type),
> > - Add the `FalconFbifTarget` and `FalconFbifMemType` as arguments of t=
he
> >   method,
> > - Maybe rename it to `set_fbif_transcfg`, because the fact we touch
> >   registers is an abstraction detail.
> >
> > As a side-note, the series is going to clash heavily with Gary's, and
> > will need to be rebased on top of it after Gary's series is merged
> > (which as far as I'm concerned should be the next version).
> =


> Thanks for the review I'll refacto on a v2 like that then and wait for
> Gary's series to rebase and send it.

I see the patch have been merged [1], so I'll rebase and make a refacto fo=
r a v2

[1] https://gitlab.freedesktop.org/drm/rust/kernel/-/commit/ea79a501243155=
89da68cbcaf518455a142d6d23
-----------------------fb4e9f4b0b317602eaf5f3b1553d6975--

--------7b53ba318633761f155271ac5e47d80a75b0cb03fcc7ffeae3511ada91d502b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqxSWgJEFKmzSsu6sDwRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeQvgvyV3yUJoCsLgAeC4wVDMe8MWuRIVetwT3P
x/inKhYhBI+99gDJjAW7MoHJ0VKmzSsu6sDwAACeaQD8CKS7AOQBshpxYI7B
0JUvIAKddHMLcTccNUgI/3ohueoA/i5KATberrMvAS5ERECh+sy1VHAtGQAS
JiTYHBI/w/cL
=fE1V
-----END PGP SIGNATURE-----


--------7b53ba318633761f155271ac5e47d80a75b0cb03fcc7ffeae3511ada91d502b2--

