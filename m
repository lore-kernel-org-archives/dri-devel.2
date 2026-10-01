Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C580FCA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 20:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0584F10E060;
	Thu,  1 Oct 2026 20:17:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XdnSGe/8";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7348C10E060
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 20:17:46 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-97e7c72bfe9so2061396241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 13:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790885865; cv=none;
 d=google.com; s=arc-20260327;
 b=fuhSw/CsEHxDKgojKH6a8uLpJ32kHX55UnXiMAZNwjBiXIZl7L+JX1saUhlhAU8iX2
 BDy36lGptQv876CFuyZoQ86ZuOBv/eqDeRLGHSmbfN3X3CKEkkW8M4mkD2w1OJ8UviIe
 vtP1mXszCDzJKFHWxtGxAdY7vrbHDsk6++szimt/BA3y6J3PXBqeA3vo12uw/4GLK2es
 WKdCJ7C9jkW9i+ngts9uwxiejTtKGeNE3h+mbS5N0fJwagLPp6LSJ8/74aVA8KkExm9M
 H1cMlN1me+gI9q7BFim2sk7+NKwuQkDHDY6G8/IO8flsLrzImLijeiozpsDj+D0gOBYP
 1WfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6tkKgICqIcJIGkBovWHK92OXP6OvdcQ+ysdZiv7iOmM=;
 fh=DrRJcPjMhA0qkVrVbMDxsUdDfgmkfxOOqpRrYF1KQNs=;
 b=dFwS3m2miTDibsbba0Eueh1H3OFOd4pTMCO2UcHOiNuGpmv0ggJJL/b0WYq48ziBnu
 T9BB95E2+6KV0dof5005h4wf8iqqkczaADW+9LzkHIjtT1kYqUDTGcKJ+0koKv6V6eQ8
 +SR8r1+fXwjn2Tu/3slxzwhay5WtZm9lfLgMpkC27FIbE18hJnCbNBWKG0x3Vpyx6Mjc
 i47GCLQs9VIQ1pH6P63YKHoa47SbjR4R3etvFNrkGI3JIlwW2vDQsPhRHDjg+YJlHUEl
 iDKWc01VgS+aKieOV2HxHNbyolQt2YlDwQJRvCZoKJLaOQU0TjuVpOzJZbr8fOGho2Hs
 K/7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790885865; x=1791490665; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6tkKgICqIcJIGkBovWHK92OXP6OvdcQ+ysdZiv7iOmM=;
 b=XdnSGe/8CcZIQnKMlIl5P1kMLZFgc88STp7ZzEZXmQkyQVUd827YbZISQqMrMZtvmM
 PSfb0n6trPCL1pUPG40YqwB337hyks5a/58bJx1d17XMyMd31URBGoXIxL/It50v7doq
 2ycPOG7OiChjYO/vgUailgdcDvKr9ZLTdnGYzW7kxniAxx1hEclC28+v2GliT/2HwOLB
 LjCMpWGtj+PBQZ13ZKiKl1IoGi8sYL+NcByu3qj23tnkQA5zdi67miMiIzXak71mHbN1
 0I+TNOZQ/nSxfJDXpFry072EVCaPuHJhtxSHeX6hSmS/G8eSoN6wnr2WBpc3KYdW6gbn
 DwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790885865; x=1791490665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6tkKgICqIcJIGkBovWHK92OXP6OvdcQ+ysdZiv7iOmM=;
 b=yiJq0a1Ac+hj0r073FCg74WLgMdeZJiBDNTAP5GH8ZUuqMuieSDM9GNKCLw/JpM89K
 H39KN55+mLVdaCzHrK5KIXzvQdG/dM4uojJqg2vrvOwlNJfGf027Y4Pb2KXmqo8H6bt/
 EAKleOHPeULDH5dZsFZU3TPAKpKXNyfImHvDb1nF/bY2pxMWTediPzmeLnKxYFCqRz/F
 v7A/MeUR/oYFChnEKEnetr9J0p0MI+F9r/5rB0cnUEsiG7ScVbyDxamK3h14bYME3oMN
 eOrfEkvLbTB++dgrtGiASgFkJtCI95rn5F7Sexig3qV0rmDIiVHjKYKPTb6e8y0UWp3m
 HbBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwztfxuu12IskjajfFiIWHP6LG8pZ/LT7+6ytf01pOzmZ8z+miBBnRak+W6TppKsBoARuLTxT6vxag=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJKM2nC22QG+CwiiPNGZ8TWuDwHDaUd+Nasr9k6v3gEBz5ijlrG
 TWEX7ra7ZFGvYfvkxaFa9njSAeWqXwQfhYTSyRm5XJlXZa5rRY6WAM3CjDeSIBUd8eP0OyUpX4k
 f7+PxqDhv9MiqDRT5aKfLSQfmNVTvGMI=
