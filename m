Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD57606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=pdPL+Avd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C6410E877;
	Fri, 30 Oct 2026 11:34:49 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BB310E877
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:34:44 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so3860805ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793360084; cv=none;
 d=google.com; s=arc-20260327;
 b=fc21pWFh42GT65bniJKZbiY5K4oq8jJljFx77ns+8nZTlqC/bDuztiJx15ZKdeIjXF
 wB4gEzHx8Cp6mffHa8XW4yf8r/LB9PxXGxbuFwVkwrRzLXxujpJoyzjBSyd0UmFBGVlx
 udvpuIt51/IENJ6N9oP0bb6r9wgswESxnZfpast+lS7F1noxU7NyBY+6qGHcH5B+dqLk
 CqSj82mXzMg5JzvD937ziG8/usla6qTGPBBdBwMuljNH4Mc9NQIfp4uBC78nBM1fdJ78
 8WCluJs7vrf7qG6TSIIB0rarnmn35/P6t9glJ686MJTYxcebugI9DX6io+D+d3cVJAxU
 mNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c97+eBSw0JgaFK2XxPHQ2OocTE5xGkKfdIwT0n7EkqY=;
 fh=kQe1JVm6yJ/zqhiT3e5ljfWPt9vyyxoQJc5qSOnf7UA=;
 b=Ee3Tp/EduGF+N1lrzcf0BEODtZLmghvYx4Y7ZEmz/avBdbMuuVIYhhaFeDw/PQWvfa
 frKyeArx41MmGwsxHtvDaH6Bf83pbdTR437tFqDZKZQQHE83ds0OnT4uHbolcFxdXdVt
 +94NTb4fR3TqY2FkH/D2sexTc+3h2UuYN8wzc+UH1fbbq7ECUT678LLRXJxphflGA1Ns
 FuqCWb+5FEcnVPMaeu98EXhmwYkA0gQEyDBFC5vWj8PlEdeS3ggW8/HBKddqF7k57ndt
 V58PYZAv68u3vUagDFtHHtsBH1qpkF6CfgRXFqUDYZQIIgiTC8NGgVfQ2Cyd3eZVFMJb
 +Khw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793360084; x=1793964884;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c97+eBSw0JgaFK2XxPHQ2OocTE5xGkKfdIwT0n7EkqY=;
 b=pdPL+AvdtOJsi7uxLhxulHeuVpJt4w26rw/3uDMMkZ2zxfPjkbNCCoFYdJLWEbQKni
 DzeiYC4wwZudFWpO2Xu9EWRj2opfyVuDaSF2EWT7uKOzyLir5RsORdWsYbd1i21Vs3Fc
 m5NEOwqCeYv8WDv/XyXPL59LqW5WgZPYIWmfPRonxaZwFXOv3/K2Kmseh2pm2DHd370g
 hKSIfg+Xy5f6eG/0GEm4ZtsuBLiddgTAAw703OADC6n9nVtQeD+DuViRWlrubVcpCiBZ
 ST1Oj+6lXan56sjPr1eewFPwW9cMZDUpFZptVLB/1z9B35zvjGzu48f2NY1Qky1LtAA0
 49gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793360084; x=1793964884;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c97+eBSw0JgaFK2XxPHQ2OocTE5xGkKfdIwT0n7EkqY=;
 b=Hg2C8moCmR0d295K8JWxjrQ8co4CZNllxsTER2we8NyheRCMgCFL2yjPzYiU44REn7
 4w+aeQ4kZb3dMscwlvh3Er98CnA8bhNUjAwPgWwuoEsK3Qeo/RsAQpCGjjSS3iFxKPSq
 bQcm7HcjvTTWut9HWvqDme2ryAjXDdn3t1fJv55hmOVEkdWHyQE7QURwaMgjwOluKa5L
 NWGLzxxWDIoO+V3P4vw62DVnWMV6IPR4/1KTUv7zmgnx/COv25Sajr6VXShDRT/lnZkx
 9b+4xC9VxOym2jQua3dYV66L8pdxrirMwC/gguLFZ8WI4Om5v74CoDuLkcuNrtJKQm/p
 Ahpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgE8isE2rUzEO4oi7mwpV8PkCUU5R/28dEDIQYS4mXm7ro5FYlXeT23ZegvTBHcudLtwiwYLFxgjI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKLPlVOF3AqnOrK66KDE5moOJWq5CrdMsQxA+CV4h49Zz/BCiO
 T4axk6SShJXTXoeW4dfXyNtv+znR7BXRAf1fRgbLgvh8rYHMeDkgTcEf3HPyoFQgwsrpFB6Qn/C
 gvNXfZytHSqcXInfB1xuI36LhFcIC8nAaldwMEdZuCg==
X-Gm-Gg: AYBFou0aMbL2Ld7Kiqsh/kF2j3uSjTCSMq/ILIi8FHaV5eR1zry6T1Rd1jHAATxa2/H
 j64ZrHlAzSf2yv/zpJIrS+SNlx3P3iTJ5ZpiQj2U7u4jHGugUl8SX6Y2nzvgIGtUS113GjBTeMo
 6sOEH8PJ6qyQi/YCtyOdCzgNQLe1lxbCFDwcGsJA2JpP213JOXIdmcsoYxZ+VLYq9tCN5fqsriw
 jADU/XMknUjwT2o+Y5ftXUEhiCxDunt7O4kA8+MIqpZJjbSdXv3SNeyT9l853GlXDG0jbdpIeDk
 pn2JYijmgrTbJ5ghMVfSMUtavWikv/JByqgNWrtqKxSXnbOrIMWL9tCPE7uiDqB57GaHWDYflrY
 JsQ2avI3Xs2ICvdDEoXOE0x8ngs/8tu4CGZJ/
X-Received: by 2002:a17:903:384d:b0:2e9:9bac:2e90 with SMTP id
 d9443c01a7336-2eb3650d23fmr19334835ad.65.1793360084151; Fri, 30 Oct 2026
 04:34:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-2-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-2-6fab0fe43a9b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 11:34:33 +0000
X-Gm-Features: AclHuK_tphtpQ4KgZ6QBDW1MCkhoNuUykWSbAiahdSvtWRJxD3fhHMWk1DFCw5Q
Message-ID: <CAPj87rMYHa6NmiwC3DJ30fSLukpyNJdgRa-Ri-TyZTpDu2NkrA@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] drm/rockchip: vop2: Fix resource leak on
 vop2_enable() error path
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>
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

On Tue, 13 Oct 2026 at 23:51, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> vop2_enable() returns void, so callers cannot tell whether powering up
> the VOP2 succeeded.
>
> Additionally, if rockchip_drm_dma_attach_device() fails, vop2_enable()
> returns without disabling the core clocks or dropping the runtime PM
> reference taken earlier, leaking both.
>
> Make vop2_enable() return int and unwind all resources on every failure
> path.  As disabling the core clocks is also needed in vop2_disable(),
> factor it out into a local helper used by both.

Reviewed-by: Daniel Stone <daniels@collabora.com>
