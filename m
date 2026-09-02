Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049AEC624D7
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116D810F252;
	Wed,  2 Sep 2026 14:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eshps1vF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF8410F244;
 Wed,  2 Sep 2026 14:40:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08FF541457;
 Wed,  2 Sep 2026 14:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01DC1F000E9;
 Wed,  2 Sep 2026 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788360041;
 bh=96/6s6+6Obnnoy5JuD/EsnTNI8D3RwVukTStVxJQY3M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Eshps1vFqetUa0nUq64kBrUzZWtYf5KRecWNiZ+S9i5dhuvWlMua6CBbNvQCvgH7D
 CFZ06BsfQjTqmH+j/SD43Q7TBEnhyp5fsVITffwOc7Ls1+xReGx/AoeB5DWtXnveE/
 b01VxoZSnjGSEm2T1UdzThzOw8aYKmbYcp31DtX/aFbtqaKBC8OizwGzbmBCSN9oLk
 Gs0i55izU5TiXb7cVV+t6Bxgfb82wePeI1WIKisitfuHBlVAMOVt4pmLbdmpiMg6oN
 DoPA/yIXlRQFAlHQXdSPGgjuUzanMIu82MiuLlDTs0F70BLouQiXo0Es3ql1ufI+HR
 e5hLNBhjuxJdw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
 id C4E3DCD6F29; Wed, 02 Sep 2026 15:40:15 +0100 (BST)
Date: Wed, 2 Sep 2026 15:40:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <apg1Tx4C2-COl4E1@sirena.org.uk>
References: <apbbvQSfUbzYRFaw@sirena.org.uk>
 <3cd2c640-3ce8-4163-9f7b-3abba46ae072@gmail.com>
 <64bdb5bc-ced6-490c-b4c8-fd3dcabbbd4c@sirena.org.uk>
 <d1a594e7-7393-4f2f-b11d-bfff720de743@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oeJxrKdgA5RSpryZ"
Content-Disposition: inline
In-Reply-To: <d1a594e7-7393-4f2f-b11d-bfff720de743@ideasonboard.com>
X-Cookie: Orders subject to approval.
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


--oeJxrKdgA5RSpryZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 02, 2026 at 04:11:21PM +0300, Tomi Valkeinen wrote:
> On 02/09/2026 15:11, Mark Brown wrote:

> > > 2. 699e5975e2a53 (drm/omap: Report HDMI hotplug events to the ASoC HDMI
> > > codec)

> > ...which the drm-misc tree has now merged so I don't expect it to build
> > independently of any other tree.  I'm a bit surprised this wasn't caught
> > when merging up -rc1.

> So the fix is just to remove that line. Any preference, should this go via
> drm or sound?

Given that the breakage is in drm-misc it needs to be fixed in drm-misc,
hopefully before it starts getting cross merged everywhere.

--oeJxrKdgA5RSpryZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqYNU4ACgkQJNaLcl1U
h9D0BAf/YAyxtna7V3tYshH0D/06/RiC5zRqLLJUGMmdlKIaFje98uwEKaeEhLfv
3Zmd0xZuf1/DjEjlgs2qB6oPBFFUnM9vdv2nkbsoPcy6YaJI+rBFuOlnl3unT9Bx
AutKhccQ07Wj4dhXnn9QEm3SgwXRO3T87Ajry27jKy0kYHrTrIZoTJXxJkHPQqIA
twtEbep+BRy8dCCOs/PbQkAiOLkp03o5hPFSR+mVoA7ROPuEF5hTI/4PkfCNPMsa
LRnuWHeQg9XoIaeIn4Ujlz9DtW822/7nKLSyH4X1f66mLOBRwohdVRqmMT2saENV
GW1Bl9KxMHWMhZHXep/4RyWPr3g5zw==
=mDpJ
-----END PGP SIGNATURE-----

--oeJxrKdgA5RSpryZ--
