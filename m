Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BE606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hDH9aieN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B00310EC81;
	Mon, 26 Oct 2026 08:37:35 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A3010E255
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 15:24:32 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1394001f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792941870; x=1793546670; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gr7m8Jgx5qFfXx97jCHm/dv2wdINd/6dtVxf1769JNg=;
 b=hDH9aieN2+Q9x9wDy+jCqMOQWYz2rBXsCl/kQALOUSt8fgsCgCekJ0L5p4tWoYVCQP
 IgMSu6Tt+vNUFLFOrn7dRI8In9MaoXCNku/GfMZXAIpT3dFq36X03vERIfp0idmYADTN
 vKxfWNiGs4bl3OY8njQ8+E+9PdpnAvcOykjk5Hi+arjfo2UFL3nuFlIHLzBWdyuZxCra
 z5KLfhAi3K8RIK6ptkdb17arteO6BrnJpYdE5QlCl3eluU9HxBfn2L9zNBNyRQiQR9gG
 QHXRsjygreqMAttb8PykOGmi5tJJ71kn/71tSprkxXW88JV9VOiD+E+bXZsdBVIa/I1U
 lsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792941870; x=1793546670;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gr7m8Jgx5qFfXx97jCHm/dv2wdINd/6dtVxf1769JNg=;
 b=vQZmus0xLXVBwQxxPhnncsfTj+JHA/aI77AfVDjGj0zhlvp97ptpUAsEFoyYjIbXJ1
 eNNy2aAiOBvcj+NJEvPTYMBmYCVIDWv09Pxr+5Zgea3eKWYk76zF/UHwVTVcEPeAYdyK
 T5S/o8LfvFJ22s5NHkMMCHDTKpv1uUbEHCPpiqWTVFJhI1sklGnC30Q2A5Va1JIB2Q1o
 ju2chedat3DFnje8mDAK63xPHetuTGCLtApgD/TJwu29Aw4XLWc5+5JXrkq7qBrXbpy7
 1QWbR1lNIrHKEEhunQl2o/HGDolKPxEg3T7jxDCdvVtmcChIxwuOdnuHN//n5L4kaNIu
 nwaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9iwpIjaG+mwuZirc1blKFejgV57ngA6RCFF9IsajWcLzkkpYW0ihVYQA2ntIbe7FQutjl5LIxZ8k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKBfo2tpfTtB0jJJwQGw4O6plk/UbJvQA4DTrkOZwr3zpWLWMTh
 Gbmmi4Uu1sdlN4BhDwqDQ84wb/KwJ9rxW5Gv1BgAryVvJO6yEfa5eEPR
X-Gm-Gg: AYBFou1PxmciuPAAsUhN5CZJ8QpAlKbk68R78L+cllCsUxXyOc2MbtrLZktQVeqLeCE
 NLV0mAIlxsw7zZlJ+e1J7PUTz1ybiMDrbhUFlVCzC8bFBSkj6o/XZqBDHUOgeMRw4qOFU5VxC9h
 mggLYYXosWfpnaO33dZcvGOVe84yxt5s4VEaFr9BKHfUFbzBm9LJG0OVvPT4qXLXZFWpsypcU4I
 CBTHol59FMox1iSac7uHDz5HMIBO0fdaRB3CNZ27lAKOPHlxUCzBvkjWvXhIPqHtEbrWICCcB2y
 q6KvbM2Tsrky5gC6BOC0uhsbGd+9OEym96kzm9FSCrAk5o/VUhTJ+kzCLeN5WystYFkKi2IWuu3
 4WOyRcwOq8o8AZko+szKSsUuha2LUeQna63VOc+PoAbevpn3sXAQW84hZAULHSrfxqt/AyuNYs/
 6hNyr6TwC1y6eTi4U126ArdvGIPos6a6r2zWu9V3akv6ANUj1h/XHaPa5RUI28OYs/tg+GAGlvK
 sZJLnqlJ2xbsO9+v/3SnT0wBWl6yrduao0Kq1D8oL99NaNwFR5peZ+f/6NykgmthXQhSIYNuseJ
 SHJtV9G9bP8PcAzu2KVxtn+ZsY7cztstSjHt6PyaYnI=
X-Received: by 2002:a05:600c:c0c9:b0:4a5:87b3:ddc1 with SMTP id
 5b1f17b1804b1-4a587b3e000mr20792825e9.13.1792941870382; 
 Sun, 25 Oct 2026 08:24:30 -0700 (PDT)
Received: from [127.0.1.1] ([2001:861:39c2:e340:4c3:3a00:d533:9d50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ae28sm132982575e9.2.2026.10.25.08.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 08:24:30 -0700 (PDT)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Liu Ying <victor.liu@nxp.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: use the lane rate for lbcc when
 lanes run faster
Date: Sun, 25 Oct 2026 16:24:29 +0100
Message-ID: <179294186960.4141843.10824416552753869438@gmail.com>
In-Reply-To: <sashiko-outbox-184251@kernel.org>
References: <20261025142639.3454322-1-romain.tisserand@gmail.com>
 <sashiko-outbox-184251@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 14:38:50 +0000, sashiko-bot@kernel.org wrote:
> For a 4-lane non-burst panel using MIPI_DSI_FMT_RGB666_PACKED (bpp = 18),
> (bpp / lanes) truncates from 4.5 to 4, giving a lane rate of 5 * mpclk Mbps.
> That is only 11.1% (1/9) above the 4.5 * mode->clock pixel bandwidth, rather
> than 25%.
[...]
> If the slack is only meant to ignore lane_mbps being rounded up to the next
> MHz, should the check compare dsi->lane_mbps against
> DIV_ROUND_UP_ULL(pixel_kbps, MSEC_PER_SEC) instead of adding pixel_kbps / 8?

Right, the 1/8 slack misses that case. v2 will use the lane rate when
lane_mbps is above the pixel bandwidth rounded up to the next MHz, which
keeps i.MX93, Meson and STM in non-burst mode on the pixel clock formula.

> Should pixel_kbps and the pixel-clock lbcc calculation divide by
> dw_mipi_dsi_get_lanes(dsi) instead of dsi->lanes to handle dual-DSI panels?

With dsi->lanes the patch doesn't change the timing of the dual-DSI Gru
Scarlet panel: its lane rate stays below the per-link pixel bandwidth, so
it keeps the current computation. Switching to the total lane count would
change that timing, and I can't test it, so I'll keep dsi->lanes in this
patch and leave the dual-DSI accounting to a separate one.

I'll send v2 in about a week.

Romain
