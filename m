Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B932BCD3436
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36C810E0FE;
	Tue,  5 May 2026 10:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jpwV9PUV";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3724B10E0FE
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:05:14 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so17134295e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777975513; x=1778580313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDcU1VfHbCGuJTy56GX4ox0vXLw5tdTcv15F5Q8EwE8=;
 b=jpwV9PUV/XW0zrgXn0xFXeDPCNRSvxDWl1PlTiJIhhfT+qpg37eXjeYqbOzxZn62mq
 NcoPYkLG+1vvceIB61aO/X+6Z7+vUxhcoYdOxIBYGF/4Lq6mrTI43etEFRisaInJFxb4
 jlksRRr+FxH/2QIAx+N3/MGDv/xzR2uZUShP8coJt4JEt6vn6Gel17n8MLsHLE5cW+eZ
 oyFHSPA4IvZRkvRAmxldMfH4rx9FWIYqU4F0KheNCYrnbE44I90D8qUtZ3i38Ht1qZwx
 wErgjqnJNakzsaAmxuGZ0eoq7ypacNuVZOKqPaKLzD5Ssf5Ml5gnea1uehWmHsxoOplx
 RVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777975513; x=1778580313;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PDcU1VfHbCGuJTy56GX4ox0vXLw5tdTcv15F5Q8EwE8=;
 b=ikICw0oJn0voobyhqe0uyM0kCF2RkhXnzQPI0d8R7dw+6Aeh7uLkv1UzRudxznMqH8
 ZxNssa5vEEXfj9m1CGsQ/rll2SPJxFzFKgIZ7kZsZjAfVJHghiJ1GoU4NWPNPX8bxq5c
 GBKrXXodf13aTN4Z2MBVlQjN6leTyiawm7FLwYJg4rrDbHp0cHtY290RyQTMSYJpSfgU
 NmhAyCXQB4zQB5gdhmtiDHOw5oLWeJYs67ze5SysX80cvGPNwyBGP0mRJf6+S8cJ8XPK
 xG6snQVbR2vziiCZTKmVtcNa+rYOu5ZfHCPrg5jj7KR9vy0nv//58fL4Cyys4xAMOaNJ
 sNPg==
X-Gm-Message-State: AOJu0YxpKS+S6L/Upbk2hPdwAnpv8V5SdCxqFEcsFQU8ut22PULBjtUl
 FLnvsxinbdWU34fZjdKjHgiHZxqzosPixx87fCf0KFQSDmEEYmDIDmBe37255zASIMg=
X-Gm-Gg: AeBDiesD9XfMXmbA6WyeVrKpzNUFMPX8gZYOQCg/1UIclj24OQ3n12SDH4kJg0xmib2
 WEwoL3BPHpGYcfg5w5D8rDDS5+HulGzc1Oart8rBn4zaz+Edu22s4qiUGSDkqCGNJMfH0oSrzII
 76EzZy6y0db/afk4FcXFhjmlOCtbF+PI/w44IH8T2MCwGK5NS+bvOE7AMCgo9aziJidfgY6UWJG
 F9EE/FkacQhtuhjxqPB3HU42kwk2YPeU1ljddNhz5PFf6vV0yybEs917Hm01yirpvlP9+Lg07XY
 lUi55tSwskHirmTQddZlvnUVFsA5oOFLbUjT/x2jzHzQ7BVOXM+/aBU2BJpeGzYBiPmnm2ggqFo
 1doy+5+Y9rjFAFmraHrH41Q9JUQRkS7AL65lcE2G/wh4pz0O/vu/Av0qZJ9vULRyA67QeOgmiOY
 VqkjGoGwKGz2QbOuo+za3ZdXVUnslfm2jQ79n6a3768cCI7rtE+Aa8aLeBi7FyMzEy5w==
X-Received: by 2002:a05:600c:c082:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-48a9887190fmr152119415e9.8.1777975512645; 
 Tue, 05 May 2026 03:05:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c8556sm381856295e9.4.2026.05.05.03.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:05:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260407-panel-simple-startek-upstream-v1-0-76721696655f@pengutronix.de>
References: <20260407-panel-simple-startek-upstream-v1-0-76721696655f@pengutronix.de>
Subject: Re: [PATCH 0/2] drm/panel: simple: Add Startek KD070HDFLD092 LVDS
 panel support
Message-Id: <177797551157.290023.14211642204638721298.b4-ty@b4>
Date: Tue, 05 May 2026 12:05:11 +0200
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

On Tue, 07 Apr 2026 11:31:15 +0200, Stefan Kerkmann wrote:
> The Startek KD070HDFLD092 is a 7" WSVGA LVDS panel.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add Startek KD070HDFLD092 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9252742eeb74853cdcb7972eb2aa39fa6385752c
[2/2] drm/panel: simple: Add Startek KD070HDFLD092 LVDS panel support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/247e7480c13e77079b71e783c478fc7027974161

-- 
Neil

