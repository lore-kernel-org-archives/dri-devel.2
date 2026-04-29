Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9101DCCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88DF10F0EB;
	Wed, 29 Apr 2026 17:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DIU5hgzQ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B23810F0F6
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:00:22 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so112018265e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777482021; x=1778086821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aidcyvjPbKTT3kmsb998TSQGc1MaHBcE23aYVUk7JtU=;
 b=DIU5hgzQbOfFn1miInN4wObk9z9z9wyJvuhrTDacHyrk6/N/sRlIldl5/QPBGRNmWb
 bO0c8XBKzlCj9YS88El59LKck0cluKBGy1uIzt0P107bULTpxvF2hnlkimw1fTuV0yHH
 OccCd9yDLX4iDbYDMptL66yGPgvR9TM/WZhSGxJJ4Qrd/A3E3LVPMFusgD7f3IGmL5zq
 NwiUIBpAG84Dew4KCNUPK5KtPwfO98jSpt+2JbNUNuNUEUWvNpai7gg1clR5ZPh9R2zh
 /+QNdVTVAXImDx/BvJs+eTByYDHehhmrU2ul1izNh/VN6RTImO7Bj2GY1kftts9ZYhf4
 FhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777482021; x=1778086821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aidcyvjPbKTT3kmsb998TSQGc1MaHBcE23aYVUk7JtU=;
 b=EtSMWHAdw8vonke4SYpVdED37Na3InC8dxM8AVcZbVy3GVP0CWCAKYAojIQB7b3tFz
 KiXeU8Z2B0TfkdHhwKG6Gqw3EZNeaQY4nSIIXsbHS270w1+1Ll9NR+8dnG0ARtvY2gna
 R+/Kwe/A5qprIqgX9LUKwisuuej7QO+nJSO66cGPOqEHOLqC2Gy7oYdFL1M6/o02EBoh
 qN1HrUWfzRTaMrsU8Pmb9eEIeK6o4PHs0XjJ7yq0zZbCWnFfgQ1HQdHrdZm/FS9rIbIP
 19zfMhevs0KM3S54VMGea+09HmLzeV8Xl16mJDGuzjujkoZgrbYtnJ8eATiGMWdxL/Wu
 1YNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zMWD68hhiNK46Pt9OGn0PtzTJpi+wyF64SLEwqfG8tDyllKB0GLdId4VqyhBLb7ad6sDBv9/A194=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyEQNwvnvbbeXNPtjisTHR8YJ/O6rGJ30/FdzFNQ2SP34ke4Z9
 77fxf3YXZJJA1EMOxgkKrWCNM6bOZpebzot3VW9VqO/gMgrT5JtQPYlU
X-Gm-Gg: AeBDievZCZagYCgLRAzhftZldzqLoONhCoNIlLY74lBXrYvl8ltmdMwmCRYwhXPeFPk
 lYrc9Sy2ToRy2zWZ4nj8PCW3aXFY0Kl9H0lTpPw7zyQN60cjhXEDgcPVI36/wCsGR/w9CTbnb70
 h8X7COSrxeL9qDwTwEPOf2MKG6g67/JZ2Sl3UoBFbo2lrQn4XQMBX4f9CNqebSGepNAsFW6MmJx
 hNoL8hjmg7Zf4/4RghYtKxYfjU7a5iPQvNFJe1wLrbqItE6QU06ULXSNLpDRRtU3IQReGZFHpRg
 GOXet6+aOQim0JuKAVWRQ2LzIbBA8QwsQFUj+vXL/3+AkbS2cd90KNLP5Q5LWxBOEunZKGTO4+3
 NrEmhMP6oo/Beeeb0bub9dmYHUlAnT/tWrsYm4yAo9GeTE1fBUbt1udmgcYzHR3Viw3vvsE8K+8
 Lc9FtQlw+scLyffCEDYo7e/ViZ63wcO00i4fqmxA6L8/hHwNlWr5RDVylhEHhG6w+q2nNIN4FRz
 tLb7Kfau+/rleN6xLCGgrEv5P3Vf8eh/GnT1aBI7jA936Pt
X-Received: by 2002:a05:600c:8b04:b0:48a:53ea:13eb with SMTP id
 5b1f17b1804b1-48a77ad5a7emr130239205e9.5.1777482019068; 
 Wed, 29 Apr 2026 10:00:19 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:212b:3a69:4f2c:3897])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c856dsm4809755e9.6.2026.04.29.10.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 10:00:18 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/4] Add DU support for RZ/T2H and RZ/N2H SoCs
Date: Wed, 29 Apr 2026 18:00:08 +0100
Message-ID: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This series adds support for the Display Unit (DU) on the RZ/T2H
and RZ/N2H (R9A09G087) SoCs. The DU on these platforms is
functionally similar to the RZ/G2UL DU but includes some SoC
specific differences such as a single output port and explicit
DPI output enable control. The series includes the following
changes:
1. Add device tree bindings for the RZ/T2H and RZ/N2H DU variants,
   including a new compatible string and port property.
2. Make the DU reset control optional to allow probing on RZ/T2H
   where the DU does not have a reset line.
3. Move pixel clock validation logic to per-SoC constraints in
   rzg2l_du_device_info to accommodate different clock limits
   across SoCs.
4. Implement support for the RZ/T2H DU variant in the driver,
   including handling of the DPI output enable signal.

Patches are rebased on next-20260429 and apply on drm-next.

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H and RZ/N2H support
  drm: renesas: rz-du: Make DU reset control optional for RZ/T2H support
  drm: renesas: rz-du: Move mode_valid logic to per-SoC clock limits
  drm: renesas: rz-du: Add support for RZ/T2H SoC

 .../bindings/display/renesas,rzg2l-du.yaml    | 24 +++++++++++++++++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  9 +++++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 16 +++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 14 +++++++++++
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  6 ++++-
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.h  |  2 ++
 6 files changed, 66 insertions(+), 5 deletions(-)

-- 
2.54.0