X-Gm-Gg: AYBFou0HONShrmmdrBAlTC/84w+Gjg/3osKVdtioSqlWdCnasdNgHb1zw3WGjJuJ/Om
 i3Xwp7uXan1vkMeLp+d6rLvsUvOLCJ3DPiOZkNt/DCfnEPl0o95eaBwsYR0S7WA4HX3ajRbOEPC
 MSKZfTKMkHZE10E6BHLIpWsMNuqSaVhOFXRScDUEcHTXUr0dyJ/x6A8kVriaqyHP2uZQFoFLg4j
 eSyXaBD/TIxJhTF/XjebCpKdtzI3LWs0B7QLN0/LYsXlKb3jYqxMdEV7bG1B2Z3PZM9Dvabptgp
 c6mLhD3HRHcP5428tZdu+EZd6+r+3PwfavY5aw5rBLCCuxg7OWnFGOt9vktwlJzIMg==
X-Received: by 2002:a05:6102:688f:b0:7a7:198a:c2c1 with SMTP id
 ada2fe7eead31-7c0f58ae607mr132715137.31.1790885864968; Thu, 01 Oct 2026
 13:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de>
 <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
 <arbLHvCBqxG7zcf_@bywater>
 <CAEUXW=ELS1OCyDdy5Gx41g8twU5B8112gMct9uFqhdGVveRKMw@mail.gmail.com>
 <aryqYhHqFk3cXh9d@bywater>
In-Reply-To: <aryqYhHqFk3cXh9d@bywater>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Thu, 1 Oct 2026 22:17:31 +0200
X-Gm-Features: AclHuK_TJb3OzJ-b3Pi60bWWkDOOeJUZPt1GI9wR3Q6RdrK3y1nqllSCTtDORV8
Message-ID: <CAEUXW=G-iz7R=c=9pZS0vygX6YVJ1suFpAhyyjXb5KzUJGtwkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Boot logo supplied by the device tree
To: Francesco Valla <francesco@valla.it>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
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

Hi,

This series is superseded by RFC v4 of the DRM splash client, which
adds the device tree support there, as Thomas suggested:

https://lore.kernel.org/all/20261001195847.141192-1-maximpedraza@gmail.com/

The node placement and the reserved memory region carried over; the
clut224 format and the ppmtodtlogo tool did not, as the client takes
BMP images. Helge, please drop this one.

Thanks to everyone who reviewed it.

M=C3=A0xim


