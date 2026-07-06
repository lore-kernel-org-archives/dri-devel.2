Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8973EC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A2F10EAC7;
	Mon,  6 Jul 2026 20:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UikCejay";
	dkim-atps=neutral
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296EE10E1ED
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 20:55:42 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-5bc4a1130adso767152e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783371341; x=1783976141;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zQnNi2Gm+RCVJd6O2+1iMT4tGxZe1kJx22cSNvswIs=;
 b=UikCejay9Dcrbvbh9vYTv92FW/grcFxhku9ayIpvn4ahi/+sx3Bt62lHMohV/d2vSn
 U0RsjA6M60mEP7GTNtWLA90rD/R+nJ6Y2UoO+xBS13GgM+WhmWykjJdWQBezaI+1QEDM
 kJvxBacTH80M8QCcm0BN+e6NTet18fbc/5pIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371341; x=1783976141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/zQnNi2Gm+RCVJd6O2+1iMT4tGxZe1kJx22cSNvswIs=;
 b=fxzN8QR3lOoFWt+I+uCpeY1r6Xq7sRlJ2Prm1Mob26sydQJdv9qwIEVns4tNHpIGVu
 A3C6jdUw96E5PwgpBRbEVI2gMu1blcaMy6/tcEI1SIov5Lmvd9RYe0kYbFIAkBhrdN02
 bjMGlbBOTlypLb8Lz85JAQSL3SaAbwF07MPyzwLGW/IrHFDTB9pdpS6inNpCnvO0yajk
 NUBn8z1lpWyf3KPsEz7FcNzX85Gg/a6+3AZEE/SQqmTsG++8CSl+l9dRgMd5T00L7csW
 lD+qJMYlYOX7QA/yAa+q6fFZU7wCrwM/07YCCr/um4mFh3b/ZN1hqVf/jxcFr5w+yCRP
 46Jg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6jRsZf7FXb5Ifay9L45pQkXhuXUebJMcuNLdPATnVYybbtvbkeG0kRyP8s57I+9HreYZ5b8OJxgc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrBICRn2tqRMThJpLLN+ANpqVW7yCMMDfZHvA6K/D3XjPncfbr
 FwOJW8DjMRuuOxdtApAEeVxjjcZxN40t5vRILQF/2VeMiBfyjQhQKWbc4+YYQNBYMn1y2KzDS9d
 Snls=
X-Gm-Gg: AfdE7clCwMtuQd/Y7kj+M7oJ64mzeqp1oQ7JJBv7TaAK7oScGj85QUOBkBvmp7PMKTs
 tvPYIz8QsMk2yqqfJKE2l0gx0KOtFVhJ+Oqb+OXA5ZVs47KyIysgQnd4m75AlPt3XmJsVPynf5+
 50hIg6neHnF/EW2ekYxjp83AWkx0xiJUDiRPwhLE8lEcmDj2RbyVLmiUIaC37Nq0ReFCSXeRkis
 RyeudtC2NVkogMUu3LCj0qp6S0VTTIqut4/D1Y0uFLudeD1maPoahFzrwEOuU6VMCPz+Om141Cy
 4zWd/A9aN1ccOgRvM8POZ1isavuFKYSMNYSyv6zMA347Ao4QsaJcCwzjfIGiXutt6rN26zvQppu
 e0O5rQV+crOcpcMpdDgm//QzQQNryedCZqF3LkhdahX2U6xDxOXNFrdwN48z3MBBkh6ZFY32ooO
 hXWP34k0xHUTgVXLbomizTNMdO8PuqMwzFWHjRkLo/xmGWvqPTONmBp3rVtGv08RE0gQ==
X-Received: by 2002:a05:6122:d08:b0:5a1:19d4:a363 with SMTP id
 71dfb90a1353d-5be90700807mr1223320e0c.3.1783371340677; 
 Mon, 06 Jul 2026 13:55:40 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com.
 [209.85.221.181]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5be03ccd55esm5476484e0c.17.2026.07.06.13.55.39
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 13:55:40 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5bdd0779366so969157e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 13:55:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqEFrk1pc06tyJdEb9fWoSjVZ2uaXbAYgVSoCLlpmjbL/d05h8Hl1xkZz+24fxsNrgKiWCdA+FnN+w=@lists.freedesktop.org
X-Received: by 2002:a05:6122:3d4b:b0:5a2:5669:d6d7 with SMTP id
 71dfb90a1353d-5be908a419dmr1132125e0c.9.1783371337867; Mon, 06 Jul 2026
 13:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260629030930.379879-1-zhouhaikun5@huaqin.corp-partner.google.com>
 <CAD=FV=XoDLOwva_tnUWujgGHCJbe1h6YqX7hO6vdD4f9dbc8UQ@mail.gmail.com>
 <CAKDRTegZxEsE36qpebdg0hAFek0NN1py1aLt4SWPVD8S7S-nbw@mail.gmail.com>
 <CAD=FV=VPyyQosGRgn3GKWzvRhii=X7_i4OJ9AiRxczh92gyxjg@mail.gmail.com>
 <CAKDRTeiLhV5KYf8UteknKBnYm8mSy-N4v3XOdm9C8T+ah6dZtg@mail.gmail.com>
