Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD75606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFocV6V/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C81010E068;
	Sat, 14 Nov 2026 18:07:27 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F163510E068
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:07:19 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so10403265e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794679638; x=1795284438; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5hED87wOhZ8V8fUnhmXBGiVZtHpLRnJmpZB4oLmvhPE=;
 b=eFocV6V/TgfEO2zK0n5fKpRlnv+WRdLZpniTsVYm+BwMPzjjE2b6EFES8uNJtok/qG
 kxMJ7A2ccodYWP29mXJaJN1gCqxA5zM/1eUcaok16O6KSLX/GaNzbMWj7wk/t0XcDgEY
 1QsTzGRAXuZMszuu5HpSiob8kLBmFmX3S7cOLa7IMa9ZuEU0Rhz36DZvA7TjhFTbjMIW
 qyCCvcUSf0g98+kWTOfHRG+ByaMHWSXE5hAOgqmVn+Wpl7KNhhVCSps7aVI5DadLikQO
 QAqylObtPd6QKLsMnmks8tbYCQOQb/nFNU+Rci8hw/TcY0M1Y0HgywXwOSNhhrtZ6OQ+
 JWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794679638; x=1795284438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5hED87wOhZ8V8fUnhmXBGiVZtHpLRnJmpZB4oLmvhPE=;
 b=xN+7FttqgGbFVbkla+66yRdS/YAbprb7kMDFmZMePqBhzP8XoF6kCMKvC+s2K7i2hD
 WvLkgFUM9s+2W+/Rl32AUNGxJ3PkDi6ABgPOXtBymE0uM1L56V3B7himSCwbuUbUidXQ
 6PssMBSsvczOx6+vyr+pcAGoz7NOvV167OAA0s0LenEBWiI6RsdujtDsPk1Iq09D2uci
 LL/3TEy3dkONYkO/ygcC7z4N+IOAOHbUAFuKiWo8bRIiKarm+WnjNSq+bvCc2qVEPNhx
 Stn4LS9mY3aPyeEI2pYpnVpt4Rzs+ufqPGzYaduubPiafUnfe11LQJUnFMw2kaHQMdvp
 m9mA==
X-Gm-Message-State: APuU4Z+ziwHeUS8iNhhemfJP+0CSuHT5988JLZezR6w4vfzDr3kvqhXa
 iePCDJox9swIg6GppEoz2FzRUWCbGm/9N/0hJ70UkKJB5HkkLE9K4jf2
X-Gm-Gg: AYBFou26TdmOSTs8HMqoGQP1Sb6cazQGlOii4K3+yKqrYxvf4TH34VZnoY7Kl3nR7E4
 Q265tkE7BlnEH1zswuatVHxyHjAXjHE/ActaiwEVHaoUU6GQKLPNhzVlCtcOh7aezeRBViuQksi
 ysB3A+IaO2UngNzTY4mnvvKeqb1Kfftjocg7muv3DuDK2Tk09dJWzZwTgC/w13oE9O1EJSsUWXk
 bkiTEeXYc22QElxMsnh8uwl3wBKAm4WK/BjLKGMNgle6XaQtc5GIfkG/8eyHqCwXBU7lV3ywDO4
 qAtOiKPSUgsugRh88PGciTtmd7Ue3CZL8hmd0Vtpr6Op38RjP0xxGE3G8tGIFVpfhEiXmOl5okZ
 O9BUt3NWaxEm6uimnO+2cva/pt8YpWnwkJ752cgO4RdfjScgySQ5g0akipopxa4lyIG+sdYQfpN
 YWieROlkZXFEQQB+bVp8xUYa15zklW6tEXniOO1IArL1Xk73CEIm1kfX9//0tlaruzXBB3SO5bK
 PSA7BYfibgmBYRSd4WRfF/BSTdOAaU9ulhQ82TD5T0haepHI77Mnnf9RIa04owssPK2Zlt+IiQc
 ib7aEKPj/jVr9NfZcaWxae8K1d6QNLGS1wKgmL4g7Xg86yprNDgMKWpOqqQxBeoOehN2AeCRWnw
 GdfzVBwIhIOfKVJ13NlQoSZJJ5k5sWB6b05bjdOgGn52NBTqQlW5CPyuFJcGyRehK5dr36QGDQo
 TkEwLz12cSJdz9/ijaDu6Mo0cj/qefSCtmGAdMVftEPVujUmuV3u+BHg+E7FrgyzRi9xofYzQ9z
 Tk2dXQf3UxgOQ==
X-Received: by 2002:a05:600c:4f12:b0:4bb:65ed:b55c with SMTP id
 5b1f17b1804b1-4bb65edbbcemr44466175e9.33.1794679638064; 
 Sat, 14 Nov 2026 10:07:18 -0800 (PST)
Received: from jernej-laptop ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm69868215e9.5.2026.11.14.10.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 10:07:17 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, ville.syrjala@linux.intel.com,
 lexander.deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] drm/edid: Fix sync polarity of DMT 1920x1080@60Hz
Date: Sat, 14 Nov 2026 19:07:11 +0100
Message-ID: <20261114180711.207722-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VESA DMT defines 1920x1080@60Hz (DMT ID 0x52) as the CTA-861 1080p
timing (VIC 16), with positive horizontal and vertical sync. The DMT
mode table has both polarities negative instead.

Since drm_match_cea_mode() also compares sync flags, a 1920x1080@60Hz
mode created from an EDID standard timing doesn't match VIC 16 and ends
up as a separate mode next to the one from the CTA Video Data Block. When
userspace picks it, the sink receives the wrong sync polarities, and
because the mode isn't recognized as a CTA format, the AVI InfoFrame
carries no VIC and RGB output uses full instead of limited quantization
range.

Use positive sync polarities, as defined by VESA DMT.

Fixes: bfcd74d2aeda ("drm/edid: Add DMT modes with ID > 0x50")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index b8f882a17c8f..7adaa428163f 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -607,7 +607,7 @@ static const struct drm_display_mode drm_dmt_modes[] = {
 	/* 0x52 - 1920x1080@60Hz */
 	{ DRM_MODE("1920x1080", DRM_MODE_TYPE_DRIVER, 148500, 1920, 2008,
 		   2052, 2200, 0, 1080, 1084, 1089, 1125, 0,
-		   DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC) },
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) },
 	/* 0x44 - 1920x1200@60Hz RB */
 	{ DRM_MODE("1920x1200", DRM_MODE_TYPE_DRIVER, 154000, 1920, 1968,
 		   2000, 2080, 0, 1200, 1203, 1209, 1235, 0,
-- 
2.43.0

