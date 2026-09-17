Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24403C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DDB10EE36;
	Thu, 17 Sep 2026 11:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ctLZV5vY";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D443C10E6F0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:42:52 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66e4ab20a32so687056d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 04:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789645372; cv=none;
 d=google.com; s=arc-20260327;
 b=kt+R6l6QW0Clo99G7WxzyTJcU0SCD476VuSKKvM5lMHEclCHyvSWZv3VEI+vhKcE8t
 TyteLzBXmTt/OFSw2b2VyKLQpmDNAQr+f2pBYY1Wf4Sn1zpZ/CCKKpT2Plzt2TlcZ1ws
 ob9fN11EfN3ZqLaQ+1m5VHIfSvy7QeUfREOlJFgOfWuIEwQuAsbNXiXIz81UdgUw8Sj0
 wRh085EPATDb6YI9J6tnQV4tdt0NyoHRN+ta2/breMgmBQNgV/t5mQknww3FWJ/uPKj6
 Lj3rLIiywjBT5q00v5OFn/8q8PQLsvEBgslfTyHHGYHd5l/OW988Odx6AV6EkSx3OIFb
 iueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=glNGbXLPG/pOAS+pJMdVn3sfq0+G6eulTKEjqN2qPww=;
 fh=q22b0e+tE+zJNhszOaxLmAznj5+YUOPH/uhqtJTL81g=;
 b=SWUNWUKt1F41Wqc+RpnaR1u53oYz2gdGvTRQYND4lr71xEyHzUIdmn+MsN9SiBEMun
 9MeQaNkzdNGZG/TOc7RzAK0X8mZJOYGQbbQGRJR8T1da7gngVTP56ukaPqEs/MjUxldJ
 FLeSJ9suz+Txh2GqqPA1Qn5nGmJdFhMOx3rDqIcN2j+7Z2RMpnjkrCFSDAYwcq6PxIBf
 l5bv9H0O9hTg8ePz1JvRlu/KFOtCCO/RNZvzrLaObmMR/K/IZLqfpzfpSA1tiEFHBrtp
 Me+hn92eBXhHaYV7TpLmSUIRGAMcHL8kJZmdRxX6byr97UydZjnmyAKbO5oASa0EFG9F
 20ug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789645372; x=1790250172;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=glNGbXLPG/pOAS+pJMdVn3sfq0+G6eulTKEjqN2qPww=;
 b=ctLZV5vYevN47e4qvvqDPb50n464UH2K3MfhURSywNWXVI1YQNKy5YpfbS2PJZE8xO
 S27qoLCVygir1fQjFwP0BsAloYRETZoadUqb182ySOQM7OeKOmH1dF+Tp8u9GVbTSi7x
 8tQKp6IzpftzbdbrGhWHi7hDknPBLaaApsWzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789645372; x=1790250172;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=glNGbXLPG/pOAS+pJMdVn3sfq0+G6eulTKEjqN2qPww=;
 b=k6mJfJJcURv6wlOa1Tfpo5pF1Umf7DOanYfKEkzSwoZf0JoSGExyk4D5ntHAqFPHlf
 dm+O7vxvlVAl1d2fs/BpVV+Q+reL3NCpo9yuzdzw0ayp1EwEm761Jes5qbubhW+c3j3O
 sVz89hhI3LJ/syspzJauhp8g1DIQkOs+Uao5MYJZ/Ex4PNKVBCwVIqOC+ZeNvTwgKpxY
 yW6X207NBQUsyAgjYABvfHJfJKvcYvlK6es65akW9YqOQD0zJojVKyqivdhsQCmEMZ/P
 PCRZKj2yOIX93gk5hjxcm1LbRbgwzmaTDujqH7/gsMePEnMpNF2fsXIUve1rFixtX3Ul
 QxOw==
X-Forwarded-Encrypted: i=1;
 AKwUvByp1WWNYB8DTC3nRwYDJtuuRyB21qPtu4v3oisdt7GbhtGb1gJtL0xdmcm4hf4JE8erVzeUBfSprWY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lr2CWJMSUhlRAbasHA2Ljc54lbRDsmxE/uhsqJCd1HlFZpySS1
 RF2RVOnSFd+ysbDvhv46bYv333TYRPIqH4GhwBgxq6xpuEX1R+/W4GwqkmUwdD01HcZLZdDBLkI
 rH4tmh/08TM+6nbfjYoHYN2t1iNny0PfQOeEwdHoL
X-Gm-Gg: AYBFou2HmlIB/4DFg75DvskYJuZQJZt0fOx+DvYhoOALXFYtOv7Qt7NaA8sB1LQYFd8
 PXgVEqY3J6dj4eXM4wglFXvYzo4LxTJQQ1jpOQ6fJLS6lEKMpEWVSuzMbBZc3mCoNNT8oMY1a8a
 scmekAMnY8xV0CKzYkqxAGWBT1Liuy1BUYfZdHdJHaeb8/hEc/l2Lzw/u+Xzq71rwDIKZrE2CLC
 /VhgmrIiT+g0siXx7JO6A//YGoeF5dXoRLry0419A48mrrSdw1b1Fv5o0frhbyYTTI1LMxkpBmX
 09FFCt1UBu9fnV1xM3Nwra6EP0rF3LtB5Qqx8gUdAZUSGPTeHxy227YwjX4h3mOO7cZLZC8qhtf
 HesJi5MQX
