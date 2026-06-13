Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B02BCD98DC
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7670810E0D0;
	Sun, 14 Jun 2026 15:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nanonej.com header.i=@nanonej.com header.b="MmFblsd8";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD32A10EDAE
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nanonej.com;
 s=protonmail2; t=1781360492; x=1781619692;
 bh=RBgYG+/wnG88Qki6yof2ao7k/abeZH3EX/1zB6gLt1w=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MmFblsd8Fhq4cvA1F2FFrqULM+iffMGVAXLuNFPduYHNALRk5AExzYKvKrmFjj5P6
 tldKEYac8Ziw+87G1mg92K8O62hiVzjOZMet3tD3NgjM40aw2Xv04JIaKAf+jYVhjL
 rVirarYwfIwCHPxi1DOrXtAyXnSRPbla+IROBIuGATVvAzCIpT1Bu7oj1ZMyIwg/Y6
 k18xLZJ/IQ1Q6qeF4aXh4EyLal9C+65xBBRUmUK1a76+vif5NXWOwOVtsQxBHRP9Fi
 KdLfxw+yosltTqh/MdH1UHPukBCXXhehR2Giapxh2VWBWR87tHXsrwzRCWx41a9lo1
 oE3HX5WcpYVCg==
Date: Sat, 13 Jun 2026 14:21:27 +0000
To: Alexandre Courbot <acourbot@nvidia.com>,
 "dakr@kernel.org" <dakr@kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "daniel.almeida@collabora.com" <daniel.almeida@collabora.com>
From: Nanonej Dev <dev@nanonej.com>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: Move gsp register definition into
 gsp module
Message-ID: <JhjbPqUuPM-wFYwy6aUe3Qk7-iA1bBxSt3MbEz-XBXjsuLYoTmYib9WIgAxy9J5WtK6GRjPU40mv-W-gSzEuEdeXDMr2yc8UFJyq-hEifqQ=@nanonej.com>
In-Reply-To: <vvjHdIL6_yt_mjEDbQzZ5naOIbjsntZJ6xoeR495GAgkIFE5m2UJyexmYhPCH9e7Nafptn9rgYNLHZhYPiX4G6l4X75A1MVlg4UzCpjUwLY=@nanonej.com>
References: <20260607140949.152575-1-dev@nanonej.com>
 <DJ5EN9YOZOVF.RZ2WJGSB0L6G@nvidia.com>
 <9B2MG9ICH2MOGGwTsi0aCGBlEyEO3p-VTk7iR0wgDgBkAYKEu9GC2mc7eAODT5nilASpnSaPdZZjliM9HcvEY96LscSKHF2iDXDXCESptAA=@nanonej.com>
 <DJ5U53UC0NV3.3L6GGS2OJ64Q4@nvidia.com>
 <vvjHdIL6_yt_mjEDbQzZ5naOIbjsntZJ6xoeR495GAgkIFE5m2UJyexmYhPCH9e7Nafptn9rgYNLHZhYPiX4G6l4X75A1MVlg4UzCpjUwLY=@nanonej.com>
Feedback-ID: 32181229:user:proton
X-Pm-Message-ID: b5c3ea6a76a01264ebacb4a54b8039a7981778a5
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------e458f56171b88a77dbf837a54da80829707ab34efc751019b917beaa10e68645";
 charset=utf-8
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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
--------e458f56171b88a77dbf837a54da80829707ab34efc751019b917beaa10e68645
Content-Type: multipart/mixed;boundary=---------------------56a15ea02298f24b6afb3d610f59601f

-----------------------56a15ea02298f24b6afb3d610f59601f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hey!

Just a quick heads up, to tell you that I spend some more time looking to =
fix this mangled patch issue and, indeed, B4's web endpoint seems to be th=
e best solution if I want to keep using Proton mail for communication.

So thanks a lot for taking time looking for it and suggesting it to solve =
my issue, I'll try it on my next patch.

