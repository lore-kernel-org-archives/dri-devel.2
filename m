Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF4606A334
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4311010E60C;
	Tue, 17 Nov 2026 15:37:49 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F263610E60C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:37:47 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-7d65662077cso3100146137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794929867; x=1795534667;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=edkz8rhF75H54wjVaNZcUL3aDSKXaXqJ2SuZNB31jO0=;
 b=kB3AITAFazaz1FJ2/qRCYHndARMqpPS3iSgIZdocIy6KVufTfUnaE0ZV8qehlNSOhX
 qVBGySDZqtABQpcc3RKL8jvRKcJlFdmStqou0d5ThHngBjBntBeC9QFzWfCPMtofyG0U
 amSzs5XXN+2o8lHScfHBFpHl6R6uLOwtGVxuDx2CNYJqCzxg4Fcjuz/6Fd9mkAZS4sHl
 G5WaDbM/jnKKzBUL51wzKNz0YkdBEg5ENxUlk6VSneyfgJ+SN1jbTgSsmDwlS497nKwK
 rBIkQOm/HCFUbMp6kGKLqZ4bXbIL+pvAuJHVCi0/6McuYgEHX4FrzxJ6Mnzqr71iBcET
 TyqA==
X-Forwarded-Encrypted: i=1;
 AL+hErFG9YuJOghFLF5s2wjrZKQybL9B86cNCIOXCi/DAcyjlalAVjnvcCa5Fi20cIPGzJe5PJ5k7vqFAnI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gU9aTKZqVRGmMmC7stWr4uxk96SDhnBCErCu9R3Kv6qrbxKMv
 0RvYsW+SM/u2QH0QlSpInEdRbXsihR/FSZXQwDLzHC/XdOwGNzxJC0u6bpU/DNaZ
X-Gm-Gg: AYBFou1/8IR5NY9IdCvjxRNI3zrVvzmuXTQTD5wBiupXJwAWRDBClhngHMTurxaIrny
 m5mYcqSOLvGmayJyNNjWZl0jdKeaK8b134hsLlfPBYHTEMXvxEJUhrYBFVvwWm85VhCaKnNFQ9v
 tcrex3/1q+56Rrq1edFuco3xSd14snwiMcnbvrYFESnOADuKUR4l0uHPCobodp/aZaVkeqtH7sj
 DnDdPFKb1ez1q60v5oaw+SYIBH0BvI/W4XbpB6sJUPyzPSNXbT8M8uQ2ZBVtFugRnQUYKe67iAL
 h/vZI0Ek/IUTnyhDxqCX60vSWiFSdNPnMQfmhLKirEX2hRJrgPucyXh4CEwpSZUwAQDBokkDcGZ
 uTPyIz5B1ovo5/BhFbHLNesqXacCjlGkTS8tmLAsjzNudS8c8P96Uj+zv+eRYwPukHuFaLNgsXy
 Np+YmnQWODG/PFSApzWAhGx0CJIF5FCYzPOQn1tIqBbuvIOf1DaKoaS7PH+uPEHl0EK/G3B+5b6
 TbxdPrSMxVSmXMJ7ljGljecuGcgPSV9wL3BS0q1Ooy2FpiQWn0eUjDNlRnIEqcbAM+MX/Oy7HUA
 94+v4uoo6aOy4KN127BRSVoDPXdEp9Cg0mlF7m1hFKRSDGzmY+z5S3p6OSfehWEOGvM=
X-Received: by 2002:a05:6102:a52:b0:7c3:2f13:d905 with SMTP id
 ada2fe7eead31-7d64d4683ecmr5893016137.3.1794929866614; 
 Tue, 17 Nov 2026 07:37:46 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com.
 [209.85.217.41]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d69df9f7b6sm2696584137.4.2026.11.17.07.37.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 07:37:46 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-7d2db6408cfso3677071137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:37:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGDo8WJxJjYSBFmb80QDi464ERTXw8T6pbZ71WjVpTag2nXFGVSYdsDvcprZtwD6nx9t1KxkcDn1FU=@lists.freedesktop.org
X-Received: by 2002:a05:6102:c15:b0:7d2:8dd0:2eb with SMTP id
 ada2fe7eead31-7d64d6ed886mr5633979137.8.1794929866113; Tue, 17 Nov 2026
 07:37:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
 <CAMuHMdXQjm9rqmKn35G9-CqGSuMO9nirDw2GmFfF2PBfsCvH_Q@mail.gmail.com>
 <avxy_u864ZT7vsLx@tom-desktop>
In-Reply-To: <avxy_u864ZT7vsLx@tom-desktop>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Nov 2026 16:37:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLw4zYGCg5isy8Mdxfgub39CXbCNgFmNsv3XMj40U7dg@mail.gmail.com>
X-Gm-Features: Aa3M54qPbbFS8WXjl4rVfHsNDf_vt32c6X6we35W2mQ26XiZPauxobEfSjiOsc8
Message-ID: <CAMuHMdWLw4zYGCg5isy8Mdxfgub39CXbCNgFmNsv3XMj40U7dg@mail.gmail.com>
Subject: Re: [PATCH] drm: renesas: rz-du: Add suspend/resume support
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tomm.merciai@gmail.com
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

Hi Tommaso,

On Tue, 17 Nov 2026 at 16:30, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> On Tue, Nov 17, 2026 at 04:12:43PM +0100, Geert Uytterhoeven wrote:
> > On Thu, 12 Nov 2026 at 09:31, Tommaso Merciai
> > <tommaso.merciai.xr@bp.renesas.com> wrote:
> > > Add suspend/resume support to the RZ/G2L DU driver.
> > >
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > @@ -140,6 +140,27 @@ static const struct drm_driver rzg2l_du_driver =
=3D {
> > >         .minor                  =3D 0,
> > >  };
> > >
> > > +/* -----------------------------------------------------------------=
------------
> > > + * Power management
> > > + */
> > > +
> > > +static int rzg2l_du_pm_suspend(struct device *dev)
> > > +{
> > > +       struct rzg2l_du_device *rcdu =3D dev_get_drvdata(dev);
> > > +
> > > +       return drm_mode_config_helper_suspend(&rcdu->ddev);
> >
> > error: passing argument 1 of =E2=80=98drm_mode_config_helper_suspend=E2=
=80=99 from
> > incompatible pointer type [-Werror=3Dincompatible-pointer-types]
> >
> > The "&" should be dropped...
>
> Sorry are you apply this patch on top of some other series?
> On top of next-20261116 I'm not seeing this issue.
>
> Maybe I'm missing somenthing?

Ah, I have your "[PATCH v9 04/10] drm: renesas: rz-du: Reference the
DRM device by pointer" applied, too...
https://patch.msgid.link/d5a97ddb346c5cb959b39fda45277afb1fa2ae16.179277096=
5.git.tommaso.merciai.xr@bp.renesas.com

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
