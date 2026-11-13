Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48F606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zd0tUxLj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8332310EC43;
	Fri, 13 Nov 2026 15:41:31 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FEC10E818
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:41:25 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cdd9d0c9bbdso1472034a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794584485; cv=none;
 d=google.com; s=arc-20260327;
 b=rGu+Zyjho/9FHmSQnqT4HRsXNrPME6svChN7NEAbQEk7jf2cBHyCFfmfVv9bLyXqVu
 Gbsyw7hTseULcgrY0HmRduuHgn8anlsgzKLuf/0w0e4qGeFB4ip2eIJq6JrLf9RYpyjP
 7ORgY4H9b4zQFNTKukcnhViYz/F3aYWAanQrKO8XE+xuHsSC7HMqULrudSBHPFKxlbNV
 C2ULqsX2zs+dsakIJUZk+dgZbSamkH6Vpprpay5AyHkcqwzZAYtFrLsGXpkDWN9mSKe+
 7DrdAZi+gYicMwkKfZBN/NYRMGAQv0eqc0OqG9JdkpccvwXy2LQi4QM68x6LRxpRfBGC
 lxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ictCGGMxgCgpUNAPmSmusxCn54ZLVwNtSFzM9e1649k=;
 fh=EmxpF2SVw2co25xetdkrsgr4NaEFTJQmZAX9b56BB/0=;
 b=EtXf904NtJCIy1+NOn0t6Wmg8i9cos7DihZ3eIsSXbfcurbyK4bFIdSGOgGXqtO+6b
 hlVTkLS5VsBVM6ejwX8kZ2yTyW5gVTUi92BiGQTRrF7nvBCyWcFxfgzpdJcgicmLJM2x
 yAs3eM6bDFL2oZOKWDDyqQiwZ9TQuUtCTz0ApoHWR7qY1QC426o1oTGrwWsUPvIUgGuP
 smC1LqitirLWoADV1gglYA+447EcmKzwT7tv1tiN6WFYCvJioFJ6CWarSgD1BKcVQ4UP
 YryEFkSNRlNh9/Xgn/WrbBg2VEyPdDIJ0hBHKEHhz2EyXrSTGf10L7x5i2b4ilIgLNKx
 wDAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794584485; x=1795189285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ictCGGMxgCgpUNAPmSmusxCn54ZLVwNtSFzM9e1649k=;
 b=Zd0tUxLj8vpcKMXDpX4mpzDZAQyhG7Hn+QIZzg+SCHwleXwmB8me/5IOYwId/ZG2cB
 /lep0x6UNCBWP540SBjexgQbXPw1hWtbVCMc9l64h5YiCmNjwAuA5XslA/sLtq5ugL+V
 JqdCJWUSQ6xwHUMCWUe7+i2IlwfLNONX7Tg5gs+0v/KH5QmJtLmFWRtHYjwyTwGA+2F3
 CuKd/78Ut3guf3ihEiXkcM3nnfc6AIuz+EbBO0e/Tl+u+07fVWxSNwm5oEmlaQsyNk3j
 LI1s4FltmUNQRxhIYliiWhe2mAXe0mU8E3GC3Rk3cgpMen8WopIfzmVbfzai2LndFiyN
 Imtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794584485; x=1795189285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ictCGGMxgCgpUNAPmSmusxCn54ZLVwNtSFzM9e1649k=;
 b=NNvLecgJZMVt/93fsqQNnQx5iLoECKEK1EHLbmrNk7dDgzIDk6AZun77JA3+B2DZUU
 Ig+OB8wJzvn0BQ3eNQXUcF3BS05cfnA+esIFlRmvf2hhVGL54VTO/s+ezHccts7ReVWm
 bAYcg9vLlM4e1Ss/3FMYNVGsdTM3DddrO6VTifpY6TYYbQqK85yVLQ7rzCQlyRQ7RNXL
 rRr490vlT2sJRupgvZimQR6NZJuaLGbC7JealL5cvYYwVb7dagZN+shLGe9rjE7Pm/aQ
 f2ZQTpoOMpCbpwDP0E0vxgaun0lIZzlEj5uqZoyyqBgvOGn1G2+WmjNLtmvFcDR4qt30
 6Trw==
