Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C24FF44875
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 10:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F85910E1B5;
	Sat, 11 Apr 2026 10:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OMNpAKIq";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB0B10E1B5
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:03:52 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-604f834349cso1006265137.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 03:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775901831; cv=none;
 d=google.com; s=arc-20240605;
 b=SpEOwx6/IUqNG4b01jK7REqcmca051qc2ThoKFku6rj73d6SXZa3DS6y1pfszEjLdq
 /ivB9s1EsNe+NMDelVnuSCECfBuUiAoOZ7HaAxUhytFXgFva5t0Zba424t+cDDIKQFlb
 cc+y8jIViMozlQNYWNJmIsPCmmfmh/Jka87MIO6HzrbuxpFUMeTlrNjyzt+2sVrw3FVK
 XaDVdFwnWcL+Yxr83BeBDiNxgnSXSv1qQczoo/ZBezRB0nB1HPml5WePtD0ymg+dkx1Y
 nXmBIwD4rHWdlbxy+KurtE14DGtAIZ6wproLCae66a4kacsXXwtVZ0wF9xUI02w/lqTk
 rwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tzdzv+Lu99UxUsiPz6Bj7C5mvvvg0kBPlXADJIR5SZQ=;
 fh=jfzjGqz++RkRHam2jVyrgmv467hp+v7bO/IXf+QOYWA=;
 b=jd1C1cVi2BP9O0JQDTj7tY9Z9slHtNWNowNCtvkXQAmyaye913Hov4zhxPXqcxwFia
 IVaeTnGAp2X/VrP5KguRuWCVHL+ypDqeRALn2VeRGydATc3ZI/OuOuR9KjI1l6fUQLlY
 OaWbmXoPoKe4zyuYhVPskFtq9LyvtDGRZzDXe2xKaoV3Gg5A+NJyalOGUAkahS3zFbYD
 6s3UbAP9xxfx+C6fRvbGsCnMh5FD8ZXN4xbbvYOVyp3cauCS0THiABeHq6N3nEM3BSVc
 +hEVenNKY6AIm8cN1EeJDPhyFpFaXvplQzsEMWM9ws+zljwuf0LfzLcjo4cMkAuuel/p
 AHfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775901831; x=1776506631; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzdzv+Lu99UxUsiPz6Bj7C5mvvvg0kBPlXADJIR5SZQ=;
 b=OMNpAKIqHM5Xv/1w444ehNFNRftpZjacOFJetT3NtXoHm0nGImZWHy7h0ScfMZyRG9
 33UqP5l/kuzv6/sWiVkIHVeItwJ88T213oCv85FfCD0bUhXh5db58Iw3C1+kDtS/nYax
 OnBtiGd2r776t7a25sccflDlXWiKHXNE+rkyzNSctQ3V6kwVlhq3y0e25BmhW4Oy+xH0
 l5RioYe7k7K6+ExC2GgilFJ5VsImRk0GPyQc5J/IRXJIfvSzkatEPUyR5FxwQ/+AtF7x
 wyxjvzXMBbPTXvh/fRW+DqwGAEv4xAV7AzZLnHCxZoXtw9BfiuMVM+0FZwtRYXW+A9Ht
 shug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775901831; x=1776506631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tzdzv+Lu99UxUsiPz6Bj7C5mvvvg0kBPlXADJIR5SZQ=;
 b=ajFVFIRFD4kPP+Aw50dNuSH0BoC96768RI3gT7ukpTj7R9w5/SWDXrcUbGjdNyxT+H
 wGo9Pa1baoJPYC82RXuD2Pgb0Y8Ti6g9UXwrLdL/Sje2ZHLH1nrtY6mftAnfFZkibyzF
 civu1baBWcs7HBFtlY9w/nKMcLuJETmuC8JCznMmPp/y5ynPIjxnDcOJLqRcBsXZPWyE
 Pz43oS6YmXtKZchEcpv+Q3a5CyhkIY3Ma1JUWlGK0X2j5yyRzpsmYfgUI7bPCFecX7pQ
 GgkSJGkDcur+B62mTMI71yLBk0UjGJW91Iq4waq4CBoujOWf4qcrLcIyBG1vkTkRn1rm
 FM5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlpEfunwUA+Kdubv5JMGJmebnOL7icthDNIswJhE7NKTUpZRUoZboi90DXKz6ICu1yQaCuiHsICtw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxP8ox5q1abGbBgPPrGX62aUU+hC0OWvq5YtBy5fvFPg9kPUh2g
 wHI9TtbjrU3hvTX3CIrXU7xGKR1YoY6kaDcU/tNyEmRdJe0O1Ps1UDDvGo4bsJwMthXKaBl3PXp
 Nutwgp0SJyrxPLZGKj2Rm2q6xTMoHvDc=
X-Gm-Gg: AeBDieshFoA8X1mVPuOVGYDioSqv0eaO9FF5qvfD4nCUkJiB49kiaJd5GDCXnKZ/Sql
 924DOCDM7fzXr83vZpYdgm0UNtTzYtmStx0fe+8L6O/00t++aydGKWkhyqps/U30JygAHi3LZDP
 HhcQ+UZ307VeDfD4UJxJbNO+ySS3ufHAkg6St6Z+sJRYZnQcmnrcmkBUzXLwGNcC4NNRAOVGS/v
 iZcFUcjMCrWpWrH3/9NlKsY9gmKREYbvER8nrpnBFL5AWBHJSJiNjvSwnY4tR1M+nhGiJpPtl/4
 xVnWFoQ3XmZUQF58QPDT1od1INS+/1RiUUaDlxOtF1UsuKYPSA==
X-Received: by 2002:a05:6102:6044:b0:5f5:4055:4558 with SMTP id
 ada2fe7eead31-609fe48d9d2mr2627787137.2.1775901831007; Sat, 11 Apr 2026
 03:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <adjM-IhvtrghMDnB@stanley.mountain>
In-Reply-To: <adjM-IhvtrghMDnB@stanley.mountain>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Sat, 11 Apr 2026 18:03:12 +0800
X-Gm-Features: AQROBzAyYZuFVagVc_vBOi-Hx99ZeQPhqfSdTs1lmogRFo2Oryli_H93NDHjpRk
Message-ID: <CAH2e8h4=+qATNBqQDgADjctkjtabt+8zpg0z8zBRSN6bzBwxcA@mail.gmail.com>
Subject: Re: [PATCH next] drm/panel: himax-hx83121a: Fix NULL vs IS_ERR()
 check in probe()
To: Dan Carpenter <error27@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
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

On Fri, Apr 10, 2026 at 6:12=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> The devm_drm_panel_alloc() function never returns NULL, it returns error
> pointers on failure.
>
> Fixes: a7c61963b727 ("drm/panel: Add Himax HX83121A panel driver")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---

Sorry, Chen Ni had sent it.
https://lore.kernel.org/dri-devel/20260327021728.647182-1-nichen@iscas.ac.c=
n/

--
Pengyu
