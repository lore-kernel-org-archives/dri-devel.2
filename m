Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28E2C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E282710E0A2;
	Tue,  8 Sep 2026 07:18:51 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F0610E0A2
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:18:51 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-5c65d654c23so1747008e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851930; x=1789456730;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ASzOob7GnYKJXcWv8xLMRXcs4durQAzV6NwhNCTQzS0=;
 b=QalqWfrwMs8Uhdai3ZYwjt88Lm8nq1+1QhZpCP/ECLgCRaBFTeqb/SBNMjM0At677y
 e6FtdEOV27OiHF+uL2vML9AAd0iJTHvjMtAypClTdjs5WKLdWtIuSTc2qoGJ+xcBBPCV
 /045JX26jiiWvll4qt2VaFJbuGF3D6/3VX9/5eiaN4lBR2bZHrhYVzK/ER+qJ9GAw8Ar
 tq6e+8k+gbAIVrnLirL0t4AdnZsC6SueLnZkfvjDXlCYpHj58XT145zINzCtHahWjEDS
 B5W1gvlTi5h3bVZiLzwG/mtp/KB8O76KOuycmuQhJE23gpwuEYRD1Tlt00656zbI82Zc
 CbjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBLfm2Y3sx59z958FSEgC0CxOXA7jiFEDoEg/YZm65bYS4mBdbhgCHD7vXKHcs+I4n1R47AsuMNuM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mlbP0NmsOLDYaZJSwFcXzNVlzzugdFpFuWYkdkL+/VGr8XRKks
 fmDu14uiTm7e7YxYW54E7rpYiL8IR8vCeaW13uc07NJBLyHtjdIXoKoP3e7xclPN
X-Gm-Gg: AYBFou2eKU1oiEOnf3tQGuRuBnyJCuqWir8+seSoYwEl1G8a32yXUwZ+5UU569peHbE
 ZJZIP2UfFqNvQ5Fm600lH6RJPz7t/TBkRVeb9WAx53ypARFTZwoLTM98z0cUO1O3oYJh7k5xbuA
 RVlXyC0ngCgsPwUbzHInV3OBZayspof98cVOVVLY9D2lqOaLrQ3/IMUCXzB/FqQsyLb640HEqe1
 tg9lsPxPfI/JAsPVK2PEDrvNeLwHxeukaalnZkHwCG7L6+sviBuRfBE118ACZ5uZtCYriNqcULM
 TcSNSrPEIhlpM1uL7sGFB06LSN06Dhz9Hj7sJ/m+yGh+4u+Ptl6vy1JD9xaX/BEDeFrDi7Xq6xT
 GXVHnWJXC4M9xwPgtOfjybBc5Ti7DPyabhSue4aNY2gbMCAFLpVL7NQtlWhFfnR6bTZLdz4P2Y6
 9VqWXncpKdkNsjWrmRoVmYr+15gml/qcR18g7lhBpJYXGp12fh4RLXCfLKQ1dkiio1LATCvTXS9
 Jz+yZuOjfw6x8OPV1OlIzhPRw==
X-Received: by 2002:a05:6122:da0:b0:5c7:ae9a:a056 with SMTP id
 71dfb90a1353d-5c7ed457809mr11508223e0c.8.1788851929660; 
 Tue, 08 Sep 2026 00:18:49 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com.
 [209.85.217.53]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c7ec3874acsm9035068e0c.15.2026.09.08.00.18.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:18:49 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-754ac74c495so1344415137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:18:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzenAjSkzbvPkxjm9fRKqNAwd+6zsuGBF0TDO88v/yIelJgR/bH7+y1OY6tDZgZHYHKR4p4Vg6kXbY=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5493:b0:789:5f54:2367 with SMTP id
 ada2fe7eead31-78a4a718223mr9320013137.4.1788851928902; Tue, 08 Sep 2026
 00:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
In-Reply-To: <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Sep 2026 09:18:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
X-Gm-Features: AcwNN1XmAqsgmY9dglWOajpNmnnts6xxj9nL1ZG-ZrxbM9jWTj4q9h8M9EtZsAE
Message-ID: <CAMuHMdWoZBGyH=WeiTG4QCNC4hr_+pC4QQb-wjK0afZgMUy1Fw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>, 
 Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi Michael,

On Mon, 7 Sept 2026 at 22:14, Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 7/09/26 23:14, Miro Krop=C3=A1=C4=8Dek wrote:
> > On Sun, 6 Sept 2026 at 11:49, Michael Schmitz <schmitzmic@gmail.com> wr=
ote:
> >> Hi Linmao,
> >>
> >> thanks for your patch!
> >>
> >> Am 27.08.2026 um 21:39 schrieb Linmao Li:
> >>> The SuperBlitter operations derive an integer byte count per pixel.  =
The
> >>> accelerated fill path handles only one-, two- and four-byte pixels.
> >>> However, the operations are currently installed for every external
> >>> framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bp=
p
> >>> truecolor modes accepted by the external video parser.
> >>>
> >>> For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copi=
es do
> >>> nothing and fills fall through to 32-bit stores.  Planar 8-bpp uses a=
n
> >>> incompatible memory layout.  For 24-bpp modes, fills also use 32-bit =
stores
> >>> despite advancing addresses by three bytes per pixel.  These cases ca=
n
> >>> corrupt the framebuffer beyond the requested rectangle.
> >> I believe 24 bpp mode can be rescued using something like this (entire=
ly
> >> untested):
> >>
> >> --- a/drivers/video/fbdev/atafb.c
> >> +++ b/drivers/video/fbdev/atafb.c
> >> @@ -2463,6 +2463,11 @@ static void svblit_fillrect(struct fb_info *inf=
o,
> >>           case 2:
> >>                   memset16((u16 *)line, pix, rect->width);
> >>                   break;
> >> +       case 3:
> >> +               memset(line, pix, ((rect->width * bytespp) % 4));
> >> +               line +=3D ((rect->width * bytespp) % 4);
> >> +               memset32((u32 *)line, pix, (rect->width * bytespp) / 4=
);
> >> +               break;
> >>           default:
> >>                   memset32((u32 *)line, pix, rect->width);
> >>                   break;
> >>
> >> Can't test this on hardware, and would need Miro to confirm it works a=
s
> >> intended.
> > Linmao's patch: I ran it on a Falcon with SuperVidel at
> > 1920x1080x32bpp, all good.
> >
> > Michael's 24bpp fill: I cannot test it because the SuperVidel has no
> > 24bpp video mode. It was planned but never implemented. Its mode
> > register offers 1/2/4/8-bit bitplane, 8-bit chunky, 16-bit highcolor
> > and 32-bit truecolor (24-bit RGB plus an alpha byte), with the
> > remaining code reserved - and TOS offers no 24bpp mode to set.
> Without a 24 bpp mode, the 24 bpp fill is pointless, so no point trying
> to keep that mode alive.
> > Unless I overlooked something, the fill also looks wrong on paper: the
> > first line is filled with a repeated byte and then with repeated
> > 32-bit words of the same value, which cannot reproduce a 3-byte pixel
> > pattern unless all three bytes are equal.
>
> You're correct - we'd need a memset24() to account for that. Without

Unless the frame buffer would be using a DIRECT_COLOR visual (which
is not the case), then you could draw pixels in the 16 console colors
by replicating the color index in all 3 bytes ;-)

> hardware support this is an academic exercise that I don't have time for =
:-)

True. And as this code is used only to fill the first line (the blitter
replicates it into the other lines), the performance difference between
a simple byte loop and a true memset24() won't be that large.


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
