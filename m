Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6CEC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABB710E28B;
	Fri, 25 Sep 2026 19:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dv7Paa+e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891B510E226;
 Fri, 25 Sep 2026 19:37:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D7AE6022F;
 Fri, 25 Sep 2026 19:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE2D1F000FF;
 Fri, 25 Sep 2026 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790365023;
 bh=ZswR5UWkm1BCz5yg/l3wO12v6Cnrj2+kj6gXYAI0W58=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Dv7Paa+eIvVZGik3JSlnNwxiRxyacR5S5JuDFMqN6Wgc0C/mJfvmzYBgK5pn5Jv8H
 GIF5tGv0XB8dymG4tiNLS0XOuJFkWeSCFcc01zcZkKe9+mgs96zSymDrwO+wkDokw0
 UmQ2eFcFGCksIhLyVIcm+8xZO5ckaE4kU8XNqU+hUka5ICBHUYOvbb3tlRTi5TWpKn
 9iodHSkXWjleXHoUfybbB6zEWmhkNT7zXvtCP8u5n48JeN3pHbmuOCnzs6fYBL3GD2
 8Es+Bhu73aHnbn/ZppLo9ocdwCoWTeFQCyChsAPzZ2ek4eGosclQunZY7cS/xmxfSD
 gacSkmEM7FPjw==
Date: Fri, 25 Sep 2026 20:36:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <47218081-0338-4a3d-bca3-8b0b5a3bda14@sirena.org.uk>
References: <arPTRF4qS6o1Q3vD@sirena.co.uk>
 <CADnq5_NUH1MBU15Vs287by4P37YV+6F1Q3J1e4Q4KuOvPwK9Fw@mail.gmail.com>
 <arPhsTaiqXPgCqAU@sirena.co.uk>
 <CADnq5_OJ=kP+0=iXbpcjsWbTx8=sNfov0wLSW53qLcFU0fmVVg@mail.gmail.com>
 <4ddbd29e-3524-4f4c-b6d7-1e2e677641b5@sirena.org.uk>
 <CADnq5_OPPnSs9Bv8LxRp104Cejf3H3JFkBE4XSfiTYgkdmjbHg@mail.gmail.com>
 <2eaa0128-4cda-4f26-b9de-311add98a1fa@sirena.org.uk>
 <CADnq5_M0uB6uRvQh3jEZGVEFqmU0wp_w=wmsipXqz=Nq5QZwhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s1+vNEBEsb7MYG6e"
Content-Disposition: inline
In-Reply-To: <CADnq5_M0uB6uRvQh3jEZGVEFqmU0wp_w=wmsipXqz=Nq5QZwhg@mail.gmail.com>
X-Cookie: Love America -- or give it back.
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


--s1+vNEBEsb7MYG6e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 03:21:43PM -0400, Alex Deucher wrote:
> On Fri, Sep 25, 2026 at 1:03=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > It seems everything built fine today, I'll try dropping the workaround
> > commits for Monday.  The drm and drm-misc trees are still failing due to
> > the original issue.  Thanks for getting things sorted.

> Thanks.  I've sent Dave and Simona a PR with the fixes so as soon as
> that gets merged into drm-next, this should be resolved.

Great.  Someone will still need to prod the drm-misc people once the
merge is taken I guess?

--s1+vNEBEsb7MYG6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq2zVkACgkQJNaLcl1U
h9A2gQf/XCnaD5SCzCDZRF1Y6n8QkFfln/MHlX4+hqg+C2pMWneYdac3rAWXJKHN
Irn0VtA7Z0xViKwudX7huCBrQhNm/9U1pucqXXkVSd4gUhbjGeH6mqCViU2QIm+J
PjW3N816n+Yi5hZR0kuJZ77HLhYVZcI4hTXCYhbWueVVKb+AKx9kwjWFCVhH+5vU
JDZfnBoaapsSCbPogFUWybCd1WNRJJzBu8s1gF57QK+NBb7rVG07DUGDxF+zFbNq
6djRO01iXENsTSRuRsH7mMsqLL1JKQrdIGPAIy2mXEL0qFdPDhvYPEkqHedn5lci
DOlXIiYukKASSAKuy0cE8p6lxxm3rg==
=4JH7
-----END PGP SIGNATURE-----

--s1+vNEBEsb7MYG6e--
