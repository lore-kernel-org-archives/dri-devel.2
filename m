Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6908606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=Q3OneYSp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD4E10FF47;
	Thu,  5 Nov 2026 14:35:34 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BC81122B1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:35:27 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8a06e79e152so1194501b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793889327; cv=none;
 d=google.com; s=arc-20260327;
 b=TW71nSH9sH2r2TZ+dh6am9N5h4m32hlXO+BzE6pacoxiLUMFaQwLtJq33OnLSKsLM/
 kih7Q+BR546lfkRdHeQlzPhbdH3drSx72XzQgBA9VwJvuRkGbUCbvnHvnlBB+WZv5uUj
 qwlZ5d66T6J9RV7VpIA6q3kgWiGVEVFSKu2sGm/OPBQ1Nj5iq+Ho3C31Sr/71EWCZFZE
 NJWfI7iQ4NgfWvnlp9GSMxXlJsC7jkahzeFodqUOqjApy2GNabVBu/hqVuWTYXFmGbUw
 FQAvuviqD0aEppeUqpAhFOlBSHsYyHhO7yfowIxPTH/t6RkUf+LED+S9a+e3hQycFTVw
 1Ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CKNrOVtQ7Tx/zqpAFEoFPOOWJYG2yTScVv26B8q6G5c=;
 fh=/8ZNdOvz6JXoz4huA07UX2fscGO9Nfk2Uws/KRH11fg=;
 b=mEM0dhtT2Y1LB0fVq+RhDk4quswmaAYi3z681IlftPfK/lw13M3AdxwSQJaEY3MRSt
 r7oWvb48vQ4CyhBAg2EFNnp0EndR5N2cilQeuIZ5R+YclnvGk62a1yO1V+h7lMuPKom5
 Qw6rJQjXosWYeTUwUzOtFf8VZsRsxpJTeS7ZjNFGK0W/2eaWVaUwO9l/v08jcyLtQsvw
 iFIu3voU+wt61eZ+x2Bv32vJHG/dMkmMFpm1FcmiBJHGV11LCCgFZhBrGgMdvQoeDG3b
 oFM6ahJ6mQoTALz6mIiE8yJr/jnZWwV4yjiIuNNgiBA1bOb7qkdDz0ySanLmf49hlFjB
 Y1ig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793889327; x=1794494127;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CKNrOVtQ7Tx/zqpAFEoFPOOWJYG2yTScVv26B8q6G5c=;
 b=Q3OneYSp+cjz2BXjMHJo+E9kPOvwaZIEp1qH7xxnR3EOTqwTlUNaPGNFp09/Jp0op6
 EoGEATLBSZYlW8RzMCxXy3VKvSnwxu1i/DmwABCKNA+Hu6Lv/EKRqUOxbLlb4oEDT7Dv
 EhdKjyjioio+eyDB2MCnOR8CTO1vatkRLxU8Gc9bnwIQ4aHLPtuLRZHaWKxwx/9ajE+l
 DuWPEREKe8EGNAcocPYFvGd4BDxkUpuGe80b5suhqQssLRJmF4d2CGlAWLmGbLfTbxS4
 dn7p3UkxJh1PpQr+XJyLKyGwTNZAIwWkrDkoyR3hGqjb5IvEvVes5OQP3LPyo/iUARj5
 UcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793889327; x=1794494127;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CKNrOVtQ7Tx/zqpAFEoFPOOWJYG2yTScVv26B8q6G5c=;
 b=DAVhpvonH/2nEJnwt8kDIW/k0CgnccubEHANp0nItMNgiKWLKDCBD4Dj/IX0zvHm6y
 cEXIElf9Cjnza1G3sZOYxqf3T4SqDBanyBCKZPRy+fM5wUT8OOco4QzvyEoeZcHCw7/1
 LRJP7mZKbyVWq2qgV8u7RvY6MpXWUXbspYP3zNjFcvwhEi1RA27tp5W08cUQqDSpCGK2
 ETwkMxkaECSN019DKu/B2xEE8SL18XL+9m1s5NtA0O3fJ/bRf8jgLk7j9j9ZndOWdacF
 zcincNWMW+QxFfQKCLBiS+OVUzjCls8qP/8S8Vtau/exHjxDbC/LBYBE3txbgYGmCO1P
 XCGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAuLytZapzdfB9+fk+6Hr7ZUv0dK7W6gAzn5fIdmQ6TapWFIMttakjvRXnqCsTTHZY35ljnaTbJEA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/RQKrN81XYeUyBI5fSySml9SkvZG0R3iTIrpJ6G0okBuMq1S5D
 i4j5pGlu7IL+1Jc1Nff/rJy0nmRvLo0PvsRR6dkqvXhS8fL3Xua5c8r5k3xfzQbuOqv8DsxNRs/
 itfot1mWcmhM/uU1PjLwf+ZP9liEM5g0L/zVpmcAPJg==
