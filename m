Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE879FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 15:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBB810E223;
	Tue,  5 May 2026 15:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="kSJYd3wN";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E5210E223
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 15:05:07 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-7bdaa68cf81so10332437b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 08:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777993506; cv=none;
 d=google.com; s=arc-20240605;
 b=gUyxnI5AGEGp4nKG3KUDDXnMND5wm0KVSaDtERo4jjNgHL18OYdV0lJPwxavdnxeiV
 Qnd/zcvsYLitV1V3bu/NtmLw84t0KQKtebBMhlAJKjqH7SNjAtPYISbrs0owFENDiOlv
 Ui42C6yUdUqncINp7J4ujFrA+ooYKy1Vsp1GU35giyz2639baKcnFmSbIQC15gbD+Wet
 e0S4ftmYft/oqZWCLYiwJM4+tsrjssLJ21R2AGsJIRv1IY/23j9Y0SzOBw01nrsb7ibq
 m19wKeYUSvk8m+/2iT9MaZztBrQH4fOgQiRuAUb5M8uF+tbB7hdA5wcrFpLcz7KDJECp
 V5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nxZ89rUvP7Lz3tEU7M6JOWMTYI1Uv/IEguOM4PesleE=;
 fh=sLnJAoj2z6om7DQVHmUEWcocaef+mQO2PjGY73r3xrA=;
 b=G68NjEJITne00n8fTxrY32v/HMd9JYxzMU5GjOeVVoxe1kDctkAkzySiaBfDdmhf0e
 sN92UkJDqhmHH8FYI5iT25z9113GyO799yaY09+6+3zMx90a83i3gNzItzDBKBC+T0kJ
 YJY2BTXYGGqboDOZg3wirzlSHdvUSkVQmwR2cYSbOR461UyEIYK/L4p6UM3A6/73f/po
 cSQwy1sYjfiQZ749q9z+9obF7STD/wRBu7eLjZf8UR96XFuZd7oofvNWx6/gRub/HCmU
 tGTvMXnKSGWdBdQi7UA+O0KmUt8GWNVbnZCM1nA2nhBBRxiWhrS4bfToKCg0bq9zaG8i
 TeEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1777993506; x=1778598306;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nxZ89rUvP7Lz3tEU7M6JOWMTYI1Uv/IEguOM4PesleE=;
 b=kSJYd3wNSCE0ioLicZLiFuVo5T3VSshLIZlfIVxCRyIwoYrTn3zJgJL0Aj5SQjeD5Y
 syk2TSsVI2XR+tvY6JcDYmOsEt/2K3CbgIz9JMJ1NloyLPTuWZqAngoVII4ewEHN9R7U
 j0/g0xq4A9kan/NRKyAGP4XDvX1YroTtbzLsyS4Cow8bAKycar43/KReE4XWrBkhwie3
 owOVCSRzGmZGqiEC9R9t8hVGuxom/wb2f6tNfdshOBWypN3z9f2fQjXWOykftDLrdyD/
 y1LAxmy7cbqvT24XvqbWQBS6uXcL96QOqcozWzNP5kY8umGVsWPTI5pBivzyHimAGG+4
 l8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777993506; x=1778598306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxZ89rUvP7Lz3tEU7M6JOWMTYI1Uv/IEguOM4PesleE=;
 b=okQ25Iff0v48vE/9dAXEwAP0ICcPEqFIPi65JeLOGKyL0WN0ZIgT6zScjfAwWmZvyM
 PvMrafNVXuC1Tuu2B+sbzTnmLL8qDfSDM9CaLD9ibIRMlaunBjRaR6zoijlvlMzRbyYc
 YfMHhahYhRNdRa9+6XSps+ZgkJ98qawS7lXGX3g0hFL/6BR76RGgdtufqCDh9Pledfd2
 dAW1DyEF4OIp7YElY66C3w1W6V1peqvgqsDCFhyfa1IKPFgtg8h4xJiaWa/h6622SvLf
 ObjjS3FBXScuNkt3LaAzo+GZsxfyfHmzxmfaA+CJK+KOTkY2FB+wuTpmwYlMWXCNQINy
 v94w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jBXvfnqbQQl1345ZfodgCIlEeUzpYGQNFsVO9x15ttPn38+/pK26uWaYm7d66mhwjQPGWsZIvX5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRwyho4SpqUH1VlNkDUfzACQQiiarrjaeYJ4qTt8G3bvrRuKiI
 YoPvituXHeadIYibS8eVYCFRMCNLJDiZwnPZVKYSkNv9XlHQsnKdR4TgnL2ZXoxs9Qf8o9g6UBn
 /28kMuI+4XdSGqzm5uT4lY5MrEBOmoiTxb9Jtpu7bnQ==
