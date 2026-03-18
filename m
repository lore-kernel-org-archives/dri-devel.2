Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4026103E197
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23EEC89FF9;
	Wed, 18 Mar 2026 15:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="MvSxUVST";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E74589FF9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:29:31 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-89c5340fed0so11499646d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773847770; cv=none;
 d=google.com; s=arc-20240605;
 b=ALfk9WePN5Y3DfdMT58V34xkkfqx8z0ycnRNwf0wN+hQ1gufPkNlJGrU2GnmNw/aBI
 qFZ4RFFnbhWOeFrsTUMT+j1JWJG7KSVgUJCULUvFcGgGbRyiJTWyb2WembZ57yJAO4Gw
 Br9rDxd8TSLyyY2cNXK4xeaky6UcHv9ax90DPoQdjl3OG/zdcmDViH35aLjwhmD1DSHn
 eU/1DymI2NAQS63lhAfO2kZfc1g6j6nLRoUaT1MHwrwKrCNyQPr/z5iwjAXMNLkldfqM
 Nmeb5/oKDOmXt94KCVZXhvHFU7ci3HDvfrCREKtn/RrjtBC0KqeWcPGpOE3kfiX0xRzJ
 G54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1+z67iI4L59MdutM3mpmu0rsH9NTlRmTzd7nYcIbwIA=;
 fh=03qOWCT1IfWVxzL/vwRBZsDAAtPSdr42GsODSxUu3vY=;
 b=O0BNtpJzw/h1Ta3nKsaKEg4ufEnP7UUJOkwA5pDSGZ7hyV23Mw9p41JckMesK2qPWE
 s6WNcfEKY0VWGWDvA9UG0frqpZpB6qP5jU5v0jSlASGEhQLTWMApN+SIMQh9TKPDwFoG
 p1APcFtcBYC4F2JyFOpX4XeAFjclRpKXV34V5OsTpDVTdJVloel94oGEUAIjko2pPl3r
 98PGWfkvS+97TLsc5BNUz1kDIrpPz708qgmVxuWWKTgt+bmLo6BS1c/zQuHI6Dh4YT5E
 mNFm6GN25ATkEHvrUC3uAGy/XMdPagDJa1sx8jeQ44MB4C73sKIt+RIQQh3GfXVLzHvM
 3FlQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1773847770; x=1774452570;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1+z67iI4L59MdutM3mpmu0rsH9NTlRmTzd7nYcIbwIA=;
 b=MvSxUVST2CbIUTzfOhc+Uhb2fEMbXSMDb0uIg2i5Nec2KfPtpWDYXdS6ZB8qwuuMhq
 BvJ9J5GBigRBegX7pqmNNWBcvGbZrLoQ8heKzIKky1uaisn0fASUvlaOnAoKP+grgFGA
 hWduO4mbpPO4z36jBMlHmIRD7orgJMq9cytxgg0Sq2pWfM5YRTMFEnIphSaf/BaOv4dU
 zei/MsR5Gw0puT2OzEh3Wi95BvxY9Dc2U3C7q41vGKJ59aCJPrZ42w1BiiTeHEOT0eYX
 tGhp9vZfZyqW6CmQe9nHVRHlz9AIA8hpiAkC2tKmoLR8d8PyXF3Hwmpo9WTwkGoYY7vK
 8PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773847770; x=1774452570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+z67iI4L59MdutM3mpmu0rsH9NTlRmTzd7nYcIbwIA=;
 b=XIix6ZJJHliWiE9eq27nu8U1EJunC8wHu9/GgpAn9AjmFjlmVLoeLSCFFAcmk6SOHH
 kuvf56Te5Ar7rbDczbtbY4uJFJT9MaPZ3Bpel/q8c/0uTdKpkL9ixr3bAsu0ujyyRwmt
 exHgxVC4OHxC61bbmVfB0lumwSz3I3XGanR/NDTImtcfw2hh3OG1VmKGUeaZOyo+cFVS
 fbzAbjkyO85fjCCcPZjBuNW/jcejNaOlLNiRqY7m5jHC3nJK7X9AwLirtbYspGIlQXcj
 1bQQgBoyLIy5Rg3uu5WVmm8JfT4C0iBtELNhYD8rLpALRAFiqZxAEpEgtjRNX4N+vbup
 g0Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAVXRVlF8ZjTwL3n3sXm3RUYpUshL5BNhZ0K99TBiVfw1dXqaPxErHE6/BtGAsc3BFsprh4CONZ70=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6WE3s9Qqu5kFv3M88GgRWHooucEhIsm5VvYRop7J0FA2IW7+H
 oCltMIbRRt9zHOa5SYoiDKAVHccVYOmY6bjrtvcTcdpgGBwPocR3w6jJirvh2Id+BWett2UgQU6
 UVVGuTNOXEjgKkqN1IPerbQPjKg7ruBN4lyuzfQeLcA==
