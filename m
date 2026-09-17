Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF883C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185D910EE40;
	Thu, 17 Sep 2026 11:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="EcwjcfxS";
	dkim-atps=neutral
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D30A410EE40
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789645872; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Pd82UWvfSs6YpVrv1vAog2PUcpE+Ombq1RArsu0V0jTFZTQtWDh0bYMe6p2rTteg9h++P5hRHi4cDvwe9KTHSgt5I+nSV+Y1BmfeAxqi0foyCAdK3OaWDXaCc/gyIeRHM7oMFN22tAmqqQPlK1pP6+5y4DzvhMkxKfkwOE0trTk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789645872;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kseQKRvQdNnN8LYBnsMt6SWVvkkwfz7j+iCs7tAx5Sw=; 
 b=bKNa4ZfgdhmY6u6pSqaA/IS4XO5OJNN59WJTndP4weOKGmlMy7BMyjWaI+Ab+hLd8RTpB2VikQ7KMh02VopEmjgf7/ExO9TVTr5Z0aFd0mZthVYX/NEPis2wME2wrbGTF2G5wLFEkqZCcWyestNKUwsfRls7x1fooQ8ooqeIWQw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789645872; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=kseQKRvQdNnN8LYBnsMt6SWVvkkwfz7j+iCs7tAx5Sw=;
 b=EcwjcfxStg1/MXXpii5AtWo3avKE4bU5Fkdyodhl8QYdZlmR2jz2kZC9/NL/xnYL
 A+ZyeFJfs+U9gbLyO94UdPXQHJ6LVvAg9mvUovNw5Kfjfhl4SQV7xmGW0H/G9PncBSL
 0/jTXWOqZXEY4skU+BoGiZDgTBzePxvpCjDWKVQMEPVHdCMJ6tU0hK3hC6FGEbSPIaT
 vpHHuJ7MIt+BJ5CGp4NqR8tOab8PwdbFqHBWZEPzZHFtTffjW+6ZsUReOVExE6zZmP4
 A5MucyOfpQUmneVrHeDziFb84wPTO9VCboxzUcBiiQq2qiCEPl30c6XC5dp1OV2W9cy
 UsdO2QKvZQ==
Received: by smtp.zohomail.com with SMTPS id 1789645871551851.4316439919276;
 Thu, 17 Sep 2026 04:51:11 -0700 (PDT)
Message-ID: <c70b6dbe42aa5ba489dba7634ad604b41925146a.camel@icenowy.me>
Subject: Re: [PATCH RFT v2 0/5] drm: Add and use
 drm_fb_dma_get_gem_clipped_addr() helper
From: Icenowy Zheng <uwu@icenowy.me>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Liu Ying <victor.liu@nxp.com>, Laurentiu Palcu
 <laurentiu.palcu@oss.nxp.com>,  Lucas Stach <l.stach@pengutronix.de>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,  Samuel
 Holland <samuel@sholland.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie	 <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 	linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, 	dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 19:51:05 +0800
In-Reply-To: <CAGXv+5FHiW8umZ=wLLb5wK5Qz3hf-mbxC_zH5v+pwxxyUNTwew@mail.gmail.com>
References: <20260916033327.3054126-1-wenst@chromium.org>
 <6d21e808d343283264665ec16d297317000fdf4d.camel@icenowy.me>
 <CAGXv+5FHiW8umZ=wLLb5wK5Qz3hf-mbxC_zH5v+pwxxyUNTwew@mail.gmail.com>
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

=E5=9C=A8 2026-09-17=E5=9B=9B=E7=9A=84 19:42 +0800=EF=BC=8CChen-Yu Tsai=E5=
=86=99=E9=81=93=EF=BC=9A
> On Thu, Sep 17, 2026 at 7:16=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me> wr=
ote:
> >=20
> > =E5=9C=A8 2026-09-16=E4=B8=89=E7=9A=84 11:33 +0800=EF=BC=8CChen-Yu Tsai=
=E5=86=99=E9=81=93=EF=BC=9A
> > > Hi,
> > >=20
> > > This is v2 of my drm_fb_dma_get_gem_clipped_addr() series.
> > >=20
> > > Changes since v1:
> > > - Add and use new drm_framebuffer_get_block_offset() helper
> > > (Thomas)
> > >=20
> > >=20
> > > This series adds a helper to retrieve the buffer starting address
> > > of
> > > a
> > > "clipped" framebuffer. This contrasts with
> > > drm_fb_dma_get_gem_addr(),
> > > which gives the address of the full buffer.
> >=20
> > Should vs_fb_get_dma_addr() in verisilicon/vs_plane.c be replaced
> > with
> > this helper too?
> >=20
> > I implemented manual framebuffer offset addition here.
>=20
> Didn't I replace vs_fb_get_dma_addr() with drm_fb_dma_get_gem_addr()

