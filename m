Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341F606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JorL3aJo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267B910E3B7;
	Thu, 26 Nov 2026 12:46:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727B010E3B7
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:46:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19DEB42369;
 Thu, 26 Nov 2026 12:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D33A1F000CF;
 Thu, 26 Nov 2026 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795697169;
 bh=rdckaT7Rt0EQb8wTCfji2xEphbWqzL0dz1XZ9l8Clsc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JorL3aJoW2gdhWICjJZWD9lShxKhQ3aR0FERUD/a77KVrVtieN41jVosl/Ng8vteW
 e6zG24bGmaK33JWWjSlqLWYtW04LUWdomEe99l3sFtRjQoIaTzqWjIEvvWPFK6wsfU
 Onjp4PZYkYghGmM6w+W8yDHQRobbwtj9+secXT8gVa+iOzTk2nHnoxkbp9ilciyYOE
 yB7orAik8emW3NxVWiTDMq8VRJXNAqzjiIqb06uWgVhwu3yAtGBMcXF0dIVH2OadCx
 wmfkKIjlrp6IFAtnJ8bsNGiwKsyHzeNaKZXzyJHmbvq78PjtVFGkn4qiYIufExgQyj
 cjHDti7AVJzzQ==
Date: Thu, 26 Nov 2026 12:46:05 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Message-ID: <20261126124605.GI38590@joneslee-macbookpro.roam.internal>
References: <20261115085155.80043-1-clamor95@gmail.com>
 <20261126114506.GF38590@joneslee-macbookpro.roam.internal>
 <CAPVz0n1QApS9Y67WH1xJ34wg9AWz+RQ0DXEd5jAPEnAw=cTd2g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1QApS9Y67WH1xJ34wg9AWz+RQ0DXEd5jAPEnAw=cTd2g@mail.gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026, Svyatoslav Ryhel wrote:

> чт, 26 лист. 2026 р. о 13:45 Lee Jones <lee@kernel.org> пише:
> >
> > On Sun, 15 Nov 2026, Svyatoslav Ryhel wrote:
> >
> > > Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> > > defined in the device tree.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> > > ---
> > > This was part of the original LM3533 controller DT/OF conversion patchset,
> > > but it appears to have been accidentally separated during the final iteration.
> > > Therefore, I am sending it as a follow-up.
> > >
> > > Changes in v2:
> > > - leds: switch to macros in regmap_update_bits() calls to apply 0xff mask
> > >   since regmap writes may cause unwanted writing.
> > >
> > > Changes in v3:
> > > - leds part moved into a separate patchset
> > > - switched to dev_err_probe()
> > > - for loop moved out of if condition
> > > ---
> > >  drivers/video/backlight/lm3533_bl.c | 44 +++++++++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >
> > > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> > > index fd6e7f4f1f61c..cb9df6ff73001 100644
> > > --- a/drivers/video/backlight/lm3533_bl.c
> > > +++ b/drivers/video/backlight/lm3533_bl.c
> > > @@ -7,6 +7,7 @@
> > >   * Author: Johan Hovold <jhovold@gmail.com>
> > >   */
> > >
> > > +#include <linux/bits.h>
> > >  #include <linux/module.h>
> > >  #include <linux/init.h>
> > >  #include <linux/platform_device.h>
> > > @@ -21,6 +22,7 @@
> > >  #define LM3533_HVCTRLBANK_COUNT              2
> > >  #define LM3533_BL_MAX_BRIGHTNESS     255
> > >
> > > +#define LM3533_REG_OUTPUT_CONF1              0x10
> > >  #define LM3533_REG_CTRLBANK_AB_BCONF 0x1a
> > >  #define   CTRLBANK_AB_BCONF_ALS(n)   BIT(2 * (n))
> > >  #define   CTRLBANK_AB_BCONF_MODE(n)  BIT(2 * (n) + 1)
> > > @@ -35,6 +37,9 @@ struct lm3533_bl {
> > >       u32 max_current;
> > >       u32 pwm;
> > >
> > > +     int num_leds;
> > > +     u32 led_strings[LM3533_HVCTRLBANK_COUNT];
> > > +
> > >       bool have_als;
> > >       bool linear;
> > >  };
> > > @@ -236,6 +241,8 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
> > >  static int lm3533_bl_setup(struct lm3533_bl *bl)
> > >  {
> > >       int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
> > > +     u32 output_cfg_val = 0;
> > > +     u32 output_cfg_mask = 0;
> > >       int ret;
> > >
> > >       ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
> > > @@ -243,6 +250,21 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
> > >       if (ret)
> > >               return ret;
> > >
> > > +     for (int i = 0; i < bl->num_leds; i++) {
> > > +             if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
> > > +                     continue;
> > > +
> > > +             output_cfg_val |= ctrlbank << bl->led_strings[i];
> > > +             output_cfg_mask |= BIT(bl->led_strings[i]);
> > > +     }
> > > +
> > > +     if (bl->num_leds) {
> > > +             ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
> > > +                                      output_cfg_mask, output_cfg_val);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > >       ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
> > >       if (ret)
> > >               return ret;
> > > @@ -320,6 +342,28 @@ static int lm3533_bl_probe(struct platform_device *pdev)
> > >
> > >       device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
> > >
> > > +     /*
> > > +      * If led-sources property is not set then either this Control Bank uses
> > > +      * its default HVLED or is not linked to any HVLED at all.
> > > +      */
> > > +     bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
> > > +     if (bl->num_leds > LM3533_HVCTRLBANK_COUNT)
> > > +             return dev_err_probe(&pdev->dev, -EINVAL,
> > > +                                  "num of LED sources %d exceeds max %d\n",
> >
> > Nit: As I mentioned before, this is user-documentation - should be number?
> >
> 
> Daniel Thompson was fine with num

I'm not.  I'll let 'max' slide, but not 'num'.

-- 
Lee Jones
