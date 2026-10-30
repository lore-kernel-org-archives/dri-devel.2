Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0870606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fooishbar.org header.i=@fooishbar.org header.a=rsa-sha256 header.s=google header.b=hXDBkokH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21588112777;
	Fri, 30 Oct 2026 11:44:54 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21CF5112777
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:44:48 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e9d1114320so4633775ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793360688; cv=none;
 d=google.com; s=arc-20260327;
 b=ZJeQLBOE8OoJ5g2YZMup4udQaPp7nf494UWpuv9uezQX0QQNTheDBQzBv8FCFoqEVn
 QB0mTK0v+Hsu5gQ6hHh7b/3ygKNqYDQRyaTYV4/1pRhS8vB/HbucEu6w9BH0a1m+tLKj
 6INsn5ovI/RSemUNj7hCdbnay43Wz04VBPmgQpVf/Ry9AEiO5/yRxBEKITeRRG5F/dnN
 ZsZBE1cbA2LlY5xKiiwjBbuSaqUMzkOY6Ue3fK+W+/qGFgNa6+5Gqv79uh7yh8Cm3Dop
 Y3n5hghHOvPtPlOSj92r8TXR7LsarDaLJi1v9ndUkfsPcwPFx34F8IhV2U2k6yZ/gip/
 OojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gj1ttizdUersx8xsUhnFSQQTCr6CuiJthd1Zca2e+6c=;
 fh=4Yv3lIhY0XdyAeaLwbSciVASVybOH+REsnXL8iaObxQ=;
 b=areghfkWAE81IOxM1qWH3LTKdARHSFggLintj0sO9EkKtJQTsgVQoTDYHxUxwf7GLb
 iAwFjxVtBgnc5V+8Z+FqEaWeJQixhDxSyQXsBKzbs+5mWrREy7SLPLvNvb0wf5x5HfxV
 moLzUmYfLSKyqCyVZ0bcdLexla3PNPSKJRtiuoR35uIIgYTy6KAY+QpmgbqvQSrfD/iv
 3NCC73oCjEbV7vt3LdtLAn41+HSgX3zwnG0mO9CW4UXKNrjggEihCewIET7moSmx8byh
 vf74MkeH00H+UGUEI0Fi9WgPegjRE72dRZ8XKcGp19E3CphlCCh2mif7oWNvLSZM/E37
 XDGQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1793360688; x=1793965488;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gj1ttizdUersx8xsUhnFSQQTCr6CuiJthd1Zca2e+6c=;
 b=hXDBkokHQUMkTt9GjishVfNXfNVgr1S+BMSTLyJScbQ799yBY0WNt60b6xSAg3FI56
 S6PgPjyO+yAG3C84osmF32OYpvfNQQxoTYA3zK0eoCCgvB8BJZ5jGIiu9vn8RHBn6AEj
 yRDKEJeE6+fi1Y4ovMQ/YIA1p/63tDVDq6hwh4g3r/zN7BiA2OZRLYUzJkEO2DC+gs6f
 lxjVq/yViwETofaevFVve6gP067IiY4+GC/bVLGzXZya+LKC0odAoAHzCYM+sAAkEeAO
 PXswl0PjDNsmatKyIeZ3cxA+aEU22iLvBn3F8vemkaaSxf4Xwqncg+q7ssFA2I5HKo9s
 jGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793360688; x=1793965488;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gj1ttizdUersx8xsUhnFSQQTCr6CuiJthd1Zca2e+6c=;
 b=N87F98+mE063DDpXgQkjaabq2IHzzNa/mT9Afyy+djCDl2AUwu5ZuK9nGoRqbNW6JF
 KRElFcXXhjUpoMzyu33HU5+gM82uOmorDn+eCtykjKXnjQRnSWIpLnBwupAKrCdmjRf7
 aBJ7cZLhTj22QQNusFhsDFnln1YCoWrcu45XOC/FFJbubNRms6yAmKf62uHHWZx95X8M
 boYG2D8TEmNpzyqyrZznMD2sQeqFWR7QtoXRIvjq6FhNhDV5xVehxdUaLqzKduPIUGNt
 pzQXBhcW/kPN6HMQqqaFFqRecjKYlJ6E3eHZ2mkVYBsS0Toh6/sI2+279op7RNUB3JEO
 Symw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6YDAa4meY+/B1+aDfeGpn7U/jvWuAJIjojyYT3fpqupnnRviqaCSmHsnX0EGR3Jw74ztMf5b28m0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIj+xMPkMaw1qMf5sIxNcvlyX34oCH7Uw1EKhR8uU7/OxzVPPZu
 1Rg3hFHhJdVmWg0o4MoIJ3Irm2njsM5iKdF37KdqS3+ast5iKpAFcb+H3zJdP0+jDEjlAXP7m+a
 erTrIYSYN5sqDy3/zUiIFeU3q46gfAiwBuhgSyUvdpw==
X-Gm-Gg: AYBFou3U9q1C4RQlJV3DfRPBWjn2a+tY8TsYfgJZ6Rmz2/2efAp0S2VTwphVoUKZQMS
 xmqUYErtcZ9Uz7R7BrgnWcqLgCgMZGooHHSB1jJGhi/+bNBmQ/BQS9T01TzxGxTqjt6wGLASW90
 q0UHHTym/qWapsMYp3FDpl9XLnxiBcLe0JQHN1wHCR6djmWKZBoJtz1P44YzqFWcLb9MFfQEC1d
 Ti+Cwc1rRZ2rXT2WlMa2yHnd2uHdVy5ZZbDLHZx3ICE8393Yg/+LySXpzPMPkqnoDMEsNlAvwxQ
 JVn0nYTSK66t0vL/2EfkpXrdpoTioLiuLcqeFVJ64+kFelZxbQQ/TsuYRUA1HcLBKcFiJazzb91
 LA81uIHxeRCOqUcV+d7uMg6e0B2FHDpJMQIK5
X-Received: by 2002:a17:903:37ce:b0:2e9:6333:fbb7 with SMTP id
 d9443c01a7336-2eb364f49fcmr22277985ad.51.1793360687631; Fri, 30 Oct 2026
 04:44:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-9-6fab0fe43a9b@collabora.com>
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-9-6fab0fe43a9b@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 30 Oct 2026 11:44:36 +0000
X-Gm-Features: AclHuK-Q06xdaUmiDGoTsq9LRujvtZmp-FKJhNsOOxfBrNNarZ1Qbmr7JOv-ovk
Message-ID: <CAPj87rPEz=Y+dZayouddZRn2ZHSVNk9BAjBqz34PJyjDRba5=Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] drm/rockchip: vop2: Consolidate HDMI PHY PLL
 clock parent switch
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com, 
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
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

On Tue, 13 Oct 2026 at 23:51, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
> +                       if (!vp->dclk_src)
> +                               vp->dclk_src = clk_get_parent(vp->dclk);

Why not do this at init, where we setup the rest of our clock tree?

The rest is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
