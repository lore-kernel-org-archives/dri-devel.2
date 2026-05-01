Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E4EFF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 07:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E143510E4F9;
	Fri,  1 May 2026 07:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cjvFVn/J";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B2C10E4B6
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 00:13:42 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12c726f46baso2514260c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777594422; x=1778199222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfo1BGJf3EN8k4catmWVb/vJMArXXWKbGdkN17Yp85w=;
 b=cjvFVn/JujIzy3JjO4nemwZbNcdGsal5UsH6R7NWVXMPWIZ1vbIN6oW4D4DNh5Mz4P
 7QwGZyKkb0kJYvd07cfo6R06+8eb+YMZAOkYgMnyhZflmXzDvfwSUz89W5yvs/4sRRBd
 KxxNRAQ5cnx1K3TTsVlC8sQTvccblWdehR1/VlxfZajj7BrWPTpbcoCh4+88Pq6ZqfKe
 QGj1asRp4G90Vd1fJuEbGrrRgHrKjv2OrvI4R4h0MpcIGhGTRo4CBGp1xui+hhDAUTSR
 DgwhG0B1/NgwnG3+e9oWbYXWWB97b1PauI4y7MVT+h/PQN5lAz0xaeb4xvxUZMBjtb2o
 /6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777594422; x=1778199222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rfo1BGJf3EN8k4catmWVb/vJMArXXWKbGdkN17Yp85w=;
 b=arEgEz3ykzS6fvYtRodJaW94+9flq6iuVzwq0fcoqHcFIu7TDZvBL/ICH9XoS0rF7P
 xbx2lS7iCWlIuGmT/Va8m6kq70jD0NPAv8PtGkbijujy23pq8gz6cM9ORredG66nVGZj
 kStO7p0JxzkdiuABMn1W9Ps01k/xKgULMkWmAq/4/M/969CaUIn+oOsYGIUBQfxophtf
 bbfmn8EA1PywQR0gFBAQDNG1tndvj+64Fv7+YBUf7kkLgeAnVhwNnOSD1k+Sb7HzdRrR
 7Oz6kcxQ/QVshCOqL63ZXvTwpYUQA8mhz/w+bVwnrtfjeNuP4UcXuAXptCVGAXq27LW/
 SdCQ==
X-Gm-Message-State: AOJu0YwV4WM+rGmN9iyJ1gUftpYvxGedH9l8rU5GkBwGidsOHpUkfLdh
 5jp5Bybn2eSFW5dgdYMnJJb48OTg5npDcJIur7LbQ58gkzw3vkdZCfllBHAhUlSO
X-Gm-Gg: AeBDieuPYdHS1Tdl1IagPrTUnn1LLvt832VQ78HmJbRuL4gIuEhtEEFImT+Li8AiGg5
 0+uLSSUgx+Gb3DCMz9RrOjYXwbeP90oc4OgSf35mLwKJH/Ve6J0Kqoai0ooVm7Iqu+pliMXrZuf
 l2AJQGgZDzGn7NnpBOk6nfdEY04FPDgVmZR3eBBQu1qrPF2BH+PB1qW8cKK0OKRCVUuVjlsTRTx
 8yvxuI2stJLsGizYmdtCwi9kJ1otqHCur5BcI+G09K0kBfLz5RFS0WA8IcDz7gg5YkO5njPFIC5
 Aqmv1SA0R1aFR9OKoEppruMnGg+cldx2/RaQ62nTA4+YEj7zGlV463pkG6tGYqnxRvWXhwYB0Mc
 Fml1Arhr8eC5evj++033RfR3CnDVOaoezpRpIwvwoDmHv7idKhcntHBhjJUP91pmUkVU9ARO1TT
 onxpSRabsog3u7CfLxv8EDxFykiJH4pF3/kLxKJbf+yFoEIeLXpMVapyb1IuCnslC8aX/1xbn4L
 NO1s24qkzZFSrtOlQ==
X-Received: by 2002:a05:7300:a497:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-2ee876806eamr406334eec.10.1777594421619; 
 Thu, 30 Apr 2026 17:13:41 -0700 (PDT)
Received: from pop-os.UNKNOWN ([2804:14c:f25a:8247:ca3c:d9ec:76ed:197d])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38e71ccesm2808237eec.10.2026.04.30.17.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 17:13:40 -0700 (PDT)
From: Gustavo Piaz Da Silva <gustavopiazdasilva2102@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Gustavo Piaz Da Silva <gustavopiazdasilva2102@gmail.com>
Subject: [PATCH 1/1] drm/blend: size zpos array to active planes instead of
 total
Date: Thu, 30 Apr 2026 21:13:00 -0300
Message-ID: <20260501001301.7666-2-gustavopiazdasilva2102@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501001301.7666-1-gustavopiazdasilva2102@gmail.com>
References: <20260501001301.7666-1-gustavopiazdasilva2102@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 May 2026 07:10:41 +0000
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

drm_atomic_helper_crtc_normalize_zpos() allocates a temporary
array with num_total_plane entries, which is the total number of
planes registered across the entire DRM device. However, the
function only processes planes active on the given CRTC, as
described by crtc_state->plane_mask.

Replace num_total_plane with hweight32(crtc_state->plane_mask),
which counts exactly the planes that drm_for_each_plane_mask will
visit. This ensures the allocation is sized precisely for the work
being done, reducing memory pressure on devices where
num_total_plane is significantly larger than the number of active
planes per CRTC.

Signed-off-by: Gustavo Piaz Da Silva <gustavopiazdasilva2102@gmail.com>
---
 drivers/gpu/drm/drm_blend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 1f3af27d2418e..ffa1870528726 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -465,7 +465,7 @@ static int drm_atomic_helper_crtc_normalize_zpos(struct drm_crtc *crtc,
 {
 	struct drm_atomic_state *state = crtc_state->state;
 	struct drm_device *dev = crtc->dev;
-	int total_planes = dev->mode_config.num_total_plane;
+	int total_planes = hweight32(crtc_state->plane_mask);
 	struct drm_plane_state **states;
 	struct drm_plane *plane;
 	int i, n = 0;
-- 
2.43.0

