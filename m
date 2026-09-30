Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D64CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BC810E215;
	Wed, 30 Sep 2026 16:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GSrb40ou";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A47710E0F8
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:30:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67D4F601DE;
 Wed, 30 Sep 2026 16:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C731F000FF;
 Wed, 30 Sep 2026 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790785834;
 bh=hcC7y6OqYIBEAIEK61od8XIplz9+KJEh05oZOmF6HrM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GSrb40ouijyelBGmpHMusFTnG+VaYn88z4GHDNRJ7Amg0hDVxW3wohM7IpGmYKaDg
 cChfkyTe58WH0agtynZDr0l5GLOwfNUFUCxl8rK9/VXUOghZCg6CpH6zkmC1T3Penx
 f1Ps8yxQ7nghNbPTIaBxScVBK3c7ZgKl7VVmwZcialLvYMHWX5HrShKFe2meKoUBRe
 GPUixGrWS8Ih+JOPJjzaJvHCN4ZqOAHsHFizDPzF3zhpr5vJ6pPQnnTqSi3iujcx7X
 fshR8nVgVTfz8+g/RI/sSVqSaQSPvpY17TjebA6NR8Qr4veiPZ055FfDcrTtQ8+7o+
 Z5NlrRwwD4KKw==
Date: Wed, 30 Sep 2026 17:30:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
 Dominique Belhachemi <domibel@debian.org>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 0/2] drm: add a noncoherent mapping checking helper
Message-ID: <20260930-reoccupy-pupil-6a5d0cace243@spud>
References: <20260930073528.3369325-1-zhengxingda@iscas.ac.cn>
 <20260930-zippy-container-d48f72432c1f@wendy>
 <32baa664ee2f66618a54c260849b311c581febfc.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="47k/3Cbh9i3Er7DT"
Content-Disposition: inline
In-Reply-To: <32baa664ee2f66618a54c260849b311c581febfc.camel@icenowy.me>
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

--47k/3Cbh9i3Er7DT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:38:07PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2026-09-30=E4=B8=89=E7=9A=84 15:18 +0100=EF=BC=8CConor Dooley=
=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, Sep 30, 2026 at 03:35:26PM +0800, Icenowy Zheng wrote:
> > > This patchset tries to address the lack of uncached mapping support
> > > on
> > > several SiFive-core-based SoCs, currently targeting JH7110 but
> > > EIC7700
> > > would have the same problem (although it uses DC8000 display
> > > controller
> > > instead of DC8200 and real display support is pending).
> > >=20
> > > Because other users (either SoCs with Xuantie cores, which have
> > > Xtheadmae extensions or non-RISC-V SoCs) of the driver have proper
> > > writecombine support, a helper is added to check whether coherent
> > > (cache-bypassing) mapping is available. This helper currently
> > > returns
> > > true for all architectures except RISC-V, and checks whether
> > > pgprot_writecombine() is a no-op on RISC-V.
> > >=20
> > > The patch really enabling manual cache maintenance for the
> > > verisilicon
> > > driver is picked from Dominique, and reworked to check both
> > > dma-noncoherent property and the platform's mapping capaibility.
> > >=20
> > > Tested on VisionFive 2 with the display enablement patchset at [1]
> > > (and
> > > its dependency).
> > >=20
> > > Also tested on Lichee Pi 4A (TH1520, which has Xtheadmae),
> > > operation is
> > > not affected, map_noncoherent isn't set and Xorg says kernel dirty
> > > updates aren't required.
> > >=20
> > > [1]
> > > https://patch.msgid.link/20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7=
@samsung.com
> >=20
> > Out of curiosity, have you seen Bo Gan's series from a few months ago
> > that creates an extension/erratum to get these devices working?
> > https://lore.kernel.org/linux-riscv/20260316060328.1173634-1-ganboing@g=
mail.com/
> >=20
> > I've been meaning to reply to it over and over again for the last
> > number
> > of months, but I just haven't had the time to actually understand the
> > detail of the EIC7700 solution or check whether it works yet. I know
> > this is just one driver because the JH7110 only has this problem for
> > the=20
>=20
> I personally think his EIC7700 solution unacceptable -- it's not
> running directly on EIC7700, but some custom hypervisor (because the
> uncached offset of EIC7700 doesn't behave as a simple OR opertaion),
> which requires 3rd party code and prohibits KVM usage of the kernel.

I was actually reading through Bo Gan's patchset when I noticed this
series, trying to get my thoughts in order and figured a second set of
eyes and thoughts would be helpful to me.

I've got a similar opinion to yours about the EIC7700 solution, it's
quite invasive (it'd only be 3rd party if it wasn't accepted) but I
would consider something invasive firmware wise to be worthwhile if no
peripheral on the device worked without it.

> > display pipeline, but according to Bo Gan this applies to all
> > peripherals on the EIC7700.=20

And, as I said, Bo Gan was of the opinion that all of the peripherals
require it. Of course I suspect that actually meant all DMA capable
peripherals require it, not all peripherals (especially given there's
been patchsets adding simpler peripherals).

That said, Samuel's solution does exist and if the feedback was
implemented by someone that cared about the eic7700 it'd be much more
acceptable. The fact that you've got a solution here at at least works
on an interim basis for the JH7110 (although I have no idea what the DRM
folks will think of it) is another point in Samuel's method's favour.

Thanks. I've got a much better idea of what to say to Bo Gan now.

Conor.

> In fact JH7100 suffers from the same problem too, so JH7110 put some
> DMA peripherals to the L2 front AXI bus; however although this bus
> keeps coherency with the CPU, its bandwidth is questionable (I think
> the bottleneck could be exhibited if you attach a not-too-bad NVMe SSD
> on JH7110's PCIe).
>=20
> Thanks,
> Icenowy
>=20
> >=20
> > >=20
> > > Dominique Belhachemi (1):
> > > =C2=A0 drm: verisilicon: support non-coherent DMA framebuffers
> > >=20
> > > Icenowy Zheng (1):
> > > =C2=A0 drm: add a helper function to check availbility of coherent
> > > mapping
> > >=20
> > > =C2=A0drivers/gpu/drm/verisilicon/vs_cursor_plane.c |=C2=A0 9 ++++++
> > > =C2=A0drivers/gpu/drm/verisilicon/vs_drm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32
> > > ++++++++++++++++++-
> > > =C2=A0drivers/gpu/drm/verisilicon/vs_drm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++
> > > =C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 9 ++++++
> > > =C2=A0include/drm/drm_cache.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 21 ++++++++++++
> > > =C2=A05 files changed, 77 insertions(+), 1 deletion(-)
> > >=20
> > > --=20
> > > 2.55.0
> > >=20

--47k/3Cbh9i3Er7DT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar05DwAKCRB4tDGHoIJi
0hBMAQCGkXMDU3h/uHOa4tVd6jAtm5+8LSaMtGIKlN36M3r5/wD/baPrkiu8EKfY
3Ji6X+CNgxudEQ3n4ASGeTxU2/TeMAY=
=dfvv
-----END PGP SIGNATURE-----

--47k/3Cbh9i3Er7DT--
