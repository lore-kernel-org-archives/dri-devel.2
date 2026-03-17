Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0222FCD0DD
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F9D10E754;
	Wed, 18 Mar 2026 08:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bIb4mQhX";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDE210E1C6
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 19:16:28 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c70bfef17a4so4069108a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773774988; x=1774379788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xNksHD/Ia/lI3PwtOgNwKe8s7JojbqFZYiYVCtaCE+Q=;
 b=bIb4mQhXFuOVjZrjCLwVvP6ANdAaqS2OKEvWIWKYeyovIk5/Bdpr/tc75eZR52c9pJ
 /ClrGzD8Qmy0uW10uTz2e1wxjphpH+kmeeHfDsxUPFsar2vjexC0z9n4LV3sxQRCA4eu
 TnUDN1b490j6zqqzrApPa7SWoHsJ9hXqQ/2DB9W7KiHhoXbtGfu2HEAntFH4iI0ykI1r
 /C4ESMXNzHcos9I250TETpdxeui3tEqCXRokKPcO1DuJT9vodXtWke4MTbUOCptQOV3X
 V/EJ9GJDCpNONiAzJDc7r7Am3hV2NET80zz0239aKPMPWamakm8DqTHvVPETHGUCvb0M
 Na3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774988; x=1774379788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xNksHD/Ia/lI3PwtOgNwKe8s7JojbqFZYiYVCtaCE+Q=;
 b=kgrAAUc7NKO1vSzN/WsygZYQ1y0e4SJyCsxSDcMYoj69j6e3MNEZM/CerdnQgM3Eph
 EfQOJglmeU+7pnMNzrWd2tPL7tyg3kAoGdcGCIxsTEsMEs0YgtRDQcTizrpMxtaVZ4rm
 yWxR/zwUkFyfQf0t+mbkN3+NleU7VyJNUWNPBqL1fI5aVQyExUxvSWcecX2Kxcvwy3wr
 hXVE8MzZ0WKfp9ClXaSn6yKs0ypgGqHKeoBWBh7ItzjUMSweHYwRYsqYHSpBvGOIf+v1
 VS+axYbYoI8Swd608JdgfOVQqo0H+/f7E4XnsURdDEW0KOhpoEoegUZxvxLeJBoXrGFg
 +R9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVM72QkEIp6g/15tqLbDlZFpEE9nvQ4TzpSp1crg46rOUAWfbOdbIWPGIETQDkfGDHFe8L9KmfdUk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+pljPAmMALmOYCUEfKCUObipV0+xNc2vnLZOX86ZWCUQJ67Uu
 CBqXw73Tz/H4f39hu1OBog/qWWc/t4gsP0tjHSOYvnYpIK+v1t5WnF/C
X-Gm-Gg: ATEYQzzN9+KDTek+Kj+T6QGSnEFrPN1TDEcZ/t8CM0MHUelR5vn+fFsb92Pa6vXy/mB
 ndIFQi2vtwXiZae+3AGJd9yJnEF0IEiBsBYBafRmyiKEfv7WqfIvKiBeTXQZi1EqKgnmq28Zc2X
 XXLSgTkq4CbEAtLPWxP15uzwvz36wQB5L11ouzcNWejWRr1eNXugI4AYs4aD+rnOT6ADnPx198J
 et6Is6yntPqBwdsVudUr0mGQoAI4N6EbbGTAdS1k64+nBPwClUAwlB1i5kDsMKw4pZIxdUO6UlV
 2tGeJPIMLvUgi093eB79GRO5wGO/5VPHQxPqfcGrwuzfAw438CjUz984oe7p66AwqnIKJoSIzTM
 oZeW4ZLCdY+NdmlP7jolqPyHv639MZgxQOLFMtt9mGtTRQbV19DniGUSQXcBxI9LWE06JmFtoW1
 TvN028WIcTYCNcXyC2Imn/KX25mc4+1/ZkxUai7uL7aE9GG7cuGTLdp2Z+bPbJqo3Fw6JM/9uD7
 swkZ2M1bOxX1RtPhsSbvX2TK7X50oe/K1e34OzFPRRVErUfcoQM888Nx/NwM/S4MpRz2eXdqw83
 gBjA
X-Received: by 2002:a05:6a21:398d:b0:39b:7f5f:d591 with SMTP id
 adf61e73a8af0-39b9a0c86ddmr341476637.63.1773774988182; 
 Tue, 17 Mar 2026 12:16:28 -0700 (PDT)
Received: from 2045D.localdomain (76.sub-72-110-123.myvzw.com. [72.110.123.76])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c741e546b01sm334350a12.21.2026.03.17.12.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:16:27 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: gregkh@linuxfoundation.org, dakr@kernel.org, rafael@kernel.org,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: gustavo.sousa@intel.com, demarchi@kernel.org, jouni.hogander@intel.com,
 luciano.coelho@intel.com, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, akaieurus@gmail.com, me@ziyao.cc,
 Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH 4/4] drm/i915/display: initialize string params to empty
 strings
Date: Wed, 18 Mar 2026 03:15:38 +0800
Message-ID: <20260317191538.43535-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317185920.43387-1-hanguidong02@gmail.com>
References: <20260317185920.43387-1-hanguidong02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

Passing NULL to debugfs_create_str() causes a NULL pointer dereference
upon reading, and is no longer permitted. Change the default values of
dmc_firmware_path and vbt_firmware to empty strings ("").

Existing code that consumes these parameters already verifies both
pointer validity and string length, so empty strings are handled
correctly. Furthermore, heap allocation is not required here: these
debugfs parameters are created with strictly read-only permissions
(0400). As a result, the debugfs write operation is never invoked,
meaning the static empty string will not be erroneously freed by
kfree().

Fixes: e9913f0bd2e1 ("drm/i915/display: move dmc_firmware_path to display params")
Fixes: 29292bc6cc37 ("drm/i915/display: Move vbt_firmware module parameter under display")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_display_params.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/drivers/gpu/drm/i915/display/intel_display_params.h
index b95ecf728daa..0a8cad98d480 100644
--- a/drivers/gpu/drm/i915/display/intel_display_params.h
+++ b/drivers/gpu/drm/i915/display/intel_display_params.h
@@ -23,8 +23,8 @@ struct drm_printer;
  *       debugfs file
  */
 #define INTEL_DISPLAY_PARAMS_FOR_EACH(param) \
-	param(char *, dmc_firmware_path, NULL, 0400) \
-	param(char *, vbt_firmware, NULL, 0400) \
+	param(char *, dmc_firmware_path, "", 0400) \
+	param(char *, vbt_firmware, "", 0400) \
 	param(int, lvds_channel_mode, 0, 0400) \
 	param(int, panel_use_ssc, -1, 0600) \
 	param(int, vbt_sdvo_panel_type, -1, 0400) \
-- 
2.43.0

