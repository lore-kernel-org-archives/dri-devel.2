Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4B0CD6E55
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 00:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5518810EA93;
	Tue,  2 Jun 2026 00:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hyv+KuSC";
	dkim-atps=neutral
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F2E10EA93
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 00:20:08 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-59d7db12342so735766e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780359608; x=1780964408;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmXuTGfu5wEdyKtowpHZkgr+34efjdZlBIcISUzAgh4=;
 b=Hyv+KuSCFqPD106I0jEOMw6pFW/7T20jcSTpoVLO2mJvbIgQik9aTwDMrw75wG+cUu
 ASlVfkD3j5gk39ldJKS/bwKs9xXAgD0fNh47gsj3R8XRh2zqX9JvYgZj7GOjiE+lwpYx
 lmKI/h7xqLcRLL38Vkt6zoDBAtqlawVhnNKA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780359608; x=1780964408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmXuTGfu5wEdyKtowpHZkgr+34efjdZlBIcISUzAgh4=;
 b=Wxe7mPJJQ6u8gyR21SLGGRBMofvetGkoYiEpfZmwTWHn3ywz8mN2K4o08s82YkaGwg
 9tLjsQGMuwXmnj9jhU0lyMBkZcLw0++oMiOpEgACUMgN31S/8OKd2jaZ58gUot1KV7b6
 fG+Iqmbcqhsu+GhYQc6XqiRd+mvlPWHTQ4IWOnSrEU6VxzKNISwS7kh7yqW8F681xGLD
 XzttooWZy+EUrliZN/CSUaPso3bkflh/F+ME+HXqH5JqmkV9eBfS0L0jBExgjEG1Lan5
 /3hEZd26uvKTjxHJkwAI9gyZ7o2dkN4B2PjFlh9/YLovxNzsy1XcaoBvUZTFHJQ8nIf6
 tMaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JZ0hAfmQG1A+lubrSD1FS9riFSMKsXVUmRC3XdECFiEZQmNc/8UohXGur+g0DkIsTiQqfph5D5nM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaXTSZmS4FAfcmjHt/NE4C7mZJ/odkC/a1anvPQrYlsGPPZ5SL
 9IWWmOMijwY6CyjZHTE1He9jx6R9bB2N+yCdkWTjRUWskfw94WIp9KzKxQYIc9/vhZGosEKelg/
 Ij/s=
X-Gm-Gg: Acq92OGyaf+ASvs5m3fFwcB7+YYzPUwYZE850owIPt6X3+wigxGfa2fx+BUvHf5A8gC
 3fDfnM84l+H8WSaJqrr1AERKFeNr3HWP602ngq8DMHb8fxg2axBxGMcJ+Lo2nAmPU4yppSY5FWe
 kmTHtUUmxStftfEMKzPqGpLJjDXR75ePtRtWtIdZqMzMcuBADFoUEPvROAElT7MEltx4OMNa8G6
 CVlqBdRmnnjGa+Tre/XaFsdhtckOYelhWpkiM0rzFe9FPNZE4yZ0e6AC+9JZTXW7afEzxgEUfcG
 qZZVBiY0wkw3YKogCSjfWwXwA+/kk0ejQYVGenzuT2zm4D/eCROymgRl6aa8UtiEQP9iK4+ygE/
 aUgYDj2riof8GoL3Gbsc3PeMtHT7vYF7Z3ZVkLrZBJJ/EBDv5TZYwIUSqSx3IAnIOA0T5f/K7t4
 u2iinCwy/mruwJr9Qw/E0T4N7kBxSOJsRudJBNY4sBULoygTYzjLk3EDxXJrVh9Zu/2ujNbXg2
X-Received: by 2002:a05:6122:d21:b0:575:38d3:7c8a with SMTP id
 71dfb90a1353d-59bf9084d54mr7291551e0c.2.1780359607749; 
 Mon, 01 Jun 2026 17:20:07 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com.
 [209.85.222.50]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-599d4754259sm8700612e0c.7.2026.06.01.17.20.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 17:20:05 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-9617940274bso3290097241.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:20:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/du3uqU7F33zHiQXxjYCnwuTYAr4WaYK+tkOBLb2TPuyokFITA71vupKyZZMibOaV835eb9Jm97Qs=@lists.freedesktop.org
X-Received: by 2002:a05:6102:374e:b0:631:4580:6a42 with SMTP id
 ada2fe7eead31-6c69a5e9bc6mr5836330137.22.1780359604695; Mon, 01 Jun 2026
 17:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-42-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-42-875d828d31bc@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 1 Jun 2026 17:19:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDjp99TYtSAQ5CEN+SjdmXUMNsqj-NA28HGE2hP83_QA@mail.gmail.com>
X-Gm-Features: AVHnY4JLfCVUg8Y3HWpxeX4g74jfT92G3YrU_mYeqCLRpk_-oqaIxYc96v0LfJ8
Message-ID: <CAD=FV=XDjp99TYtSAQ5CEN+SjdmXUMNsqj-NA28HGE2hP83_QA@mail.gmail.com>
Subject: Re: [PATCH 42/76] drm/bridge: ti-sn65dsi86: Switch to
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

On Sat, May 30, 2026 at 7:02=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
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
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Douglas Anderson <dianders@chromium.org>
