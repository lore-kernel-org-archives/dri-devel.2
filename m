Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA13DC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF5010E092;
	Mon,  3 Aug 2026 22:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VIe6d9tl";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFD210E092
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 22:04:36 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so2604837a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 15:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785794675; cv=none;
 d=google.com; s=arc-20260327;
 b=dgop8b/XBaDZQAsU6BVE/dzyxDIe582079j9gWotdTJfOXSTdbBXrh0CdzjFjvaccj
 IC1BFMhmdCaC18apZJtImy7rF3Ic45Tsxf6j0wU2gllrSdpW4rFVKY+nNBcZX7l05/+e
 6lqCGa2CZie8InIBAk+i9iw9sg6CltfVi04qIpE4lx1oazqnJ8r1LAp2mjuHSSKfZtcG
 gkj9SZlLQeX64haODjArLKgHNwOSvZ9m84mugrGN2lin9j+NuF4to/i0s6AayevSsrWa
 eLdJgR9MZtSt6Xkb8XJBECWkNWanZjp0d/ojlRzbS5Gmh40SniKvAqh+4OGLU78mxZGT
 nBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7WoJ364o71w8b02TDFU0Hi19/xzHT2Re2qR96++mBVE=;
 fh=pkcBx2D1C0yZ+qhRvwSHtPXR5iEVKYNigoNsFOK78+M=;
 b=csRjIpiqRCBWH8b/lhVUDBveSUHtSpPnHNmr2UU5SStpjMKOCF7DMv9J8vEKvxLZob
 wVzPzEUNoaew1ML1kdbmyzPsWYv2shCk3Lq7hZZm6/VztiEFVQs0upuhVqen047fXu3P
 x3n0T8YwwyfIemgatBJJ7ZGxl3GV8pDoBSrK0Ppa9RkZJaFj4YE0+1czNzj1hCATRorQ
 1mACR4VOjSK9qTdACyJGZgOE/ZJBBMjjCEQFjj9qdMIzt0rU4aIzkR2rptfgyOLjx91Z
 11bS5fd5zj1Kv3KY8wcDXPn8x1H1BorubxrirM9ONz68gbs4AVzkAfEqrm7K0MbgHLo9
 eK/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785794675; x=1786399475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7WoJ364o71w8b02TDFU0Hi19/xzHT2Re2qR96++mBVE=;
 b=VIe6d9tlX5BvqFvJh5guVY9JHtlRZqUUkJqPKItDSlpQFccvla5tZO8jXDLBbKEFle
 vhiVZNMMD0dmH3YrhUcVHil5OLjHxHqX1m5hGpfShxKAPS1fvUU2cm0M7NvHZY7rdw65
 sQ6DufOtPp0YT2SmqIk1EY1x08xSjzGCRAMlWS/bujv3LDyfpat814jEakY5oeEhfMFr
 zYqOP+cFyYEKiI/xcqEd5Vvm7c3Dyd61sQAo5Jt3kU2z4aUzlm43rfu4lWDdbKf46nNh
 l9xrcCCTO4Ldlkgqv+R153bWKhQnLnO5Qs6LAflwNz8vasneMRGFqRLwDcvZ1V8YWTfF
 j0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785794675; x=1786399475;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7WoJ364o71w8b02TDFU0Hi19/xzHT2Re2qR96++mBVE=;
 b=bNp9WU2wkRAkw9CIgn+WjbnE7vuT6MeCxnB31r0+QyF4dz0chvRq3tFuO6Vd+WhLN+
 cQOSyUBtRYQM3/lchpiROjIYhtB/xhSNC7QU0eU/5xbOEYhHOaccTDQj2s/suGtGD5M+
 eQiqFrEC7IIRQeDetW6faAE3N7yQtCMl5P6vi/oao7n1loMgLlMOsqOwftEcbgImyFUa
 k5t36JmbEepudc3I6Z9S9tsXCasQudbXgCLzPc39tZ123h2kEr7lfqshYAmWwtmI6bTP
 66yZ/xxSPbEaxiuE4+YDmcFK1MTcdzIrd7fBUVCecwHqBs1WQdzqlSMeutXkFt2oK1hZ
 KB6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcTMjPR+nuQK4x4L3imFeN6pZoj6K3RBIQlana5TqeBBIo/tC5VJ2Zi/9M+6FO4Xly5iREH1mpahw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwELPE0v4T4tD2GiSw8HHZA6rksk+suy9MakCkAC4+vuEq0ONDj
 EXXRxIceVNkWXxjCQyW5QSrfyxQCI0islrCOV//ctbMv0hLBov/cbnSbn6xtAVIPG3nIkx2j/WI
 JKV0P3SHT2I2Qa0ckxxWG/NUjOHRaiT0=
X-Gm-Gg: AR+sD12yyep4zyA3pSFXT1h5Gnach/0A6sWeNjqOgTxaSex6XnBSD8vg0RXr6zhalIf
 ErJtCcGZTih/ttvc8jHTJ9lbwwMkjnhI271P9nZycq/obEbFWXgxcTUhkyRw6u4RTeDoL8WtyFo
 iGHfVuU5joHzur4wR3pX8oGMaWyHbWi2wnBZ0luOgrMHE173Imc0SWo0dlqHK0h96/ImRgzSOhu
 5hbgLjsPGy6XJag9exJPHlwFixHzknKCoUt2ATXy+KLryCoEHc8+8WAz+iV9ksjJyJouCxPvp02
 eMu2DBaHgeHn6cWckSTxwRaVyQ2/1YkeeAET59SbSlk=
X-Received: by 2002:a05:6402:a0c2:b0:699:728e:48c3 with SMTP id
 4fb4d7f45d1cf-6a0a7c60706mr9085678a12.9.1785794674539; Mon, 03 Aug 2026
 15:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <6rbjbj74zh.fsf@pengutronix.de>
In-Reply-To: <6rbjbj74zh.fsf@pengutronix.de>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Tue, 4 Aug 2026 00:04:23 +0200
X-Gm-Features: AUfX_mwLFzASRisUw0SGYbdrUbrTEEZl2WcpJHPwHspkAa-eHL0jaqDpB83YDME
Message-ID: <CAEUXW=EHD1Y1zHQWE=jFhONM5Hg6TTc_uPYHgp-GS-4YWYJN3A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: =?UTF-8?Q?Ulrich_=C3=96lmann?= <u.oelmann@pengutronix.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 kernel@pengutronix.de, 
 devicetree@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
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

El lun, 3 ago 2026 a las 14:39, Ulrich =C3=96lmann
(<u.oelmann@pengutronix.de>) escribi=C3=B3:
> independently of the specific implementation, please keep in mind that
> the kernel is distributed under the GPLv2, which may have implications
> for a proprietary image embedded in the device tree. That doesn't
> necessarily have to be a deal-breaker, but it's probably something that
> should be considered carefully.

Good point, I had not considered it.

A warning could be added to the binding documentation about the licensing
implications of a proprietary logo, aimed at anyone thinking of
submitting a device tree carrying one to the kernel tree. I am happy to
add that in v2 if it is considered useful.

Patches 4 and 5 also avoid the question by construction: there the image
is a separate binary the bootloader loads, and the device tree carries
only a phandle to the reserved region.

In any case, whether such device trees are accepted is ultimately for the
device tree maintainers to decide.

Best regards,
Max
