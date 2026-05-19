Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ED3CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728DB10EB00;
	Tue, 19 May 2026 08:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RNtj8s09";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9957310EB00
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:09:11 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso39513625e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779178150; x=1779782950; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iMQHjSEfbKROtejUXhzBkZMB9GHzcTlY7ZdrFaIuvzs=;
 b=RNtj8s09dg92wUYOXwbF9pOSESaqBFCjBhCy8VemYCPnPOy9O52WGftIE0jvtJUCZ4
 Dbn1SJCr8WxV+uAwS6yupzvHkwdaoijly8tya+XeVqS0SqWCnaROAWUs7P7CNrz2PRCh
 xL6dLIW9nvyM931F4Dr0D5W+lD6iG6HXDkxyuJQ3W+JnxSOKlG0FW7d5Xx+X2E3Sc3P0
 PXMlJ3+/W4WNKNQ6VVGTrm8autm/2cmJKTwvOTzDSBT7L7qYPd3bu4Tq5GEJsUfCr/oJ
 dHj1RZq/2Pl6/mfHmoRNRyr9wf2iPYZz9RphkYLnaq35FvWzCDT8TKg5l6QPBRAHMhm+
 AGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178150; x=1779782950;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMQHjSEfbKROtejUXhzBkZMB9GHzcTlY7ZdrFaIuvzs=;
 b=s4shli7i/yGTJok73o01OWzKIKgUw6R8VI2bYrlJoofJaPzKCtb0RZ2vr+LJ8AaA9D
 YmQ79qtV9wSLJtWu7QCvSjJBmk3KDKfFVpKvUzFlfXCOMKNDCOpL1vabMqd6ge7G03zA
 YEj38XWsBQZCxaLnUuYqc64CaJod/uVO9cTf05SE8wJBOv4oPk0B06lDvKaGhBYd2jhK
 vSxIEiXXbsoRDRZjxKA8azMQyIvAUhAx7/yn/OHiXprFumCvIZMg5V3SNyNZUaidL+F3
 Yr4Y53bY/kERptQHb4kt2TvvL7h+EmPpeAE/PtvsJN4tj0UVmzkhG3Zj4sl3iAP/YdgW
 onRA==
X-Gm-Message-State: AOJu0Yw2ZLDVsYqs2+6r41WdV7nfA+QRH1uosQUcHNrr2+wOytK1zDyt
 9kqVbNQOU6g+1UiNl2optb6Bb+nvUmIoEV/Hhr2dnA+3+N0cjM36x6nQppyx4sPzuiY=
X-Gm-Gg: Acq92OHgiMHWdcpEpNbvOqrTIJe0LuRgrWBMWpsbrCW8PuA0cJohLXV9IGH5vvCxcCA
 lI7oKBAfm0jVjkFBN+BLKerVPdoW8KiIyQ3uN5q5D/+rcTEpspZ1r3HKEmM75kbg1c6FXE5AJae
 BTt31O4vZ5IdW/H3vTDB0G1VMpS9HQZALqYpFz1Lyn9pVXxsM7/ZuJu1JlnBJXTrwdOIXbY63PD
 TrX7ZbAipK7d5Ejf8qnQUGlqh8qvxKbF7uSagoWaU5JjmdcM89zJWDKFzVCvjwuIhYZiaKN+X+g
 rt7plDfwGMzl28PjdKVIHhjCphbCw26+Uh5p6E4vT8KWUxnJj8tqt6qKcunvzYu8eOrss1hnxb+
 /xgzp65GgI0d+Zp94uCIXdXllS7oPc52l2LdsS6k9D50VkrVfbIDqjkc5iXDa8g+S0Z83jMz9zD
 jWp7xFiv2QbT85RYPa2CDsyUjSHXxr5qqv8Gr800UZOYcN
X-Received: by 2002:a05:600d:8:b0:48f:e6b9:c740 with SMTP id
 5b1f17b1804b1-48fe6b9c811mr246894415e9.30.1779178149915; 
 Tue, 19 May 2026 01:09:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1a22csm42856373f8f.19.2026.05.19.01.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:09:09 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/2] drm: panel: support the R63419 based dual-DSI video
 mode Display Panels
Date: Tue, 19 May 2026 10:09:02 +0200
Message-Id: <20260519-topic-sm8650-ayaneo-pocket-s2-r63419-v4-0-b8929af5e951@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4aDGoC/5XOTW7CMBAF4KsgrzvVePxDYMU9KhaOMwa3JY7sN
 AKh3L0xXRTUDZVm86Sn781VFM6Ri9iuriLzFEtM/RL0y0r4o+sPDLFbsiAki5oaGNMQPZRTYw2
 Cu7ieEwzJf/AIhSBbpeUGeE3arpm6FoNYqCFziOfbzNv+J5ev9p39WO3aOMYypny5/THJ2vvn5
 CQBYdNIbo1bzsjdZ+xdTq8pH0TdnOhOVfikSlWVzkvURnXo/6jqVzWon1RVVYOVPpB23IYHdZ7
 nb/uU/D6XAQAA
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
 KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=r+//7BfKRoExdLXAW6UsFKJGqyUKXjQDp+OkD+3h78A=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDBqjPksCUJBpAkQN0vRqVxP5ps61f3y6/oQfjDEd
 WxqwaMmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCagwaowAKCRB33NvayMhJ0UI2D/
 9AxRUbzdpr2LRnJ2bsf6wCQIm6ZrAGfggKvRBW4nMkCyC3jDxQZ+3pPtYmCwsOTG+sRRzXfJ9TkWJv
 hPoehKgbxptxj3jhHCcwa/Bd4gM4BT52sS2yjZwvvajj9yB5I0RQqPb95RDge+DKBlgnVtMSHCXFuZ
 ypP3V2sfqVa/9wnzGMYx37swFXS3iXc6pMyn1UHOuRv/oe7LnhwSLyLokeasrTpe8aqmWSwtOTjEay
 U9eG0MpDp4vW7XKpE7FymZkIOy+95T3qp+Q2IEgIecTMCvgL036JdgRqVRbln296y9Da+Rjr+6g7MD
 dZp/eR75T+OvW+5g0QzhEPZp+ZJrUE6D5yGpGXTd6rQLoajl7tQuEHV3vxD5sCIjgxYahXYcg5rb4I
 y0I4UuCzdTad/ZXoo/gBQTh2uV2visyvKbBUlIyFUfQnUWWjmEfZelGBeufQ+kpbYzsRD4lwWGflK5
 T68KhqG/PsDDKfKiPD5QFopRzHTY+dIKCAddsMm7WsyVUkAWXY21UCIFSvBGDO/ylhxAyIMaGtgaVw
 GwSVNtD2xM4OgAHBJS38/JXbBHwbtvXnliF3SxfnhoAm79ssTibbgNa+XBWEyd3phv6+wlXl0PBcPU
 zafXsjmp/11cbHpDHjF2gN7qoETlvubnt5/15o0RYNFlrLAVB8bUVqy+C/eA==
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

 .../bindings/display/panel/renesas,r63419.yaml     |  97 ++++++
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-renesas-r63419.c       | 341 +++++++++++++++++++++
 4 files changed, 451 insertions(+)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

