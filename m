Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E46606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dlrEAoW3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC7B10E403;
	Sat,  7 Nov 2026 11:41:11 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6399610E403
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 11:41:05 +0000 (UTC)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-67be1e468a8so788420d50.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 03:41:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794051664; cv=none;
 d=google.com; s=arc-20260327;
 b=FtA2pPn2wM7c29vvEvKXmaD+c/72XxYQ3OMpmqZhq3ORDX7QWxxjoKJd/yPPEwUJSk
 KdA3k/mIYHDG1sZMy4SHFeZYN/M69HCNlVE4EMhEuL4U45QaVkjPUwsH+DKsTR7q/Cax
 gKNTQrBC8XBAFdCAC8nxI6lcc/7lU6EsA8HFd+R+6ZkkQNqbXZFCkOMJqO06HHRZI36t
 k0DYSpPDIloDmNkPVgC7E2UpvXcHUie+u2JwdbVsn6XzS4rwqCIjNyZijgNxg+Bg8xjh
 Yqm2iWPicpttjsF1pFVwLDLiVb/IoICyrXVNshnFQR7k5QNs+fKZ8uUmwcuLNhU60IjV
 h46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6fTH6XXWW1XsqnJehduXCj5gyuC0EEdV5T9p2wxK7S4=;
 fh=STtPVg6frnte2sNrqiQKQ20hE9fLr2EZ/aAyXm4xiPM=;
 b=KJmWRYiyylOWa1Ov0dI8WTufZBu9MKBQxXzcvCfc+z/3+C/lCIzU6B9mibjCEfClE1
 lTQI9j6k3PiwY39HXGTSosDxwLzBMHu4me9OURYqSYacDm6Hj8hgqBtCEDJsA7/hoH8d
 Fx47hEo1dIOTFJyNlpddLj2z8wtd6Rkd2vDwmZsJUsTSaS6fWuaZfnJ4dyBu18q21PFB
 ABsfPd7ycgqouQCANutsQtFBpLo4sFeh80WbjfX9lZNHJ6E0tszGdNLyloCqBmsXFqor
 +US8uz6iJcxNrT/PpnLmGJw3NVZPw2kGmRCouppSOiRqN4otx7ySQdBOAfNi8qd45URP
 SLqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794051664; x=1794656464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6fTH6XXWW1XsqnJehduXCj5gyuC0EEdV5T9p2wxK7S4=;
 b=dlrEAoW3WXTZayQsofhtciFkxWBFZS6UEz+eHo72T/x/6AdvZS+uk8gtnb7x4Uk7v9
 23vKIDp52zFUEDjvIXLttKqQqgnFXO9nIlz6vFFPVyssjbl8hTgwpVRH0pq2BrGFonJe
 O+UDNIsHHxlqeX++yxknp9RIs7Ou4TJJbOt07NIo9yprC3OgSXpk3VKVKo3Ho5kltcA5
 gInWNA59Shtgwiu8+7Yblpy7LPOpQLYPvktpGFkb0uhe7f6dk3U/MV5o0wHttxL0Yb+V
 026qVJDpOWoLrhKeREC/9WPl3wJqSCAX2K4Y69ne0Rb+fzEYkQ6jZG7P/szfbUm69xFI
 OZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794051664; x=1794656464;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6fTH6XXWW1XsqnJehduXCj5gyuC0EEdV5T9p2wxK7S4=;
 b=elbfpqwF1PFIx5QUHa+Z7dYKxooseIZyoZJ7ln6QYh0g/asN3rml/1OHvphaq/6fPQ
 hbcqeStAr8QbuHrlXLKAQ0PZeDT8eWnDm9oPOmIfKBISPG4duYQ4lVl8798K4/VM4v61
 xjZVF6k/O1jaJUDy+LcsaOnAfd181LrZkIy3jb7684BkcDb7s9N1zauydRG5XN8o8Q3r
 qFVCuVyB++bHi6OGUI/IjJUHBIDADKk3Tjl0WLpuihaabVb3y7SRrcnyiVLEgavdJUpl
 6nUW+qHDPaWHNXWx+eZCXEcCpjERfdb83tISUPHngKKtNK9c/vwL3rFeVmyyqUXCiE8Y
 4iFA==
X-Forwarded-Encrypted: i=1;
 AL+hErHQ5XmNNdxyBcdfSXooatOHfc+h4YAFWEdaFB1OE2xC+iTpEFQg/WI9NLOq4Jw5TvNpIEa6vQavRGc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Yvr1D6iho5wh8N4e5dgwir37MqjxfwIavGEAB9ozDu1ajnSjI
 w4TSSQfMKCXcCZRwX5Z9y+L9WMAPHO6OeloFvAVkfZs6SMHCHUnfcEKEuw6OftWZeZ2br0bg4v3
 Kp2PteIbCysGZi+E+ObqQvyEJ/Oecv+g=