El mi=C3=A9, 30 sept 2026 a las 8:32, Francesco Valla
(<francesco@valla.it>) escribi=C3=B3:
>
> Hi M=C3=A0xim,
>
> On Tue, Sep 29, 2026 at 01:46:36PM +0200, M=C3=A0xim Pedraza Padilla wrot=
e:
> > Hi Francesco,
> >
> > > v4 is planned but has been preempted by other activities - I am not a=
ble
> > > to give you an ETA at the moment. If you have capacity, feel free to
> > > take over.
> >
> > Thanks, I appreciate it. Since it is your series, I would like to run
> > past you what I would change before taking it on.
> >
> > The v4 would still be an RFC, based on drm-misc-next. Your patches keep
> > your authorship, with any fix to them folded in and noted in the commit
> > message.
> >
> > Fixes to what is in v3:
> >
> >   - the BGRT symbols exported, as in your patch for Mario, but with
> >     EXPORT_SYMBOL_GPL;
> >   - drm_splash_init_client() indexes modeset_mask by the number of
> >     modesets added in the first loop and by the number walked in the
> >     second, so an output without a mode ahead of a connected one gets
> >     the buffer instead;
> >   - for a tiled group, the first loop dereferences tiled->buffer before
> >     any buffer exists, and the width and height look swapped;
> >   - if the BMP firmware never arrives, the callback returns without
> >     waking the render thread, which is left in TASK_UNINTERRUPTIBLE for
> >     good;
> >   - the 24 bit blitters read each pixel as an unaligned u32, one byte
> >     past the image when the rows have no padding;
> >   - the image cleanup always calls memunmap(), which will need to know
> >     where the image came from once there is a third source;
> >   - the spaces in DRM_CLIENT_DEFAULT, in a patch of its own.
> >
>
> I suggest you also take at look at the review sashiko did for the V3
> [1], as it contains some good suggestions (some of them are already
> present in your list).
>
> > The modeset, tiling and render thread ones come from reading the code,
> > so I will reproduce them in qemu first. Tiling I cannot test at all.
> >
>
> I did not test tiling as well - I think it's a mode limited to some
> Intel cards?
>
> > Additions:
> >
> >   - a device tree image source: a node under /chosen with the BMP eithe=
r
> >     in the node itself (dtc's /incbin/) or in a reserved memory region,
> >     mapped with the same memremap() as the BGRT;
>
> A reserved memory region is (probably) a better idea, to allow change
> the splash without recompiling the devicetree.
>
> A possible usecase would be:
>
>  - bootloader reads the BMP image from a dedicated partition and loads
>    it to the reserved memory (very much like the BGRT path);
>  - splash client parses the devicetree, finds the memory region and
>    loads the image from there;
>  - userspace updates the dedicated partition with a different image.
>
> >   - placement from that node, a position with -1 centring an axis plus
> >     an offset, instead of always centring;
> >   - rotation, for the DT image and for BGRT images with the orientation
> >     bits set, which are skipped today;
> >   - the background colour coming from the same place as the image: the
> >     DT node can carry its own, splash_color goes with splash_bmp, and
> >     the Kconfig colour stays the default for everything else, BGRT
> >     included.
> >
> > The sources would be tried in the order DT, BGRT, BMP firmware, and
> > then just the colour. A DT node is only there if someone put it there
> > for that board, so it seemed right to let it win.
> >
> > Does that match what you had in mind? And how would you like to appear
> > in MAINTAINERS, as a maintainer next to me or as a reviewer?
> >
>
> Yes, please, either as a co-maintainer or as a reviewer, as you see fit.
>
> > If you are happy with it, I'll take you up on your offer.
> >
>
> Thank you for continuing the effort on this - I still believe it's
> useful, but currently is not fitting inside my schedule.
>
> > M=C3=A0xim
> >
>
> Regards,
> Francesco
>
>
> [1] https://sashiko.dev/#/patchset/20260510-drm_client_splash-v3-0-a9aee9=
f0b2fc%40valla.it
>
> > El vie, 25 sept 2026 a las 21:32, Francesco Valla
> > (<francesco@valla.it>) escribi=C3=B3:
> > >
> > > Hi M=C3=A0xim,
> > >
> > > On Fri, Sep 25, 2026 at 10:48:31AM +0200, M=C3=A0xim Pedraza Padilla =
wrote:
> > > > Hi Thomas,
> > > >
> > > > > the whole Linux logo on the console is somewhat gimmicky and IMHO=
 should
> > > > > not be further extended. Also fbdev as a whole has realistically =
run its
> > > > > course. We fix bugs and occasionally clean up the code, but it is
> > > > > questionable whether new feature make much sense. Even more so as=
 the
> > > > > drivers your system uses appear to be DRM ones.
> > > >
> > > > They are, it is tilcdc. Understood, I will drop the fbdev side, whi=
ch
> > > > also settles your comment on patch 1.
> > > >
> > > > > There is a proposal for a DRM splash screen at [1]. It retrieves =
the
> > > > > device vendor's logo from the firmware and displays it at the giv=
en
> > > > > coordinates. IMHO you should start with this series and add DT su=
pport
> > > > > there.
> > > >
> > > > Agreed. I have been following Francesco's series since Sam pointed =
me
> > > > at it, and it is where the DRM follow-up I mentioned in the cover l=
etter
> > > > belongs, rather than in a client of my own.
> > > >
> > > > A device tree source fits next to the BGRT one. The BGRT is the fir=
mware
> > > > handing the kernel an image and where to put it, and a DT system ha=
s no
> > > > such table. The BMP loaded as firmware only helps if the file is bu=
ilt
> > > > into the kernel, or if a filesystem is already there when the displ=
ay
> > > > comes up. With U-Boot's Falcon mode, the device tree is the only th=
ing
> > > > that reaches the kernel.
> > > >
> > > > So the plan would be a node under /chosen carrying a BMP, either in=
 the
> > > > node itself or in a reserved memory region the bootloader loaded it
> > > > into, with the placement properties from this series. The region is=
 the
> > > > same memremap() the BGRT source already does, only with the address
> > > > coming from the device tree.
> > > >
> > > > Rotation too: the client skips a BGRT image with the orientation bi=
ts
> > > > set today, and it could turn it instead. I will ask Rob separately =
how
> > > > he wants the image described, since that is what the binding hinges=
 on.
> > > >
> > > > Francesco, is a v4 on the way? Would you take a DT source as patche=
s on
> > > > top of your series, or would you rather I wait until it lands?
> > > >
> > >
> > > v4 is planned but has been preempted by other activities - I am not a=
ble
> > > to give you an ETA at the moment. If you have capacity, feel free to
> > > take over.
> > >
> > > > Max
> > > >
> > >
> > > Regards,
> > > Francesco
> > >
