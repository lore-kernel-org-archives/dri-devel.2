Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C498AFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 20:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E1810E075;
	Tue, 28 Apr 2026 20:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PGmyYgsA";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CC510E075
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:52:46 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-ba51e69988aso1625370366b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777409561; x=1778014361;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m374ejHVkN8x1TuhNLKUGmcEUyzd0vEuAltwe0+QC9k=;
 b=PGmyYgsAKW/1yP0xFzI/ooEj5CcOT8e7vAEea3UAAjd6xV+jaJdBehZbtCCrHdieN/
 u07cpJMPcxFJvky0NE7Xkp9Rqd+bBUS7u30XwbzTE3DLZ8JWw3Yex5ruBja8BugPwRSy
 ekMqcTBya/rBn8v4ZuJH7/foz4vIhxLHAvZ7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777409561; x=1778014361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m374ejHVkN8x1TuhNLKUGmcEUyzd0vEuAltwe0+QC9k=;
 b=bKCcq61wrMTJ/E1hJIm/G5SRsHRPs78oXNHF4rfRFhG4v/9O1Gzut3rA+zLh0cX1T0
 PQNEeJOYIQvAzr7XRg/AFPNwR9apUFsfuK7QTKyYKZ19RSEc8lbKkRZwHHnRVFXG7FLL
 6YoK5EqPrVR2vRCorpESCqPAcn7fteXyig0nRDPeyTgdIRl7WEyc+4BDETfYHOIEys2V
 4HNGKrEDsy5B8FU8T6Q9rRy5uaCqPJaoHzBFammjGq9YMmqSJEpe6zW60we5gz7xczcF
 s+xjkgEnhnBKlXg1FuoFl5cJWhEn0rB41pBuKNrqrh6kS9PhOwDlVGSMVqsjhb2NuBbx
 pRVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8wz2Vw5B3putyk5rtrVvQIkm5BtrMvFagPzE3schSwdjp/pLrpedsUeKqgE9lwfApqctc65tc6vw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz17wYcSveftg422Huo5P1t5QUmLl/rjio1oGksJn10Hu370NFv
 CCet3ZuGiEKr+LV/fL0FNXkKWH2R7V9CxQtc/+/U2azt/spj0D6Cz8O04ptZZbxqNPPAylYN1My
 /xkd8GVC0
X-Gm-Gg: AeBDievq7MZACpVI4Oosozx05XXFvA+Qo+YPMnEdSaX7QEgV36MB3neFNjI0lXshEO0
 E3MVWElB1xHYoumTK/puv1KDRfsumYxu0Fbe1aEUHa2nBA3t8cc2xwavNHANVnaSC1oEgvzmCqE
 zRknRzErAqwI2T+PKkS2umVYfIU5QfoTUDkUnXt34xh/Eywmmp5ckJzC5EHVSZODqR2vw+d4Zyx
 pyrQ3QhQmZpCxKfMI2RWUv9hV5YXzhKGyy8RpPS443Yg2EbPL1TuxU/0ynjPFRO+VETv9x8eE8m
 7tfz6xAFW0WFE20sDRHq62rOc+r4jDDOHF6EsBBkf8atv7sWhCrjKvUMD73bvoSJF82IW7sTw6E
 muEfevsKCsi9gyBhJPnr8oJbWHSc39oGI4WH4Cx5IvVyVFouFMCcp7ytDexlg/dJk4BcwTOWFmp
 AEA2eHISGEwGLKcNL8b7SQNDvnXpZc8xEwZs/A/6xK3k0nUp9uOySQUOBbX0Vood+QoYIU09Ao
X-Received: by 2002:a17:907:ca13:b0:ba4:d724:1730 with SMTP id
 a640c23a62f3a-bb8027bb403mr202823966b.20.1777409560635; 
 Tue, 28 Apr 2026 13:52:40 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb808633631sm147125566b.13.2026.04.28.13.52.37
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 13:52:40 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-446fea16729so780489f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:52:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ozh/rNZQcfFcwyBKdyZgO6jwcRuxwD0TCQFxxS4ychQT6UQ/IhBW+aelgk8a3xGBD7C0c0ga81A8=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2f84:b0:43d:1c21:ead5 with SMTP id
 ffacd0b85a97d-4464a16848bmr8613675f8f.22.1777409557072; Tue, 28 Apr 2026
 13:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
 <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
 <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com>
 <151c1c1d52fce8c3b1dac3a919be3086ce3426df.camel@iscas.ac.cn>
 <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com>
 <d349eb9a8632d847eca48ece1e6c88b717dddde1.camel@iscas.ac.cn>
In-Reply-To: <d349eb9a8632d847eca48ece1e6c88b717dddde1.camel@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 Apr 2026 13:52:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=USy4DWrkKrhqbUGR5JWJzcJz_J1PVt0Z=o_LVn_iON-w@mail.gmail.com>
X-Gm-Features: AVHnY4LgWSJRzWB0fzS8RfQGwiEMjDHAlIcbWfHHNuwDg0u8vOyHNSvhg_5QJiY
Message-ID: <CAD=FV=USy4DWrkKrhqbUGR5JWJzcJz_J1PVt0Z=o_LVn_iON-w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Hi,

