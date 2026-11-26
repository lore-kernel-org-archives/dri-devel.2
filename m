Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C8606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DhlKTRkL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F404B10E308;
	Thu, 26 Nov 2026 12:20:26 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E740B10E308
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:20:20 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-3863db981d4so9794450eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 04:20:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795695620; cv=none;
 d=google.com; s=arc-20260327;
 b=XNGwFWq8iCHcWym5OVAGZEz0roaf6KnGTbI/GP8pw3cp2nRucZm+PoYUqzEVaCEZHv
 fCmuRr24figuWyZSeJCvt3UVi0UY1NcN/ooTRnTdEFmIVVgNqcnjAzHgEWjDMGJaXIcy
 xulLF69zL2u/xN83/nFNq/plOfjKYbnlt7651HZKoFxFkoPAuPUV/AoKxbTSn78ItRTu
 zJRpDWu59WfE2NDysj54J2ozX0b44V6sYPvQITmqNFUPWz7mWGoYCJyYx1vCR2b0ucQM
 2OJjnGhAOM+/6qZD1KYi9MybeNaYRl/ioBgjvIIoZDC9+ygJYYIq4ER+4VBU0xMyC11m
 OGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+lSvuZp8Y17eXoO25lsbfQdbZJVTJnq/pMdU2BkHd48=;
 fh=GUSXumWaaeZl2CMlFv3OilDLlM/mriwVHKmyjMHK0x4=;
 b=cJWIMKaRT5T+123Lb0XAuq/0tSSbK3QgP4hv7KcDxb2yt135lVOWvDq/CGJBpk3udJ
 K1Qy4k++kOSkk0hSLLz/i5MdoGMB1/N0Sc5RO3AvTCc5vszArJsAhOVI07KWdIU7CEK9
 cNUHXsAiBFHRZ1wsmFKbVatOdmqLWzxwtBLhmCtcf9hOHMdN7I06XuGEFxA/i7e2RrVU
 hUs96xhp+KAVwZ+E2qJ62aq1ggKnjJ0HEFWN1NqMLQ/EQJXQedRRqGcAfbj2S8qxHiGa
 jJ9nBXr0gh0fUt3ZoXM8+Ian5S6FSfU1JIKLPSzH2O/+TKegpykMsDp9amwXuU5gYV1K
 qZAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795695620; x=1796300420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+lSvuZp8Y17eXoO25lsbfQdbZJVTJnq/pMdU2BkHd48=;
 b=DhlKTRkLLoG8aYGiEZMSPsNQoEkTu4xoMS011yQfa1FnSXu/DyyW/oVTajL+LUEolL
 EQhZQ2iofi5OkRnE4ks22PDCRIe51xO+36WNMAMBh5g8oPw6hv6cM3S/zspLPGo3UXH4
 QYA50kOiYMRE2by4Kk5B6n32VfoczULJAy1EyiroZ3q0L82SNtYwGGHTQ6PiZlN6379D
 OrxMgMr60lro/yNGxYKa8WcBFl02EHYC3K9qhPWtL/rtFxZujU2RSKdH6WEwoGP40HDP
 r2MfEmqfHQ2PsbihCJQolpeaVUSw7le7wYmPbGoPf9YN4CFLWFDIxDGEqHlUyV/JkAwT
 zJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795695620; x=1796300420;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+lSvuZp8Y17eXoO25lsbfQdbZJVTJnq/pMdU2BkHd48=;
 b=LatrCN3xFSatOrw+DU3RFpJ03t9lwlfNP5bGIIjsWkndShfchulX6UMd56tfikpXtE
 kYi8MFwuRSp0XjGL/rNX5GKL0/+dnf4NLxw4o7bEPXLLDBJLkcn/EchGczE2pUCKUJUS
 oP2UjAKKdj7VcIJ1ITYOWVzM24JxZRXnQzW73kk64xvZGC3A/tS9ZUC3w+p3PWfaHSkA
 a7eN9vV0AyfruZU6TDdDiDoG9aBirFMCkO01Pn8mC0A/GsZgEvXco8He4RggthnpdWqY
 VoU2m61DQkIy3EmNZvk+NeWZlm8mtZO7xmQqLeh21LST2UJa7e8tjpUu07GHAQcg5BAc
 7APg==
