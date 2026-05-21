Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B9ECD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D59310F269;
	Thu, 21 May 2026 08:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mQfZN/lQ";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5B910F269
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:14:23 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso3219602f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779351262; x=1779956062; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pGOnSJlvkub39LzIjocgenS5JEKrBfHwIH34CbFHt/0=;
 b=mQfZN/lQsUTzGV2PeyEHar/5BWXrjHdFg88Z4Hq+Edrf/M+PGbGGfSzrnXI8cehDes
 VKIEPK9FyaihihY0Sc+NQQg5d4CGeLlckBPMR32kkCVPBEVuYHAFsMxi030hdxjo4sls
 hyNqjttlOawZAoOxF2k7drB6NYI92rQXIfR7xCkvi+Nxf00jPeoFNWIxbEd3Yv83OpZw
 c3BUNNm23uTBMnu53CVa7ttoufx2I65Uuam+4mLOwFf7QastvHSMzhNXf5weuST38KxP
 YnmgFk2jwbnWZC3Rs/lNGY3K90j7XCwgGlHcgkZIGkCN8HClTTGKNa2vYyYgmJC65b1f
 02gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351262; x=1779956062;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGOnSJlvkub39LzIjocgenS5JEKrBfHwIH34CbFHt/0=;
 b=Zk3ATWjH08lzo/tB1oC+64sIRkqVZbd9zNBbZjNmaX+A/yRaTb03d700jpEJCf/nO5
 QwhDgCRlJlgFBpVwDdoeT0ZngK33y4pM+PSxe8uvZ8FYtkfK4RPriwSOlsTvItgirz2t
 zOCXkbK0YakUBLexTUXiVCGxSRyedfZ0nyrcnnKssAZwPn4pIMC5Vh0hZR9pXysCQLT/
 3bXfPqKLu6yvdc9YR6294mM+/iAuEOkJ0RM0gY5O6QDje6xUzvSPUGmOst5cTLZS4w5x
 AVgFx5QBUOxT2pOvn+OcDalu6pmfmWsY0FBhYHtu56Pw7EZYjc1YxU9Kh50kbaaU5nxO
 T9yg==
X-Gm-Message-State: AOJu0YzknoJP51zL7ARhGx3Z7p3LNPZ4+323j/OwA6JTNs5KP0xjjmj+
 26Iyn0djRj2TBcKdLOS4phtCgk1Sp9Naq763qi0j8Yf6MWrLpecIrpAD9X6vMkYwHgc=
X-Gm-Gg: Acq92OGg/AfOQAn9WGLGG2yoiDso9nXsWE+Sun6xx1eRbcl3KB9SzCECVTls4IhLeHr
 eMYYFWrqr+2uTyOttObM3qJ9yBBM5VQNzOYdc1oOBBXZDXLXl6R7sbDOPirh9PXpTTXtdZ8rP/c
 RGjm5KdpmSLkOQeu4Yv1v+CXdC091F03QPMlxcpPP3is9cH4+rWsa1xQ/AzlVRVxSsz9kH5mFYf
 lvhs/M/Yd1L0rJ8hMBNvNNgtQxSZt2diZPXVxrpfqYX3qB4i5AZ9iW0UOOXPByOL/d3yT8opdXN
 qYTVxgx1bdiXcwi6oWA4AawFYlEANQME+oat6HQW5r8Zs0WOvULOCZVRMsOXH5lLF0wJVd1wrk7
 rREYzguttDiQAmjAHvtYvtN82QtqY7ywDcohnfAmTDDd4B2QVYnLWQN6RNy07xsbdoQIMpK1Btn
 ok/BcxywmYvdxVQEXe+Kn8i0PhHkJzXUqSKh/PB1scPF3v
X-Received: by 2002:a05:6000:430c:b0:45e:9417:556f with SMTP id
 ffacd0b85a97d-45ea3ef385amr3051597f8f.39.1779351262175; 
 Thu, 21 May 2026 01:14:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7dab28sm1056384f8f.12.2026.05.21.01.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:14:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/2] drm: panel: support the R63419 based dual-DSI video
 mode Display Panels
Date: Thu, 21 May 2026 10:14:18 +0200
Message-Id: <20260521-topic-sm8650-ayaneo-pocket-s2-r63419-v5-0-dd5700299390@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANq+DmoC/5XQTU7DMBAF4KtUXjPIHv80YcU9EAvbGbcGGkd2i
 Kiq3B27LKjoJkizedL4eyNfWKEcqbCn3YVlWmKJaaxBP+yYP9rxQBCHmhlyNFxhB3Oaoody6oz
 mYM92pART8u80Q0HIRirRA+1RmT3h4HhglZoyhfh1rXl5/cnl072Rn5vdNo6xzCmfr3csou39s
 3IRwKHvBDlt62jx/BFHm9NjygfWOhe8USXfqGJThfWCKy0H7u9U+atqrjaqsqnBCB9QWXLhTlU
 3an2wTVVVdV2PvQ2a+j8/sK7rN/SMXTDtAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2346;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=0pTdcu/kVI+eVxLSPSl8lJa1+3nzA1VclyY+DaWoszU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDr7belusu44FW5o5tWy/5pavxW0qYJXy2xYOIk1N
 HIk0ojeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCag6+2wAKCRB33NvayMhJ0RDtD/
 4nwtOkEETae9L29EDFr5Wp/CKfD0Q2rJQfvKzuHuQuZRXnUtbvuAFS1DzjpvSP+5avgjgZcXY5dIyu
 jtIOugjYR7reb8kOwLGlOIYGeKRzy0JjyBd7bQD/GXustifK3ssc1GvpWR2Ia2YduINdoocLpJFIJV
 ELnklONOBnw/egakFHLU/dFewh2Yx54p0m9w/HcgiXmlhw2HDv8d6v0+5AiotFEjOUFQiFOAcHxN6k
 hhTU9tc/zuA3SWcz0e/hyiF124Br7ZMvxwq+/j2n3Dkq5UEUJWD31NnyWUbFKxFHh1w3pxlXnl9Mrl
 GycqiUzdWenWAPjmcLLHD7UjdlNTvGTFpSrGcOTBgJJE2qDA8Hvi/G1zteT+gj2DDzNM0rv7eO/4DH
 FXTa1RLmljGt+4lxh9tevxfQmO6q2kzfgMHxsPjiQvEi0EgPLGUPydlOi2BL7dklwWtVwaCNJeUOHR
 U9/aOEyaPKdjloZjebasc63GTtE+GyS6fkeNEGvcpYG75l7zXTwRhLA5GyDURLV4vrQJVgQP3q8HYp
 YNhXpDtjZ2hvfgk19/bLqbaxlY+SudP5q4Tv81vyDUbwbSEmgQv/28bTo1x1ooO2c0X6uJnCdq8QOi
 Jvh2KODE7B7fi3/mmPgaUt8AAtKZvHG8p0abKkxpWXQlY9jczpIJQBHQEbxA==
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

