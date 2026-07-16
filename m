Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24136C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC4510F20E;
	Thu, 16 Jul 2026 08:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rWVNYQ/n";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF35D10E2A6
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 03:39:08 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso6315018f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 20:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784173147; cv=none;
 d=google.com; s=arc-20260327;
 b=iZC2O2hqCU86kLZxV3tKy35cG9wf8E44EMAmNLjZzwFkHmXGHHwWn13oGoCxUtAwdL
 Y+nJ71OF4QTH/eItTXqVOXROgC3ZeY2nu2qWdjQ/7Ls8ny8I2BrrXNVV7gaaRxlIMbVF
 rQks4mjvc5FjOAGPbJin4l/FGdY/BwNV9BaSKxJb7cNCvlW+dU3Gif6OPZ+qFz3UkTiu
 TyQZsha+EtBDTPsR1tgvY1RFzfvy5C3HwDSv+8XEsNLB+qBmnBgn3BfWF1T35eRH3wVx
 Wvehg+jtq803vNEJ/5zThJRu1QTddKFxVksO6V1qQQbMROu1IiMERRYvz4/uRsdelKOJ
 II2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HaAi6r0o04lXEAunGEp84mPQVwuTB4awISro/owjdbQ=;
 fh=BE2s/nSmpctq6M0USULiFaeu+AZjFDzTR0808BiExQU=;
 b=TU5jr1S67vC68hHYUphg9Z/ORxBnLOMhltgh47Zdw/KCGULHL0WLgUyKILx7PiXdJN
 nCAF0F6cH8PuQuFpE7S+09LOmrEtk9M/4TNuzW28Ef8kRl9HkF3R+utWMmaza3K+hy3F
 pbwotuDNPvji/3c/zx/HjgzA/lMlPL4Hjo2sBYCkxdGeKOFOKx/E2QCcZ8sewVeNi7F2
 xL3nggMc6Efq1m3XUEBrIwd51L1vH8q+v1rnvOjhCl279r2QtKClVg7/3cU8Bqs5bUGJ
 iZZA+vL/8ScD+kgtfb4kc/G+IxT3LT0LyzRVtHlvSSz+2P1PPO5mmZ3U8lM5BGeMSfI3
 Ezgw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784173147; x=1784777947; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HaAi6r0o04lXEAunGEp84mPQVwuTB4awISro/owjdbQ=;
 b=rWVNYQ/nHAUqeJ8ym38AEDIdqyJN7fEX66taCp+eK1bc6s0qOpyGGfUU58uY0c3c2A
 Beqip1JMaM4zfuPH8fuAvJ3bkWwvHLm8Woc2Wpf5urb2EB19dFN37RKGurAPw2ooeGCu
 61xghoYCM9RPy/lNSkH/BTo+/fvxyZf8D/DzbW3zQSvF1OTSPEqSl7dYPU5mCvXtVuh2
 gHe6lH+hSnjqAHEYGgyvZsFvp4+b+cBj8iTRYf3/aIffZF3BxgZGDsJEmuqVd0h8Vql+
 fnA9qiGfMD1cRCig6YEYwdzN9yaHSWSYqO0Vcd2GOnd2nOelQmG/yBpice2Ipua9CBew
 8MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784173147; x=1784777947;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HaAi6r0o04lXEAunGEp84mPQVwuTB4awISro/owjdbQ=;
 b=ogHHeoElTnuSYytl+59R4nIV0hjCwg/ychdPbL6zv7V9op9hoI30ydEvlITSaFmvxR
 MPQj4e+wvVs5h9HcrbUII36htx/3H7uhmc2sO1wsgR3/4SCgy7XgSHHYMcOqBCghD/I9
 YxSnEPP5eX29ybDSqm5Zmr69sqVMJRfn37QiGhvEqsaxeMs5PIjHe+k9mp46YuJln8jn
 qBRahl3qyQcoA6YKt7tOvK7rmmbHaWIPyML23uNkZnAJduYAuGooAdr6CbRqLw54c0NG
 I8DWq8sSu8fhM7mDFTOGgeYzPCPQYX8eYKX9CXdJEhgfl9AmG2RgMBDze8NNfv8TQ6Z+
 va9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpqti3jvkTayUxLJFupyprQC/sY1xvN4q4hly9m/6TH/9VcmNu8G4xsyvTzCk4+zxiYNM3eER+CuaM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsAKDu8XXdGeaiGeBptPp5fkvioOW9RPwVwi96b289gLecb/I7
 JUsXiuh7n/YIz6vgnI4r2GMigLWTah2LaHsKWxnqJMQvmgrHGXMFzTkEjg9UPGqvZStM+4jFlfS
 AJmtYvqmMahwqGX1T26pddCrH+yIbDcI=
