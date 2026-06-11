Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57247CD8CB2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD15C10ECB2;
	Thu, 11 Jun 2026 05:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r9R/DgzA";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6DB10ECB7
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:28:20 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-36bd175fdbaso4496586a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781155700; x=1781760500; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2M4DgNNlKQeB9wAbpVxMXW2+kw1ExLVQE/x550Vs++I=;
 b=r9R/DgzAKESDHFAuwAeg6weG2z/s5RYrQHxJfKTIZozCEnaZ1gh2GsXTJHQ9EXX35J
 AZBdYAfDV5Q7r9SDpUmxpepPfTKQKBiJmC56Gq2IfOsK+4gvKRZY1//MZn9TpKysxwFU
 03vaKHx4Q+PKzVJshct+ULiPGnsZs5enGUkrSUV/rDw59ie4p9FentU4hkq99ygLzk5x
 7cXxD+cLnOHgJNXHTLZftYz8mm2Gu6VRrA7SYVTe06zH5Kmek86dpSuGptJMAOrCez5a
 TcRV0PwvWb98UD2Sc6je8Ci0M5h3ZCvY+c3yQ3WhnGyvYnniMkPwHCApTyLS6ykJvtZX
 yLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155700; x=1781760500;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2M4DgNNlKQeB9wAbpVxMXW2+kw1ExLVQE/x550Vs++I=;
 b=j0DjLDqoiyGwg1RP9Je17/kB1w2RkH/ian94HU2qiw6IY16jWXiJFiEpmAfS/lPcf+
 zcENJq4Ty737QnFYcSFl4PxCWzCDDt8qOrEzQ15IIQOqnJSc81DnBU3qy6ZV4IdRGgvC
 DHz2Sf1Uw34nt6xGXJ+sCf9AxhooR1Od7Z4rv6Aegsa4dwWvRcoDLQn2Jv1rYyTMmJ6M
 8GY3UOZ5jBBf/4EtErN4YBnOe76M32zLiJ1DstPkPKGaQmp+f0TjpzUiXy/hQlwF6Xed
 4q59ccxIIARHHyQ924UW59mIyFeZKGaHGtQoJCGdrHMPDJaQoJuyJ2Tw5vZzhauzEFJT
 w3rA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ABAqtaHtgzmJb8uD6G6hnI0//EY4Dh31mQsXVxOw7aLiIjma51X5C6QhVot78ethE9wD6RU6iz00=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUdOMpnIFekOgzL7/97AO5nsH/CI41c9gy1Kc+MgrQkuKRov5k
 kfBovF7ow4xNUCArOvn0jQGcUxkNwH3oisUR/8kkQRkHuQUZ+N1C/PU6
X-Gm-Gg: Acq92OH0c3qwGArRsb/wwKq3d41J60BxAV1BKt3sqOklRvUm1uoDZ8dXe9ktIMf6fgS
 T/JeyCQza1Gc+a0uMEkDk6mtu1z9vSduPGpfgloOxyDT/ZMSu4oUoWct0D04K9e9pwEXQBQsSpV
 E7Bszx7ZMlbgoG+SPEB4YQQ88hAg6TwQSkJ+9M+9SIPQG4YECo3ljsO/p95fwwRD+GEWdDPGO9I
 njZgjbaEz4hd3RyotCanExDi4ara/t2P+9LXySYi2dW26G+s4D/MDlTTY32ufeVGMvjnIbEvXpy
 RveD/27wF6zZ0p9/ZfNLyHvy9zChlOS+pN9tKraLJNG31xQd7US9Z5Mv6H/2SlL1hIRdiNoQFzT
 iRNY9X8pwH08CmK6CffwXV2Kxv8tMsBE5TcWT/cO3KQZVMPRpaj3yDfhsk3URf9cFD86oyW0Ren
 MZU4wZaJjNDBKYvCCAy0gwCEt9YwXkKfaXKlqusSgr7PHA7A==
X-Received: by 2002:a17:90b:2d92:b0:36d:8f51:fe29 with SMTP id
 98e67ed59e1d1-377a5ce84camr1632782a91.17.1781155699906; 
 Wed, 10 Jun 2026 22:28:19 -0700 (PDT)
Received: from [10.188.227.203] ([2408:844f:2361:d7cd:deb7:4e0e:26d0:4076])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-377522a1a9esm1144589a91.4.2026.06.10.22.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:28:19 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] drm/panel: himax-hx83121a: add backlight regulator
 support
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260608162622.403713-3-zhengxingda@iscas.ac.cn>
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
 <20260608162622.403713-3-zhengxingda@iscas.ac.cn>
Date: Thu, 11 Jun 2026 13:26:47 +0800
Message-Id: <178115560757.199930.5802398831559617564.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Tue, 09 Jun 2026 00:26:22 +0800, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> index 1a7e0125bced..e31e2fba0a78 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> @@ -195,7 +197,27 @@ static int himax_bl_update_status(struct backlight_device *bl)
> [ ... skip 18 lines ... ]
> +		ret = regulator_enable(ctx->bl_supply);
> +	if (ret)
> +		return ret;
> +
> +	ctx->backlight_enabled = true;
> +

If you use a pin, (it is indeed a hwen pin as we know) you can
simplify it like this,

bool bl_enable_now = !!brightness;

if (ctx->bl_enable != bl_enable_now) {
	gpiod_set_value(ctx->hwen_gpio, bl_enable_now);
	ctx->bl_enable = bl_enable_now;
}

BTW, iirc, panel bias can be turned off too, although I don't think
this will save too much power.

Best wishes,
Pengyu

-- 
Best wishes,
Pengyu

