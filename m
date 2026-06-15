Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02311CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E58C10E21A;
	Mon, 15 Jun 2026 07:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AaBgP3Qx";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D8710E21A
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 07:10:39 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f95so5663458a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 00:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781507438; cv=none;
 d=google.com; s=arc-20240605;
 b=ShszICyVy7MudCdFj9inQZNPmv9Kr5ggRT+nuNX74odyVyNqtARNvmQ7OJyIZxnEEF
 X2dRQExXEnUR5ByUvoi5DYZqKwaUdkQ+1uVlYxHoT+DgmXEH/A0suiE7Q30vovlhC3n4
 /EgDR8jvyL64fak/68CosJ0dqLaE6aY6xT3p5/aJpl4/tPArxaFtXhtyv0g9HQI6oLpJ
 hVUfo1l0/tQKR6k3bhBsx2CaPLri6GKCLj3i4Cy0Js5haipVQdhyoRoXD5el8jvxBQHe
 8gMnSY8dDY1J6WK1XQddyvo9XtbWAg5/yE4eGLtun9/YHJlJiU0jv8co6FgoTY+cledb
 27Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ox3fjy9suyScmRrcmhaltE9MsZADpI1WVron/xvMJL0=;
 fh=oZ1rxcy4IIIorl7BGZIIHcBWAgtpRCViZgFm3D+380k=;
 b=ipoCM99F738nYQF4Jbxcrac3adn8ZalLoMQ0+IkjMxvdA3uGAsv5LrXB/icMTRFkzN
 RSZ2MA4C4ANikZZGarH6w8qVIlosJM5AeO8AiZkaojtySYw8hlLuNaEqZlI05P6Rb6sE
 Mxoz1SwdIJu4/5o96tuB5q0o5jW/+xAVPabfgyK+CxL02czjbhyOwX4dRM0OYLXpWN+v
 KDF363SqFSJgCA8YpN4TDC947DrxJ4VuF+ExZ3P3MAc5tiA/qyuvSRrI8VM9f4fxg6B0
 ZG1x1n+IA0txwOAQbNKrTrPPxu5RsdJdIcBqMBcJUkSJXjdTWve4/thYvFj+YJ8rLOph
 lUnw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781507438; x=1782112238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ox3fjy9suyScmRrcmhaltE9MsZADpI1WVron/xvMJL0=;
 b=AaBgP3Qx6F+XTfGltY5nUmIJJT1j7RMKTE4bUZWjv4+8uWZ8bInqRbhNROnc1aD0F1
 U35Gg25U7Cpvh8+XlBUNp0X0YqC8VmbLZLbSXJv5jd1v1uDgvYk37pzqkKVtcMnchFao
 vEcuGRGTuTTtzN9Wb3CRZZvbxvSgWbJApYK+8bKcBGxOxKCaV9VUHuQRroR6MJBguf96
 KDkIiMXNWDdOZbRJSvBFi7ofM2uzsXxmR9kK8u4jIYnOtG9rPSnTejdwnccgAlPKCdJX
 YTZ3+wBOGytFCUCMC1BoNjxaS/1H3fQw1eN3iR9pgDVxAPiFXG5WYm1Gw0qsgKZV0zd2
 aCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781507438; x=1782112238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ox3fjy9suyScmRrcmhaltE9MsZADpI1WVron/xvMJL0=;
 b=Vp8tcB87/jGHrOar4ukzfCNQu/XmpysjJ45cVKwuze/NH2NMWVIPkTzMx4241JDA7P
 EMryOgazHTWUXUq4QjQzushXBNnjLJ8cGUfD8HCLNA90vtwvgnJDS/gAb/FxI5p9lIdN
 eVOfNwz21K/v6fAPvdxM/jEYN/HiFFF8FdrqP0bmY9uMQVRlckmkITDtR6Uvxx7+LAyV
 mQdKVGyamTAkeJS9ZJsxCTxEZ6UOLgpBA086zXnJaYO7Q7h42uOVrqjmWWTnwFQN1vSD
 TSu86j35vYLau79ttbHLR0md80agp8TAHexg8QGbIW3VzBJnbW6P8iXBohVGBtHatFJf
 MADg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+va6HzdydvdIcv4gLC42FZetWgGPOmh6HX4ms9yRxce0bVUvFFZKDRcUiaWGHASylqfS3v+k+nXCc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwENC/7wrfEbiUG9YJfpVk57ntvcA5+hcG7Tp0E9sou85MUx2Yk
 DHSP1tLEgT1bMjqE70xX3sdso3toBpMQle3RIjTIjS0+QYGnwDk148Ghk43ijZi0nsVcszMJe12
 g/79q84qVcjJwjX45Pzz4nqK/pL4tc0M=
