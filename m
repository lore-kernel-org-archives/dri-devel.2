Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6553CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5036C10F302;
	Mon,  8 Jun 2026 12:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DGpN5gBI";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E97E10F303
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 12:25:59 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490abf12f0fso21632785e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780921558; x=1781526358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HToUuJ6es2zjFw8PTyZUYRF4Q9UIJtuonF67RdPYTL8=;
 b=DGpN5gBI0CSXJqbk0MH5r5KvVjW+s0pJV2y4+NfjfT36UCFHtfve2zW478p9KYt4Hz
 SfgfAYwD89/BbPce7RPgsmgxGheUvL6vY58gduyblKLd2mHFPrBOPxoQzkl6ib8AR8F2
 FfsnCxCoLlJNOTJzor6zl5/NSnwi0mi3QTDPQwJKbLwq574jJaStf2idcWnUZCvXl3xQ
 h/w9Jd6YA5qQBkiGeZfG2j7kNCxFgPM35IA8d6geWFDoRTWXgc6M4xkWSnTkkPZh1LXU
 WK9tD5qy6myG2ruOEHeyaxzvmkPHMJ6+/SnA1e7dqsGytfyoq1gTWX0LHWiffxcfdJic
 W6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780921558; x=1781526358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HToUuJ6es2zjFw8PTyZUYRF4Q9UIJtuonF67RdPYTL8=;
 b=gEH0V6+Giq/JassINbXYbBjC9PJ/c0Rx2MaIMq07pCTjEvu6Vc9Z680JDSJYhqF4O4
 9hGQQdzPNQv/nfZEXhWmgYUKfwgk7E3q4Ep9wMnMvvfFM+oj5rMhW/mA+tt45uPgBjWo
 1Ep+nLPkA1v9UpL1jhdAeAOSsRDIQtv4HZO6x1s7/vGFFn9Cd0C2Si4GtkeKOjsNmvE4
 LQ9Y6SfphJsqoaJ/mOCc5e2DZ+o7vx+YV90cXhf1EWnXJOdWUrWiv6PCZYCTExKsU38C
 gIFw0ey4L14rHT5uj7FOuMr3kPtJUi9QTO0sbpFuVHZCfsj+uJnG/EqL75FCcHiwlutz
 MMkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CNCywDJrpFOFVSjOA6D3IPG11T96W1DCvbJxfOhavy/Wus3xZgKjqOI8xA/qfl7FV9bSLDLKNjyg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxdkc1Y6LNwlcaUT628j8KTFNKmJjvkk7xtwaiRFe1Ems6P7EGm
 hs2PQE+FlTkMeZNMuKzYIayKkDcT9DP3b0Ea0RkkG2I/ChBME9NbSd3O
X-Gm-Gg: Acq92OE9fHSkGE8k64RxIaVQiGNxhxD2CbsiJUSeIOU4DqgVzmApStjbz4qXGQwF7kw
 +kvwdeQP6fVxZkY3WZc3ptrfar6NN+Wl3sgeNQgXUOXYrVziZLRCyG2ld0C5vijbgDGTGCyPMqO
 6ifXdF0pbtrYNvSPGzGkcWgqFg1en4ZoJ4xF7dYpvuokgeMZpQ//vVOI03f1l75C3Eivs2hB+hU
 Bb8PnkYQckVe7x8ZnfVk+E+uoEIvSWI/rt59IpUi1f0Pah6hXYov2wS8E+Dy8bMJoPP70tv++J4
 maljX8vIeVV+jss2+M0332jFZ2OkC7I9I/W0FQCJE1oIY7wOkk/6mTI8m3xq732Dnrr8apAWMRd
 oHQ1lyeUFlLlUVDyIAjxZJ/v2jWx+TyVkwAtovZXNOEqolBDXMRH6x3LZWO7GFCYPLh0h9m6gVC
 PGto/NdBfzmZudi5OtdeIqn7a446Em9THh
X-Received: by 2002:a05:600c:8208:b0:490:ad1e:1846 with SMTP id
 5b1f17b1804b1-490c2cf6718mr190635455e9.9.1780921557568; 
 Mon, 08 Jun 2026 05:25:57 -0700 (PDT)
Received: from localhost ([87.254.0.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351d69sm94264837f8f.29.2026.06.08.05.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 05:25:57 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/display: make read-only array rates static
 const
Date: Mon,  8 Jun 2026 13:24:27 +0100
Message-ID: <20260608122427.48375-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array rates the stack at run time,
instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 9076c2b176ec..351a62654a8d 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -71,7 +71,7 @@
 
 bool intel_hdmi_is_frl(u32 clock)
 {
-	u32 rates[] = { 300000, 600000, 800000, 1000000, 1200000 };
+	static const u32 rates[] = { 300000, 600000, 800000, 1000000, 1200000 };
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(rates); i++)
-- 
2.53.0

