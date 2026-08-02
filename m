Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83669C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394FF10E480;
	Sun,  2 Aug 2026 22:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UUWs/aVa";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAAD910E480
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 22:56:42 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso2768336a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 15:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785711401; cv=none;
 d=google.com; s=arc-20260327;
 b=bAMg/hroc62ZBMvDA86cSZb6d3cCIuu3y74Z3rUytB8ZhGoQoCMAMyf5dMt2Ck9Xdd
 A3KbVgJbjVdSgftSFecIIyTTcQJMTmU+/nAvJ5SeXnkaS1CZl0P+FWdjr8AyoLtHy+4G
 bS0IBPfJadyhlc8uwUIN0a/su7BEMRc5Vo0A31Y2sJPX8Qq4jyBnEB6q53qNHk4wnzXE
 uSsmSXME8oT892jeV2c1b8usaHm5rNMQ3ILglir5usHHlb+k+p7EuHx7GSPJ1hIsx46t
 ewZ6J+LyZj7Mp8P2mS71VgBF8vwCLyeJA2OvC6Mwkhi46GR1uHf5v3v5KvHp13ar0wtz
 b2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L/rMtwPDxsC52fx+U9UwvVtcGVHIIpAAwX8W2NzxXeY=;
 fh=Hq8MJWatuZ8FVro1iHup5PdQEdTpUafwIDA4M1W53Is=;
 b=krluYKSleYJah6MgWKqLOx680HbHZh0y8V5Oriy1ONTFxQBBxvW/+2T8TKS2yPPMHO
 mUwKC+5nxcnmPd+AonWF+UMSyJEdMuAylsN9eE51Zy1KO2COzgPtrtfd0EqFqBro5qYQ
 bDOHh9bdQ2L//a88Z1DgidSu/AZab6jCWITOJTY4l/fu+73Vhv+B/sHtWaDPtVi83Fb9
 X2+esF8DG3zBk4MgvL5XPfMaZC0HREdAWg1O4hOhyvI2CbSiSnbhojFeVsU4/OyrSfHX
 jIxOBlOZuRYJuqlHWjXwlKD5+joyqSP1DCKeeCScm0D/h/N+mNvGNj90NHR2ji5+WCa/
 Xrtw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785711401; x=1786316201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L/rMtwPDxsC52fx+U9UwvVtcGVHIIpAAwX8W2NzxXeY=;
 b=UUWs/aVapXaJjFdcdHUqGXYfKXro+/tsaPT+oLffUPsStkOAOAxdaqr76aZDJ6mE5k
 Ju9Exm3VreW/UPR9cN7ahHYUah30eyRQ9LGxApXVDwkXSWyFqH9PH9cD8ki4MB/e/bcc
 evTTSoRTnq5uXjDcj9LMwu2e48OTDcz2Hx7l7RASZAXQ5yjF/g2cOeSr9JiV+H26Eq/+
 Gk0r+i6HDNVm/Pfo+vkWvWOt9XFdaWFUjbuAnbW9FpcsEJIKBrjzcVNYeNjFuiPQ6MF/
 V/Ybp060oa1STFjxAnuz2NpoZWepxc6VeBgFD3zL/oNr8h3q1DHy1DU0kdPQHbmLWxFu
 1ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785711401; x=1786316201;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L/rMtwPDxsC52fx+U9UwvVtcGVHIIpAAwX8W2NzxXeY=;
 b=kSxJ5zqfOO4/B2Wykbjy8UeQ74ijZUfhGfDRJz3fVpSgK+mOg16UpVTnFvOY0IZqcK
 /7RrKudBKP58WuSZBde67We2+AM9S+i26seHzfuY1w2y20XJ7V8Q9oI9mvGzYuylLAlK
 ICfoHcS5cg781mDV2Oq+un+A+WVwIFtuDJfvztf/PWmbWP85BZlXAWpuVPXptGd0u8bL
 kTiTy7M051YLu8KkzfL+q0qs73pnPTMUm7oow9uHgHKdhfJlvw3eVs0TXPbI+x301C19
 eBL+M32yVtAiyNrghHspR/QTu1P/imH/pgeO+YLWLDv0FqN14ORbrNxLR+qdZpn8CHEC
 DlVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUTRfjSu0yoP3LzItH0l1Abu8/4OJphTvMaUHK/B7kygKRitde/IAC+0F4bEJXQKsVQSFIntgk268=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrvShBnarHKC1F94bvE4PehBJXqztS+Vc08lOLPaY0rrewkv59
 2nf00Eygzl2acAOYn5KFDeQbPqmX0kQOEp0T9fcFAXtiwT0n6wChyMkLkEVspoH2RASlHdwUbIg
 4X/ukNbo+0yUWpy2701CPft8MimKIha4=
