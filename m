Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FA4C531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C40A10E0EF;
	Sat, 25 Jul 2026 03:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PnjQJFtU";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C8C10E0F0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:49:56 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-81ee6b2da98so10651327b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784951395; cv=none;
 d=google.com; s=arc-20260327;
 b=ptv8xq0hMhr2ccNJ1vkwnpX4yGQpTev4QvXxIs4+ABgpHyie87AvG8RYKDB0OXS93O
 yMX0axA1GeiPBATYOHJGaVh+LfH8iwhvXB0qn3FEwZn2Vopk4EYLi77HHZD5hPxtFybd
 3s3t/dXGqCUax88LJY6JHMtkG0Nq4G+DN8Pscr8mGEy+FAZ0J8mJFlwvjpMcMLcGPY6H
 3NLHsKI7SBbgSWaDpewUe86nK9lChHO1v4OADBgu9LGx2iaWjGu1hxDb6eKI+6kH98PX
 v5zfocTvvNmRsEGea0QfTEvT18bSk6zZ/sGKciq5WrfDQwimjx86VmkUDyBKfvi90oNU
 jk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+Auhbwa+a5TW5dJOagtosBZ5QlY30myaRTt31FDzvB8=;
 fh=EY6+9+zUXAsCNyd39RTBqssQCEqzlAI2njnHrsUSTc8=;
 b=pMLnFghtrhIp1UBvEJIz0bFEGJyt2dxwvQnPY48UyDnnm14CQKrb9IjShJGg+k88MH
 i/DXGuRhmjofImjb092VVTGumyjjoUAH6GNTxZy4G9LWM4wEHvPkVZhWpZ65cILGHIGc
 pLs3G45eiaf0xSMAPhEhEcxZvAOFeDynfK1YkrhEelvF/P45ozsgzSHCC5fUm2A1S1Ym
 ag06w/xXBovBq9+Hju4VJB5F8AB4XRs5DO895y7dmsPGha01lJtqlxLEiTTLEIE7Uf4V
 j6WfHH8O8v7GDt8/x0yMiwAQDe0Gr8C0vJB697ysAwdNRzCKBjzx0kKvWzEb8ZXxKfB4
 9REw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784951395; x=1785556195; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+Auhbwa+a5TW5dJOagtosBZ5QlY30myaRTt31FDzvB8=;
 b=PnjQJFtUKH99KRojOWSIDYuUN0LlMUF8PhWvgucAo/SUKMt5eRHcX+3CG5oSuLk9T2
 aDW5LRs+WIwaD4KBFYsEi7bU5EVfcSDKmf/cvlKi1vfcKupp9hh2v1GD9uSogEozs1bK
 3Py3DUFo/z6vH0F/hffIUDGMJx8EA7nlMFulzHlIf4zRY2Ko5hDp6x0KSAWeO5Yc5yU2
 KAqrUg8s25pFLHVjXXKUaqgFw0tLcIDbZD1i676ul1xXaU5rv8o+FIPKO8YTk7sJvM1m
 Wmh55IKlkJ8hzkITnvI3ox+Z0/DKi117PjmnBZnmut15SfkYgs0AKDj0GT08hN7HBFSU
 UyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784951395; x=1785556195;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+Auhbwa+a5TW5dJOagtosBZ5QlY30myaRTt31FDzvB8=;
 b=dc729OiPu+3tOIXYiqVvfT2Shl8VQm2BXGiZCEPs1M4jwM9yvNaAW/meSe52oaW9v3
 dkkUmY3x9aS5DiK2FSsCigODmjuSb9Ws5udW43S980hEHQzhFF5u6wtc9Nhb3r/6xrL+
 jJUqsRjX3ug4REGi5hoZ8z84IxUpz8wowF27OL1QcS/ArxUGCJlkBkDWd14OPVa9wAaW
 DoGT0BBKqjF6dq0EuiMUBpI9LnAF+NcgCzDokFFoES06Zu7OFYkst/ma5JwRDUmAqVe9
 oUQpX4aO2Gj4MQclmYRn3QR3TyXFTl6kFXV5zvwghkJa3LLhJP0FTgKTmY/6UfDHk7GR
 OIrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RohjSSP3Y8eW+Pixv9XQuvhoGZXjpXnk3TQ4M7oZJmxlQJ5ysUu+JeCpPTSRFOkr+wCyNFBl20mIIM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxifs8GVuzwXUP2qIMCCSAkQ69aM2IntRm6MqWFZcHVEhVmo3Gy
 LItNN9C9UJPBdy5X9DPBrv8SgWhvi87eIVmVeucWrNgRFzpPIjVdUWCmGThOxxj+iPZCbdWA2Ca
 oIIU+/EGwg6FLGFiu9ItXr8gADQMP1sQ=
