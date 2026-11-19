Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7C606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1282F10FB4D;
	Thu, 19 Nov 2026 07:38:37 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBBB10E125
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:38:35 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5ed2f163a2fso525783e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795073914; x=1795678714;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k0+ZWXQWiknYSqpkTHhzEE+AHvAYHvT+Lzy36NlaabQ=;
 b=cgY1AQHtNU0fWpl+ZYzFUU5AAzQHRBmX0BBt+PMbo8lvhnPlAK3HsA+ktir0MUZ/in
 a+X3UNsqp1FmODynz9enqDgtQhcoftInT2ECw4BCH3yEjA2MsDO1VjfOcOfb2KdIaFLH
 ubjZhXvV83gUz4TA/mWvCdNC5C6Ywq/sydEF0SoX4yanN/q0ckRVsmyJaIn0tX1UlrRn
 INoZjZcUmHQp6LzjW2bfSV+hGJpPLimlbI1lo7ZZQVb+C/ohjyEF/lVvNfXrmjboy/Hm
 o7dWRCiA82D4nBLsPDwqdi6ytdnsR2Qfecdc/Y4+qnmVlymGENLbXzwRmEbe9GeP8Geo
 u7sA==
X-Forwarded-Encrypted: i=1;
 AL+hErHZhLAY8x9WHi5YOn70/aRkrATfP/+RcFW+qswDKzu/rp1xCEwYelMW+DTJerH4O6+4YabGeAbihRk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+A8uRksjXxiAkzYUf03kC98hGJYH7RteKJMg5P6Wmhz9lZqhEY
 EsPrNOH0NHl02VcC6lkJOWe8M+16MG4lzwmGzKz35K9loKNs7Y1k00Ybt+RFD0A+
X-Gm-Gg: AYBFou3g2zZNG2HnVEtH+auSWGuZPhngDijz8xuL/JYOWJbdDIqHtYMsNA9gT7nYa2t
 M+AwYvxxcY3p17/g5Wou2wSUzf+XKvMw7XFJiEU4+UcJOHNoTGza7jLZA4gJBTKAk7KcCjNofR6
 MZFSEfhKr3tAbRlSKsBGH9z4FHhyOlFTev5W1mTLdZkcxRG9fMrEkIn8n6S73IRTdCKiD9DaifI
 Y69KmnRuiQSBroV9Io8xvQeesAySSo7JunHtbBNeEzxclJI1LdGcmB8wvnADb8qBWGsDOGtk9XK
 bqWDzH6shOpyuuxEF4uzJGUPgDlZfuHQ/JLTN8aY1EKrSatD3DkP3CcY1BFEl57MTnDEThBKvIM
 gYHihowHQpdzQX9NoQeXW+rwv1o0ZpUEr8wup6cDCNEDsWlaNKpFyiOAT49oLaCNFwlX7u8jhNY
 CMDmpvRyaVO1ayVu+rI98aQb7MHN3Ks17p1fv9JLHal1tT02tKywxeT2CAT1SUbF3jOsJJ2BQo8
 SCkq/UVQPT6wHTPoDX2phKkmwHYf4BsCf9xYNf0M037z2+EIPQOOQf4gCusKKL1eeDW7itM7ykY
 Mx36VymPLMpncTQFm2NHFeYyC13coenCvzJPWL1/4IBHcLwLJ8b4eNiH6vlMw9JBaos=
X-Received: by 2002:a05:6122:d0e:b0:5ea:e188:a5af with SMTP id
 71dfb90a1353d-5ee646ffc70mr2949371e0c.11.1795073914472; 
 Wed, 18 Nov 2026 23:38:34 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com.
 [209.85.217.54]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee64ec2730sm3594475e0c.14.2026.11.18.23.38.33
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 23:38:34 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-7cc013095d4so698256137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:38:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErG+UDUggN3kLaD4DRM95TNJIZeslsxTgLuBYBxehPuZe6VzUv877UY14eFQNR9FKjVeU37dctYfebQ=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3f9f:b0:7d0:6db8:dc33 with SMTP id
 ada2fe7eead31-7d6ba22ce53mr2119889137.2.1795073913387; Wed, 18 Nov 2026
 23:38:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-21-ville.syrjala@linux.intel.com>
 <20261118221114.GI1923307@killaraus.ideasonboard.com>
 <av4nb98f3ewe2rV3@intel.com>
 <20261118223911.GJ1923307@killaraus.ideasonboard.com>
 <av4tQaL6caoqd2w8@intel.com>
