Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C5C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A34F10F6F4;
	Fri,  3 Jul 2026 08:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sqecuFYK";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD8E10F6F4
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:42:25 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493c733f15aso2819545e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783068143; x=1783672943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMSN/w8D8c3Ml2NelVlRwSQRShVwiaFWi/GCztB5J24=;
 b=sqecuFYKVhGCFZGwIj/lJCAqTiggs8zfcFWYsdUR/dBf9h4UBgRR/XVWGvlu7RR1n/
 T/QGqpvBNymTeqQkznRSeaiGhxWyCPqqkpMk0Tb3FVZTADGHoyjTTfuYRYRSs6fhVQjc
 lVMfPahdPQVHprDSEZ1BHGeoDbZ9eGdJm3AGQD1QD27fgQK8YYE9JlcLrE728XEzyFJ0
 C5+1W57+kZ7/sUjZK5AL00IfpoXgfZ1RwUdUY7LjY2qmvuE3uQlpcp+DZ74/C+L/MZbS
 lH+lWnZpmKUWNW3tG1YwsEMiiMt+8PZ9D1zaG29R2D9+oSyMw1F+HvJV/VI8JAIS5NZb
 kERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783068143; x=1783672943;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rMSN/w8D8c3Ml2NelVlRwSQRShVwiaFWi/GCztB5J24=;
 b=H/Qas9OhmwU3sWXUFpd6wGpmWRuQQWfn2LQp3qlQ4LOpaZU/k15JdLfQbMzPMb2mtw
 5Z1nhXjiJG/3GP600ixxuSnIHWA/9JlLlN+y0FS0B1ruJptfE3Ge4cREwvOHmrmINEqO
 5qMzHZg0rJk+o7eDrtS6T6MGbFsHrfpnXmAUoP5TtQKBys1bARJ19dtoH+Ff5TKTO8/H
 oGg/5wuPzHhOV79np/oYShevo5SDkiE0YtT/lrdhe5Ltrr/dw3J2eXGyCxJGAa8H5bvj
 HuRfi5ODwky4jS5O1f1NfOIxgIsqXeFG39Qf/vGVjoqDPoEHk8hrr6Eh1bxJc2seWJ96
 wgJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nvqxqhFhvwMnk4cuJzubjk5tryIdTl0oEzS2/QGfw6+KUGmV+UTdWeIRG4BYzlQEPQVYyZwDHNgU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLc/gwmnWY/xbMsWv7QUF1SMCwRtvQzEd6cyunGh5j+aKNIm8k
 55EExB3zEzas6cm1hghMuytjmmkCG2k3cZ9b/AixgWgxGGuZ/TGEHROTcU12v88LkMo=
X-Gm-Gg: AfdE7cm12h/l74UkU+MVokrdHsl0PGwsq5AWJ4MmcnHiUxFdnStPmv9BBkb/+6odp1q
 e+vl2Kts7imL7+TUJm0AUDEBIt9E1yOoJIdsQD3jDyRCo1hyAPwZN4VymAhdZ+P9rVjoMJ5ZDyZ
 w+w6GMyDnufAECzughoo6mtW6XBpsx2Oqq9jZoK1rFnA/F1shuqGQUX1EZzZMJQ3OlFiO9Fx76+
 sRV5eHH+NwETvIfB9A0FL48MPm53x0t/igXryuJyO6AAM3hqDtMZn7S8Q6q+pyDTjA9qbiQWfIP
 BKo+ZXzNbH9dnBQcMkwMmYrQT/ZPfql63+Us38GH+82YnGmBjR1Uz1JhlGpoIQKTL3A2W2K3xBN
 THwH5n++kWPGNoAwakqvMQXCpjfmvpG8A3mF8pjqy82dPpjiKcgb2kNC0KtSfLrKVHuGUbBgum7
 0OuAqByFvE0rkW+IT8dIKAihrxPnit1CJhuQ==
X-Received: by 2002:a05:600d:8649:10b0:492:6eff:7d02 with SMTP id
 5b1f17b1804b1-493c2b974bamr115602665e9.30.1783068143284; 
 Fri, 03 Jul 2026 01:42:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm30001575e9.4.2026.07.03.01.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:42:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ayushi.makhija@oss.qualcomm.com, rajeevny@qti.qualcomm.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260701-ili7807s-v4-0-c7d76d4780a5@oss.qualcomm.com>
References: <20260701-ili7807s-v4-0-c7d76d4780a5@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/2] drm/panel: add support for Ilitek ILI7807S DSI
 panels
Message-Id: <178306814218.3165305.10784888600083150493.b4-ty@b4>
Date: Fri, 03 Jul 2026 10:42:22 +0200
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

On Wed, 01 Jul 2026 16:42:48 +0530, Arpit Saini wrote:
> Add DT bindings and a DRM panel driver for panels based on the Ilitek
> ILI7807S display controller. The first supported panel is the DLC
> DLC0697 1080x1920@60Hz MIPI DSI panel.
> 
> Changes in v4:
> - Use active-low reset GPIO semantics: define reset-gpios as active-low
>   in DT and use hold=1/drop=0 in the driver (Dmitry Baryshkov)
> - Replace raw DCS writes with proper helpers: mipi_dsi_dcs_set_tear_on_multi(),
>   MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, MIPI_DCS_WRITE_CONTROL_DISPLAY,
>   MIPI_DCS_WRITE_POWER_SAVE (Dmitry Baryshkov)
> - Use mipi_dsi_dcs_set_display_brightness_multi() with 0x1fff initial
>   brightness (Dmitry Baryshkov)
> - Move MIPI_DSI_MODE_LPM to probe(), drop toggling in on()/off()
>   (Dmitry Baryshkov)
> - Express .clock as arithmetic expression for clarity (Dmitry Baryshkov)
> - Update panel physical dimensions width_mm/height_mm (Dmitry Baryshkov)
> - Link to v3: https://lore.kernel.org/r/20260624-ili7807s-v3-0-ddf37052a289@oss.qualcomm.com
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: add Ilitek ILI7807S panel controller
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/447a76a99e242fd04eaea33ecd9a6d73992e49a0
[2/2] drm/panel: add Ilitek ILI7807S panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/dd7ec83f456734de8efc115eac671e5add82777a

-- 
Neil

