Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F792F8DFFF
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B4910E08E;
	Fri, 17 Apr 2026 17:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZROceg1";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FF410E08E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 17:52:39 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so12692805e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776448358; x=1777053158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kcWSZcx8tUSQRJOSIW4G17Zl7J0Fx/Boua0I4nA8bg0=;
 b=SZROceg1iX2S5jnGpK5jCeafist20SJx9Mbv+1rJwjJ43z4X6xZe8TP3/uJ5EjzgUj
 4glrEDF1mDWz0rQD1QiFdjJbOkDGhl2m/Y9mzit/nn/2iE3mApx7c3DAn5xU3MdA15nG
 d7SsvyaPh5fOmwvlmVE6z76nigubbhhyeW3/0oSwHR6MUz0FmFefFZVdYaKnBbzMSklv
 QXXCx2w4vK3VlasXZIp9cGqDB1yw6mVHOeqG+S702xqq/IO+2MtHluVp+seq1AoRJhwJ
 m6fiIiE21GblAjVT5pQLmKWeNQh90VTlnpNhmdviz+KLrTi0KBUQT0vmMvFbdCK127SY
 4hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776448358; x=1777053158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcWSZcx8tUSQRJOSIW4G17Zl7J0Fx/Boua0I4nA8bg0=;
 b=drkFeZYfyLyZdJk9ukvKShvKe/qKQSgAAdsSueukAIYznIcydd4bbRKI0QPbvm/8k8
 tMYi8OXWrKI2up0mPqahXl5VPx4p/EljPC0D0t5G4gkpdF8afKEav+g4MrIpNqHx5dJd
 Ge1k2iFFzAC8E7H0dfk+XmTSECQC23ONia1roEwm8d9qpMjq9sFOOnHefSUh3exvc+6k
 R6wwBrPuvJEJceQv/BeaKIGHMTnPLZe0YlzJih09Id14GxOJEgo0VOdiTmb3XgjOrM16
 p54TavnBVZ+DjNEAamQYwfUVFkZ9Z8o4s2rSv5ZPhOcouHgsz3WOtfTK99zA02Z+Ux7T
 h9jA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fSWX7GwHGGc2BJiOQcva29g7OjP1ea1NgB248K21I7hfaotCNEFyhqFPqSsKn9J75VhisTCd03tU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPiACtJJBtpL4TYCqLt4p3Uu3wUT2K2aBzs0F8psiDCY2t20YR
 lTlreXBYvzmEeKzc7BHZGWzYsc9Uh0HOYL3TOzaaF7bsZPTcOPhD7DdX
X-Gm-Gg: AeBDietPhsCGCiSn8nOXozKBqS5ZE5lY0luzqghYSinU6Ptu0sgHpip3m3VYFckfv1t
 GmHjOqXhN+PjYOhmC02YwptQw9E60xe/MvYTsLxmJGAWEPR4ZzLnA6sUQycG8Caxm0mden0bT2P
 2ltorZJxfmLw+ayUX8U3bE0EBJu01DsAJdCzytEVj19gsEZOv5siFwHL7zDNkHztT1lKW7+/VWv
 naRQMXGIiZjBMAxC4gHYCDNT8x8Gygrj4jCK2vQ4Nq1+te7yNlSnifn0GhxpSNSGjI6dadb+J/D
 SUlynr6OrgQ35K6xLJH4Pb8r8idWzUZav6R0UNLy/Rkn3o/z4QhhlRD5upOnD6OnIsOijKcnic/
 vnzM5BPfElWUHOK3n3g/RlmnQyadKMBDpQq5ztINyHOO2MJtDjO+ePIaJuKc+a8sAaZKWI/oH3n
 vWAMqV1wQdKwqdevTj9Ahvk/mREBaG3PmZqA5ItP9/
X-Received: by 2002:a05:600c:350e:b0:488:a82f:bb95 with SMTP id
 5b1f17b1804b1-488fb7861c0mr52097255e9.29.1776448357547; 
 Fri, 17 Apr 2026 10:52:37 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:528c:590:5bef:9bc8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c773fsm56166535e9.12.2026.04.17.10.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:52:37 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/3] Add support for Renesas RZ/G3L LVDS encoder
Date: Fri, 17 Apr 2026 18:52:27 +0100
Message-ID: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
from 25 to 87 MHz. The LVDS module cannot be used at the same time as
MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock and
the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
module.

Biju Das (3):
  dt-bindings: mfd: syscon: Document the LVDS_CMN syscon for the RZ/G3L
  dt-bindings: display: bridge: Document Renesas RZ/G3L LVDS encoder
  drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder

 .../bridge/renesas,r9a08g046-lvds.yaml        | 128 +++++++
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 333 ++++++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h    |  22 ++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  26 ++
 7 files changed, 524 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

