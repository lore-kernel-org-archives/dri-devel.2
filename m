Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03032606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zhuzq+2A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F65D10E5A4;
	Fri, 23 Oct 2026 08:07:17 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF45610E5A4
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:07:10 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-35943f55c06so733612eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792742830; cv=none;
 d=google.com; s=arc-20260327;
 b=KuyR+vpE5MyOLTy6CKaSlqSHyiIO3+d7p25yiDMd0T/niIS05/cwYLF3cuRUDzFSV5
 NOt4gvFLJ8ohkL21jhiXCcIarNgtyy90tnUcNEBhfl3IxKSPrNyGP+8BAXjcyGuOdlkl
 jZT6HAYAJivrqGCBq/tjvJVFQNujbrQZgoGrYP4UWvvEiP4nkzmZpUm6m9FairECrZ80
 0WJAHmHULK/IK9OrzuuUpU3Va/SEoKy1ptUBmrB8WuVJ7Hr56vclY9Z4gmXsNFpl5O70
 wzt3BCzckuKBENvpglex36RGmCMXXecNQO36OPXkVy3MhBCZqVCYXO3JNGemWSyuKU7S
 l+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NnvImXqrDQ/+gM4kxWTSIgQWWDlFGoCxyR2kWQPVQtg=;
 fh=k+QW/SttjW3SK+7RlyMTbB/aN84DezXVqGhBlb/x7X4=;
 b=EWnjckZyr0sIu53RTiA9H4ZFcWzqO+69ktOc4Bc07vTiuiaQxPI+X8NLfATHpnbvua
 Zq/RiFcVfiFgFibs2cOh3/ZBstXy5j3G1Pu+drpLwCvx5p4mh0L4lct46AMXYFXWM/78
 25cW2xzQl7PQTAPuLIKGbCtoL5IyRxanFcdrb2vuqFFIqYIGOckD7daqcFPJ2wSl6xyB
 HyrxJvqjarsnevkZ+iDWntqoB66NTcwTq1gFFUdRQloDgm3LxSG7g4As/F76NmGawlrE
 n7XyMiNvB1qWor4LLeT33VHPC2Mmg9Ft58BGn0LGAmiHxs4XjwDU2fiFXlLu5M0Fq8qI
 b4Dg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792742830; x=1793347630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NnvImXqrDQ/+gM4kxWTSIgQWWDlFGoCxyR2kWQPVQtg=;
 b=Zhuzq+2A8jcVjTpjPfDl4fXDLKoA1ovnOG9y1jYGO4ScrhOQ1vlODilFlkVRAk8E8R
 D9t2oe7/eJxX6UhvFYeQmdlY2ycZ9Z+JKQI5+3S7M0+c1FRqKoFrmCY0GZopSVo0HuHJ
 gTg334Nc3PfpP01fCzFnJf/LJWnQPImzUC0oIBWACNPpaGDn50/g78vU5JiYJcKQlLb0
 7Iay/UHorVKxQF/1ElIVZOBfrxBAWEsoyHCsxp4vHBG3VnMJSgg//IyHIsd+Bq8zOrSj
 YBFrkTNZAeg2dPCDq0ztMwuVxVZyCZLEumkETpk3BsxCNPyE7GIUv9Nk0JwZM7slYjWx
 xTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792742830; x=1793347630;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NnvImXqrDQ/+gM4kxWTSIgQWWDlFGoCxyR2kWQPVQtg=;
 b=Ak/5ONMLkif7G+B2avaHzjDVgWFXGFPxjtZMed0NKDEtwF4nMFmCdUzza6e94/r7B8
 O6OcljacWpJk7FiRWOa4unVk7MCjDdrG3G7LDcRBbrdDjLQ3eQzeo8QA73Hck6vi6NwP
 1q/oxipnwMhVdYrYhupxUqRVc+Qx1U496ZdU7tvhKYHA/kPomfK0VAdtyb0Sq8XrHxP5
 JSxZhdgAbdRwVnSFXdNTahvZg3Cod775eOPGsmcKyMkh5TCzhKlWVIcLieMjTLx2Re9E
 /3Rmb1LjgcEuO56XdVtR7wIjU9HnG6KDCQ6l6YUpkkymnWaFol1rRbo+1SWk51hOapSw
 FVsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqWcjpqXeBkBlL1+vgwmYGVHbDkW98PayTSo39guQ33HTS79v/hPq4eEYvwFavf/szb9iAqJpbVqU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLhNkda0CUhq5HpL7kmoE65DzLJGhxv7At1u4PazewYXPL8Jmh9
 Le4wwaNy+Dsfmiv/HO2tdqLic/4SA+wjkNdH2CJZt12LvlGSszEVx/QK10MZpTBFJ2gI+50McS2
 fhsqEzrBpeYyQl5U5NCiCu/GiZzIn22Q=
X-Gm-Gg: AYBFou0MRq0eQWHmHMp2mrqHI+bj0RbUFIERyr0e7zYzG3k8kYEbVqH6UP+dMEom5My
 79qL1/nmCFxhTozUJM1eudbJ4+802wE/b76zWqwevdxzLO18yIsjW20VxgddkG07jhBUt1P/d5P
 1ayAdeYcD0AH1PgAdzlvWW+6IVHj05bpT23nA7aHcwMcBWQV8al8aI4cNwiYX7RGi8+c7gR469w
 7+48f895EdWI+RdzF3Ow/2v0Lvctqd04prSVlcYz4cO/bN1I+4KWD6Tnv0QJvW6dnZi31vsfOLc
 14wekQQS27IorI6aDr2IivYTYOjyYqY+/mQhkG7+pQL/fQNeqqMTbHNvaBzcGN8dzA00uTLDr7i
 KjZQvBeDkcucnsj6oJ8OiaWURA6uvgFVGqojE1msPwTo5vjgMggBTls0pi/k0PPg/iPJZXg==
