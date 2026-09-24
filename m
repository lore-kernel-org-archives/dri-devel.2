Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59A2C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D9F10F5BC;
	Thu, 24 Sep 2026 13:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gptGYHbc";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53A110F5BC
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:59:30 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350faaso1390172f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790258369; x=1790863169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bjiz5fcvqLF+AelQDc1eUMc5aT1mzQ/HKFsPWrKukUg=;
 b=gptGYHbcvGej0eQz42gJGXy8vIzcvBgvQr65e1b9Lov7c24XGRXDD8B4A2Lw/tD1ck
 eUyTRRUc0v2R+C24S9Qz8Yc0pUmeVkYaCr10hCOJDGw8kWxzjco22jsNzVRnRW118ovH
 VgvAbT6Db6S6RD96Jv8o6ry9TUGqsjfxsw1QtieQS4q/Sr8YJmali5rf229374Xs+Bg2
 6e3HczlE6A70SyGzz4QmMuusfdqLlayLTKChZwIW/pdKAe8E48Fbh8Jf/z+bcItroAmP
 FcuggDksZZWRp7bnDxpbHKNqWmcQ/TWLyYbKOPlNfYe5Keg8JePPnNdyvXZg1WDAbAVO
 1vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790258369; x=1790863169;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bjiz5fcvqLF+AelQDc1eUMc5aT1mzQ/HKFsPWrKukUg=;
 b=rtQQ0DKxhWRmFTedC6jChO82aeRWiFIHNZwXYMhFQQXovNnPTeiJsCLtHg2RSWAdbb
 muImgkwiRt9RZ+oo5LEG470/q1yj+sG5jB+dpjiao9SlbrQHICNxLKU6FuLEBtC1GFIZ
 VjIDxS4b7MLxKxkDopppzuXNgqnXTa/ZLYLDi6iT1Mzq7XiG1sK5I+326A0wp916lQ59
 itCy5JSwJan+K2MC4O1SSGZor+zh9m9VSHufDLLIMF89ou81x/kTw7N1HH/f6avOKXaE
 lexQW29nomkbWx6CpDHX2OquKaFmXuim2kIl8Ps2JM8F4wP0l6oJY1ug1iQscH7wT3GY
 /OcQ==
X-Gm-Message-State: AFuF++m7fucUzqTGj4yupRtR7srtKy8SwKKp+Gu4EZ2q/rC41VBBUD0x
 e5SkPYBjodjfxNefo7QIEtlantxKKRRHkYKOf7aTyt8ZZ5BpzvRfes6aYcpQPXW59nM=
X-Gm-Gg: AYBFou3zM7hRs+fRRegrxOgO7hEn1MSEbYa2t3T2SwzJMP4v0N48zGee5tWAtSdM7OZ
 9ZjtSXYjwdn/b1DhCRrmm/r44OyRGENNSW3v3HKY1EUxKcDcIFs5m9cwMolM0wma41zhBpQltn7
 3gJS3f4mJHPNeDw+/C2xW7iMArIKqgO8tJWY2mJ9KtYZc1epUH799UrUAWsz2OJiVJzeZP46A5n
 wDofcldOoZOJRSLeJwo6dPA1g2vVQE8qoXKKitV5W10DZowHmX2v+H85zxt01z74W4DZTy84MXb
 e68Az/jnvUTJ+/o8yuQOCIlHLg9PBelqeqS1vB+TMVF6o54L6s+XwRyO5shG/d55c398qQoQ1V/
 5NrKlA8MRr+PD/vmaPYrGfzlSCjMSMNz6NN3Szjuk1E4MieEsMKgjbBSipooAdEcHMVSe8la6qN
 gd5F0h969e+Id8boSzlKA53fmdv8IqC9Usod4GfoZzmMdbKW3VbcaacNfozPUzCt/SOlqVmqAuU
 MoVm0Ym8DT1wHH2iXfu
X-Received: by 2002:a05:6000:238a:b0:487:84:96d7 with SMTP id
 ffacd0b85a97d-48871974f03mr4191954f8f.53.1790258368630; 
 Thu, 24 Sep 2026 06:59:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c500sm15799213f8f.19.2026.09.24.06.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 06:59:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260910181918.31551-1-marek.vasut+renesas@mailbox.org>
References: <20260910181918.31551-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: panel: Document 10"
 Raspberry Pi Touch Display 2
Message-Id: <179025836777.3234093.12909071047594857987.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:59:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Thu, 10 Sep 2026 20:18:42 +0200, Marek Vasut wrote:
> Document the 10" Raspberry Pi Touch Display 2 MIPI-DSI TFT LCD panel.
> The panel is based on the Ilitek IL79600A controller.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] dt-bindings: display: panel: Document 10" Raspberry Pi Touch Display 2
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e40d71fa231fc510c87c92cfe40f60f18eaafa61
[2/4] drm/panel: ilitek-ili9882t: Make enable GPIO optional
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/803d7e465616d2822deb10ec3bf8952e49ffd6ba
[3/4] drm/panel: ilitek-ili9882t: Set prepare_prev_first
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/20f01db1545252cf81a39202920d0b032fb4501a
[4/4] drm/panel: ilitek-ili9882t: Add support for Ilitek IL79600A-based panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/481b38467000602761215ba4a196e89f58248055

-- 
Neil

