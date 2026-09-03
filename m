Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62253C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC1D10E2E0;
	Thu,  3 Sep 2026 06:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TpfKbvcA";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C4210E2E0
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:07:06 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d944747d41so23112755ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 23:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788415625; x=1789020425;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9sWrGiGmOcSJiAk1eI4wCn2xiwpKyibpzpt88DR+e+A=;
 b=TpfKbvcAsMX1YRw49eE6fns60GP7AmSntqtkZCZwUEdNRatohxwwOpQUfSKAsBFjRE
 OnaB5UOj01DDpAlw0Whdcx6nOL8Ki7IrL6bTHMlUgoZHoqqhVIseZ+dXUHYinFDVdPTo
 3eoyAdg41RBZ1ipnvCR1ysAJzAInDqIYgbNk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788415625; x=1789020425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9sWrGiGmOcSJiAk1eI4wCn2xiwpKyibpzpt88DR+e+A=;
 b=mpZblnlaPfR9y4C/VGz4Kq2pfsjAMLeO+CiJG/hMxAt9N6WI5b1lYQIW1iP9UTJr9L
 HZXaRx0/6yOSWEl4GC+Ly3qHV3pUpyK1p6QYtVuguGgAg70RlSVJbW5ONkh0pPZVyIyx
 g7e0CH6GH2s2kSKhxvgdD7xGjtbaIVyg78AT7X3LuX2kdB6afQIKGtgKezM9Y2f741W2
 RTwnCVLKNJCLKkCi6mE5RV+fiPUcS27bHb1WZFMRifd72kt2xqvH0+2dHdbyxcwwEaFh
 bGLsefuwS3fEkE5tUHf90613sT6tA5fPjw4M8h2iK+CIhpVK4VS9GY29lVtCcBBU2vaZ
 +xOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgwHGfFD/S7yvUe/SzhNeOP+0xdjf6ERSlbts95NSjNdED3PhNkVqEAYvS1IpYOCn6iyUotdijaOE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n4sDYx73hm3yalZ1HtDVcesEhz8oVqtD8CQVcUaf2/pGzCFcR4
 nx7L9FbNTcWa0VeEkuvyn/j62lO9dwoV6H0t3XTbWL/8f/TWyxiBR1VNdscgdVtSig==
X-Gm-Gg: AYBFou0kri9hXhtS1Cmn6F8Mx5zSmkt6YmlL7QOnBR7o/2SPijsDUh7SJa/2Sbk4Y0L
 l02SzV8yjkLGrMce03oTs1FqDp3L0rtV+iOFdH1Ki7BZ4F3IvS0KgBYrHLHP3vRM4fyj09SjhVy
 xD2D7yOFrOdsSsqv4YHYD43HCLQUuB4eNTHXTglcE7qD2LjWf0EDKYjZb6Ru1s47tGp0akKtnZf
 OiJIPoo6z3kzRKxCY0L1hikakPckBpth/wr+07u34ox0bDUE+4VoBAq8oNEtcTA7y9ENeqdW4Iy
 sZLGjoE/dUvIu2o8qnoss4SabKH89i9DJ2/6oRWwPGdqkErApIDcZoWbZUca19xcv4VL30dQdCo
 v2XgaNvYfIOQyJ9lks9Gemde3uAMdKOhueINf1TR7oZX81xwRDzpsi5xC/AdYQcgsBozCKMhunn
 nLE7ejIBls2zTXQE+eku1gr1gGQG3DvHy/8OyEsGsFN98KjpT2kotmCkAwS7Gl7Oqa0c6y9kNSB
 glXQ681vshEtf+TPGKPZhgBvHWtozBcEUUiRhrUTs4i5Q==
X-Received: by 2002:a17:90b:3e8d:b0:396:4cbf:45bc with SMTP id
 98e67ed59e1d1-39aee153e79mr12189018a91.16.1788415624439; 
 Wed, 02 Sep 2026 23:07:04 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:59de:d2d:e1ec:bf86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae8cfb279sm2579007a91.3.2026.09.02.23.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 23:07:04 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/sysfb: Use drm_format_info_min_pitch() to calculate
 line clear length
Date: Thu,  3 Sep 2026 14:06:50 +0800
Message-ID: <20260903060651.3724163-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
In-Reply-To: <20260903060651.3724163-1-wenst@chromium.org>
References: <20260903060651.3724163-1-wenst@chromium.org>
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

format->cpp[] is only for legacy formats that do not have block height /
width defined, and is replaced by format->chars_per_block[]. Users should
use helpers that transparently handle the migration.

Switch to drm_format_info_min_pitch(), i.e. convert from format->cpp
to format->chars_per_block and block height / width for calculating
the length of each line in the buffer to clear. This makes it future
proof with respect to format block size additions.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index 99b13af4e391..acac94fdda7a 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -396,7 +396,7 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
 	offset = drm_fb_clip_offset(dst_pitch, dst_format, &dst_clip);
 	for (i = 0; i < lines; ++i)
 		iosys_map_memset(&sysfb->fb_addr, offset + dst_pitch * i, 0,
-				 linepixels * dst_format->cpp[0]);
+				 drm_format_info_min_pitch(dst_format, 0, linepixels));
 
 	drm_dev_exit(idx);
 }
-- 
2.55.0.970.g62bdec98f9-goog