X-Received: by 2002:a05:690e:1181:b0:66e:54a0:cdd3 with SMTP id
 956f58d0204a3-6717724501emr313133d50.42.1789645371777; Thu, 17 Sep 2026
 04:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260916033327.3054126-1-wenst@chromium.org>
 <6d21e808d343283264665ec16d297317000fdf4d.camel@icenowy.me>
In-Reply-To: <6d21e808d343283264665ec16d297317000fdf4d.camel@icenowy.me>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 17 Sep 2026 19:42:39 +0800
X-Gm-Features: AcwNN1UiSWBQWxLfTBKkSaF0uFiyhB3L4EIUoSHVNJlTekBmF6uuJ4F5EBEDj-E
Message-ID: <CAGXv+5FHiW8umZ=wLLb5wK5Qz3hf-mbxC_zH5v+pwxxyUNTwew@mail.gmail.com>
Subject: Re: [PATCH RFT v2 0/5] drm: Add and use
 drm_fb_dma_get_gem_clipped_addr() helper
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 17, 2026 at 7:16=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> =E5=9C=A8 2026-09-16=E4=B8=89=E7=9A=84 11:33 +0800=EF=BC=8CChen-Yu Tsai=
=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >
> > This is v2 of my drm_fb_dma_get_gem_clipped_addr() series.
> >
> > Changes since v1:
> > - Add and use new drm_framebuffer_get_block_offset() helper (Thomas)
> >
> >
> > This series adds a helper to retrieve the buffer starting address of
> > a
> > "clipped" framebuffer. This contrasts with drm_fb_dma_get_gem_addr(),
> > which gives the address of the full buffer.
>
> Should vs_fb_get_dma_addr() in verisilicon/vs_plane.c be replaced with
> this helper too?
>
> I implemented manual framebuffer offset addition here.

Didn't I replace vs_fb_get_dma_addr() with drm_fb_dma_get_gem_addr()
already? At the time only primary and cursor planes were supported by
the driver. The primary plane can't be clipped, and the cursor plane
had some custom clipping, but seemed to want the unclipped address.


ChenYu

> Thanks,
> Icenowy
>
> >
> > Some drivers program their hardware with clipped dimensions, so they
> > should be using the clipped buffer address as well, unless the
> > hardware
> > can advance the scanout directly. (Side note: many drivers still use
> > the non-clipped dimensions.)
> >
> > While at it, also pull out the offset calculation of
> > drm_fb_dma_get_gem_addr()
> > into a separate helper in drm_framebuffer.[ch], thereby separating
> > responsibilities.
> >
> > The sun4i driver was recently incorrectly converted to use the
> > unclipped
> > drm_fb_dma_get_gem_addr() helper. This broke offsets into subsampled
> > pixel groups, but also exposed the mismatch between the dimensions
> > used
> > vs the buffer address. Two other drivers were also touched.
> >
> >
> > Patch 1 adds a new helper to return the byte offset into a
> > framebuffer
> > for the start of the pixel block of the given pixel coordinates.
> >
> > Patch 2 adds the new helper to return the buffer address based on
> > clipped coordinates.
> >
> > Patch 3 switches the sun4i driver to the new helper, and fixes the
> > luma plane buffer address offset for subsampled YUV formats.
> >
> > Patch 4 converts the imx/dc driver to use the new helper. This fixes
> > a
> > mismatch between the programmed coordinates and the buffer address.
> >
> > Patch 5 replaces the open coded buffer address calculation in the
> > imx/dcss driver with the new helper. Existing behavior, which might
> > be
> > wrong, is preserved.
> >
> >
> > Please help test. The series is only compile tested on my end. The
> > sun4i
> > changes should revert its behavior to before the
> > drm_fb_dma_get_gem_addr()
> > was adopted. The imx/dcss changes should not have any behavioral
> > difference.
> >
> >
> > Thanks
> > ChenYu
> >
> > Chen-Yu Tsai (5):
> >   drm: Split framebuffer pixel offset calculation from
> >     drm_fb_dma_get_gem_addr()
> >   drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
> >   drm/sun4i: layers: Fix VI buffer address for clipped offsets
> >   drm/imx/dc: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
> >   drm/imx/dcss: plane: Switch to drm_fb_dma_get_gem_clipped_addr()
> >
> >  drivers/gpu/drm/drm_fb_dma_helper.c    | 61 ++++++++++++++----------
> > --
> >  drivers/gpu/drm/drm_framebuffer.c      | 45 +++++++++++++++++++
> >  drivers/gpu/drm/imx/dc/dc-plane.c      |  4 +-
> >  drivers/gpu/drm/imx/dcss/dcss-plane.c  | 34 ++++++--------
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 ++++++-
> >  include/drm/drm_fb_dma_helper.h        |  4 ++
> >  include/drm/drm_framebuffer.h          |  3 ++
> >  8 files changed, 118 insertions(+), 51 deletions(-)