X-Gm-Gg: Acq92OFbbWUV3kGX+wXxvWBYJph74OCS4qpdjQqFm33ZEcnpylnLr7PuZ5NM8//EoqE
 3W4nD8zMlwBxhKMkMNrvuF6S6uZcPO8nKoXS8ylfxjWCCMtch4NOLtVz97w8O0httEj3FF/B+ai
 m6cx9E6Im6yJvVIkHITLUuvwMfimp9lBBMES2zVV3eOUYob5O+ZMJFtRFgNuozhMQgaGnRihI5u
 SEmrRD696q8Z/3RSApleu2FZ1seYjq8ea+nkOIZyEuvVwtNdxSdGWIyzXovtVPAGbVBMdMutilo
 NElBfidnvg3wvBO94Nz/Z/h/HYtxDFFCWbJ5sDZYhgcaITJr2x79dfvV1Hk6IJ9CQqQFmGU9oUt
 yKxqH4Aobt3i5cIi2s7lq6CDMjc/SWmD7PL8nPyb5E91ufoSaTxusoxh3/1skOiMb1LkU
X-Received: by 2002:a17:906:cc4e:b0:bd4:6da5:d5b2 with SMTP id
 a640c23a62f3a-bfe278302c0mr422985266b.1.1781507437663; Mon, 15 Jun 2026
 00:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260614200837.17908-1-reeveskeefe@gmail.com>
In-Reply-To: <20260614200837.17908-1-reeveskeefe@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Jun 2026 10:10:00 +0300
X-Gm-Features: AVVi8Ccqd-I4uOPWzClztukgUI3AAdEG0bLZD1O4-8fQaU-229tIeoSg2FTznI8
Message-ID: <CAHp75VfSUfjo6rxUdwMghZb7V9s2_AgYCDex5uDX3cCWZOenyg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: use %pe for backlight errors
To: Keefe Reeves <reeveskeefe@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, abdun.nihaal@gmail.com, 
 error27@gmail.com, chintanlike@gmail.com, namcao@linutronix.de, 
 niejianglei2021@163.com, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Keefe Reeves <229415268+reeveskeefe@users.noreply.github.com>
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

On Sun, Jun 14, 2026 at 11:08=E2=80=AFPM Keefe Reeves <reeveskeefe@gmail.co=
m> wrote:
>
> From: Keefe Reeves <229415268+reeveskeefe@users.noreply.github.com>
>
> Coccinelle found two places where backlight registration errors are
> printed by passing PTR_ERR() to dev_err().
>
> Use %pe instead so the error pointer can be printed directly. This keeps
> the behavior the same and just makes the error printing cleaner.
>
> Signed-off-by: Keefe Reeves <229415268+reeveskeefe@users.noreply.github.c=
om>

I see a subtle problem with this email address. In case something
happened with your contribution (exempli gratia a regression found)
there will be no possibility to contact you without digging into
mailing list archives to get your Gmail address. I would prefer to see
the From: and SoB to acce-pt responses.

For the change itself, I have no objections. If one considers this
useful (probably to stop flood of the similar patches in the future)
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
