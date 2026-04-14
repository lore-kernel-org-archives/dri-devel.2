Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27A4ED7B96
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 10:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E51110E569;
	Tue, 14 Apr 2026 10:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="1UmSMgHO";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D46410E5BB
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 10:13:48 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6716a2d9596so2881093a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1776161627; x=1776766427; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJSw8VlpR0SQaT46EC/ZG9s+q9gQW8P2r5D2rKPIRLY=;
 b=1UmSMgHOR4gEBHpk68iPuIpZS2z8RDTPs3bltex2bAZDhKo4KapQUu14IP/0PV2IOH
 NQsmXkSqtuxFmbZnmEEV9w0Z9xcH9cVlD/klyNlIGoJrgJwFfF7ZJddtrG2/2CCMmxlW
 aNASjIABBulyfb7qBQN5kt+iiKN2tm9skeb0jELEFh5HCaR4F3VzTtGN+RmhrjfqqMaJ
 VMmb1iEH0jbjK1Rcwf7qbiiTeSxwTsisWmZp5HC1Mt8PEJOIWgvVUb167oE3wyJW1HYn
 rXv7pphn8erGTto5Nh2AMGjkNt2z5VL24ZlzqgigGJAgtvkaSi97dWujprJojnCl+u3w
 70Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776161627; x=1776766427;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SJSw8VlpR0SQaT46EC/ZG9s+q9gQW8P2r5D2rKPIRLY=;
 b=YxRkE9F6f0lvIUG9ad1AHCjksm3Ld8oE3tOAXybxv6j2wGXoI+HKhn4Ru8D2VOuN4d
 jFY8aVoXUgxW982ZdEiB36+vwZFAOMP+N8LcoSHKezGp45j3ogVwqPLN+gw3zBFe+xaY
 MXJv02ISI5gffmabAZmInVG0ZIgzN41N0qDEagdY3pm5fFKvM2Tu5d2PlAquTK8Q3OdI
 sTkghdpKXp7Hg6kJoRwToMYJ6+XNQgi3yPm4r61LZimJ0w6q4xiAz0b37YN+5jVyWSKb
 s6h+M+eihATmMk4TnNQnwPPAH7l7k3Od0MhVx60pzhEnm0C6Dy6iiFC9RwXK0ohF51NL
 uhhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TdOqGfEMblrDsm/Gf4iS7i3AoJqjWoyPpSC6rloO6PU9yqj5qZjrq2BSe4boUTZk9BifoZDQS6FM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkmC4RNRCsiWHDbx1uZVEUH4Bs4Y7o4UZQv6uE/J6bQ2kQQmGx
 lQ1yGXWxWhjpDU9pHPnKIz9PszXx2NfnEKNy13IpbehgR++fsXK1xm1fyJbinkCoAdc=
X-Gm-Gg: AeBDietmcymzebOtopv5MKEGOPTpPXW6eVZP3xPcLtGF3C/YG4d7KVIm18+36FqPyZ0
 pwnTNrs9BYh9/1ehZhDHinAl7BBnVX/et0TI4TrOi6FDLH9QXFrdQHDLZRuQlcNDVgfQfJWt/mw
 IrMogztqumUPUHwYbH0sO/r36iayMkJFdGYlxDJElp5dAUemToKrYE28AIjuL5N3cjXHUkuJR70
 uO5SU8Z9CiEFUdRI4uTYFbdFISs8GnePBSgOxMx3tjvXSMVu1gPoQsx9THfDAOXhajmBD2r3dQt
 k+t7SUg0ljTpgDi+toPGiso17PriNKKRHNf5L1HTErShQ9wvYenO2kQTEGm6AzsD3JWIL1HkJHX
 80W05q5zxkRbyJSHONYUgvzSg1K6dOclYnWl6NT47uNm6WxwPBkK5xmKeJmcIF4f4sYOUnGIS5n
 TWcT5IFSOfZPJu9SytHlrmBZDh1ss3TnAbwHHQ9QrqGDkaWjAdjy0yeA1APaLMl+Gu3rYw
X-Received: by 2002:a17:907:c80e:b0:b9c:b475:90ff with SMTP id
 a640c23a62f3a-b9d7298086emr974077066b.30.1776161626946; 
 Tue, 14 Apr 2026 03:13:46 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9d6dee0d9csm386880166b.16.2026.04.14.03.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 03:13:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 12:13:45 +0200
Message-Id: <DHSSQYIFSY92.1J57RLTLCH8B@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/msm/dsi: fix bits_per_pclk
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Pengyu Luo" <mitltlatltl@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260307111250.105772-1-mitltlatltl@gmail.com>
 <177463970785.3488980.6066718261448635938.b4-ty@b4>
In-Reply-To: <177463970785.3488980.6066718261448635938.b4-ty@b4>
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

Hi all,

On Fri Mar 27, 2026 at 8:47 PM CET, Dmitry Baryshkov wrote:
> On Sat, 07 Mar 2026 19:12:48 +0800, Pengyu Luo wrote:
>> mipi_dsi_pixel_format_to_bpp return dst bpp not src bpp, dst bpp may
>> not be the uncompressed data size. use src bpc * 3 to get src bpp,
>> this aligns with pclk rate calculation.
>
> Applied to msm-next, thanks!
>
> [1/2] drm/msm/dsi: fix bits_per_pclk
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/2d51cfb77daa
> [2/2] drm/msm/dsi: fix hdisplay calculation for CMD mode panel
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/82159db4371f

Just wanna document this somewhere, 7.0 is quite broken on QCM6490
Fairphone 5 (8-bit cmd mode panel).

Picking these two patches plus "drm/msm/dpu: don't try using 2 LMs if
only one DSC is available" on top of 7.0 makes display work again.

Regards
Luca
