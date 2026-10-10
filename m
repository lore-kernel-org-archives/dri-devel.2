Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33114CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 15:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0413310E5A0;
	Sat, 10 Oct 2026 15:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="oAhTH0AO";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9552D10E5A0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:04:00 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so8252355e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791644639; cv=none;
 d=google.com; s=arc-20260327;
 b=E9PBWwoFY8aoNH8rPdR4LglE0ClLR1Ma5gQtcu/Bezfcq5bPkJ5ck/4EOwXvgbMxt6
 qwxwMS7lxSNt01YE6BQ4VCZtRGddHceDOj2A6jYw9tUYM7SPYcEX+OkszUTbNmevYyIH
 mVeUiRaPaeaFBDpWYxgNe2Q/kytNVt+vVTFlz389Iqpgj+lhy9r/l0gKxce637ctE7cD
 D7Id021PD33jrRoqS5LHisnid28kN1y8RBLtpt1hgwps1nOT7K078QnXrg4gmUQxYG0l
 ntnFfpA27nC8pHawhbrrfs6CMMBYgUTInxv+lj6ZjgOOCVFOmcIbA4tDT7KzFspunwjv
 zWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D4M8q1Gw4JSNRpSJ6YMmuoD2ZiLo8ynCybzLGCHtt4s=;
 fh=1AoAT7nm+QaqIc61tPARY7ENEAyf8cLaToYIfpX9fk8=;
 b=a2qaAOiLqxTaqYUgNbVgjkGpQkf2atHWHic+YDHPyV0pCY21ugWfbNqqIY1/6Qon6I
 ZYJLT/Jll78+Jc+j/VkI69P8XyF5aNw9TMIvQOxDCrxyQij3gc/QcwEghUN1aaA0Pobr
 ROsCfs2VEYQ3Dj/1YczqHWI8oRgdXQt/TBVKakLpIEYzxQlJHnrFqRUVV2rZNuaIfDQZ
 bgm7CI2xahhl48ukOA0cffPKFyd1hFEJOKqyGtz/fFoUb35uPoqMGlbmGB6onLEK0O7s
 MkAkwjKjGhzGlEl3jfJAQU8sTedfLIgiaymZxMeXdP44d1a0Sz4+1PuDk3BzCxIXSkJU
 NAWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791644639; x=1792249439;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D4M8q1Gw4JSNRpSJ6YMmuoD2ZiLo8ynCybzLGCHtt4s=;
 b=oAhTH0AOfGjz+CWvGIxD3fGkL4zvKGQ6/rzeAaC2pQKlmRlSvCPqpx6F3edXQwQ5d5
 t0V3813q2XZorUqDxuii5M8y9o5tUwxe2UvWuPYe6Zlz8wMmsjmJd8Ql+VjLt17SSyeJ
 Xw6jRLYyEpwokLsdh21eCVX0CCUUakTaNeU0QUCvx0BtAax6oKWxK1qTbDdY6gtniW8W
 Uw1fMwRxB2TBeixyy5NNkzK6sRlptR4TA0/NjztolJqIOO5e56V1Iji5WBPYD++cJkuo
 8LH23hdvteopjK0obT7unlGK4bGyypLVWFihNaDVRsYDGy/HAmJToR2HKl+1cfjD3sg6
 pZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791644639; x=1792249439;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D4M8q1Gw4JSNRpSJ6YMmuoD2ZiLo8ynCybzLGCHtt4s=;
 b=sjcFjc8pEHm/V1BGq0uiAJq4kkakVk4/6xrI/7B6FPd4bOoQK/YrEQXJL/D6BWS/vl
 bpewhVCwkam3TjbZcC5ilgMeoDB63PNoLHrEZ/9MKZC/UBtXl/fuVlnf5lqDCy5Tt56I
 7Fz18bpR3PpJxARcw1cDXuUboSOxHKV4i+VxYZNGE6l6WD/EpJ2SXJl2BrhS7GLk6CWz
 dgp1y9IFoyEs48KrTRQ9B8/xANgwvd2xX12hhTju+oDLPPALAfZ9hxyJVK7+dOJgtJu8
 U4BkxFxbSYnvjoCoz9AOMZAoyCzMqUO8Nr/1aA97Lxy5NbGqp9BVNzzIUnKD6FkHi0yx
 rdhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBww+vgMTiPo8H/EbSUwwNwNasACGoAFf1GjueiHQatizVIvtRdYoIO6qVvsDUXKebMWL938PayN4zc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKI+aETJVrcp6XdNTtwonn0TBnGIfgf+Nyfz/QBDNZyP3HLmK9J
 3h1XeaQE5dSnKn1RDaNGXft3fmefBoK+jXaJvHHbv2uz/zw8EqmApPf+W33pj3U1pHTgBNDC8q2
 iFDK0Lr0JiOsA/nXy6jIK23avTQpoO5x6EIhetJZv
X-Gm-Gg: AYBFou08C53Sm4xT6ohVHFA2hBLuWvEcc/YXF4eff7g14WbkP7T8ZZenojGbmI+r2NF
 9T3KT9J8GmKabEXDm9omkCJMJFeU7Db41liYqd3dNa+hoA79BcOWXVty0pFzi7MW5zcB8KJlPAq
 /nTQfAmoDM0HMHg898DRfA5HVEsCS9egaXP40M+gQPKgpCFwZjf28Eoq7tPpWin/yIyWWWWJhpw
 6Cn5wK+R4xFGjezFDKoRO9aD4PoJCMze+GDnyrrUjVUoMUVX0UvXHK6EUzprtvG+NYx7hkBtUHN
 glgIYudJ6RkDuV4uoLjbg76Lc7RCzgn3Q4+7mITMmxAGBoOM+zOoqKjY12E3+sO2aoWA/mMMcXP
 CijK8XeHMB/JR78TImzPe
X-Received: by 2002:a05:600c:34cf:b0:4a0:159b:d2a9 with SMTP id
 5b1f17b1804b1-4a18e4d68aamr77276885e9.24.1791644638230; Sat, 10 Oct 2026
 08:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260929190024.2248099-1-dakr@kernel.org>
In-Reply-To: <20260929190024.2248099-1-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 10 Oct 2026 17:03:45 +0200
X-Gm-Features: AclHuK8ZQUI3eItwXg_rZSYr1EbwRsPHujK2QRZB7QR-TB8HYr0HF9f_x1pIk1Y
Message-ID: <CAH5fLgh6siikdQ-vM2eMdbgqxOvquGuv=0UKZwidabj4tcGV7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: drm: Return impl PinInit from
 drm::Registration::new()
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, daniel.almeida@collabora.com, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 tamird@kernel.org, work@onurozkan.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
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

On Tue, Sep 29, 2026 at 9:00=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Convert drm::Registration to return an impl PinInit<Self, Error> rather
> than creating a separate allocation. This removes an otherwise
> unnecessary allocation.
>
> Update both in-tree callers (nova, tyr) to construct their bus device
> private data using try_pin_init!().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

For both:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
