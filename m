Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B833CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CAA10E5DC;
	Wed, 30 Sep 2026 14:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="RKxtKsqC";
	dkim-atps=neutral
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8078B10E5DC
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790779098; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Yf1S92WSr8Oz7zcvvnh6pxtKqTiMOge44c0nfuTiZ5Qdzks9htwoxn0jzk4kscZglmLefUJmzEVc6y0zkiSqRjhC1mtekqZxAnn+ffFePrOJOl5RWqN5kkx6FiiH8vwgTUG2gq/G3IKj4RPsgsn5CEqgxXW1OhtKqyx8ELH9bLs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790779098;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tBu9b7TLQe7QpwGcplfd51YyxwHo+iad+kdLfEBII/U=; 
 b=J5wz+4UKGb9I6JglBkHnksLniF5RmrCE25QjZGCsoFKO6DaUoLHNqGj/2RjXGKBDF6NaJnIgNBTkh952gJhyfU+t28+4BLlqeOKsNKzyOFtgEvCdeQRHmRMgvqTv2pO3I5DuIU1so3p0+YTbupHwt1aGC6u5047Gm/GhuBEjlg8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790779098; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=tBu9b7TLQe7QpwGcplfd51YyxwHo+iad+kdLfEBII/U=;
 b=RKxtKsqCWHI2iJ0PEfttV7NYLAUgHvE4aENmWzLlX5zlFr067Wff99EWUCPL3UoH
 O9bpTRyrHB8VgDAr10RVq66CSBSUMDPb7iilZ6U8fxRO9ZpaW90spg8K1VMa54k5K8w
 PXbu4Tw+tuE3EG2GKH+Ss58Tr2lzTF8z3B3Jwc/nBTOlRSuBs1GAW16XIMU7+394Vns
 sz1Gi3BGOTrTGi+YPVZf192xKAA8hnsxtvo0tjHfhzc3zi9klQ3hhZBIku6yqsreAr3
 wDaXp/EOnieBJTsrQAZBrDyBqtdBnwG+2rAXID/+sC5/YevYCidCfBFas9AGC2D58ch
 Tap2C/qaNg==
Received: by smtp.zohomail.com with SMTPS id 1790779098161301.8299346542899;
 Wed, 30 Sep 2026 07:38:18 -0700 (PDT)
Message-ID: <32baa664ee2f66618a54c260849b311c581febfc.camel@icenowy.me>
Subject: Re: [RFC PATCH 0/2] drm: add a noncoherent mapping checking helper
From: Icenowy Zheng <uwu@icenowy.me>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Paul Walmsley	
 <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Dominique
 Belhachemi <domibel@debian.org>, Michal Wilczynski
 <m.wilczynski@samsung.com>, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	linux-riscv@lists.infradead.org
Date: Wed, 30 Sep 2026 22:38:07 +0800
In-Reply-To: <20260930-zippy-container-d48f72432c1f@wendy>
References: <20260930073528.3369325-1-zhengxingda@iscas.ac.cn>
 <20260930-zippy-container-d48f72432c1f@wendy>
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

=E5=9C=A8 2026-09-30=E4=B8=89=E7=9A=84 15:18 +0100=EF=BC=8CConor Dooley=E5=
=86=99=E9=81=93=EF=BC=9A
> On Wed, Sep 30, 2026 at 03:35:26PM +0800, Icenowy Zheng wrote:
> > This patchset tries to address the lack of uncached mapping support
> > on
> > several SiFive-core-based SoCs, currently targeting JH7110 but
> > EIC7700
> > would have the same problem (although it uses DC8000 display
> > controller
> > instead of DC8200 and real display support is pending).
> >=20
> > Because other users (either SoCs with Xuantie cores, which have
> > Xtheadmae extensions or non-RISC-V SoCs) of the driver have proper
> > writecombine support, a helper is added to check whether coherent
> > (cache-bypassing) mapping is available. This helper currently
> > returns
> > true for all architectures except RISC-V, and checks whether
> > pgprot_writecombine() is a no-op on RISC-V.
> >=20
> > The patch really enabling manual cache maintenance for the
> > verisilicon
> > driver is picked from Dominique, and reworked to check both
> > dma-noncoherent property and the platform's mapping capaibility.
> >=20
> > Tested on VisionFive 2 with the display enablement patchset at [1]
> > (and
> > its dependency).
> >=20
> > Also tested on Lichee Pi 4A (TH1520, which has Xtheadmae),
> > operation is
> > not affected, map_noncoherent isn't set and Xorg says kernel dirty
> > updates aren't required.
> >=20
> > [1]
> > https://patch.msgid.link/20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@s=
amsung.com
>=20
> Out of curiosity, have you seen Bo Gan's series from a few months ago
> that creates an extension/erratum to get these devices working?
> https://lore.kernel.org/linux-riscv/20260316060328.1173634-1-ganboing@gma=
il.com/
>=20
> I've been meaning to reply to it over and over again for the last
> number
> of months, but I just haven't had the time to actually understand the
> detail of the EIC7700 solution or check whether it works yet. I know
> this is just one driver because the JH7110 only has this problem for
> the=20

I personally think his EIC7700 solution unacceptable -- it's not
running directly on EIC7700, but some custom hypervisor (because the
uncached offset of EIC7700 doesn't behave as a simple OR opertaion),
which requires 3rd party code and prohibits KVM usage of the kernel.

> display pipeline, but according to Bo Gan this applies to all
> peripherals on the EIC7700.=20

In fact JH7100 suffers from the same problem too, so JH7110 put some
DMA peripherals to the L2 front AXI bus; however although this bus
keeps coherency with the CPU, its bandwidth is questionable (I think
the bottleneck could be exhibited if you attach a not-too-bad NVMe SSD
on JH7110's PCIe).

Thanks,
Icenowy

>=20
> >=20
> > Dominique Belhachemi (1):
> > =C2=A0 drm: verisilicon: support non-coherent DMA framebuffers
> >=20
> > Icenowy Zheng (1):
> > =C2=A0 drm: add a helper function to check availbility of coherent
> > mapping
> >=20
> > =C2=A0drivers/gpu/drm/verisilicon/vs_cursor_plane.c |=C2=A0 9 ++++++
> > =C2=A0drivers/gpu/drm/verisilicon/vs_drm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32
> > ++++++++++++++++++-
> > =C2=A0drivers/gpu/drm/verisilicon/vs_drm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++
> > =C2=A0.../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 9 ++++++
> > =C2=A0include/drm/drm_cache.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 21 ++++++++++++
> > =C2=A05 files changed, 77 insertions(+), 1 deletion(-)
> >=20
> > --=20
> > 2.55.0
> >=20