X-Gm-Gg: AYBFou3uaKRHPts8RtLetTu1JyQUocSRAedTO5HoL3nTXvdcViGAx64fp0F+6k687LS
 Y4pQB3FpnXGTsrl4Y4pRaVA/qAnNLsyplS3PbfZKxO4ySgym+M2DeM2sLoyTXLu01kuF6YESFOy
 +uu5unvD8bu+wFETjtaqVT8QRSnGyIwYgYbJKPIygDyUXU1lbCyHSi6Q9oT21QBYv6bWCs1Ge8C
 ukmWrlc2xh0Zp9lwnOzP3dSuHihE2V/vS1u2QWaoVAb/GNKfvqSLvUuv3yI1dCq2+Zbcn6RSV1/
 tqpAc1gaX4p/fcdIdppYdqMuOT+6gYQUOO1OvTx+4BRWi4VA3puoumHwOO0RSQVWryLSr1xDk8h
 QyRmBBlH8ywY+rljoVJDygutl7Gthx+ji04kfeUIrsimJ2u11PllNZvgsayUFpr2hPkO7hDJrAF
 NKfGHeGTAfw1eAUO/6KtUzYBXVRoxPVnnRFUG307GAdteOYCHT0QM3gMShJMlPdCTsUPwUYwJjX
 TGp0VpE9Ja2UF/G+8dW3gJh+shlZafIitIKrpBDGikBpFwW8PCKl/M1511EVg==
X-Received: by 2002:a53:c056:0:20b0:677:c18f:7257 with SMTP id
 956f58d0204a3-67c141e4301mr2310364d50.23.1794051664343; Sat, 07 Nov 2026
 03:41:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105201154.37294-2-matyasdaniel006@gmail.com>
 <874idv2bol.fsf@yellow.woof> <au4J-0GOUuueHLZe@rabbit>
In-Reply-To: <au4J-0GOUuueHLZe@rabbit>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 7 Nov 2026 13:40:28 +0200
X-Gm-Features: AclHuK9O7PUmgPlP4zevfIOy9d0EnpN6X7geLvTsMFUAaD8AWKettmZPb3yRw48
Message-ID: <CAHp75VedGBBd8qk5fO9-DkGwmuLQk77_igefAwTbrfcPCMW8Fg@mail.gmail.com>
Subject: Re: [RFC] staging: fbtft: Moving fb_ili9341 (and others) to DRM
To: Daniel Matyas <matyasdaniel006@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, dri-devel@lists.freedesktop.org, 
 linux-staging@lists.linux.dev, Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Lanzano <lanzano.alex@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 7:10=E2=80=AFPM Daniel Matyas <matyasdaniel006@gmail=
.com> wrote:
>
> On Thu, Nov 05, 2026 at 10:47:06PM +0100, Nam Cao wrote:
> > Daniel Matyas <matyasdaniel006@gmail.com> writes:
> > > Questions:
> > >  a) Is removing fb_ili9341 acceptable, pointing users of other ILI934=
1
> > >     modules to panel-mipi-dbi? The KD233 node would then have no driv=
er.
> > >  b) Or should KD233 panel support go into a DRM driver first? I don't=
 have
> > >     its init sequence or physical size, or the board...
> > >  c) Is removal of all of fbtft already planned?
> > >  d) Several other fbtft drivers have drm counterparts. Should I inspe=
ct those
> > >  to see if removal is needed?
> >
> > IIRC the main reason fbtft needs to stay is because it supports paralle=
l
> > interface which is missing in the DRM drivers.
> >
> > Nam
>
> Thank you for clarifying. However, the fb_ili9341 driver uses only the
> SPI interface.

Only two drivers use that macro, indeed:
drivers/staging/fbtft/fb_ili9341.c, line 136
drivers/staging/fbtft/fb_sh1106.c, line 173

> Is it alright then to move (or remove) those drivers that only use
> SPI interface and have DRM counterparts?

You can suggest removing it, but it might break some users (yes, I
understand that FBTFT is a staging driver), but doing such only for
two out of dozens drivers seems to me a bit inconsistent approach.

> Furthermore, would there be a need to enable parallel interface support
> in the DRM subsystem?

If you can do it, I will agree on retiring the FBTFT drivers that will
gain such a support. I can test 8347d (IIRC I have that panel at
hand).

--=20
With Best Regards,
Andy Shevchenko
