Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C921090253
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0305510E5A1;
	Thu, 19 Mar 2026 16:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ha41m9cT";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC6010E516
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:48:37 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-485392de558so7569835e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773938916; x=1774543716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=67YBzLgJpm+jWRJhQmLmU0eKJxzFoUHQUOznNZxFkEg=;
 b=Ha41m9cTFxtf1fXC+XVpBUvOmCXxOpKG0NsG6c+Tdt6Nu3Pxj730KtoV/1io1g5FND
 +fS18SjxcYaY2WVliKJ0k72IZGPaGYGpc3UIUCdC5M/Fd1xsyWbAObq5aaoQuJbqU3Qm
 Vul2H/ex8aUwOkw6HXeYE0G++hbL99ZUHndJT/Idvs0eXVZBzajsiYcARJQZKFf+tzUY
 XUXUIWLmmM6BpVduj6tOfqkV/dxWn3+JZXALE/ErLNzzOOyKq1FVIUDAfRzuV2o3imBT
 JsUZXaf7wpOMs2leolVp23nLdR0GltKg6KoZMA/UfNhe9ICmrnFbOjSumnbkFoq9wC8l
 vvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773938916; x=1774543716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67YBzLgJpm+jWRJhQmLmU0eKJxzFoUHQUOznNZxFkEg=;
 b=mUimFTBMbpfU0o3IRYDcgMPs2LnCda1eztlSxcqkiXNGXLkeuJC+8iwY52782G007a
 fRGYjsnblL1dSxumOY0v6W6DoqvrKxSHfmDxH7Xa/sRBPa98Q5s3ou4dH1aOfUb5i8Zh
 cg4OXs8JbBheeMwobCtuRppJDSOLSJZeWJuh+rvC1ifmTXO+y3pMX6HzKxjwpBrjYUsY
 sNlPdNgrnjVOykLbwBca6JlYsHJ2JQAAdmUBFutp6OP0MFRmXjxeQ6nZxO/7WXvF8Smp
 IYHYKIhKWWVnYMHXbCoPUUDtfgBJwOp03FqB13oM04/Rft6zBhSox6/bdQZ0LuThA/Xm
 wYpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUZmp5nHoGLVjk5Dj5jCFaAmgpzUxnPvFkl+g+OojCLVJEvsGz82AgCJohyrjY7vONva+WJ2P9UjQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRAXFnbZ6cNXRKbueO/xbMD8+jmmtkrg8FjHQeCc46WM0vcdjM
 Ibka3EUFD7r3X06M13JMqx98nDCzTxEiWh+Xn5+Me3kFNuNW/py4Yen/
X-Gm-Gg: ATEYQzzEwMXafWkhX7x2sOnNXqd7gH3HPKDtgJQ4RkamNEJRkK80LlnoMQEf7yXL63M
 +K4bTM3iOxSrjJaCpC9+uTiyLeXNCIsYDU/HC6nSswMjnCsO8LCQxu3lDCxOlfBp2aeR4XrSOE4
 xm5c9z/8DU47r8GPftvefG1KAJ+o5dy2/XfQ5Sb0c88PBJHWK64Vn4gKYb16rHq46Ir+Z2+DzHr
 mv7dgiSUiP28xZRMYwv5aoomyopyN0gpH5MMRCCl+Z9cB23xuJAbCKB+E2ectZm+H2TXgw/eCyI
 NOAJDkD0e81WXx2dHcetx9l6HFh8Nr5N2J0vMrC8xhF4yHCMaAWhh1E1CtuuyIkWFrZ4voxqHHd
 wu/SXymn2S6bTJVkYG/SByE2vx54PSn0BWiOdRXcXjtoCXRN5CrunVWEnq1dCJE4nz0yCuJmI6h
 WPYR4YTV3t/OpEwcR5UzakkSRjQHcKjV0=
X-Received: by 2002:a05:600c:1992:b0:486:fad0:b166 with SMTP id
 5b1f17b1804b1-486fad0b2c8mr46748695e9.17.1773938915746; 
 Thu, 19 Mar 2026 09:48:35 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:8326:7b31:bf82:d2d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe68ec05sm5238505e9.0.2026.03.19.09.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:48:35 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hugo@hugovil.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/4] Improvements on RZ/G2L MIPI DSI driver
Date: Thu, 19 Mar 2026 16:48:24 +0000
Message-ID: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
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

v1->v2:
 * Updated commit header and description
 * Moved the code from rzg2l_mipi_dsi_dphy_init() to rzg2l_mipi_dsi_startup()
 * Moved the check before calling reset_control_deassert(), so that it will be
   skipped for RZ/V2H SoC
 * Added fixes patch for moving rzg2l_mipi_dsi_set_display_timing()
 * Added fixes patch for assert of CMN_RSTB signal

Biju Das (4):
  drm: renesas: rzg2l_mipi_dsi: Move rzg2l_mipi_dsi_set_display_timing()
  drm: renesas: rzg2l_mipi_dsi: Fix assert of CMN_RSTB signal
  drm: renesas: rzg2l_mipi_dsi: Fix deassert of CMN_RSTB signal
  drm: renesas: rzg2l_mipi_dsi: Increase reset delay

 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

-- 
2.43.0

