Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7281DC44529
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A821010E780;
	Mon, 20 Jul 2026 07:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PUmpPVPw";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1BC10F4DA
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:12:20 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so1688225e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784283139; x=1784887939; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3RJV9UC3pnAaTAcgCOuWlBvuu7N+6toEb+Gnb0umxzY=;
 b=PUmpPVPwdraTOFSkACpudkOLV107LWXgcmK++RnjSJy3M7Tocpl5OkbWXTUQfjIxH/
 aWDxvgbLmGJIvro4pNzrS8bzRno9K1Zlcc5r/+bPNNmxiH7rTlwmfN9cHmSpa519q+Zd
 sR/dQ7iPKfqz+JmlQ72wDCSJPchA/83re2u/ZyiewN040H5Q1qJ3nWARnYET/Kf4AdHt
 l0GosNB948/WdRfPskAf4K68jLJz1GgBdDYcQOdcy+gKWV/yDLpZ7Kshu7pGLUBFDpgJ
 cYNdnTshnnjcK5hnAG3pSL3Fo6EQB7sbeaTI6kQPdzGgCALzIOo0HXXAJeKJsmY6nXF3
 ftgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784283139; x=1784887939;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3RJV9UC3pnAaTAcgCOuWlBvuu7N+6toEb+Gnb0umxzY=;
 b=Dwd70SVmJIHipvOhysBldnY5sL86eo/3Uq6ThoRbwOc2WgP7B5cZwZpIFqrpa8RuGO
 npGvRWyngjYW24QwWV2O8ImnKbDtRkmcJmG0S+EuipG5d/HX8GbCqS8DDMBNdZGEdy6A
 uhsRdJrrrBGMawSg512bRvzXkGmXGnsgdn+SVGi7t4953/bwGbANdbXbAVzlkVDzhWwc
 /pz0qSBrZXQvU1svBZDgqvoTLumAZhpepyaoD6Atmnct/TMUMsVsHkL3NP25xiyfgO0V
 /e9iFbfqh0MsJNG8jUGjfGzvOd69DE89/JmnjYnHQbwiI01v68p+hVoPIEwQk6fpRxbS
 1LWw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6qez1YCjzNub6BIxq+PuUysclpHhxMsLOcl2NMtkYWJv837z7u5ZmmCKFuaVFWz7cSlfHsEhrUOw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+vMo64cK5DmfLmfkrAN9aNCicJtvEjwu4oqsaVd0Jebwfqokb
 u3vJjxZmITN3c4NA4iJaaU39Ug4aXcEIf3FXWKUGQU7JvF+bTLrQZ0KQHOk0Chmd
X-Gm-Gg: AfdE7clqcEYDQH3yEqSDjKa8uPAykOlhHnQOcm0OIj8IGgmfAgpb4nNESWsTdtomy5G
 GosJdbGP6bh1ipbEFdq5q4szQbBW7QUAVGrk0GPkwe6nJKmqb4MHgRfcDg1tvnJ8BSTguJwHqWw
 WYsXblUbscJzcOHP2O2XX9Jnkhc2Hhuf1wbSx/xRhkhc6RrGlFF1kMS4tblkYR83DyNAJw0S2F7
 3+yPYs62aBDHLa46Y/g0FfVoiUDP0zoc+WoF0k5HmkT5+vMLheFpt6rckKrfQQ5h/e9ShPtvEem
 JxybjfQahWicUCUTxFarBGOcFaFaRySHuDmTpkH2q1RrxglCJUpVcNaVKiuPkvAqyjpOT6eDH6f
 x1ks9leR0MIdcvswUQ4zhmjEmrq0rTQEVLyqHVbu3tXz4F/bD+pSUXcC6PoXpxvcu9v9dUyTPEU
 JGnH0TaADsBnaoD30e4ODq8diRkjHrJ0UA/eHQEg==
X-Received: by 2002:a05:600d:10c:b0:495:409e:bc80 with SMTP id
 5b1f17b1804b1-4954a51b852mr13770135e9.37.1784283138775; 
 Fri, 17 Jul 2026 03:12:18 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm2846908f8f.11.2026.07.17.03.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:12:18 -0700 (PDT)
