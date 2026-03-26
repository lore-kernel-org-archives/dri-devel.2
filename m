Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC93106F30A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F2F10E973;
	Thu, 26 Mar 2026 09:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DmM4/80D";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63FA10EA13
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:37 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so631388f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515756; x=1775120556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uDgwVygqNPr9RHXvzVoREYuOBHGBAMwYlaa7aLlgho=;
 b=DmM4/80DJqXeN94p63OJGM+Y8VgG3DmUue2uUwk8zSNhaGXoTGy3qD/gELVHOUP150
 uciwcvH+ba6/XSZigvT4lpfxyBuQNYvCrQtPE4XoqD5Q+5IUg+zr2l3IpiVe+vcdKvFh
 LDvyikxqQbtMO5H1DS3H5LLf5bkkjlR9Nd041R9/Dktp/54CUCjfqeJ07uWtxlxIXCKq
 TPAHO1YywmaBLVMtGQEL202yKfgCbZRzS+KdamUlnYymUZ4GTkRwgy3IrPWxyP3xGSj9
 Ej0mrRUgBfLAKNNF14SrwFvgwdeqvickq/zzbkvnambL4iL3uCrCIihbhNcPcHpmaqlL
 dbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515756; x=1775120556;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+uDgwVygqNPr9RHXvzVoREYuOBHGBAMwYlaa7aLlgho=;
 b=bcxa4LaK2RriW+vU9gF2Wl7i4X6Qnsd+rqakPzgA6S15l1yNw3BmvfrXSun5bMnwib
 hqqikVc9F9ttt80H+Xpcw2yx7UcAYB6E0t8gjJ+p90F32a5WoEDZHR27jHH7PCN/Q5Hb
 KC+WXj0WiZZnZXrfCbFHppG+LNgVZirQrzYj4M53EQ6zfEZtpPsWE2/nCBcjN4B4ccIB
 eYfx5+Zp8WHXDo6zk6b/IyZEe56mXpxJjmqBdT47wUJDjHhtS6Txd7lxSFmJmyIg0lnB
 5A5QGrIUA3KCV0dqL/msxv6J0Z8ctNTJORTpoG8BdJ3QJmSoaq4GGsq+DSGDjw/2gKUX
 lzGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxkVrzGxF9TTYTioR2pBykmsJ21uMXeHnBAcgSRfPaNEwrZcTqz3LqcNGn5egttlRB6BC9/Hk5szI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTWjzRzajKqrhm2HB3UU/qY23xNxsQxbme9oCZmNdmfgLR3yPJ
 imBtwIsiFP6jcnoQ/kRM+o2f/Et4N6N071lA1zJAKUIHoGIerE1ShqNj0J9HlOnr46M=
X-Gm-Gg: ATEYQzyH62R8xitgV5fIk3uocNe+zRLRPb+n3GffRgz3Jr/6wp/7/hLCJkqSjhB3hXA
 7vIzgueJ5Qm7SnO4WYp5Prj5RRrDNPYpHLV5BSUI4muduHaJxU/4BSKXh5wq10Ybn7ha1PtsAVT
 udNYlzq+qyNaukuT2cQwOc9PT3WPlsAXqPcsVI3pYY3Mm6S06YHqCA5PiCDmT0B+vt+yZ5Arfk1
 bDDXpHpI+Wa/aMCU1yTeZJUbq5l+CntxHqIhk0PnKgk9QakPr24S3oowGiOtpm1GJ14FnsdnNNe
 8gtTJeOY9xr0IUigvgVD+PWODWeDC7fMavGRM3o6p159W0oPxlY/fGHJiDBxgN863spuBhpLjDH
 W78wag/186z+JRbEhwc0y39kWAcQvnda0t0AbShmJZkm3K6saYo7anpziknLx+KFC0x8dOrUwuu
 rOL+UUV7FEWeexfyW4QukXzap1ZzMbzRjfTRlVgIi2BvSb
X-Received: by 2002:a05:6000:1ac7:b0:439:b440:b8b5 with SMTP id
 ffacd0b85a97d-43b889f5b49mr9488507f8f.43.1774515756148; 
 Thu, 26 Mar 2026 02:02:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-kernel@vger.kernel.org, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-amarula@amarulasolutions.com, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
References: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v5 0/4] drm/panel: ilitek-ili9806e: add Rocktech
 RK050HR345-CT106A support
Message-Id: <177451575531.103892.1628569309866054058.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 18 Mar 2026 08:32:49 +0100, Dario Binacchi wrote:
> This series extends the Ilitek ILI9806E panel driver to support the
> Rocktech RK050HR345-CT106A model via SPI.
> 
> To achieve this, the current driver (previously restricted to DSI) is
> refactored to support both DSI and SPI variants independently.
> 
> The series includes:
>  - A refactoring of the existing driver and Kconfig to support
>    multiple buses.
>  - DT binding documentation for the Rocktech RK050HR345-CT106A.
>  - The implementation of the SPI-based driver for the Rocktech panel.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] drm/panel: ilitek-ili9806e: rename to specific DSI driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3bdd847ac2278d675e86000fced794fd61159974
[2/4] drm/panel: ilitek-ili9806e: split core and DSI logic
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0efa7924243e461a643a44904653f200bfd40ee0
[3/4] dt-bindings: ili9806e: add Rocktech RK050HR345-CT106A display
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7cad20e339ea0493fad76db27e4675b2a9629e7c
[4/4] drm/panel: ilitek-ili9806e: add Rocktech RK050HR345-CT106A SPI panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a05f291175f2cc01fa95c29dba4493cd3f8de594

-- 
Neil

