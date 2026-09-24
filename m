Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FBDC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6687110E387;
	Thu, 24 Sep 2026 17:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NQIE+sBD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353AE10E1BD;
 Thu, 24 Sep 2026 17:16:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B9C3601E4;
 Thu, 24 Sep 2026 17:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2722D1F000FF;
 Thu, 24 Sep 2026 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790270166;
 bh=l7EPunzNere6TJZFXapnJ1i2B/w1f51shg7LoArRGlc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NQIE+sBDeMt/YoeadQk9mIsTsTckafsht6vi76MdnUeacqf1sGvrUbEGWUHt7jx6d
 jMd5uu4Eb5SqJdlmCTQKm5dLNqhCgGmoiH4yzUAO7gxIcJ1vcm0EVQAfYxfOyf9ijE
 RDc7lKIMaleckJL1/ULkCl9FZ0hpZcHRvLfMz4NuHUC9LjNnlbGk3TTvIBQc/9sFIb
 aq82QdDAkd4i2wsqkFGKa5XETnYsuGzGHFXWs9/NvAXh6WpNSxIb8KrWoIY5Wa2QAQ
 AaRKHJzuWrc/8zmQei4wBS8y1ibWr+6kE6QGuYhysV4nxxkTOLJOH6dUgIkVX0MrCB
 I4v2Owp5nXrIw==
Date: Thu, 24 Sep 2026 18:16:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <9f1008c5-5529-4916-acb7-81a75593aaf2@sirena.org.uk>
References: <arPTRF4qS6o1Q3vD@sirena.co.uk>
 <CADnq5_NUH1MBU15Vs287by4P37YV+6F1Q3J1e4Q4KuOvPwK9Fw@mail.gmail.com>
 <arPhsTaiqXPgCqAU@sirena.co.uk>
 <CADnq5_OJ=kP+0=iXbpcjsWbTx8=sNfov0wLSW53qLcFU0fmVVg@mail.gmail.com>
 <4ddbd29e-3524-4f4c-b6d7-1e2e677641b5@sirena.org.uk>
 <CADnq5_OPPnSs9Bv8LxRp104Cejf3H3JFkBE4XSfiTYgkdmjbHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="22uyFBtZ7Xdfmy+p"
Content-Disposition: inline
In-Reply-To: <CADnq5_OPPnSs9Bv8LxRp104Cejf3H3JFkBE4XSfiTYgkdmjbHg@mail.gmail.com>
X-Cookie: Oh, so there you are!
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


--22uyFBtZ7Xdfmy+p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 01:01:15PM -0400, Alex Deucher wrote:
> On Thu, Sep 24, 2026 at 12:54=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:

> > I'm still seeing at least:

> Does this patch fix it?
> https://patchwork.freedesktop.org/patch/755883/?series=3D174861&rev=3D1

I don't have the tree any more since I'm further into -next but I'd
expect so, thanks.

--22uyFBtZ7Xdfmy+p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1WtAACgkQJNaLcl1U
h9C12gf/aQ67+bp5y1NEDx5tDqCCRsjTxQOkH7d95rMPicLmNQihy16Y67eiJkPK
I5Z6lL99GkYECImspYxhbQxcddeH58gzVhNCBDG++u2dJ+Iq3MNZfFlberCIn0HF
RXfbsVwYZmb6fhhehnyqz/koznMQn2ZN2IFzYd7bF+EcnVC94C9JnH0Mnyq9zhtT
05/Yvu5FYiD2Aj26ePQAe8XsDVYMXq06Xa8iXbomfn0JD3DIp1TsFdo+z780+d1o
9BXKE2BSS3KI+5socMhxFhmNgH46XH+EPu/XH2N3Mwx67ojaVgp/0HMmdFtSY8CQ
mJFa1191yu51i9KOq7Yf+H83LNLXbQ==
=h98E
-----END PGP SIGNATURE-----

--22uyFBtZ7Xdfmy+p--