X-Forwarded-Encrypted: i=1;
 AL+hErFPPcq5eT5CBsIXkCCbxkxHc5I5x3JqSeHfFV5DIrMEeHamob5mpYz4Beg42H8NuXFUSZcTOfDtE3g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9MjPEA9EIKIWIJHJw3pVpknmsd1y4W0lkfAo6497U8nhxQ/CwE
 L34poHOuKr7VGuVfj14TX5dAremNfkptc78IHJMSv+bqUFC93WNWyZ++rCL06Uh9svvIRaMvbbl
 eBQi+icBwk1ACBKP8MP7jSlSrC6TIVN4=
X-Gm-Gg: AZFdTZe9asr6nEJNouyGJbNUzts96CyZgNsWYSjiKJhQEHqL9ZfEkyrmZR3Wbn7UPjW
 u5IVYqN+ZIu3nxn0Gn684339LiU0S9KmVGZGemKb4F+2MRRu6kC7Cis1rmOOsYU73UnuQLphH7d
 65ViH9U24jeE8kSRyEnaQjDrGo/R51BMrC1J2ahx4ofv/DlW11OW3RAYI4NZtFIRtdLl3wMDMKL
 5vJ0CdGsg6sxbnWYXYcUwOsYuqWoPM+8RNc+iCJmHZXMgiUPy5ID7wuaJOrsX9IUIvGUEktD0bb
 s7hw1IcT1UrkX4wDmLZt9jFCBOhFfNXiIB1xWDmZypnK5mok1jjq889KD57f3sEdlSh2y2LlHDN
 Vr/DumfaHHaCs9YCvsVa2IOqvTT++oWAb3J03B9/b6KgHCr8RB6JjlGtozHCu8c+T56muaCiQL6
 f7LZyULux/0Q2wVOrjDcIVtIszHEjdkm2VP7jssCdad78fxs1NrJc=
X-Received: by 2002:a05:7301:929:b0:376:37a2:87f3 with SMTP id
 5a478bee46e88-38570f25262mr19450186eec.31.1795695620162; Thu, 26 Nov 2026
 04:20:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115085155.80043-1-clamor95@gmail.com>
 <20261126114506.GF38590@joneslee-macbookpro.roam.internal>