X-Gm-Gg: AYBFou3/ETlT3AJfPSSYy4Nw4HWBCU0nELbAuFP/PZUYCld2unt2arydwxq87T2/4HY
 PWk5Ju7+D2rUf4CbE+ijaCnfEQoWWgr+X41IFjXFOy8JizdHPGqiNN2VRx0zStMHiPXGYBPWClr
 MDk5mnbpewrEr/CGolpLcr3g9y2h4MkW9GI95LHitaO3CjJTxY4qW+rO8RUF5pQ/OyPOZs0orlj
 IZDZaZa8427NZV6hxMGhOAGO486fh8heLbDKIRcnhPNrARfyDigYo6MXpmcGDVvVM7Ug0CKlxT4
 2Lo9oW2HWuku1X2MPP7mreHTnG0l9dT5niR+AZUtiJN+tAt8g8OS9Wo2UTcftLJuVD8gsK2DR1Z
 i8ug18sCo/DPRaXoErMFa+ORRxW8FQW4TCsjaXTBHihCJvIaq5nZghi3wmQ==
X-Received: by 2002:a05:6a00:21cb:b0:8a0:6860:cb16 with SMTP id
 d2e1a72fcca58-8a9ba806f4bmr13913523b3a.8.1793889327094; Thu, 05 Nov 2026
 06:35:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-9-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-9-1bb63ef5766e@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 14:35:16 +0000
X-Gm-Features: AclHuK_n1-N1ApR-k6d2Ij0iknOGmj4ALZ4zRGpX5gsfuT0639_6holwqyNMTac
Message-ID: <CAPj87rOutcy5VhtmqYg=YD4OB6dbRzxyaf1rG2kcASp477X6og@mail.gmail.com>
Subject: Re: [PATCH v6 09/15] drm/rockchip: vop2: Use TMDS character rate to
 select DCLK source
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
 linux-kernel@vger.kernel.org
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
> The HDMI PHY PLL can only be used as DCLK source while the HDMI link
> operates in TMDS mode, i.e. for TMDS character rates up to 600 MHz.
> Beyond that, HDMI 2.1 FRL is required, in which case the PLL would run
> at the link rate and VOP2 must keep using the system CRU.
>
> Currently, this is decided by reconstructing the TMDS character rate
> from the DCLK rate and the color depth, i.e. DCLK * bpc / 8, which does
> not hold for all possible output configurations:
>
> - YUV422 always transmits two 12-bit components per clock cycle,
>   regardless of the color depth, which from a clock-rate perspective is
>   equivalent to three 8-bit RGB components.  For example, 4K@60Hz 10-bit
>   YUV422 requires the same bandwidth as 4K@60Hz 8-bit RGB, typically 594
>   MHz.  However, VOP2 wrongly assumes it needs 742.5 MHz (594 * 10 / 8)
>   and ends up switching the DCLK source.  As a consequence, modes
>   requiring uncommon pixel clocks, such as those corresponding to
>   fractional refresh rates, will fail.  An example is 3840x2160@59.94Hz,
>   which would likely rely on a 593.407 MHz clock rate, unsupported by
>   the system CRU.
>
> - When VOP2 processes multiple pixels per clock cycle, DCLK is only a
>   fraction of the pixel clock, e.g. RK3576 halves it for pixel clocks
>   above 600 MHz.  Hence, an FRL mode such as 4K@120Hz 8-bit RGB, with a
>   pixel clock of 1188 MHz, ends up with a 594 MHz DCLK, which slips
>   under the limit and wrongly selects the HDMI PHY PLL as DCLK source.
>
> In preparation for supporting the use cases above, rework the DCLK
> source switch logic to check the TMDS character rate computed by the
> HDMI connector state helpers, which already accounts for the output
> color format and depth.  Keep using the system CRU when the rate is not
> available.
>
> While at it, drop the VOP2_MAX_DCLK_RATE define in favor of the generic
> HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ, since the 600 MHz limit applies to the
> TMDS character rate rather than to DCLK.

Reviewed-by: Daniel Stone <daniels@collabora.com>
