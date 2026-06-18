Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91FCCD98FA
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B501710EDCF;
	Thu, 18 Jun 2026 14:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KRVbn6Py";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E9010EC5E
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 14:01:58 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6957b74472dso1671847a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781791317; x=1782396117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqWrw5Zm6IcTUSbd0pVoLa2mAQQgXMRFds7fJ5WZYVo=;
 b=KRVbn6Py7lNXK74LbUEiAI3McjUiBTe/K9BCarhfkYoM9Lj2GVRR6TyfNuyjAGQCvm
 8xZBiwVPDZoPbS+959B2xmAFSvlPP3iZJSeJOH0L9rDrtmjKRluW5oBcc0ij+qM2Th7W
 jSDHSkOYtyWdVM8reNMDnSVsPBW/9v5t+qUkh/MPD98BD4oo+yIVdYeLI+oGr6lY7bup
 NLZ0f80F5bKay6+TvhwhjVF9srB+8P1wC9hpBur3QFC6cXyLMwKnoSeIFiozgslk3tKd
 ub9jHRwQG3MY2JWus5zPZIgU79UaSU2lfaPRH9nRgf4Lf9MFrU66Bon7u0WIzacBKJ0X
 mO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781791317; x=1782396117;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gqWrw5Zm6IcTUSbd0pVoLa2mAQQgXMRFds7fJ5WZYVo=;
 b=R3fjKY3oELYXYJfXi33SZht6J2VBCgwmeUtQvc8WcJDXqXpJ+G985WX/ttiRhxmXHx
 TmOebpMHtEJIlSMXHRGegMnW3DTB6JSjxIOcrX+sSmpn6nr3bS22xS9rg0I6BimgO6s7
 pHLWOGZdpk4FmpPbZdDDfly0MydvkrAam9aX7E4/a82AkszqEGse5CiHRz1Xb00T0V3W
 vMUWLzztBhFsEsfQFBR8rtSJi1MvEdXKLagaMwwneIu79Ofw4ppMU5Nj4qPEwmjx4PhM
 ijiMGQ80UHppVW4AKYcFcdsOmuJAHA9JQ4x8Rq3wx5Ks/KDgroOL7wz1LSsZkluDMXOr
 lBoQ==
X-Gm-Message-State: AOJu0YySjJw3kG+St/9F7Drxm0xLoaQEdD0oklbfMzugolcM9048yFmg
 /psT7IKtmhbJcDOPIADhuZVS8GVzlcVw1dznKiOOx5X+ld5AE7OWij/c16BvkMspWz13Ov+tG41
 e9wbLepw=
X-Gm-Gg: AfdE7ck5L6VeE4FZ/fZbzKFOL0KvJY65yoZu4O8l7+x27fYj16apTw7YJmqTv5E+cC9
 XYEm45NqTXHvtoKCEt4eqK+Q/xiie0Zr6k4HSzhxK5KRTzWUSdOp2h/ZKMnk6roj7w1bhzod9ab
 3IfjzmVN1RTxN3KClpd4Is3sTC1d+cuHbCCF0Q209bjk0V4c2u7rpWDTY6cMt3yGDebuPy9DrpT
 qSyPuwNjiQhDc9UW2mlhUakkGzoCHq0v3v5SuYb4MBRa9Hv8zV2Km+v4Tx13wDXAymStABFuY2p
 cD5RiIfQHvzwzixx9IB4Z1ABI5hmFzDh1Kv1r4Un5j+jw37FbNBjEi5oVYA7BsK75kTHX1J2Ayb
 uORJS1EFehuiz8Q+GPuL05DTQ307OYmWyTWdQTQWsjt6T8jxztD1oxGNITpgUZ+DHtc5b32JD7o
 cZyQPotqkXeSrfXrVItxilPo89cAae9I1pcw==
X-Received: by 2002:a17:907:934e:b0:beb:7979:47d9 with SMTP id
 a640c23a62f3a-c074898f593mr220079066b.8.1781791316348; 
 Thu, 18 Jun 2026 07:01:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4620b3ed0d2sm27901309f8f.22.2026.06.18.07.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 07:01:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Kael D'Alcamo <dev@kael-k.io>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Igor Reznichenko <igor@reznichenko.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260617143245.372182-1-igor@reznichenko.net>
References: <20260617143245.372182-1-igor@reznichenko.net>
Subject: Re: [PATCH v6 0/2] drm/panel: Add support for the FocusLCDs
 E35GH-I-MW800CB
Message-Id: <178179131510.245596.16459075760414662708.b4-ty@b4>
Date: Thu, 18 Jun 2026 16:01:55 +0200
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

On Wed, 17 Jun 2026 07:32:43 -0700, Igor Reznichenko wrote:
> Add support for E35GH-I-MW800CB 320x480 MIPI DSI panel by FocusLCDs.
> The panel uses Ilitek ILI9488 driver IC in DSI mode specifically.
> ILI9488 also appears in DBI/SPI panels, but those require different bus drivers.
> 
> This panel driver has been tested on STM32MP157D-DK1 in addition to TI AM62P EVK.
> The panel works in video mode on both platforms. Additional panels using
> ILI9488 DSI can be added later with their own timings.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Ilitek ILI9488 panel controller
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/532701ad6e239f1b47bebaa597e159c282c6c6ac
[2/2] drm/panel: Add Ilitek ILI9488 controller driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/99e9aca83bfb867ae780f58d076bb89dd5c2681d

-- 
Neil

