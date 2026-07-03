Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EA2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABEE10E0FA;
	Fri,  3 Jul 2026 09:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="sYM9M8id";
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88A910E0FA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 09:19:50 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-6a1840edbabso585082eaf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 02:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783070390; cv=none;
 d=google.com; s=arc-20260327;
 b=C4Io+OZTFJISniH9lsBkw7MQXSTN8fp6c+pj/ctHAZxYxSU3JeCJnMZgx1AHmQ38i4
 RwhvW6xCACgzPvuheXh0GdWEsbj/H03fI651S+V1qcbZBeMbq2eSWAUxP0uIfnXreGT7
 JmdQ3VVplqKJdZ9W2tZp09J0vB4FC9mqRYst1TeNerx/u8eRJEwyQ2U1qtNYnE1etVHo
 F3Bs7esY6VsgJB333OMBKzdFA9XRX8wSFlMhLCzkFHOAOSYN9XignXqReBtU/wrgHNAD
 EhSnDWx5Q6CXErgkRFLBhegAmJMqVbntbO3BhyP/fxesNmWKPT4aj74667OzDQXe0XLf
 fiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=daVxj2QmJFSiDanODqC5cOrBNGVj6v9uZQgD03LLDR0=;
 fh=JW95OC82g6DUMl1TX1K6PLI7WRM5ljOS5tfY7wEjlyQ=;
 b=mL1Ze0+Y9lTqrhae01/UW83OLF8CRGTfocAa6v2Fe0u4rStns7aG58Hhg68nY5r2b7
 aattBhYDeITvo6JHkvVSRHKcnnk10CYFMJnHGSVxdgf7woltyIxWThu+YC5UMs4VkbQK
 N3XiLWcOh2DNOHMRFyMaESfDevh5RfRHwpPpGHrZNfQJZofrAO7BvbyD7QiLZnkcKKMz
 2WORn4i0MC6an8UDKwCQrAvbGNQqU1o31CEKran3QktmF/S8iiGsQ0xvpgLvPfSsGP0f
 8vWJTFnzoRjLq4Ip5SmjN3csDOQB8pYy74mNlsxrO6FFWVAs5HiwLNaJbCiJojm3nd7s
 Vm0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783070390; x=1783675190;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=daVxj2QmJFSiDanODqC5cOrBNGVj6v9uZQgD03LLDR0=;
 b=sYM9M8id2CRMYD45gHOI3A6yvak1CoHaaT0piFPYYGVlwv6W78DMzlwAE17x4yb4m4
 /vqOgttVvN3K6hr9hfJxRnJGlrFneG/3TiWUa8EIi/lBx9x76n3tj3EFymc0P6RoeZRE
 rsK9aLaF3cRh3n5YDIygU+D/j4IlFNo3I+dUUBDQUnj1dZESneCa2Ajte2OMXgTtcJkK
 j2OyVuAi+HNxI2l5fw6qqULHQ1HUke8LCT5f397Sw8J6V2dSH33VL2C7lr3jg2MAVMtj
 sUhfONn2BTrQH6GSjh4HAdrq/T/RXtVWPiNFClMY1JbXGlU9NqPxAZYUJEJyciX3gXoZ
 bvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070390; x=1783675190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=daVxj2QmJFSiDanODqC5cOrBNGVj6v9uZQgD03LLDR0=;
 b=bBWKKeyx7PCYG2v8FOIOwYmTtZYjLq7iF7cyH8BaTaWroDtLMSJms2vcpCXeK2WxV+
 dexeL8Be9M1nEHLFjlNbdUyZfkkaxXSUsCFXDUWNEXVxLVan4kFMrHk1c9JwWwykdWsF
 4FCbktBBK1mC3ZAZEZ6pNtu+32nUfrUgKLaL4u7BO2JqqvBnSRtpcSca7w4iAiwuiN43
 ChdVbgqzBGgNSi9Ukl8PvdiEc2VmlB4F85JiTAOeXM+FB/sF5wuaD965KpH0HCfDMvo/
 eWZ1OfPyc/TSPhvIuTrRtV2oRunaRUdMlgqdoTceKcWkV1VEA5aGqov0d5MyJeah+k3u
 9ekQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SjTxYTI6sr+ymCYRR7ftNWipxmILlNLrE/LXKO2X38C/IkkzSCoZvW+8fQZfMcFdOfRdcbkV8BDQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9KG4JtY+hTvwxN+Nrq/h37hajUTSVA+nL1F4g/Zf8jbxk2mpf
 b8jkYXrROMFi518eOBi+TlJJ9wL4tmVGVoM8kmUrn8FyKVGfx3p0FJxZx8QfLcXBErYBwsRvWG5
 psQL9pHrM2jp7RNUzk4b+dYaZG4tAmpR5IcTkkJN7xg==
