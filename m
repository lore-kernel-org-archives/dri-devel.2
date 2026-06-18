Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B82CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E1710F351;
	Thu, 18 Jun 2026 15:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P+Z/0JkK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6056710F351
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:48:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9C2360008;
 Thu, 18 Jun 2026 15:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDEC1F000E9;
 Thu, 18 Jun 2026 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781797724;
 bh=8n4HL8JKwhJmIYyhxPMrMUQdSZP+magVoUvrNWlahuY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=P+Z/0JkK/8j8bM1+eDmWnagnvJRTInoq5J96N6HgSSbyh2UuQmlr5Tz3iZioEJE8Y
 ykUh8p1bI5CGKVHhaDigS+YxZN2DPbEOAGcsWGEGtogdCOvh0girwEcsmT37YkIGLZ
 4Z5mY4r0Un7PCeXF0xPGj0ByyyNT1DK2d8GwAcxTV3UUFR+bjkhXUMXiyrfwA276Bt
 xvr2OvlRuiwIbWJ4/yaEF7bedojNIGAnaM6FJn6jaOexrmijxFVdu2SSEKQ+MO+w9o
 J0bzuCGOfohPDqL4Czx3oG5ab06ggGF3sFZqqnWDNDzEH4s8LSoGErievhE90KPJsY
 jiZ66Jq9Y/CEg==
Date: Thu, 18 Jun 2026 17:48:42 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH 0/2] Make HDMI state helpers handle odd max bpc requests
Message-ID: <20260618-evasive-devious-cassowary-70a2b6@houat>
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
 <20260609-orthodox-cocky-bull-5ddef8@houat>
 <n8gESqWZSRS1IhbHdJvkLQ@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="nawyvqvn2shi7gai"
Content-Disposition: inline
In-Reply-To: <n8gESqWZSRS1IhbHdJvkLQ@collabora.com>
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


--nawyvqvn2shi7gai
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] Make HDMI state helpers handle odd max bpc requests
MIME-Version: 1.0

On Tue, Jun 09, 2026 at 05:46:20PM +0200, Nicolas Frattaroli wrote:
> On Tuesday, 9 June 2026 14:51:12 Central European Summer Time Maxime Ripa=
rd wrote:
> > Hi,
> >=20
> > On Mon, Jun 08, 2026 at 01:19:06PM +0200, Nicolas Frattaroli wrote:
> > > With the "max bpc" KMS connector property, userspace can arbitrarily
> > > restrict the upper end of the bits-per-component range. This is fine =
and
> > > good, except the HDMI state helpers never considered that max_bpc cou=
ld
> > > be influenced by a userspace setting, so assumed it'll always be an e=
ven
> > > value from the HDMI standards.
> > >=20
> > > This, unfortunately, is not the world we live in anymore. Patch 1
> > > corrects sink_supports_format_bpc to return false on BPCs outside of
> > > what HDMI allows. Patch 2 then corrects handling of odd-numbered max
> > > bpcs by rounding the loop start value down to an even number instead.=
 It
> > > also adds a KUnit test to make sure nobody breaks this again in the
> > > future.
> > >=20
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >=20
> > Do you have a bit more details on the world you live in? :)
> >=20
> > In particular, why would erroring out on setting an odd value in
> > atomic_set_property not work?
>=20
> It would work, but it'd be an inferior solution IMHO. (If the intent
> was to point out this is already done then I can't find the code where
> such a check is performed.)
>=20
> It's perfectly fine, albeit weird, for userspace to say it wants a max
> bpc of 11. That HDMI does not support 11 bpc isn't really something the
> upper end of the range should concern itself with, much like we don't
> error out on a max bpc of 14 either even though HDMI does not support
> bit depths of 14 bits.

Yeah, this makes total sense indeed.

> By counting from the next even number, we don't leak our implementation's
> choice of trying every other bit depth through the uAPI with an overly
> restrictive constraint being placed. In an alternate universe, mirror
> world Maxime may have decided to i-- in that for loop instead just in
> case, and the second patch wouldn't be needed.

Damn current world Maxime :D

Thanks for the explanation, the series looks mostly fine and I had two
nits.

Maxime

--nawyvqvn2shi7gai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajQTWQAKCRAnX84Zoj2+
dtnMAXoDM65XFye2u/uB3v/ttHxIq8Mo5Q622H77WbWYRTguvfOGQKNUcmTDLlFM
wr4ldusBfiIc+J8jiaFbr06gVnmk79bQVfr0N4daYgHKhNVDgk9lxbysA/Qw5Ql5
PbShmX6wGA==
=VBfy
-----END PGP SIGNATURE-----

--nawyvqvn2shi7gai--