X-Gm-Gg: AeBDieuydzS0D/hR8YaGHOhDFHUOUKaFLHVP6CptNofApnCMECbGUtVjkNHcPYPl1Z4
 5hzEJXiu9W+e5fONhf0E+kRZJipfcb3ns0GHZxu9opPRaZLMHZVUB6JlaJHB8hMjvBfN7d4K9kd
 s+rBmLupePIOHz5c8q1MXR2Mf2CjuLcueSm2/wRYd+KbpMP1Rt+7pNtqOFEbepdzo3wyaAf2NZ3
 LjbQKokRxYHU8PIVVuPAAkXe5oqL3SKU8o21bnrbEfiWwIz2W25BNZPmcmrCRxK5nBgUn0lj2pA
 kNXdW1sGszoR+RzAI9Fobx7bTPRHtK6xsM8gBCx3IRKe0MbaCJ9CpsqyTQ==
X-Received: by 2002:a05:690c:6d84:b0:7bd:d145:3af9 with SMTP id
 00721157ae682-7bdd1453b57mr17435087b3.47.1777993506337; Tue, 05 May 2026
 08:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260502121251.39206-3-thorsten.blum@linux.dev>
 <CAPY8ntDOEjAHFF_HxFoVEmrgQ8okm=8cHQEfm2QUU=MuB77d_A@mail.gmail.com>
 <afm5rE1i3D-Uk3S7@linux.dev>
In-Reply-To: <afm5rE1i3D-Uk3S7@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 5 May 2026 16:04:50 +0100
X-Gm-Features: AVHnY4JZgHkJgGCzic2hZC9UU4JXCcW0xdjYdX9AKr5gfvwyZOmmOxNQ7b9qX4s
Message-ID: <CAPY8ntCgeP-0k=b1KCzKb5K4zExGD5g2=VOtjVaiSPWj=2b2kA@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: fix NULL dereference in vc4_hvs_unbind
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Eric Anholt <eric@anholt.net>, 
 stable@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Thorsten

On Tue, 5 May 2026 at 10:34, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> Hi Dave,
>
> On Tue, May 05, 2026 at 09:54:53AM +0100, Dave Stevenson wrote:
> > Hi Thorsten
> >
> > On Sat, 2 May 2026 at 13:13, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > >
> > > With 'dtoverlay=vc4-kms-v3d,noaudio' and 'hdmi=off' on Raspberry Pi,
> >
> > Mainline doesn't use overlays, so this description isn't valid.
> >
> > Which generation of Pi are you using? Whilst they all share the vc4
> > driver, the functionality associated differs. If you're disabling HDMI
> > (and HDMI audio), which display outputs are you using?
>
> It's a Pi 500 currently running headless, which is why I turned audio
> and HDMI off. I ended up using:
>
>   dtparam=audio=off
>   #dtoverlay=vc4-kms-v3d
>   hdmi=off

You're still working from our vendor kernel[1] rather than mainline.
The mainline kernel doesn't support the Pi500 yet, and doesn't use
overlays.
The bug is present in both, but descriptions reported to mainline
should correspond to mainline. Otherwise report it to our vendor
kernel repo.

There's also no such config.txt parameter as "hdmi=off".

[1] https://github.com/raspberrypi/linux

> This prevents the vc4 and snd modules from loading and works for me.
>
> > > unloading the vc4 module calls vc4_hvs_unbind() with
> > > dev_get_drvdata(master) returning NULL.
> > >
> > > Return early when 'drm' is NULL before converting it to 'vc4' and before
> > > dereferencing 'vc4->hvs', preventing a kernel oops.
> >
> > That leaves things allocated and clocks running, so bailing out isn't a fix.
> > I'll have a look to see why dev_get_drvdata is returning NULL.
>
> Yes, I realized there are probably other things that need to be fixed.
> However, the defensive NULL check avoided the kernel oops for me.

A quick check says that vc4_drm_unbind gets called first and sets
drvdata to NULL.
The devm action then triggers and calls vc4_component_unbind_all,
which in turn calls vc4_hvs_unbind. The relevant pointer is passed to
the unbind as "void *data", but not used.

In vc4_hvs_unbind, changing
struct drm_device *drm = dev_get_drvdata(master);
to
struct drm_device *drm = (struct drm_device *)data;
fixes it for me.

It looks like vc4_v3d (used on Pi 0-3) has the same issue.
vc4_crtc and vc4_txp both store drvdata against their own device, not
against the master. I'll have a bit of a think as to whether that is
better than using the "data" pointer.

AIUI unbinding DRM drivers is an unusual operation anyway.
If audio is enabled then I can't "rmmod vc4" as the module is in use,
but I can if audio isn't enabled. I can't immediately see a way around
that one.

  Dave
