Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58840606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMKyctZq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05CF10E510;
	Fri, 27 Nov 2026 09:42:01 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3927A10E510
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:41:55 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3869f03af6aso6978700eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795772514; cv=none;
 d=google.com; s=arc-20260327;
 b=DUtFBC5ywZRhPGvYFPYKugJxVUW8UHfQvodvVE0tJqGsUgr18BaH6CeZnOv78K1yg0
 8Vbm1x5k3J0HHfHDRSfPSk2sR/DJqh+LcP3F0Zgr0/VSo4SWkRiQOUglYTQkkkq0vsMS
 C/bMJkmt2XQZ1Be2Fz27OY6Ufbyf05yuZhMofnqSLPMN7TmTTNBBF8gC4mtJdlbjiztH
 6r7m7xzxB9s53cYMOF0M+rS9xBSM9fGlaqOMkTMxBd1o4xwdH9D1H2tXhnNoQ1wuY6MM
 H/8uqYO0JcNBS0KFW5Oy6CuXJAtXOkZyTfvAn1WSjNAHivk/dYZLsCtl5RWCLE5CCvnw
 ZdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9uU8/lZDNdhVavctrYy60KAkKa6LqrOSME59pYMkOn0=;
 fh=V3illVhO+t4d7WcJAv1+2ZVqWTdEUqqID05hs17cI2o=;
 b=A0dpOQ3n4f+opp0Ltj7ZN63ThIh/0IsWAnrqv4mYFsfkonDW4+YrdMsJirxQa3+XQe
 8MjiGTv/v1hxSLLkQf873mGQkDROSa+zbzgah9QPJ0l0wCzYiFDx6mmmKWU65VoxPbkZ
 T00hkLBxdaMA4qInKgxbmpALQ1MWowHNzbPPDfGPxamjXkQ1VW37mc/1ayHNROdF23d/
 7PnhwNIp6nLtpWFsvApVq6BpD/Eo9BaBabvI/hb0FKoII9/IH7udgkkCsO7MuZ/6MokR
 oXTSz+TYgp1DaCdBb87ZhTEObdDRqm0WkvViTHhMGnCryF9F+LMIw+0FOwtaS3alj+D3
 pPQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795772514; x=1796377314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9uU8/lZDNdhVavctrYy60KAkKa6LqrOSME59pYMkOn0=;
 b=ZMKyctZqq/qjBqid7Uo/j33T+n0ePMgMgi59SMy8Dc/Ske+M0zlO1SW8qbloC+mk1R
 mnm1DvW/K7Lwts+WyfhxM6O0Txx3L2oTmVqHl6SIzzH1ZxpYQDWgN9F1qGxFJC42xqzq
 dadVCl3Vd5ZeBnTREv1qNTyXN7pzpW8wxJwF81/L59nKaRraXNNH6r5toFRMsf2wTna/
 voQ0BrvojVXqUQZAez5rPDRtFXOHVOREv4uIAc5ydoTL1x+ySl87vMZ38mwL6QxHjFoG
 NCD+vDqvCFeSJYmCR3lBPK/6y8rubfue90ih4cEKoclqkYmmwkI139mFe8v0RWiVEUY2
 OAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795772514; x=1796377314;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9uU8/lZDNdhVavctrYy60KAkKa6LqrOSME59pYMkOn0=;
 b=ZtkR5rP2J2Rh190dljXCKFrgbWjNGOGoNdV/EVQAzCMX7cyBUZMUOtxZvIFbkzXdlz
 jEvxmxWJl3t1htiyY1yCeocFoi2aQJ/aAvxkxCHlHUQ+BuS0QAj/tv/cXTe+Pg0ZfNSP
 8XgL5m1iFHlpcjq+pxsHkyMm9tyeeBQseQEGHwn5nDXkhK6XkxnJO6VrYIb/QQroOVQx
 NBXilhzph1PrLBbpvo7LcGGDuoPDbcStT8TFQmbp8Kvo/8zqrBl5NkVsCknQ0oCBSuNl
 1Nn7yjtd5+IJ/x+tqdE+iTmVU7tWD5ebM5S+VyOdumytDtspEGHVptRW/9rVAWRpc8gv
 evRg==
X-Forwarded-Encrypted: i=1;
 AL+hErHV/2SD3LqxJ3wxKClDioXOQv2v/uQDhyoKrAAGX/CIduPbCvRyaZasCWIN56srhfG4u9S3ABzC8f0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/yGjxV80yFPeIVKou0wOZKdWq99kcXvdL6mHVAe4AAY9GfWWWv
 UOT0dXUzdt3tLzfWZuapV6oy1w2ACJ5rwQA1nsWoJ1RI1M3J6kWL5nmJ6W6Uhgf+w0Z/hIcsrmU
 9YVuIN1NNhW1inGi3LVQJDmSfq1PIcHcAoy8B
