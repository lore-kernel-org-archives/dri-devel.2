Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDDACD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 19:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9D410E0C7;
	Sat,  2 May 2026 19:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j307ZgTb";
	dkim-atps=neutral
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A535310E0C7
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 19:19:53 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-575171b1ce7so92284e0c.1
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777749592; x=1778354392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=x2r10uGrKHV33PsNUv9ruSE933g5xqNd7qcsNOcjvJI=;
 b=j307ZgTb/eHyCu7LDK/3pgBziFtCKVZgWZRlCko5ra/k03cwNDClc5C52ssKI0fNK9
 B8MhTYFv5wZtPcuFAM6ZARxy7m9wkRPbvREjP9QWyOpBNDSmIWxNLGCatzJ7smHZba8/
 uk/HkGLyqQCJDbz/cQXVTF+25NMqkmXCEHqOhUUoTNP2nYLy5PCRHtlq+7c28Y3WUqC6
 pCRKdrY+hxMyz1q+YFG/9y5KqVKFbfK4FoIUUWsImzJNdd0PgFx/r6g4k3oz+ui+ImBZ
 ss9+ExdK4zp3cKRHjas8c2rO1sqaCCUCXtrBQQtuGDgzeQ1dqS+k+CSQwGTuqPPklGey
 J1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777749592; x=1778354392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2r10uGrKHV33PsNUv9ruSE933g5xqNd7qcsNOcjvJI=;
 b=mdLJA1eyFy3heXG0hs0iwgSYOcq6g9Eky9ir520coICkhyECdHOvkoENcviiDsDJqO
 SPmQA/ommXm49Qx4guMhTcSNV+P4BFLgZl/5h22VW7t7y50n1Fe3zQZIudKp0cmSFKHa
 KW1wAAUaBCVEdEzMABkxFXN/DZIdOgD0k/t9OZWH8GoDmVwsxXHY4ircg8GteR3paLWx
 F13wZAJadK+r7qK8pveeOaIb+dJ5l/kaNPl1R8D2JRYmtS4Ty7QTqCrdNPj4jafFg9CX
 rOtEsP74xhuVuBo+9+a5N9KfH7sQ5IDm1gvLknC1se3wgJP62ojFWJ0Fkp6hDRsnQ7Gc
 +qkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ukZJKF1YwsPguW8fsSCL0cYvIwnirMv47mDR8LDOI6Anij4828EJ21kTrLtoZZyqT4Xx+39x7pZw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxt8RYZC86GiAYbK9k4EbmGh3tn76jDNjwhKieRKNr1Ac6YdOjC
 zZUmyFzhW+SBB7eTG+8JfQEMN1P2zTFHOJ7B2tLjTEpsU0JQtNwmOCAA
X-Gm-Gg: AeBDieuktLlMPnejy8rrewnGT47QeiGkBdlKwbV0o+SvtGesxjzRshr85l9bYjn645R
 X3mAp7AQz5vv8+gySIVxdYHLMp6OLceEPiaef5YG3ak1fLdNlOmJ3Ma89CaYuOrK10WK/XEJqGF
 V7ctwQOtKxEZwyGQruRaFTxDNAW7iRWao/izGxq+QeaU1lZLkIiXhRBCk9X7+MwWHXOriBEpwAW
 rflRr2bvxYpNMy4hhLtRK5PEUAW7qUQ+Ypz5H1DCjrwFRu3MbXSIXmwSU0whHwfyrLfTCe6pcxW
 sXICa36K2yC/XI8ewZlyyehbdOK+3muhQFZsVIndFxtOrarsWVFHrAErLoIRje0VCTLTUzyudzx
 g9/nUlGpYBZm1RKHycHNVqDP8QQRSEzh12Z7BOYzpJKxK15XwUW4MUMahFKMXWE6ZfhOGI4numi
 pAMeFVxk11DQYtOw+rh9842LXZbsJxbW+QBZ54bA==
X-Received: by 2002:a05:6122:1d0b:b0:56d:b50d:3ee7 with SMTP id
 71dfb90a1353d-5750c4b4e2fmr1896410e0c.2.1777749592357; 
 Sat, 02 May 2026 12:19:52 -0700 (PDT)
Received: from nixos-office ([129.222.53.215])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5749f7e8c25sm3474641e0c.2.2026.05.02.12.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 12:19:50 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] drm/i915: replace select with dependency for visible
 DEBUG_OBJECTS
Date: Sat,  2 May 2026 20:19:32 +0100
Message-ID: <20260502191932.4491-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.53.0
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

DRM_I915_SW_FENCE_DEBUG_OBJECTS currently selects DEBUG_OBJECTS even though
DEBUG_OBJECTS is visible to users. Other config options use 'depends on'
for DEBUG_OBJECTS, so let's do the same here.

This select-visible Kconfig misusage was detected by Kconfirm, a static
analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/i915/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
index 52a3a59b4ba2..028a2c97361d 100644
--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -153,7 +153,7 @@ config DRM_I915_TRACE_GTT
 config DRM_I915_SW_FENCE_DEBUG_OBJECTS
 	bool "Enable additional driver debugging for fence objects"
 	depends on DRM_I915
-	select DEBUG_OBJECTS
+	depends on DEBUG_OBJECTS
 	default n
 	help
 	  Choose this option to turn on extra driver debugging that may affect
-- 
2.53.0

