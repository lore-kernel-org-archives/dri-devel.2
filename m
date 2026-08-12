Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBF7C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B474110E2D9;
	Wed, 12 Aug 2026 21:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZWcbCh5G";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3143D10E2D9
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 21:51:05 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so142103566b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786571463; cv=none;
 d=google.com; s=arc-20260327;
 b=e7Sm9rR+WcxpjYBFfQrrYM6elLcZ83BFClSlz7etHFZiD+8SAWoNr7ZZQt4gtvhtph
 OKvHc7LDOVKU7s5UgpTlj+MgcewQ5mgwrAlF23VLpqBkL6pgYyhn0HsfDRPa6xJnUElO
 RFuEMSCY6PsL770xdqTJ1xKnBOPeVn5XUEagAs++jThX4xAiT6eTFaqfklCjX5R7QgUC
 v3HfSTokCo6nWh6ZnBJ4zvx1XLW8RsKbmdB9kcefXSjSKjcKfHWnonV4pvjRDX39kY3c
 DVQg3Rx6NJb1SXuKGxj62owGbtmt6O43FANgPfp0zpJtFiw0L00OkzS5zLAmWxANCB4w
 BEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZRbb1QL5HOmY6fyxJkNCzzNheSCQLGJpJYrLwNUFf0s=;
 fh=gcgTn5n05z3nhshaCmdYRCjvylgwDV2AzETBhSh4uJI=;
 b=V0PBav4F1cUUuEllGgJfzm6VnCq2blUrp6fjFyW7OniQsiAdPr/iY0fkG35O/k4Mgj
 klBSf0uPTHmMNv3isMaJy19VCulgGCCF5dI5V7H0LM13om2QfKsjk6VCj/ztfLIWo1x0
 mgQSb3HdzRQvMyg+kLU1wvHqs23Zs16KBwjYEQyeswKKUKqDT9PljoOFM0f62YcM/BdA
 LIqnmvhWSVP3PwWB0zHFTC1rl48lrGoGRHkAlf5mFEWo9g2Y/dvQpS11SMbJq/RrbzXj
 QDaO/AIJQYfEmX7fNK0ctaRgxdJLY47gyq0nYaO0MijRVK2OWv/+tfYqtRCrL/HbCXCm
 Edbg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786571463; x=1787176263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZRbb1QL5HOmY6fyxJkNCzzNheSCQLGJpJYrLwNUFf0s=;
 b=ZWcbCh5G0MXsFcKWUprJN7K8dFllvvaUzs9LpCzRc57p/gw8xIU1W9QonwmIMgBriK
 Im/G5V+3jg2hkkBGH2f3+2GhHEJ96QsiznOdE8tvHp5YgQn0E4THI3hFQ6mkYgAPbDWj
 5I9a8sahUYlhCgbKNzP89qjA+jyTRTigrORm+m5YxR4l0e+IGhtGF9kljLjqO26kxWJN
 RUYI9vS/WAcTMl6CucrXvGH16mu6BiU8ZFP0cxI/MgeZxpji1uIo0md1kdDvTVuRa8W/
 gQCpAlxrqGEy9EaQ3fHOG4oJ2lPZaDQtEsqd00DG1k+WDE9y0KiWeWYZXbNzbsZcQo6x
 +Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786571463; x=1787176263;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZRbb1QL5HOmY6fyxJkNCzzNheSCQLGJpJYrLwNUFf0s=;
 b=RipSNe0LlZ/gJKHW/Ium9NJNlfxxkcjKDde8oFkmn1TE3OxRU386iintK9htA7lv10
 /ibCW6qoTKHFZjvKJ4xWg9W1w3lx8SkCRZxr9MsDKhNarvge+QqC36u3PTW0B4J1Ulpx
 ZKj0RORDrRRbbuH4vK05gCdRH97ceAb0ZyXwfRN8+eXpTR7jLl8viV3GkKqfx7ZIojJj
 GjtS3dwIpyS7U8RdciDAikfy35PQCYFrVByUOe7kQk0nchTTwX0QPkusF/QR4hVlNqgZ
 Q80JZ5GTu6oO3WWjsr0rvuPF3NVnEzdBRmuv/qbc+ab+oONt05oCIBxmUwCYi6rlgsjc
 CMAA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8nc41dON8LGa0uLwNkHuWHW0MHzbi/eMP63FWAbsKxm3JIO7oSg9CSjmqYlbkef8zP3Kok04b6L0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoPOvhXHdk9WZANTXsPSDYDlbNCl1yydixo00wkE3M1bySETBm
 5+oYB2kj4WAjVzVcMmBIYk+b0YQ9D3xP58Jw02Yl4rI+/g0KJ4i7QfwPvycR/JR5tnjez2UAFbm
 RmQ6t5wNdyZ8G6jQXQ2Re8fAkqm7Llh8=
