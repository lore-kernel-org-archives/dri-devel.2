Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62B4C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07D710EB94;
	Tue,  1 Sep 2026 07:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rI7bvMwx";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8972110E2B7
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:44:14 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so3618744a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788187454; x=1788792254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VT0MoepU5ZagANU1QfNRwm7KYdNf4WeZGjYR7GBCaMQ=;
 b=rI7bvMwxssUx/B8EJ2+WwKiQXTkUaiLct7BzfRG3ti29SZk566JXfWr8nsOaQVl8m5
 Ayt7e6+yrIeVJdRNzxbLUCPBtIeaZ8PvKS/Kexil/kdyRcZiVH20xfSnEdfuSWcnVF9K
 muL3CMdql2dfWDMdv8kFmakvZa0ccOWv/6pOAGzmAiXoVLf6Emz7+HA5hk+sxuu06afI
 jWLwfQPyr1WxjraC4nyl7LW7Q/8iRrYZk2y4zZSYqwFSKldCXzJJWt9+DhVS6Deyeqh7
 Bizk+bamVguyKoQZWhzxoJQmyBXodJl/nmvB6RTcfXS520PI+9jVF4n/glwb5y9sTnno
 dE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788187454; x=1788792254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VT0MoepU5ZagANU1QfNRwm7KYdNf4WeZGjYR7GBCaMQ=;
 b=YM+j1xk9SsqXRBObnXgL86p6yRbqEzFj85hHw8IyGgJHYkZsFLSmvZCfVDmn+fb5Af
 qeYdMs7RtYw9JBzXk8IGvqSBo9oCsQB074T1st7LhKnbR0ezdrIH/w2NERGBoQvHx/rl
 FtZZhsMIAKJmHPCw7jmmfg59/vKab9bOZnGagyKZKp/aCxAW/v6sSliNo/Q5dsQPo73x
 U4MWFX0a+l2hHI1kIfv37rqpt3iJcgZaIOYGDrCv22xeC2nKkvgNqp1v1oBK+8WEzQ5W
 vRJSgaYZCws+CtHodZhwe2QhfL07hlkeE2ZhrJUwBLhe6VuZZgfo89XRQ5WSWShDtfGZ
 uCIg==
X-Forwarded-Encrypted: i=1;
 AKwUvByD051GLL0zAE/vBKPwEJoTKtHbfo5zf1KaWTbi0Zy9d57UVkQYTOiq79bI4SHfCuSjKUdTfiGMmJI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k+Tk1+ZKLa9JvtTN0ZFOAE8FqXDCmLe2Vh977MHv6UKmyJVFMM
 +7VdzRqXyYqznFfX8au4MGbHeJr2rKQw7kCaPWK3sRm94wpTAYWTi5yI
X-Gm-Gg: AYBFou35G7WP3S94JQfCZzj5hOw03WzbANPzKNzkJ6JxhWVZO+4Pv6QXeib2ez2Okot
 PNvRhXXjvTGjgeE8CHYwmMUFsxd/ev0beF9h+sUoWAKG33IGoI4UFlRyZNyeb8WazYWOy5yNLNt
 BlkF//xU0M8tmUZUoNYhHSoLPOmzXUt6dm96qY6W8Mt7WC4+JPTTyTYGomcSLAskOmA7qLEUx9J
 vSIuMiBHa00tATdyh0DRgpMypR8DxlLH/iHtChX7pSasDKwcxTlxTTm0DRtN63MwE9UCXOEbz0P
 iOjXy2QZku6jDTzwx9LaypXI8unHWWv1+2hhrS+/BMNS8pdSFR2uORzuYJL5eX+s1Dg0YV0eT2V
 zXEcmRSOObfkrs0eGc8oLm9wbBUKV7ETWMad9OJwfQLdzVIY497p3dUghZy5RndvE3VDYGsWuZk
 kKi+A2KrM6AIT7r29qQS0mYSoQp9MhyTUZN9eb8WsX5ypiPcyjyGa0HMKpVW+xyamSw1an
X-Received: by 2002:a17:90a:da87:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-396d0d4c42fmr44338628a91.2.1788187453935; 
 Mon, 31 Aug 2026 07:44:13 -0700 (PDT)
Received: from i386.168.1.127 ([2402:a00:163:2ce9:6882:91b7:8e79:7958])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0dc854dsm28403095c88.10.2026.08.31.07.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:44:13 -0700 (PDT)
From: Hrushiraj Gandhi <hrushirajg23@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Hrushiraj Gandhi <hrushirajg23@gmail.com>
Subject: [PATCH] drm/fb-helper: use strscpy() instead of strcpy()
Date: Mon, 31 Aug 2026 20:14:05 +0530
Message-ID: <20260831144405.320914-1-hrushirajg23@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

strcpy() has no notion of the destination buffer's size, so it will
write past the end of fb_helper->fb->comm if the source string is
ever longer than expected. It isn't here today ("[fbcon]" always
fits), but strscpy() is the bounded, always-NUL-terminating
replacement recommended for all new and existing strcpy() users, so
convert this one too. fb->comm is a fixed-size array, so the
destination size can be derived automatically.

No functional change.

Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 80ca785bdb26..175311fac2e4 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1545,7 +1545,7 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 	if (ret < 0)
 		return ret;
 
-	strcpy(fb_helper->fb->comm, "[fbcon]");
+	strscpy(fb_helper->fb->comm, "[fbcon]");
 
 	return 0;
 }
