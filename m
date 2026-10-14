Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F888CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8714310FEC8;
	Wed, 14 Oct 2026 13:50:50 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2EF10FED0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:50:44 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8899a204034so1921212b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791985844; x=1792590644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yas7S2ptUyRxsl5wgGVtE1bj+Q7zhE7wRKK3MWjRWrU=;
 b=gpFyO4t5smf5Bo0/Ux0k9cuy6zF3AoDulIXuTqzOOPHh7MLV+f49TOLeVCvt9cN26j
 iPdUHV2YQWNzYNsbZRmFT5xYVFr5RITTI9PtHRVIgiA1sR5oxg2tzOJpYlpuEb1fbByE
 Mt2s0Nl3SW62/p6trAk9/o2KEibqlu4SOScEke0Bnjq1mvNWNiUj6cKzw680CH1RgG5P
 w883u2w+dYMVEp4EVN7zjWmwyxcXMU4paf2AKiubDRz4AySxiIHPD7cAetCBmiQDJ5s+
 qjQrOLkN2c78DUlU7TPjQLukuSXMvkrJujMufTksdnriNoKzJ0x91ix61Q4o0fUk1oM6
 W2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791985844; x=1792590644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yas7S2ptUyRxsl5wgGVtE1bj+Q7zhE7wRKK3MWjRWrU=;
 b=jT6N238fMNcb19n5XBEzwQmZWdCAIS5WyZ3SOe2qx2iwMgys9hyoTGYwjCGM0g6SNs
 Iw5qnYDYWHPwsZO1APViD7UeNIXMif0XeLUaHziP63e6QyYoivKG3n0HXUPwDlnl4WW1
 /lppkvo59d3ddAAGW52dfv/Z8juiF1leGW0HLjMy30PVf+YDXJ791wGvEONGkOhaQwUY
 BPUhPc+KoKr32khcNcbm8gKhhXHSJPtTjbY5y7wXz1KsXCBdKpk2GsF8gyHBWonJ2OiG
 q5kbAjBYrwM3IhQxnAb9+WeMG7yxHWBf28YnDB6rtzZ60SYXQiguobO9k41NPeviK5j2
 VKHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMAXfFI+BfXSfGcJgOtBiFelRx7DwO+Br6VFwBSqSPav1Bq1/n0ydjEEU5yhQnGpA75ihpooNtzjQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIbpFBNDr9eocg/V9W2S0uIbE5Th5um8eyP26fs7bAv/klY+g+m
 9RMI4vT5km1m0854WT4Eukuex1iRTIGkuDXhgak2JWQRrfM7wsOPGmt/
X-Gm-Gg: AYBFou0/4XueQuDeFr0IFAZaXqeFuRa3TTJhcQmfJIpFwsxhCfOimQWCvuveU0wRGLe
 y3iZJqmrX6iK9R3wfyLR3RWBtC6XHUhdB3O+ag6fimXXXrrodb3JMYOwgbdrAQwSbgQs/BZiDcm
 BKDSe6UE979+8Vx8XAZjQZcJS8P2/WQe/iML8G/bcESvEG14JbuaGOu8jHV5L8WoSlGz2u1XjVf
 QR94Ni9J20b3RlJYKiaei6LiGAPHSgPjwngXzuUAY2qaTyQqi1aUh5izAvaZC5QOD4q5gFzUZwg
 RS16ecEdUVQsHuo8HPL/FVPvnUeNw6QFoAxfCRrQyeZeIVsgwS+YSVjaeN0mihkEX3f8GbS4FvM
 NGrladY7F8kLyBoHKo9ZF0LfjE8HlpM+Q1s8xnh5YWzOkyI5cMHXOXs8i3A3qqln1sZyujIZfVT
 ewybBbETeiF/C8WY2Iy01WjXn+XnvmoziE5HJzM6KWAvCQNrKfGZCQvD92IGHTHNVnR4U8jdkYr
 2R1oxVYilcqiR5uQKkjPHqtf88JvZN4iWgtf7ywaSx04g5xBi17cfTJl2t8v1NpylYqR8tYMWgu
 K4tha+sPEP61Y+5drLPwx2FT0EjSGHi7yia6n63PaAi61cLl+VgCxe6z
X-Received: by 2002:a05:6a00:3692:b0:893:3f00:3292 with SMTP id
 d2e1a72fcca58-897c634de71mr11932341b3a.9.1791985843529; 
 Wed, 14 Oct 2026 06:50:43 -0700 (PDT)
Received: from NB150512.ADVANTECH.CORP
 (2001-b011-6c00-3d72-751d-cebe-164a-ae70.dynamic-ip6.hinet.net.
 [2001:b011:6c00:3d72:751d:cebe:164a:ae70])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d804e514bsm1168418b3a.41.2026.10.14.06.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:50:42 -0700 (PDT)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH 0/3] drm/panel: Use mipi_dsi_*_multi() in feiyang and rm68200
Date: Wed, 14 Oct 2026 21:50:25 +0800
Message-ID: <20261014135028.1438841-1-hungen3108@gmail.com>
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

This series converts the feiyang-fy07024di26a30d and raydium-rm68200
panel drivers from the deprecated MIPI DSI helpers to their _multi
variants, as suggested in Documentation/gpu/todo.rst.

Patch 1 converts feiyang. As in commit 00efe8a68565 ("drm/panel:
ronbo-rb070d30: Ignore DCS errors in disable()"), disable() now always
returns 0 so that a failed SET_DISPLAY_OFF cannot leave panel->enabled
stale.

Patch 2 converts the deprecated calls in rm68200's prepare() and
unprepare(), preserving the existing error handling.

Patch 3 converts the rm68200 initialization sequence and shares the
multi-context with prepare(). This changes the error handling: a failed
initialization command now stops subsequent DCS transfers and makes
prepare() fail, whereas previously the error was only logged and
prepare() could still report success.

Doug, do you think this fail-fast behavior is appropriate here, or
would you prefer to preserve the existing best-effort initialization?

This series modifies the prepare(), unprepare(), enable(), and disable()
callbacks and the initialization sequence. It is independent of Osama
Abdelkader's "drm/panel: Use managed helpers in DSI panels" v7, which
modifies probe() and remove() in both drivers.

Compile-tested on arm64 with both panels enabled and W=1.
Neither panel was tested on hardware.

Hsieh Hung-En (3):
  drm/panel: feiyang-fy07024di26a30d: Use mipi_dsi_*_multi() functions
  drm/panel: raydium-rm68200: Use mipi_dsi_*_multi() functions
  drm/panel: raydium-rm68200: Use multi-context helpers for init
    sequence

 .../drm/panel/panel-feiyang-fy07024di26a30d.c |  35 +--
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 211 ++++++++----------
 2 files changed, 112 insertions(+), 134 deletions(-)


base-commit: 91f52e99824b0beebb48cad51bbda81437af8664
-- 
2.43.0

