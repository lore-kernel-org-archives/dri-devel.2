Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69286C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9387910F26D;
	Wed,  2 Sep 2026 15:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jb7Zk66i";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183F910F26D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:29:04 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4994d41ceb9so900125e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788362942; x=1788967742; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P9gX6/N+hUOidEKEDGQo/G6sZJ3cDNUMsczJpk9kQyc=;
 b=jb7Zk66ioNqZ/9xYyQcQxz4jyOkMg7TrgIet7cIsrUDV9yHpCpfp3N7/e0i8LTogeY
 cH0GRWv/nEG9s5MlkpJndKnkl4tni9sRiYpWMqP5T1idPayuhx5CxblaJ0O2et6Wt6+L
 wd4f5hY9Gw3TpjoEjE+IEb9ueoYgaZhHA6cBYCnE45q+P5Hx9FEySbdccRXDhhuifkUQ
 Ivw0/SSAqEAFJ9HygtJRJO6x1jyzmvoOEZ+JrTzajQWlCk5VzD8dXkaFT4WgH+vB46SM
 VnuCG+CJpeNPG/MyDKeBBKHqg2rw2Ri76+FkrRG863S9Z3noYnt90DM5FNbZVvLIqkAn
 nC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788362942; x=1788967742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P9gX6/N+hUOidEKEDGQo/G6sZJ3cDNUMsczJpk9kQyc=;
 b=UHcCLe7phplafmFOst4HRTpyIeO20D0H2TgqWuPw1Jw5hOo5ekZ+jwRHuDaG0lW6PA
 ImVc6SGMGiBEgCCnppX3+NDEtK7C15XqCGi4GmW593wN38/3rG6+6V2Q5Pyd+exxDMkY
 bQ3fUX59T3SYkHdCouh4rZnJvxTY4yys4JgLyp94Sf4E7zGjizKbN8wYQ0WoGJZLM7TM
 v9ZSQtMWfefLiAchTuaR2aoD+QcY3KHsxDPOrBSQhnVuRbKFblC+2Xb3DluV1DdoRVQm
 Zq9x6UwHI94XRS8AHEHIK0J/K3sXIvu3ZjpCnaXA4nZ6od/cJ0CNf9JGNGDKLhmSJtXl
 tNUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5mgZtaEbkv0UhLSrx5jrqtUz47Um4rHyRtRK6I8wQyER3FlbPXfKjkJXfky/8wq2MnWvQBBBEE9M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l0gZiYEWCabyMBYj48E4QePzN4FyGwDkYKSw0lq8YtcgAOnegF
 4waFD+R4d4QniJQfjYbnx0WZXeueRAsxz0U9pRjnGA/wcxJJwXfUfMHi
X-Gm-Gg: AR+sD103gW320EKdt+509LJRR/Yr4nPtMtPvJ4CJucCXPs3SdipJA7IGfEiG3Wm7Yk2
 WJN+Rvp8FkFe8bqVOYz31epV5u4jGYO61zZJDxj5BsoTRmyxmtO14/KOXz7wxXsyVGqYrvunJV4
 IsXRHkZzAOLdmTbMpH3AmGhQSgyCN/wWUWN2qKZvePGqWIXWtaERFttYr37NjC2duxO/sAdvvB3
 EKFWCkE4/fg9pSfr7NK6wexFOFm5ruPi5F4UBqIJIQqchkHMv5T7WQ+2DqNJkERl+AxllWY/6We
 dmPjyRzK16SGLzD1P1T8Bl1D1pbWNL4551rtFlwOdoxfa1yj1Ea8SRW2pZCO6f0xZB5C30JFvCm
 JscLCLAri4O845hn+TWj8vKPQyLBpWf06Fxpqn8saDxLQjc36JP6K8XzSiBNY5Oc7o57aTjsaQF
 G6yjKKad8SOo4b+5P0G+NTbgvI01inFHFTpR2HzyHjYf1VLpC+YAj/DC9uxL18FLn6zIK/p3fEw
 psZx594KpUaeou70k3fHWvK2FS4cBzlS538GitWmnIpLq2Xp2NpKHpz6SL4paWgK5BR4gqAJxVK
 tNuK
X-Received: by 2002:a05:600c:c48e:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49ce558d5cbmr47256105e9.0.1788362942067; 
 Wed, 02 Sep 2026 08:29:02 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B831700D60D5CCF7970D839.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:1700:d60d:5ccf:7970:d839])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4775005sm91395395e9.10.2026.09.02.08.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:29:01 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, mcanal@igalia.com,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>,
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>,
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>,
 kernel@collabora.com, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v11 00/74] Add HDMI 2.0 support to DW HDMI QP TX
Date: Wed,  2 Sep 2026 17:28:35 +0200
Message-ID: <20260902152838.5771-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
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

> This has been tested on the following boards:

One more, with a sink pair your boards cannot cover:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588 Orange Pi 5 Plus, dual HDMI

Setup: whole v11 on its stated base (drm-misc-next 47b823940e38),
both SoC HDMI ports driven at once: a Samsung with HF-VSDB (max
TMDS character rate 600 MHz, SCDC present) and a Sony limited to
300 MHz TMDS.

1) HDMI 2.0 path: the Samsung now offers and runs 3840x2160@60 RGB
   with a 594 MHz pixel clock (modetest-confirmed). Without the
   series the same port tops out at 4K@30. A stable picture at
   594 MHz is only possible with scrambling and the 1/40 TMDS ratio
   active; it stayed stable across boot, mode changes and hotplug.

2) Non-2.0 fallback: the Sony keeps its 297 MHz 4K@30 modes.
   No regression.

3) The result I care most about: this Sony in standby keeps EDID/5V
   up but drops the link, and on my 7.2 stack that generates a
   storm of detect/modeset cycles - measured 119-194 per hour,
   enough to make the desktop stutter. On v11, twenty minutes of
   standby produced ZERO events, and wake restored both sinks by
   itself. Whatever share of that the cached-status detect and the
   SCDC-loss handling each take - thank you.

4) Hotplug on both ports: clean detach and reattach, no storms.

5) Audio on a dead link: this morning my 7.2 stack took an SError
   panic (regmap read in dw_hdmi_qp_bridge_clear_audio_infoframe
   when a PCM was closed on a link whose SCDC never came up - full
   UART trace available if useful). On v11 I could not reproduce
   the class: six open/close cycles against the standby sink plus
   one natural prepare-failure-then-close during replug all
   survived cleanly. Caveat: different base kernels, so this is
   not a clean A/B on the series alone.

Scope: RGB output only (the YUV420 output series is separate), no
USB-C DP on this base, VC4 side not exercised.

Igor
