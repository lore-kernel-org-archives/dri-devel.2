Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C5606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=bg0D7itP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A9910E1A6;
	Thu,  5 Nov 2026 12:25:00 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE82710E1A6
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 12:24:53 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cdb2dfcca94so773108a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 04:24:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793881493; cv=none;
 d=google.com; s=arc-20260327;
 b=HfIRQRWH2odH0Slhsl51tAh9ZDPJLMMv3k01VVnDAD39V/+Drwl9Kr1Mmsxv8dg8ad
 8JlQ8ZQiC+O39pkNfei27vBocCtCxrOveVBDVPFGT+V7vLo0aiTZS7TbU8gE0M+Ym0EC
 9/grsxWa3g93SNhf8dDqxv1zMbsZ5f5h/oOwr79/579oHzwuhcCJh6rHNgXXST2PP53/
 vUuqGaIuMFjHEUNdpnRkbUQ5Nkw+78xESYIkWrVeRUpANky53NCD2wGf/Oe9crZvaCj+
 q2XX8Xj3Oclw2Qj2p3CS6sPvDGyLHLL9I3ceWSc1sw8zM7olu8uEz9TDoXxGoJJxMng7
 PyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fwDskA9fWTX9sBCyIzGNiSQQNIOQGfJ8qP89spP3R4A=;
 fh=19ONTKW+xODB2U1Y5YU9+cCGVCsAsobKIZoeBuTSWqM=;
 b=pW6TnjzIJFbBCpC5VLngIhd4pOewpb62pzB849HmKURnPWu/Fx5WIZ2ju1Z7q3hqLf
 O/Ds39S5coqZccWywnPgxsSeIBcL6Os8Emol1QhgVAXNyCYx0P/JpRQF/hf12VqczUZn
 QTd07wxSBkwMCLOqr+1yy6m/k4dKvpoSmaDbxcIwDdi8txWZ/IEUU2tmv+24jfU+fNi1
 uk0JXhWeHUz1983n62ZazXkIr0M9lS29OuOC9Qq/WSVGxFvtwSPdCJdMmLkFd1fOBPvm
 GfIZBRT4nPJTN0n7OG+Aa5NfeSeF8jrWapRXDDLOnWXbzWhPfVPQyvRNRYQpTWVzIaJC
 WV9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793881493; x=1794486293;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fwDskA9fWTX9sBCyIzGNiSQQNIOQGfJ8qP89spP3R4A=;
 b=bg0D7itPnJaI1PpNCFNLL6y9MhTRGK5DNu/GPje1nx5HQFJIgpYD4V2T9dX/Xap8Bd
 CkaA7EZi0ElTEuBSIj/ZLr23hcu0H+fJ4Pz/AdXHC7tTU3XHsKXYujcrWLTOzqysSWMe
 1NGfZt3GBQJcA4HWrsUoHVHLkuXSVkCUXpUFk21zOAXB6rmYVr9hWUD8m6UOMX2EPk3K
 /YxQ89q5j7inXAr/TN7Jk3hdfVsGG0BdwKxUWkk45GXGGqrb18150Ng02sBM5VyYSfWX
 ZSQdtZsPfvN/EcQ1yuyNWuoyuTSn9NyOQzA8wvksd5E5Bt0zpMwb20vr7LM0Le2aOLJR
 TfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793881493; x=1794486293;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fwDskA9fWTX9sBCyIzGNiSQQNIOQGfJ8qP89spP3R4A=;
 b=XDAqN3l+MgXfpVBfzzHUWCNqBk4lXH1ksvSEnf/jqtMR4L2zNtWbkxvPcNv9rYJHbx
 KLqOYwVJ+ybRc2UV23M7NgwoM8RYAc9uB6a8xA70edSF+74arbr1NOgZjEWficesHZY2
 Hyw641KkF1r8Uf2/WV03Rta9y5tx0itV3vGCf9HaGeJueL+X8lQLMaXnFacgUduwigi7
 wKfpCVxvHLlKw9cdovmaCB1ntfehcj3llFkInMr1ReOivzJfEs6DQ/DkjxFtzeYh2n+z
 XTbz8/vvvzKyvoQ0p4CahXbuDUPFOVYnoEzSXvjPDZGCaOgeMUxrVaFCfajsmmQIUMRo
 7/MQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBynkn2YGCyAZNS/4cttHnLto39yBRUTvU6B4yv4RY9PPFAbrGeNBf616XFGsdtfyjSll1jVcaVtwWw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9c5SjM1MfFLvmkmrSnUXdvHSWV/6KGFvbWPessYq68/kvMGUZ8
 VFiJt6UKpwFf3SLUOkLJUqiB90lHUV8X0i3MhbEQyZok9ZnnmO8C3NopwzgfYCKlCNpVwkkBU9E
 +ECl35O78x12BivagDfw24RLD6qF1kMB/xTgOWnpYeg==
