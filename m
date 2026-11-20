Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E55606A6FF
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A0F1P0fX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DEC112CD4;
	Fri, 20 Nov 2026 19:20:38 +0000 (UTC)
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5406D112CD4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 19:20:32 +0000 (UTC)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b3b45597c7so2799869c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795202431; x=1795807231;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KO/bgS9573WdL9OckehiaeYLsdBAM3AUhNlncBXYYkQ=;
 b=A0F1P0fXUHxRIdxezoynUK/u+ZuD4sU3Mq40cCj6e2X1g2+Q2xtymtirGakdiFr3ZP
 TewJ0SzxiFCTn7pLnSgUZ+o35J0o2cNNlLLuhDftFbOfx7V7c5fNprq77udkMLr9eQvA
 KYrouqBKKXvzyFCTmWvD/0LYAfFUa+Z/X9YqMCD7dDsljzyv96fNeH3er8Pcd07tIzCe
 3IZGNDsIYALX8YqluCy+WN72yfMtl6DCb5K49ocGalD0rvknBSqmOJoLqBkttvt5q3pR
 UWnKcFBKc0Jjr/HWP+kYj69Q+hnfhXbCftbOZRPDFUZp4LOnlO1HbFoWQ+uZb0R21RA3
 /fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202431; x=1795807231;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KO/bgS9573WdL9OckehiaeYLsdBAM3AUhNlncBXYYkQ=;
 b=W7JpkCwH5TPqmwvi+66zTRkhZ5meTYD42bwKOO28GbGHLOYmY0w2aK07997Iy/P44q
 lRx8jWsZol91qpyhcnaCqm1voB+uitI6USgzPcCQouLbh9kXhEVsaSA47RpWDk3djna6
 eNczmYQhXpkci3cx6lBvkzw03E3c0Gp0QFxtitKPfpjC4Xh0m8Q4qwa7lNy3pW49bfwE
 BZmDx28CVWPeoNuVgzAczXoKx+AEX14gBNV/QPkT6dX+b9Bdxi32w6pDJgVwjTJYi2LJ
 VIosTIBGqQlHJc8/y3+Km3ZXNSCP2tZp2if///OkokISGc1fshjWOH0mjD3rj+0gySAu
 6iyA==
X-Forwarded-Encrypted: i=1;
 AL+hErHSelb6WbuFCo0Hz4IBI9eeUXZDI4UhtUQ/92MIQkeCizYg72zCHpJDHL5sxVcXRGz6s4+G8vMDAb0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Ow46AZSngQI2TdQkvbG/PsUG59qckeu8bM31iLNu7wB9UCKGd
 MMdyP7hRdwbcIBPRHg1yPo5K4nqCYQ9sxgD80HBnTmTEhD1OHMJK3PDvsnnu3zXTdJp9YLhY5q4
 33w==
X-Received: from dlbvv25.prod.google.com
 ([2002:a05:7022:5f19:b0:1a4:c892:b166])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:907:b0:193:9aa3:474c
 with SMTP id a92af1059eb24-1b5568a9271mr3806499c88.21.1795202429856; Fri, 20
 Nov 2026 11:20:29 -0800 (PST)
Date: Fri, 20 Nov 2026 19:18:31 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120191831.2865901-1-elkin@google.com>
Subject: [PATCH] drm/rockchip: dw_hdmi: check IS_ERR() on
 drm_atomic_get_bridge_state()
From: Elkin Cruz <elkin@google.com>
To: Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Damon Ding <damon.ding@rock-chips.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_atomic_get_bridge_state() returns an ERR_PTR() on failure rather
than NULL. dw_hdmi_rockchip_get_bus_format() checks !bridge_state and
then dereferences bridge_state->input_bus_cfg.format, which faults if an
error pointer is returned.

Use IS_ERR(bridge_state) instead of !bridge_state.

Fixes: dc70272cc184 ("drm/rockchip: dw_hdmi: Propagate bus format to display driver")
Signed-off-by: Elkin Cruz <elkin@google.com>
---
I am trying out a new Clang static analysis linter for ERR_PTR/NULL
handling, and it flagged this code as possibly buggy. The findings were triaged
and fixed with an AI coding assistant, then checked against linux-next (not
runtime-tested on hardware).

Thanks,
Elkin

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index b6e154c35e7c..30191927593b 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -286,7 +286,7 @@ static u32 dw_hdmi_rockchip_get_bus_format(struct drm_encoder *encoder,
 		return 0;
 
 	bridge_state = drm_atomic_get_bridge_state(conn_state->state, bridge);
-	if (!bridge_state)
+	if (IS_ERR(bridge_state))
 		return 0;
 
 	if (bridge_state->input_bus_cfg.format != MEDIA_BUS_FMT_FIXED)
-- 
2.56.1.750.gf70dc682cf-goog

