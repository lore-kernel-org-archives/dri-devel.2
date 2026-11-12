Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0453606A896
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Szw5ztA+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA7B10F439;
	Thu, 12 Nov 2026 14:33:39 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55BF710E628
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:33:33 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so54165785e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 06:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794494012; x=1795098812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZvWhfh0tjT8b9eS/+ePbZ/29reieprsJmIKfK0jNE/I=;
 b=Szw5ztA+17vmqjTjYjmDOIe1VJEwJ7xxY7CzEjzIlMnHtBAQWx1xYfNeg8Hl2EB5n8
 LHCIdkKn25a4w9k5nQV0EVaqEQbFNaYzzPTHH5/WExj4fr/5T8p4UIedXgCDGIw0goBd
 3jFUkPzoTlycMaEDVIGZzH93BEkRz/5PwnbBZSbG0xFHtv/jadA5R1MEfRB6wDeVj5am
 ISH4Zg4KN/5wCMV6NQWIFvCyYFwUHh4oiImIA+bhWegOcTVPe1Y//mfZZeDXqOXVELtZ
 08Qwtsxgu+ZAIZ8D4F2aqkNLusa6LIkEFOkE0TwYEhpKb7W25Kz1ZLALnUFTc27cBuIf
 Z3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494012; x=1795098812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZvWhfh0tjT8b9eS/+ePbZ/29reieprsJmIKfK0jNE/I=;
 b=UYLzHhUhORE9fXal9WhKwSQYSHaBBiqYHwc8hpGn/dI7fG6QhBpHsevkooBLGsvpmp
 XnT89PGGbBAGQLzBp5nKVpzVoZrgDr71+GTqpPZqN+XCKqnjUvbzy3AVzoW24aAT3f2b
 PFt55XkrxuH3e1WNyjLwLwC3oGh2Z/SO9mkAY+KraZIX8T9FZ2pHDs2bgtRrY+m4y3y5
 UHZCPcINp9xufOhfE9/QzgNgycVKNK/9EDOvqxGMQxNmu/IsFUuEZGJRQD3a/NVM6slr
 d4mcv5zVD0DVHbwulN+9pZv2f8emcYKCPhrFuQtBzr4S4xJutF+rf+F5SwoWcQs0cXZR
 dVdw==
X-Forwarded-Encrypted: i=1;
 AL+hErFYDPhJCmg4ROQstONJyAzpv85LAlbN7j5oRlqPLdzF/ZxUryStbGreMxa+7GgvL19Wu5//1LYYsdo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/HKDh5bexQV6siATzo60fJAfmqn/K0e0xaYuov3PAKWc4+6uxp
 7gEF+ggODW7k8kA2xszsTEAnTDRcxbjypZo7T5k4xHlERTTeQsGksI9e
X-Gm-Gg: AYBFou0eI1s2hyZ7bUwcUoXzhzTwZ7/ag89UzMdcuKtJtbiMMyEQf55vvpE+iw3DXi0
 XjOG9bZ/L9NO4RmeRU4aAyR7tdsvwKJknr3aDJFdD1eVS2GGo2WHcEQ34QCvUo4J1hAmXuVJae3
 GxKk60aJsEoF5fTktLpvN5ycIKLAuYgf1DGXSMugjeIQVE3NoPuo6D8gKAts/loOIQGSd+EedaY
 To38noSAV9xdKVq7d6+Z8OhpBmjw7rEgzzyrwjEvBuXUWG/wLgXMb9W7oU08IGQIxRTrhCXN2wD
 aJiIWoeKRs2AV3g/W47kcSueg12XCy9qejusYcTxJNoF9zczyKbmCRiyKW2sNNnaS2QX3XlqTCV
 JT/sF08U61cioWghUtzYfvISkEdFtQCOwbWQoFxOdrweh5D7+AEi8u33jXVt9F+RH+QaBT8ur51
 g3NE6/oznqni5iZHpVgK4uxsjvj+qk9WvC468Z9CYwF0w7JPmOSe5j9O9plzumSQ/DeLWgUzGe6
 J7x5LDWavICduwxYFmawHBQEVHiSmGbTuw7r1TlftA5/3+JaMxVu5Wt4VUaqMlH/kT6CWd8bNCA
 sYXXu5lpN+EjiFsqzNWR1kcKBFhkAyJJVPRhU3OkWgu068dpaL64sunhr8XuEOL+J8ON8+dnr3D
 gRZPnxi22em7dH3Hykufg4fM+
X-Received: by 2002:a05:6000:2008:b0:493:8847:841e with SMTP id
 ffacd0b85a97d-499c8982608mr10751462f8f.16.1794494011369; 
 Thu, 12 Nov 2026 06:33:31 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.lan
 ([2001:861:39c2:e340:7c57:d4:a443:9a65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4988f5b1ce3sm15590804f8f.14.2026.11.12.06.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 06:33:31 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/35] drm/panel: drop the orientation workaround from
 get_modes()
Date: Thu, 12 Nov 2026 15:33:30 +0100
Message-ID: <20261112143330.2576419-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026-drm-panel-funcs-v1-22-5e3070a3478f@oss.qualcomm.com>
References: <20261026-drm-panel-funcs-v1-22-5e3070a3478f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

On Mon, Oct 26, 2026, Dmitry Baryshkov wrote:
> The exceptions are sun6i_mipi_dsi, sti_dvo and the Tegra DSI, which get
> the panel only after the DRM device has been registered.
> None of the in-tree boards using them has a rotated panel.

Two are on their way for sun6i_mipi_dsi, both A33 handhelds with the
panel mounted for landscape use, rotation = <270>: the Miyoo PocketGo S30
(ILI9488, panel series at [1]) and the Miyoo A30 (ST7701, not posted yet).

I sent a fix for this gap on 1 November [2]: sun6i_dsi_bind() reads the
rotation from the panel node, a child of the DSI node, and sets the
orientation on the connector before the DRM device is registered. It
does not rely on the panel driver, so it keeps working once the
get_modes() workaround is gone, and it skips port/ports nodes, so it
does not mind whether the board also links the panel through the graph.
Tested on the S30; it still applies to drm-misc-next as of 12 November.

Could your repost of 15+ take it, or point at it for sun6i_mipi_dsi? It
reads the DT itself rather than panel->orientation from your 23/35,
because the panel is not there yet at bind time. I am happy to rebase it
on top of your series if you prefer.

[1] https://lore.kernel.org/all/20261109160706.2272332-1-romain.tisserand@gmail.com/
[2] https://lore.kernel.org/all/20261101203406.1360656-1-romain.tisserand@gmail.com/

Romain