X-Received: by 2002:a05:7300:ff43:b0:358:c5c9:2661 with SMTP id
 5a478bee46e88-369d9825511mr1710525eec.10.1792742829641; Fri, 23 Oct 2026
 01:07:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022132259.240717-1-clamor95@gmail.com>
 <20261022132259.240717-5-clamor95@gmail.com>
 <Rqw6Z6zYRbyIFoTAHJtpuw@nvidia.com>
In-Reply-To: <Rqw6Z6zYRbyIFoTAHJtpuw@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 23 Oct 2026 11:06:55 +0300
X-Gm-Features: AclHuK_5rggW1YEyeeWCARrgxFz7VynuFiVi0IUrlR8AYmBGFbwzWkAjfApMGS0
Message-ID: <CAPVz0n1dRyoMXNJe4ewY_3YQcaKFXQ08ROvNJr4=HRz4UDBeHw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] drm/tegra: dc: Expand available registers layouts
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 23 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10:1=
4 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thursday, October 22, 2026 10:22=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Expand existing DC register definitions with additional fields in
> > preparation for adding the 8-bit CPU interface.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/dc.c |  3 ++-
> >  drivers/gpu/drm/tegra/dc.h | 49 +++++++++++++++++++++++++++++++++-----
> >  2 files changed, 45 insertions(+), 7 deletions(-)
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
> > index 0cb0515968b35..7005df32f485f 100644
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
>
> Please update the existing defines to use BIT(n) as well, and align the
> define values (incl. the lines around here that are already there) like
> elsewhere in the file. Also, currently it's hard to tell which register
> each bit define corresponds to, so I'd like some comments like ..
>
> /* DC_COM_PIN_OUTPUT_POLARITY(0): */
> #define ...
> #define ...
>
> > +#define LDC_OUTPUT_SELECT_V_PULSE1 BIT(14)
>
> Please move this below the DC_COM_PIN_OUTPUT_SELECT(x) define.
>

Sure, I will refactor this header in a more readable manner.

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
> > @@ -451,12 +460,26 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define BASE_COLOR_SIZE_888    (  8 << 0)
> >  #define BASE_COLOR_SIZE_101010 ( 10 << 0)
> >  #define BASE_COLOR_SIZE_121212 ( 12 << 0)
> > +#define DISP_COLOR_SWAP_BGR  BIT(16)
> >  #define CMU_ENABLE_ENABLE      (1 << 20)
> >
> >  #define DC_DISP_SHIFT_CLOCK_OPTIONS          0x431
> > -#define  SC1_H_QUALIFIER_NONE        (1 << 16)
> > -#define  SC0_H_QUALIFIER_NONE        (1 <<  0)
> > -
> > +#define SC0_H_QUALIFIER(x)                   (((x) & 0x7) <<  0)
> > +#define SC1_H_QUALIFIER(x)                   (((x) & 0x7) << 16)
> > +#define SC_H_QUALIFIER_DISABLE                       0
> > +#define SC_H_QUALIFIER_NONE                  1
> > +#define SC_H_QUALIFIER_HACTIVE                       2
> > +#define SC_H_QUALIFIER_EXT_HACTIVE           3
> > +#define SC_H_QUALIFIER_HPULSE                        4
> > +#define SC_H_QUALIFIER_EXT_HPULSE            5
> > +#define SC0_V_QUALIFIER(x)                   (((x) & 0x7) <<  3)
> > +#define SC1_V_QUALIFIER(x)                   (((x) & 0x7) <<  19)
> > +#define SC_V_QUALIFIER_NONE                  0
> > +#define SC_V_QUALIFIER_RSVD                  1
> > +#define SC_V_QUALIFIER_VACTIVE                       2
> > +#define SC_V_QUALIFIER_EXT_VACTIVE           3
> > +#define SC_V_QUALIFIER_VPULSE                        4
> > +#define SC_V_QUALIFIER_EXT_VPULSE            5
> >  #define DC_DISP_DATA_ENABLE_OPTIONS          0x432
> >  #define DE_SELECT_ACTIVE_BLANK  (0 << 0)
> >  #define DE_SELECT_ACTIVE        (1 << 0)
> > @@ -493,6 +516,20 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define DC_DISP_CURSOR_POSITION_NS           0x441
> >
> >  #define DC_DISP_INIT_SEQ_CONTROL             0x442
> > +#define SEND_INIT_SEQUENCE                   BIT(0)
> > +#define INIT_SEQUENCE_MODE_SPI                       BIT(1)
> > +#define INIT_SEQUENCE_MODE_PLCD                      0x0
> > +#define INIT_SEQ_DC_SIGNAL_SHIFT             4
> > +#define INIT_SEQ_DC_SIGNAL_MASK                      (0x7 << INIT_SEQ_=
DC_SIGNAL_SHIFT)
> > +#define NO_DC_SIGNAL                         0
> > +#define DC_SIGNAL_VSYNC                              1
> > +#define DC_SIGNAL_VPULSE0                    2
> > +#define DC_SIGNAL_VPULSE1                    3
> > +#define DC_SIGNAL_VPULSE2                    4
> > +#define DC_SIGNAL_VPULSE3                    5
> > +#define INIT_SEQ_DC_CONTROL_SHIFT            7
> > +#define FRAME_INIT_SEQ_CYCLES_SHIFT          8
> > +
> >  #define DC_DISP_SPI_INIT_SEQ_DATA_A          0x443
> >  #define DC_DISP_SPI_INIT_SEQ_DATA_B          0x444
> >  #define DC_DISP_SPI_INIT_SEQ_DATA_C          0x445
> > --
> > 2.53.0
> >
> >
>
>
>
>
