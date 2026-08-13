Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB25C5DF67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0225D10E081;
	Thu, 13 Aug 2026 16:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="osxCBanT";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A369610E081
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:44:18 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-46f88060e8dso398f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786639457; x=1787244257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uzP4xqIsstfeVL1p2BEayzggpWH6XvsfreBjrDZxCS8=;
 b=osxCBanT9AittVLKJAfQTdWnJQGNGQxyxQDYyhTh9JTHIdbVyAVLy40kaxCIxBURTO
 r1i7RpeNPpPgujzr3BCpcESbhkJj8iPaG0DhUakZC0Cg2YtxLN3VtE/hJwbZmBq7hpzl
 7g1DSlj1tmA1McKhSvK4CuS85p0fDnOaTzc0firMR2Vh01jVP6sgzpmPPjxq38GOE/G4
 EWV2nzClam85InJ+ZE8Bd4LX2fhIcsAEzqLeFfZjlSL1vNSE5mjlg/ciQ0ZKc+njvWUA
 8CYGwDuqIE1OBqpYA6ABj5Co4N7qEyXyVO97WDxuaWvBFRd8weIw07BbaOsmw8aOUgWu
 Rxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786639457; x=1787244257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uzP4xqIsstfeVL1p2BEayzggpWH6XvsfreBjrDZxCS8=;
 b=F8+3lrquBe+1EhWWmlRUh85TqfQU9jeYtOszYXWe/JN/9YXzIgq8zsA97udASDmmyz
 3biqdgYaDCcJLfnj0RBe0l2fZsKXBYjDepJrJqvmPmREiSU1PsheONQ4etZzk9/V8d5x
 l8a3u+1lid7GYMWdfMGEhF4sUsZK300RUFHc/+cGCR/jOwLvLRKU0hH3SGSCdMueF78W
 IvXjCl2SgVjgbQKujwffz3kcIjdme26IHvnoXOP6uN4Olw0Ig/BQ0oQ8IMiDQ4vvu95w
 faSzP0zMTk8zFKDQbIBt1ATFz7ZYUdWivEAdVqVTqGUQeTgbN0fJjvJmMLg21lMpM8RR
 QYYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoE5Y9ND/OwhvbveJYihIR+fT8/TcD9jMR6XBgNRB4wlT4817vM9vT8JXTJVGw2UtMFi4tBgKlC8bk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzHNPeEOSjLXq3bSD1TOiuXL3cOTVoXAhr0/0q5e8oUEFIfFuC
 hId7SjHkrhrOqEmK0yQryZszhdoE+jOXOWV/iVXW9DIH4oKQr0WZTt5b
X-Gm-Gg: AR+sD11ftfIbuNNSpdBkJnvJR4tDKdKiPFDkKhlp5UIpELfQOyDwEAX5oWY+2oYP7WW
 Mkunh0vd338skZIkDS/ro9b18vrjduHvyOzN+W0o1gQ11TkmBtqJ66o7qU7xr+LPVaa2OXpxZHS
 0s8Mtj0BJMxsSZACmVZpalYhDzEpQwtSkjKJ5GPH2Y2Ls6kvV8rE0JkEDVPJrxO7z/Mhmk1h7SL
 NtCoBIhkEvCmd2G4/nz/pQ8M38waPF4SxnsLiD75TgeHp9ADn2dEqQ2Kc8gyTAU+X0DPgW6cQ+P
 lpvonOiKt7z7FvviLYezskv5J63QjHdhT+thWMkkWFkquVW8aiiSqJw4leDs5vC/cZVY95oxVBj
 EEGhzk9zGIW2fRVIwEPFkHopq/MjBPlRmW5uUQ6XuYJ5U+nawWbu0lytFdM0lq/TGVzwrhfvx5N
 CJLc6VdU2OA3LmYF8uE3aNJC8QLp9y3POSk6hJ0AtntVKr4PPf9JpTLAXj36k8dUBhAChxXkpvO
 GOOlOVl6MU7D1TEK66dOiRV0LnFf+HCRy2jQY1tiUdM4FbHWO/D+w1UBknMyS6d20CDp1+VUjYj
X-Received: by 2002:a05:6000:1aca:b0:481:3db3:8eb with SMTP id
 ffacd0b85a97d-48159edffe0mr5610370f8f.1.1786639456881; 
 Thu, 13 Aug 2026 09:44:16 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B911C00586200462B420123.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:1c00:5862:46:2b42:123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1d90sm603116f8f.22.2026.08.13.09.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:44:16 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] Support 10-bit YUV422 and 8/10-bit YUV420 color
 format on DW HDMI QP
Date: Thu, 13 Aug 2026 18:43:51 +0200
Message-ID: <20260813164356.9625-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
References: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Cristian,

I tested this series on an RK3588 (Orange Pi 5 Plus) with a sink that
actually needs it: a Sony TV with a 256-byte HDMI 1.4 EDID -- max TMDS
clock 300 MHz, no HF-VSDB and no SCDC, and 4K above 30 Hz offered only
through the YCbCr 4:2:0 Video Data Block (VIC 96/97/101/102). Without
YUV420 output this display has had no 4K mode above 30 Hz on the
Rockchip HDMI path.

Base: drm-misc-next dc2f9f7fed1a ("drm/komeda: Set display/writeback
clone masks"), with the dw-dp v11 and usbdp v13 series applied, plus
three local patches: board DT changes enabling USB-C DP Alt Mode and
pinning the VP2 dclk to V0PLL (DisplayPort side only; HDMI ran on VP0
from the HDMI PHY PLL), and CLOCK_ALLOW_WRITE_DEBUGFS for unrelated
clock experiments. On top of that, the samsung-hdptx clock fixes v6
[1] as the runtime dependency noted in your cover letter, then this
series.

Results on the HDMI-A-1 connector:

- The connector now lists 3840x2160 at 60/59.94/50 and 4096x2160 at
  60/50 for the first time on this setup, and 3840x2160@60 shows a
  stable picture.

- The negotiated wire format matches expectations
  (/sys/kernel/debug/dri/0/state):

    output_format=YUV 4:2:0
    output_bpc=8
    tmds_char_rate=297000000

  and clk_summary agrees: clk_hdmiphy_pixel0 = dclk_vop0 = 297 MHz,
  just under the sink's 300 MHz ceiling.

- Cycling 60 -> 30 -> 60 -> 50 -> 60 re-synced cleanly every time,
  with no errors in the kernel log and the VOP interrupt rate at the
  expected per-frame values throughout (no underrun storms).

To be explicit about the scope, three things were not covered: 10-bit
output in either format (this sink's 300 MHz TMDS limit rules out
10-bit 4:2:0 at 4K, and my compositor cannot force an output format
to exercise 10-bit 4:2:2 -- I can retest with modetest from a console
if that would be useful), and the 4096-wide modes were only verified
in the mode list.

For the series as tested above:

Tested-by: Igor Paunovic <royalnet026@gmail.com>

[1] https://lore.kernel.org/all/20260811-hdptx-clk-fixes-v6-0-75bca0ee5753@collabora.com/

Thanks,
Igor
