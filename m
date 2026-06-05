Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EEDCD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B1710E1AA;
	Fri,  5 Jun 2026 14:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lh4faeqt";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F0E10E1AA
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:50:53 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so17192165e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780671052; x=1781275852; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V0j4B4g7G9TNgdgRoQeZbJsIdkpUUijRXOBtL+WYeVA=;
 b=Lh4faeqtslStDi6LAGYHE5I7s2gCVoMmBRt0XIfLn6yv0Abhybgfawx97pWB1QHqnK
 x7cOYf3OgM6pZYwRHqfyd0W2xK2v6TsscNM9qXP6XVY7I19bK13gFyrWX3hvKaXancS5
 t2grfsn072opJ5aS/5sD329o5oy7NSSqA94nJBGpXPAYTwnL9DAc7q/fSyIPgM+NhVNT
 QNMjkQB+odj9yTk6QNbvo+/MgjAfQxsfgDcKMcPMbwPZLMzKVvbnBhpl4sqlWW++o71x
 bZJbTZ2mPNMXd2zeK0O3pOiuFsBAIDJvnvKoKZeWtiPNvYLt1jhydb3lhbtc2uN2gZrM
 6E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671052; x=1781275852;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0j4B4g7G9TNgdgRoQeZbJsIdkpUUijRXOBtL+WYeVA=;
 b=fJAtTabq4eX01lPPu9MKdwfsYmC5Nhv/5LqPC8iyiYWdAzfq7HLH9VDcgbNHbmVYlk
 X10VRoxVLbbXIPFeZkK5xJKDUr+rLjcy1iEAAfvOkHXaitvvQHpRpOIyOTwH0YHlRvVI
 NmMaLd8DiTz/KWBC8sBvuFJNdey/K/S4wHE/AyeYtNw1wx1N6CXUjPUJ5BnzXpmAhyKj
 XHvtMzxd1WxAvPNhFKqLtclmdk7FJpD6IGzVEtypQJ2vpedlFFalOVJpjGlHf69BQiOE
 75iyC4/dUsYIKhQfCG4ly6qBNdYCyO+3MfAdIupMSD5yufVqRIZpwXdExkkZjiE681w9
 EoFQ==
X-Gm-Message-State: AOJu0YyV5S1eR+ZxxDufWI8nbqE6RoiXfY+NtzHMz3CeEWjAKDUk4Da6
 aC3dHjLnuFZqLmgGW7DWEmqNM49PVShqwUcH6VZDGwa1joAeL36IpaE06oTYzJD7V4o=
X-Gm-Gg: Acq92OEKQ/xMeRZc6vg1tGleh5oI66R9S9Xmm3iEYIHi1hQ1PC/JEdBUQByc3qzB8Ec
 gLZaPLbrL8NMceK54pD1/u7M4YmDNIiwWnhBY0ghqC4cMxC0l1wyc8bSrf1MH0gVb5Sv0I5yA1f
 +JOqDPh6mnX0jjfdUWaRn7RKnRN1w+7xXCr/mnN9jRdy0vyHFVD28y48viR5EcGWJi3n1kQOOPW
 f/bRv2LRhGjYetnC+8wlgA9FMXnSDDcRIMqZMw0rLkqOOGytxr961rjg8hSVg+COBG59eMdM8uu
 5hkO2W9bakk+il4+OmRsRP5ud+T+WBF7/QaEIp5H9M4jcN6mi1aI9Wl3ibnrbsTcon0j4tfXmaW
 CCOhudQ3RikrAfSzwep8HWm926/jcWPJuf47RPia3NTD6hIkfUp5lAJN9k9H7pqAQpnYgJaBBua
 hG8/2rSX+m/DX2+nCM9t+zW//NmUh6w1cWIw+PG/rOFzvacfxS8xRLNz1xQf8MAmUv/g==
X-Received: by 2002:a05:600c:1c1e:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-490c26056a4mr68528555e9.21.1780671052262; 
 Fri, 05 Jun 2026 07:50:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3d663csm176178315e9.11.2026.06.05.07.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 07:50:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v7 0/2] drm: panel: support the R63419 based dual-DSI video
 mode Display Panels
Date: Fri, 05 Jun 2026 16:50:47 +0200
Message-Id: <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-0-b84b6da84293@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEfiImoC/5XQy07EIBQG4FeZsBYDh0uLK9/DuKBwmMFLaaA2T
 iZ9d2Fc2DguKmHzJ4fvP+FCCuaIhTwcLiTjEktMYw3d3YG4kx2PSKOvmQADzST0dE5TdLS891o
 xas92xESn5F5xpgVo1kJyQ7EDqTsEP7BAKjVlDPHzWvP0/J3Lx/CCbm52mzjFMqd8vu6x8Db3z
 8qFU0ZNz3FQtl7FH9/iaHO6T/lIWucCG1WwnSo0lVvHmVTCM3ejih9VMblTFU0NmrsA0uIQblS
 5UeuDfaqs6tAbMDYoNH/8gNqowHeqqqreq44xMEYYdqPqrQo7VV1VrtHXY83vXdd1/QLqdF0Mm
 QIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2735;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=noLWCZ7k/hogDRaJM1qtY69Rcq9ht/JpS1l/lTFXwLs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqIuJK66bVPMQ1g9Q/2C8MA7ktzUvGIRC7z+2QQSUq
 gLYjO8OJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaiLiSgAKCRB33NvayMhJ0e+CEA
 CRYThuOvq3cuir9RXhER/VOuVviw44dKQkZG9ueWjPmdbMF6QuWbXSPu0JGa+Ej4cpbtmbF6BZBu3E
 P8n+4qIjovTvcgaZ7+uuiiflqkgNl4zzmwykG5ZjWcwZT8RbLmT6LGt1S3BLnOXMju3TIKclRaAQsU
 Hoso5dtmjywHD5II3meXR7FZ45rJOIinR4/JR2L6hAvc+dyYZ5HzhWW/AdXV415orxIRytMxDVYzkS
 FbvDg2rEdgO7P9PNmBqI4rRxbF4LqNL9B/UUFzGaNeFX8qQci09hmuTyF0ZcjF2vMore1JOZOG5Pt/
 MfuLf+/Y058EKxVZAztViJ6J04k7depqEkoiqM82GpElRTIL9OSN1D2UlFJLJXO4SlQPFDNBC+1m5w
 ZX8Yt6t6doMXkYbvBZeL+0McML0MHCazZvlBUofZPicZunaHq1BrxruW3J4J2pfGqPzF/5IARdhrUG
 f3vqUZ0/+Okdn1xKj10pfJucrDJQHsyr3y/kL0WA4AXgzwM1HVyFOxbawyPS/6en8RAiA9dJsZxpwB
 eTRNIbTPsL5ulGwMhm9hEQx2LRSUvxUpEJWYKPOPhBEzvXZ1F8t/xuOCrijfWjVr82PeVgJaDhdMvO
 0TRH7Hr5fEuOd4ASp0+1yCvK3FNRdgVIrQyUfvdcgX/EgQyaprw5edOz36fQ==
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
 drivers/gpu/drm/panel/panel-renesas-r63419.c       | 366 +++++++++++++++++++++
 4 files changed, 477 insertions(+)
---
base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

