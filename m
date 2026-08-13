Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798F3C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 23:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A34810E0A6;
	Thu, 13 Aug 2026 23:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rrLFnIiW";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BB710E0A6
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 23:50:48 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso634513a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786665047; cv=none;
 d=google.com; s=arc-20260327;
 b=VcGcx+/MQ/hEVmS5eKK2OqR8EMCZn8OD+/6kNkDi5BaaA0YRYf2mVDogCBzVXp54FD
 MSZ3LHr85rJN7qHFYh+vY2ZV8RXCgDVa+7qEsSETGT+xlV3Bi4Hu7H+n50cBfBcSmbf0
 FeTItBWgu+25q6cQgJunjXk/YHmNHLSAwEB88sbq2x9aVf28TEQTkybTgvDqSdj3cgMq
 fkT4WSzsvJrGTiHx+1wP/lL1wWeZYljsoW847kg4fLOczA2r9UKU9JHtOJwCVxDYrL8f
 cZh8VWA/W0bdsSFaUfcx8h1HHOmM4Mq32vGVFvHzBqLECNh/2fMitjFzGGtMl4YD+PhJ
 Gu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T/dfQBLHu5s8TsHAIwVzyPX7PzgkH5dDnFw2MKqwf0g=;
 fh=ee1gBx/JbCnzdRIwjeIfYe4TLE9PGqu280c9nE+BW/8=;
 b=nk693nSaXx8iJNOnvMGjoLdo7p0JiccrrOdcXJ68mcHyrWvTjq2tePK0WYrtMar0Xj
 LMtrXhSM/uh3JSjleGqiUxjvTY5k+xg6qAHrbB3kQth2dq1sQOdvhjJF4JZzAtHmwOX7
 SCr1WJhuqnZgtDLd5uvJ7R205EkRtumEoivxUNBNBkZuuGs1+0rVLsy8THnS7Eilqzls
 P8u81bEWj7xEh/+rGPfQNeyBmPiamoAPjBqJy9wNLPMZuJyQbVZs2rbeW3ymECN48Gae
 KdNPR5v8d/CcDnVrrd2OAEZnETStyFDUcp9i8HYL7ejJonzNIWfo9HuZE48kwk5fHCjb
 icrA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786665047; x=1787269847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T/dfQBLHu5s8TsHAIwVzyPX7PzgkH5dDnFw2MKqwf0g=;
 b=rrLFnIiWy12MJBvCs0y/e7/QtNPYHWY1KYGD8HHiUuEUKuCrCimbbE4lw1JWak6dgM
 Ge+pUfB/9ePh93t/8dNfOX6XKTxuSNAirSX7qzIOosy7Joc2CNjn2cFAfLUWjLA084vX
 KMzvp/IABYzoAfYD9M8GxArkfN9WRhgelZmrGEEvoYJvkvMOPt5be5VafhjGW+CyiOv5
 8CLyyhHz2+8HQfHbNZaoNZNKQ/f7ARq8GroPZ2e3nP0+OWnf07T0Pg1+7C0T0FCjpl4p
 Ki1piLfTunnfdIl3hhiwydwMSWbcr9emN7SUvF8ESstGtcYM8dNWYnJbfQ4VXDpjx87J
 IPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786665047; x=1787269847;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T/dfQBLHu5s8TsHAIwVzyPX7PzgkH5dDnFw2MKqwf0g=;
 b=klH+D+pB7ZILtXiJBAG3iq+nSgCSR913A2Kn2yy7nRN9+ZmiCq1Zwf0X5Dury7wEzg
 LkgyivtGjj3JPK1zKPewRMfnJUvcyd5DjTdKou5QqkoMiWpPiE93zZWUMGgwKClnSXoy
 6YXXj5WTmbqhr0YPqa5LLwFhnBtK+9uwwYny9cHm/EsI3J58jYaXXOVA6m8p3QPri/sh
 Vy374X4DUYeeWqx9rSiKU2uFLHf8fqk56C8i5Q5bZZIpHLh3ZLFTqgNqayYkv6SmZ7Eh
 QdtBgkb0d14VNzpoOQvNju42sJtBFxHmb2gpJyS3bfErnyhxYoXi+uB6hW6vHAxKnTpQ
 gDcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbDimO1NVLM1wiNkTZJfiwulG5MfN316k9h5bcWdRem8X4RNzrCXfpqkkBT1Vw9N0UWWPrpO4vREI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPUp3nLphzJgTMLInLYA0ca33yFNlloMW1SOvzauFxSDXYK4wf
 0j9n3qPVFtBOksgPFJL8ZL+3OyNQdj/5enlHgRq5/8wV3AdNbKT35ErwvJoDNG8F/53yb9hHh+G
 iF53HBsykGEFCre04cFCWVGYtZPeKkQg=