In-Reply-To: <av4tQaL6caoqd2w8@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Nov 2026 08:38:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSiwX6AoPoPwF4zrYpO8xdaG=aq7U2JG_RjyS-E5UtcQ@mail.gmail.com>
X-Gm-Features: Aa3M54pIjw8Q6yVuzFTv0f6jMNRzbaN6MrjfovuH5QzOAoOlJRGM9JUOWvoBvC0
Message-ID: <CAMuHMdWSiwX6AoPoPwF4zrYpO8xdaG=aq7U2JG_RjyS-E5UtcQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/20] drm/rcar-du: Allow VSP and writeback build with
 COMPILE_TEST=y
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 23:57, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
> On Thu, Nov 19, 2026 at 12:39:11AM +0200, Laurent Pinchart wrote:
> > On Thu, Nov 19, 2026 at 12:32:15AM +0200, Ville Syrj=C3=A4l=C3=A4 wrote=
:
> > > On Thu, Nov 19, 2026 at 12:11:14AM +0200, Laurent Pinchart wrote:
> > > > On Wed, Nov 18, 2026 at 11:45:17PM +0200, Ville Syrjala wrote:
> > > > > From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > > > >
> > > > > Make DRM_RCAR_VSP selectable with COMPILE_TEST=3Dy, and enable th=
e hidden
> > > > > DRM_RCAR_WRITEBACK option by default, so the VSP and writeback co=
de gets
> > > > > built for greater coverage. Builds fine on x86, x86_64, arm and a=
rm64 at
> > > > > least.
> > > >
> > > > Let's see what build bots will report on more exotic architectures.=
 I
> > > > may volunteer you to send a fix if I'm too busy when the builders s=
tart
> > > > yelling :-)
> > > >
> > > > > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > > Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > > > > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > > > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > > Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel=
.com>
> > > > > ---
> > > > >  drivers/gpu/drm/renesas/rcar-du/Kconfig | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gp=
u/drm/renesas/rcar-du/Kconfig
> > > > > index 80bd770ae0f6..5394f131c58f 100644
> > > > > --- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > > +++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > > @@ -76,7 +76,7 @@ config DRM_RCAR_MIPI_DSI
> > > > >         select RESET_CONTROLLER
> > > > >
> > > > >  config DRM_RCAR_VSP
> > > > > -       bool "R-Car DU VSP Compositor Support" if ARM
> > > > > +       bool "R-Car DU VSP Compositor Support" if ARM || COMPILE_=
TEST
> > > >
> > > > This will make it possible to disable the option when ARM64 &&
> > > > COMPILE_TEST, which will break operation on Gen3 and up. It would b=
e
> > > > best to avoid that.
> > >
> > > Break operation, as in when running on real hardware?
> > > People actually do that with COMPILE_TEST=3Dy kernels?

COMPILE_TEST=3Dy kernels should still work.

> > Hopefully not in production, but that may be the case during developmen=
t
> > (I don't though, there are enough kernel options to deal with without
> > COMPILE_TEST).
> >
> > This should do:
> >
> >       bool "R-Car DU VSP Compositor Support" if ARM || (COMPILE_TEST &&=
 !ARM64)
> >
> > (untested though). Do you think it brings too much complexity ?
>
> Doesn't bother me.

It does bother me, as it breaks the safeguards encoded in Kconfig rules.
I think it would be better if DRM_RCAR_DU would select DRM_RCAR_VSP
if ARM64, so DRM_RCAR_VSP cannot be disabled where it is needed.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
