Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24E606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpovA+AD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8F110E13E;
	Sat, 21 Nov 2026 06:03:51 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C74310E114
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 06:03:44 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-38564b4b017so1613280eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 22:03:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795241024; cv=none;
 d=google.com; s=arc-20260327;
 b=WmgjXE5yPODibLSYRUXDvUsCtI5xpk4br5ZuyflHM2f7oEv+6OMimyapVlmebvXNpi
 CFwWvdMflhurPnLMaJlujIoAKQMID+UDZTtz79ZWIZynmnN3mjaC0kUw8Xcoyj3kyzOC
 3xVHXu/6XNSZxGZQEsPxy5tbYxS9zRsjVx7RaIy0aW/sJhQn3rkgCUR4OBF0XsKTJmIt
 Vx+drd0j+LFZop8rUOxZDXpXdIGWd/EkBIRu7Vr9KLA7i88pBjW4oXIHMgkkWMX6lPwP
 jLxEcoKkO/KhpQe8a0lFe9z/aOi+fn8PPGqu5Mw4yIzCLA7pTnmlXynMPCYivu0Osgoo
 p0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lkIcDSC/bFxcu22I88GO2krkZZKs2yf41B/Zw2+/nk0=;
 fh=fJu42mwQfpLzrxC6QiDWQH2tR0ps8UuyF0ibITkjyCw=;
 b=C8JX+rrdxr2WKiOhulqLF0BBLHxkRtZmQXgqhlDzUKoNyreNTFK/0X2baqAApXkSOR
 sW7h/2tvulYdCLbLrf00cY9rI4kWn3ea5aOCjO8XJXMQXw5YFu5EIVT1aQIels9Neawr
 znlDxH60mgXnvJ6ybdBrCjmM4kEhT20nic/d+vG/pQYYqnj+dWSakgz7kzLYtCBk/JOc
 LmCwRj3Xu3DnNmvYj2942bggHLHcuqR4Z39OBRr/RN72VTFqfQ9AlMX2krxAsjc17y+h
 BPZAcl/fbxkPUbMxpXEeq3sRimoDVRmQSHDpeK+MJeAIt5EpAt6rWUD0CrEGWQzI1zjk
 PIMA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795241024; x=1795845824; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lkIcDSC/bFxcu22I88GO2krkZZKs2yf41B/Zw2+/nk0=;
 b=kpovA+AD5Ac/y2pYR/0ozuYsgnYm4TTHTaKzFr7mUJ27MhndsqXAmV2u4C+JlmILZZ
 F7ONfKN5cqphX7v6gcKL/nm37kxMjaO5PSoCVGbduGXVISBls9r/IA9U9ZQ7s5yyZg84
 KiuzJzCscr6ukrRQS8CMBR7kuHpFjHPxjtECHmlFgl8MTsdYF3AidrsyyamN0tBNMt+u
 /Mc/uiMRyolUIYrTZPprKWi72oBeBpjw5J76hJkZFD4rEDDS8OmnShj6cN44QZe/vz8B
 1w7RrYD0p3UYfbsRy8NfkkDpK7KonR6Cpz6sYBMfshtGyGecLFhyl3IJDvghX40g+sZS
 MhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795241024; x=1795845824;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lkIcDSC/bFxcu22I88GO2krkZZKs2yf41B/Zw2+/nk0=;
 b=eOhyqQOG9d8sKVNtf09T1OKSuYxCjEUgW8OaCXydRZgeomKNEolAPH35kVb0JOUvWe
 IMoJ2R8ng8nJYs+rU8H+WbnwbxypOvPWfkxR1WR5k6cs/y7Ga3W7h5hmJSp7aIXEb3Fx
 XISOt/zpqPB7N0iGl/VXpyDEkHvYNdT5h1tCaujTrzLoIyZkvXEmC4rHEb/SCeaENKOe
 EB+AG6vV3k+BjV4eDDtvPjK2fXJycI06ntRtdWnOL+A5tlC7+iKexzIDCZrPUpnOgOOp
 3lgONT9DuKE/Jq7Dqbsy5eHZlR4TEHBCiiOQP25B5sUMm+senxTyMK8N+5IEgwtWx2/u
 NiKg==
X-Forwarded-Encrypted: i=1;
 AL+hErHlMGsAC1Yc7m8tQRTX65B+dr03iGkQ7OxuPfDwbqImV5M56YmbUb+s+pOoRHv+Eum5C0W4LH+ne1c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8YAv6lzc4fMol7WwrnoMg0sp0D+KUTSTYjBb9y1SU4Gew3escC
 E0WPoWxOI9BE318zGmyjXp75Z3HrNrpTC6e0XeDOZcLgDhsJM1GriJYjTy+3za22ie51Ul6ftn4
 ML0YhiCR+5VGpMhMGmn0oKMa0e3drNUg=
X-Gm-Gg: AZFdTZd6OpA9srO/IWB2LAuEU2bKcj+gH7KPl3JnZe4yre/73swsmKtNYCisk7AWrJW
 dihqHQEaHWnmpOZ6T6fktLcQGgy6aNJd9QNYXdROK977jqiHC4hvOvWMM3qgK5nFE+40roMLBGb
 bbcyrJXLbMVvFopXuDIKLMQxtMMfwZIn3Rb8UoRZQOKmUI7nCDXVCBWpQkvkOLrk0bH/7xA1WlP
 77az8wXFvEnxqwy3Fq9mo8l8ujHPw5drqShj2vMS8EfdFb8vaai2i9daAPq1st/ZYnARNC+mpRn
 zl5AD/siLmB/ngq6Bi7Keg3k4iDn2Mm1buP18ov5FhE8NwZcgY15i+g8vhrQP675f83Q4NhAe8P
 CWQ+XeUcj/exHIdWl3cZiDpzOhuVEoZNuvdDYJkJ1RVzFe/Rum3rBv1Ke7aJ/XEiSoazvv4ktJz
 GB3siF72qIVqFus/4nL9RrPDjFVMW1qA==
