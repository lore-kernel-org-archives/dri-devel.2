Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC49ECD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 12:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC6D10E0FC;
	Fri, 22 May 2026 12:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jLUG34R+";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A92310E0FC
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:51:30 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so18444995e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779454289; x=1780059089; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qITjIxKdpi1UQe1FdVWE4w1z8BRh8hFPuNNNTfo269A=;
 b=jLUG34R+kKk/EBBY+phs+6EZ3yVL6Xm1/FJ41B0Xy0V9FG5CJ+UNI18kFf8eOZKNhZ
 rrKms2N/O42nFS56A0sz0FkU1NvflCDE+YiVmf8aafqUuTj3lo0aWb/OZxV16/RS1Nww
 5dy3cquZmreEVpCpfQ79pWsvsX+xCmy5wKv1+bkFO9wbqYfi5Ets250nl9PRGVhEWVBH
 vzaNRUJCtyPU3vSzIPs1yO/8OkXvYe6x1WiQECiTV8q1uXoeVB7egPz2kYT5+bFd2Bhp
 6pTmk5qA+4OM1jO4uLdIJkH+Ct5+tDtOC98qRnYIFhpR2qOB7+Auu2Drxj+0xnocqt+h
 8etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779454289; x=1780059089;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qITjIxKdpi1UQe1FdVWE4w1z8BRh8hFPuNNNTfo269A=;
 b=Q2tKVeyk9bFTL+yFwbvlmYfec/C+/aNwExxNhCx98UL1xmsd2pxnHYFbGXdXsMkOqL
 pf05K+oK/GThfcmW9xLtAmoMfaViaGf4MI33zLxqXbElcpjO83SjeYbVfFnCyqj+oQdq
 fjNMz+0KljQ3TFPlTOcGL9fcyeP6L0w7F8j1EgZWWzJFRuGlzNMUP3EOkpkXfaO8+C/+
 833DAl8wq6B6iIstA4qD9BPjyLUr/9DCPPZbm7fTX/GhJU/0P0pecTZE3n+EamigWQKD
 rgb+TNlFQmr70B2Sjk+Usod9K4wwDFHABggbaSUmt+uLqgXkSPMyFz6jJ8IC7LPBDYNW
 LQQA==
X-Gm-Message-State: AOJu0Ywb97mN5hAcTUuFwv8R4yFdT1J0E2VmCeDbOJgyOYGV3L+uh06S
 W01XRkpMHv1LgsnXoFFpEkh2WhQfJdWyvo6OlgVnUCtNvNd9EF27HK9LKzuY6S/j20c=
X-Gm-Gg: Acq92OEDADVAiVuYq2e+Wfk8z7F6XPG2UbK+pVnT9mPmdWfDWT/BkDBmBQluvxs09Qd
 D0W5UiuxYopVGXpCAMAQEEF6lhec01dPkAqTYpES0pb9Plq7icSgCBNk0FO87KhK0nIZqnH/9Ud
 5HUsARXtwnZ7beeqQVYj87R8vL+C6Sc2dLm/eHkOkRYtIJNVam8QQhFLRORFYGomwZHTITcOwo1
 b0YAUK52RtB1hL4JCrx+nnJ/9maGsqMqvQl5f+9QY7aO/92+BfMvcAsvURWg4hrbPQpo6ATdcHB
 pquV7RNJRRrwCsGoNTQ6EdG+FuEFFs1BOcReR4GQuhfCSIapSedtGFJBhgfBlfDsMi7z4Pvnc4S
 1nlN41KxZoGCtwYSmZGpKe1ZTia3yvXxF33nmDGv/ato+GU6pZKJNukyDoKH6M7rJ4YGfzwmyEi
 GPIXXpsmCs3m6QrBXDd/FXFvompnSOAtEkrqXunH0U+5VWAe70qGd7F58=
X-Received: by 2002:a05:600c:a14:b0:48f:99a9:bbcc with SMTP id
 5b1f17b1804b1-4904249af8cmr43036585e9.10.1779454288848; 
 Fri, 22 May 2026 05:51:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042af0ac1sm15046735e9.31.2026.05.22.05.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 05:51:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v6 0/2] drm: panel: support the R63419 based dual-DSI video
 mode Display Panels
