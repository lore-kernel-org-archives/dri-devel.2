Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F0606A321
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=i63g4w4V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F37810E1BA;
	Fri, 30 Oct 2026 11:47:47 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA1B10E1BA
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:47:40 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so329435a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793360860; cv=none;
 d=google.com; s=arc-20260327;
 b=no29aPOhfqY99mCCQgbtwD5IwC5Bs6uG6cPQci5K0VOneXqaKMP+GQH+g04fkW5+U6
 Jd4nl5pPNJhja62poMPyC3Puky2HKFtmt2KcozhVxLXu98/KK0c5OWP0bniaXbZqaIlZ
 a2v6/xUjrEW1XwYpeOUMfzGllr/zaMIRuGp2PnC5Cg+csESk7F08T+2YojqIy6zXe1A5
 Kz7lXzU3HJCJkln99VpPfUjsq7sBT+uE6Mf7hP8LvnBzupqCDd9Na+5vUARXJj4YOmtU
 xGIs3KnA15BQB60aYD0OfYjqHnoxQUMlOZmEfztyqkkyX5YGj1TtPLylgHoLSeHvcK9x
 46fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jhQMGcD15ceeh2wLMh9Atxq0/hg3i7fdihgYRv3Ypv8=;
 fh=eCHIQd9RH493mN5D3x0h206oeSLh8YmH7YvakzN9z9Y=;
 b=ZvgswRL3oSaKPHfp7cnkK6BfbMw3B6EV3IqXZkNzdVlU9txmxZlBWbdWDWLuqhNoIe
 G3r40AjZjgRo2mt1MesTJ/u0nO/i8Xdfy8v49Mr3ou+YMH5YwPkSA5nqKmgGFx63ZhgC
 q5MV3LWG/39iwNQb4bZbeA/PTIghPd7KqkU+EJxgv26SIs1iPSK6kajW1zRiemtYgwed
 WbxwM3dyC/LLpUAc4hEVfdud+0s6ldiAFWN7oWcoZVcA0+UnKLsqIOL2EZ8J1rj3dA5G
 p/krIXOK8iUp1IAg3Zw4kPQqbTPoKkN6ezdAYx6V+FX8F//th7i2yhdZSrymsF7VedF6
 JS0g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793360860; x=1793965660;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jhQMGcD15ceeh2wLMh9Atxq0/hg3i7fdihgYRv3Ypv8=;
 b=i63g4w4VW2aOR54oTcQGlrq+QdchEg1ruUWW8I0yGa67BIbV4mWit6tp7vqXgSVimX
 0qyNsIzUDf7+Slfq2jtADpU4MYYBHQt/g4FiShKcQ+Mk48VHQscTHJxmvXSnicD/q+zj
 ZL+0bQMJlftnQ9b/ymtM2+3sPxcGWUWsb2qjPxN1J0KKWOnv86w/yOWuAqyy+tJPBVu7
 EuMg1MlTl2KbTxtl6kW8mkzYU3JTlw5m+7O/FuXFfklPqlrVg6sCy0khUoNKRsns6BFo
 qQJNmNFZxVhi6K7zp3ATUoo8gUGpvb1E0XQ+CTijZIq9lLncGX+HFFP2WRHoYP/3z964
 Aevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793360860; x=1793965660;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jhQMGcD15ceeh2wLMh9Atxq0/hg3i7fdihgYRv3Ypv8=;
 b=wo276v3reRPmxe4yectFp/qw5uk9BPFkFByAEWmzsYYrZhwCHys3yqyCupTNpbu8XL
 1/6mv+0nhgNMxsHk0I0uS4tnYtH37qtqwMB2JzmW6OfV1d+/OJ07VKHSEKVmmlwunGKl
 oWB/H1oMQ8EAwwNAkWBNCcRHKGW5jUwFO5U9qaE81eyPX67IHbAiiEz18hKw7JK7DkD9
 oUZ8+ohVpk+HPagVjisveWRJeyZdk2KmvGebF8dl70pvh1gPDbmDF56dMu8ri/XbHb35
 doUOMEhw1Nr8kvTVRFTgbC/Kb8d55qAIYwTaQOkXFJ5tL5jVYDkv8Ax5VzZcNpUkISgI
 XmEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwARBQh970kfM9yffLF413biRpP5VVSB7lZg/0rz34+efks3IfwddII8JIU1iwcSSjR+4dkd+An4Rg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLf5iCYE09EvtQeIp/J85MuTZuCrDFyjBlBaz60F981ZybYu/ws
 HVtdEwo9SumxyxehENfFF++Jugs4SS+NtE++YqYzTa1DnhOAVvRWWZ2htjZ3pNwooJGo98gcOaX
 xFpWcT8BNwgBXJ7VEklkYwIzzWU/XrQ+SbHskNUTaIA==
X-Gm-Gg: AYBFou3L2hiL6aBL/btkOJ0xFY3IHvGeq9R0YQb58N+I5retxcXyv/T+P7vXO3gn057
 TlzTOJFZSNcSvYAodYPr6NsnAyH16Ogqi4MvGW5d6WY5Izj6Y/zEULrOJPXRik239x4QbtX6icw
 7dfMtm2Y8eAwHJ+YMXW0s/llcWhfQ6NvOG779n8atF0x2hO9Hgv6i2eM9bqaKah9ZEK03W0tHdY
 kHhFtudmM2qRx2nv/hMqBtzR+fVHqE5sfLksEmPeYt9HBF34Xt37YEIPHxIzGfJYKY8ILfIIi13
 2M5LuzK5okdUb8U5CE1NBuNipUb8cTw+EMXkcXsN8fWc/V7b6lmjYN/qqDsz5TzcN69wreBb5H3
 eEbPHF+oEL5573I8IZkFuIvkSb9kM90Sv16ex
X-Received: by 2002:a17:90b:4a46:b0:3aa:f2c4:12e9 with SMTP id
 98e67ed59e1d1-3ae8953617fmr1788397a91.3.1793360860430; Fri, 30 Oct 2026
 04:47:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-10-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-10-6fab0fe43a9b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 11:47:29 +0000
X-Gm-Features: AclHuK94pfXkqJW650Ejw1KMr2XP085nv_elOXQBTTnf3Z6vJhDk_9RcSiJIx78
Message-ID: <CAPj87rMMHpeE3WnPQp-M8KvAH9yZjT7goWU8dGtw+ykzvY1TGQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] drm/rockchip: vop2: Switch to enum vop_csc_format
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
 Igor Paunovic <royalnet026@gmail.com>
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
> Improve code readability in vop2_setup_csc_mode() by using enum
> vop_csc_format for the csc_mode variable, as well as for the return type
> of the vop2_convert_csc_mode() helper, which already returns CSC_*
> enumerators.
>
> While at it, replace the nonsensical 'csc_mode = false' assignment in
> the no-conversion branch with the equivalent CSC_BT601L, which carries
> the same value (0) but is type-correct.

Reviewed-by: Daniel Stone <daniels@collabora.com>
