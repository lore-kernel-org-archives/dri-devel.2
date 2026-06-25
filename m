Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CFDCDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 05:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B291A10EC87;
	Thu, 25 Jun 2026 05:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Hg1NhNZm";
	dkim-atps=neutral
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E809E10E178
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 05:55:39 +0000 (UTC)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 534813F97E
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 05:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782366938;
 bh=hrK/hqc0KTSs3qSmB6J+wib7JPcAUEvvkJ6klAPWA3M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Hg1NhNZmiyR300zXNDW4D6Elo2/dqLNXIz6fr9g76cMvu1syrG9cWkdPT/5N3aLLW
 +efcaZRzphnyOP3EEtmOx7eCSjBBHK0A1sNC1QN/fR2D5E7/yCv0wd6YDO37nKjDeW
 jqPEm2ATMAPapj8qe4eyIs0iybLWr6/YlBHpjZEWz2jdIybfNimV2iWsqEN5vOHsJs
 6Rgg4bt5QWMhFatUB+yimh+NXXpcpwFD56JygGZ0q77XrvJX/vpBlH6X5owmEeS/UL
 d594U8lFcn9wLR+5sxhzNh2qcVdWoNLxlwDgFM0f8h0BK6htdtIxYzkOiNuUPkmADr
 WVK9s3dAtOxldA+jc2zfDCLgKGYSny/8VRrOcm12tV/GXdLQrGaVN6fu82m9OUzzjX
 LeoQ324x6B+DoYxpUVGz5dg5OxAly7o4OjZriGw7j+YOAfSWu9dAkGIgScj3VXxkDz
 /WhtboeqPZlNkNYlxKiTZz0qpXz7G21bGrtJaYH/7yVP04jK1WZfFiOYa0UmRbvgat
 D0HV8Xff6jJezhH2voGZNgvBr+UG6Wb6stEXZOcrM22OM5qrkhNMsqG4rzKHX0MfzM
 BvPl2XP7YJ2xN4ilsfgOYMOQSfVrGjFhHjwjP+AebKaBgJ+DNgHL1PVLhB7XKzXdlB
 xeFsyVp1vrFh1heUGqemstWw=
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8db8b467f13so36144146d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 22:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782366937; x=1782971737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrK/hqc0KTSs3qSmB6J+wib7JPcAUEvvkJ6klAPWA3M=;
 b=Q3dPwzljzPgu+ieQvYfUxg//vQYhW+Po+E7DizJPVwu96asAyboy/sqJIY30oKgfLp
 WaVdPdT7HbMCQ6E7t64e3ljf4Vh8mg4X1WM/1fhqX6K1h+TKOJW6b6eG4/BHB72H+JxJ
 c6JZMOOWuk5EzNP5SU/ldQJ41jz6g6ro4J/aDZczXMV+33cDiX1lIjBw549Sl9dco7Tk
 RJzipb0QfmhVKuiSMCWai5wZ3g1TG/tdDm8j8+C8UncP8kYBx/4tMFe3DgipSAyys5S9
 pIqUwY4+Oz8UGQR6Q50wge/RMAiTLDg1En+TXyrLLFvklr3AAWElwa44zMVY+CoW0BKE
 14cQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8v8WoaTLpffLzwFhc+uZT3VRZ4T+xomBbwtkTtdGR3o5a+Mczl8HfMARuT0QFgq4yBJDQIyE9eLss=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFPrD/0iKo/mkTFFiqdeq/lE7zo9YzSbX3r1c7FuVg5sWAOoim
 EU+1XWAymtXBg1WZgw47DRbPIryt4PK21NWDgpwVLWEQTmMhT60LcWkSgIqGdAlkAqZizpe/eI2
 TYGYfdmOKdGb0HA4Kfu38AFnGIF2AS94fC/5dsLKmvMxuDoMZHgBjSDIuBkqC1ScT9jbwmntgw8
 twvVRpu08Phg==