Take care,

Antonin Malzieu Ridolfi.



On Thursday, June 11th, 2026 at 17:00, Nanonej Dev <dev@nanonej.com> wrote=
:

> > Don't worry, you did nothing wrong.
> >
> > This is just the (rudimentary) process by which we state that we have
> > processed a patch in some way: just reply with the tags carrying our
> > name/email that we want to stick to the patch [1].
> =


> Oh! I must have forgot this part then, my bad, thanks for the info.
> =


> > Normally `git send-email` or `b4` should do the right thing, but after=
 a
> > quick search there seems to be recurring server-side mangling issues
> > with Protonmail, so you might need to use another service to send
> > patches. B4's web endpoint might be an option [3].
> >
> > [3] https://b4.docs.kernel.org/en/latest/contributor/send.html
> =


> Oh, thanks! I didn't know about b4 service. I'm gonna check that then!
> =


> On Thursday, June 11th, 2026 at 03:40, Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
> =


> > On Wed Jun 10, 2026 at 11:57 PM JST, Nanonej Dev wrote:
> > > Oh! Didn't think to add this extra tag since your review, sorry!
> > >
> > > Can we add it now? Should I do a V3 to add it? Or not that much of a=
 big deal this time, but should think about it for the next time?
> >
> > Don't worry, you did nothing wrong.
> >
> > This is just the (rudimentary) process by which we state that we have
> > processed a patch in some way: just reply with the tags carrying our
> > name/email that we want to stick to the patch [1]. In this case, I've
> > reviewed it, so I signaled that by giving my `Reviewed-by`.
> >
> > Since I hadn't given it by the time you sent this patch, there was no
> > way for you to add it.
> >
> > The common practice is to collect the tags you received on vN and carr=
y
> > them onto vN+1 (unless the patch has significantly changed), but in th=
is
> > case this wasn't necessary since Danilo applied the patch and added th=
e
> > tags [2].
> >
> > All this to say that this was a perfectly normal kernel patch review a=
nd
> > there was nothing more for you to do.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.=
html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> > [2] https://gitlab.freedesktop.org/drm/rust/kernel/-/commit/3e4bac7b8c=
a7688fb3aa9c0bf005a5a4256ad578
> >
> > >
> > > Anyway let me know and thanks for the feedback!
> > >
> > > Also, I check for Proton Mail, as I understand they don't support `f=
ormat=3Dflowed` so except using there "uservoice" service to ask them to i=
mplement  it, I had probably nothing else to do. But I found a git-protonm=
ail service dedicated to use proton mail with git send-email, so maybe it =
will work? I have to try as I don't know the email protocol well enough to=
 understand on which layer the patch get mangled and if this tool can prox=
y around the Proton implementation.
> >
> > Normally `git send-email` or `b4` should do the right thing, but after=
 a
> > quick search there seems to be recurring server-side mangling issues
> > with Protonmail, so you might need to use another service to send
> > patches. B4's web endpoint might be an option [3].
> >
> > [3] https://b4.docs.kernel.org/en/latest/contributor/send.html
> >
-----------------------56a15ea02298f24b6afb3d610f59601f--

--------e458f56171b88a77dbf837a54da80829707ab34efc751019b917beaa10e68645
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmotZ08JEFKmzSsu6sDwRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdz039PfqCAQScVZ0Oc9Apytjx4ThQUkd+Od55K
K7HB3RYhBI+99gDJjAW7MoHJ0VKmzSsu6sDwAABZXgD+Jf/+RjnNxTKd0mLh
MZlrKqiIhtFPkIDh6Iw7d83lWMkA/jvNpl3ffR/1F891Svny3Up+ESKCSaSX
TWGCmBFm33YJ
=3c5V
-----END PGP SIGNATURE-----


--------e458f56171b88a77dbf837a54da80829707ab34efc751019b917beaa10e68645--

