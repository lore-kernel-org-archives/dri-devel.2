Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EDECA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A6810E245;
	Wed, 30 Sep 2026 08:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qyNSzykX";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A6210E245
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 08:55:55 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-3396cec93b6so5808855eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 01:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790758554; cv=none;
 d=google.com; s=arc-20260327;
 b=Bz6SKq/s4zTLyxAn5uNYJDzg27jV8i+R38LeqoET2t/nlDWpJAFqIFmp2x0HqvRD/V
 e4feTmkQdPdfAUx0biObRsB0OMUu6xcxK7gpqfLBRNnarNxEVYi7zPJfzUIhB8r0GrCF
 DYjXwTA59Ul+kjclgqdQeCFBdAHTdRaKYx04Lnlr6wo+v3mr64wk4y9axlgOqX/VUCVG
 kLdBUmzdwUr1Wq/n44reRoK3kg42AH4Ean4XA5KJgmnPl8PP8mpR67fXMhRzmtmLlafA
 G95+Xd0Y7V2V/m8qt/SXRu27Zirx4Q5pbIyYWCGVIiTV12sc+C7/x0u9atC4rtMCm9Pj
 Z7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tK3QynNJMVX6fk91fIN3QptmwfowFv6iOT0xBS9VT+c=;
 fh=m6Dszki7NNYXsziqPoFp+JcLovdgEu3gYioggQKXv4o=;
 b=Kw7M8peesGPj0NX9TC/q4WOWRTMjwcBgj7Xk3XIMpT36PiZzglvNxUPF0YKjlq0fpv
 kRvZMOgV1L9xYBDvvLoTVu3s+zGLuu8IwjQRuK3i1NsGUdzPqwguz1hvXP0TOS8LQZ1e
 QBuJwUmYx1XsUziBOop4ThRUiw5sYwueIciEL+eHDSHWqULsgMQlbvX8ipptHKABUHYa
 QzBwlm1Zw8j4Tm8lDU0eNEIZCgNffkY517XhvQt/FJX0gMWrFIuBi0omNqN/gRtlLZHZ
 wpohxloqvNQSrN6aW4qFviKTSx7OnWgz99kNk7aVGmLRy3JZzqEK1XpOQckaYFL9ugnV
 k3Pw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790758554; x=1791363354; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tK3QynNJMVX6fk91fIN3QptmwfowFv6iOT0xBS9VT+c=;
 b=qyNSzykXS/q+m8TYFhkNc814yUdaMGAKMAgVZGxI7J7NYeoNa7uryVYM4X5GFcqMNX
 jg4x2+ZcmxwX4MRNr9Oj/xE5RjlqvWRMPCpvHVe8RNKtjSY70x4T+Hg9Dt0gBvEj5Tl5
 4bhrKSZVjfLFBSI4nWGf1AQ8H/cEu72IXTf7DAX4+9zYrhFNcJPGQk2T8TYVn/yZS7Rr
 HbfX0yvdgBTi/xsI2uVl5XElu1mZxNAzF8Zuwd5DotyjsWPxlJAyjARQ38zM8K5k1cCP
 nF/VkpjpqmE3X9XjzrbewTEeBAy3Yz4HUU5ng10qvAR+pTy34/O/2xozYSVPQzj8d7ZU
 cOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758554; x=1791363354;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tK3QynNJMVX6fk91fIN3QptmwfowFv6iOT0xBS9VT+c=;
 b=iJsR+ojr74+GG/eVO9aZwZzrO2rVDfKv3MSYfnSRhJej2JrVkD9Lh9CW0ecmZXMXl3
 K8n6qNkJuuZ8Hdz7alav2Q/CPoPQFVSuQYurhe28T+/JsbwqLbkgyuLkC+/UpFLyLxcp
 lFGombRGqwEOqBjfAHz4zQ9bsBiUTZeAFsLXA+sMb+29Kp3BxSSd7sQnmAYBTtEfMYrY
 AfQnqwfs49zzm6oRQsx0uUi08ZsVvUN8rkKuvFMtl5ICx9lKBqw9AvK3wjArjr2i5w4c
 /yry5f/AclvI3jyEe6fEGkJg7fxLkb33fvuIetiCjfeXKFrxLKYU0ipgmnOuTvSw+v9z
 Cu1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwD/4WJLgDpzTIlnp+r589ryR3jEFPqTVhtAFE3K0RgvHP1G18JadSiIAF0EB1adAwV4nIsNPk7TEY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI/4681U88Jb97s+UV+oXDaI3M2WOTaI39m0JhtuDlxInpOqgnf
 EMsq+FanISKq7vkHKed0rwWeqXOOeHx6WGPgYnLIkQJ340V93n+QrUPkPcW6leldQhnTNBTsmc+
 zzs1U6hC16Ajpy0rDDR7ruZVhIM8SRXk=
X-Gm-Gg: AYBFou0gR2fXodCTM2HAmTHL/LacJIUafXw/lhCADSJvqBn02qCvyoecP0s8unS6k8P
 +4DuiNTdWd283bzcm7eCIqc/Zvr8MxzQjSHJfKr5LPazk+YDxwbMxu5m/HoDiphZOltVUlwwQLs
 pNpopapECYN087ZPncvI3SLq69pRZXLIp+t3okcyUH9CH3eVvrWYd7l6LINTWr/U90sHglA6Cse
 tTdBg9ht+rrVs79G00cCRT3lnbsdmCGooG6yvKPtpGFUyS/+4Vgft2Pg0qNUv76XBESbh1Rky74
 WqSgLUtTAzzMJKUghUJWiUcX/QkVmXOl4TFC6ZFZ6u+G1Oe79iWRKgel1vhd5jYAprBzbcerEMR
 l86AiTq0TAEIE
