Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66126CA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB72810E140;
	Wed, 30 Sep 2026 14:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="pfLkZfGx";
	dkim-atps=neutral
X-Greylist: delayed 426 seconds by postgrey-1.36 at gabe;
 Wed, 30 Sep 2026 14:27:21 UTC
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB49A10E140
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1790778442; x=1822314442;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kCB4rMy72t6lstrsvtZpL3+kGrYokSHmdSQFAird/Fc=;
 b=pfLkZfGxT3HuD61MTnz9v9zFxi00F7skdyNqoXf2TulBZ5UzT+RYIx2S
 ZTnOPWQsgS1JwcC6LHccJvnwh5GudBTvBVUdQNnCQgBgVQk56Lf9wP6mz
 o6DAFkso04c3rRmgE7vr59ui2vXgiujoaokBm1Zf3QwVDx/W3ymRGGQPs
 IEbENou/AXLGp5ARfiNOA64d0t7kRYAW2n095FcX58owFaFkssUxh16wK
 iddPnnS53CcAKEZW1CpWHZ/Y7Usoa0PVH9IQinYF7493iWuFvYAhs/XTG
 rNpHDZrFTZs+EVjLCU1MbXGTpDWb/jvCU0p9enrehg2aoNaDmu149e2PF Q==;
X-CSE-ConnectionGUID: 5UlyJrXIRiKfRQ7wTS9rwg==
X-CSE-MsgGUID: 9gbWqOU1Ts6BYkfY4HLAGQ==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
 d="asc'?scan'208";a="295783353"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 07:20:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 30 Sep 2026 07:20:13 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 07:20:11 -0700
Date: Wed, 30 Sep 2026 15:18:52 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Paul Walmsley
 <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Dominique
 Belhachemi <domibel@debian.org>, Michal Wilczynski
 <m.wilczynski@samsung.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>, Icenowy
 Zheng <uwu@icenowy.me>
Subject: Re: [RFC PATCH 0/2] drm: add a noncoherent mapping checking helper
Message-ID: <20260930-zippy-container-d48f72432c1f@wendy>
References: <20260930073528.3369325-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OqEFKY6wsUz/m5my"
Content-Disposition: inline
In-Reply-To: <20260930073528.3369325-1-zhengxingda@iscas.ac.cn>
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

--OqEFKY6wsUz/m5my
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 03:35:26PM +0800, Icenowy Zheng wrote:
> This patchset tries to address the lack of uncached mapping support on
> several SiFive-core-based SoCs, currently targeting JH7110 but EIC7700
> would have the same problem (although it uses DC8000 display controller
> instead of DC8200 and real display support is pending).
>=20
> Because other users (either SoCs with Xuantie cores, which have
> Xtheadmae extensions or non-RISC-V SoCs) of the driver have proper
> writecombine support, a helper is added to check whether coherent
> (cache-bypassing) mapping is available. This helper currently returns
> true for all architectures except RISC-V, and checks whether
> pgprot_writecombine() is a no-op on RISC-V.
>=20
> The patch really enabling manual cache maintenance for the verisilicon
> driver is picked from Dominique, and reworked to check both
> dma-noncoherent property and the platform's mapping capaibility.
>=20
> Tested on VisionFive 2 with the display enablement patchset at [1] (and
> its dependency).
>=20
> Also tested on Lichee Pi 4A (TH1520, which has Xtheadmae), operation is
> not affected, map_noncoherent isn't set and Xorg says kernel dirty
> updates aren't required.
>=20
> [1] https://patch.msgid.link/20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7=
@samsung.com

Out of curiosity, have you seen Bo Gan's series from a few months ago
that creates an extension/erratum to get these devices working?
https://lore.kernel.org/linux-riscv/20260316060328.1173634-1-ganboing@gmail=
=2Ecom/

I've been meaning to reply to it over and over again for the last number
of months, but I just haven't had the time to actually understand the
detail of the EIC7700 solution or check whether it works yet. I know
this is just one driver because the JH7110 only has this problem for the=20
display pipeline, but according to Bo Gan this applies to all
peripherals on the EIC7700.=20

>=20
> Dominique Belhachemi (1):
>   drm: verisilicon: support non-coherent DMA framebuffers
>=20
> Icenowy Zheng (1):
>   drm: add a helper function to check availbility of coherent mapping
>=20
>  drivers/gpu/drm/verisilicon/vs_cursor_plane.c |  9 ++++++
>  drivers/gpu/drm/verisilicon/vs_drm.c          | 32 ++++++++++++++++++-
>  drivers/gpu/drm/verisilicon/vs_drm.h          |  7 ++++
>  .../gpu/drm/verisilicon/vs_primary_plane.c    |  9 ++++++
>  include/drm/drm_cache.h                       | 21 ++++++++++++
>  5 files changed, 77 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.55.0
>=20

--OqEFKY6wsUz/m5my
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar0aTAAKCRB4tDGHoIJi
0gIjAQCmqfpa8F+zRS9qou6Cpt/edun4UcrGLDrhAT9zS7xYcAEAxJhi1xxX/pOq
tlDO5YLG1EFJ07bqeI4vPVUnFSYXcgU=
=z16F
-----END PGP SIGNATURE-----

--OqEFKY6wsUz/m5my--
