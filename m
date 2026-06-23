Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E725CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA69A10E9A6;
	Tue, 23 Jun 2026 07:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kl9dm1VY";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B20210E9A6
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 07:37:14 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8454160043aso4165313b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782200233; x=1782805033;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QWlSMHsACJK0E3abjyK7dgy5EMAkt0OYlO+2FYWhCzk=;
 b=kl9dm1VYidZ3TGfORKRaMpaIZ1TCQtKrsA+cLh/wMkxyEs8yWjq6Yaq6M7pKK5KnHr
 QLeFZ0YMXuRKpDT8InzUS1beEkF9ANlxmm+n1GwiQAIX2CctgLOA6q7koADmer9E3dyn
 U4KBQ9NCHIJ4GlCZ+s678VOB8u2qJ34c7DvJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782200233; x=1782805033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWlSMHsACJK0E3abjyK7dgy5EMAkt0OYlO+2FYWhCzk=;
 b=MSMX7dfK1gLBcsHoq0JnYvJCls5SSYiy9KKJDUFdkRQgw/YgaKnBn/Cl3dR8yrfFTr
 BD9EjD250LZboN10suS4W8l+48p4uyWe1cAkJmfdhuTnxAfkqV+xbMmV205P9jn7QfDM
 cyYGBNfTCab6D1rkH3vSIgvyHcL1Lz6WeZYWmK4Kfyt3RAXS6WR/dZzaTbKpJA/q/+3i
 Ly4T4cia+yhjSdeqoJMALpDYPRDlYDBf9ii5K++SgfdUffVEUIPIBf/8eQ+4OtpzfL21
 pcZGMSu5ZtpGSbMccl4QBmBlqPaZKT6PbW4fg+yRWFel9L48HS5nr0J8Zw86IvdfAiRO
 KDKQ==
X-Gm-Message-State: AOJu0YyBR1ENYdKjrKEWCTYTxBIKj1ZAwI/TCnISJ2WmR4rtI/NJvIFG
 +VNHGbciRUXALRPIG5EwoyywDUurn//M4gs+yuSzn5ecX5z2gbZ4elRm4zY25dk7sQ==
X-Gm-Gg: AfdE7clDnPSIQAkhZDGpSqfEUWiI9GGlu2vzTtrl696ydrPrfTnL9dI95g+7GE2QCjC
 5g3OazN+6XL6qzTrFtqVZar+xCM5q5c48u9HxVXraY5u4B7cQD95ANLsI2we7fl25d+6bs4ZQFu
 XZhk1JSxToQJ75OMpVsltirVHe51GQjiMc9hJ40Xk2VOUst8JjWTR+txEr24SivfinToay3KEBh
 ZOr87DNjB0p+7Cr/Vk2Nr+kFtAO+RIkrJYckNnyjPeu3HccNpocdD6Q5h9uy6YRJ8CepY+Q0pve
 MQRKRj3MyVg+6eBu87kShS+3sxDYgN0ua45T/iyaxTk774Swh6tvA+AeKhux7aLXiMJYiqHM+qb
 LFLO4cueOK6nfVDBmS9xEPbmepbM9ZM725EZt6Gb06CCOdTSX+0SLXHb39JtAEN0ZPy91zuWz0O
 iswFNOHQUwOW+EePJTFdbl/mytnpZjKjAGzfQDoI6c6VTFxkB95gC13HNQHljtyepSspPF4xns9
 2s=
X-Received: by 2002:a05:6a00:3cc4:b0:842:46a6:e2db with SMTP id
 d2e1a72fcca58-84597044cf1mr1705096b3a.19.1782200233543; 
 Tue, 23 Jun 2026 00:37:13 -0700 (PDT)
Received: from tigerii.tok.corp.google.com
 ([2a00:79e0:2031:6:1287:5d13:b2d6:c6ab])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564ed3212sm9961227b3a.55.2026.06.23.00.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 00:37:13 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org
Subject: [PATCH] drm/drm_mode: drop property ref-counter outside of deadlock
 retry loop
Date: Tue, 23 Jun 2026 16:36:24 +0900
Message-ID: <20260623073648.836363-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
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

set_property_legacy() increments property ref-counter before
DRM_MODESET_LOCK_ALL_BEGIN()'s modeset_lock_retry label.
However the ref-counter decrement is misplaced - it's performed
before DRM_MODESET_LOCK_ALL_END() checks for -EDEADLK and jumps
to modeset_lock_retry label, creating ref-counter underflow.

Fixes: 9bcaa3fe58ab ("drm: Replace drm_modeset_lock/unlock_all with DRM_MODESET_LOCK_ALL_* helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/gpu/drm/drm_mode_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 21fc9deda437..11f0044f4782 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -549,8 +549,8 @@ static int set_property_legacy(struct drm_mode_object *obj,
 						  prop, prop_value);
 		break;
 	}
-	drm_property_change_valid_put(prop, ref);
 	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
+	drm_property_change_valid_put(prop, ref);
 
 	return ret;
 }
-- 
2.55.0.rc0.786.g65d90a0328-goog