X-Received: by 2002:a05:693c:66cc:10b0:33c:e9d:6d4b with SMTP id
 5a478bee46e88-34ce1a002femr1132397eec.41.1790758554481; Wed, 30 Sep 2026
 01:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-2-clamor95@gmail.com>
 <arzI6PXbGAgXs9Uh@orome>
In-Reply-To: <arzI6PXbGAgXs9Uh@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Sep 2026 11:55:42 +0300
X-Gm-Features: AclHuK--O-LZ7t9iRpgmVS0LccEUwDL6n7PPlA0pa15dhw7HSbr4NELCXapQceg
Message-ID: <CAPVz0n3dOfmF6C5r0Z1t6ezzCoQEZh+V_oLGMFaUh1xHBMv+UA@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] drm/tegra: dc: Expand available registers layouts
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
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

=D1=81=D1=80, 30 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 11:35 Thie=
rry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 30, 2026 at 10:05:30AM +0300, Svyatoslav Ryhel wrote:
> > Expand existing DC register definitions with additional fields in
> > preparation for adding the 8-bit CPU interface.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/dc.c |  3 ++-
> >  drivers/gpu/drm/tegra/dc.h | 54 ++++++++++++++++++++++++++++++++++----
> >  2 files changed, 51 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> > index b0bfa946e6979..5c67928bcabfa 100644
> > --- a/drivers/gpu/drm/tegra/dc.c
> > +++ b/drivers/gpu/drm/tegra/dc.c
> > @@ -2384,7 +2384,8 @@ static void tegra_crtc_atomic_enable(struct drm_c=
rtc *crtc,
> >
> >       if (dc->rgb) {
> >               /* XXX: parameterize? */
> > -             value =3D SC0_H_QUALIFIER_NONE | SC1_H_QUALIFIER_NONE;
> > +             value =3D SC0_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
> > +                     SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE);
> >               tegra_dc_writel(dc, value, DC_DISP_SHIFT_CLOCK_OPTIONS);
> >       }
> >
> > diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> > index 0cb0515968b35..5679e1ca0c2a5 100644
> > --- a/drivers/gpu/drm/tegra/dc.h
> > +++ b/drivers/gpu/drm/tegra/dc.h
> > @@ -274,8 +274,11 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define DC_COM_CRC_CHECKSUM                  0x301
> >  #define DC_COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
> >  #define DC_COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
> > +#define LSC0_OUTPUT_POLARITY_LOW BIT(24)
> >  #define LVS_OUTPUT_POLARITY_LOW (1 << 28)
> >  #define LHS_OUTPUT_POLARITY_LOW (1 << 30)
> > +#define LSPI_OUTPUT_POLARITY_LOW BIT(8)
> > +#define LDC_OUTPUT_SELECT_V_PULSE1 BIT(14)
> >  #define DC_COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
> >  #define DC_COM_PIN_INPUT_ENABLE(x) (0x30e + (x))
> >  #define DC_COM_PIN_INPUT_DATA(x) (0x312 + (x))
> > @@ -303,9 +306,15 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define  UNDERFLOW_REPORT_ENABLE (1 << 0)
> >
> >  #define DC_DISP_DISP_SIGNAL_OPTIONS0         0x400
> > -#define H_PULSE0_ENABLE (1 <<  8)
> > -#define H_PULSE1_ENABLE (1 << 10)
> > -#define H_PULSE2_ENABLE (1 << 12)
> > +#define H_PULSE0_ENABLE                              BIT(8)
> > +#define H_PULSE1_ENABLE                              BIT(10)
> > +#define H_PULSE2_ENABLE                              BIT(12)
> > +#define V_PULSE0_ENABLE                              BIT(16)
> > +#define V_PULSE1_ENABLE                              BIT(18)
> > +#define V_PULSE2_ENABLE                              BIT(19)
> > +#define V_PULSE3_ENABLE                              BIT(20)
> > +#define M0_ENABLE                            BIT(24)
> > +#define M1_ENABLE                            BIT(26)
> >
> >  #define DC_DISP_DISP_SIGNAL_OPTIONS1         0x401
> >
> > @@ -451,11 +460,30 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define BASE_COLOR_SIZE_888    (  8 << 0)
> >  #define BASE_COLOR_SIZE_101010 ( 10 << 0)
> >  #define BASE_COLOR_SIZE_121212 ( 12 << 0)
> > +#define DISP_COLOR_SWAP_BGR  BIT(16)
> >  #define CMU_ENABLE_ENABLE      (1 << 20)
> >
> >  #define DC_DISP_SHIFT_CLOCK_OPTIONS          0x431
> > -#define  SC1_H_QUALIFIER_NONE        (1 << 16)
> > -#define  SC0_H_QUALIFIER_NONE        (1 <<  0)
> > +#define SC0_H_QUALIFIER(x)                   (((x) & 0x7) <<  0)
> > +#define SC1_H_QUALIFIER(x)                   (((x) & 0x7) << 16)
> > +enum {
> > +     SC_H_QUALIFIER_DISABLE,
> > +     SC_H_QUALIFIER_NONE,
> > +     SC_H_QUALIFIER_HACTIVE,
> > +     SC_H_QUALIFIER_EXT_HACTIVE,
> > +     SC_H_QUALIFIER_HPULSE,
> > +     SC_H_QUALIFIER_EXT_HPULSE,
> > +};
>
> Let's stick with regular defines for this, there's really no advantage
> in using enums for this and the other enums introduced by this patch.
>

Alright, noted. Thanks.

> Thierry