X-Gm-Gg: AYBFou0oVomDC/5wMxEGik9sd71KMYZGGal6tVNu4mBCpmlN1mAEG3+1FSCkCDZE3Yx
 AB8ViKfc105KY/cvbFoqR9ybliDr9XiLTRA4dtUuR7+xA+jssG0I2iVgueDw+k+/wJGlqVZiXs6
 0/T7GHZlYrwnBSZfhQ7LZyf8LXoH/xKorx5TZMN4qAz/GeIs9toxGCjOKM54RbzZGlndHSPrKNW
 wUSfKFRlyR6ZQoXJ+xd/PSzHpV1duQ/2uz8BAI7i8cWJXPSNqP7FOMvYhB3a2bEyBcFqpQsP3oK
 ujdHZsVlSFrfkE2AdGze5apmFU2lcdgNIVdSa4gjGMi8lLJVLGd4z904rV1l8zQv8IxtIVJzT+o
 uw6cbds2HluyIpOF92sSs7gy/yrkxAzIMmOhE
X-Received: by 2002:a17:90b:5485:b0:3ad:c482:ae9a with SMTP id
 98e67ed59e1d1-3ae8957cc71mr15827995a91.1.1793881493387; Thu, 05 Nov 2026
 04:24:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
 <20261105-dw-hdmi-qp-yuv-v6-4-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-4-1bb63ef5766e@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Nov 2026 12:24:41 +0000
X-Gm-Features: AclHuK9ClbYY9N6f31xMjtm_H95iii7gcZZZTGs_rA5ccUrhMgtzVapBrsI3_h4
Message-ID: <CAPj87rOgPMc4_nvVj+aHK7qUEQBXCMa4OUHHC=GyYzr2Ls_Wag@mail.gmail.com>
Subject: Re: [PATCH v6 04/15] drm/rockchip: vop2: Balance state on
 atomic_enable() error paths
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Igor Paunovic <royalnet026@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 5 Nov 2026 at 01:01, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> vop2_crtc_atomic_enable() prepares vp->dclk and, for the first CRTC,
> calls vop2_enable(), incrementing the shared vop2->enable_count before
> programming VOP2 registers.  Two later failure points return early with
> only vop2_unlock(), leaking the dclk prepare, the enable_count
> increment, and the core clocks / PM runtime reference from
> vop2_enable().
>
> Since the disable path decrements enable_count unconditionally, the
> leaked increment skews the count, causing an underflow or premature
> shutdown of core clocks and PM runtime while another CRTC is active.
>
> Moreover, cleaning up on the enable error paths alone is insufficient.
> A CRTC whose atomic_enable() bailed is still committed as active, so
> vop2_crtc_atomic_disable() still runs its full teardown, releasing the
> same dclk prepare and enable_count a second time, thus underflowing both
> counts and, where vop2_enable() ran, touching VOP registers with core
> clocks gated.
>
> Fix this by reverting exactly what was set up on failure, and track the
> per-VP bring-up state so atomic_disable() skips teardown when
> atomic_enable() never completed.  Additionally, ensure any further
> hardware programming is also skipped within the affected RPM commit
> tail, i.e. in the callbacks gated by drm_atomic_helper_commit_planes():
> vop2_crtc_atomic_begin(), vop2_plane_atomic_update{update|disable}() and
> vop2_crtc_atomic_flush().

This one is:
Acked-by: Daniel Stone <daniels@collabora.com>

I don't think it's the world's most complete fix which covers every
corner case, but on the other hand, building out the tracking
infrastructure to do that, for cases which will almost never occur in
practice, is going to make the driver pretty unmaintainable. This is
pretty much as far as I think it makes sense to go.

Cheers,
Daniel
