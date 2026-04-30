Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D5DCD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA4E10F444;
	Thu, 30 Apr 2026 20:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="djKZyoBu";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B32310F444
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 20:03:16 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488b0046078so11574415e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777579395; x=1778184195; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hW4vHMMUnbyMXFRxshaPjNall3Xr6KHgzmKn/VB3uNA=;
 b=djKZyoBuLM30PRAqYNgIS6OeImUCYa1qjOlD1Vd+q8aUhPvIymFj5YhPDGDPJk5w1c
 X/WmuoAP2D4OwTHs2tag3SEN5R1INwtDl18gY1TDCj1cioY9h9psfZyagZrIypiPPnGA
 8pRteZk4BqD8AF4crwvZVs8LcVyLvgonQLKbHTS221xwWZKWHhhThZ3mLFtD0ih2Ze9E
 zFryGLXFTayjIWhGYl/TAZntQWsAkH+DEK1algE3GqTC86ZvOi/ngrxlYjrQtg8pItvp
 M5S4uj98uvNY+jkqo5ar6wLa+xmH6GAXpoYzNSaE7xqyY87ROQXJMvRbqNjKtp2hT7XG
 xcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777579395; x=1778184195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hW4vHMMUnbyMXFRxshaPjNall3Xr6KHgzmKn/VB3uNA=;
 b=Q51+R2bkidbxP+2rl1608ig/tdMCGKtCPvOfJLB1nB6II9aEg/uHAmRhNu5supdfyo
 evN7jL2WqWgb18V0yuwvW0FlASOfeaQCQskfiDUY848zB8Z/M1DaEVBaGvvUOxzIur1L
 zTix586l8ewLGAAR1FHppGtQIN0pnzG6Eza9WndNNQSbgXIOM8yb3dvvw19AeTvvkl3w
 zPscPG5pU8Mgw0FMY9kG3fbOWmLBemCChPbHhChE5lDd3carNNztQ4FGS6aHCNxpfQSL
 GdFOvJvHkKGbW9LQ78BLaMbMBdwptAPqeCfY6jurMr0HWiSMV2ArYr0n1maY7vBoN6E+
 BROg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hzcc+61yzjsBUIhDFs9SNV57z/3mrYdi0k4NzjpThBa736yOxdseJ/NAg95QfhK9DmiV45HIibyA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznKQnWnYdVv8D1TVCB4VsZZ6KkGl/wRUTAJMdHLhsYKdxlkWG4
 f4rvaPyVk+/O4/5fvQECiYPm1Zf6t0W2Jdqq3CflCuIKmRyOUBU9phKBLiLsYA6UXiw=
X-Gm-Gg: AeBDietniPhKE7fbBu9ajUGCtCe5s/noDjT2Q6BxiKcpXORYMTQThOfOBlr9AE1rhpI
 AEWxzCS+ujfuEv0aOVNJq4SCsmHaaHP+qSp4EUMHMOd36tI+kd1qRU6J4OeWLIFZ1J2BIeszS+Q
 51sO/MEyFMZhasWxu+LTFdBY9gmpuVUFOPTEo81Ngwpq5QOQ5PO2Cwec0HcT8tTrJPM25qNw840
 moVlSkw4t86Y3NbNf+0vJkpFjwTxhAW7kOUAmEn/ayH7SCqdt+iF6hokw2UArO3uXeUW39Ph2aB
 E5hb83qH3xnRbKOB9HwU367jOtXO3YjbH1O2jqvBUWGN4how1CqNb9vCjtzgOBQIDolPIat+jWm
 DTuEw9H8YiHh6BjaeD3RzNq2jx7jOjOFT/emzf/Hyb8amhG4jckbfsxhOw/ejz8fkwbhQAVejgb
 4so8Qz33boU/BxgjxrbqJQZuDOGGOwJJkkmB/eiPaubuwnU2Id0Jk3iF3uf/cFeSrvFUWVzYCME
 nTe7K0=
X-Received: by 2002:a05:600c:c118:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-48a8eb6b027mr1935865e9.7.1777579394535; 
 Thu, 30 Apr 2026 13:03:14 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a824f9f0dsm82432745e9.15.2026.04.30.13.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:03:13 -0700 (PDT)
Date: Thu, 30 Apr 2026 22:03:11 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in dsi probe
Message-ID: <afO1fxrg2oh-aeSV@osama>
References: <20260423200604.324615-1-osama.abdelkader@gmail.com>
 <DI6FS20AP8M2.3PBKGP25K4XQX@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI6FS20AP8M2.3PBKGP25K4XQX@bootlin.com>
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

Hello Luca,

On Thu, Apr 30, 2026 at 01:01:16PM +0200, Luca Ceresoli wrote:
> Hello Osama,
> 
> On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> > Use devm_drm_bridge_add() so the bridge is released if probe fails after
> > registration, and drop drm_bridge_remove() in chipone_dsi_probe.
> 
> Wait, this patch must drop drm_bridge_remove() in chipone_dsi_remove() too!
> Otherwise it'd be introducing an excess put, and consequent use-after-free.
> 
> I have to withdraw my R-by.
> 
> You can amend in v4.
> 

Good catch, added now in v4.

Thanks,
Osama

> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
