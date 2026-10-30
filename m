Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59766606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=WnDIQ46b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6D310E896;
	Fri, 30 Oct 2026 11:35:15 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE6A10E896
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:35:09 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e9cf928dc9so8287365ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793360109; cv=none;
 d=google.com; s=arc-20260327;
 b=ShEyfItNwoEyYWjSwLoF3FsmoLc1FkxJJSmIwCCV5T2KDouXXQ8l0oqsPdqHM6CV6h
 cKu8JE86mD4gwRUOCzUT/Ds/d3YuPGhk7ppdJgg+LufQdeMTFZ0cz1tL9bC891q8/QqX
 08Ps/dBXlU08UoHgKiePuyaX2omBY5mcBJQOPDQHjRkPwsfl5t+iDDBSdu8OKwEl9m+7
 jlLPL6HpZ3lU37JnXZ9/ukK5EHpzdx/2fgR/qk9kVURodbKv6j2u+Wi9AmE+7SltNL9K
 G1nDeN0AMopVTt2+TkOzOpiRKfIpQtsFdz8b4MdnbRajogAVrW2/JtCOr66xvtiSZsFX
 Hz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1/uyCfgrexYOU1XKSxjmyAIj5YjfxeLRY3LwALyGTk8=;
 fh=Lkc4y/GilVoYjv+4e3gP6U0SjHGwX/y4hiF5B806Qsg=;
 b=HAREJJiDEcLiZyQMXM4sDsfz2V68DTk8LVyLU7YL2KcAejQFJRZrnCHnVi+iSk4j72
 gIsbrdSvcPBsMfkQGleDEuOd4k/j7iX8b8sTc44Lb5UPhi37oSMgdf/i8MiD2pezvLbR
 Wueb7EemuEIyFo2cihXKoLdzPZens77+yJ1XO1xmVun3ZlkM2k9xmi/W1hLOmR4ovIE3
 gwguPSN+cIwJ9fR3BdbekMyQILbfMGclO07dC9YEusl7j1vRHeUYN+3b1dGlScVu/oOG
 rffxZ3KlkYtsm2IekZYgmoQCyTS852/VX6gPW2LF3wUGMztTsvCOQWVvjaUseoA8AH6x
 go6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793360109; x=1793964909;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1/uyCfgrexYOU1XKSxjmyAIj5YjfxeLRY3LwALyGTk8=;
 b=WnDIQ46bCGG9zTV4JWgS6k9Qk82taLFPQG71Ubw79xORS6h+u+cRHIPoQEu5ABjpzp
 9WnoSKG3OYht/qfvjjGQKjQfoqRUtojkiJdfmlTJ2QLorEE24OEGm7Fi4Is+yjDr1d7m
 6cuyV72eXQQNowavoeIYmTPadHQ3RZwCCDNf6GZkoD1uLMVxAQUr/pxxgvLwfWhOa7WV
 FqssMEJOUGs7PadoBB4OS5693EilpVeH45T2Ad0/XQ0X59DmBLQ2WOILjNiAjE1TO+6e
 VQw4k3+jvPR+/v74jyttKNaNY3YZvjXWczpZr9cVd+fJuHOUnrzwv/v30wLjMKVkvWeZ
 oBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793360109; x=1793964909;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1/uyCfgrexYOU1XKSxjmyAIj5YjfxeLRY3LwALyGTk8=;
 b=fLkyR8l8JgC2yHswXaa6uG2SFl/EMIxqtsae92yV7y/4OjCM913w5HHybC7JXTTVew
 0qZ0TgcwM2e4ryzf1ScZUwJEDFhhjnROBsS5GAqZTBvvDN7VArKe33E2uEjEdF0KHzCi
 ISw3FpqUPAXULjcbp+B+w9ZPf15XZrXYPLaN7v4TLJFgbxKM/HEMMQEYz03QgdDtB1Ec
 Y093DPnJ++YpnpESFuLHMBOqoBg8J3wZK/ot+Bl8fHiVO08h4XSEEiV1rDQ8mitH0/1i
 g/aabhwtPEIK9xXNPBNMmUAzCQyk6mnXGmvGsl4CDGCSHoSTJN4H3oKFRBx46nmgGmHc
 Hbng==
X-Forwarded-Encrypted: i=1;
 AKwUvBytmN4DhMF38hpmfSO7oEuIBwrlzvsdzSJiJ3HG2tEqXe/9xRa7qWfnk3iM0RXRwpCjQfFZKF33V2Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJyAfyqShA3YeLhHJBeiqUDPw7uLCN6KcF9vxBd/tPQAlOJ2ALu
 pTWTT0JXEgnFzq3WIWo38LLcOReYfki5iXQ52JapyygvcoVaJJDPgyVkT2+9vO3rawAqkp/IC6l
 ByxfBiUt8cXXMqDt/ofDPmMecUwgE4cKAhgVeQgPXPg==
X-Gm-Gg: AYBFou3LcgcvEsRIqbpE6kVsNSo11fbPfD0DTjn05+6DjYYBZELYOsPFIoPIg/O7QBx
 6z3YgvUV4Etd8IY/d5aC02e91Vtk2Cuf33UWKjZoVZKzFpD/OD+4sEXnix8LSD7qmMILDEAY59n
 NxHOWeOjg1KOmAl41WVvWy3Fbkldeb8HxWkNc6gjrTLa6RjK7MxCCEyH9jo2A6xEKuWod+aL7Zj
 350eakfcoaO5WTcHeZYpMsQQVf4gOwDObU0NNkI8nSmQ9klpPqZO5ouWgdB52isnwxwQDtaRGOM
 Y2h/HwLBIgas94MJZ3981Vej03+0jNwiACx5gLMKcK3ZZPqq5tQ8d8dYkiuLkCUXxLvYC2ZM47Q
 A2SMPsfS4xtVLJKiIIQOCIote1aupQT6pS7W+
X-Received: by 2002:a17:902:e549:b0:2e5:41d6:178c with SMTP id
 d9443c01a7336-2eb364f8d9bmr16400675ad.33.1793360109306; Fri, 30 Oct 2026
 04:35:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-5-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-5-6fab0fe43a9b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 11:34:57 +0000
X-Gm-Features: AclHuK9zIGd0T_kGXOKSuNwCM4dWmBNTN1uB9T4b5-OFaEClVCp9NkMOArmh8_E
Message-ID: <CAPj87rMh7_Efefe3D7DyOFmMiFUtBYdC8e6EXfJYzhEu3DXDyg@mail.gmail.com>
Subject: Re: [PATCH v5 05/15] drm/rockchip: vop2: Avoid division by zero when
 computing max_dclk
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
> Default bpc to 8 when it would otherwise be 0.  The resulting max_dclk
> value is a don't-care on the non-HDMI paths that trigger this, since the
> encoder loop will not select the PHY PLL as the DCLK source there.

Reviewed-by: Daniel Stone <daniels@collabora.com>