X-Gm-Gg: AR+sD10zDIDi/JiJk6Yx/9giDknKswGHz5T0VkT7cPCmsSunNacdVgzzMEhjAhFE5mL
 JclY+bRH11zJtqSwkh4qa5+R8N1w2kTXw/4ifC0qWN5wwcqqtlM6qVNwTbDsxnU5wl4U2rBA97z
 OXlBRDv3R47DzpspMnU2lbvkvLpfU7NFPv+hhoP9CDarXfSRqoE1GgmuJTo4Dum3gv+qO85y/tC
 734DA/ANfCiw2f0xrUjQTnCKJoQnMf2ghGsm0s8sxtjn+IHhfX/Q8N2XKgxg1qgnNOjhIO2E0nW
 2FMbfQ7xNI+DFlqzYigX1cLSZRjR0OMSPCUdoxY9GqkgZRI=
X-Received: by 2002:a05:690c:84:b0:7fd:a7b6:8d87 with SMTP id
 00721157ae682-81f69ce0006mr3890967b3.25.1784951395636; Fri, 24 Jul 2026
 20:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260720215058.398210-1-lyude@redhat.com>
In-Reply-To: <20260720215058.398210-1-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 25 Jul 2026 13:49:43 +1000
X-Gm-Features: AUfX_mzPtibcVs6rRbWkoM0g6rCCWwGuBSs4QpTCZpfNRuTtPlzDFCNiscVZkH8
Message-ID: <CAPM=9txcOcnnxznq41z8+FA_V2BCqmRKFZBOt0oEhcHbBs8Fsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/nouveau: Fix WARN_ON() from missing blend modes
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Dave Airlie <airlied@redhat.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Kees Cook <kees@kernel.org>, 
 Marco Crivellari <marco.crivellari@suse.com>, Simona Vetter <simona@ffwll.ch>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Stone <daniels@collabora.com>, James Jones <jajones@nvidia.com>
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

On Tue, 21 Jul 2026 at 07:51, Lyude Paul <lyude@redhat.com> wrote:
>
> Recently a change went into the kernel to ensure that drivers which
> expose color formats which have alpha channels. This would cause nouveau
> to hit a WARN_ON when setting up cursors, since they do support blending
> - but we never bothered trying to hook up the controls for it to
> nouveau.
>
> This fixes the issue by ensuring that nouveau always exposes a blend
> mode for any planes with alpha channels, regardless of whether or not we
> have control of the blend mode hooked up. If someone wants to add
> control for this in the future as well, it should be fairly easy to hook
> up with this.
>
> Previous version:
>         https://patchwork.freedesktop.org/api/1.0/series/170773/revisions/1/mbox/

For the series,

Reviewed-by: Dave Airlie <airlied@redhat.com>

>
> Lyude Paul (3):
>   drm/nouveau/kms/nv50-: Add .blend_modes to nv50_wndw_func
>   drm/nouveau/kms/nv50-: Introduce nv50_wndw_default_state()
>   drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for
>     wndws
>
>  drivers/gpu/drm/nouveau/dispnv50/base.h     |  6 ++++
>  drivers/gpu/drm/nouveau/dispnv50/base507c.c |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/base827c.c |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/base907c.c |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/curs507a.c |  3 ++
>  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  4 +++
>  drivers/gpu/drm/nouveau/dispnv50/wndw.c     | 40 +++++++++++++++++----
>  drivers/gpu/drm/nouveau/dispnv50/wndw.h     | 11 ++++++
>  drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c |  1 +
>  drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c |  1 +
>  12 files changed, 64 insertions(+), 7 deletions(-)
>
>
> base-commit: b0a652436b892eb9a036a031b33099dca036faaa
> --
> 2.55.0
>
