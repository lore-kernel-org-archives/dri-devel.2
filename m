Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF441098784
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B3A10EAF2;
	Fri, 20 Mar 2026 13:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lbqCm3po";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8895110EAF1;
 Fri, 20 Mar 2026 13:08:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FCAE40A16;
 Fri, 20 Mar 2026 13:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DAEC2BCAF;
 Fri, 20 Mar 2026 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774012123;
 bh=6a4U7/Uyv/5B/nQ4t9QHBSjqBn31r6wgaK8C1DzwsBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lbqCm3poynDd2cxlXh7rYljYbu6R1hEw8v6PANP+szmf3bPUafnU28AUwvBz/lGhM
 /G5yPGUJ951pF9DH4nHA7ibvvxoxY17lR1L4KR8leGs+29AIUZgEAKtSBXii48yyHe
 Gr420LV3a5y7GPw28S2LO/Er/wUuRQ3+sayjiNZJRgKkHIgFH4oYwktvwlZcPmes6u
 1Vf+n+KcWbVuml7ijtIzTJxkHM/hcstSI+vhxMya6GsSKtKKnktxgLRyHp6qcP1tbZ
 YbHazhM7dXG5nOkHlc5FhnTktZAzuDAAmVXKf7BfdX+Q/Yiu0gE9Pn71WM2s/c6wl0
 j6X5sLFMW7k+g==
Date: Fri, 20 Mar 2026 14:08:40 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Melissa Wen <mwen@igalia.com>
Cc: maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, contact@emersion.fr,
 sebastian.wick@redhat.com, 
 harry.wentland@amd.com, daniels@collabora.com, Alex Hung <alex.hung@amd.com>, 
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/drm_atomic: duplicate colorop states if plane
 color pipeline in use
Message-ID: <20260320-mighty-rousing-toucanet-66fcfd@houat>
References: <20260318163629.300627-1-mwen@igalia.com>
 <20260319-nocturnal-mighty-chupacabra-87cbd0@houat>
 <f993cd33-cb39-4fb4-9dbb-42abd22c3112@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="efjkobqgbpnwfhqr"
Content-Disposition: inline
In-Reply-To: <f993cd33-cb39-4fb4-9dbb-42abd22c3112@igalia.com>
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


--efjkobqgbpnwfhqr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/drm_atomic: duplicate colorop states if plane
 color pipeline in use
MIME-Version: 1.0

Hi Melissa,

Thanks for your answer

On Fri, Mar 20, 2026 at 09:47:47AM -0300, Melissa Wen wrote:
> On 19/03/2026 07:00, Maxime Ripard wrote:
> > Hi Melissa,
> >=20
> > On Wed, Mar 18, 2026 at 01:27:11PM -0300, Melissa Wen wrote:
> > > For suspend/resume to work correctly, do for colorop state the same we
> > > do for plane/crtc/connector states: duplicate the state of colorops i=
n a
> > > color pipeline if it's in use by a given plane when suspending and
> > > restore cached colorop states when resuming.
> > >=20
> > > Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
> > > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > > Reviewed-by: Alex Hung <alex.hung@amd.com>
> > > Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> > > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > Only slightly related to this patch itself, so this discussion must not
> > block merging this patch.
> >=20
> > I've been looking at revamping the state allocation / reset recently and
> > came across the colorop. It's not clear to me if it's something that
> > should be expected to be reset across a suspend/resume cycle or if it's
> > something that should be maintained across that cycle.
> >=20
> > What is your opinion on that?
>
> I understand colorop should follow the same lifecycle of plane, since
> colorop
> is associated with a plane and represent the color configuration of a giv=
en
> plane state.
>
> So, I think it should be preserved and restored in a suspend/resume cycle.

Ack :)

> You mentioned about "revamping state allocation/reset", is there already a
> public link for this work that I can take a look?

Sure, it's there:
https://lore.kernel.org/r/20260310-drm-mode-config-init-v1-0-de7397c8e1cf@k=
ernel.org

I should send a v2 soon though. Do you want to be in Cc?

Maxime

--efjkobqgbpnwfhqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCab1G1wAKCRAnX84Zoj2+
duI2AX0ahW+Z6n0zhXzxJWYLbj6dtGbuAqgj6SZ6ts6XcSf2W92k9QBmUIED8MwF
644HWQgBgPuel2I/8OLsVQaSbAbBxMM/9Kc4voQmD5JKh4QMFCXkKM7O6ecvc6cQ
U5yPJ5/9UQ==
=iJ80
-----END PGP SIGNATURE-----

--efjkobqgbpnwfhqr--
