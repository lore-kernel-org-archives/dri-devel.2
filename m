Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09970FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3EC10ECFA;
	Tue, 28 Apr 2026 13:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VpN4TfL5";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7EF510ECFA
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:59:15 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so195893855e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777384754; x=1777989554; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=udhA8FYIygeULMf2spSguXELNb0LFsPfqpfV0jbfFB0=;
 b=VpN4TfL5bW6NuAF5RWUhJh+v+XHI0YUqSSka7nhjmx+KtbCEiM1sIajpjldL5eVdYW
 FTjs0b2im3YObR5YfOfY1cfTM6qIO9D/XXY/T0vLrb5lNV0FRM3B4eoOGwYgkz3Lbf9z
 g9g/rWxWs6UEXc/nYrkRJoZ8uvXuGIS0aMYnijnA3sG05w+6eH7KJccHsAwrdzh2a8Z7
 2slqu2GU77fwlQtuHZQZoexVpfOXPOpbUKQEnAzWdy08w3dEHoRDvQCoGaJqNmCQ+aPt
 vopR3d62Lrp0XJWh3SNP5u9bxnXjYPeeGWDzHWRlnwke3kwbR24u9ouD2qANa36gUcfe
 rO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777384754; x=1777989554;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udhA8FYIygeULMf2spSguXELNb0LFsPfqpfV0jbfFB0=;
 b=NURkkCB4x2I5ubnqN2AGScA3XKcnO0zawdJ5D9BMJXqD/JYcrjE9OU53f1BXdeAtwG
 BZQpIbYSthK6ubIm50oEHoqbT4pORofFZibxT6dIer/NCLeEyCoPPGX4D3ODIoR5fY+M
 ebMCH1Gw+J4qkt1SdTj3xnPkzjkwzamtophIdkghgEIkhrH76UbXmRZKEQ51kDJ9xeF5
 7clP3e8xmYI1+tqZ+TbbO/AMaShzYq0/BPmMP9AZNzdlZYS8hfT/dgowdzDghvdeubH9
 9ja1lC50C54tksPMfj0KEZTs9OSnE5/nnnEVHgWCMXJtvAXnTCLZcoqVGpLgZO9YgTJ4
 ocPQ==
X-Gm-Message-State: AOJu0Yy4Qf0dev8GPp38SNXBC/V0Z12b/8naWgyYz/nngOe8G8yY5YW1
 97yNUUkiIrWm5/JqkqtHr3DeI/7OirlcmBuhOsVn5yrsUp4S5rg9f4A9/SF+DCgfU1k=
X-Gm-Gg: AeBDiet1qyGJ0B3LDNDYcvDAzG5r2u22d4RO0wFac/3jC3aN72XJTk2Ios46HXneOwZ
 ThL8KrJVBy2octUjwoWOrP7rDtFz5eGp8ng5E4Vca8Lq3ZquHlXbAuqr+2CRQUMrspMHiVOrOOb
 hbw5iVjdSBfHsxqeWqyAQjBXFQBbUSkl9AelQCtDDmO8TMLYp3LLGtEjPvMWvxI/c/PTqGJaLLa
 //SkYYSt+Kv9R8eOtmRrLB22rkBOwckNCg18rW0ENcxSbn67BipXc0yC32EAdzXXgVK7BUF26rM
 F1SLI0x/077IQ2KstLHYw+oSHCKSHtBUvjU64qdNImOsSM9ECrVn7m26pZJvT2mEs5G/5e+gKi9
 IaDYwwFiAYwlMqSqkPKPXhYv43dksi55SfUauj5/RfH4NtVG9iCDoFWzys6h24mk1N6dUfYkSdS
 YWt8gH4/49ScUxn4oTLtp+hMXEcB0AK63VWePIPOQmAt0NE1x8vDzqSz9JXXylJZS21Q==
X-Received: by 2002:a05:600c:8b2f:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-48a77b19d6fmr55500725e9.23.1777384754118; 
 Tue, 28 Apr 2026 06:59:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773efe04sm60811155e9.12.2026.04.28.06.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:59:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
Date: Tue, 28 Apr 2026 15:59:10 +0200
Message-Id: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC698GkC/yXNQQ7CIBBA0as0s3YSQCnEqxgXiFMdjUAYNDZN7
 y7q8m3+X0CoMgnshwUqvVg4pw69GSBeQ7oQ8rkbjDKj2hmPLReOKA8/WoVhDokylhzv1FAMyuy
 c9bhVXhO5SZOx0FOl0sTv3+Zw/FuepxvF9m3Dun4AbzFq8IgAAAA=
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=928;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fStomxOM1crQBf2dh5jW011uYO0a7/MEjHDN74nHXvk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8L0vzGcnPNa1ZX01cDX2xFb+HU61fFeMMwl6DH2F
 niCN/+KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafC9LwAKCRB33NvayMhJ0S/1D/
 9IGhCG7NAXzhBOSkBWur+HPJ04e478uoCh3E5AtZa7bb7QZDxv2o5d6Ior4uxN4kmXwBkRB2xvOB9e
 ty9eMPNe2OUD5P8ldWalWQxt0ez1fe2MF5woGGODSG+CVmnx8TIjsU0QZHrIqZPyECCoeLgCewIZ1f
 ASbx1dFC6OBW3GD5O+Pt84j+a7NzC35fJX4AFr0LQPS1PBez1rnOtsiXbhuKQw5f7TvBf5ANjTSTuH
 R0h6a/Ob7RAAcnzg+BXizPUmGTSyFaSgyhGIl3kznUYZae5HwmxLRao4J8z+RoYUhIQOqB+GEvMWkK
 n/O5r5zqzfQkMqU2X9iHzADB1XGGAQon4RSO/znZjDtvMlNVN46/dJPnFSnKMlCL1jjPgnSkfsg1CJ
 SvxfH4G9LjLAu5myBS1wh9JNvzoYzveq4CReN9UqJLYLYEE507y/UCbhMD/8RmzqazWyvp8nm+3ahs
 gYhiO9UuVSMMJCXdhjIpS1NuLPUPDNdddaZOhOAXtXcBQD3kHDOSogHFBI15hLemEGX/GxOy/J2QvP
 CQIO2cC53n/Uf48FWz4leqpsmQE4z/0NuHyTXfV/SgAVyfOhKvn9TyB6oKAmSDajmDBprAwUye4Tbk
 9rvsoSN7ThYC75Xt2qIu2z5c5UmLJrkwqmRxH+fOVC0w/6fgmWKGP3qH/GWg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Implement support for the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control in the Ayaneo Pocket S2 dual-DSI panel.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
KancyJoe (1):
      backlight: Add SY7758 6-channel High Efficiency LED Driver support

Neil Armstrong (1):
      dt-bindings: regulator: document the SY7758 6-channel High Efficiency LED Driver

 .../bindings/leds/backlight/silergy,sy7758.yaml    |  53 ++++
 drivers/video/backlight/Kconfig                    |   8 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sy7758.c                   | 311 +++++++++++++++++++++
 4 files changed, 373 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

