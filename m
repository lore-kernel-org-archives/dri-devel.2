Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943D0CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 19:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B6C11244E;
	Fri, 29 May 2026 19:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jmiekor4";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA1711244E
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 19:23:13 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so63940565e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780082592; x=1780687392; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ndz1hoCdDpCMZ0CBl4eGMfc4kRE7BfbvXniyLhRZSE4=;
 b=jmiekor4cxafIRupc++3dtqX5R3t0B+imjSI+gjPljzS9vGOM7LkzwOiCP7Dyteo7x
 RWPxHRlRFkzCBhTtGHs5i+OoFrx/JbkAqpiHGK0E4xg5E9ZNh3xgWbMjypos0ZrmD0nc
 +Qp/ICmCi+IsiCmH+O7qo4FBRC4QLYOxyp//cwTCYb+36P8vV0roMkWnvfE5YFSibGmE
 1qFQUKREtTTm6hyDNZoJDfM2phXrkJnfilZm4I/VOWAbc+DfRi74eNhl571nHs/K69EM
 Jp34rgLnl1zEHHTeVg7vBgUAcwlNmHA5haM0W52ZM0dSWbMPre9tZxH1r9r/aPowGJg4
 hGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780082592; x=1780687392;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ndz1hoCdDpCMZ0CBl4eGMfc4kRE7BfbvXniyLhRZSE4=;
 b=WkUl3Jn9mHHGJ4rpAfcFnHuvJLiMLHWghyWcGnNE92GHVuQDQru2Mu1u9vkIlwAbZp
 GlhVL9H/5dMUE20oN+7P8zXOEgD20A/pcJJj1N6iu2Cv7F0LLlzXOHEHcVqi7raFz26/
 oV/8loCvYEzA6xIhujkOFgUhMpkTkxDkYmO854zZHQUNhe6tdX3zF+YuQZvEnwfcC6m5
 FWoyWfbswr+Yryf9Ylj5CQW8xjdmCdiv5YRR7tqrAjumLTtdrpK7s3XcGO005N+9iRsm
 EmfPygD7WFF1z5v66T+30HXk7EmSjH6tAyAih9W3MK+rZ6c46qQ1jIykkIKyZoHgBApe
 pxDg==
X-Gm-Message-State: AOJu0YzNECHZBnCL8MhrP0u4pqpsFA8I2tejq0tsibOGZSfgq74GzowA
 vQZuBsWe2p0oUg9tLCNBWE1vFdDFUIlA1btlQXt4NLZKwASFfrYgw8fxR34cD9WSlqk=
X-Gm-Gg: Acq92OFmPrOfPM/QOVvPWQwSM+TVob1mSY2CofzULIy2Q3V/VeiW5VW6i6eUwiaGD1P
 +MKNTHhTitWsM6MWp9UMBJz3rg531RqjlWmQXlrnWN6eLVDUjIMAlQ4D0gPKZfkVcNfc60dKKMK
 dGEKxaV8kWrT9TlzkbuNyLHA0sz5BWIVReqpC4G8bk21Sq6bPPUyF1PQGqkCcZRAfarXKj4Fc/q
 +jhw7y54uMpUJo9/iyIj7aoKtVh5vZnTUnGkoolQ8eClkFUBXEUwV3Id6dOOYbaI1hYYoOJjHBv
 4oPef9aZ65l6daAfOvoYbowUeJb3jzW1j457RUCKICO2N28iITvVBnCLjTdF1sncknBiEwQCHfw
 7SkHmUHVBeTvZ4FQxMWTMxRzvvMgIs3LwUwirkmxSUJkfS6HTC9D5m8JN35MQ0rpOkA9rZX9jpP
 zaUKa83YbPO/0wNLSi+2itxBSmz+JevkNWplUnhbmIHwMPpIZ6ShvCM7o=
X-Received: by 2002:a05:600c:8b6c:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-490a292fba3mr15871725e9.18.1780082592072; 
 Fri, 29 May 2026 12:23:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm28692545e9.9.2026.05.29.12.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:23:11 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
