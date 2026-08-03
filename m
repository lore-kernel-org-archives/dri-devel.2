Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790E1C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D732810E048;
	Mon,  3 Aug 2026 14:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iy/tguGw";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D8E10E5F1
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:29:59 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so6081546a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785767398; x=1786372198; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ULsy1ctbWqO6V2elk1FWgzGLxyQfY/VXo4lHMIY/JzI=;
 b=Iy/tguGwuO494JsrnT8msFqyC8OHWPEp1z0fZ4A0soYPD9n41q9e0CJ3/SlQBFDsqv
 ZmpN5K4rrg1CpDld0hwPrG4fYHEyhI8EUDKhPo3A+wZK8bDdf8sOZF+iMeWCM+xN1j5R
 otzobstVAdma46IPdF80vgFZFQk35olN75K6E27neHqzTnc2zGOAnGmIvitC4kWwvzf6
 mtDwspFlKewQElJf/Zjtsa0mHz4c9SP4TWwve3/cIkPblI4WZZmOMucRimx79wkpn6Tp
 jmiVjYv4YbBCODHhzim0JC7YK7Eo/8qLEguxSZ5LJ5tKn99cDvLJMVYAJ1BUxZ5UYEOT
 cPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785767398; x=1786372198;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ULsy1ctbWqO6V2elk1FWgzGLxyQfY/VXo4lHMIY/JzI=;
 b=aDxCTdkwOuF1mlnCjyn6O4jfOCjEG7DnGzK9/NfBoxd4S0nCOUk9C2auO2iRFoBqr8
 WvCUMJdIrc+OpXQEM7dZ0tHw0dWCSrizzq9U0WdSnOFeQtZDIx2/vpWs4fkw/JEasxiU
 Z0snKCKqsEX3qQ2d7h/gW9c/6fC2kMsQPHKkz00nEODEgwpF04CJYuM7JpWiOkcvJBnX
 nVampe1euEB+TOI60+zP22V/2lOIead3SbNjapODcHP11RZkHtd9zb1Y1a/Ik94tSv8U
 U7aT8KPtk8lBOQpvjfyFNsvfTcq0dk0Bx80ss/HuOiQ1WtQpIAWCc2MDrBX59KuvRyHK
 9oqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKbFqw6l6P6h8TrcSqbEPwYbXxXMxb0cRbWFocEllQTKx0KCmC8/pPFkhbFZ12Tk/A8VPOCG7fl18=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyL5Hn2dvgkchOm563ThYf+M3jTwIrEtQdawBLXS/heRMy8NbzV
 5TLLbkvG8c1+Hzxj3Udj2avW8IYJ9xkbqdPnKymcgx5ewQIXssV00/XH
X-Gm-Gg: AR+sD13UEivpZmfCFaBtmJrQs3nYrtM22siSbJVgO3WIDEYd7Bz0upULLndpWa750qM
 NriOGBdQIf0Ck/k9gyZPfpkWB0H1YFTe1VUDTlFhveoMcG7u34IwOfio5QG0NHgUNGNF+XLY76x
 S5PB0s2SGkljqiDHo55tfNmhm+EmhrSg9uGV5noQ9LmWRpcwBx+ivojv3q0UE2v2C5dHzq56YkQ
 HKfhNgQCh+r7QA8imZO4MFEdnwwJ4XNK5cOqFcHbCU2VC6ZCv5IjsU21fuQPmECEJP5Y97xuU3X
 NgB4V/SixEmsnv3+4u+ACZKKps8J8lLZueKrEe+xmLEZj7FguJTgF3Zql2PfeBzq3bqQB8gr+DQ
 dJPPQ3mM7Pb6P93dbi3clbhFQO+0azRFUNriZtUByB0j/YM6QWj/XmMd7YKhBhOzjNKvorq2Afy
 1CRburgcT0XnGzi7ZnqRrBfH5hfX/BraSmG6TyfNg58XVtKH2dPsQE2UgGwFS+E7uAAJ2NbzoJy
 KjJ9fV9hbD4WzKpPlyIEyFgbQGQ/g1GjGbb/6KNziWzV1xlVpidMgb7nBghnztKlLko8TrynmVa
 cOIsrB0Y1s8oIWoo/DBteS/y9yybMhw0+45jQuGYuiem/6y88WDlflxAL8e/qcYO2+9rAjT85yt
 zXSWwyCuxkIpxiDqWfPEU36eK2rBlgNaeiVKahLhMjwZsKNQrIMbSEJuuGXw560HoYrc3VtmbMF
 xi/twKtHs=
X-Received: by 2002:a05:6402:21ca:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a0a7c72678mr7302242a12.10.1785767397382; 
 Mon, 03 Aug 2026 07:29:57 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-68.dynamic.telemach.net.
 [86.58.6.68]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c63dca6sm5741293a12.16.2026.08.03.07.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 07:29:56 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-sunxi@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: framebuffer: Set mode_config.normalize_zpos
Date: Mon, 03 Aug 2026 16:29:53 +0200
Message-ID: <lyqNcSMNQtSAKCGG4XMGOg@gmail.com>
In-Reply-To: <20260803111319.2836240-1-wenst@chromium.org>
References: <20260803111319.2836240-1-wenst@chromium.org>
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

Dne ponedeljek, 3. avgust 2026 ob 13:13:18 Srednjeevropski poletni =C4=8Das=
 je Chen-Yu Tsai napisal(a):
> Back when support for zpos was added in commit 47a05f4a68f9 ("drm/sun4i:
> backend: Add support for zpos"), a custom atomic_check callback was also
> added in commit b8f1230dd3bf ("drm/sun4i: framebuffer: Add a custom
> atomic_check") to have a place to call drm_atomic_normalize_zpos().
>=20
> Commit 49efffc7fbd4 ("drm: Add drm_mode_config->normalize_zpos boolean")
> added drm_atomic_normalize_zpos() to the standard atomic_check function.
>=20
> Set mode_config.normalize_zpos and drop the custom atomic_check
> implementation, which at this point is just a simplified copy of the
> standard one. The standard one also checks whether async updates are
> valid and updates the self refresh state, but neither feature is
> supported by this driver.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


