Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1D6C43602
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62FA810E5DC;
	Sun, 28 Jun 2026 11:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=yeah.net header.i=@yeah.net header.b="AH7r4MkT";
	dkim-atps=neutral
X-Greylist: delayed 623 seconds by postgrey-1.36 at gabe;
 Sat, 27 Jun 2026 09:40:51 UTC
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690D210E489;
 Sat, 27 Jun 2026 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=C8
 lZKwGDt2f7adfxqjwjv6Pu205yOu85uuRaLpr0plU=; b=AH7r4MkTjx9B/YfpkH
 IaFn+WBB2AP4ofOm9ApJtcBXwAw8ccoKBgyuyoSsgqRthrwOUkTXu/qIVJdNmQtt
 WtXcZdPbP3y+SQiPpE11ddRuAswagu5PTFqFjXBjd4YA3F/BRvmjBNQ6LGFUkndm
 INgvyNOsbBpaiByRlRCM9ux2o=
Received: from zhang.. (unknown [])
 by gzsmtp2 (Coremail) with UTF8SMTPSA id Ms8vCgD3v1GMlz9qZpppAA--.53477S4;
 Sat, 27 Jun 2026 17:27:42 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ziran Zhang <zhangcoder@yeah.net>
Subject: [PATCH] drm/amd/display: Remove redundant NULL check before kfree in
 mod_power_create()
Date: Sat, 27 Jun 2026 17:26:12 +0800
Message-ID: <20260627092612.5282-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ms8vCgD3v1GMlz9qZpppAA--.53477S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF13Ww1rZw1rWFyDZryfXrb_yoW8Zry7pF
 4DKw15tw48G3W8KFnFg3W8XFy8Wa1kAFW3ur4UC3Wa9343Zr9YkF18A34YgFWDWFy7tF17
 tF1UKF4UXFyakw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUUUUUU=
X-Originating-IP: [116.149.202.60]
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiNg9zNGo-l4-U3wAA34
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

kfree() safely handles NULL pointers, so there is no need to check for
NULL before calling kfree().

Remove redundant NULL check.

Found by Coccinelle ifnullfree script.

Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
---
 drivers/gpu/drm/amd/display/modules/power/power.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
index 5659a38b3..74d5530de 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -270,12 +270,10 @@ struct mod_power *mod_power_create(struct dc *dc,
 fail_bad_brightness_range:
 fail_alloc_backlight_array:
 	for (inst = 0; inst < edp_num; inst++)
-		if (core_power->bl_prop[inst].backlight_lut)
-			kfree(core_power->bl_prop[inst].backlight_lut);
+		kfree(core_power->bl_prop[inst].backlight_lut);
 fail_construct:
 	for (i = 0; i < MOD_POWER_MAX_CONCURRENT_STREAMS; i++) {
-		if (core_power->map[i].psr_context)
-			kfree(core_power->map[i].psr_context);
+		kfree(core_power->map[i].psr_context);
 	}
 	kfree(core_power->map);
 
@@ -295,8 +293,7 @@ void mod_power_destroy(struct mod_power *mod_power)
 				MOD_POWER_TO_CORE(mod_power);
 
 		for (i = 0; i < MOD_POWER_MAX_CONCURRENT_STREAMS; i++)
-			if (core_power->map[i].psr_context)
-				kfree(core_power->map[i].psr_context);
+			kfree(core_power->map[i].psr_context);
 
 		for (i = 0; i < core_power->num_entities; i++)
 			if (core_power->map[i].stream)
@@ -305,8 +302,7 @@ void mod_power_destroy(struct mod_power *mod_power)
 		kfree(core_power->map);
 
 		for (i = 0; i < MAX_NUM_EDP; i++)
-			if (core_power->bl_prop[i].backlight_lut)
-				kfree(core_power->bl_prop[i].backlight_lut);
+			kfree(core_power->bl_prop[i].backlight_lut);
 
 		kfree(core_power);
 	}
-- 
2.43.0