In-Reply-To: <20261126114506.GF38590@joneslee-macbookpro.roam.internal>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 26 Nov 2026 14:20:08 +0200
X-Gm-Features: Aa3M54qVnLT4LX9aypLg829C8Q--H88cVFtiIS6wh8smfquZHuMzs0sW-CXGNDk
Message-ID: <CAPVz0n1QApS9Y67WH1xJ34wg9AWz+RQ0DXEd5jAPEnAw=cTd2g@mail.gmail.com>
Subject: Re: [PATCH v3] video: leds: backlight: lm3533: Support getting LED
 sources from DT
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D1=87=D1=82, 26 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
5 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 15 Nov 2026, Svyatoslav Ryhel wrote:
>
> > Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> > defined in the device tree.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> > ---
> > This was part of the original LM3533 controller DT/OF conversion patchs=
et,
> > but it appears to have been accidentally separated during the final ite=
ration.
> > Therefore, I am sending it as a follow-up.
> >
> > Changes in v2:
> > - leds: switch to macros in regmap_update_bits() calls to apply 0xff ma=
sk
> >   since regmap writes may cause unwanted writing.
> >
> > Changes in v3:
> > - leds part moved into a separate patchset
> > - switched to dev_err_probe()
> > - for loop moved out of if condition
> > ---
> >  drivers/video/backlight/lm3533_bl.c | 44 +++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backli=
ght/lm3533_bl.c
> > index fd6e7f4f1f61c..cb9df6ff73001 100644
> > --- a/drivers/video/backlight/lm3533_bl.c
> > +++ b/drivers/video/backlight/lm3533_bl.c
> > @@ -7,6 +7,7 @@
> >   * Author: Johan Hovold <jhovold@gmail.com>
> >   */
> >
> > +#include <linux/bits.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/platform_device.h>
> > @@ -21,6 +22,7 @@
> >  #define LM3533_HVCTRLBANK_COUNT              2
> >  #define LM3533_BL_MAX_BRIGHTNESS     255
> >
> > +#define LM3533_REG_OUTPUT_CONF1              0x10
> >  #define LM3533_REG_CTRLBANK_AB_BCONF 0x1a
> >  #define   CTRLBANK_AB_BCONF_ALS(n)   BIT(2 * (n))
> >  #define   CTRLBANK_AB_BCONF_MODE(n)  BIT(2 * (n) + 1)
> > @@ -35,6 +37,9 @@ struct lm3533_bl {
> >       u32 max_current;
> >       u32 pwm;
> >
> > +     int num_leds;
> > +     u32 led_strings[LM3533_HVCTRLBANK_COUNT];
> > +
> >       bool have_als;
> >       bool linear;
> >  };
> > @@ -236,6 +241,8 @@ static const struct attribute_group *lm3533_bl_attr=
ibute_groups[] =3D {
> >  static int lm3533_bl_setup(struct lm3533_bl *bl)
> >  {
> >       int ctrlbank =3D lm3533_bl_get_ctrlbank_id(bl);
> > +     u32 output_cfg_val =3D 0;
> > +     u32 output_cfg_mask =3D 0;
> >       int ret;
> >
> >       ret =3D regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCO=
NF,
> > @@ -243,6 +250,21 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
> >       if (ret)
> >               return ret;
> >
> > +     for (int i =3D 0; i < bl->num_leds; i++) {
> > +             if (bl->led_strings[i] >=3D LM3533_HVCTRLBANK_COUNT)
> > +                     continue;
> > +
> > +             output_cfg_val |=3D ctrlbank << bl->led_strings[i];
> > +             output_cfg_mask |=3D BIT(bl->led_strings[i]);
> > +     }
> > +
> > +     if (bl->num_leds) {
> > +             ret =3D regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_=
CONF1,
> > +                                      output_cfg_mask, output_cfg_val)=
;
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       ret =3D lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current)=
;
> >       if (ret)
> >               return ret;
> > @@ -320,6 +342,28 @@ static int lm3533_bl_probe(struct platform_device =
*pdev)
> >
> >       device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->p=
wm);
> >
> > +     /*
> > +      * If led-sources property is not set then either this Control Ba=
nk uses
> > +      * its default HVLED or is not linked to any HVLED at all.
> > +      */
> > +     bl->num_leds =3D device_property_count_u32(&pdev->dev, "led-sourc=
es");
> > +     if (bl->num_leds > LM3533_HVCTRLBANK_COUNT)
> > +             return dev_err_probe(&pdev->dev, -EINVAL,
> > +                                  "num of LED sources %d exceeds max %=
d\n",
>
> Nit: As I mentioned before, this is user-documentation - should be number=
?
>

Daniel Thompson was fine with num

> > +                                  bl->num_leds, LM3533_HVCTRLBANK_COUN=
T);
> > +
> > +     if (bl->num_leds < 0)
> > +             bl->num_leds =3D 0;
> > +
> > +     if (bl->num_leds > 0) {
> > +             ret =3D device_property_read_u32_array(&pdev->dev, "led-s=
ources",
> > +                                                  bl->led_strings,
> > +                                                  bl->num_leds);
> > +             if (ret)
> > +                     return dev_err_probe(&pdev->dev, ret,
> > +                                          "failed to get led-sources\n=
");
> > +     }
> > +
> >       ret =3D lm3533_bl_setup(bl);
> >       if (ret)
> >               return ret;
> > --
> > 2.53.0
> >
>
> --
> Lee Jones
