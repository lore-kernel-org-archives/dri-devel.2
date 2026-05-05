Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2E9FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 21:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2C510E46B;
	Tue,  5 May 2026 21:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qncCwKGS";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4135C10E46B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 21:46:31 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso50861855e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778017590; x=1778622390; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mWFcBq0zhFRY7Cz5fcJUSQDRK4lDJnO8aVB09yQ4oes=;
 b=qncCwKGS5+ayCPk4BoJS94EOdzst+xyv5+Tkd9yttzwlIx++3n9ErHQ59sim4QexOH
 z05LKzCCYDZ9sHmNOJz8vguXUlbCStz4LDRXFX6lTlBPr00c6NhuGhJga/PCieeiPaLx
 baNQdJqpXT4Lcfc18JQ8CLFvSogqKcClY6PZA9qt5y1vAuB86oEeZxthry4xqaFvK62V
 HrAWWf+o4C6JnM7jYLYVcBifUXsm+cGzxWIzQtvGkYwPFQHDLA3+rnF9h5nanXu3/3R0
 euEhceWfwUqrJ4L8aGFMCXQmyZkJCqhaPIfLjEgoTLKf1LckBr6j52WhNsICeR+5vSx3
 e36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778017590; x=1778622390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWFcBq0zhFRY7Cz5fcJUSQDRK4lDJnO8aVB09yQ4oes=;
 b=o+yF/Ol5zXR1/1BY/7HcDnJ0b0SHlOqLwenIxGWY981rBNuFF5xwM/tEZhKHGvR3Wm
 OLbSSLBpQxRfH7Yk5aFmq89LVVZDlJyX7QDX8qGE7Yd4y4tuIVwEA2qWtaN8d+yKIy/4
 YejCKBKQTzr16OHSzto0z8q8C57p7Y2h0QKJLUZCIoesIJ6BjEvulRJJSZViIrawoL6B
 wOgKkGXex71QEK7UtdIWQcm8BIcj4eECfuuprbgYW/5uI3JYKdtnGbXWUl6D/4Xd6lR1
 NX2T7h577ISKa9L87XzdhA9gUXhjuxamecgr1aTaxsOBSGwT2EhNvMcOuEXn/bYoOcm3
 2sWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ912654rmQArkvUpRySzcuo26ZRLCH698gLYfuDnTdu+cDaq8WhVhHYrAwQvS8r0R8UDxZN0X1M6Rs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwC1CFlDna07sHU9Dr2oRaYzmV9f3R29X/fs1vh7W7VF7u1DDOA
 ZdU0sB+hP/4vetSXJIJ1MELRaimf0Oar18wvSdB0z+o0ydoA5tWpWkyQ
X-Gm-Gg: AeBDiesX90oZPb3jg/oJ1spuhRh420ic2CIiQ3sSXC3xDhtMtP9CPpAuz+oDZ0ncVlH
 xJi2Gdzf79Js9IpnAgK2RySIiSqyfyCV83Yb/eDk/PWZxvjM0NTCeAHNeYojL/TIwgjGuTL7aOs
 HZTM3aU917bIPq93UCJYprGNelsBIc/LRi42tmpOut6jjP5MIGll3o9Z38tXN2BKy5tlG7kXC7/
 m9LhrkgCefNbPybyEMT2b+z30kO3NWOZsUPW501e1E2YA0odsFq9PtapAH2jfOz1NMT7aK9ZnB5
 giXfSX8LLMlew/x7mSkSH40BSAAsI3YY66/2z6ThezFGpsIqm9cfqDqIiup0pLl+1+XoFjzz0sH
 iTb3hwNf17hUaLMjeF8FfaGZ564YRCqYRmYfzZNt/lRysfA/6Wa2kp9T0Mdof4SyQPw5KqU6PCR
 fkZZEANWAceZAC7nBbL3/0dX7X2+9a6oSfr1r5a0iF
X-Received: by 2002:a05:600c:3f0b:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-48e51f37fb8mr17928735e9.20.1778017589343; 
 Tue, 05 May 2026 14:46:29 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a824f9f0dsm411556165e9.15.2026.05.05.14.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 14:46:28 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4 0/2] Add support for mt8167 display blocks
Date: Tue,  5 May 2026 22:44:58 +0100
Message-ID: <20260505214541.333657-1-l.scorcia@gmail.com>
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

This series adds support for the display blocks on MediaTek mt8167.
Tested on Xiaomi Mi Smart Clock x04g.

The second patch in the series ideally wouldn't be required as the
DSI controller is compatible with mt2701, but the mediatek,dsi binding
lists an explicit compatible since 2020 and removing or changing it
would break the ABI, so we actually need to support it.

Changes in v4:
- Rebased patches
- Rewrote commit message to better explain why we need to add an
  explicit compatible.

Changes in v3 [3]:
- Added mt8167-dsi compatible to driver instead of changing the binding;
- Resolved patch formatting issues.

Changes in v2 [2]:
- Separate patch for mediatek,dsi-phy binding;
- Separate patch for mt8167-dsi binding;
- Simplified OF graph endpoints in mt8167.dtsi.

Link to v1: [1].

[1] https://lore.kernel.org/linux-mediatek/cover.1771144723.git.l.scorcia@gmail.com/
[2] https://lore.kernel.org/linux-mediatek/cover.1771258407.git.l.scorcia@gmail.com/
[3] https://lore.kernel.org/linux-mediatek/cover.1771863641.git.l.scorcia@gmail.com/

Luca Leonardo Scorcia (2):
  arm64: dts: mediatek: mt8167: Add DRM nodes
  drm/mediatek: dsi: Add compatible for mt8167-dsi

 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 317 +++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dsi.c       |   1 +
 2 files changed, 318 insertions(+)

-- 
2.43.0

