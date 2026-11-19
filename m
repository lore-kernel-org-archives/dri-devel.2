Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7F606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF93D10E222;
	Thu, 19 Nov 2026 08:23:46 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6EC10E222
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:23:45 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-9905d61449cso557443241.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076624; x=1795681424;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+hfyVl1XUQA6cwLu2cPCDOrlTt5udZgDRMAPyOiNJi0=;
 b=dOnN6oqJkpr6miA+XZTiE6xD+qB3kHYTjY07EklFVwpHNZszY7GT4alIFyjZovIr/R
 7ZkBf6Op6a5FvAFDMYBWW2kvcl6tHTiEpfNE4tYen7x/Dkhf1HN2DGgPRFwJVYTrW4e+
 tsM4+HxLmwPozZupFLzFinbfF/ciVl94EH7uxxURz0HorAjSJdCCsCk96IIvebhNNhdI
 WL0QSIH3lSdDPaJ+q5FrgrPMxwn7pkX57sW4DcB2hfjyVi5MkP59jRPslj23il7FHIua
 jT5NnfymwHWbuiknE5wc5lbG4TiZqkFMspegw+vNqw8LoUlgX6YuBHzvfjpjwu+pt4/t
 rEXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHFVV63v99PGZOq35mhH4DJsWEX+REWpVjng/63DEHIS4zL2p2nhLy3n6eNZ5R0u+5YcZnIJdS8agk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9vN2bGzTy9UCJUWNBeFwASRXTd7Fju86Rf/ZXqTZJh4v8Zevs+
 ne3g+H+JL6YYRpENfSirMVB4anUzMmJik/+pqEyXJc4XhlDHeKhMA3HNUyTUt+WO
X-Gm-Gg: AYBFou28mNUFezdWTBhv/oEC7RFqRUrPZvdetWPr3QiLG8velP0c8L0MLMSBrlDqZh8
 dkWYadaOywxkBYpnRYA8fvFqPXRVsl3sUSZR3vibWvN8/Nin/j02PHtOQ+WAS0A1/UkLJ94qpOU
 yi5NBFAl66/FcPX+JAemVYnp22BgEvLWn3vRZ+EZx6aAcKrwfA8943D7tb8oX4HMfGhNATavYTj
 JLlEfuldndewQebYsog//w0wi8coVRVs8GCjK+jJAkJaOJifoOcLfj2eCl+h6mxlMHnWZ7i6ZgL
 tr+wYWz9Q9l/DG8u/eFiEm+tjH2ZfgHq9uy1ss8jPlr+hq0K1pEKIt/bJHZXQocn5GMipSxJKHk
 6mU5tXxH54b6f+khGQd0CNZPWFBPo8n1oo9yLHiMKlN0DLBNnyvZScsBW+JXiifXCO0LlX8iw+2
 qtMg2GIFwGlJ5FCzOIsYTGPj7dELIzuXmJcDK4H5EbgySvtLkhn4G1OzomCnMQDcLIfFqyM4cQI
 msppcxZ1WHYxdPp8507TE0U1Br5YeDseiJiIMC0Ag242njibfSu2hXhSuPP+JZR6q3utPclmLmb
 UXqPT6I4IucCKdhWHry5YT3YND8ejWjtq5hYTJTnh3zRrYLp05cJOXNqzPYdPQzee9nK7NM9tmw
 WGVJZuXww9lRn
X-Received: by 2002:a05:6102:2906:b0:7b1:6028:5475 with SMTP id
 ada2fe7eead31-7d6ba3953f5mr1904112137.12.1795076624210; 
 Thu, 19 Nov 2026 00:23:44 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com.
 [209.85.217.54]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d6b8ea9d2csm3702074137.1.2026.11.19.00.23.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 00:23:43 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-7d2dc1ac787so616737137.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:23:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGF+YNUL1NfWJpfQ8wGaGc24suVLYxHPCMontu099u6XZ5ACm0IL4UVWsQwV8p2Oi9tPlS0YC+dB0M=@lists.freedesktop.org
X-Received: by 2002:a67:e113:0:b0:7d2:a019:b42a with SMTP id
 ada2fe7eead31-7d6ba48d83dmr1658750137.32.1795076623219; Thu, 19 Nov 2026
 00:23:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-21-ville.syrjala@linux.intel.com>
 <20261118221114.GI1923307@killaraus.ideasonboard.com>
 <av4nb98f3ewe2rV3@intel.com>
 <20261118223911.GJ1923307@killaraus.ideasonboard.com>
 <av4tQaL6caoqd2w8@intel.com>
 <CAMuHMdWSiwX6AoPoPwF4zrYpO8xdaG=aq7U2JG_RjyS-E5UtcQ@mail.gmail.com>
 <20261119081613.GO1923307@killaraus.ideasonboard.com>