X-Gm-Gg: AZFdTZfnkpd39ajHTpsxlTEy/P/VwjHdxM7vDoODhdLYMa72N7WyA+ZHy234LtJ7Uix
 svO6hwBXda9jSBogtx1Txn0TZit+FcCuiBeDprKc/63uX+gfZ7TjtR0n4VAE3BPUn7j6yXcoLst
 IBOsYTNL3JaM/xDG7dU0bjlzdIedtujNHrrPILJudJ1j5e6EEs6yn6ktCpeCFowiN1Dtw+8E0fX
 lk1a6vltCVXaUYS491oXs/6XDRTYMCAtXy+51IowYN2yj8A8AtlndPpjo2ZMeSb64S4DwBIJQF9
 bO4sGqvNa7OxGkiZQhIDJn9DH/gvo+u4Ybf4O+CcAfxlLVI/pnJkHpfCiRVizS9c6FOdJLX2N5c
 tkS9kFuszsR3eRGlx+pTQzYq7c/XwsJaHmu2flA/+mwUli7L3ZWAHG96leEVqsGdnROsMndDKt4
 JZ+ajQRo45yVcpKLsOPic9Y4oRxF4vXDsqWJDDE5ZscGHSdRR9mG4=
X-Received: by 2002:a05:7300:d589:b0:386:9ff1:7f7d with SMTP id
 5a478bee46e88-3869ff18213mr20461146eec.4.1795772514372; Fri, 27 Nov 2026
 01:41:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-11-clamor95@gmail.com>
 <XPGRUNopQCaIq1yDhISpSg@nvidia.com>
 <CAPVz0n3YEoq5dg4+sHfd74rT8x_R9DEv1eTzW7UHVKEABGa-BQ@mail.gmail.com>
In-Reply-To: <CAPVz0n3YEoq5dg4+sHfd74rT8x_R9DEv1eTzW7UHVKEABGa-BQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 11:41:43 +0200
X-Gm-Features: Aa3M54q2qhxyDM_Zeh4LfrLo7uscd-ydHCRlf9uUlV1oDTURq66rSYIDmKEA6Jg
Message-ID: <CAPVz0n1xeNP=rv3qDMG06aSWRLTVvCfuo5tFyt9fz7KDTySV0A@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based
 on bus flags
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:2=
1 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 08=
:22 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > Parameterize configuration based on bus flags passed from the bridge =
or
> > > panel. The list of supported flags includes now pixel clock polarity,
> > > display enable (DE) polarity, and data alignment.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
...
> > > +     /* configure DATA order and alignment */
> > > +     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
> > > +
> > > +     if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
> > > +             value |=3D DISP_ALIGNMENT_LSB;
> > > +     else
> > > +             value &=3D ~DISP_ALIGNMENT_LSB;
> >
> > DRM_BUS_FLAG_DATA_LSB_TO_MSB does not seem the correct thing to check
> > here. According to the TRM, DISP_ALIGNMENT doesn't swap between LSB/MSB
> > bit ordering in a classical way, instead:
> >
> >   // DISP_DATA_ALIGNMENT =3D 0 (MSB)
> >   LD[23:0] =3D {R[1:0], G[1:0], B[1:0],
> >               R[7:2], G[7:2], B[7:2]};
> >
> >   // DISP_DATA_ALIGNMENT =3D 1 (LSB)
> >   LD[23:0] =3D {R[7:0], G[7:0], B[7:0]};
> >
> > I suppose MSB is more natural for 18-bit panels and LSB for 24-bit
> > panels depending on the layout. So the correct value depends on how the
> > panel is wired to the SoC on the board. Hence, I think we should
> > describe this with a new property in device tree under rgb/dbi or
> > endpoint node. Something like 'nvidia,rgb888-wiring' for LSB? And
> > document that this means the above kind of wiring - not all RGB888
> > panels use it.
> >
>
> Ugh, why is this so confusing...
>

Using 'nvidia,rgb888-wiring' may be confusing since as you mentioned
not all RGB888 panels use it. I can add 'nvidia,data-alignment' to rgb
properties and set 0 to msb (default) and 1 to lsb, or directly set
boolean `nvidia,data-alignment-lsb`. Let me know which is preferred.

> > > +
> > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONTROL)=
;
> > >
> > >       tegra_dc_commit(rgb->dc);
> > > --
> > > 2.53.0
> > >