Date: Fri, 22 May 2026 14:51:23 +0200
Message-Id: <20260522-topic-sm8650-ayaneo-pocket-s2-r63419-v6-0-16edddda9951@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtREGoC/5XQy07DMBAF0F+pvMZoPH4kZsV/IBaOM27NI47sE
 FFV+XecsiCoLII0myuNzx35wgrlSIU9HC4s0xxLTEMN5u7A/MkNR+Kxr5khoAGFLZ/SGD0v763
 RwN3ZDZT4mPwrTbwgz0YqYTk1qExD2HcQWKXGTCF+Xmuenr9z+eheyE+rvW6cYplSPl/vmMW69
 8/KWXDgthXUaVdHi8e3OLic7lM+srVzxo0qYaeKqyqcF6C07MHfqPJH1aB2qnJVgxE+oHLUhRt
 VbdT6YJ+qqtq1Fq0LmuwfP6A3Koqdqq5q3+sGAK2VFn6py7J8AU7ZUANDAgAA
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=yu5kbiZ7RSpkU9DZCpgGVCTo6zTSxkQHUhlI1OpeSZU=;
 b=owEBbAKT/ZANAwAKAXfc29rIyEnRAcsmYgBqEFFOKZN7cltSl4iY7VA4xytyu+IWa1ufwwM5Ync+
 21HH8U6JAjIEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCahBRTgAKCRB33NvayMhJ0f+dD/
 dluIr2VYAGxXnbAONds0fhFF5qTOghobJH9hzEpYHGTzmHnU93c27IYNjTSTC5QgO9/bWP9SB7UB/z
 ozJw9jZTuaNZSsAF1tcBr7mLUmHG3dY2DAS8qMhimo8RtjilNVKGW7vBmYiyCrFcACwltHKjSPYPHr
 C6UveKj5kVweeUdCj5guO+77zseBf/pQ4w+R7FV93drAT8NpmwpB++7PbzcztO5lmlxpGS1e4P/Cg6
 gOnaML1kYbcUxhF4evNIlUGY1bZvaxje6a5IcDcs0ZaqE+R0jPAYpKAeCn3owrb0tXQ+vXfY3f8R9o
 kzOfD3eDW8OO/DM1GSoNOXZgQmsfdF4JEu+GyCyVV+99PuQgFgIVqomxolGCFM6wUjHVrgVoVnQpkS
 G6EgrymFmO91ojg838j709OMdA86FDkLm7XugO2K717YVWaxUCKBy3ACYp5Eg1Wt9Vkns3Wj5nGQJY
 ttOb2su2YDgeVUEmoWwGrs4IQ6daGmERStSveu2TRUYCYW1n/XAOEOSZvpUOcpOL3t7EXtguZ5vBHe
 UTKDOf/SCe+SH3l7NMqGXmi+sgwteX/IoFH88Tiu6V8JXwayeudqE/umSKZz2hvMNTE4BCR97hyS2K
 a7jc+Klcg38Fa9i8mZq2Q3FC7m01clxHgBk2f13n0UfDRD1upullV+NCz7
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

Add support for the Renesas 63419 based dual-DSI video mode
Display Panels found in the Ayaneo gaming handled devices.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v6:
- Get new dt bindings review from Conor
- Properly init dsi_ctx
- Link to v5: https://patch.msgid.link/20260521-topic-sm8650-ayaneo-pocket-s2-r63419-v5-0-dd5700299390@linaro.org

Changes in v5:
- Import panel-common-dual.yaml in bindings
- Set reg as required
- fix bindings example typo
- Add helper to switch link in order to use single dsi_ctx to properly handle errors
- Disable vdd supplies if vcc supplied fail to enable
- Precise the power off sequence is recommended by the vendor spec
- Drop passing of node to second dsi to avoid re-probing the driver twice
- Link to v4: https://patch.msgid.link/20260519-topic-sm8650-ayaneo-pocket-s2-r63419-v4-0-b8929af5e951@linaro.org

Changes in v4:
- Moved height/width in the drm_mode, duplicated modes to use drm_connector_helper_get_modes_fixed
- Create dsi_info on the stack with proper OF node and name passed
- Switched to devm_drm_panel_add/devm_mipi_dsi_attach & dropped remove
- Link to v3: https://patch.msgid.link/20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-0-9f61cf24aebf@linaro.org

Changes in v3:
- Added DDIC compatible as fallback
- Added rotation in bindings example
- Fixed bindings subject
- Added second MODULE_AUTHOR entry and re-ordered signed-off-by order
- Link to v2: https://patch.msgid.link/20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-0-91ac10453d0c@linaro.org

Changes in v2:
- Add missing rotation property into bindings
- Fix commit message & subject typos
- Link to v1: https://patch.msgid.link/20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-0-981eb5ab5a51@linaro.org

---
KancyJoe (1):
      drm: panel: add support for the Renesas R63419 based dual-DSI video mode Display Panels

Neil Armstrong (1):
      dt-bindings: display: panel: document the Renesas R63419 based dual-DSI video mode Display Panels

 .../bindings/display/panel/renesas,r63419.yaml     |  98 ++++++
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-renesas-r63419.c       | 364 +++++++++++++++++++++
 4 files changed, 475 insertions(+)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

