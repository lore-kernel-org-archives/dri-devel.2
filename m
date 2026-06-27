Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A66C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417BB10E5ED;
	Sun, 28 Jun 2026 11:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lnSDjaO9";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D84910E4D6
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:07:31 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so13533045e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 06:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782565650; x=1783170450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UmhgP2D8HiKkDS6wrb+BQEzFopfYHIiJqOc6NEvXz0s=;
 b=lnSDjaO9xCEwUwlfa5sQdAfcoCzVQjyZnTV6lYQoI1FdiQmt183dr+Fcs2j+dCWZMY
 jUrsGAjWfXaNiH8xMmBZW1xB4cdnXsyCDk/+WDCVM/jx4TpZBd62LFiAVdQ838cwMUUP
 QCkIw+QFBrdjRJy9MiO7NUxC7BIR5a3ux8QlDyUabyellLY5RdlwdFAgkJbD00dg2whB
 fHvlKwQuNbW5oaEivmAnnsh3sqKH7CtYv/12+ECVkK0QYgSq4HSs99XFv8UpAojmKyo0
 Lmc6+5KGcAi2uMo7TrVth1hjfBA2JOx1wr/Ojs8je8+So7RZ/J3GafsvKNhSGpE48xu5
 aJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782565650; x=1783170450;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UmhgP2D8HiKkDS6wrb+BQEzFopfYHIiJqOc6NEvXz0s=;
 b=R7hslREguPgTRldiVq0pC9n/8balsbRVPyaxbXEP+SOHeAYVr6ifDBv0YEn0UlpoZK
 iBOdyEfotZpgAsN+PILu280Z3980VBKwBs4eV+379IJzvFzz58EcGmsQSHUNUlkEc2IV
 To+jxEDhlFvi7N506tOdSXkrb7I4y68VayYSx5s0RycTTYa+A/uzenTv3O9l40QgULNr
 2Wa6Dgaf+N0xFUhsSeK6bIMKJgWSOuG+mEf2Pnp1X4CcCOXULxm16h4CEQQoYLsX5TdU
 Oh+BojCU8sK6KqFv/Hi0dDg5S0tgK/ZJ19yiuzvkrR3d4BZUtM5UBKYXFZgdSJ6fhAX2
 sQTg==
X-Gm-Message-State: AOJu0YwoFozwdCNNe64ZWn8TnhgbvSDWxwNPuoTLXnqAEPBRTxhE021l
 EeSHULw+UeZuJpLZyTxDmbTmdgIK0fHCYEHfsTnwQrwzzDURJixF9Nx8
X-Gm-Gg: AfdE7clmkGMFrMFaWJRiU3nMLDYk+HI9+4Fw3MYLmFA4LfrP4FZBfzWk5D6F/d2TrCX
 Mm4eMYwyOVEd9+knePXyZMyyRH7O/Pp7EbsPSzJd2Uwm0N7dC3NZngrlFaJMri2RPSAXR1e+dEQ
 9WfwS64bOm13ubCNGalS63UURjdV1cm4eEW+JtHVgdZZUGRL1Gm6UVnVNByfbIKviDTDpx7jDTO
 wgpONxSnGYiT7hW7/enEPFTYOZviRfJQK3pGjxlOmwInbwQT4us+lpZUPb+FMb9V1Z8f1Zv0dfI
 mjyNTvqCAADSwJtQcaCqFvFzZ5btX4npAKNvldQzXfG7SBtHgKy72e4kzjruhnKDck0SHmzTqfX
 KTU1DF7hfsyMx8ENoBIv1Y0FZYpvt9oNZDoCKUmDpo85nr9CyxAIaaK8kwN4HNKZ6yuujJGXyqq
 01IFBIq8qTIj7DXqNObExIfio+tRjzkYpuSSi6lZQBmXW8x02QU1AXHxEI1hTmR3E=
X-Received: by 2002:a05:600c:c4a5:b0:492:2e48:81e6 with SMTP id
 5b1f17b1804b1-4926684a6b7mr156129535e9.4.1782565649964; 
 Sat, 27 Jun 2026 06:07:29 -0700 (PDT)
Received: from ehlo.thunderbird.net (046125148194.public.t-mobile.at.
 [46.125.148.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c278ab2sm84360345e9.1.2026.06.27.06.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jun 2026 06:07:29 -0700 (PDT)
Date: Sat, 27 Jun 2026 15:07:28 +0200
From: Diogo <diogompaissilva@gmail.com>
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Samuel Holland <samuel@sholland.org>
CC: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Remove dependency on DRM simple helpers
User-Agent: Thunderbird for Android
In-Reply-To: <PMdb9FVETQuPUnyh12NM2Q@gmail.com>
References: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
 <PMdb9FVETQuPUnyh12NM2Q@gmail.com>
Message-ID: <74626A23-5EF8-499C-AF4B-64003BF9F404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

Hey,

I saw the task to open-code the drm_simple_encoder_init in the DRM tasks, =
and thought that sending individual patches for each platform would be the =
easiest=2E
Thomas Zimmermann, is it ok if I do all drivers at once as a patch series?

BR,
Diogo

On 27 June 2026 08:55:04 CEST, "Jernej =C5=A0krabec" <jernej=2Eskrabec@gma=
il=2Ecom> wrote:
>Dne torek, 23=2E junij 2026 ob 22:34:40 Srednjeevropski poletni =C4=8Das =
je Diogo Silva napisal(a):
>> Simple KMS helper are deprecated since they only add an intermediate
>> layer between drivers and the atomic modesetting=2E
>> This patch removes the dependency on drm simple helpers from sun4i
>> DRM drivers=2E
>>=20
>> Signed-off-by: Diogo Silva <diogompaissilva@gmail=2Ecom>
>
>This doesn't look as useful change=2E Is this tree-wide attempt? If so, i=
t
>should be done in one go in one patch series, coordinated with DRM
>maintainers=2E
>
>Best regards,
>Jernej
>
>
