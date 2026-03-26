Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F69106F30C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4A110EA43;
	Thu, 26 Mar 2026 09:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tENTwhE5";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22AB10EA13
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:42 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b932fe2e1a7so82596766b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515761; x=1775120561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXPKOAWpcR9xHk9hAzrUFCp6rLb1/uw3dh+uChYT9mc=;
 b=tENTwhE5XvPZ/x8KkVqhLBYd3woE6/tgL9Jd7jiGJHp/byokQsUSwkjKSWJXLlJSBt
 0LBFzkKBhB2U2k/Rx0+h6YjBtburKCzqv8WsvYVHZ0CTi7dhP4OUP9Ipijt7y9hMB1fQ
 gXTwcQLfv5gYEbwnLg+ko/LS73M7nXFra/g9iudeMK6NRIQFCTwIC4/idMZ06GnSHPIu
 h6H8I+BznMd5uR4+f07tTF9o5Ah/0oZ9Y18WGeSmnqoKgM+BIIgZjFwdLeGR/cA7Utq4
 SNd7Gqah5jkvRYbGiCVSdkfSLhWFgL7GN2Rc0CT5duhbwtAoiR1XW1cy6T8bKz48vzNL
 RPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515761; x=1775120561;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NXPKOAWpcR9xHk9hAzrUFCp6rLb1/uw3dh+uChYT9mc=;
 b=au8D8PPRmnFE7OYMhZbkP6DR/lV3C+xcoci3GwNj8ywq+MSSsz/gCcEHQ4xJSxjV8E
 a3NfbHvf5U6WG2e3Fl2zzwZ/VZWNKtkzoCZHGzZclzQdMu6c4mDxF/DJR7fOM/gH2ReX
 T+X4P1NyYM0LNvETQ4GuKUawjyBkH3LGWLlJxSKouB25TXAdgJbfq6XjaAq+mAyhyYRI
 bAkpElJyiEJ3uP98Qz55/dV04tuqORDDlzMEb4kvP4dEewXEwnZM3rsxaqbfKk1yOpE5
 IVgZYNQBvQT6Y/76CjwADC7YIxOWuFGmziGt5jCJUoK33ktvql5q318xLE6Y6T1T9ROa
 wsMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0MDn8rPzgw9Est+pjDGsRztfR6dpTafWCzLDWCyS+ulC/XnROrdPnn9VnqjZ6lRct+n7hbP/XIjY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2bfG2YRdwrZJO+jJY6V4+ctob6f3WOmgGQgkTYjJSjuwct7Hf
 0KZfW6jrEnLf8bMXOSGA22YeJB07XrR5W8JOUG3vgDWL81Q3AVlrG+LiVJAoPosAqYQ=
X-Gm-Gg: ATEYQzzT964WEMbLP00/uYGSEl6FxhL4o8rOrYeb370ioK0rRliTRKUnE0t5lS0bZad
 x0DSM8tGrtU4mZ0UUkgCMc+xnxbNeBgUjdJ/U8SHACkwbANViDnqQSuGwEjG2i/MAveTxgOs8NY
 IQX9cfpY/xCYn4lT7ZDOsTLkFSJ9jphyjuauC0pCJunFMM2jo+9UDz7iLHJhjgTdKphY8uQeCKQ
 kzVnoACQLuEgGgC5AqOwnxggZUSH0F00UbYUYHyS1HxY+y31ZC6GPZ+s7z49az4tNSAyEDbTwmu
 oQjHnW1z+JeYND/j+mX0KQZdLWjd/5H/GbvvK7w+vUcVQoXt4I/t9zH8ItA8bI0zGAEJsCZMQT7
 2c5i0e2vAub8mEo1nsgWi+8qpTvJDwvIurvu8agkgwamrzbA5SCa8/3Otna+NqqNk7jeZqpJN40
 qK5jbdwKKNhVmBgSwQmEssuCR7Xt6iumJxLmCviAia4Uzj
X-Received: by 2002:a17:906:e097:b0:b97:ba90:edb2 with SMTP id
 a640c23a62f3a-b9a599a5322mr343969666b.50.1774515760204; 
 Thu, 26 Mar 2026 02:02:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Kamil_Go=C5=82da?= <kamil.golda@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Yedaya Katsman <yedaya.ka@gmail.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 David Heidelberg <david@ixit.cz>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260320-panel-patches-v7-0-3eaefc4b3878@gmail.com>
References: <20260320-panel-patches-v7-0-3eaefc4b3878@gmail.com>
Subject: Re: (subset) [PATCH v7 0/3] Add support for the Samsung S6E8FC0
 DSI and M1906F9 display panel
Message-Id: <177451575929.103892.7506565955077481700.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:39 +0100
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

On Fri, 20 Mar 2026 16:41:37 +0200, Yedaya Katsman wrote:
> This adds a driver to support the Samsung S6E8FC0 DSI controller with the
> M1906F9 display panel found in Xiaomi Mi A3 (xiaomi-laurel). The driver is
> generated using linux-mdss-dsi-panel-driver-generator[0].
> 
> The mdss reset dependency makes the screen work more reliably.
> 
> [0]: https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
> Original tree with patches: https://gitlab.postmarketos.org/SzczurekYT/linux/-/tree/laurel
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] dt-bindings: display: panel: Add Samsung S6E8FC0-M1906F9
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f4693b88bc730cddc6d69f6f11b64e6d93a8e373
[2/3] drm: panel: Add Samsung S6E8FC0 DSI controller for M1906F9 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/49837b6babe71fac84cda2a0d3cf9c085bf3a2f9

-- 
Neil

