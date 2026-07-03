Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBDFC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CBBA10F6FD;
	Fri,  3 Jul 2026 08:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M1Hso9fN";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65BAF10F6F8
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:42:26 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so2087185e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783068145; x=1783672945; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2BvWoVYKkcPj1zcFMdBoaWfsieqjtxdGGOhjIbmmoc=;
 b=M1Hso9fNjHBVb1fVuHFPKvEiQH9y7n/RsSg4wgGAfk6rhnMyrtIOZ60bMzkZ1uDKcm
 AirC5zXRckkg67rQ/Xpyo2XmcKkKae4O+tNI7kn6HSHGek542ZRWZa7uXMEIGbicVGtf
 jG8er1z/4BkjJaEuEXNcBSSeuaYyZTxy1fUUjEi/7XI6tL9KhBX+YA06lLstKbW+sRDo
 p8nVcM9a/FX/6pyM86I04uS8Bn+dBUI9X+C6tCbh50BH6BSSXiC6ItBmEiV4IIX9obIF
 kiysKGPnivnuth6cwkDYRclEBcxp3UFF5l6niy3PHMur0rSHv2RmeAS/lGFb81zGegIU
 jWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783068145; x=1783672945;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2BvWoVYKkcPj1zcFMdBoaWfsieqjtxdGGOhjIbmmoc=;
 b=CngUuvwKL6eghah9LEt9Y1VTBnKb09f4ddSqofNYkVlqTfq9Uh5LxATFVZf7UnsXwW
 477oVsVWHeYXarlyo40+6gj0JTKZHeU1ZA5ebYC1VrtsB4BztiQUb1ii5qHsNjeeAUlf
 vEiYrRiNRMG+SINY++zu/DBZ23P+RXZr306Z3wiZvfiegZnqxEyi6UgeNbM6lYNDT/bP
 HpGrbtMgjsA4B9mn/NfMeShcPlPhpE93KfUCrzXZg6QHUT+KiBDrDj6QnHDpfpV6Ig1T
 dvIH4hBJygYZTxl99IReKkI62gy4AmU6HdiOFtXfbhuWIA22ChjnigwxZSvqP3HfU1Qr
 hgmw==
X-Gm-Message-State: AOJu0Yy7vl/eTY7DgxIY7ISVRQb9K6nacf5w0z/IMPBGwbs1sGhgd7jS
 Ipjs9DJgtSvg4yrJXE/BbY0XkP1Fesh/0l5kXXoBeEDk1dK6XwqT/yiM6k5lrv20F/g=
X-Gm-Gg: AfdE7cklO88U4/lYJLOyyFVd7Y50kpr6QMJrlDSHkJQ8JjiOgQmXDM6Vic/NzCoccCx
 qdXnBS4cGoNdVOEUkEDHUAaOfWihGAa4wtGnsFnUVAWMA7cDVjPwzRhljV35BQR1ojr8DQZ3jcF
 esW6/ctlXkM8giPjkEgyRvqB6NbCowzODFFxchnATKD0/qWeai8RTo2yyvMmldZj2Mqce0muMl2
 8UTNiS7msle3ZM0gXRgnhuOIw1OW3WYjA+slBcv8diqobi5xmyyIM6s8sIWNGqbBsCmPSouevNB
 n1WajtA63lqbr2ZuYWJczHfmCNZSwm9oLvNuTPN2A7fzGoaSfR8OCvmb2IoIMTQeFBiG3Ylp09D
 37YtXDB4aDP1GnHRttjfgYgJN05CjkQ0Wp4DPcPZTLUDPYgvhDhVu+GQr7z7OBt3JLkH0tTpU54
 8KN5fJgZX3DBRdgveRwEIJaijGSabkRExNmQ==
X-Received: by 2002:a05:600c:64c6:b0:493:c337:db18 with SMTP id
 5b1f17b1804b1-493c3e135a9mr113800625e9.16.1783068144642; 
 Fri, 03 Jul 2026 01:42:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm30001575e9.4.2026.07.03.01.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:42:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Doug Anderson <dianders@chromium.org>, 
 Conor Dooley <conor.dooley@microchip.com>, KancyJoe <kancy2333@outlook.com>
In-Reply-To: <20260625-topic-sm8650-ayaneo-pocket-s2-r63419-v8-0-8570e692143e@linaro.org>
References: <20260625-topic-sm8650-ayaneo-pocket-s2-r63419-v8-0-8570e692143e@linaro.org>
Subject: Re: [PATCH v8 0/2] drm: panel: support the R63419 based dual-DSI
 video mode Display Panels
Message-Id: <178306814343.3165305.11547200028737735771.b4-ty@b4>
Date: Fri, 03 Jul 2026 10:42:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Thu, 25 Jun 2026 11:29:06 +0200, Neil Armstrong wrote:
> Add support for the Renesas 63419 based dual-DSI video mode
> Display Panels found in the Ayaneo gaming handled devices.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: document the Renesas R63419 based dual-DSI video mode Display Panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9c04ecc893f07d001e484e6c420af19a970f755c
[2/2] drm: panel: add support for the Renesas R63419 based dual-DSI video mode Display Panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1190fc8d7b8a9cebea8dcbd2e544e43990ae81d0

-- 
Neil

