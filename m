Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9E606D805
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=fJhXbhAh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644B11123A3;
	Thu,  5 Nov 2026 12:08:56 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EFC1123A3
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 12:08:49 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cdab6ae1ee9so809728a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 04:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793880529; cv=none;
 d=google.com; s=arc-20260327;
 b=Y7OvkDarhkL3HZ64GVSy04XrWv3fP2NWYTnRvPOOqZJU4QeJuoBcQ0uZfRsXGLOy0d
 yQfRQO9FimNnhb4ykK588kh4A0oCkPx98HPQf01rz533lVK2Clbw4IjvL5gscWPmWGjY
 y14xOLUpveGy7OOtaWW3gxoiurKARKjFMY1HpKGlTjeeUT5xomg+uHAqZYqolcc9F90/
 jKBdI5RPP0VZFb+pdjOCSGWto9MJY8Yeal62bPnsSO3g9DgkB7VERrX31kdJpLZqmwJJ
 0sjL3SWf9mIF2D6xgNHPGGZKap0yTT97s0rIqIP03mSI2y15xiXOswQPxc2MS6EUgm8X
 NDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/0iceX90IqV9oL5wqkzDxra2XjMzLEXwA9jTMie2zR4=;
 fh=UsHfQtzxF22wakR+PS0Jm+Nk62VnWAhI5ITI4v5KlZg=;
 b=qdskuq33zwMQpzSxnp4HAx75eolr5rFHZJ7klD6areRPem8UFGqeqV9ycCrScELFaw
 v/HCiRNAFBCDMGHf2wv0tqtHr4icJXgqMN8AFioNTCTzCe662v9QqXGJ4WVlo/lq3Bej
 OD2dMpdeo4FPHDCBv8vQHJa7gc1B9+AwYSlMDyMWoWpfxFJxCPZYSuQFAdehit6w4c+8
 lMRHIzDoBRUPesZgnSCPf+qgZFJFGpfKopCGFiWDk5CHLHJBYSnbbffN9hfWsWHcAjc5
 ruhHWoLwEhKiPGbr1GM9ysMGBqHPuO4wrJ82TKGwQ0b36bmam9ylgyLWRIaGyqR+9kn6
 PO5w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793880529; x=1794485329;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/0iceX90IqV9oL5wqkzDxra2XjMzLEXwA9jTMie2zR4=;
 b=fJhXbhAhe8hhArSmvDYcSComaU0/7+qNr76cQRjExrfYo6XaVdZUVF8tOExrPA9CI8
 LmBLZKBxRt6HjQmSyiLiP5vfMHCvvI8jekvf0Sv0ZTne3JVc+R3um2oxWY/9cc/UlL5/
 GVWuBwdnRChygvKgbP8THGdLGf34lXVLOkm/Y2aVHe8fkVuWlIZTbifGTe4W9mz9zlvk
 rdkWNWET7qhPFg01EPrgnKsVGfvdn9LoYsecwUEKEZUeRYNHx6iXgsoga3JW1QTtlnhy
 hJDZwDKkbPyPzaZiqSKEVmARo8WTBTOps7nJsDkzMeKfYdpMQCKM+8HULtKqkreGop+U
 Ylfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793880529; x=1794485329;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/0iceX90IqV9oL5wqkzDxra2XjMzLEXwA9jTMie2zR4=;
 b=KYISFCh19I6wvw1RloTwF+6/2I8sdfdIrBFuvMJQQI91n6ATyqzrpht7ccOP6Vi2hn
 jHlT1LMd5J8a/pmXBPXVK17inNTLPDOHn1v0enKb3M07edEDZ3gEbf2JwvNCd9G3gHHI
 +gnyq7jujTCtuKu/Eq+3mMi+UKw0rqHdsI/Qyf2PAWtdz+4xQV98YUsooV2krVcFaNVc
 kIhEbz7dt7IFMe1VjeT0SQbUSmIX9YZAeZXYNAoHB0wuiM8NTUyw6TuKaFxda62AthOo
 UeQnQctTAHAyEdNrgpFKL+2cuKQ9+jdLxS0Iclk4FsN5mkH64jxijR9WB3/lytiPiWBw
 VpKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGOab206nfxrjYYvuKnyn+YY0B+fvHen0y/7RYwaJy/mDa+cvG3k9bBQz3OTLLFVcPo3AIl6TO3gI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8sK2ACVPH2k9up8A2w9LsNoF/SqTyIoqEmjUv3YWf/UiCgsUbQ
 f2/3BPfCQ+d2CG+r8Mv6HeGPDFkEH0SA+FqD5r+3rSYl5E2+DZM+ky5jRqtqmDBT6AlF/QYxx98
 FuqdzcOkm1KK5TslUKPkl/6eXXaunUa6ytnMMOw/ffg==
X-Gm-Gg: AYBFou0xpSIq97J+P2u8xMccZlN+iIU+1emdmLDbl+gkmCpip4xF67Zz/sT4z5q2Dhn
 skHTfa9ma1lpyrCFM9jdO6jkEqldqojYYxyx4cbQNgdB7oFm9Mdc1gretdlWqL6JZVQqkEJsJSC
 tkE89kMqK8c9O50d/uEpK5nPJ9hA2v6PTbZu0g/SRMdYrcSToYeTkwpDZxDbdQzKVihQ9SKyWG+
 qLn/4+LJxHgwemwqjD5gCKM1ub2yOHwr2eyhPJpPOaPj37OLYUfQgfuZbOqGBoaDOdxfKL8GdAl
 r2jFMTkImrKMCkgofH3umGacYGd+0RmYLEdqXvsEnN7nCIj0PGAAGeTQlnvvP/WgR2EFgAQvA6D
 jGnLvvpqPROo9I/ITTRtQmEO3OjBrZMqFCPtO
X-Received: by 2002:a17:90a:ec90:b0:3b0:c11a:902d with SMTP id
 98e67ed59e1d1-3b0c11a91c6mr1036738a91.10.1793880529265; Thu, 05 Nov 2026
 04:08:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-13-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-13-1bb63ef5766e@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 12:08:38 +0000
X-Gm-Features: AclHuK9SHkBLRSAoFwhG6L3qgKeNZAN0mhWE5mO5no7yjWFPSRU-9JZ6TzN2VOg
Message-ID: <CAPj87rM=D4h-EfkTdqbumrM159M9Mb89nJt0K1AgcTrqwAqM6w@mail.gmail.com>
Subject: Re: [PATCH v6 13/15] drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422
 output format
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 01:01, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> Rockchip DW HDMI QP encoder supports YUV 4:2:2 output through
> ROCKCHIP_OUT_MODE_YUV422, but was limited to 8-bit depth via
> MEDIA_BUS_FMT_UYVY8_1X16.  Add support for its 10-bit counterpart
> MEDIA_BUS_FMT_UYVY10_1X20, which carries two 10-bit components per clock
> cycle on a 20-bit wide bus.
>
> The HDMI PHY scales its PLL output by 8/bpc to undo the deep color
> packing, such that it matches the DCLK rate expected by VOP2.  However,
> YUV 4:2:2 is never deep color packed, as it always transmits two 12-bit
> components per pixel, regardless of the color depth.  From a clock-rate
> perspective this is equivalent to three 8-bit RGB components, so
> configure the HDMI PHY with 8 bpc when YUV 4:2:2 is in use to keep its
> output clock aligned with the TMDS character rate.

Reviewed-by: Daniel Stone <daniels@collabora.com>
