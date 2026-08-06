Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D0CC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070F910E543;
	Thu,  6 Aug 2026 12:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IDBq5CF2";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6963F10E543
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 12:29:10 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38e3617ba36so2155475a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 05:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786019350; x=1786624150; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PATN1j5zjfMqry81Ubt1Txf86+h6fghF2+e0J3o9yzQ=;
 b=IDBq5CF2kwTHdY2aOWRxhQ+cr2baFxmKp7bNTxNPPUzYpHD03d4jJtat/z3oq9stNj
 DN8StlEbhjUNw+lhPr4CqnyGNjEMOPmCaEivzUmm6juPGxcciL7IsjdGnYEnGK1scXKy
 EKkmhkbyN8zF+PYlZmRCXhZM98Rlq7IRZg43GlEJBr+ro3DR1TSZgoj5q/BtajyznR8g
 LxrEW8UceEuMdzQCnERmz+HiKxiZ+fGoszEZly4v2CmGO5uZlIUPH6nBZHoUPdg2NgaC
 Gmtqf3CNGKde+Gv/hWXWJqtXEoStW3twX0ZONUlx77Axgn5kWuAShbZoUIgyXWtHcZd3
 P1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786019350; x=1786624150;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PATN1j5zjfMqry81Ubt1Txf86+h6fghF2+e0J3o9yzQ=;
 b=rBvwaWURkjsiWKgREu+uYuXGypaQGMxZEJ6GakthwoJPulS/NjzzTxupmB0PX//kLO
 gB/1lK/ItgZgw+eFm1oq0qxTcGrp4SBjccDm5x83EGclCuQPotUFf2urDgoZt2myQCTi
 0BoZQdZaPPUD0Uv11JZ+HCgHbfn5gxQLB2hhgrZAviUAQ+lYPkVyFDFxfu3DmwjMqRnK
 z1D/pnGQFJeClLevJDulrExRzXhFmRZEbKVQwn8TNlkbd8BhZ/6j23sofFClVJuTXFNx
 r8gelDmxbPPojiGX8iImHAQ6bfQGkhQSAteClhoEfUtK3tMcgE9AWO/SqcescbPdQVSY
 O3jw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roez7Fs4ZkzDDfp5PgKOhgijLpj5uAUVYNA6BCOxH7SrPc18YZbs2H1eQH0ZsVrwS2aJI4OVd6rGUg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyp9eEjVbIP+CF+VcvMdM/xBauSW5gEs+YSTYX1T+tHtwUCO2Hk
 jlGLNpvCtRqZ+ps81o2MwzURzuC2FZha8wShjvr7dRk6yWekjWCS92WtkwRFdP8=
X-Gm-Gg: AR+sD13kt0MhcexYQWtAQoGFULhXcExWhfHnhaFken1AMrbU659KkbFpNJNlPb7BRdI
 PWE+i84BakiB4sktNKqIIlkuoo2cm8XoPaoUFWM0JJCsD10zGLM9YxpEW5Q0/S4Of3k+JJmXSUY
 Q+C9gwJzB19pDKnjJbmpH6XCKQGx193F8by/IMrMM/6VhWzFhBybiuOhhz1IB9J4Pel2nzJ//pW
 YcT4HJABPa1wD8VhJYAsXv+ZzcmiNFRGsPiLhiS8afSSbS2YKEfx7YIsmoIXBhFwnzBF9EAkriI
 ZR4CFracEakglX4KLvJnNCVQM4oNawEv1xSBmaj0TUhF3XrzfUKhdqJ673/B8l9ABaFkIAjfZaW
 hN3P9+0xMIHiF5RY4pswF5rq5XMEuREQGzsJncKJCnOIl2GGlqwuzwhiXjv3afVPH1QDGEWlzXR
 SbHz/jGVAP3g7LfJld50Cm86ecGATROIsq84ZqkqC7lqEDjl1rod6xkp37pVe+MDeXgFeLzQxSG
 O68qBmdsx7mKSNdgQmPzima
X-Received: by 2002:a17:90a:da83:b0:38e:2c8f:a01a with SMTP id
 98e67ed59e1d1-3903c5d2f8bmr14496686a91.11.1786019349803; 
 Thu, 06 Aug 2026 05:29:09 -0700 (PDT)
Received: from localhost ([186.158.238.108]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085dbf82csm1463292a91.1.2026.08.06.05.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 05:29:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 09:29:04 -0300
Message-Id: <DKHV0NRB0DYQ.2EYHJ4T1FV9N7@gmail.com>
Cc: "Brigham Campbell" <me@brighamcampbell.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/mipi-dsi: docs: Mark mipi_dsi_compression_mode() as
 deprecated
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260702194223.290763-1-nico.antinori.7@gmail.com>
In-Reply-To: <20260702194223.290763-1-nico.antinori.7@gmail.com>
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

Hello,

On Thu Jul 2, 2026 at 4:42 PM -03, Nicol=C3=A1s Antinori wrote:
> The mipi_dsi_compression_mode() function is a thin wrapper around
> mipi_dsi_compression_mode_ext(), which is already marked as deprecated.
> Additionally, the non-deprecated mipi_dsi_compression_mode_multi()
> alternative exists.
>
> Document this deprecation to encourage developers to use the multi varian=
t.
>
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_ds=
i.c
> index 3ac1dd5ad640..9e20818f2de0 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -699,6 +699,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode_ext);
>   * Enable or disable Display Stream Compression on the peripheral using =
the
>   * default Picture Parameter Set and VESA DSC 1.1 algorithm.
>   *
> + * This function is deprecated. Use mipi_dsi_compression_mode_multi() in=
stead.
> + *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
> --
> 2.47.3

Is there any feedback on this patch?

Regards,
Nicol=C3=A1s