X-Gm-Gg: AR+sD11kVBEuL90E+GXFZoeHJzA6iHWs0FYLipTIEA6nJlTrM+nILcStEJHga9u95B+
 4/iH8IaLc5wcQz+mPy4xAZKqjWIyEqXvni47QIcDI/lKOB+9bvfbaU73YMsh7kfz4/frp6EQf8d
 +h+i4/1FSlCQvyzT3WWuRfguwT3S+fWk8h43BBnaNd+Rh3l0AyfZJDCRXPZykeYJS+S2o2LkfDP
 JWndxtSmVfbr77Tmh8r6GUMN4gZSgVivNXyc2IP4/FY5BjCZR1+EIjDge6tTmQ8jtF06x4J5KYO
 4oOeucN4p/pKYly5iLt6o26qrD7FaMcDklNYnD72vDgI
X-Received: by 2002:a17:906:f59c:b0:c20:f913:9337 with SMTP id
 a640c23a62f3a-c2108f7b604mr49396666b.20.1786571463233; Wed, 12 Aug 2026
 14:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
In-Reply-To: <20260812-neon-asp-of-completion-e9349e@houat>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Thu, 13 Aug 2026 01:50:47 +0200
X-Gm-Features: AUfX_mxyPKLYJzGR3BRhvwNIy9Y09lt45MHF5IGyuCsk2Z_DBdXDroK9BGIUrgQ
Message-ID: <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
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

El mi=C3=A9, 12 ago 2026 a las 9:42, Maxime Ripard (<mripard@kernel.org>) e=
scribi=C3=B3:
> In such a case, you can (and really should) use KMS, and you should use
> an initramfs and setup the splash screen there.

Agreed that readout is the right answer where it applies, and I am not
looking to duplicate it. Three cases where it does not:

  - Hardware whose only in-tree display driver is fbdev. There is no KMS
    state to read at all, and there are still around a hundred of those
    drivers.
  - DRM drivers without readout implemented, which today is all of them
    but tidss.
  - Falcon mode, where U-Boot proper never runs, so there is no image and
    no programmed CRTC to inherit.

On the initramfs: it moves the splash earlier, it does not close the gap.
Measured on our 4.19 product kernel:

  1.09 s  tilcdc registers fb0, the logo can be drawn
  2.68 s  ubi0 starts attaching        <- 1.59 s of built-in driver probes
  3.39 s  Run /sbin/init               <- 0.70 s of UBI attach + UBIFS moun=
t

An initramfs removes the 0.70 s of storage. It cannot remove the 1.59 s,
because PID 1 does not exist until the initcalls have run. So the gap goes
from 2.3 s to roughly 1.6 s, before the splash binary has loaded and drawn
anything. That figure is an estimate; the breakdown it comes from is not.

It is also worth saying what this series is and is not. The kernel has
drawn a boot logo for decades; this does not add that. It changes where the
image comes from, so that one kernel binary can serve products that differ
only in branding. If the position is that the kernel should not draw a logo
at all, that is an argument about CONFIG_LOGO rather than about these
patches -- and drm_panic already calls fb_find_logo(), so the logo is not
purely an fbdev concern either.

On doing it through KMS: you are right, and the follow-up series should be
a DRM client alongside drm_log rather than a hook in drm_fb_helper. I will
rework it that way before posting it.

Max