X-Gm-Gg: AfdE7cnl9GbfasIK4e8/yUcW/Vyuqfe8SxPI7+Ugo/QlWOY1A97yHCFS8VOAmDDd27m
 zBuxObyHZ0Vabz9tpYpRnvqs0aKqo+WAcKMlqmz/5W+XThgoZVXr2u+q9tZgaqep1C1tqXn3OzD
 FQUmIwmLPLpb8y0/Q2p4CFftLCICFk0twYGVoUjFgDNDwaNy4IidSM6Qw3XJfE2Eq0n3KoDnw5r
 pVuDSvmLU8LeFf49j2QbYI/61WvuDdZWZChJPUuvXYKfQNL44SPl3Bv8z9eDyzbi6JBjjC9Tw==
X-Received: by 2002:a05:6820:4ccc:b0:6a1:83a4:8175 with SMTP id
 006d021491bc7-6a31d492ae8mr1839020eaf.27.1783070389668; Fri, 03 Jul 2026
 02:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260629030930.379879-1-zhouhaikun5@huaqin.corp-partner.google.com>
 <CAD=FV=XoDLOwva_tnUWujgGHCJbe1h6YqX7hO6vdD4f9dbc8UQ@mail.gmail.com>
 <CAKDRTegZxEsE36qpebdg0hAFek0NN1py1aLt4SWPVD8S7S-nbw@mail.gmail.com>
 <CAD=FV=VPyyQosGRgn3GKWzvRhii=X7_i4OJ9AiRxczh92gyxjg@mail.gmail.com>
In-Reply-To: <CAD=FV=VPyyQosGRgn3GKWzvRhii=X7_i4OJ9AiRxczh92gyxjg@mail.gmail.com>
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Date: Fri, 3 Jul 2026 17:19:38 +0800
X-Gm-Features: AVVi8CeytAQOAKA-p2E8gOyrMH_9SyDchMlsSDcku3fMjBDlvBGx2jjYfM59L7E
Message-ID: <CAKDRTeiLhV5KYf8UteknKBnYm8mSy-N4v3XOdm9C8T+ah6dZtg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Change the KD116N2930A15 panel enable delay
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
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

Hi Doug

On Thu, Jul 2, 2026 at 12:33=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Jun 30, 2026 at 6:16=E2=80=AFPM Haikun Zhou
> <zhouhaikun5@huaqin.corp-partner.google.com> wrote:
> >
> > Hi Doug, thank you very much for your reply,
> >
> > On Wed, Jul 1, 2026 at 1:33=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
> > >
> > > Hi,
> > >
> > > On Sun, Jun 28, 2026 at 8:09=E2=80=AFPM Haikun Zhou
> > > <zhouhaikun5@huaqin.corp-partner.google.com> wrote:
> > > >
> > > > Due to panel characteristics, when the panel wakes up from the S3, =
the
> > > > main link data is not yet ready when the backlight turns on, causin=
g
> > > > a garbage appearance on the screen. Delaying the backlight by 1000m=
s
> > > > can avoid this issue.
> > > >
> > > > Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.=
com>
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-edp.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > This really doesn't feel right; it seems like a hack papering over a
> > > problem whose root cause hasn't been found. If nothing else, what doe=
s
> > > "S3" have to do with anything? The panel isn't left powered on during
> > > S3, right? So, as far as the panel is concerned, S3 should be the sam=
e
> > > as S5. Why would you see this noise only coming out of S3?
> > >
> > > -Doug
> >
> > Yes, this screen issue isn't limited to the S3; the backlight turning
> > on first and then
> > displaying garbage isn't limited to this issue. On Chromebooks, the
> > same phenomenon occurs
> > when the backlight is completely turned off and then back on.
> > Measurements with EE revealed
> > that when the backlight is on, the main link data is already being
> > transmitted but is still unstable.
> > Turning on the backlight at this time causes the screen to display garb=
age.
> > We had to add sufficient backlight delay to fix this issue, and while
> > we could modify it in the DTS
> > settings, since this is a screen-related problem, we wanted to fix it
> > from the driver.
>
> OK, fair enough. Sure, if this is truly a problem with this specific
> panel then your patch is the correct one. That being said, I'd still
> like to confirm a bit more. Specifically:
>
> 1. Usually the controller on the panel is shared among a family of
> displays. Do we understand why this specific panel needs the extra
> delay while no other panels do? Is this only because we support so few
> KDC panels?
>
> 2. Have you talked to the panel manufacturer about this problem? Have
> they confirmed that they understand the problem and verified that we
> truly need a full 1 second delay here?
>
> The 1-second delay is pretty beefy and can affect things like boot
> speed for devices using this panel.
>
> -Doug

about the 1 question:
  The limited number of KDC panels is not the cause.
Our waveform measurements revealed that after recovery from S3,
the complete image from the source output system was only available
after 1120ms. We had to delay the blending time to avoid garbage
caused by incomplete source output. It's worth noting that adding
1000ms to circumvent the issue is already quite poor;
based on the oscilloscope waveform, we would need to add at least
1120ms to completely avoid it.
about the 2 question:
Yes, we have discussed this with the vendor, based on what's visually
perceptible, we confirmed with the vendor that 1000ms is feasible.

-Haikun
