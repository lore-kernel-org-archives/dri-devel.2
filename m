Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946A606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krs3dUPw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FACC10ECC1;
	Wed, 18 Nov 2026 21:21:28 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F1910ECC1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:21:18 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so13494835e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795036877; x=1795641677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ca1nIBMqrrLHE7ETNS2F+Z7D0jHo3mjnb9yE820o6xI=;
 b=krs3dUPwS8HL75ZvFvYOZ8ibUOIzDYWHMMwfurJ3oA9IsFjVivNBAsJTmCAYOBsMDy
 GCyCZ3MYnUSDvKdlqDmz5DDN7uNxC+fNbqWQo8ZQDxqkPgGqZ6PiKfKLHEQ76/TrzPFT
 nZ8HNpeRzlaaeR2jnHnBWVE4AlmjvJa0h2qA7AhWqDi5EJsuhnXoadMUyPS3MQo4fZlC
 aPznWajdNRJBRah9hVr5LFUiqgGgs1vg1fwXBPHRYXKtLbSATKFDYAN4110mqoWAvKC8
 h6igG2U8zOWR6EhAleK5X3XKGLCeeSdqfZI+MFJnxTMHKIWjgOQC7KfRI43CsCQBun1m
 QK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795036877; x=1795641677;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ca1nIBMqrrLHE7ETNS2F+Z7D0jHo3mjnb9yE820o6xI=;
 b=L6ez5LoMYPKEiLxvIYNeV9I0goev2Hz8Mf+MwbAjPbRe3lI1Ez9LooDM2+/ca60E+b
 oeMZ6G1gvni9HRK+JHJkvpnkSdNL/9wP+NHblpLZAm9ADPcxIRmgKHOHp/aOE05dLmLr
 sbUTiJjQohspCjEHhrihWKPhLw906zHfvlpJfsIKrSOd8inUZD9VZdiYrUhTquNY+XEk
 9lHir6Q7NsoIA2eadqUSc+fzgajOGWPQaM/w88DkQw5eQG2vUFRDQVS6eZHirwUuBUkx
 oVn0gkkUFxa2Hc1VJm/dLiFSlspYnIUdlmv2RkVgsObxRdjakwUVGv0thHz3P3EKgvyh
 et4A==
X-Forwarded-Encrypted: i=1;
 AL+hErFI6+P6Pfpn4r/xl9NGWUNUyA1ABawy1m0oPmW8lblURZsdeVWktK+codSiegZV6/8A/fT2KyKcm7U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9SL8/dD5BmIHpVDf702txA97nTZVsR/2zcFU4wlwwiuJKejCRs
 cGSfkwa9i7Ox2Gqlcn145hXkAClK/aXWvPoBo4EXYqyIysEUULiZNwB/
X-Gm-Gg: AYBFou08QqWN70KhgiudAjJtw8XSYQpOjM4rd3N7hUDP9mS8KrUbB0/mxtignlAiIDY
 VsuGPj9Fj9jZSs5aQv4ExTsBINPUl/LT6gOe19oZCn935Ok0lNFRu0puR/jASixY1pJL3PrXot6
 CEzOXIsBNMDWyvhqA59k5A76lmIPiGh634MbI29cMyR39qdosYbn4Z4sSap0lPV4p54uYyMPUz+
 JWHnN33YNuquEac16QhN4PP6ejDYGh8KIgCvuFfff0xvaAJXHdsF32Y/GuzLbhlhMWlrZvs7DLR
 HEyuwRJhFTZrIQYFrpkb/gkXf/BYzG7MCV7wlahAcqek9cf/6g1INMHAlpN9C794n+mgTheL+hH
 Rj2J4evVC9lg6K7XJLm35zctEV8P0d6KO8RXGOss+XlFPKSHlocBsjDpKhSq6sCv99qlwK+Ubtz
 mfockTRsdQOmWB8sG1nUCsoKKpwIc0uHKyFJNWWTFsPfr84PG8voYLV5AXVfnz25Ms1PI40ACOj
 YFWDpDn2ott7W105muCx6CP+zt4N3cxc+7WVSmCeIfbmkcTdZhU4E6wlrgR7k3SvY/HfyeE9QJW
 bxLtdqYJgA7oJhqTvvb3VOECD693or6serIWHQtjFJmfzpfVftY32xc=
X-Received: by 2002:a05:600d:4:b0:4bb:818d:8d8f with SMTP id
 5b1f17b1804b1-4bb818d8df2mr30863675e9.23.1795036876600; 
 Wed, 18 Nov 2026 13:21:16 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e513c28sm36914945e9.0.2026.11.18.13.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:21:15 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
Date: Wed, 18 Nov 2026 22:21:14 +0100
Message-Id: <20261118212114.150992-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <avs2dagfmQkv00H0@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com> <avs2dagfmQkv00H0@houat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 06:12:50PM +0100, Maxime Ripard wrote:
> > - The channel order isn't stored, so RGB is reported for the adopted
> >   framebuffer. It doesn't change what's on screen.
>
> You mean RGB vs BGR? It's not available anywhere in a register?

Right, there's no swap bit in the LCDC. The order comes from the board
wiring, which the DT describes with blue-and-red-wiring, and the driver
already uses it to pick the format list. I'll use that in the readout
instead of always reporting RGB.

> > - tilcdc_crtc_mode_fixup() is undone to get the requested mode, but a
> >   positive sync can't be told from a mode that doesn't specify it.
>
> That's suprising as well, the polairity of signals is typically stored
> somewhere in a register.

It is, in RASTER_TIMING_2 (INVERT_HSYNC and INVERT_VSYNC), so the actual
polarity is read back fine. What's lost is the difference between a mode
that asks for DRM_MODE_FLAG_PHSYNC and one with no polarity flag at all:
both end up with the same register value, and the readout can only pick
one of them. I'll reword the commit message.

> You need to give some leeway there. It's unlikely you'll ever going to
> be an exact match for the mode being used due to clock rounding.
> [...]
> We handle that in tidss by looking for the closest rate match and see if
> it falls into the specified tolerance
> (dispc_find_closest_refresh_rate_from_clk). I always thought of it as
> something that could be turned into a helper, and it's what you should
> be using here.

Makes sense, I'll use the same approach in tilcdc, and see if it can be
turned into a common helper along the way.

> That part is
> https://lore.kernel.org/all/20261116-drm-no-more-config-reset-v2-43-0bb471f4d1e0@kernel.org/
> with hw_reset that sashiko pointed out

Ok, I'll drop it from my patch and base on top of that one.

Thanks,
Màxim
