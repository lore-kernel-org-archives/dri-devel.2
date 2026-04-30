Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C68FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035EF10F2B1;
	Thu, 30 Apr 2026 09:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmExZPES";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A5A10F2B1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:12:37 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-50fb8e9a4edso7733111cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777540356; cv=none;
 d=google.com; s=arc-20240605;
 b=dFJxJURoyTFYMdPo47WTG5JRns85R7Ci0Mob6yeiJtn3QGdBMjL4q0PLd2s1onihfK
 J6rZTRB08hJTTo+JuEt0uHeJjuNrTD6zRi211wTaCWFSOS85gzUiWs98sg/MHoi70017
 o/Jzrv8R9lb/5QVwxitW5nU1SnO/EPL9efdzFKpLSSJf+AmMW5gGfT6cxj4NcMtbA9st
 nyr9wlP3ZU6uRmzWVFAc6M9OO00kSE9gFOsdK72uH30kU0qBTOL7IdZ9kPAfogOiH+QP
 NTCpfxR4x35nhinkszYdMsFfXUO8VhUeavAZsnvlv9oatinDX6Kj0tRATf6tLJCC1iTm
 +tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CBO+qP2fp4ZIZ2hbTpo8BAvLBsmEh447VHA/0NJ5kAY=;
 fh=3z0zmwDKR5VzHCAi4gKlGadrssom6TxfVuNfnBlOdGo=;
 b=jfnBx4G6sS8iv1PIWIoaEGRccmRQa8khjSZOjqL3SDM3weTvQ0E0apuUUcKGwJjGAZ
 gS8Ay/aYZJnLYZ5n/5v+wJo2IVkpmIv8JACPwCYAixaLUGjZ0nMgoL2THbj6LruP2iHM
 wTHrv3//RG3dwuSB+NHFeavhzKJsMKW/QTWs2ip1H55EQU8y5rM3+JG1j0gMSVEYpCL3
 oWaxrwmPhZvpIioqQ66fafCDyvufjfsdERrbNFRWxTj1FSYihpmu6bY2+61J8smli3o8
 21Q9+Fj2SfEVPAu+e4/C+zY7vcz8unP4ZB3raxDtps4RCTLH/+yGX8WKdG9rVUcQjn1a
 oB7w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777540356; x=1778145156; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBO+qP2fp4ZIZ2hbTpo8BAvLBsmEh447VHA/0NJ5kAY=;
 b=HmExZPESbZF+gjzNCCT1DAdlgMls2p5g5I9wAu4dUkOdyWnFBGcdhT3U5+4dZyzu2B
 EcBYxu5I6xo9yXs/cn4vTIsyOnK6zUNYrpzbVg3+4EXyNIs/YJBwkfbg8S2ZKMsg4nVH
 jK8/wSdhSi5Yx51DeYG0THZsV9Exm1YQ4qO9ueHfN/baNCv14ejrpSwu3CSm9Wj+Nu3O
 Txne2NTo56cUBeCX9N1ebYBOBHvAQGnS70BvZ7c0DdS0LvBFLDCN7PPclad4/ALLo2cv
 nMEauQed/7DW7U7Tb9SOKCPvTgvB1v/UcDUwTlid9FhtwljMFlU7dSqhq38BPHd192jc
 YYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777540356; x=1778145156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CBO+qP2fp4ZIZ2hbTpo8BAvLBsmEh447VHA/0NJ5kAY=;
 b=EwLksZowmhnqNBi8xKcVKgXJmGRQnHU2SKVunDxDF9NbQbNtiDCZQMzvHP/5+INTIE
 m+GjobqqISmNFq9NDGaumu66tM9a+W+h/ksfzelrL21V4LOHvckADAFwVuQ+CC+eDPWn
 HBsbfh8UtFOyxgI441jHO1HILZ7ml/99GfWXdaTcgYQnOVZClxQaYW+rESrO4QloQFfQ
 nB/tA0hSOfChPiCLu6pXT4aItyRfgOzAZzDHYjAMEGqR/Spc/URCOcjYqJklNEFIpBfX
 YEiUrvAVF7bzU3eR5D7KJI6Ea0EbpHWW9sp0epQbbD7h2kFbToUq6p/bFzflnXDbJR3H
 NoBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CdJSuwEF36uTZU0417mt9RH8Bl9sR5piknjcFFTWQZ3SncPsV2HKlKdPrFdHlfWja4iZgdak65jI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzknd9wptYoQvk0KDMas9czaBmFiM1obY2agpqSS2YzOcR/Vq5o
 amSMrFaeyfT8nuvV8rf1n+mFPznLncn0hERQhylPGc5VZqruUclPxv9Y8OLtGFXs24SnVCUIf/l
 /bL/o8uRuSE4zibpfoxkxtPaqTdVjCA0=
X-Gm-Gg: AeBDietEFV+2aYK2Oxm8z/n8cylmugBgxTMb8EMwLQ57GyfgWJFV1U64JAM9SOccEHr
 AqQN4yBCwrTazW6tLWHS6iDN6BZAF6ttGyS7FrlvqORHRRc6ZO+Z+K9HOV3H4WoFiZNFEl9Tnkx
 bCKh5UYktG+lUngOU+5EDhanTNDcJomVKxvMTrZzF9vJGCY35MyDV+STB7/zal7Obd0511R/0Ba
 R99/d9UZ8nqtRU8N/FxgTpBpYcBQuX/5W5Ju0E3bTyXcQUzoaJORc31hxqOHcm77GN5/skJRqxb
 weX27QkJNEWNbwefcbKsu1ImFGcQ
X-Received: by 2002:a05:622a:a14:b0:50d:edcd:4f39 with SMTP id
 d75a77b69052e-5102adc7d9bmr26633321cf.40.1777540356421; Thu, 30 Apr 2026
 02:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260430085344.34271-1-francesco@dolcini.it>
 <DI6DC1OD5S7N.2EXPCKI13OZNM@bootlin.com>
In-Reply-To: <DI6DC1OD5S7N.2EXPCKI13OZNM@bootlin.com>
From: Adrien Grassein <adrien.grassein@gmail.com>
Date: Thu, 30 Apr 2026 11:12:23 +0200
X-Gm-Features: AVHnY4KIb3EZwtjEuyVikwUpvIR2bFalintX6aFwcVP1HD24fqoAZ-swyGdJ3zk
Message-ID: <CABkfQAHWPwr55dzfMyiJfK2XSat-Eqf+8d1qceHMMFaM9v-2iA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer for LT8912B DRM HDMI bridge
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Le jeu. 30 avr. 2026 =C3=A0 11:06, Luca Ceresoli
<luca.ceresoli@bootlin.com> a =C3=A9crit :
>
> On Thu Apr 30, 2026 at 10:53 AM CEST, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >
> > Update the maintainer from Adrien to Francesco.  Adrien is not
> > interested in maintaining this driver anymore, Francesco has access to
> > various hardware devices using this component and the vendor
> > documentation.
> >
> > Cc: Adrien Grassein <adrien.grassein@gmail.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Adrien Grassein adrien.grassein@gmail.com
>
> FWIW:
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Thanks,
Adrien
