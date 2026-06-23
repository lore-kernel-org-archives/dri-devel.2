Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B44BCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8110110EC7F;
	Tue, 23 Jun 2026 20:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="PPZNKMPW";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EBD10EC7F
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:11:45 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-37da8b5540bso264834a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782245505; cv=none;
 d=google.com; s=arc-20240605;
 b=bpTu/weDLMYXVF7/G/NiwEaGQvyjxUIUX4ZcqlWGRVttQOv6s4vcGKDO5Ra6wGgbmz
 UWOL3tCdy7r95hJQNYwKvQJf7B8maQe78tfCB0SbUgbv3Vn/5N1UUhbwCrsrmD6ManaU
 RTeAKD/0JXBqUbtjREd+BfKApFY5i2qP1RxLoPnxufJTyRcI0hcLJgSqIzgIN9QlKN1H
 kDBjwD2qEnHv5gJMCU33ZQPL17Jejxncjo25HSHTghDrDNjIaqmldKvlkGKaGjZxW0tq
 wuiriNg4wA0T/42+QJjukBFaYZeofOpq5++TvdaeG3UhN0/8F7oFjlxpMDojVWN1lLLw
 tTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t9AA00HARo6TTOGKX0Hmf8exd0jNlIDDEh7Vt3olSGA=;
 fh=quuhg9r2a2oZsxVguzdw62uNdkqY7RqT8S5WM+37Vrw=;
 b=EAQlimtEIy7/1iNnwE/Fngu1whF+JXsO5pDj+uz95s9A4Agg4CPF33AtcJDxZb32a+
 bhBnCoV9VLjZXk07XHkKyy08fd/soZNlZpn4+YoR5dA35XLoaNAJw8SJCnrQnlY0migP
 UGdXsK/q6/zp7VJWTkita4THbUsAnYHb+xE/vPJA/pUCEmTz2LhWdSktcQTSY7rYrLgR
 9qhF0EKU5aiKZ0dwI2ZtyhJYaFMiYgsY5iAOOysQhjTnpFb7OqccdOSuYjhM1K/F/wtb
 Fc7I9SKuw6jEFIwvLu0G2h+xZZPRqo5Ko5GdCmFv4hYP8KiJNn+1ydjVVXdZErxHFhOg
 ZAsQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20251104; t=1782245505; x=1782850305;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9AA00HARo6TTOGKX0Hmf8exd0jNlIDDEh7Vt3olSGA=;
 b=PPZNKMPW+alHXANQm4PWYwFGRXpoDvUNkY87yCwbXXeIQuoAPjAH8yfaHVeQoNZvL6
 99VihsBDAKbBWYaLtkZk4lWDSwZQg9JMI3Db8LceLn65IB7yHQMYtGPvLOLyM82OQxWx
 C20dUIJPNHwOs+mwnPS/utFUcsa+fdZMLnxRmNB4ionE4sSZoIQdYljF8aiWHtO3Q3uC
 sNz8JIi/cFcg3/Jd5UrRyVWF3lWXfu/L0vzcjIlgpzZMmWrJ3FkpwHypPGda3NWhnaWa
 +k2oBfHfkOudUc1b1itEktFgEC/HDzGzofmGVSH0hV1BKA+rvQoj4TKlg5TwIPSXrBmJ
 kvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782245505; x=1782850305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9AA00HARo6TTOGKX0Hmf8exd0jNlIDDEh7Vt3olSGA=;
 b=DE3/YdlPTXGejSmjQLH50AIU3WY/IbGu5WVlDrpHGnki6xlebOCyMBrRkt8hE4ARfA
 fpBkVkNigs1iEiC1y8Msjzykma7pPnQ1e7Jq86DjE0KacIjBdaCIlfna8lky8bRaJqxD
 5wdCUWQkvngiN7bLFYkwDej6KVjYPFhDv9A5Q7tcjAqkiqVgrnLfpl2aprLPWM0U2pgR
 cVnOjGGkZiOhpjK0zggc8L+2opqOnz28oE0ZdgwIbJTuy91e8Iwr13etPpKG8L1MU5sF
 nddxpkRFarkIFX28wxjFs+kOYgKyV+rVGSDCfGjRQTd+1iEi2q7EWNqzwkIqIfHJdyaz
 TNkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrN8Uv1fNA8TUoW38kjGUQObKSoXPczU0b81eKhnGbp0rREIEVHtj1m+4UepD3STJddf3O+GKvLZac=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPfqmdEOeT7FJbhpOM4IUZOF+mf24n/TzeSxxo+cRn3lYjDh0G
 BPFSanKEpxDd+5cf8ctmj5E6Xq+kXdcFitFvivBpY0M36reCkzCIwj3cDjexn7ml3t9gWCwzHcT
 BCGUca4gJeZWYkwOu6V1UQ5zcz/gv040=
X-Gm-Gg: AfdE7ckzXsyUfkwwMu/ywaN0kNPf0Q784IGXgOIZKlZccQfCtJ5d0dxXqxeBt2Arc+7
 Icd6cFNAM91Fv2LSFQsyNmm0m6Byt2pRAsf6GkUbrwAks9aNB5Ve9D5yuT0Fe5pV/d/nuBKzKH8
 RLdMKgGbtRs0t4pf1vZF5b/RDx2bAlQsLYM3IquNVQyarmcPFjb/IurWNa4Tn3AaG/6KAvDkzWH
 /qGKRbuGKIxCHzXPI8AryEyD3dbSmlUXIH4qnghFtaOEe2Ur0FdxLNQdMubUAZXQa47SM8OSpXj
 uEmTpesRKHbCJqbM+Sp+wpG9wtRYsQ==
X-Received: by 2002:a17:902:ebd1:b0:2c0:e2ea:6b0c with SMTP id
 d9443c01a7336-2c7e14bda22mr4283265ad.21.1782245505106; Tue, 23 Jun 2026
 13:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
 <20260619-drm-no-more-bridge-reset-v3-54-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-54-ff399263111b@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 23 Jun 2026 22:11:33 +0200
X-Gm-Features: AVVi8Cfq-bHIbRBMSxAeraOZBrOtibTj2Lvi8RI8pWYRXkS8hq20ZIX0g5AznWw
Message-ID: <CAFBinCDJNGCsyRWS7KeXyHh4Fo0K6NX6sUuwdYRoCRoLn=Cx5Q@mail.gmail.com>
Subject: Re: [PATCH v3 54/78] drm/meson: encoder_cvbs: Switch to
 atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 19, 2026 at 2:27=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
>
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
