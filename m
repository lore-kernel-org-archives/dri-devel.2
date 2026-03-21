Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CC81094489
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 18:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3999A10E0AC;
	Sat, 21 Mar 2026 18:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fnlbHtBB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104D910E0AC
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 18:17:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D55E3443D4;
 Sat, 21 Mar 2026 18:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372EFC19421;
 Sat, 21 Mar 2026 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774117042;
 bh=de0g3TNmF0ppn5KPIWgzPlcksNLGUo9q95G6dJJhB0k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fnlbHtBBsnE6Say1eUoW7xfFddP0G8Sk0SX5Bmg7BqusfGmGyS3uC9tMH57dOh3Qd
 PeHWJ+NbN2LNY2QL4qnsBeYhr3ed6DUm9d2J4IyQ2VyaMmkk6D1zx0Dmhl3XuomLyd
 zGM2sv9vIwW7W/aC5vah8L3UI//+Z6WKnLzyxtmepxKMDJT0j79WML6efTt8nMEUvi
 QKoRLtglmoNRmFlGqw5rtI45ttdXJlxKXWYYvdwdZVrLUDOKt+VeT4ThmoepTu8K6O
 wfFRG11c2tEaElbzZ4+yauZWKgeuoMBlAjtpbpUAONuNriiE/S5HZX7t9wMaJire3P
 A1rUqPkOOdfjA==
Date: Sat, 21 Mar 2026 19:17:19 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>, Stephen Boyd <sboyd@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Michael Turquette <mturquette@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
Message-ID: <20260321-awesome-hot-kingfisher-5d9f55@houat>
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="zbpbbnuxfqdi6lai"
Content-Disposition: inline
In-Reply-To: <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
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


--zbpbbnuxfqdi6lai
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
MIME-Version: 1.0

Hi Danilo,

On Fri, Mar 20, 2026 at 12:43:47PM +0100, Danilo Krummrich wrote:
> Hi Stephen,
>=20
> On Mon Feb 23, 2026 at 11:08 AM CET, Alice Ryhl wrote:
> > The Clk type is thread-safe, so let's mark it as thread-safe in the type
> > system. This lets us get rid of hacks in drivers.
> >
> > For Stephen's clk tree.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Changes in v5:
> > - Rebase on v7.0-rc1.
> > - Pick up Reviewed-by tags.
> > - Link to v4: https://lore.kernel.org/r/20260113-clk-send-sync-v4-0-712=
bc7d94a79@google.com
> >
> > Changes in v4:
> > - Pick up Reviewed-by tags.
> > - Link to v3: https://lore.kernel.org/r/20251218-clk-send-sync-v3-0-e48=
b2e2f1eac@google.com
> >
> > Changes in v3:
> > - Rebase on v6.19-rc1.
> > - Pick up tags.
> > - Add fix for pwm driver as well.
> > - Link to v2: https://lore.kernel.org/r/20251020-clk-send-sync-v2-0-44a=
b533ae084@google.com
> >
> > Changes in v2:
> > - Rebase on v6.18-rc1.
> > - Add patch to tyr driver.
> > - Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1-48d=
023320eb8@google.com
>=20
> Alice has resent this over the past three cycles, but it hasn't been pick=
ed up
> yet. Please let me know if there are any concerns -- otherwise, I plan to=
 take
> it through the drm-rust tree in a few days.

Stephen hasn't really been active lately, but Brian (in Cc) has been
trying to pick up the patches falling through the cracks. It looks like
such a candidate to me.

Maxime

--zbpbbnuxfqdi6lai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCab7gqwAKCRAnX84Zoj2+
djeQAX9KWOn1hNDiILmTf7Ag8DImTKbEsLxP95XBXK5UxCxVezwlFzDaOZb8aVbn
yJJieMgBgNwA6rCeY2pZtFsSy2CRzTTQaBtQEqal7JxaqO5Q2WCKWFvNY6BimLbf
AkXQMYWt3A==
=KXRw
-----END PGP SIGNATURE-----

--zbpbbnuxfqdi6lai--