X-Forwarded-Encrypted: i=1;
 AL+hErHb1uH5E2ZlsB9nIacURfHgkr2kOcntxtd0WMlx9v6BGFIXu4u1h6ds3VZPe+Mdn6zWuqj1aB3VT7g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/NsXNLv5Tg2tVh3TDeuwEIyXfJb5SfVosZbaLRrF1WZkkHl9PI
 6W91H4FKvhFXvTrdAZU866U2fRfP1tvjm9DumrwawJ2CIAfwG648EBweVLR8Qw5VikQxaN4vP24
 uQGkLSamaCLE0F/Embvwu5BW6xWTSSbU=
X-Gm-Gg: AYBFou2XEvmlvKaSY5kwGHDS8C3cECH47Z+tpWGfJxpKonmUi7USQc+9NyGAOfbh4wq
 UxkO1DHg+htQ1t1OxmPicaaUKLjg+2D9D3ASw8J+Zb8zNkROlS18IjypP6av9Eb1L5MSb0UN3xS
 hsAGcHBrOCKqomSnV0EvP1yNDvgaxTs4L9vkrrFq+5mr9tZNXb5MVEsnI6MfaobN2IS160q2T+b
 OWqMz8Ozhkn9nDACiJ3FRaCDUnXOWKvrrwNARkuFdEtmEK1nSHtGtw9jlv1ntZ8gOTPoUi7TvZY
 E9cUz7di1Yw+vqaLufZ8OyWDbpmUEPvbSN/5Rcys1EXLUivImb7yv9hKIrZK5z/R5wXhA/J9hzY
 1EeaeN3DfQZMmiBkfOJjB+hrR04jtIBK8lO4IWJGBMM1juFD+swkGEagIMKGK2ar45C+zbYvCWc
 6hm8FwkUYe8+YyzV08VPtEG/1dE69WsA==
X-Received: by 2002:a05:7022:3c87:b0:16c:4eef:a526 with SMTP id
 a92af1059eb24-1b5030e2ee9mr2671578c88.15.1794584484844; Fri, 13 Nov 2026
 07:41:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101142435.130520-1-clamor95@gmail.com>
 <179370032880.793788.4424159880220279586@kernel.org>
In-Reply-To: <179370032880.793788.4424159880220279586@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Nov 2026 17:41:12 +0200
X-Gm-Features: AclHuK_BgAPnek8SSBsS7xD29UnkVImGVLvK3G9PVowz-sB26JLAqdiA-Cf1RLY
Message-ID: <CAPVz0n1E2bLOzKEC6_2iiPM5ZZ6-NOXuOkwx+jQYn8BRvPXwSw@mail.gmail.com>
Subject: Re: [PATCH v1] video: leds: backlight: lm3533: Support getting LED
 sources from DT
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
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

