Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC029CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 00:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5244610EA97;
	Tue,  2 Jun 2026 00:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XsOrjgn4";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9353910EA97
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 00:20:24 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5873983d19eso9264653e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780359623; x=1780964423;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3/xtwRP63pXaOheyPaBZD7pHEdFay+Wgq3mXhlc8lc=;
 b=XsOrjgn4PZKNhRSEEC8XMMqolzKP/XUF6e29rU9/dp6CgDDudrcaKz8SjLAf6J7+Mj
 3v4WamicIChZGAHrw27BUyc+PvWcc0wOozYxud3wVXdkcHI50zNkvZgjxmqDMH19wOLb
 eXkISF0qdvKgr6V8BsSI8c9n3ZEF8x7B0W4s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780359623; x=1780964423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s3/xtwRP63pXaOheyPaBZD7pHEdFay+Wgq3mXhlc8lc=;
 b=jS6M5i/EKuO0umKWFlRAca2ZTA43zK4Vc/3sD837SvoT+naIzMS17e3fCZuxPANrkj
 fiGTZseBbjC4P7TH2SIPtKLhdlMP5NsrMoSvEWKK/pH/nHsKeIush9nkCwajbvkY3lA1
 js16kZjkewANZCD2VlWmZDeGTwYFHqW6m6llUFogvQ5wbEe0cCZX3RPNJqjbZPUtbf+U
 Koycf5id25W3Qon+xJ7YCKtjJnuPEU7h1ShJH8bh350j3W0h+DgS7g7VpTY0EQoBkPey
 DDfodSt72bMX7jWoL+UQGJuV+qREekMi1qiDl8EB/J9rgxiXK7r/puOYb8oOUxBXpWAM
 CERg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Sxas38pASLvUcKzeO0V+YAEgK1BFSStDN/3wef5WmkYmrP44t2I6prYtZliOsuSpqhoYw5Yoipwc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhGFV65cjHPUjRD9vgMH4sHdwX7PGHPcNlEQIVH4hIuw2lsgCy
 fNofTjMeca1J5hS+qZsDRTJWXLJ214f4PYXIH0PPowed39O+Ead4/1jFeNgpc1nYgBTsfMBzxMR
 EuC8=
X-Gm-Gg: Acq92OE6ziDCwXgKlHA6F5RKU/ujrGokysGrBXqYWMe0m2W0dTqvWe6+lfYJJbDMCu3
 5wjcJTsWqnJNWBZssnBdgdDZ1a8F7v4W9yzviMPf3u8+xGxifyiCimwFaxZVe1DqRt0zw2UnHU+
 ZMewZINXbxs+rAPmnkUxx/cYM6hFPyueDRxPcciTqD99ps5CT+2OvTM3R+/VoYzdDvWu1uf/csB
 XsGT9IXJ7wfTdSV+sXGdZXtpRt3bgb/LWktONEQXgx0mJbVI3lPj0RGbaZmyz+BJh/ys1c3Kjkp
 MsxeCDvBCalcheZ9fj28aUIYEKRSdUBFCR1Z55QKeJQU9iHJOHYgS8gX9fLypncTc6bm53NQMS8
 uRwpNmxudeD1gqw4bQ4e+fOT06UMrdq15iGulG9yeucllSawWs+5Pwe2sgnL5dwaT5YZJBVqMT8
 tmd3HFJqcjpLum3yDW70xS3ujXAEh17c2Wn8ucHNf2ve7+e8KOgJI0ITu3xgvWzoWWZ3BJL2PA
X-Received: by 2002:a05:6102:15a9:b0:631:81d6:e158 with SMTP id
 ada2fe7eead31-6c699e3588cmr6509778137.27.1780359623658; 
 Mon, 01 Jun 2026 17:20:23 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com.
 [209.85.217.45]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-963aba26091sm7492744241.1.2026.06.01.17.20.22
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 17:20:22 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-6c534af2470so2278986137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:20:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/9KIebKcaqNu99N7YmCR8wU9FttE8RI4iZDNO+P/1v+aX5KB/BqeKtig9Q4ZIdYquWJFnZQ8rNIJI=@lists.freedesktop.org
X-Received: by 2002:a05:6102:512a:b0:6d9:a879:8e39 with SMTP id
 ada2fe7eead31-6d9a8799cdemr3618863137.14.1780359621380; Mon, 01 Jun 2026
 17:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-27-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-27-875d828d31bc@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 1 Jun 2026 17:20:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W41kpjCZp4Zw7Xv1Z4UNaMkphYeSTDGrK-gZgmRKbLTw@mail.gmail.com>
X-Gm-Features: AVHnY4KoP6emokdG8r8GhcSl0aAwryMZG2bxkIMnJwjPIqWCXeVcS_hXrMFQ9F8
Message-ID: <CAD=FV=W41kpjCZp4Zw7Xv1Z4UNaMkphYeSTDGrK-gZgmRKbLTw@mail.gmail.com>
Subject: Re: [PATCH 27/76] drm/bridge: parade-ps8640: Switch to
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
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org
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

Hi,

On Sat, May 30, 2026 at 7:01=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
>
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>
> ---
> To: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/gpu/drm/bridge/parade-ps8640.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Douglas Anderson <dianders@chromium.org>