On Tue, Apr 28, 2026 at 9:12=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> =E5=9C=A8 2026-04-28=E4=BA=8C=E7=9A=84 08:56 -0700=EF=BC=8CDoug Anderson=
=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >
> > On Tue, Apr 28, 2026 at 8:53=E2=80=AFAM Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > >
> > > =E5=9C=A8 2026-04-28=E4=BA=8C=E7=9A=84 08:48 -0700=EF=BC=8CDoug Ander=
son=E5=86=99=E9=81=93=EF=BC=9A
> > > > Hi,
> > > >
> > > > On Mon, Apr 27, 2026 at 10:49=E2=80=AFPM Icenowy Zheng
> > > > <zhengxingda@iscas.ac.cn> wrote:
> > > > >
> > > > > =E5=9C=A8 2026-04-27=E4=B8=80=E7=9A=84 11:24 -0700=EF=BC=8CDoug A=
nderson=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > Hi,
> > > > > >
> > > > > > On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng
> > > > > > <zhengxingda@iscas.ac.cn> wrote:
> > > > > > >
> > > > > > > When preparing the panel, it seems that it always expects
> > > > > > > commands
> > > > > > > to be
> > > > > > > transferred in LP mode. However, the disable function
> > > > > > > removes
> > > > > > > the
> > > > > > > MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> > > > > > >
> > > > > > > As the unprepare function contains no DSI commands, re-
> > > > > > > adding
> > > > > > > the
> > > > > > > flag
> > > > > > > just after disabling the panel should be safe. Add the code
> > > > > > > re-
> > > > > > > adding
> > > > > > > the flag after the two commands for disabling the panel are
> > > > > > > sent.
> > > > > > >
> > > > > > > This fixes screen unblanking (after blanking once) on
> > > > > > > mt8188-geralt-ciri-sku1 device.
> > > > > > >
> > > > > > > Cc: stable@vger.kernel.org # 6.11+
> > > > > > > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out
> > > > > > > as
> > > > > > > separate driver")
> > > > > >
> > > > > > This "Fixes" looks wrong. The bug was still there even before
> > > > > > the
> > > > > > driver was broken out. ...and it looks like the driver that
> > > > > > this
> > > > > > was
> > > > > > broken out of (panel-boe-tv101wum-nl6.c) still has the same
> > > > > > bug?
> > > > >
> > > > > Yes, but I think the fix shouldn't be propagated to the other
> > > > > driver
> > > > > because of the same reason with breaking out the original
> > > > > driver.
> > > >
> > > > ...but doesn't all the same logic apply to the other driver?
> > > > Nothing
> > > > ever adds MIPI_DSI_MODE_LPM back in.
> > > >
> > > > Even if you don't fix the other driver yourself right now, the
> > > > proper
> > > > "Fixes" tag is when the problem was introduced, not when the
> > > > driver
> > > > forked out.
> > >
> > > I think the Fixes tag should point to where the driver is forked
> > > out,
> > > and if I'm going to send a patch for panel-boe-tv101wum-nl6, it
> > > will
> > > has a Fixes tag pointing to the further commit affecting that
> > > driver.
> >
> > You're free to have your own opinion, but that doesn't match my
> > understanding of the Fixes tag. If you can convince Neil or some
> > other
> > drm-misc committer to land your changes with the Fixes tag as you
> > have
> > it, then I won't object, but I won't land it. Best of luck!
>
> I checked the forking commit, and the forking process doesn't involve
> moving a `dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM` clause from the panel-
> boe-tv101wum-nl6 driver to the panel-himax-hx83102 driver, which means
> that this clause in the new driver is new, and shouldn't be trivially
> backported to the old driver (because this process will affect other
> non-hx83102 panels in that driver). Even if the unblanking issue exists
> before the forking point, the specific code fixed by this commit is
> created by the forking point (just by copying), instead of the previous
> commit introducing the starry panel or the initial addition of the LPM
> masking code to panel-boe-tv101wum-nl6 .

In general in Linux drivers support more than one device. If you have
a fix for a driver, then you make the fix. You don't couch your fix
with "if (this_is_the_device_i_tested) do_my_fix()"

Said another way, if we hadn't forked support of this panel into a
separate driver, then you'd _have_ to be fixing to
panel-boe-tv101wum-nl6 driver, correct? You wouldn't add a special
case just for your panel--you'd fix it for the whole driver.

Another argument here is that someone could (conceivably) still have
an old kernel built from before the driver forked out. Maybe they care
about supporting "panel-himax-hx83102" panels on their old kernel.
They'd want the fix tagged so that they could find it.


> In addition, this isn't a regression fix, so Fixes tag is only
> informative for backporting. The previous paragraph has already proved
> that pointing it further isn't meaningful for backporting.

Sure, it's not a regression, but it's still a fix for a bug in the
panel driver. I don't know why someone wouldn't want to backport it if
they were using this panel.

-Doug
