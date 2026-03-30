Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECF4FB3D17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF65910E1C8;
	Mon, 30 Mar 2026 10:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mrX/HNjh";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931A710E1C8
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:44:54 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-486507134e4so50305625e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774867493; x=1775472293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nqv4AprnwJimRofV12+nm6wKeoECG68gUH8nOF/KtJQ=;
 b=mrX/HNjhKyX1NRyxD+7nnGoKqY2ChG7Z80ifB3CI4qUgnsqU+ZAcuwJqwex9KCcvjD
 4AP0+Uq9XmQoT7LRLvWUBZB3+GgytBjtUaDooV1AVI8RJjTigLr9oHQiEScvVCE7AYWb
 7wY3aUl7DRZoqlniMQgZlqorwOQz8hftB0p5SiGRJTkkESs0f8eVxh4pV/O5efq39lQG
 IHUOmggiGA++Z1nTf5d5ZBBhYK10lGr9wubIDDlJNaU4qstmayF0W6cOhtJiCBAFI/Di
 ajFyKUj3ZvL9SvPiUm1xRx8WqqrG81ybN+u8LBV2FA7cZKMayXdJWoDtsmHQ0pV6NPJM
 Pr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774867493; x=1775472293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nqv4AprnwJimRofV12+nm6wKeoECG68gUH8nOF/KtJQ=;
 b=QZwPm2cM5oSiMUzzo4Yy8YLz6wZrwBx1ouco9Z4WNKa+XSj8uizcrfgxtwQqwqwDPK
 P+7jgBuHZlmJumm9MBpHGhseofQW8sa3xbw67KycZeiTYVijJ3oAFmNgXaOE4ORutSsw
 K2l0sItNYA7uGy1Ly1NAbmUIBChNa0bqNW3dc9YepUbe8wWxiXcC3SURE4J8wWTW6cUj
 VRoBkYVGqI4UuCfFd5HnQECrgh4VQiuINe2PQqqfLmBkJGLoShqp82QNN5TrMoYcv6Og
 9tEuF2ZmxTu6CDer5xn8eecPxE/gs3ecJEk3UkbWYbAn7OTFYbtCHZIxlpy8F0kOLgGY
 GNBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVazMwdwp+TJ1bixPheCVq5/I2kZs+rrEOAYWGXTX8RegVt1IDokq7vDk5/x47v5o5pyUsKz31ugvc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyd6j4ga93LA7G4RZpT7PbgJ09zSSOP+mEXU4AJxDTeVQTXdI7k
 2HnInkHgRYn8ggfcY105Sq9u/5VBexI9hBXN7DYPE2EjrW/XSB69/pgp
X-Gm-Gg: ATEYQzxfLYOnYXAuPA7MZMadLK5zioxitGvu+2G8SAQGaT75Z+/ccCKllwfAxFGMYRA
 bpr0WFw1fVdOHFd7cSZZij+yhizvmYnyn6dJCxUEZVFcbzaLOB/6UcPA1cnt3ATXpvUvWmwtaHK
 fsOgwDzWrRY3zIBZmUIluQPerIlHWcDH47TYLrPQJ3y0+NYdztE42uN64p0xOwz0DbiQFbRhXQa
 5nhELs0TAlP5DENGnDMDc5Zxi9sXjCUCIN21ErS6aWKvuZHhjowh9+i3KXXlee8PbJoW9xXJDN+
 BIHleimB3gAxh4nBPVZ+15PKwd9u5YeDsmb0ALAA52d08K5vHCRilqOZJcTSN3jhkVeUCeB+qVm
 S+FHpa6FSb6jHeoB+pPhJ61j/q8u7egppidIvGnVt+SHcnuptK0RUR2D1E7Yqq/QH7OABTI5vjx
 9W7rcAbFMojSS0Z9V/1oim9AfICILYIQ==
X-Received: by 2002:a05:600c:c493:b0:487:338:b4f3 with SMTP id
 5b1f17b1804b1-48727efad7cmr190825115e9.17.1774867492664; 
 Mon, 30 Mar 2026 03:44:52 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:e60:2c8a:54bb:d692])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48727bfc5ecsm185842685e9.1.2026.03.30.03.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:44:52 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/3] Improvements on RZ/G2L MIPI DSI driver
Date: Mon, 30 Mar 2026 11:44:43 +0100
Message-ID: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
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

Hi All,

Enhance the RZ/G2L MIPI DSI driver based on section "34.4.2.1 Reset" of
the RZ/G2L hardware manual Rev.1.50 May 2025. According to this section,
it is required to wait >= 1 msec after deasserting the CMN_RSTB signal,
and writing to DSI PHY timing registers and LINK registers should be done
before deasserting CMN_RSTB.
Additionally, the hardware manual suggests display timing settings should
be done after the HS clock is started.

v2->v3:
 * Merged patch#2 and patch#3 to avoid breakage.
 * Moved the patch from patch#4 to patch#2.
 * Added fixes tag for patch#2.
 * Updated commit description for patch#2 and patch#3.
v1->v2:
 * Updated commit header and description
 * Moved the code from rzg2l_mipi_dsi_dphy_init() to rzg2l_mipi_dsi_startup()
 * Moved the check before calling reset_control_deassert(), so that it will be
   skipped for RZ/V2H SoC
 * Added fixes patch for moving rzg2l_mipi_dsi_set_display_timing()
 * Added fixes patch for assert of CMN_RSTB signal

Biju Das (3):
  drm: renesas: rzg2l_mipi_dsi: Move rzg2l_mipi_dsi_set_display_timing()
  drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion delay
  drm: renesas: rzg2l_mipi_dsi: Fix deassert/assert of CMN_RSTB signal

 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

-- 
2.43.0

