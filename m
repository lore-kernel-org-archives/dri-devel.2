Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052F606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=GdLZOJ5d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA2E10E10A;
	Fri, 30 Oct 2026 11:42:25 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3074C10E10A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:42:20 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc751eddf25so343784a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793360540; cv=none;
 d=google.com; s=arc-20260327;
 b=I2MphG+wDVmo6A5Vu6TS62Ct45FB03hX9A/wHILGKAD/CiCiuLT6w0AoDCpTY+EjWZ
 NaZpsHdJCsiYln0qtUH5prtGkaeYnF1Yy9FcWmNDgm7vkiuaFtHf7/uM3Ct3DHuWH3LS
 lJP7t6PTV5dlHiE0hLJKNrdvk6aPiIuYhfEMrNAiiuXIRH0QNKSC+zMgExaXJWPZ31ZN
 F2OdtuKYVtUAY0Zg8Ihh+MwULw38xs4Nv8Hq1GrzbyoA0vRH27Jr33osBTMkkDVEzRzl
 3uzivRmS2jayW3I/zracN9sCI1hiYqoQN7Mcx6Px4m3NE8ukt1bi1zpokn6JdqJCoC9g
 /Gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4lcETnvcA1FO4VShSmFGhX4tA8WQyd2jA8DOJ8G3k5s=;
 fh=IqpjRqZRM1YwZ3Z+yZ3+kCvJHf/k6aS8Haxl4TU5OvY=;
 b=aGoMJ9x421uveOoV45fxhs8P8qZKG2YPNr+aj3PuvElQ7cfzEFm5+iLn7qk50kkx7h
 +B/72ieQK01ifAgpGXUWMussUW3dYwg6q+UWvoyFzjjRAH/M9arimeuh1b/AkBdVtmEW
 omyjTUHr2nTQD06PwsKF0axD0rfBTwIs6stI7S0YJljqFS394jVbOfx9UFXLMlFJq5dX
 yxukE8HYf2Ody8FX3ASmtzc8D0ETHJkoh1c3ohG8Vb4qwtzHgqeLxZqXQ7LAR/TGvnav
 OYCsa+Qw0VwjBBk8eb1XVqwOPugH5JKXrMmo20Taesr8CHJtuFRY3Wd4xfwdEBVvUksA
 n3xg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793360540; x=1793965340;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4lcETnvcA1FO4VShSmFGhX4tA8WQyd2jA8DOJ8G3k5s=;
 b=GdLZOJ5dD+sqan/zOVH306KJ4mXnKKF32FrrucfT2b3GUjEX7P0ZwHN8I181Fx6OuH
 26LpPAiONffQDRdLVkkTzKbyTjLvKyY+5hF9Z8tffz1wUBDqQp+2D+5lMtuQk0KEDST9
 KzrRq5Gqti98PN3fzbkxcnZsKEO59VZhqbvVP4qK1tbxitWLM03GkbX6ZHhqw8ow8qtO
 xOb8eQjvguuONzklIr8GMijmnbFDD3jbgzBuvHoPNbd3Zqg8NJu1Cu/8GIEt7PF3kofE
 7IXx56Ab77yvz01qepqr/yQbsJNEJttN1HoPXKXYFu5HSxMj1wLvIV8gBNSicskyzG8s
 twzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793360540; x=1793965340;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4lcETnvcA1FO4VShSmFGhX4tA8WQyd2jA8DOJ8G3k5s=;
 b=DaBkZ9dMe/CKID97VbvwQ2sh5duwlE6Xu6V5O+bAHAjOmFYJ+d3OzRbWjUcm/mYK5b
 frUuIZtDOOD9daE2lOivezhFeJvcoHMKLlrvXlzmmZ9oZDhTq1T+KdYrhKkQl3OIRzsi
 5YioeB9Q9e4qCo2bwV/isz8ptZlcWKlXcBrg2gW0mhcoyzCZPySaAE75aWU2cIReFLND
 qutQb9B4gFl3+TZvzGtuJlr+slPs6BUHL36QlvkwwW7t/fvSR89s/2yxq2YrOIQX0BXT
 JCbTWjfDYsXmeKcxdO8VJ8XAXkV24G/h/Ll5f2SW6wdOaVIf7/48FeuulpgRp7lPbY3n
 9MLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8FV7/VNqCWFsN1b9FE1oaP2us22axecBBlwoUjsx698lSbDtAsQNwiLoYCMK6LltWBCcl2KlHn+c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK+64fw4j9nSSUKYG8UqvAuiTdyG7b+SbwilTj2E9cnNS2icctF
 0k87O5RezFWLnDox/uljhLLPL8duZ5gMy6el9fjmaplLAk0y+7hJkuFlC4FQ/7wwQH/q+97ip5C
 Ns5qOr4RvtIJy8uNdsYncY7hr4JCw/sC80VoBGHZWTA==
X-Gm-Gg: AYBFou1BKeEzX3tdXaX+ZrSqIgeVQXcx5hoiQk8sqw9hT3rtlBi6OD2aSTcAbO8+42n
 zro5iugQDPq5ACeUaD/7uP3Iv2oO9TOlb9ll94IptV456LHGeB8/hUgCKcD/EEp91yfERGltNSC
 TbOlsGzRTWsnMrGNDS3X/RWFk0wZri5p6mwkDDC4DdXVkpedE21wXYTpyGZZuB+Iu30ZWDFPFv6
 t0e2nWGR2kOiueopMTiRryKNjSYGMrQ/t8bwjx9ERSUQXtinvIhzb0GWrZJSjT/3hpyge1IN60N
 eMujXNcxgqTH0NM2ArJTyv8zo7fSp3sw8csMZ3YS4td/2uwqGeHrLzklqgxo7zciNcRcjRN4GKZ
 A+Oi/oB6i7eGcsOA6Tm2EyvYEJq+rb+32vp1M
X-Received: by 2002:a17:90b:570c:b0:3ac:8897:7ba9 with SMTP id
 98e67ed59e1d1-3ae8985d52dmr1762888a91.56.1793360539713; Fri, 30 Oct 2026
 04:42:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-8-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-8-6fab0fe43a9b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 11:42:08 +0000
X-Gm-Features: AclHuK-tK26BAq3qSwy7dk58hnLMShmnME05ES1MHznr_rkGJBFi7nJKvVCEwy4
Message-ID: <CAPj87rPsh_cVQWtGEisDrXWiT+Zj6D6n5wXpmbuoFvMKtOi7TA@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] drm/rockchip: vop2: Avoid DCLK source switch for
 10-bit YUV422 output
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 13 Oct 2026 at 23:51, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>         if (vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) {
> -               unsigned int bpc = vcstate->output_bpc ?: 8;
> +               /*
> +                * YUV422 always transmits two 12-bit components per clock
> +                * cycle, regardless of the color depth, which from a rate
> +                * perspective is equivalent to three 8-bit RGB components.
> +                * Force 8 bpc here so the bandwidth check reflects the actual
> +                * TMDS rate and avoids an unnecessary DCLK source switch.
> +                */
> +               unsigned int bpc = vcstate->output_mode == ROCKCHIP_OUT_MODE_YUV422 ?
> +                                       8 : (vcstate->output_bpc ?: 8);

The nested ternary is pretty violent; please write it out explicitly.
Either way, the equivalent clock adjustment for YUV420 is handled in
the setup_intf_mux() handler, so would it be better for YUV422 to also
live there, rather than mashed in with bpc here?

Cheers,
Daniel
