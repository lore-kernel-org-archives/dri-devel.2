Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA989CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A48810FD78;
	Fri, 29 May 2026 11:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ys/78qjh";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF99310FD78
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:10:41 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so92631755e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780053040; x=1780657840;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VwGJ1aVISsmjGLnoNcjoGKPnok5e19Xi0seckWEDRu0=;
 b=ys/78qjhb7R2xAqRAOlYXvsL99lYHssTsHjbfTN7Ay5NN4FUpCX/Sepz0oOblPk8Ke
 HfRQvIiCTYuQeZXCDRHdlwLpBss5f2qrBN8nwnP/zYaWgU5GEpGGPNGSRVsDTXiFJnnD
 s85PHpjCAfA/pIQcy+QydHYaxPxiXR9F8DKaZgu++wNcVd7AWqFt0mzVPN16VHBCG5BC
 zFsW7M5jbTBZryOJCYKmkUOPLqxqPbFc47CVI0CBx/VM08phSQUw5Bn2tNtB7Ezk3OdU
 9Ke6Zf5em8nW9XF7LswH4/I0/mcJxWcNwsHI7cdAsxasz62+Q1LYU0gW5iMKUCstPWrA
 vTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780053040; x=1780657840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwGJ1aVISsmjGLnoNcjoGKPnok5e19Xi0seckWEDRu0=;
 b=pGyIckNVpe7ghCLBGfghq8MgIAbjvbvJBqEHMzhUTwmPSEB0+sRu2Blt6llTmMvmwg
 vuefnl5Mn9iPFtGaZQiWK0iUtuZ8GB1cFFOUmDnFn47nT+snJeBRUJM+OvoqEhtSHSG/
 fNXRX3rT5MlCGoqYlWKqWtugOSjoZkmuY1v4S/wUorHFFz+fGoJoh646sqLYEXdEW0nS
 VZb5hGPYspfPMWgChcUxVcas2LdkCkKhaZKWj0YDNizSFmDe4ZdVkB0JIkJPhQEYd2Q6
 uXqG0SAQ9i4/pyvoHmxlBPedIu7WsbX0BI46Qf520qz+bnYgwEfB2SHB7WcxZJ6P008R
 VI2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Clg1di2vRbgTfie2B/5yApBpwuuzoOSvgmALmTb48yug0DU6Ih1A2wR5ZwBNhVCSW/hvVx/SFmHg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyrio6MzzVKtuWWaFMYJ5IMW1vgat2M6tj/dA2LTVN8hrB5AXRT
 MWdPWTHDQVWQzr+VLshY3P++7qcCudJEdaBNeshezuxdSyCZ/zoc1p48xg/fqE1CYnw=
X-Gm-Gg: Acq92OHSsUr3lXk3ugldeNTcMpmNhpbZTcP5bmPULV7qexOQP353gF/2Loqc6hFcJzi
 hsUrq1czuIY56rUfqqREGCVFXsHoksKkb0sNY/ZAn7f8Ya3P8S8UxMV4jjAmnYF9kleMMiWdqHU
 6fr8ozryfaPSIi078R+vKbzXnEVwoqTyJyY3hCtrKxd1L/xX2IwhUyTAgcO6e8f4/CjuFCuZ5FP
 V0TIV+gLo/OpI4xnQYFJuu4i9VZKnmFYvakbJgfXnTDjsXicjSn7D5LipRMi0mijR0t8D4enKmX
 GBhR3Zm5mGuBvItF2pL9mbiTrINNWNPr9RFSQLkQBnBcYSMqjlEtkWwVVYAS4/sM6RuAaQBfOjl
 52OVr2s+HnRkgg8c6jKiW71yao7W2nF/rUtFsuns9Rc+sZZnYuLc+FJsGBlNmioa09dinAjbQCA
 TYin2POEa9DuhOAU8x2lEjMcVArXU1B3dQYL1M5Nrd/S1S6GeVdn5Y95ZQM59WIT73QjPbA2NVU
 rCTw1qgojGd5k+5obrDwetWQOGXOLq+SjbUqgUTHwBcyu9SH9h1xk83mQv5Oimk6g9udSyCkBn1
 vFI3jWlbJI6ZQCpupzvZLaijxju85Q==
X-Received: by 2002:a05:600c:4595:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-4909c0a4c85mr41540435e9.10.1780053040047; 
 Fri, 29 May 2026 04:10:40 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c103b98sm11912765e9.19.2026.05.29.04.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:10:39 -0700 (PDT)
Date: Fri, 29 May 2026 12:10:37 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 5/6] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
Message-ID: <ahl0La8OQHXAlV3m@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-6-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528135123.103745-6-clamor95@gmail.com>
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

On Thu, May 28, 2026 at 04:51:22PM +0300, Svyatoslav Ryhel wrote:
> Add support to obtain the initial mapping mode from DT instead of leaving
> it unconfigured. Additionally, update the linear sysfs code, which uses a
> similar coding pattern.

Words like "additionally" in a patch description can be a sign the patch
should actually be two patches. In this case the patch would be a lot
easier to read if you cleaned up the linear sysfs code (patch N) and then
added the new DT logic (patch N+1).


Daniel.
