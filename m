Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F02CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 05:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C1410E09D;
	Thu,  1 Oct 2026 05:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="qeOpMIHq";
	dkim-atps=neutral
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C2110E09D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 05:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790832099; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mMFw8cCuCMzUEVMfJF3aKZ1neIlbin6WcRqxVN2oUpSmY3mthZUi3rbTPVw4LXqJrmpYw2e6f8Je8I9Eb+CaGshT6YlFRYiHY+8exwpRiSo3J4RYwhDUdJqJe+gqiPv1uKy8myK3nqZH/8LDXLfSVLvOGJwpAIGNrqb4ieLuuoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790832099;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lz+9c0nkenhND9sDVxJDz3WjWh9rFaj9ZD4c+CCam6g=; 
 b=EFxTNTjLePxt3iHQb2Ba0jJeFfoP96hTmNrDCC05/pM31i33xwSi3Ax8SOMikyRYZaT+FPoI+bWmRMxKbtE6SVMV1wnMdE1P/lULXCoz6wNswJepj/CnIJa26tMk7ssXYRAqthXRcre1gHhbr6Hn5soDfwiYTUKXuybhSq+Uggo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790832099; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=lz+9c0nkenhND9sDVxJDz3WjWh9rFaj9ZD4c+CCam6g=;
 b=qeOpMIHqj1lSX3vGn5zRrQcXblWXrJn6zCXKct6mSEhyE3JIpF/41Snh0wFP3YeK
 rSBzgz53J4Fr7Za9KWvSY9gTbD6EW48oHJGicSgQfI9rgVI2gCp8PHyx+bZZRd6Ga1p
 +NfdDnuYYb97D3bDwoh5c9zNxjBJTeCCgYbn5c6DY6qUPvJJ9CB8qd7oeoZMVjtYdd+
 /u733hGh6GKkT4WHZY8mlAG4QGQ96vA4EafqEm1T5X6Z65k69t5wot50HeGbLY+wW6y
 Sb252PWO9qGeoF+hwHxoL6DjHJeOvpaWyUf5kjOd3Sy23wcsf/2u1FVKK2+aozJW5G8
 trKoR2xWSg==
Received: by smtp.zohomail.com with SMTPS id 1790832098016772.1720132572663;
 Wed, 30 Sep 2026 22:21:38 -0700 (PDT)
Message-ID: <3e8bc62a01f5b0162373cb8016d7409c6a4c269b.camel@icenowy.me>
Subject: Re: [RFC PATCH 0/2] drm: add a noncoherent mapping checking helper
From: Icenowy Zheng <uwu@icenowy.me>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Paul Walmsley <pjw@kernel.org>, Samuel
 Holland <samuel.holland@sifive.com>, Dominique Belhachemi	
 <domibel@debian.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
Date: Thu, 01 Oct 2026 13:21:32 +0800
In-Reply-To: <20260930-reoccupy-pupil-6a5d0cace243@spud>
References: <20260930073528.3369325-1-zhengxingda@iscas.ac.cn>
 <20260930-zippy-container-d48f72432c1f@wendy>
 <32baa664ee2f66618a54c260849b311c581febfc.camel@icenowy.me>
 <20260930-reoccupy-pupil-6a5d0cace243@spud>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-09-30=E4=B8=89=E7=9A=84 17:30 +0100=EF=BC=8CConor Dooley=E5=