X-Received: by 2002:a05:7300:e9c4:20b0:383:6f73:eb34 with SMTP id
 5a478bee46e88-3856c6b00fdmr6323139eec.2.1795241023623; Fri, 20 Nov 2026
 22:03:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-2-clamor95@gmail.com>
 <20261120143147.GA2466366@killaraus.ideasonboard.com>
 <CAPVz0n3u3oe1+H_w9jE2afb9PQT0VLtYVqfHeVNc3D+tLN6NDQ@mail.gmail.com>
 <20261120213116.GB2472094@killaraus.ideasonboard.com>
In-Reply-To: <20261120213116.GB2472094@killaraus.ideasonboard.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 21 Nov 2026 08:03:31 +0200
X-Gm-Features: Aa3M54qOnB5G9GXqLIL-lPBYx8eezPpq659tGJ_BSKM-GqCEY4niHx2BKUlkMTw
Message-ID: <CAPVz0n0h6xd4DbnpNTW63agospeJFqoV8vnkPYdzB3NmgVRM5Q@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] staging: media: tegra-video: Move driver to
 media/platform/nvidia
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>, Dan Carpenter <error27@gmail.com>, 
 Hungyu Lin <dennylin0707@gmail.com>, Hao-Qun Huang <alvinhuang0603@gmail.com>, 
 Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 20 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 23:3=
1 Laurent Pinchart
<laurent.pinchart@ideasonboard.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Nov 20, 2026 at 05:31:17PM +0200, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 20 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
16:31 Laurent Pinchart =D0=BF=D0=B8=D1=88=D0=B5:
> > > On Fri, Nov 13, 2026 at 06:18:10PM +0200, Svyatoslav Ryhel wrote:
> > > > The Tegra Video Input drivers are mature and developed enough to be=
 moved
> > > > from staging into the media subsystem. No other changes are introdu=
ced.
> > >
> > > The driver should at least be converted to be MC-centric before being
> > > moved out of staging. I haven't checked if other changes would also b=
e
> > > needed.
> >
> > Does the media subsystem deny video-centric devices from even being
> > moved into it? I have not seen this restriction imposed; could you
> > please point me to where this is stated in the media subsystem
> > documentation?
>
> There's a consensus that devices that require control of camera sensors
> (i.e. "MIPI" cameras) must be MC-centric. That's not documented, we
> should probably fix that.
>

Yeah, stating this in documentation would simplify things.

> > I would like to convert this device, but that may take quite some time
> > and may case regressions if not done carefully. This patchset apart
> > from moving to media is mostly fixes to work correctly with mt9m114
> > and tegra114 bring-up which is quite simple and straight forward
> > change.
>
> Converting to the MC API will require some changes in userspace. That's
> why it's important to make this change before destaging the driver.
>

Noted, I will most likely drop destaging for now then.

> > BTW, may you ack mt9m114 get_fwnode_pad change[1]. I have updated it
> > to your liking, Sakari seems to ignore it.
> >
> > [1] - https://lore.kernel.org/lkml/20261006153619.304520-1-clamor95@gma=
il.com/
>
> In the review of v1, I wrote in my last message
> (https://lore.kernel.org/linux-media/20260721103845.GJ50424@killaraus.ide=
asonboard.com/)
> that the issue seems to come from a bug in the VI driver. Let's continue
> the discussion there.
>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/media/platform/nvidia/Kconfig                           | =
2 ++
> > > >  drivers/media/platform/nvidia/Makefile                          | =
1 +
> > > >  .../media =3D> media/platform/nvidia}/tegra-video/Kconfig         =
| 0
> > > >  .../media =3D> media/platform/nvidia}/tegra-video/Makefile        =
| 0
> > > >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/TODO   =
| 0
> > > >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/csi.c  =
| 0
> > > >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/csi.h  =
| 0
> > > >  .../media =3D> media/platform/nvidia}/tegra-video/tegra20.c       =
| 0
> > > >  .../media =3D> media/platform/nvidia}/tegra-video/tegra210.c      =
| 0
> > > >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/vi.c   =
| 0
> > > >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/vi.h   =
| 0
> > > >  .../media =3D> media/platform/nvidia}/tegra-video/video.c         =
| 0
> > > >  .../media =3D> media/platform/nvidia}/tegra-video/video.h         =
| 0
> > > >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/vip.c  =
| 0
> > > >  .../{staging/media =3D> media/platform/nvidia}/tegra-video/vip.h  =
| 0
> > > >  drivers/staging/media/Kconfig                                   | =
2 --
> > > >  drivers/staging/media/Makefile                                  | =
1 -
> > > >  17 files changed, 3 insertions(+), 3 deletions(-)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/Kconfig (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/Makefile (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/TODO (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/csi.c (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/csi.h (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/tegra20.c (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/tegra210.c (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/vi.c (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/vi.h (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/video.c (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/video.h (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/vip.c (100%)
> > > >  rename drivers/{staging/media =3D> media/platform/nvidia}/tegra-vi=
deo/vip.h (100%)
> > >
> > > --
> > > Regards,
> > >
> > > Laurent Pinchart
>
> --
> Regards,
>
> Laurent Pinchart
