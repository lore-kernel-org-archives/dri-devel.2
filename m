Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAC2105F787
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D03E10E04D;
	Fri, 13 Mar 2026 09:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="CwddWdhI";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3469B10E04D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 09:52:19 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-4853b5b0fafso25037535e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 02:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773395538; x=1774000338;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=V70IkhLpQ/taGR6pCrJdxC5WDW/RC4Bx2WhEUbll+RY=;
 b=CwddWdhI8kXIUg5V5thWgwGxuP19GKILO95CkEHZwbKPqKVk7XC9S3Cwv7cl3AVjhR
 2IDnWBkgBG+4TjGbEaVHeFG/gtduOmUgYNVycNQhdg34fV0C3kz7VbtTugi0KJa3Bcq/
 6uN1FApt7IIX0TC0RTNtdlevk3XBzBq6XC1w9BkXebNPZoqI8/tatlYYnLUMe2jn3Nqw
 ANKCf/r8+pODYEgnVPopSlVaZrlpEHgdbE5yjOeAR4j+D+HeJwZEyGuQun/AWWfMyN00
 EmXylncXiy5SAyMKZ8BxUouxzaZt/7A5vepUoOOHpVBAvVBMvcX/poLcib//4gftxoAN
 7v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773395538; x=1774000338;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V70IkhLpQ/taGR6pCrJdxC5WDW/RC4Bx2WhEUbll+RY=;
 b=FOPY8HGbQ1H30bAZK63M3Cw24tbc5cH6ItIUUwGz+BnhiIeM4VhgU4ZjW8e5vxEjUq
 uP9ujVE5DgJZlq18Nor2ft3fHZlBYDVRbER7JsTUJAra20eWEqndK3gIurA0FXinxhG3
 MYeVhmSoWTDKwhg5CQLwQFuGPyZpQHPy4aeWiY+0CpdMkHaTow8xblNioNR/j0eIS0lz
 5G2bKaIOvt6zzCTp/QHlvuqVu67+7CE2u6/NZaQfTvKyjltzUo77i1VLYmwJ87HHyD+l
 EBUWovptmZdvdjuE2WR8VhVW8QlPijTRvL9tLtcGUJV24QMCq65ck3Tjrb33H5+Ct1hA
 B7zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnZFOErlLo9MV4kso0X4uGa6wNtD9Pl5ZjF/mjN0j9pbB362MA8fj60s9akONAaXXcBPa+h89wzmA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFI1BF7+48fq/aUcYnYc+vbxhdKULirzlQ/jci7HEq7CCD2EkU
 pXi4zAB+0/vXq9LIo7FP198Q1XrcGVI7OmzjoQLrdolbu43ZsCt6myOuPALi5HKUER/pJxoHOdp
 ReT9CLJEy9C10eTazhQ==
X-Received: from wmlv5.prod.google.com ([2002:a05:600c:2145:b0:485:4ce0:d98f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524f:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-4855670281emr40166955e9.20.1773395537565; 
 Fri, 13 Mar 2026 02:52:17 -0700 (PDT)
Date: Fri, 13 Mar 2026 09:52:16 +0000
In-Reply-To: <20260313091646.16938-1-work@onurozkan.dev>
Mime-Version: 1.0
References: <20260313091646.16938-1-work@onurozkan.dev>
Message-ID: <abPeUBWpTB3mQRQs@google.com>
Subject: Re: [PATCH v1 RESEND 0/4] drm/tyr: implement GPU reset API
From: Alice Ryhl <aliceryhl@google.com>
To: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dakr@kernel.org, 
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Fri, Mar 13, 2026 at 12:16:40PM +0300, Onur =C3=96zkan wrote:
> This series adds GPU reset handling support for Tyr in a new module
> drivers/gpu/drm/tyr/driver.rs which encapsulates the low-level reset
> controller internals and exposes a ResetHandle API to the driver.
>=20
> The reset module owns reset state, queueing and execution ordering
> through OrderedQueue and handles duplicate/concurrent reset requests
> with a pending flag.
>=20
> Apart from the reset module, the first 3 patches:
>=20
> - Fixes a potential reset-complete stale state bug by clearing completed
>   state before doing soft reset.
> - Adds Work::disable_sync() (wrapper of bindings::disable_work_sync).
> - Adds OrderedQueue support.
>=20
> Runtime tested on hardware by Deborah Brouwer (see [1]) and myself.
>=20
> [1]: https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/63#no=
te_3364131
>=20
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28
> ---
>=20
> Onur =C3=96zkan (4):
>   drm/tyr: clear reset IRQ before soft reset
>   rust: add Work::disable_sync
>   rust: add ordered workqueue wrapper

I actually added ordered workqueue support here:
https://lore.kernel.org/all/20260312-create-workqueue-v4-0-ea39c351c38f@goo=
gle.com/

Alice