=D0=BF=D1=82, 13 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:5=
3 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Drop the 'video: ' part of the subject line.
>
> Please review, explain or fix the Sashiko review(s).
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
> > ---
> >  drivers/leds/leds-lm3533.c          | 60 +++++++++++++++++++++++++++++
> >  drivers/video/backlight/lm3533_bl.c | 45 ++++++++++++++++++++++
>
> Why are these being bundled up?
>
> What is the dependency?  If none, please separate.
>
> >  2 files changed, 105 insertions(+)
> >
> > diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> > index 7259097bd6a71..a1aeff70a90fc 100644
> > --- a/drivers/leds/leds-lm3533.c
> > +++ b/drivers/leds/leds-lm3533.c
> > @@ -26,6 +26,11 @@
> >  #define LM3533_ALS_CHANNEL_LV_MIN    1
> >  #define LM3533_ALS_CHANNEL_LV_MAX    2
> >
> > +#define LM3533_REG_OUTPUT_CONF1                      0x10
> > +#define   OUTPUT_CONF1_SHIFT                 2
> > +#define   OUTPUT_LVLED_MASK                  0x3
> > +#define LM3533_REG_OUTPUT_CONF2                      0x11
> > +#define   OUTPUT_CONF2_SHIFT                 6
> >  #define LM3533_REG_CTRLBANK_BCONF_BASE               0x1b
> >  #define LM3533_REG_PATTERN_ENABLE            0x28
> >  #define LM3533_REG_PATTERN_LOW_TIME_BASE     0x71
> > @@ -54,6 +59,9 @@ struct lm3533_led {
> >       u32 max_current;
> >       u32 pwm;
> >
> > +     int num_leds;
> > +     u32 leds[LM3533_LVCTRLBANK_MAX];
> > +
> >       bool have_als;
> >  };
> >
> > @@ -622,8 +630,36 @@ static const struct attribute_group *lm3533_led_at=
tribute_groups[] =3D {
> >
> >  static int lm3533_led_setup(struct lm3533_led *led)
> >  {
> > +     u32 output_cfg_shift =3D 0;
> > +     u32 output_cfg_val =3D 0;
> > +     u32 output_cfg_mask =3D 0;
> >       int ret;
> >
> > +     if (led->num_leds) {
> > +             for (int i =3D 0; i < led->num_leds; i++) {
> > +                     if (led->leds[i] >=3D LM3533_LVCTRLBANK_MAX)
> > +                             continue;
> > +
> > +                     output_cfg_shift =3D led->leds[i] * 2;
> > +                     output_cfg_val |=3D led->id << output_cfg_shift;
> > +                     output_cfg_mask |=3D OUTPUT_LVLED_MASK << output_=
cfg_shift;
> > +             }
> > +
> > +             /* LVLED1, LVLED2 and LVLED3 */
> > +             ret =3D regmap_update_bits(led->regmap, LM3533_REG_OUTPUT=
_CONF1,
> > +                                      output_cfg_mask << OUTPUT_CONF1_=
SHIFT,
> > +                                      output_cfg_val << OUTPUT_CONF1_S=
HIFT);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /* LVLED4 and LVLED5 */
> > +             ret =3D regmap_update_bits(led->regmap, LM3533_REG_OUTPUT=
_CONF2,
> > +                                      output_cfg_mask >> OUTPUT_CONF2_=
SHIFT,
> > +                                      output_cfg_val >> OUTPUT_CONF2_S=
HIFT);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       ret =3D lm3533_ctrlbank_set_max_current(&led->cb, led->max_curren=
t);
> >       if (ret)
> >               return ret;
> > @@ -698,6 +734,30 @@ static int lm3533_led_probe(struct platform_device=
 *pdev)
> >
> >       device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->=
pwm);
> >
> > +     /*
> > +      * If led-sources property is not set then either this Control Ba=
nk uses
> > +      * its default LVLED or is not linked to any LVLED at all.
> > +      */
> > +     led->num_leds =3D device_property_count_u32(&pdev->dev, "led-sour=
ces");
> > +     if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
> > +             dev_err(&pdev->dev, "num of LED sources exceeds max %d: %=
d\n",
>
> "Number "
>
> > +                     LM3533_LVCTRLBANK_MAX, led->num_leds);
> > +             ret =3D -EINVAL;
> > +             goto err_deregister;
> > +     }
>
> Could we move the 'led-sources' parsing above led_classdev_register(),
> or convert the driver to devm_led_classdev_register() and use 'return
> dev_err_probe()' here?
>

I will convert to devm_led_classdev_register() as precursor to this patch.

> > +     if (led->num_leds < 0)
> > +             led->num_leds =3D 0;
> > +
> > +     if (led->num_leds > 0) {
> > +             ret =3D device_property_read_u32_array(&pdev->dev, "led-s=
ources",
> > +                                                  led->leds, led->num_=
leds);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "failed to get led-sources\n"=
);
> > +                     goto err_deregister;
> > +             }
>
> dev_err_probe()
>
> > +     }
> > +
> >       ret =3D lm3533_led_setup(led);
> >       if (ret)
> >               goto err_deregister;
> > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backli=
ght/lm3533_bl.c
> > index adcd6ac7cf229..e8164c8528577 100644
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
> > +     if (bl->num_leds) {
> > +             for (int i =3D 0; i < bl->num_leds; i++) {
> > +                     if (bl->led_strings[i] >=3D LM3533_HVCTRLBANK_COU=
NT)
> > +                             continue;
> > +
> > +                     output_cfg_val |=3D ctrlbank << bl->led_strings[i=
];
> > +                     output_cfg_mask |=3D BIT(bl->led_strings[i]);
> > +             }
>
> This for loop doesn't need to be in the if statement.
>

It is in if statement because if node has no "led-sources"
LM3533_REG_OUTPUT_CONF1 should not be touched and must be left in its
default state.

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
> > @@ -320,6 +342,29 @@ static int lm3533_bl_probe(struct platform_device =
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
> > +     if (bl->num_leds > LM3533_HVCTRLBANK_COUNT) {
> > +             dev_err(&pdev->dev, "num of LED sources %d exceeds max %d=
\n",
> > +                     bl->num_leds, LM3533_HVCTRLBANK_COUNT);
> > +             return -EINVAL;
> > +     }
>
> dev_err_probe()
>
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

Other suggestions are valid, I will apply them in v3

> --
> Lee Jones