X-Gm-Gg: ATEYQzxp3CQSJe1ybRiOJvkTs22jKk3Yp0yuhCyekwJDQp27IEJzkyqYqDQQ0lGI3fC
 7+Am3RHgHZAD87f1nXr7u6NoU97tkQnM1FpfbCBmJxa/VPcc/+26FWLCZBgHRxE6ws4KHULwOTf
 tkpu4QiNWA03jIMOlbqfo7CFuT5253tn8C5sYnjJwxhMfLtP0F1UVb5/Xp6LvTvDbRF1a4WpNfP
 SjcH0e3IxHnutOPNVPNrUZyCQPFmHxKERL+xp+N01jv9mnwmukpqrKzrIJK6q0APvp/wi2c2gbx
 0/DudnQ=
X-Received: by 2002:a05:6214:1c4f:b0:89c:44f9:e894 with SMTP id
 6a1803df08f44-89c5e41b9f7mr103159756d6.35.1773847770018; Wed, 18 Mar 2026
 08:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260303-rk3588-bgcolor-v8-0-fee377037ad1@collabora.com>
In-Reply-To: <20260303-rk3588-bgcolor-v8-0-fee377037ad1@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 18 Mar 2026 15:29:17 +0000
X-Gm-Features: AaiRm53yGvgJgOV9I3p6FzqNAFzKV2WD3m1y2KktvZYLgOplUbSfLUgC9ZelTk0
Message-ID: <CAPj87rMW=4=0y_WZAhaLWhnEG1e-sF+Cn4XR57+p+d5wy9BvkA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce BACKGROUND_COLOR DRM CRTC property
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Melissa Wen <melissa.srw@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Robert Mader <robert.mader@collabora.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matt Roper <matthew.d.roper@intel.com>, Andy Yan <andyshrk@163.com>
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

Hi Cristian,

On Tue, 3 Mar 2026 at 19:24, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> Some display controllers can be hardware-configured to present non-black
> colors for pixels which are not covered by any plane (or are exposed
> through transparent regions of higher planes).
>
> The 1st patch of the series provides DIV_ROUND_CLOSEST() to uapi, as a
> prerequisite to the 2nd patch introducing the BACKGROUND_COLOR DRM
> property that can be attached to a CRTC via a dedicated helper function.
> A 64-bit ARGB color value format is also defined and can be manipulated
> with the help of a few utility macros.
>
> Note this is a reworked version of the patch [1] submitted (many) years
> ago by Matt Roper.  The main changes are:
> [...]
>
> The subsequent patches add background color support to VKMS and the VOP2
> display controller used in the RK3568, RK3576, and RK3588 Rockchip SoC
> families.
>
> The validation has been done using a dedicated IGT test [2] - see the
> reported results below.
>
> On the userland side, a Weston merge request [3] is available, providing
> support for the BACKGROUND_COLOR CRTC property to the DRM backend.  It
> relies on the already existing background-color setting in weston.ini:
>
>   [shell]
>   background-color=0xAARRGGBB

Thanks for all this.

To ssh://ssh.gitlab.freedesktop.org/drm/misc/kernel.git
   25854131c04a5..bec7cbfa7d4f5  drm-misc-next -> drm-misc-next

Cheers,
Daniel