Date: Fri, 17 Jul 2026 13:12:17 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 jesszhan0024@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: ilitek-ili9805: Use _multi variants
Message-ID: <aloAAaC1FuDqT8Rd@michalis-linux>
References: <allWpYxgHfpKughy@michalis-linux>
 <CAD=FV=Wez4s5gUPXN=DuHvHAk4esBMGfh4Rj=ww72UK7VUbOzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Wez4s5gUPXN=DuHvHAk4esBMGfh4Rj=ww72UK7VUbOzw@mail.gmail.com>
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

On Thu, Jul 16, 2026 at 04:31:53PM -0700, Doug Anderson wrote:

Hello Doug, thanks a lot for the review!

> Hi,
> 
> On Thu, Jul 16, 2026 at 3:09 PM Michail Tatas <michail.tatas@gmail.com> wrote:
> >
> > @@ -159,36 +159,23 @@ static int ili9805_power_off(struct ili9805 *ctx)
> >
> >  static int ili9805_activate(struct ili9805 *ctx)
> >  {
> > -       struct mipi_dsi_device *dsi = ctx->dsi;
> > -       struct device *dev = &dsi->dev;
> > -       int i, ret;
> > +       struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> > +       int i;
> >
> >         for (i = 0; i < ctx->desc->init_length; i++) {
> >                 const struct ili9805_instr *instr = &ctx->desc->init[i];
> >
> > -               ret = mipi_dsi_dcs_write_buffer(ctx->dsi, instr->data, instr->len);
> > -               if (ret < 0)
> > -                       return ret;
> > +               mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data, instr->len);
> >
> >                 if (instr->delay > 0)
> > -                       msleep(instr->delay);
> > -       }
> 
> What you've done is an improvement, but it's not all the way there.
> Specifically, we'd really want to get rid of the whole "struct
> ili9805_instr" type and instead each panel should have an init
> function. The "struct ili9805_desc" should have a pointer to the init
> function instead of a pointer to the init data.

I am more than happy to do these changes as well. My only concern is
that I do not have hardware to test the panel. Are compiling and static
analysis sufficient tests for these changes ?

> For details, you can see a preivous email about this [1], which then
> has further links if you want to dig into details. You can see that
> Chintan eventually implemented this in commit a89d9a327d06
> ("drm/panel: novatek-nt36672a: Inline panel init sequences").
> 
> If landing this patch without cleaning up the init sequences is really
> important to you, I could be convinced. However, the init sequences
> aren't all that big and it would be nice if you could clean it up all
> at once. It could be one patch or two.
> 

It is not all that important, I can clean up the init sequences and
send it as part of the v2

> [1] http://lore.kernel.org/r/CAD=FV=UCyfjiqcpYCM5ePz-auX4g=i_+i78ivvvyA8R1XtAKzg@mail.gmail.com
> 
> 
> > @@ -211,25 +198,13 @@ static int ili9805_prepare(struct drm_panel *panel)
> >
> >  static int ili9805_deactivate(struct ili9805 *ctx)
> >  {
> > -       struct mipi_dsi_device *dsi = ctx->dsi;
> > -       struct device *dev = &dsi->dev;
> > -       int ret;
> > -
> > -       ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
> > -       if (ret < 0) {
> > -               dev_err(dev, "Failed to set display OFF (%d)\n", ret);
> > -               return ret;
> > -       }
> > +       struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> >
> > -       usleep_range(5000, 10000);
> > -
> > -       ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> > -       if (ret < 0) {
> > -               dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
> > -               return ret;
> > -       }
> > +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> > +       mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
> > +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> >
> > -       return 0;
> > +       return dsi_ctx.accum_err;
> 
> Nobody looks at the return code of this function. Since you're
> touching it anyway, can you change ili9805_deactivate() to return
> "void"? I wouldn't object if you made ili9805_power_off() return
> "void" in the same patch too, even though it's a bit unrelated to the
> rest of the patch.
> 

Good point regarding the return types, I will change them to
return void.

I will send a v2 with the requested changes.

Regards,
Michail
