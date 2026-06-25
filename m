Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FDACDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0375310F1CF;
	Thu, 25 Jun 2026 09:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZVFhFZL1";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA3910F1CE
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:29:12 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so12795935e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782379751; x=1782984551; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1qmqlBS+NOvUVwDO1d/d5gRMpOTlf6GDJuFG270RH6Y=;
 b=ZVFhFZL1C5bHCo+gjgL07kQYD1Ew7uo6AUsNodNTOXtt4f8LvrCAHIOqKkH5PmMicl
 EQtZUfGEqBH/w6kOk0umcVM+fFvFwayrT5KHqdphSJFnL5QQxVHQS6Oby4KOFwXb2ekX
 mzQlJ+tGTx8z6wvSlbWulSwiTc0qB/SNmndbuK7MnM/HL49MXz0Tre6W474IUMjNMUP9
 Ell0Xixz1APCiNFigDD+P9x41oDuF93t5kZ/igvh3Le3XBktPXr60SxmTSr1JkrGnnZ3
 QDChnTA15TSSbdSAPwbB6AG3hwvQqKc2c70QHDJzdi5MTxUTXZVfmHsoOvf1rxCpmO0P
 4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782379751; x=1782984551;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qmqlBS+NOvUVwDO1d/d5gRMpOTlf6GDJuFG270RH6Y=;
 b=I0hGWX5l5bk2oWUKBihjNg24FXdThwZhryq/d5H1N+u7G2vAatL5v7PI35+jL9OQIQ
 sJlgXBTPkQYwYsbq+oQNIUNN54ug5DbIyawbrQ16SRxP52bbHAqNdcXcr4fZuXfDjLc2
 hoGlwb79jaaQqxSV+jqpzpHd5pdqzBpsHQz6YyXWiHac+nhBV/7tSdxAaH+YeK+FHt2Y
 59N7bi0eJ+T48RqbwDB8/UAvJ0/jcxUR5BPiU6aUo6F5gkx9giFHhtoBeCEHHAenMaY+
 IwjL5ydlUGCdkEvJXdDWSegoR7zKMzjkR0VlkSeGljTujdyvPcIRuowQmXMpxiBkdim1
 AUiQ==
X-Gm-Message-State: AOJu0YysmYW/GDKi3D1Ph+6Gn/58kNhQd/szaG4m5n5MVj3Y5+D/elHJ
 bJ3I9C1vHnq86o0KaA3LUOMRoQkVKy9IDYSLxRCamHvRjvgdOfQCN+107kzRKdfpQsY=
X-Gm-Gg: AfdE7cnitnU5C10ZbZ70vYhogxIk6qFUs9XyUDKfbhIqjxdUNA/pey4QPikGyuMUDG9
 iJYsAsSyHJMY1nHT4AU7TduIu/N3QuEgcC0p0bCll39yhNVkeBeCDBGHwqZW53wzUT9tNWMV1Sn
 VACtfDTtDU3KrdLU1SPskaSDaJ21SFdtrc689aCPH5xPCf2HaIsROHZ+rT/JKktzFhYuNHR3MRG
 1mGSuBXjZGEflHad2naYYLiLz4sxqoWYICffc2HnEG07T1V2pyyImrfcEAUK7h6x+d/26sX978o
 PFrs6LNl9DgEsmgiTKb+9C569cZchErRBn5z6Z6kfiHoz95xNF2CcSo0YZIi4BkpiV1Nh+C6MVu
 rNnAheWQ/1heUEogkfeBkIiGf4F2D+XvDbBBucCOzkHOYMh+kYk0SZQEM9g8Ju1Xy7XpagPGV2S
 4wN7IGKLUlq+QP69phB0DDrzfLy7q6mLIU/A==
X-Received: by 2002:a05:600c:e557:20b0:490:a1dc:e542 with SMTP id
 5b1f17b1804b1-49266862d71mr14954775e9.6.1782379751095; 
 Thu, 25 Jun 2026 02:29:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926544dfaesm33846195e9.2.2026.06.25.02.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:29:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v8 0/2] drm: panel: support the R63419 based dual-DSI video
 mode Display Panels
