Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944F606D831
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=XNCHnlzk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9764F1123B7;
	Thu,  5 Nov 2026 12:09:55 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA471123B0
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 12:09:49 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so1527546a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 04:09:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793880588; cv=none;
 d=google.com; s=arc-20260327;
 b=XHwT066+IDMYRmrjah9fghMR/noCDJ2GqWpEfkB/jUKjFkEBE+WpNsERj63AKNP1OC
 UsXIo3EffH4tqfI7u7K+aHnT8tyxy7b7gr/sqbN5kUjmblPQUeA0qA5jpRQ41HQmCeie
 /2Qv3tUj/wRKrEgTRarx8r9V42FQMUet7DEGIo0939+2E8FLujyQO/Glbj8/PFOgR3i5
 4dtgRBGACWTEwsavNLTYBcK/xWpNqYcn6PyJT0NHeY23sUlW35ypm4txZVT0pc220evc
 I9mP4HtlN2Zupqi6Cxm7QkPx0y4ybDQjBiYJUw+Lgga6aRkcglygL9odAkUs+rfmrlwT
 zXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4fvBY9zhAaIiPkSg9Hq87qAnpt7MuwN0ORLvoKho5YI=;
 fh=xRP2BMGJ7f3U1ZEsOy3bkIpGAet1/6zxbygDLMBSay8=;
 b=gjjfIZ+N4emuLcuG/PzaL4SdR6un8BiGvb7FwmzoC9LKzttWvsaQjgcQ48RJuA1Kol
 nTLDv6Ut1aYexgpR/u26WM6eTVlC9XL97qadpqO4CIZv4qxmh/mPLzJOyZHRNceazcYE
 dR5c23vdSazwoinE7Z2yGiUlEfxeJqcTf741rvKbmj83BPhqJS8RmLGfAcMgN444Cfaz
 8iuO7zowC7fKBbGBQnALcOISrncGklWyTCCuysjU3Ku4tObE84zUeJ9aXAlpeqpi1grC
 KIqY7QI2GMJmLWVPUQJXgcm+uBTC4EB5E10DejufzGnTdoFhHdUqJfwS46qMXdrfoMy3
 BTzQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793880588; x=1794485388;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4fvBY9zhAaIiPkSg9Hq87qAnpt7MuwN0ORLvoKho5YI=;
 b=XNCHnlzkZVLx5g2DLCs4YHdssglI6U592rv0SkSfckJLbfS7Pu52YgV6eg85R7GW3s
 CtbOAaV87jHeYYvgWcrZ6KYj2fbho4CA43i59ez+nK1xG6QPonji6rbHU8Ybf3L/WVLw
 7gB229Ux1MJL/b5m6emniIWeX0JvVeZh/Lg15rikDjxHE+ewlUuQWH0xF+/d32F0DYfC
 fctUjht96Wtfa2Sgy+BNxDYiyc+nWC9zd9y1si8MRgqlbN2HzhzIOWODw7pc5qazcWsp
 clJxlP9/I8JZaPtkkIn0hOalGxim1MS5vw1T5q7uJIFtk3Rg6a8vJzVUDAlY+7zsi6KG
 f8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793880588; x=1794485388;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4fvBY9zhAaIiPkSg9Hq87qAnpt7MuwN0ORLvoKho5YI=;
 b=1lTcdH1C+zG4w/q/+2R9CaAfxn4+zNyrdJKWYgiNhuJRA4MGu0z0doMyo0mWZjkx3p
 rusOaHdn3UcNOl7ofIrZqA54LmWkpKN7k+rH5fT7QfGkZ4Rif0LH+QUi2JKx04973L8F
 61pQ/FvUAv2PrKP6LyqorfKCOUW+nP1P3u83rPZj58ulDoX6I0oXpZXD0Xkk9RyQywY6
 H3HZy9WgWtqSD8XYuQCAjZ9TFNi6FMo/9WGg233SKuTBMwDU3HrWqlrldG3Xqe2YFaqV
 T3yQnvWdBjhDjo6z29Tar4UwSyuq4xhE+CtqzEuzXdYp3TLOodb/jruvQ5/B2LM9voGY
 Tlhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJvxMMAEKghP6QsshtdM4FcyEtoy8KMpF9PU3ho9F1hpHiYRSenJEbZD77z3R5RQVttp8W+jMT+3I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+56tkqvheqWj/whNE2D7qJfYKQdSa+fUDwpsVCPvYZpwD07x1J
 5NpfbJ36j+UPzvos+1wckB7crhzesTXGek8nTXMOqUxLPBTkuJfQw6KFrB+wrAsjlIANP9+4JNh
 lEN7wNvVxa2AZwUsUdH0vRu8q/Qmsj2GHrPp+gMlFig==
X-Gm-Gg: AYBFou2zks9s5Ay7v+w8AZ4FUm+ZPOMpCPYSZebsiOTHs2tG9p1esccFHNY6ji2AP0D
 iK/5a/+iyagfraNCx4Qc+mRwawr8hlxkQubL9X0xrkthf96LxkTHofnr8KW5w34Ab403OlDbAgp
 SrTsxx/pP5sjkDe7Q6XuhoK5MhXYBJmfnD30svC2j7aE8yu7EZkQwMLmZSUN+aU7qSoBHXlqWqZ
 Fm9oIkhHmfdKSpi+triLrpbVXLi6qllSufNwNrBPL+OQV8v/ogQTRApunzsFtxpfuU7G0+fVlhy
 h2VkozpNMTYg++HBb04SIG1hW/+kUs+yvBd/+a9X19nO2LX77JxCpbCSZZNRBzgYjCUcSd8NZDW
 f4sZKOTjbuazB4xYWWa3/Czf7zcBH8WnMPrcRTjxEeJav3y5IJN0NP0B01+U=
X-Received: by 2002:a17:90a:e7cc:b0:3ab:2737:3395 with SMTP id
 98e67ed59e1d1-3ae8979d3c7mr16512224a91.42.1793880588558; Thu, 05 Nov 2026
 04:09:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-14-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-14-1bb63ef5766e@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 12:09:36 +0000
X-Gm-Features: AclHuK_MHMThyHgJMV5RxoSYYJYLTJBQMatbDWcZrO2pg9eAtUGM46fm6kw3Mdw
Message-ID: <CAPj87rNp=Qen3CpxdBWHrKqmpDq=w=3fhbuJFM2uVLrwizWQRQ@mail.gmail.com>
Subject: Re: [PATCH v6 14/15] drm/rockchip: dw_hdmi_qp: Enable YUV420 output
 format
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
> Both RK3576 and RK3588 SoCs are capable of driving the YUV420 output
> color format, and the required bus-format handling and VOP2 support are
> already in place.  Advertise it via the platform supported formats so
> the HDMI core can select it.
>
> YUV420 halves the TMDS bandwidth compared to RGB/YUV444, which enables
> high-resolution modes such as 4K@60Hz on links that cannot otherwise
> carry the full-bandwidth signal.

Reviewed-by: Daniel Stone <daniels@collabora.com>