X-Gm-Gg: AfdE7ckvlVhVSXDOAUYfU7Q2cSZf7pOm8C6tXb23PVe8xYtNy2Z46pl3kcNmE6dTUxy
 +6aC02ooohV8P39HKcy+zCJEMt7xQ5oclrlrsFPi2yMWNqwWpEAB25nXl6Jw0rHZpXcbhCK7Vy8
 H0O777Q8avaKb7zyAkS2SwsjqM0aH6zVjk2nxkzqC6CCz4L9E7m6An1Lx/sfqqSfPCp+O+rpdvv
 zEgg750g1SwpIlZJr47gNm/++ev35ppRpG8VboWsKNncbJi/DPgHZx9X4EH8K3daMW5rIj4
X-Received: by 2002:a05:6000:461c:b0:473:506a:e47c with SMTP id
 ffacd0b85a97d-47f4886399amr11638724f8f.26.1784173146909; Wed, 15 Jul 2026
 20:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com>
 <CANbgqATR-V0rRGfzj0hdJ2hsJex-iWzHMwD1L4vavTi2Jd79Kw@mail.gmail.com>
 <alfV1691ZgZ6KylX@venus> <2301403.NgBsaNRSFp@phil>
In-Reply-To: <2301403.NgBsaNRSFp@phil>
From: Andy Yan <andyshrk@gmail.com>
Date: Thu, 16 Jul 2026 11:38:53 +0800
X-Gm-Features: AUfX_myr_sOq7hYE4m85iq51mdLC4kRmODLTYq7q95ypFNA8vqcVX-4llt0DR9M
Message-ID: <CANbgqASSwGjnUsqmpyPgYQ8Qy_6++krbVMQQywB8oJv8Jziz-g@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] drm/rockchip: dw_dp: Add runtime PM support
To: Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, yubing.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:21 +0000
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

Hello =EF=BC=8C

Heiko Stuebner <heiko@sntech.de> =E4=BA=8E2026=E5=B9=B47=E6=9C=8816=E6=97=
=A5=E5=91=A8=E5=9B=9B 03:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Am Mittwoch, 15. Juli 2026, 21:00:12 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Sebastian Reichel:
> > Hello Andy,
> >
> > On Tue, Jul 14, 2026 at 06:08:06PM +0800, Andy Yan wrote:
> > > > @@ -58,6 +59,8 @@ static void dw_dp_rockchip_hpd_sw_sel(void *data,=
 bool
> > > > force_hpd_from_sw)
> > > >
> > > >         dp->hpd_sel =3D force_hpd_from_sw;
> > > >
> > > > +       ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> > >
> > > This can triger  HPD irq for USB-C DP AltMode, but for a standard
> > > DP port, this is no way to acquire runtime, so there will no irq
> > > when plug in.
> >
> > Right. I don't have any RK3588 or RK3576 system exposing a DP
> > connector directly. This this is non-trivial to test for me :/
> >
> > I see the following options:
> >
> > 1. Only enable runtime PM when running in USB-C mode
> > 2. Mux the HPD pin as GPIO to support waking up with the controller
> >    being suspended; either remux when the controller is awake or use
> >    the same mechanism as USB-C to do software based HPD on top of the
> >    GPIO (which would allow using any GPIO as HPD).
> > 3. Have a poll function, which wakes up the controller regularly to
> >    check the status
> >
> > I consider going for option 1 for now, which allows option 2 to be
> > implemented as a follow up. Mostly to avoid that the series becomes
> > as big and messy as the USBDP PHY series became.
>
> I'd agree with that solution.
> I think we can all agree that option 3 is baaaad :-) .

  I'm also in favor of moving ahead with 1.

  About Option 2: we've got a GPIO-based HPD workaround in our  BSP
tree, but it's a bit flaky in some use-cases=EF=BC=9A
  According to the DP spec, there are two types of interrupts:
  1.  HOTPLUG_IRQ: A level-transition pulse that must be sustained for
at least 2=E2=80=AFms.
  2. HPD_IRQ:  A low-level pulse with a duration between 0.25=E2=80=AFms ~ =
2=E2=80=AFms.
 With the GPIO-based solution, it is difficult to reliably detect such
short pulses.


>
> So with 1, functionality keeps working, and then someone can put the
> special HPD handling on top later - the Rock-5-ITX does expose the DP1
> (on a hdmi port)
>
>
> Heiko
>
>
