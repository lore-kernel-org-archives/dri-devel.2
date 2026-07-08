Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D6C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB62310E641;
	Wed,  8 Jul 2026 18:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="Rz4F6IEU";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E8A10E641
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 18:25:51 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 3CFED32E614
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 19:25:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1783535150; bh=AYKBzCp7T0QiMMJZa3BAdBHLdsgd36h8hp0281HShrA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Rz4F6IEU54yvzVOyMX17QgK2SaSaBdj6KRKClyOBercbHhZeystVlHxpFYuy6xAps
 t39bnxaeOJcCCS7rATNwmBC6Ed8LGq2wCEbWfCFmOZ8mCDVEwHH539/Do4wHgRGa32
 AUiUr63Hp4YU2WlezqpzvrBu5br8t0tyQwC/T3lFzNlwG3X/RAT8JMR1r3hAcs5KHd
 IesPPSapqiBAJAcHhONLjf8eyafK7LTiEOPPYXFAglJaZfemYSoHCO4Dspc0kwEERx
 R5KwuGbHxYkakJpQ263XCqBYVmtak8Jxy5RgCTikvhdPTC9sfBm196Xr3ki0IJjYO3
 H0v1ETH0VRuMw==
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-51bfbe05683so6433351cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 11:25:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoZaBjoe1bOrLya6z/Yvh7BFd5xYOx9Kbp9O479vY9JOJL7Fs0tFLt7vqjr7flihnga8mb6f7ZyoSE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAxf5tKewCQv5dR5xuGTHCZuLzmQAPZnUo2HYyv1bCfrhu63Fc
 2wkhW2w2ifCuCeUIPzQxu7M4vLhhG0EBGmie/5revbJNZtbxG/esid0U4gjXuZoUbyJk5Nhd03Q
 QZ4nmV3MJairC/Z5DZAU5asGjAQwp0kE=
X-Received: by 2002:a05:622a:a0b:b0:51c:ebd:fb40 with SMTP id
 d75a77b69052e-51c8b2e3a0fmr38998771cf.31.1783535148479; Wed, 08 Jul 2026
 11:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
In-Reply-To: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Wed, 8 Jul 2026 20:25:36 +0200
X-Gmail-Original-Message-ID: <CAFZQkGzw2MZGivy=oyYgZE3_dmxu-z-NbDgzh9uyqSsj=MG=2w@mail.gmail.com>
X-Gm-Features: AUfX_mxLV-zi6P4yw-MJNuFojIPS3QWwBaPQkdvJdxirQrCb6kj0O6UjI20boY4
Message-ID: <CAFZQkGzw2MZGivy=oyYgZE3_dmxu-z-NbDgzh9uyqSsj=MG=2w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] drm: Add DRM_MODE_ATOMIC_RESET flag
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Stone <daniels@collabora.com>, Harry Wentland <harry.wentland@amd.com>, 
 =?UTF-8?B?Sm9uYXMgw4VkYWhs?= <jadahl@redhat.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, 
 Simon Ser <contact@emersion.fr>, Victoria Brekenfeld <victoria@system76.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi,

Thanks for working on this, it'll be great to finally have this solved properly.

> Open question: should DRM_MODE_ATOMIC_RESET require
> DRM_MODE_ATOMIC_ALLOW_MODESET? A full state reset will change CRTC
> active states, which is effectively a modeset. Without requiring it,
> a reset could pass flag validation but fail later at atomic_check in
> a confusing way.
The compositor may use the same CRTC states, modes etc; whether or not
the commit actually ends up requiring a modeset depends entirely on
the exact contents of the commit. So I definitely wouldn't require
ALLOW_MODESET.

- Xaver