In-Reply-To: <CAKDRTeiLhV5KYf8UteknKBnYm8mSy-N4v3XOdm9C8T+ah6dZtg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Jul 2026 13:55:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wx0cdsbmZiGP3V24UpWQkrpKbZgYstfMkySP9a7ZPYeg@mail.gmail.com>
X-Gm-Features: AVVi8CfIDKohbiRabfklUiULQVonEgKyFjD2cFeAJdB59M81OG9LynoaY230QX0
Message-ID: <CAD=FV=Wx0cdsbmZiGP3V24UpWQkrpKbZgYstfMkySP9a7ZPYeg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Change the KD116N2930A15 panel enable delay
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
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

Hi,

On Fri, Jul 3, 2026 at 2:19=E2=80=AFAM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>
> Hi Doug
>
> On Thu, Jul 2, 2026 at 12:33=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Tue, Jun 30, 2026 at 6:16=E2=80=AFPM Haikun Zhou
> > <zhouhaikun5@huaqin.corp-partner.google.com> wrote:
> > >
> > > Hi Doug, thank you very much for your reply,
> > >
> > > On Wed, Jul 1, 2026 at 1:33=E2=80=AFAM Doug Anderson <dianders@chromi=
um.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Sun, Jun 28, 2026 at 8:09=E2=80=AFPM Haikun Zhou
> > > > <zhouhaikun5@huaqin.corp-partner.google.com> wrote:
> > > > >
> > > > > Due to panel characteristics, when the panel wakes up from the S3=
, the
> > > > > main link data is not yet ready when the backlight turns on, caus=
ing
> > > > > a garbage appearance on the screen. Delaying the backlight by 100=
0ms
> > > > > can avoid this issue.
> > > > >
> > > > > Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.googl=
e.com>
> > > > > ---
> > > > >  drivers/gpu/drm/panel/panel-edp.c | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > This really doesn't feel right; it seems like a hack papering over =
a
> > > > problem whose root cause hasn't been found. If nothing else, what d=
oes
> > > > "S3" have to do with anything? The panel isn't left powered on duri=
ng
> > > > S3, right? So, as far as the panel is concerned, S3 should be the s=
ame
> > > > as S5. Why would you see this noise only coming out of S3?
> > > >
> > > > -Doug
> > >
> > > Yes, this screen issue isn't limited to the S3; the backlight turning
> > > on first and then
> > > displaying garbage isn't limited to this issue. On Chromebooks, the
> > > same phenomenon occurs
> > > when the backlight is completely turned off and then back on.
> > > Measurements with EE revealed
> > > that when the backlight is on, the main link data is already being
> > > transmitted but is still unstable.
> > > Turning on the backlight at this time causes the screen to display ga=
rbage.
> > > We had to add sufficient backlight delay to fix this issue, and while
> > > we could modify it in the DTS
> > > settings, since this is a screen-related problem, we wanted to fix it
> > > from the driver.
> >
> > OK, fair enough. Sure, if this is truly a problem with this specific
> > panel then your patch is the correct one. That being said, I'd still
> > like to confirm a bit more. Specifically:
> >
> > 1. Usually the controller on the panel is shared among a family of
> > displays. Do we understand why this specific panel needs the extra
> > delay while no other panels do? Is this only because we support so few
> > KDC panels?
> >
> > 2. Have you talked to the panel manufacturer about this problem? Have
> > they confirmed that they understand the problem and verified that we
> > truly need a full 1 second delay here?
> >
> > The 1-second delay is pretty beefy and can affect things like boot
> > speed for devices using this panel.
> >
> > -Doug
>
> about the 1 question:
>   The limited number of KDC panels is not the cause.
> Our waveform measurements revealed that after recovery from S3,
> the complete image from the source output system was only available
> after 1120ms. We had to delay the blending time to avoid garbage
> caused by incomplete source output.

"incomplete source output" makes it sound as if your eDP controller is
providing bad data during this time.


> It's worth noting that adding
> 1000ms to circumvent the issue is already quite poor;
> based on the oscilloscope waveform, we would need to add at least
> 1120ms to completely avoid it.
> about the 2 question:
> Yes, we have discussed this with the vendor, based on what's visually
> perceptible, we confirmed with the vendor that 1000ms is feasible.

I'm trying to understand why this specific model of panel has the
problem, but no other panels need such a long delay here. It's very
suspicious. Unless we understand what makes this panel different /
unique, I feel like the problem is elsewhere in the system and this
delay is just hiding it.

-Doug