X-Gm-Gg: AR+sD10w///6Aca7LYLs0UOni4ZQiHtMyPDWic+BLIy58Xa/7XdXtkqMvZXLEzTrtQj
 O3rBCH9xP3GOu6WXNEypNJh1w4Jzxqv6ewCQ1ioz9uQNHVVjsuLRnWcjLVfXhc18MSLvB33sPwB
 Je9NXKekNst2wzv44d9c7BWuESztQHlIwjdbOOC3kICnPpoLlkPo4WV7GbaCI8O9taVLZhbChCP
 MroRql+eJJkXhzMa3WwpOzbhH+mXiPCyyz6CRLefIEYHNSKB+5i9UzaUxcgoG7Z0CN5gIapWTCi
 7dL3td+5Se0IdjLcBlhFBGz0F1ZXUkNI3euqVI2cDW3I1WRdlQfCo1PFjN2ksqku3A==
X-Received: by 2002:a05:6402:5046:b0:699:fbe4:16d4 with SMTP id
 4fb4d7f45d1cf-6a0a7cb31e1mr5338151a12.18.1785711400839; Sun, 02 Aug 2026
 15:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <am9DGQFk6JfR6bXl@monoceros>
In-Reply-To: <am9DGQFk6JfR6bXl@monoceros>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Mon, 3 Aug 2026 00:56:29 +0200
X-Gm-Features: AUfX_mxll1BnAASKTkWyMod9VELF2y9V2Qxa3BymFTVuaD1zfm5wy-U_j9CAbIY
Message-ID: <CAEUXW=Gut0oN6VN1XouegJsQzwNYGqhAjVotGJbQdXk5bVuZwg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
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

Hi Uwe,


El dom, 2 ago 2026 a las 15:35, Uwe Kleine-K=C3=B6nig
(<u.kleine-koenig@baylibre.com>) escribi=C3=B3:
> No need to wait for init, the idea is to use init=3D/usr/sbin/platsch so
> it starts before init (and once the display is setup execve()s
> /sbin/init).

I think I caused a misunderstanding here: when I wrote "init" I meant
PID 1 itself, not the init system getting far enough to start a service.
Running platsch as PID 1 does not change the part that hurts, because
PID 1 is exactly what I am waiting for.

Numbers from a shipping board, our 4.19 product kernel on an AM335x:

  [    1.065931] tilcdc 4830e000.lcdc: fb0: DRM emulated frame buffer devic=
e
  [    3.522118] Run /sbin/init as init process

The display is up and can be drawn on at 1.07 s. PID 1 does not exist
until 3.52 s. Whatever runs as PID 1, platsch included, is roughly 2.4 s
late on this hardware. That gap is the entire problem: the panel is
alive and black while the customer is looking at it.

> Also you can put it in an initramfs which gets rid of the dependency on
> "rootfs mounted".

Agreed, and that would remove part of those 2.4 s. But not the shape of
it: PID 1 runs after the built-in initcalls have finished, while the
logo is drawn as soon as the display driver's own probe is done. Any
userspace solution is structurally behind that point, and an initramfs
moves it closer without crossing it.

> And if your kernel is modular apart from what is needed for the display
> the time difference between kernel boot image and platsch might be
> negligible compared to the simplification of the software architecture.

That is worth evaluating, and it may well be the right choice for a new
design. It does not change the ordering, though: the display driver has
to stay built in either way, so its probe finishes before PID 1 exists.
Making the rest modular moves PID 1 closer to that moment without ever
reaching it. The kernel logo draws at the earliest point where there is
something to draw on, and nothing in userspace can be earlier than that.

To be clear about what I am not claiming: platsch is the better answer
for anything that can tolerate the delay, it is more flexible, and I
will very likely use it for the parts of our UI that come after the
splash. The kernel logo is not competing with it, it covers the window
platsch cannot reach.

> Having said that, I'm against putting boot splash info in the device
> tree as the pointed out alternative is IMHO good enough. But my opinion
> probably isn't the one that eventually counts.

Understood, and thanks for saying it plainly, it is useful to know where
you stand. For what it is worth, the objection I expected was exactly
that one and I would rather have it on the record than guess at it. If
the conclusion is that a bitmap does not belong in the device tree, the
fallback I would still like to explore is keeping the placement
properties and the reserved memory path while dropping the in-tree
image, since that removes the "bitmap in DT" part while keeping the
early drawing. But that is for Helge and the DT maintainers to weigh.

Thanks for taking the time,
Max
