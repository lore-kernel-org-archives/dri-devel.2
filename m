Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B947606A324
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=PeZnm4Dw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F6210E8A1;
	Fri, 30 Oct 2026 11:36:37 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69D210E8A1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:36:30 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3ac7842c17dso352852a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:36:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793360190; cv=none;
 d=google.com; s=arc-20260327;
 b=QNOwUMKyStmF80nMwTsntSVt75HmQFDbrSsmo5u2cWqA/DNVBZP0PiuIYc4BRWqNO1
 lf54jf4yN4CWHEbVOrqENd3rucXl41dKJ/rvG4T1heEIMxCTkXUa82pBLmdw/6WOcyoR
 D/GcqxrGVyEfBGCHDqKKHSgoUZQ6/LFBTRONIx6NTqimzDK5nH0bP5Juz7YrxG6riQ6b
 65cyi/yBbwQhfomew3U5twx9inK9sk9kO25fQaEIiwld7t4SEySQh4rXY2JYNSQoDUpx
 dkeyGqBnNrQjmiS+OC9DR1SP0DANdBkNHPsKxJmfK2/1d7mr5Z2oIpz1zLUnoixgUDwt
 c8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LtCf5nVW5bznJzuzPUP3xJSxpr7qf7Ib525PZhWyGlc=;
 fh=doIqJ7b5fTMPRkM2TDpwhPnVPJha6gYErhMXEpOPEiw=;
 b=iNUkPmtF2KJIOpf+3uCtCIuWCf+z7Z4ktR7y8edyaUsS8EsZ5DfHMCzaGkivAFf/C4
 h0p8sOgR27UtgBwwCa7c7NfvXygUmJB7FhWwWw+AkgVw4QVPyUivTm3t3bQ/BBoE5SWK
 4g6/yLBntPFptCrXdCnQ+aIzI5PJr6/uDySIP7wuXR0v+0u1myRZ9YeJU1Wj91p+AY9k
 eoKDCILm05GQVEPOF601ftowP0HuB5owzDbGAhrAGbaF4DR6R8t0/oY6cSnmTy1ceKMS
 3FQWY0a9SLgsgiOeYlt0W6sRcRpawCFADFMN9vaC4ACFCFB6CZOCQ9k78wdYUuqm7g1d
 JOPw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793360190; x=1793964990;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LtCf5nVW5bznJzuzPUP3xJSxpr7qf7Ib525PZhWyGlc=;
 b=PeZnm4Dwbx/FNKnbQLs5iMXMq2fGfBWOSGzV76Z4lMcpCSYdqgszVlKd+6fARGyrGm
 7ustGr74mxQ5+W7cQa9ykPdTD9h2y/NcjqOXtQF5saAmPzMwVuh05aIffvJ2ADmnpYIH
 rcR2+WhGOZmJWeOUkQgnawLhTocyb3OwweRGUatQqb/oDoWq8VMGHwNCIXKFVBq8ztXF
 17CV8A/T1HX+bvk6U6PsELlYMS5hExMmjGblLUVJJlcPjbQbTCYv3vRazog6+U2nrus+
 X5NOKPDtNgW2ps3PZ84ki/blDe68vT3NsToUtutureDYrLh5BzVFCwWvUNgguqtwR6R5
 WZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793360190; x=1793964990;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LtCf5nVW5bznJzuzPUP3xJSxpr7qf7Ib525PZhWyGlc=;
 b=hwNKALHS21QKdj8nloPESKrLu24HktSgL0TRc6HweDPoyRKVk4wCrjNA92sOJMHSZ1
 Pk0hgfHDajwWYWA2iWKz5zkF4F5oESwS1OUNHyB9Ovd+O8+zlyH238MDs7+Cw+J/wLaf
 NNn2Kz309bLMTnPSYT1CS7xdkfFK67E/3iqXVvpETTzT9RJN+6nUl2YHYatKa5CYahR7
 K8X39e+9Vm2IaFgNp/BR3/KiyU3AMTYPnPE5rOhX1kSyW5FRrzNHumZEb1wKOudXoXrP
 JokyF8ATah9nIGeGopGncZpAkFGdPqECWkAu0KDWael7XacCMulV2h/s7JyaA6YZSzhR
 7cUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRIYjDAqdsHqjRLwZXVeEgF/+jkEefHaRDDvQHBKJDiIxGZLnBr1W6d3UiXGmyLOsAb9874UdLNbI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI4lkty6qdg9wJdnQNXElwUZFwY24teVYt6CEpJF7HIvzcJQhoq
 SHUZDNJJYtDP4or0pyR9WdYtTVWfwhdsoXLlwgIedvW0d9gTvvdw9Lazc1Ip6LpyZBgRYkK1RKT
 jfFGCHU64DBeashn/UvDcBr7/dayU64yHNLhAtAsFww==
X-Gm-Gg: AYBFou3XFSOXY8im5pmEFfqqE9nWokLO3GkH5L1Vr2tt/d7szRQ/Sc6jjP2XKP1mjWY
 r7v7Kh6pqQu4FpR97yRCIk6hFcd1wKeBKpG07mU9fCnsxphK7uyTeEzTOBY+e4FIR9z6K/2tQvb
 W2wFH6RD2O5dfYlL8kqHEaGqU48CA8Gzp1en/wXOmR5ymS0OVkU7e4LQIbZ/CZ1HQE7p0u12xIy
 fq48rfSCG5z6jjTALUkuuFbLcVs1cxYtdeWC6912NHFUqzFxYIqSEXqB/U6kFqrzy33hHGZLa4V
 4G6Cfwzeskbb5gh73+8+4wsENpJ5CbQVoDSZ7oVSBqVojNQjmo1AENthI9MJl2+E32gRJRRsPnR
 npbiDiIO+jooOKAVPTstr+WK3jFQe8jY2lY7exHssS4ovjtMGEr2N2+Uj0Q==
X-Received: by 2002:a17:90b:4d83:b0:3ab:d26b:c2e9 with SMTP id
 98e67ed59e1d1-3ae89763ad5mr1536469a91.33.1793360190259; Fri, 30 Oct 2026
 04:36:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-6-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-6-6fab0fe43a9b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 11:36:18 +0000
X-Gm-Features: AclHuK-U0mC8XWkCgVPn0dV4tOoEVFqDFmKaCqBI68agDhWQD9u0tSx5WY3ydLY
Message-ID: <CAPj87rNJgUPhXtBj6tw7pzeHqmbPwkmVzzc6fT5pj_XxAuss=Q@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE
 overflow on 32-bit
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
> On architectures where unsigned long is 32-bit, VOP2_MAX_DCLK_RATE * 8
> is evaluated in 32-bit arithmetic

On architectures where unsigned long is 32-bit, we will never run VOP2
code. I guess Sashiko doesn't realise it's just asked you for a
functionally-correct but completely useless commit.

Reviewed-by: Daniel Stone <daniels@collabora.com>