Yes, it seems so. I checked newest rc, but this change is in drm-misc-
next. Sorry for the noise.

> already? At the time only primary and cursor planes were supported by
> the driver. The primary plane can't be clipped, and the cursor plane
> had some custom clipping, but seemed to want the unclipped address.

Yes it looks like thedrm_fb_dma_get_gem_addr() helper already handled
the non-clipping source offset.

Thanks,
Icenowy

>=20
>=20
> ChenYu
>=20
> > Thanks,
> > Icenowy
> >=20
> > >=20
> > > Some drivers program their hardware with clipped dimensions, so
> > > they
> > > should be using the clipped buffer address as well, unless the
> > > hardware
> > > can advance the scanout directly. (Side note: many drivers still
> > > use
> > > the non-clipped dimensions.)
> > >=20
> > > While at it, also pull out the offset calculation of
> > > drm_fb_dma_get_gem_addr()
> > > into a separate helper in drm_framebuffer.[ch], thereby
> > > separating
> > > responsibilities.
> > >=20
> > > The sun4i driver was recently incorrectly converted to use the
> > > unclipped
> > > drm_fb_dma_get_gem_addr() helper. This broke offsets into
> > > subsampled
> > > pixel groups, but also exposed the mismatch between the
> > > dimensions
> > > used
> > > vs the buffer address. Two other drivers were also touched.
> > >=20
> > >=20
> > > Patch 1 adds a new helper to return the byte offset into a
> > > framebuffer
> > > for the start of the pixel block of the given pixel coordinates.
> > >=20
> > > Patch 2 adds the new helper to return the buffer address based on
> > > clipped coordinates.
> > >=20
> > > Patch 3 switches the sun4i driver to the new helper, and fixes
> > > the
> > > luma plane buffer address offset for subsampled YUV formats.
> > >=20
> > > Patch 4 converts the imx/dc driver to use the new helper. This
> > > fixes
> > > a
> > > mismatch between the programmed coordinates and the buffer
> > > address.
> > >=20
> > > Patch 5 replaces the open coded buffer address calculation in the
> > > imx/dcss driver with the new helper. Existing behavior, which
> > > might
> > > be
> > > wrong, is preserved.
> > >=20
> > >=20
> > > Please help test. The series is only compile tested on my end.
> > > The
> > > sun4i
> > > changes should revert its behavior to before the
> > > drm_fb_dma_get_gem_addr()
> > > was adopted. The imx/dcss changes should not have any behavioral
> > > difference.
> > >=20
> > >=20
> > > Thanks
> > > ChenYu
> > >=20
> > > Chen-Yu Tsai (5):
> > > =C2=A0 drm: Split framebuffer pixel offset calculation from
> > > =C2=A0=C2=A0=C2=A0 drm_fb_dma_get_gem_addr()
> > > =C2=A0 drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
> > > =C2=A0 drm/sun4i: layers: Fix VI buffer address for clipped offsets
> > > =C2=A0 drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
> > > =C2=A0 drm/imx/dcss: plane: Switch to
> > > drm_fb_dma_get_gem_clipped_addr()
> > >=20
> > > =C2=A0drivers/gpu/drm/drm_fb_dma_helper.c=C2=A0=C2=A0=C2=A0 | 61 ++++=
++++++++++------
> > > ----
> > > --
> > > =C2=A0drivers/gpu/drm/drm_framebuffer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 45 +++++++++++++++++++
> > > =C2=A0drivers/gpu/drm/imx/dc/dc-plane.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 4 +-
> > > =C2=A0drivers/gpu/drm/imx/dcss/dcss-plane.c=C2=A0 | 34 ++++++--------
> > > =C2=A0drivers/gpu/drm/sun4i/sun8i_ui_layer.c |=C2=A0 2 +-
> > > =C2=A0drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 ++++++-
> > > =C2=A0include/drm/drm_fb_dma_helper.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 ++
> > > =C2=A0include/drm/drm_framebuffer.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
> > > =C2=A08 files changed, 118 insertions(+), 51 deletions(-)
