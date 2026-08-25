Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2975DC61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDBE10EA84;
	Tue, 25 Aug 2026 14:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U6nr+Tqc";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBDA10E905
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:26:37 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c16794450aeso634855466b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 23:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787639196; x=1788243996; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=60XtkPwFk/w34T7VeFlm3nV7ZLR8jG3DQAqksR7eXfY=;
 b=U6nr+Tqc3skIzxavUPKCIgYEgsr+B1R0fleatCfXzrwLR/kgsR2bhOb8sampIWbWhM
 hJrMmlOjW0BQd7KEHBYdBpyRsI8oZ/IsjIZcI1dP5dTFaDMnqBL3WgAWd0u67191nHeW
 K8RoMt+8MrYoOzcjONzjjAKaGpq6DOvTTkXJAsYjpy9Dc2YrLstou5AO8MInm6Lh6jG2
 17p9EIpygt0Y/PP+9G4PL6T7W/+SteC2u4VFUYuaVFAcypVzAsCbeMukeiek9hpuZ1BQ
 +AvhE7ecxEsqmcEHCW36ykaDJtJkSImjHTcYa+Xga+yjdlcEu/8c1kdwo1AIMBfclvcv
 xm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787639196; x=1788243996;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=60XtkPwFk/w34T7VeFlm3nV7ZLR8jG3DQAqksR7eXfY=;
 b=PRxPBgXcGWKkm+0QBnlsHUJrosT9Fg8jZKWzrgAApQWN6l89XlcRULyT/ACXv/kMzt
 x7d1bDzXniovl5TMBVyRzNsGVrVp25+OAipHtzZ8oz21U+Y4guOsuv6T2fZk899Ck4Ou
 oatDNsTwtpxcCXC7StGJacjQDQDPuXexvpDpEuS1mkXIKyb+LS3+R7OohiHKTLEg/tZz
 XIXBVhwyWaCAoqR2Pdrmk48fzFzf6LjZLFNwZ4e8XhmqjZQtn/Uhi+I+QRe7EwHtr71c
 0aCjbvhGBoALe6CjcISSUMNTNFlinhkBgazrQdiT+w0QDtPd24glcURhWHh8HkSj+onn
 PR3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCjWe2p62Z/j7v384yYWznKCfGf2+hKq8u/RGjQ0XKc6HW5K6IcnwrRJwdTVHFburHRnz7BiPkl8Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mA1/bVmGnqXXpR36oTrURwoqwfV8lulKVJcbPikCpDsWYDF1x5
 Jj2msBNpOjtO7exEfRdy6vx8UhaX0Uoe/1QnERNs377Xe+wxCB4VWRrz
X-Gm-Gg: AR+sD13GXjZXV062lC2397Ugc4SKnMxrW6HmcZ9UelU8jplIsUId1C0ovAiaGT4vsiB
 5bYov4K8hTNcxEzrc/s51x3z+am3m/YOCvq6yArj4MaMcuXgkasXrzJM2uhwq+xK3EkKW9/mV0h
 yljh/Wyy+vN1fJZDrpIi8PlUAy6iwvwKzImyQrtLcPvhqonOgUjZnsPj+kJTMyLCymAI+gtvs41
 Npe1m9CIrQNQj0T5Aa0E/s7BzckpzcZk+0Ju8kDytqVAzz3h0oMhw2O7nNi0SpzmZezS5UvkNYF
 2xMYbSzEj9ABcfN9z2DYtH0kQIF/Ezmf4TY9OBGBmgtEbGtf07FmRkZMXyaJPWS8ndMHZoRgn+0
 50HIFqLZJSmcsRl5oQizrOAnKSHToa02jZrzwatXLYcgCAcZneysKWzX1SchlXjFKnXGgZSRaWT
 f27XX1W9P+knH3NBiuMuwP58BAAvk2ZMBeUx4xMBJK2Rs8PghAWbEcnxbAWWUhcjGu8u/QZH4fx
 SvEZ2avpMyf+19seyzqmcwTLCkQBnbExtz0AXOGi8RnrOuGDXexydYDrNh1wWiWlpRluVgQZcH5
 BrbCCJugv6D8ScH7cXGP2hToJulLfZP7wHp9djTJa70GDoxzRWNM0c8S/mbfXzJOpg==
X-Received: by 2002:a17:906:9fd0:b0:c20:1db7:f486 with SMTP id
 a640c23a62f3a-c246a2ef579mr3321726966b.4.1787639195439; 
 Mon, 24 Aug 2026 23:26:35 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-af54-b201-7419-a557-62e9-4d13.310.pool.telefonica.de.
 [2a02:3100:af54:b201:7419:a557:62e9:4d13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24967459aesm1547936966b.48.2026.08.24.23.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 23:26:33 -0700 (PDT)
Date: Tue, 25 Aug 2026 08:26:31 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: hdmi: Unregister the ASoC card on unbind
Message-ID: <ao01FpItuJm-5M2e@gmail.com>
References: <20260822143218.68764-1-kmehltretter@gmail.com>
 <20260824-expert-sepia-oyster-cabaea@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-expert-sepia-oyster-cabaea@houat>
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

On Mon, Aug 24, 2026 at 08:52:44AM +0100, Maxime Ripard wrote:
> And that happens only because you have no user. If you had one, you
> would have had the opposite sequence.
> 

Hi Maxime,

Thanks for the correction, and sorry that v1 described the lifetime too
broadly.

You are right that DRM-managed memory is released when the last DRM
reference is gone, not simply at unbind. With an open DRM fd, vc4_hdmi can
outlive platform teardown.

v2 was triggered by syzbot comments on the ASoC retry path. A deferred card
bind can move the devm registration outside the component devres
group. With no DRM fd open, the final DRM release can then free vc4_hdmi
before the HDMI platform releases the card.

v2 link:
https://lore.kernel.org/r/20260823173740.2983-1-kmehltretter@gmail.com/

I will send a v3 based on your input.

The implementation change was already in v2. v3 only clarifies the wording
and keeps that same implementation. The card is registered without devm and
unregistered from component unbind while vc4_hdmi is still alive.

I also tested this on a real Pi 400 with /dev/dri/card0 open during vc4-drm
sysfs unbind. There were no new KASAN reports.

Thanks,
Karl