Date: Fri, 29 May 2026 21:23:07 +0200
Message-Id: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvnGWoC/5XPwU7EIBAG4FfZcHYMDFCoJ9/DeKB0uou6pYHa2
 Gz67sJ6cM1e6vFP/nz/zIVlSoEyezpcWKIl5BDHEvTDgfmTG48EoS+ZIceGK7Qwxyl4yGfbaA5
 udSNFmKJ/pxkyQl6N0RYkt4LIDIJQs0JNiYbwdZ15ef3J+bN7Iz9XuzZOIc8xrdc7FlF7/5xcB
 HDg3rme9NB3Ep8/wuhSfIzpyOrmgjeq5DtVLGr9RvFG8Z7aO1X+qlq0O1VZVPJWtKrrvLX6TlU
 3Koqdqiqqkd5IbIQm5f6o27Z9A+OP9kDtAQAA
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hyz4a9KfkQdq6GF9UiDXxz4gzafyVLqjGocQwFon4KY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqGeedDSAmaxEWFCz8CYt6xxzZKkdzED+A2UmDL8D2
 nVNNL4CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCahnnnQAKCRB33NvayMhJ0dn9D/
 sE/AU77M7s/TwXuyqD/Mj1TYB7fXk4pCI+bWHvo+AEKx3QpoHQ6cLP/EZCUtdwYRsuWCFDI8afjfJr
 9psSKOo2Fly28TOIETBHkajm6CHMHh+e0Pb2biwVuUl00Rp5+KVHNMvogZg/kfNqh88baJPXGIwQNJ
 PCXJr7FP/tFpp5hFcZbacugiKvc2nohC61M84GNKpwgmGUzkbDNYgY4MEzgIj9Ww4PMai1Fc5AWxm4
 HINbalshfz5hR1omdn90hXK9F6+FOGEfKajDmcG5EhNacQlVON/10by2hKHG55MC6C4ofHsl4ApSrj
 IyG+wbtMoZmwG3tVi+obY4D0GAdQ37+JRqAnTA+9gJGSXJ8nZaYrp1+ID4G1Kd8u4i1nRIUjrjYS0L
 yCtbu82jAH8qXG8eUBOyRnzWr/Uy7h7oCiuZTzWiI0hpcNx1IOv4rIp4vC1F1IXx8dTU7GVgPCihZT
 YSQFpSGbU1VISH8Xu+7RuP3xfHdoCH0pEyTn4Oucd5bjEaBHXMAuCdAFWRy638S7Nk3/c5Qa8I4zvJ
 LkDeVo1whnBmBUd2uqtF7pRLAP5zMJuzHS4SZf+v6wYCZ5N4j91OcxQ45vK2miY3RgxDB2bvX2ACWj
 XWi0WdtUHPd/1OPlw+z7BRpTJi2O95IlMYgircSQ2I1AB/eP9cr8dWAGU42w==
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
Changes in v5:
- Rename vddio to vdd and make it optional in bindings
- Kept the bindings review since the change is trivial
- Link to v4: https://patch.msgid.link/20260521-topic-sm8650-ayaneo-pocket-s2-sy7758-v4-0-73c732615e4a@linaro.org

Changes in v4:
- Fixed Kconfig typo
- Remove again unused macros
- Added delay.h include
- Link to v3: https://patch.msgid.link/20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org

Changes in v3:
- Dropped unused macros
- Added second autho entry to match header and commit message
- Move my signof at the end
- Switched to flseep()
- Link to v2: https://patch.msgid.link/20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org

Changes in v2:
- Fixed bindings subject and removed "|"
- Added review tag
- Added higher delay before reading ID from HW (100us was too short)
- Removed probe defer if i2c read fails
- Link to v1: https://patch.msgid.link/20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org

---
KancyJoe (1):
      backlight: Add SY7758 6-channel High Efficiency LED Driver support

Neil Armstrong (1):
      dt-bindings: leds: backlight: document the SY7758 6-channel High Efficiency LED Driver

 .../bindings/leds/backlight/silergy,sy7758.yaml    |  52 +++++
 drivers/video/backlight/Kconfig                    |   8 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sy7758.c                   | 259 +++++++++++++++++++++
 4 files changed, 320 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

