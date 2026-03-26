Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DBE106F309
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E00410EA37;
	Thu, 26 Mar 2026 09:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rVMWZZtj";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C726B10EA13
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:44 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-486507134e4so8823745e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515763; x=1775120563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SO+1oE17hDIKR5mphj28NGtnxtIqXY3QHBAqdZU43PI=;
 b=rVMWZZtj+Jy2zyq9TIf4zAvrlx+YC3GvSJ8nhKhIoBo3JCoA+fc/5VgMfcY8oc7GWd
 IRNN24YWLJBCSE9Api6Etb5SiAmEnDgheyvsCc4IhYUwGNe91tv36YLrL+kuepvvzc0X
 06SsT8rayyyNrF6ramHuIdlLA98FIV22u3ze3n4EHgQRddmRL1cHcFvxbatFcATOyCKc
 r2iT8NZt79nXOTAGFdQ/rmtgwA+US/m7rZ45oNo3Gw1/8TfaBLZq0E05aCy+FlOyAFDt
 iDlLUlFcWxH207UFscVweH/1pG/xlZ63KT6Bm5RKfvNebAnkJPABT58doP/X9NkYwMwe
 lXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515763; x=1775120563;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SO+1oE17hDIKR5mphj28NGtnxtIqXY3QHBAqdZU43PI=;
 b=Ac8MOQ467HJp16YOkRtfryVc4yn8q4tYIIiSjMuClx/Z8DIVibVDfB5g4bkPOn/Fj6
 RVjdvz4PV2SNxJKrsO1Gc5GcE9BF5A6JTl+zq83TJQKJWGH9ZvW0VJhyMRqlom6tvPRE
 tNhLuDyL9qyNyauFdVUp91zf7H2rBUnur5IP3S5FA1wVCwOSeYPxHkUxLpC6FggiF7EF
 pXIhz5oOb0VLACE0Kf6pbngBSNgkYMDB0xijdeO0uCHDzzrhbwRiytRaWLhDSvTFk7bD
 gcs25fRwlKCZmUuUpF9OaRiw95O/Nhu3ZQo26TWqRM2z74Hnvg0fIfnlRJM1kDaKNiFl
 mxIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuK9fbbMz8qUGEnBmUid4pVYnCRoVgA3eO2h6KNDUcV5teMf5yKvCrBO7Ho4ZIRJU9iltJi1MqFcQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMiclZVk+UPI9c9jn+4pK6V3iZoCRONjxy/0pw2D8cqQP8FO6L
 WJMT3Ib1vSQ01uZhSQhFWjbeLs8V7U+0ec+jHdFtlQSx27A3QtYGDW4sT/LJ3NgUCQM=
X-Gm-Gg: ATEYQzymp3C5k4yaLSij/4cbewzKx0GPQLTy9PLrcm134RZvtVVcykp/PY7MXvGlJRe
 a8K6Z0u16+wtaIi9OXYNFTKdEukAB2pBXQ4sxUlnefdj9yY9cVvkuhnIueJB5KKeFJqDks8zZ9J
 pk7CVD2UZgBaTQUKGzkBRVaisTXzZPtVKPajcEH5xP3Gci8Lq7i7GhDbZH6AN1DrBVcbq1+Ed03
 jjEGyPjw82DkOtPOQYKkzRIKJkEZgmvJcc17Yn0GS41mpHkhmqMEjf50iOebFUuSaixFtaJt8LP
 NlE2AEExVYDNAPnSU2V65mI2DJsbEqSHStiLcPbz/arwdlWAO5Gu4d+gFaFhcGOat5i9s/cV5vt
 SG1ZvhECj+2VGQo6OrlA0WpGT9ypqakNFDX/L8B53/L21tyIGrTgl010v8Xnr/Qw8FtwBE65jGX
 ks5JW5NKqpx7ln+a3C6q4mLMEMB02F493779BV6JdwmWBf
X-Received: by 2002:a05:600c:4ecb:b0:487:1520:d107 with SMTP id
 5b1f17b1804b1-487160aa232mr97071565e9.31.1774515763192; 
 Thu, 26 Mar 2026 02:02:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: aaro.koskinen@iki.fi, airlied@gmail.com, andreas@kemnade.info, 
 conor+dt@kernel.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
 khilman@baylibre.com, krzk+dt@kernel.org, laurent.pinchart@ideasonboard.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, jesszhan0024@gmail.com, 
 rfoss@kernel.org, robh@kernel.org, rogerq@kernel.org, simona@ffwll.ch, 
 thierry.reding@gmail.com, tony@atomide.com, tzimmermann@suse.de, 
 andrzej.hajda@intel.com, Mithil Bavishi <bavishimithil@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20260303203017.511-1-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
Subject: Re: (subset) [PATCH v9 0/8] Initial support for Samsung Galaxy Tab
 2 series
Message-Id: <177451576215.103892.12129135091369769725.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 03 Mar 2026 15:30:09 -0500, Mithil Bavishi wrote:
> This series adds initial support for the Samsung Galaxy Tab 2
> (samsung-espresso7/10) series of devices. It adds support for 6 variants
> (P3100, P3110, P3113, P5100, P5110, P5113). Downstream categorised them
> based on 3G and WiFi, but since they use different panel, touch
> controllers, batteries, I decided to categorise them based on screen
> size as espresso7 and espresso10.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[4/8] dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d37690b5e02418a2365548300628ef3895a24ed2

-- 
Neil