=86=99=E9=81=93=EF=BC=9A
> On Wed, Sep 30, 2026 at 10:38:07PM +0800, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-09-30=E4=B8=89=E7=9A=84 15:18 +0100=EF=BC=8CConor Dooley=
=E5=86=99=E9=81=93=EF=BC=9A
> > > On Wed, Sep 30, 2026 at 03:35:26PM +0800, Icenowy Zheng wrote:
> > > > This patchset tries to address the lack of uncached mapping
> > > > support
> > > > on
> > > > several SiFive-core-based SoCs, currently targeting JH7110 but
> > > > EIC7700
> > > > would have the same problem (although it uses DC8000 display
> > > > controller
> > > > instead of DC8200 and real display support is pending).
> > > >=20
> > > > Because other users (either SoCs with Xuantie cores, which have
> > > > Xtheadmae extensions or non-RISC-V SoCs) of the driver have
> > > > proper
> > > > writecombine support, a helper is added to check whether
> > > > coherent
> > > > (cache-bypassing) mapping is available. This helper currently
> > > > returns
> > > > true for all architectures except RISC-V, and checks whether
> > > > pgprot_writecombine() is a no-op on RISC-V.
> > > >=20
> > > > The patch really enabling manual cache maintenance for the
> > > > verisilicon
> > > > driver is picked from Dominique, and reworked to check both
> > > > dma-noncoherent property and the platform's mapping
> > > > capaibility.
> > > >=20
> > > > Tested on VisionFive 2 with the display enablement patchset at
> > > > [1]
> > > > (and
> > > > its dependency).
> > > >=20
> > > > Also tested on Lichee Pi 4A (TH1520, which has Xtheadmae),
> > > > operation is
> > > > not affected, map_noncoherent isn't set and Xorg says kernel
> > > > dirty
> > > > updates aren't required.
> > > >=20
> > > > [1]
> > > > https://patch.msgid.link/20260929-jh7110-clean-send-v5-0-82b4d8e3c6=
c7@samsung.com
> > >=20
> > > Out of curiosity, have you seen Bo Gan's series from a few months
> > > ago
> > > that creates an extension/erratum to get these devices working?
> > > https://lore.kernel.org/linux-riscv/20260316060328.1173634-1-ganboing=
@gmail.com/
> > >=20
> > > I've been meaning to reply to it over and over again for the last
> > > number
> > > of months, but I just haven't had the time to actually understand
> > > the
> > > detail of the EIC7700 solution or check whether it works yet. I
> > > know
> > > this is just one driver because the JH7110 only has this problem
> > > for
> > > the=20
> >=20
> > I personally think his EIC7700 solution unacceptable -- it's not
> > running directly on EIC7700, but some custom hypervisor (because
> > the
> > uncached offset of EIC7700 doesn't behave as a simple OR
> > opertaion),
> > which requires 3rd party code and prohibits KVM usage of the
> > kernel.
>=20
> I was actually reading through Bo Gan's patchset when I noticed this
> series, trying to get my thoughts in order and figured a second set
> of
> eyes and thoughts would be helpful to me.
>=20
> I've got a similar opinion to yours about the EIC7700 solution, it's
> quite invasive (it'd only be 3rd party if it wasn't accepted) but I

It'd always be 3rd party if Eswin doesn't accept it. The Linux kernel
cannot deliver such a hacked firmware.

> would consider something invasive firmware wise to be worthwhile if
> no
> peripheral on the device worked without it.
>=20
> > > display pipeline, but according to Bo Gan this applies to all
> > > peripherals on the EIC7700.=20
>=20
> And, as I said, Bo Gan was of the opinion that all of the peripherals
> require it. Of course I suspect that actually meant all DMA capable
> peripherals require it, not all peripherals (especially given there's
> been patchsets adding simpler peripherals).

All DMA peripherals on EIC7700 is non-coherent, but some of them will
still work without uncached mapping.

Only peripherals that really share the same buffer between CPU and the
device will be affected, because otherwise the coherency is kept by
cache maintenance instead of uncached mapping. (Display framebuffer is
a borderline situation -- it is accessed by the CPU and the DC in the
same time, but the DC does read-only access, so manual cache
maintenance is still doable although with price).

>=20
> That said, Samuel's solution does exist and if the feedback was
> implemented by someone that cared about the eic7700 it'd be much more
> acceptable. The fact that you've got a solution here at at least
> works
> on an interim basis for the JH7110 (although I have no idea what the
> DRM
> folks will think of it) is another point in Samuel's method's favour.

I think the major problem of Samuel's method is that it's invasive to
other kernel subsystems, which would make the review time much much
longer; but I still expect it.

(A minor problem is that his mail server is too strict -- on SPF rules,
which prevented his mails to be forwarded by mailing lists.)

Thanks,
Icenowy

>=20
> Thanks. I've got a much better idea of what to say to Bo Gan now.
>=20
> Conor.
>=20
> > In fact JH7100 suffers from the same problem too, so JH7110 put
> > some
> > DMA peripherals to the L2 front AXI bus; however although this bus
> > keeps coherency with the CPU, its bandwidth is questionable (I
> > think
> > the bottleneck could be exhibited if you attach a not-too-bad NVMe
> > SSD
> > on JH7110's PCIe).
> >=20
> > Thanks,
> > Icenowy
> >=20
> > >=20
> > > >=20
> > > > Dominique Belhachemi (1):
> > > > =C2=A0 drm: verisilicon: support non-coherent DMA framebuffers
> > > >=20
> > > > Icenowy Zheng (1):
> > > > =C2=A0 drm: add a helper function to check availbility of coherent
> > > > mapping
> > > >=20
> > > > =C2=A0drivers/gpu/drm/verisilicon/vs_cursor_plane.c |=C2=A0 9 +++++=
+
> > > > =C2=A0drivers/gpu/drm/verisilicon/vs_drm.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32
> > > > ++++++++++++++++++-
> > > > =C2=A0drivers/gpu/drm/verisilicon/vs_drm.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++
> > > > =C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 =
|=C2=A0 9 ++++++
> > > > =C2=A0include/drm/drm_cache.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 21
> > > > ++++++++++++
> > > > =C2=A05 files changed, 77 insertions(+), 1 deletion(-)
> > > >=20
> > > > --=20
> > > > 2.55.0
> > > >=20