In-Reply-To: <20261119081613.GO1923307@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Nov 2026 09:23:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXvFVhYiT1CSHoe45tUkkDPz=pND6jc0CswQWF3agPC_g@mail.gmail.com>
X-Gm-Features: Aa3M54qDzVkUx71v61aMc9IrVxbyT9_EmyPnJjNSiSx7Z1-Yks0fKGnCa5fVWic
Message-ID: <CAMuHMdXvFVhYiT1CSHoe45tUkkDPz=pND6jc0CswQWF3agPC_g@mail.gmail.com>
Subject: Re: [PATCH v4 20/20] drm/rcar-du: Allow VSP and writeback build with
 COMPILE_TEST=y
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
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

Hi Laurent,

On Thu, 19 Nov 2026 at 09:16, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thu, Nov 19, 2026 at 08:38:21AM +0100, Geert Uytterhoeven wrote:
> > On Wed, 18 Nov 2026 at 23:57, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > On Thu, Nov 19, 2026 at 12:39:11AM +0200, Laurent Pinchart wrote:
> > > > On Thu, Nov 19, 2026 at 12:32:15AM +0200, Ville Syrj=C3=A4l=C3=A4 w=
rote:
> > > > > On Thu, Nov 19, 2026 at 12:11:14AM +0200, Laurent Pinchart wrote:
> > > > > > On Wed, Nov 18, 2026 at 11:45:17PM +0200, Ville Syrjala wrote:
> > > > > > > From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > > > > > >
> > > > > > > Make DRM_RCAR_VSP selectable with COMPILE_TEST=3Dy, and enabl=
e the hidden
> > > > > > > DRM_RCAR_WRITEBACK option by default, so the VSP and writebac=
k code gets
> > > > > > > built for greater coverage. Builds fine on x86, x86_64, arm a=
nd arm64 at
> > > > > > > least.
> > > > > >
> > > > > > Let's see what build bots will report on more exotic architectu=
res. I
> > > > > > may volunteer you to send a fix if I'm too busy when the builde=
rs start
> > > > > > yelling :-)
> > > > > >
> > > > > > > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.c=
om>
> > > > > > > Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > > > > > > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > > > > > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > > > > Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.i=
ntel.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/renesas/rcar-du/Kconfig | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/driver=
s/gpu/drm/renesas/rcar-du/Kconfig
> > > > > > > index 80bd770ae0f6..5394f131c58f 100644
> > > > > > > --- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > > > > +++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> > > > > > > @@ -76,7 +76,7 @@ config DRM_RCAR_MIPI_DSI
> > > > > > >         select RESET_CONTROLLER
> > > > > > >
> > > > > > >  config DRM_RCAR_VSP
> > > > > > > -       bool "R-Car DU VSP Compositor Support" if ARM
> > > > > > > +       bool "R-Car DU VSP Compositor Support" if ARM || COMP=
ILE_TEST
> > > > > >
> > > > > > This will make it possible to disable the option when ARM64 &&
> > > > > > COMPILE_TEST, which will break operation on Gen3 and up. It wou=
ld be
> > > > > > best to avoid that.
> > > > >
> > > > > Break operation, as in when running on real hardware?
> > > > > People actually do that with COMPILE_TEST=3Dy kernels?
> >
> > COMPILE_TEST=3Dy kernels should still work.
> >
> > > > Hopefully not in production, but that may be the case during develo=
pment
> > > > (I don't though, there are enough kernel options to deal with witho=
ut
> > > > COMPILE_TEST).
> > > >
> > > > This should do:
> > > >
> > > >       bool "R-Car DU VSP Compositor Support" if ARM || (COMPILE_TES=
T && !ARM64)
> > > >
> > > > (untested though). Do you think it brings too much complexity ?
> > >
> > > Doesn't bother me.
> >
> > It does bother me, as it breaks the safeguards encoded in Kconfig rules=
.
> > I think it would be better if DRM_RCAR_DU would select DRM_RCAR_VSP
> > if ARM64, so DRM_RCAR_VSP cannot be disabled where it is needed.
>
> That's possibly an option too. But does
>
>         bool "R-Car DU VSP Compositor Support" if ARM || (COMPILE_TEST &&=
 !ARM64)
>
> break the safeguard ?

No it does not. But it is more complicated and less readable.

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
