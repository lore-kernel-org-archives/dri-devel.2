Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAABC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9708110F35B;
	Fri, 31 Jul 2026 17:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YiUmL8cg";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2214210F35D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:04:20 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-9349ad9c857so65568385a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785517459; x=1786122259;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q6s7fDAIRuuqc0qt5k2/m36SoHvN8KyFeNU/LrJAEBc=;
 b=YiUmL8cgVmWhZCMrwFlTbT85DNqIvt2nFoYNchspj6WLXqVV1ivB2K9zxULDReUmBH
 urDn38F6P4Xrke9tWoWop9815EXJXt1dWt0z4CyKv0AHIK2rmCnqFnezR1grC7gHxDOW
 reD1SmA92PsE2MKqLgTOGrlNZxowNLtAhv8Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517459; x=1786122259;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q6s7fDAIRuuqc0qt5k2/m36SoHvN8KyFeNU/LrJAEBc=;
 b=Vo1Alo99FmNpLV001ouXFhuZbQ1C1aAu/x76crT7LzA/KofzB2Jc58i/CRKhB0o6T0
 UEwYzM3GDtKFQFziewERLr6STaU5pkQrtKFMThw08e6wsy/P2/LVKK7ca+C5rgU8V9DB
 Z4ZICcBHP/kBw+12/tVuUvnGbWT2Kc6dUKFZn+XqI0sO1i+0/DSw6pPlwesciroUF0J5
 49V7ER76tSGqd+UPELlTq/NbnV38xgv40A5WiJ11SM0lGQ0KAMPBYePjrUi6OfWG3fyH
 1z5tQk1yhjAI6r/3bdPv9OoZ11V6iQQwSYXkhzjTppHkHx0+RIFFNsAOl0UIMIvWO5oC
 Pn/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoN+g0MV2w07f+l4w1tUrh5YwZE365V8uVqsY5ebpXZNCpic5nA+k7jnRcpcbDn/H8Lecs09mrX5BU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqXZgYeCAStUUDb/ftk198g1c1vXGvvk3mo9+06/ShAxYWImHG
 tdNHeC68xWgbf/YuCN7uvyaHFv8xXKvZd9+PAfEjIzsg2m/jW1Dj3CjRqB2yxB6Dv/QevaTuroK
 qSgA=
X-Gm-Gg: AR+sD10lD9uCqmmVtolyiAHd7iwfISYIcMKESxcFbAcuEqwVmwvyEM0lAvh1s1t+5gG
 4GiGHryiM0LOTe6thpJigDTG5fOXNsoZLXokycnyo/oDQN2q1X+YsRk8VYZjmFg/KeD8MndKo16
 H+rqT/H8r8+hsRk0tfsd39WlUZxvJ0SLgLlOTinpp9fw60t7voSCxasZYg1BXUtQZ4Zy9Uxw0XE
 /tifw+TEZSINDs0TY6nbLxKqTRn8882skqogOjJQfFUrp+4amhK1O+8NiFCmrLoIscLblxoFYGv
 P0vczNbclvWOYko6EEnPlnlyzjwJTbV2VVzaPAENd1fSefeiHV0saRsGlYpv5cmNDS1L/ofjdCL
 7sRNSmPeK9sgYGhW03UdkMFWcNtRrErTbdsZ2wirIv5hvBqxIWuK+OIeMiWGIVltiEpXaNiLdfq
 RKOKlXcDDqMxn9ogW+LG1Wu73e41HQCbkjx2AzIDH3gLDHBoUxRGtIWNQt2YWdc7Fy1urFQrvzS
 0MdWEqvDpJ759n8sQhhtPmqXPs=
X-Received: by 2002:a05:620a:6588:b0:934:81ae:6d1b with SMTP id
 af79cd13be357-934a09386ffmr129731985a.22.1785517458902; 
 Fri, 31 Jul 2026 10:04:18 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com.
 [209.85.222.41]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9349c1f829esm105190985a.45.2026.07.31.10.04.17
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:04:17 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-97727c2064fso730657241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 10:04:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rqi1vjazaxh46TAcSXSRr+NXAqsR6HWRq5D7620JQyeQYNBAJUNJLY6ZrjRQTSRn8Y0sS+d13xJW2E=@lists.freedesktop.org
X-Received: by 2002:a05:6102:fa5:b0:744:dd70:a364 with SMTP id
 ada2fe7eead31-75b23d68935mr900061137.9.1785517456763; Fri, 31 Jul 2026
 10:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260731115253.15234-1-info@humanlearning.ch>
In-Reply-To: <20260731115253.15234-1-info@humanlearning.ch>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 31 Jul 2026 10:04:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGjfK_PxT9J===oYZguBw6+gk4DoGiVLojDki1sEz8PA@mail.gmail.com>
X-Gm-Features: AUfX_mzNMJD5KrO4xo4y7-b1Mh9NjRG2qjeEo_0VNLMae8kQ7DLiugX5TuJphRY
Message-ID: <CAD=FV=WGjfK_PxT9J===oYZguBw6+gk4DoGiVLojDki1sEz8PA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add Sharp SHP 0x15a7 (Surface Pro 12in 1st
 Ed.)
To: franzelverbier <info@humanlearning.ch>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 31, 2026 at 4:53=E2=80=AFAM franzelverbier <info@humanlearning.=
ch> wrote:
>
> The internal eDP panel of the Microsoft Surface Pro 12in 1st Edition
> (Snapdragon X Plus, X1P42100) is not in edp_panels[], so every boot
> produces the deliberate WARN_ON splat in panel_edp_probe() and the panel
> falls back to conservative timings:
>
>   WARNING: drivers/gpu/drm/panel/panel-edp.c:814 panel_edp_probe+0x53c/0x=
56c
>   panel-simple-dp-aux aux-aea0000.displayport-controller:
>       Unknown panel SHP 0x15a7, using conservative timings
>
> The exact model string is not known: the device tree uses the generic
> "edp-panel" compatible and the driver does not expose the EDID it reads,
> so the entry is named "Unknown" as is done for 32 other entries.

No, the EDID should be available somewhere in sysfs or through various
tools. You should include the EDID in the commit message, as is done
for other panels. If we couldn't read the EDID, we wouldn't have known
this was SHP 0x15a7.

Ideally the EDID will have the panel name and we can include it. If
not and we really can't figure out what panel is in there (the laptop
spec sheet doesn't have it?) then we can use "Unknown".


> Timings are deliberately cautious rather than datasheet-derived. The
> conservative fallback sets unprepare=3D2000 and enable=3D200; unprepare=
=3D2000
> is a safety margin for unknown panels only and is the single occurrence
> of that value in the file -- no real panel entry uses it.
> delay_200_500_e200 keeps the same generous 200 ms enable delay while
> using the 500 ms unprepare shared by every actual panel in the table. A
> shorter enable delay may well be fine, but has not been validated here.

Sure this is fine.

> Signed-off-by: franzelverbier <info@humanlearning.ch>

Just to confirm: Is "franzelverbier" the best identity for you?


-Doug
