Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE64CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F7610EA2D;
	Mon,  5 Oct 2026 09:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="yNo1hC4f";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D8E10EA2D
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:36:38 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1556700f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791192997; x=1791797797; darn=lists.freedesktop.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BITV0xN/Wyix+y3zSS4utGAF8MX+E4pjWeLeeUY9W7s=;
 b=yNo1hC4f2BtMhw3U2wLOTp92LoU1E7uJ7zB4uneLyGMBLFCpZsBlwO/xret8jdY/67
 rh4ujtr9EX22TEk1L8wdOIssPB/2dWQQipqLIHzaTCRE5BgsmUbMuSXzQ0ya1EcleRLq
 crAzkZk/Bh0r2qG8nadL/O2trwhMb59v/u7K6K1cvl6Ze2JYyrJI1aczeGQhva5sn08G
 VUJUhFqXmrR1JHk5gDfxJ45blOumHL4wR14LrlF8R/JVKzxTihUNF+UPCN4yNgqtii0w
 xiVk09DSXu2OrjOykpsNE3M5MUQ0wOOLHjSgDxg1qGzqTfd2EmR4xGxJLlF3B9pDiuPq
 G7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791192997; x=1791797797;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BITV0xN/Wyix+y3zSS4utGAF8MX+E4pjWeLeeUY9W7s=;
 b=NYPwky8SFgHAIsfH7yptWCnqr17cTqzUNM8x8llU7u5UIJHSBmqLPsGKCD0V5B1vdJ
 7bHV3tGcYQDal49lPO7PrGn+DhEbB2Fxc4911XWJLTnhddZFzb1/Z//QKRVfPkk/WcZz
 QHZ1EwlNdMEqDZC5TjgaVfXInc3pdY8Uu4EvS7kqBjtXTL44WTul/kqMLdjLSDPOCMsC
 ihKubzZGYTdQ5T49pGU7GEJ9sJaPsPNRa07t1lpFJv0eFzSjRn/ajzixap2iue2k7GFm
 S/g4HdLe2Epi+8qpOjmzS8ZJUQ/3FPpHSb87O09WCAWwJWznmnukum8jRg4FOk/DT1ps
 CQAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXQi9syohUrT16QJ8cBHb7VxDxrujGfCaBdizas1zv4HrCr9twGHKCjlJZi1DieXcB3WHt4ZhR/yQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJEgjGD9tKCWCA1HsE+9t1bZwKrFkyFwc0cegwzJVWlMkh/wYJb
 Eez2ViYTgFjm38cQb80IY8v0nCBow4qcRezz+gU5n3lF/B2+/EhRHlOImnN/TCFXbm4=
X-Gm-Gg: AYBFou2hQeT/NsUvJLhO8bvoxuPtiVDUaK31unUofhJD2u5MH3Oz2iab8pgF0lO60rY
 KlzWRs36WriOPBl8/Prsv7RpNJsvHKRzUNwSBZVhWl3Bx4PPSZ7UlLxUFNzlD3oEg7KTZqV97Kd
 /NL+9ob5ySTbSmLBJhX4TRvU/gCCV1spS9M5cwwsOAbseHw1dwXVbFcnWKx6u+5gSeBE/ikJVZB
 fnRxsswl+M7MTOot25UHs8F0XH0XGdbRa9Z1qggxr71Wu519lB0XwxGO6ssW6sfVv0IwTWPHRc5
 ELe1tkduOtA8aOWSZj72KHQS9oO/IEtH7KB32nDVrcEbM4d0m4Qw3vzf0CFrssjN4fylalapGjl
 PdNCG3JXphUVokgAN2vo0EkeznOxlqJurpSKSKRum8tCiY6GEmAvxuo9Z0omiNF0rsQDxC6JTzu
 3a3frUjx6Z4GQBaIahUcN3AKJdv+x7AzkmfBLQSv2wAsvEEfL+dzsfEOqfFXLZp4VqfMDy
X-Received: by 2002:a05:6000:2212:b0:487:1ddc:aaff with SMTP id
 ffacd0b85a97d-48c47ffa3f3mr10798541f8f.44.1791192997141; 
 Mon, 05 Oct 2026 02:36:37 -0700 (PDT)
Received: from localhost ([41.66.99.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ad2f9sm2391478f8f.38.2026.10.05.02.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:36:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 11:36:34 +0200
Message-Id: <DLWSX9ZHDC8K.1KXUAR8VSMNND@fairphone.com>
Subject: Re: [PATCH 2/2] dt-bindings: display: panel: himax,hx83112b:
 Tighten compatible matching
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Luca Weiss" <luca@lucaweiss.eu>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261002-hx83112-compatible-contains-v1-0-d558635ab7fc@fairphone.com>
 <20261002-hx83112-compatible-contains-v1-2-d558635ab7fc@fairphone.com>
In-Reply-To: <20261002-hx83112-compatible-contains-v1-2-d558635ab7fc@fairphone.com>
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

On Fri Oct 2, 2026 at 4:49 PM CEST, Luca Weiss wrote:
> The compatible was defined too wide, we just want "djn,98-03057-6598b-i"
> and nothing else.

Fixes: 54bd1390e984 ("dt-bindings: display: panel: Add Himax HX83112B")

> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml | 3 =
+--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8311=
2b.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.ya=
ml
> index e58bb3d45331..34e97003d293 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
> @@ -18,8 +18,7 @@ allOf:
> =20
>  properties:
>    compatible:
> -    contains:
> -      const: djn,98-03057-6598b-i
> +    const: djn,98-03057-6598b-i
> =20
>    reg:
>      maxItems: 1