X-Gm-Gg: AfdE7cnbPuVo4oeI+MyMA5gi1nOV431IC1hy9hXE7RIQOAnQ2GkLtPmgTeJ+2A8afi9
 fWCeXxL8y529WBX/ldWkbJJG63qAQK30MvEYKhRw5r6yoUm3V6a/uA17TQIiu6KsBuPBzKzdG1z
 iOQhdZkmH/phe3m3S8preQroDBBuaOCtro7nefyOUDHGXG1kXfb5P8j/HmyowILoPgUXeR5n47k
 2AwdTsGnALbCOfZHjOrI3v8+qM9VZ+bha+VBDyRp48AeNM2I9s94a5bLZBpTpgnXMCG9oF5V4OB
 O5av54PM4d6JpZoARs3zzfluuHvxTOlolq/k2h1ZDjYpssEOVC4UnlIuliZH6WkbXtkhfiDbsrq
 +f4udx+KuubAAXddsj8RwWdZ9PzkLKDLbZqDzbHxkEXrXmU8tixwBNQSvYuJbqOEPtpxPsoALvt
 QvEMebaS0=
X-Received: by 2002:a05:620a:1b95:b0:918:419:4b49 with SMTP id
 af79cd13be357-9293d4b31aemr151566185a.32.1782366937137; 
 Wed, 24 Jun 2026 22:55:37 -0700 (PDT)
X-Received: by 2002:a05:620a:1b95:b0:918:419:4b49 with SMTP id
 af79cd13be357-9293d4b31aemr151562685a.32.1782366936736; 
 Wed, 24 Jun 2026 22:55:36 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.9])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926000c2a09sm720088185a.31.2026.06.24.22.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 22:55:35 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH v2] drm/i915/psr: Skip PSR exit for legacy cursor updates on
 LunarLake onwards
Date: Thu, 25 Jun 2026 13:55:14 +0800
Message-ID: <20260625055514.3636380-1-aaron.ma@canonical.com>
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

ORIGIN_CURSOR_UPDATE falls through to _psr_flush_handle() on
DISPLAY_VER >= 20, which calls intel_psr_exit(). Cursor plane updated
via legacy ioctl (drmModeMoveCursor) does not dirty the primary
frontbuffer, no PSR2 state change is needed. Match the existing
ORIGIN_FLIP behavior by returning early on DISPLAY_VER >= 20.

Before this, the psr2_sel_fetch_enabled guard only prevented the early
return when PSR2 selective fetch was active, sending cursor updates
through intel_psr_exit() and causing a black line artifact on some
panels during the exit/re-enable transition.

Preserve the fallthrough for pre-LNL platforms with PSR2 selective
fetch, where intel_psr_force_update() (CURSURFLIVE write) is needed
for cursor tracking.

Fixes: ef39826c12b4 ("drm/i915/display: Fix glitches when moving cursor with PSR2 selective fetch enabled")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
Changes in v2:
- Add DISPLAY_VER >= 20 guard to only skip PSR exit on LunarLake onwards,
  preserving the intel_psr_force_update() fallthrough for pre-LNL platforms
  with PSR2 selective fetch (addresses Sashiko review about cursor trailing
  artifacts on pre-LNL)

v1: https://lore.kernel.org/r/20260623084137.3421894-1-aaron.ma@canonical.com

 drivers/gpu/drm/i915/display/intel_psr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index e138982dc91f6..ba8c427f45463 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3772,7 +3772,7 @@ void intel_psr_flush(struct intel_display *display,
 
 		if (origin == ORIGIN_FLIP ||
 		    (origin == ORIGIN_CURSOR_UPDATE &&
-		     !intel_dp->psr.psr2_sel_fetch_enabled)) {
+		     (DISPLAY_VER(display) >= 20 || !intel_dp->psr.psr2_sel_fetch_enabled))) {
 			tgl_dc3co_flush_locked(intel_dp, frontbuffer_bits, origin);
 			goto unlock;
 		}
-- 
2.43.0

