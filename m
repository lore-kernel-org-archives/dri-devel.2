Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04AFCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC3810E54D;
	Tue, 29 Sep 2026 09:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LD57Ze5l";
	dkim-atps=neutral
Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com
 [74.125.228.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A4710E54D
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:46:55 +0000 (UTC)
Received: by mail-ed2-f32.google.com with SMTP id
 4fb4d7f45d1cf-6acb8b78d6cso517344a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 02:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790675213; cv=none;
 d=google.com; s=arc-20260327;
 b=JGEsxyvWP2UYoeBVXFSxjIdiV1IPfVFx7imEYOWHnxHbk1bwo4ROTVi6F1CMabp/wc
 SwmNKRcgJY3vOaLsigIRZwLwPkKhTbeOr0ap23irjm2EnL5xAobe2066jGv8GtjNSexM
 +pbcOMxQM3sD3K/qWowp1b5MYdLPyxIu79PhQnSKUX+JOZfQEOSxopHTteC0jrVwtOkv
 ZFTEqb1AERJiHriTJktvSysL+M8Bop9b2SA1TKQPvnF0Al7Zqaor77m+q2GnKtIOZkf0
 6T4T8Zt5WWyGOvCN/VQGq8guZhMT80gUnwCAdSH+WR7B2TljOQ42XsaT2szdshjFJTHC
 ltjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+YdZLbLvyhM+9EF8BV63cOnUty6jcpMKF9WL+DE/91w=;
 fh=fELCNufw0sdYcBcwmIBqF6UWediPMRmnDL/v4ToNBWg=;
 b=AGxokn+kApn8Y+G3NKquiHkla2jJKUcxg0SSHW6W/6N44bWQjaXN/YMPR9RXNywjg3
 sWUXxRXqgjM7EsLsRICRgJITqEpVF/QGCH16BUJH3dkS8qi91mSBs/Jnfk23WcCR2YJQ
 cyxglNxVs2je/byijkH90ZsniwAgHOMLox0vPrR/XWIK3jCFTx41UDc2QCOtznixeGIm
 wHWP6f0sEtImEDmmB3IQex9Gwpsoh3gX1q4kZyfFtPgGxMou6h2g1cbkRjmpDYsYchAz
 4IN/JFjGVLnnAd4UsPTqTQiytW9F7rLrCBO4k4YpshwlF4PdhfIYl/poDemznWYGmKLA
 Dq1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790675213; x=1791280013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+YdZLbLvyhM+9EF8BV63cOnUty6jcpMKF9WL+DE/91w=;
 b=LD57Ze5lozb2fKbWhhqwbo4kSGLIesTLG50HHe/eXLloqdYDa4xFBZ1cti5Pda5mB4
 zZCZKcdAH+pL5SpB7mV170IrwTkGehiBeNRz8E7AetKjeyb+ZOWnw65isuDZMJ9zDet4
 vyQkBlRbhVBMO7kcvjcQwA0GncA1+Z2/Bi7xH8/s1XZfWfNfrlL9q5BJyhXm7ug6fk42
 wAjUoL03V9kOouELv/MvQ4TFMSYW8fGkeNd8cKSlY4xwhVnemA/4T2kLISOw9+sF3DoD
 c/5+cdEtELRXFi1I6IbjpQjkou/liXYQrACdK8AnlK1lJNGvwrh0nUXzSAm0qV2N3UI8
 duoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790675213; x=1791280013;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+YdZLbLvyhM+9EF8BV63cOnUty6jcpMKF9WL+DE/91w=;
 b=XO+KgnY8J6O4p8avxc2oyyoAfK/3wb7fuSzBFi9dlQSCzlI+Iz9ctSICycVUo3whZd
 bvIx5rxabDSdC58jckOuqi+ZC9hz7eGdRDrKRCAsHIRa0J8Ee/tjTC/ycLGlszTXI4Mv
 Yi8Z1FC+n1a3CEQ2LPTTMxqkOJb75lUYADrMXctXblgCLfDajg+mfyzT2uEJujX6EUi1
 hMDntoM4nmeBz1nzm1+IA2TILGYBvAm9pZny9k9P2L4wKRGiyLTCbsPKOrRfS87iNwG9
 qQu8sVK4dAalzw15w7L6E1O4R4chq3k/BVKZOjXQ1IlfbPBw5ArecXLpQbbFKECslORm
 QuQw==
X-Forwarded-Encrypted: i=1;
 AKwUvByzaBB+uYMk+bz9Rk3EqbTxNss9tIISdexrv+iABQdspCoGBAMKxfztb/CwZaPnAu0bmfu/pFXicv0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJDqvJ9WOraJn/oXTi+Fy0u7JV4EylfNhsw7D5tt1pMF3zomzGZ
 V1RjyfZq0vxabmscTvKArJVUxug15I41uMGO3tLPPKP5BHks7NrOsvI+tiH1TMkdzXYzZcljqaL
 MPgjwffbWcR39JszTdA0026nMHOhkuP0=
X-Gm-Gg: AYBFou0GaLoLsBO4JsJ84iXP0rplXD8C1zqXok+UZT8qZpkn3ZiYgGwq96A1DZp49bu
 ZeRJZc8fUikuJ6dn4H7iqUcv3drmcX8S13HPzHYrpgSkhMhP8ERfo9WS3a9ilB07O4OQYwOJj+z
 A6tH1cEhbrwJEC9qR3ZVaPV5mjXSlZlesWrINqHTK4VNz9MgG4x5IY6RoKwKUk+8/UxIyI4LwTH
 A5WP08zs5YahPxV9j1KsOVi7MvxM7Iww6Iw6cTjbhVk8F/aa+7FZehe1gSoM/Lk9sr+SzUPh+xL
 TqNz3HBJVVFEvreLyJo0AZqIag2xHIX8EkezClcS7C9kIMhkZiCir+w=
X-Received: by 2002:a05:6402:1d55:b0:6aa:7fb:7678 with SMTP id
 4fb4d7f45d1cf-6aae8a518b4mr8630052a12.6.1790675213345; Tue, 29 Sep 2026
 02:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de>
 <CAEUXW=G2a=Qz-9P_2+EFe-GiW4WqdOjtSCxoO4P15u_J48nP9g@mail.gmail.com>
 <arbLHvCBqxG7zcf_@bywater>
In-Reply-To: <arbLHvCBqxG7zcf_@bywater>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Tue, 29 Sep 2026 13:46:36 +0200
X-Gm-Features: AclHuK_DOhKuESbFIkSM5tBxWuDkjgIy9D1hy5UWjYEzpHDFJ0AUXPBUH8LKOSA
Message-ID: <CAEUXW=ELS1OCyDdy5Gx41g8twU5B8112gMct9uFqhdGVveRKMw@mail.gmail.com>
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

Hi Francesco,

> v4 is planned but has been preempted by other activities - I am not able
> to give you an ETA at the moment. If you have capacity, feel free to
> take over.

Thanks, I appreciate it. Since it is your series, I would like to run
past you what I would change before taking it on.

The v4 would still be an RFC, based on drm-misc-next. Your patches keep
your authorship, with any fix to them folded in and noted in the commit
message.

Fixes to what is in v3:

  - the BGRT symbols exported, as in your patch for Mario, but with
    EXPORT_SYMBOL_GPL;
  - drm_splash_init_client() indexes modeset_mask by the number of
    modesets added in the first loop and by the number walked in the
    second, so an output without a mode ahead of a connected one gets
    the buffer instead;
  - for a tiled group, the first loop dereferences tiled->buffer before
    any buffer exists, and the width and height look swapped;
  - if the BMP firmware never arrives, the callback returns without
    waking the render thread, which is left in TASK_UNINTERRUPTIBLE for
    good;
  - the 24 bit blitters read each pixel as an unaligned u32, one byte
    past the image when the rows have no padding;
  - the image cleanup always calls memunmap(), which will need to know
    where the image came from once there is a third source;
  - the spaces in DRM_CLIENT_DEFAULT, in a patch of its own.

The modeset, tiling and render thread ones come from reading the code,
so I will reproduce them in qemu first. Tiling I cannot test at all.

Additions:

  - a device tree image source: a node under /chosen with the BMP either
    in the node itself (dtc's /incbin/) or in a reserved memory region,
    mapped with the same memremap() as the BGRT;
  - placement from that node, a position with -1 centring an axis plus
    an offset, instead of always centring;
  - rotation, for the DT image and for BGRT images with the orientation
    bits set, which are skipped today;
  - the background colour coming from the same place as the image: the
    DT node can carry its own, splash_color goes with splash_bmp, and
    the Kconfig colour stays the default for everything else, BGRT
    included.

The sources would be tried in the order DT, BGRT, BMP firmware, and
then just the colour. A DT node is only there if someone put it there
for that board, so it seemed right to let it win.

Does that match what you had in mind? And how would you like to appear
in MAINTAINERS, as a maintainer next to me or as a reviewer?

If you are happy with it, I'll take you up on your offer.

M=C3=A0xim

El vie, 25 sept 2026 a las 21:32, Francesco Valla
(<francesco@valla.it>) escribi=C3=B3:
>
> Hi M=C3=A0xim,
>
> On Fri, Sep 25, 2026 at 10:48:31AM +0200, M=C3=A0xim Pedraza Padilla wrot=
e:
> > Hi Thomas,
> >
> > > the whole Linux logo on the console is somewhat gimmicky and IMHO sho=
uld
> > > not be further extended. Also fbdev as a whole has realistically run =
its
> > > course. We fix bugs and occasionally clean up the code, but it is
> > > questionable whether new feature make much sense. Even more so as the
> > > drivers your system uses appear to be DRM ones.
> >
> > They are, it is tilcdc. Understood, I will drop the fbdev side, which
> > also settles your comment on patch 1.
> >
> > > There is a proposal for a DRM splash screen at [1]. It retrieves the
> > > device vendor's logo from the firmware and displays it at the given
> > > coordinates. IMHO you should start with this series and add DT suppor=
t
> > > there.
> >
> > Agreed. I have been following Francesco's series since Sam pointed me
> > at it, and it is where the DRM follow-up I mentioned in the cover lette=
r
> > belongs, rather than in a client of my own.
> >
> > A device tree source fits next to the BGRT one. The BGRT is the firmwar=
e
> > handing the kernel an image and where to put it, and a DT system has no
> > such table. The BMP loaded as firmware only helps if the file is built
> > into the kernel, or if a filesystem is already there when the display
> > comes up. With U-Boot's Falcon mode, the device tree is the only thing
> > that reaches the kernel.
> >
> > So the plan would be a node under /chosen carrying a BMP, either in the
> > node itself or in a reserved memory region the bootloader loaded it
> > into, with the placement properties from this series. The region is the
> > same memremap() the BGRT source already does, only with the address
> > coming from the device tree.
> >
> > Rotation too: the client skips a BGRT image with the orientation bits
> > set today, and it could turn it instead. I will ask Rob separately how
> > he wants the image described, since that is what the binding hinges on.
> >
> > Francesco, is a v4 on the way? Would you take a DT source as patches on
> > top of your series, or would you rather I wait until it lands?
> >
>
> v4 is planned but has been preempted by other activities - I am not able
> to give you an ETA at the moment. If you have capacity, feel free to
> take over.
>
> > Max
> >
>
> Regards,
> Francesco
>
