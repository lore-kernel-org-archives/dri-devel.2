Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D98C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 06:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9B310E460;
	Sat, 27 Jun 2026 06:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s6HFwbcN";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93E210E460
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 06:36:48 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-46cbe01d4b6so901810f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782542207; x=1783147007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=komZ01FtP3txsJGXgsSmR1HKfwi3kLT906a58S6194k=;
 b=s6HFwbcNnH42nHH21yptHhw7WqAuTv68srzWGD1izGyTyJNAEv+zfiT3WmLiO1tUFW
 526SJO5oG6miB5j2kyCM8cxHVvMZPA2ejn9EbPzIkFUWQixeAe9GIPN//Xib4alcMN5a
 dJm0vDsmD32PmeXGUkgOPvjLACIynzFp1RaxBwAU4qS2SxZyZF8M/uXL+v4zyJZmstP8
 8i7JnVwmXbC7X0Oyo9YCfQouLMd890OMNkAeO6+5xPIzVENUlAZFq9rdlAgTGdhY/H8u
 8m0W5ZxXqSrAKga38Gkoq5kz7ZhPUY5KyQl/2h4lSJ1xdeaFq07yove3C9b+eITNryKI
 0n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782542207; x=1783147007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=komZ01FtP3txsJGXgsSmR1HKfwi3kLT906a58S6194k=;
 b=M0f9Ly9CAUQoCC1CR9MKqEG532gu0IkvmA//qAkUFd9OanweuM04pyiJLIRQ40vA7a
 04QxAKOQ3+jAM2pdVVT5lUVVs5vZbPE6WpTPSpCXgBp41v65JWUaRkrJgJbt6wjtuUWo
 7nbRq7NCgbKko9WdKB0YGmy33ZnyLNR56k5zAEfOdqUd+IhuhhYkziO8Ys7oY0PJH5Ln
 KfKi5Po6V08bc6oD+Am7h6RV/Lz6tYKf1z662QIBPqOXTOVTglLG72+Nu7akx/l6r4Fn
 g8g4Hq7lVjj5jB2Hu+URUiEtx4V0nWuyx+zdV9uf8sPjOzQ7/A08KCCC+b7ATQOd2LB5
 T/QQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpSugCKsovWlf2yT/Uo2MuHE6dPu43a7DpLE9CmElGgcyFg+PBr+CIdLT9BDmcJ+IvexH7gP/0sOo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzq9VxnWyHKtRbpIuHqggZz5SKvESp+7KXZCOUYPPFgyuz56RMR
 +aPVW8T7fE0DNvur388YJdabDKw6mEB/JVAEg1w3y+eqr3izFyVzFD01
X-Gm-Gg: AfdE7cklWZDmVgWXuVnw6MGPHXES2kpeQVwBIunvU+Ac9hKc7yQRPhXi//ZkneCFQSl
 +xzuIL+4hIdyBi8oVeQdDVjC5RpunzluTpb7rMUJXRXic+uMX/MfHGhd64ZfYTMcORBT2s1qW2C
 eCd5Bg25e3+p4Xy0KZ2kiUBUpI2lgxmCu3zJyB8eWL6dbgv6AQBsjFAHX9DVKg+lkkIwDYfaMGi
 pzqRIMYP3hnzGIAU28HfmlXnkjJp0IVKn+SLA6RKDILq7fPtyozmX28V7jZkvXplqumyzD9Zdwl
 gEoV3Ts2YiskTAHSKFePBs2e2q9XNIGQG33B4ubtkeHc84Wv2TN4JIcKv/FJQgmC4Zuh/RmXIs8
 8lREzJ0NwJfeD3EOe6p+Aunik2ozMONsZee//q9V7gZOl978drksnVO3ADzPuVrxGiusKgcN7DU
 1xdizxrNoLzoM/IH8KGWOVXJ1T8svyS31EeOgjim0S91JB/cs3U7mVN4FKNO9PE8AwgEKzM9V9n
 /17
X-Received: by 2002:a05:6000:71e:b0:46d:71b0:e754 with SMTP id
 ffacd0b85a97d-46dc30ddc52mr14625249f8f.41.1782542206978; 
 Fri, 26 Jun 2026 23:36:46 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46fe25429d5sm6986765f8f.7.2026.06.26.23.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 23:36:46 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org,
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] drm/sun4i: mixer: Check clock enable failures
Date: Sat, 27 Jun 2026 08:36:44 +0200
Message-ID: <H-eSPH2FSEq_Vc39E72MsA@gmail.com>
In-Reply-To: <20260624055123.26769-1-pengpeng@iscas.ac.cn>
References: <20260624055123.26769-1-pengpeng@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne sreda, 24. junij 2026 ob 07:51:23 Srednjeevropski poletni =C4=8Das je P=
engpeng Hou napisal(a):
> sun8i_mixer_bind() acquires the required bus and module clocks, but
> ignores clk_prepare_enable() failures before adding the mixer engine to
> the DRM pipeline.
>=20
> Check both clock enable operations and use the existing unwind labels
> when a required clock cannot be enabled.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


