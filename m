Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD47F327B6
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381E710EB7C;
	Tue, 21 Apr 2026 07:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=poorly.run header.i=@poorly.run header.b="dHjrsxb+";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A31910E6D9
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:04:29 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-470145d7e6fso989673b6e.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=poorly.run; s=google; t=1776701068; x=1777305868; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xJw/OZgfob/yF2Gz/mIIFeBzC60vy16cxgxQvBlE7c8=;
 b=dHjrsxb+BnX0HQpt3nHOc8j0l8g3Buo17tIqjGlPxf9IYiWDKb8+hAFgPL3bBLk79T
 xDag6wIrPnmlrlplGkdrseIhYKQxspLJQPrd1uJvnuZ5db9cIHrnoeUeDxWwktXu3xRH
 ZmhMMDzsA2M5wskuFHRJcYhanclZ3lddX/jO5ryCD5wEw7AZ5G5ZZ3SfUQK83tYzYzat
 tZbdG+Y9ltljemIHnO8c4sAOMCSyy6cIkVPZFYF5cRRlQXLTupGQ8fM21EnMJdpksG0T
 DEicjB/x2xTDAfPKaUxi333h2k429TVv4hilKXyZ6urFqkaO137GQ0JeCeE0ac4QlFBX
 Xuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776701068; x=1777305868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJw/OZgfob/yF2Gz/mIIFeBzC60vy16cxgxQvBlE7c8=;
 b=Yy4pGSPL0xk11L6hft5YVLwxgGxOsk+kTEosWy0rEnvh6L/CeNLNDa7RqMIgrnffmj
 tVJHag+zRPXQATjFeWD+kGRh5pCYj+7SNg1psYccnjI5OwPVE292TOPd33aklXsePhFe
 O7HxLOh10NoE0JN3x37K/ASoiW1Xmlz6jYozDrAq2lp2r94p0ycKlFfJ3DwjvschIVtP
 hx+j2urSXUUoVDbO8Qb5bAfvzd7XQS7a3FyKOXZKLugbs163nqrwRKye3CXjZBeSQdt6
 3TLK+xXLXlvRuGR0uGR6cclIij0i3DvAh4/YQ61+7j+wu2Hfa0m3fZIO24ufuHqPmLot
 uB1g==
X-Gm-Message-State: AOJu0YxtHb1R/5XOuLgyxk+xh8DqEkuL98HeAML2+ndYg4g+hE+l6IBZ
 brqDuVqRdfBW1tcBetCj93KNKH84aLgmgjYWB956zUMldd7hEQKZ5DgEq24dSAaQ92SEz8Dmlaw
 dlGOeAFz/yg==
X-Gm-Gg: AeBDiet/7Qr6nwxdfPMZ7f/BBIdjCsTyU2SO26pzAYHURKfJEcks3+COLW//61xt49J
 d1+rjd0hV1ULaU756YpJhupPctWB1AKP0Xj3JQVRuvQupxUO6pc7qK2cm5nOD+5TbY8FbQ9I9Zo
 JFeI3Oi3CXJLbTEHZCWvLmqcDG+1IxVx2xnCIGubpbiYXZnCzLQ9Ds3i5vP6dLpc2PeAhHskuaE
 AW8aZE9c8mtiDDJnefd/FRy3ZmktSgA4lOtjUdyz5xqi4HRZL2WfwkW2B3pVYTJ17kWEu8KrSFc
 OdReHQJJeGJP53/wXEwrItmRmSGORFXHUuZ8IukmjX6AZ83o9YQNjfbt8gvPThWV1VfQ8Mvd823
 s7sWgSee7+4B4wPaSJ+wYCwsfXsrs3pdU0AZOzl3tuqt4R92O/cql6k5dFDWM+eQHPwVOFmQKPU
 vPn4YGBXRhu1b7F6qZ6K7fBrTP/6y7wLXrO/3Pdqoq2g2oG99MVGF6O9Ijy7KwSSDVG8p7VfE0w
 rPb
X-Received: by 2002:a05:6808:690b:b0:45e:fefd:8993 with SMTP id
 5614622812f47-4799c8b346bmr6387244b6e.11.1776701067975; 
 Mon, 20 Apr 2026 09:04:27 -0700 (PDT)
Received: from localhost (21.179.150.34.bc.googleusercontent.com.
 [34.150.179.21]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65314eed05csm5434127d50.20.2026.04.20.09.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:04:27 -0700 (PDT)
From: Sean Paul <sean@poorly.run>
To: dri-devel@lists.freedesktop.org
Cc: Sean Paul <seanpaul@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH] drm: Fix DYNAMIC_DEBUG_MODULE propagation to subdirectories
Date: Mon, 20 Apr 2026 16:04:08 +0000
Message-ID: <20260420160425.3919114-1-sean@poorly.run>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

From: Sean Paul <seanpaul@google.com>

Switch incompatible CFLAGS-y to ccflags-* and propagate the flag
to subdirectories to avoid implicit declaration errors for
_dynamic_func_call_cls when DRM_USE_DYNAMIC_DEBUG is enabled.

Note that this flag is still disabled due to depends on BROKEN.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Sean Paul <seanpaul@google.com>
---

a wild seanpaul appears...

 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..7082ff6449fb 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 # Unconditionally enable W=1 warnings locally
 # --- begin copy-paste W=1 warnings from scripts/Makefile.warn
-- 
Sean Paul, Software Engineer, Google / Chromium OS