X-Gm-Gg: AR+sD10h0iMTziYYUSyYHxiHQ+KO8q6UEYe6ixxB+2IZmlv9CuNDPRknTkLpDtHAE8v
 /w5tsBK6c1iXnvJC01a69l6TYr9IvyGnUDBO3yyxNnpe7PB9nJuIUJmcolqHJtyTvmSWA/lOPEj
 eSYt7CVVQivAErOM1j0gk95bFpWwqATX8hPg78jc9UpQVgf7WIJ+cOdp/RW3P0ggRHQFQUu6cB2
 DLLsy45UFJK/W3HCsgMHq9vvOjpegeCsundc+Egm59kN4W/jHazf3JNTvHsQSrUyWhqIvKY9TvT
 5zfimr7hQ07pSxjTBi3UgLWMNDQe/xZNe2clm8cIBUml
X-Received: by 2002:a05:6402:504a:b0:698:ad4b:abf4 with SMTP id
 4fb4d7f45d1cf-6a38a8d7c48mr896349a12.3.1786665046571; Thu, 13 Aug 2026
 16:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
 <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
 <20260813-ethereal-sawfish-of-downpour-c23da9@houat>
In-Reply-To: <20260813-ethereal-sawfish-of-downpour-c23da9@houat>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Fri, 14 Aug 2026 01:50:34 +0200
X-Gm-Features: AUfX_myW-QMGZXXJ8a5tVXZ3ZTxXNko9mUPevusA5ZZV81bVlEs6TTsn0To5954
Message-ID: <CAEUXW=GE1atEpG3=SHZhZR4cAXvyMBp-K2n967MVY0YS9AwcWA@mail.gmail.com>
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

You're right, on essentially all of it, and I owe you a clearer account
than I gave.

The 3.4s I put up was our 4.19 product kernel: not an SPL/Falcon build,
and not one that has ever been optimized for boot time. I should have
said which system it was instead of holding it up as if it were the
floor. "Suboptimal" is fair.

Reaching for an initramfs purely to paint a splash early isn't free on
my side either: it pushes the start of the actual application out a
little, so it's a trade rather than a clean win. But that's a detail,
not a rebuttal.

The case I actually care about is simpler than the one I was making. As
someone building products on top of the kernel, I reach for the simplest
thing that works, and the kernel already draws a boot logo =E2=80=94 so tha=
t is
what I used, the built-in CLUT224 image, from day one. What pushed me
past it was not speed: it was one kernel image feeding four panel
variants (two sizes, two orientations), where a single compiled-in logo
no longer fits. Describing the logo per board rather than per build is
the whole of it.

I'm well aware that "convenient for the product engineer" and "worth
carrying in the kernel forever" are different questions, and that the
second one is yours and Helge's to answer, not mine. If the verdict is
that this belongs in userspace or the bootloader, I'll take it =E2=80=94 I =
would
just rather have it decided than keep guessing downstream.

Thanks for taking the time to push back. It was the useful kind.

Max