Date: Thu, 25 Jun 2026 11:29:06 +0200
Message-Id: <20260625-topic-sm8650-ayaneo-pocket-s2-r63419-v8-0-8570e692143e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOL0PGoC/5XQS27DIBAG4KtErEsFw8Omq96j6gLDkNCHscC1G
 kW+e3G6iCtn4SI2I818/2gupGCOWMjT4UIyTrHE1NeifTgQd7L9EWn0tSbAQDMJLR3TEB0tn61
 WjNqz7THRIbl3HGkBmrWQ3FBsQOoGwXcskEoNGUP8vsa8vP7W5at7Qzcu9tJximVM+XzdY+JL3
 z8jJ04ZNS3HTtn6FX/+iL3N6THlI1kyJ1ipgu1UYVG5dZxJJTxzG1XcVMXkTlUsatDcBZAWu7B
 R5UqtA/tUWdWuNWBsUGjuXECtVOA7VVVV71XDGBgjDNuoeq3CTlVXlWv09Vlzb9fmplZ3p9pcL
 yA77W0rwYg/6jzPP1dCtSPvAgAA
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
 Doug Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3109;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JZ6x+4HXQCf0qklTwQbSEog/fEcbxqfwTfTEQH/gfao=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqPPTkU0lwl9mndInTTxFKj3+RDBDu6m+62iBo+2Vt
 hlUQGriJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajz05AAKCRB33NvayMhJ0d+KEA
 DNc7WttevYyJv35sE13rnt1FLMVAaXNcwOD6iRizL406fRZlqAw/PMLkxO1cNCzpqbE5zDQ2B+MAiB
 D2c5fT8KFdlfX2F6djJ9lu7UooNnfu+PFHlavPwdowmB8sk+q/LNOHg7QsInGdfdWBkUsyXVaqEBkU
 98qC1EZybMaQSxiqL7F5fmhuMt9GOO1vbtK87qQ8D/5PL3qyEswP2gaBHYbo+bvfw/68Rer8erU5qf
 b/E27zRNAmdYOkmXgaq13OJ+gb5n3/rqOtNMvYNtN6xKoxsrBCpdK7jh4ENvj/fu86NehhUKLfl12P
 TMkPBAjGmtxF7FTJwRwfTPYXY0wi95w1ONgtLrYAF9JYi7H7/KUTxsibp3Q1Sdm2ZjfbcKjkDCxZQi
 E0jdsQIjFRM0PoPobzpPUbOgA/C9s67nBBwo2IMdcFgNx6782jXkBfnro/6iRA/CgCaQsCYIQCy2bU
 zY0EWYTykKCiQ9OYB0BD1qkD8tZ9KydQGHyZs/ag0DPTKxZbkQ3TuEp3ixXA3NOB/dLI6XiQ0S+pRa
 q0F4LG1aLGvtS62uC1gDhqR8Z+FV8GoNbd3gNTkB9ppsPUHbv14NTwibSxcbtpsHEEN75ZvWgSVcl7
 y9SpnMGYL0AkSZOWZViH4j/PkSavgA2UJYlNBDrleAp5AYz8Co2CUUWYSk+A==
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
Changes in v8:
- Use mipi_dsi_dual instead of helper
- Revert to recommended prepare sequence from DDIC spec
- Disable VCC after gpio up
- Remove drm_connector_set_panel_orientation
- Use 2 params strscpy and make sure mipi_dsi_device_info is cleared
- Link to v7: https://patch.msgid.link/20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-0-b84b6da84293@linaro.org

Changes in v7:
- Reverse "on" command order
- Rebase on drm-misc-next
- Link to v6: https://patch.msgid.link/20260522-topic-sm8650-ayaneo-pocket-s2-r63419-v6-0-16edddda9951@linaro.org

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
 drivers/gpu/drm/panel/panel-renesas-r63419.c       | 350 +++++++++++++++++++++
 4 files changed, 461 insertions(+)
---
base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

