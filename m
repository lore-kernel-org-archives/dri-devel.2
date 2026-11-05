Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14B606A338
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=gk1pYeKz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC15710E2C6;
	Thu,  5 Nov 2026 11:43:57 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4C110E2C6
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 11:43:51 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e987b4a710so2706785ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 03:43:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793879031; cv=none;
 d=google.com; s=arc-20260327;
 b=MflYghgwwvfikmczAutOx+HymyRKElbeodFm+MspFq9lhn1r19WAMg2EliOd1tWDR/
 ZhO1w1kD2BZXxpklgvbixTr4kMDAsS5EMXjQwYyAF5YhI3fQJGP8ELpWGtihIbipyj6n
 aU/6P1xnLHRFenBrntiJDOWJ5A2gUYY2rw43OC8s0P/RNvM6Gh13MrtPy/wDm9gD67Ng
 qNezDaeokrV6dFA7OgdAxBBbp6K324fIKg6fX+bzx3+2mup2tpfa5E3WywienFSJf+Bk
 Hov6qc6Ja5hDivBrRyXMbyb7BY3uP7JU6PK6yVVk24MbVTyFZjQTqLdlng4QVOLsLNq1
 tU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OJ9vO3o1ng0Vc2a7LO8PFMvHKiA8ZblNfQZPhAUrQbE=;
 fh=WK2TtrHtd+2a/7QPh0YhwMrhHLVvao4QJmkVFnxbJWc=;
 b=oorI5h9+uCbVg/odEROkCKKjhkGoQl5utV1sE20R1wBS2YRFkfXV/57A6tWuUSrE8a
 ynvH6siwVEDJvB6+fAy0GmFsh5o1g4mn2zh8sb0yJFzgZLFYW+SBqN90hNhjPJzc9py9
 Z96AVhz86ZX/ELzFqDgY1UQUdzpyQPUhmzumSK1FFeHyHYgmusX96V9Vou2CXvKt3e3C
 yaDXWze6pGePf7Z6viRq3PmCxzveN1WsF82avAvTpnL7zgRq3uBGbLNpK+v8pca+9rC4
 9+8DQ66uP3OEd7jE73CTCwvFFWTYG950AlYUqjXzsnP5XjvWX99VPFGti9wrtGb5gAWB
 mVog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793879031; x=1794483831;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OJ9vO3o1ng0Vc2a7LO8PFMvHKiA8ZblNfQZPhAUrQbE=;
 b=gk1pYeKzlOhOuY1MV0xaicngvBR4ZKKLuq8Na1u37zbTtofvU7XLWRKg/3uCGpFoaK
 A/+oSItcWabeNIkvYlExUAfMOo6xpdyVnNKlQHpRW+vagjiFtl7nKxqfGi5zmeVCU3bm
 NAAY6vAtDZXKEsV/fwPb675j4dNNZicoYvwEavUmW92BjcPrJoBDez4HWm7yt+dZvB5v
 yxfvaDzduFg9dKtlwgzB4cIwAVKO0yQVddvIWHpQt5y7z5hDBEYsyYcuiULTBYkCzhA+
 vuNR9PgPGSm1kt17akXdVHgpwNWSOsX5nqG1eYd30imBRJvXQ/oIGRrHj7kQgkL2EnK3
 0XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793879031; x=1794483831;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OJ9vO3o1ng0Vc2a7LO8PFMvHKiA8ZblNfQZPhAUrQbE=;
 b=oyvSvGmTb3WDKQwl7XjYUfATfH677oitUNRo3miCSYuj6Lwz3bpYcYzU2ot8IwIfLX
 nXi2Wjsk/W6Dynq99ZXWJFASFLDAdNoOebMcOcsgZaKfzSS0V0GwumVATAGOr9/RzruU
 s6TDimW1Ivh+rrs2Lv/d+Jgk1woSj44m/o+RMP4iOgN8mnaTyZMWSyrc/blj0bEXCZk4
 3KMaeNIXczhQ6ieenmjMn4JeVxNf9sg5iv5dSJhZP7vCBZ3JC7VxFd6xCPRGzgoeYsl+
 IDBlOrPUOnXz6JH9HoyypF2dCeQeLOnp5BMmBbeOMPrOejNIcNNrcHYMVS70dpbrNzB5
 4SZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBziyM6VsAO7WLPXj5EmhAIvs5baiZGUoiTWBz0iz8CdSJY7Cqnqmnql3oUpFwfQiJAMcdHj+jPiJBE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/LBWt7y2QxSyUtgxT48kelyvQcCMQ6wFyUgWnfm8MfIFfBA9s6
 vC7AVggbTnTRZ3SEbSaXL+Qd7BdfAvZlmb77nUv1DzF80fY8RFNMMboUDo1EhkR/FkA600Dqo1w
 bZ6y96LiMMe0Qsgxla6L4x7lddxtOU6lvK4owdSupHw==
X-Gm-Gg: AYBFou2GNH1kw7M14XqjLV1BwQ8+1fSO+TUtEj4RMaPzOFlN7GfMO8nsMHiDpBu1Nxn
 O7hquyr0snSSDF4loBXgSgN4h/iTjSWKIbpbmvTaN5BVd/TxCKBiEH+XIR7oeKSIToJXgXefAZU
 6SvrX/h9A/a6dl/M9TJemFZn3W+CAKIQD5GjiCNYiXWqtdxnfbq8c88S23tT+MC4wkmS1+TN/Ph
 Qst9NEhJk38GkeO5IfBpfva+dDKyBzb9/BC8Su/kMOMonrD+UF3nVfu53W4vlQExP6xkdWDqCOi
 Zrl/iTILqD5BL4fN2AsOUTqCR9p23bhxGJr0QBAxOja08Amnr5tyhFq7j/6pdspUiGNNALrDCzX
 w1CQIREn22W+oR0z+lR/Dq1PHsHPJys4qyVhM
X-Received: by 2002:a17:903:acd:b0:2dd:c100:2521 with SMTP id
 d9443c01a7336-2ed2405ebe1mr15348025ad.42.1793879031149; Thu, 05 Nov 2026
 03:43:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-3-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-3-1bb63ef5766e@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 11:43:40 +0000
X-Gm-Features: AclHuK_G5HVtKeWQBX7RTZFBduxaJbvsY8isCNKQp8OLwXCa8s_PlYhYGah1Zi8
Message-ID: <CAPj87rN4sxAmb+Lw_xGeQMsQeD_hR-GNaCHeRFivAKfp+Ww=fA@mail.gmail.com>
Subject: Re: [PATCH v6 03/15] drm/rockchip: vop2: Disable core clocks before
 dropping runtime PM reference
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
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
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
> vop2_enable() acquires the runtime PM reference before enabling the core
> clocks, and its error path releases them in the reverse order.  However,
> vop2_disable() drops the runtime PM reference first, potentially
> powering off the VOP power domain while the core clocks are still
> running.
>
> Make the teardown mirror the bring-up sequence by disabling the core
> clocks before calling pm_runtime_put_sync().

Reviewed-by: Daniel Stone <daniels@collabora.com>
