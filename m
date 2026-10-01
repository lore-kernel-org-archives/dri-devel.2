Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF70DCA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 00:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB8B10E20B;
	Thu,  1 Oct 2026 00:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WV/WELZd";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE33010E20B
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 00:50:51 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ee1f9bso28600695ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 17:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790815851; x=1791420651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+p/hrm6+chvYSoq4BTJEh28/132fMbyEn9rvNB7Zknw=;
 b=WV/WELZdDgOYP74Di8KJ4UJoTvdK9eHF75y2J43vbBhCAEgHtVGtdy5eVBKJjdnunR
 ErRMnGF9cbqZB6KadOUWKqIUQxY1W6pKcD7WNgFkT4sXscizECmDJuR22II4bHAZAA3b
 BapLli8T1F+zGqsGmhF9bBv7KoUmYAZGK0Z6iTRzhdqbhAewqEuMmW0eWH5GbFxa+uDj
 JZNXAJA7Y1+GKAKxWw1R+ybHQIdpAbNnrPXpIXbs7/qqlxMJIgImS1mrzSv1QGR2VaNr
 CBocCNiApiTwSXP3+9RaIsZ0UfJ16s3AiTVQO7wxRV03jXZoTYwdkxLq/NKC8V9kuc31
 REoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790815851; x=1791420651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+p/hrm6+chvYSoq4BTJEh28/132fMbyEn9rvNB7Zknw=;
 b=PdKT6rJ5xVWaZP2v/OQdiwlewsuRGCczPmEoe5zd2glnVwGGJ/i2dwqnT2/YCTDTzC
 vCiGA/PBG+rUd2YRmyAIuGSU+4E3NDYTxEx5owgV+uIUcE2DFkx1YofFLjWoQ3PVaZDr
 aJJAK48n8brSzcfS35Nqp9+7ZE8PG1GgakQdPVnUtW8mky9aEGbtBouqpwn9MW8C95kc
 qwQKBbT8VbSjbL5Ddu9ppz6TRZ2hxb6lcH6Ukv260AIRjY8qExQoFbSuqoNNGh2K75gE
 r/afHN7RRmLvtuPiUNDIMTbkFOxzdffM6NLYe8ODA/JPCNA4IpEL4V1Qpr/Mu2ESqnar
 qLqw==
X-Gm-Message-State: AFuF++kDtCzG3DFgek86+sdMolLLqThEAakCPVBYeDYF05v64oQujoK8
 c6S9XLG/MQTqQyI6OtP0sqZCwEj+DSuX0nM3HopLcOMRAr36m6feKJ2u
X-Gm-Gg: AYBFou39IfuoT88v8XaWoIq4SG0BbZxCK0uNO13Dfux5ijRuGu+hprVhcmLK8Uzd3ql
 FegQFIG7Gsm678gCcHAmOqG2/IUiKUOpej57McNgEKPNsZZ1F+s2pHHFaPMGuUzkaqOPr9+I1Or
 +QoFEzheMjHMAjKdFbw0BSnrc6pBGc7twNUSXzxsThlNDDdbwA8zvhY7UOurDij1UsvvQtEb5VG
 /b9+cCJ+AgNMRXfiUd26ID1tP8H7O+PkgiIFjKvR7H1ZmhVkcdPU+3gUa3FBxhDZ6999PVLOJ8Q
 K474YwF8jM70Cw55Jtl/ojHOJoO+TRDzuCMvXfvodkaZM3BSxDo6kx61emg+4Fjw/uX4o7gfqA6
 K0hiTA5KzAYx/dbHkvWHvdoeFM6ePntx5d1RxBnRNWqSC2AQQJXDezMuLum6iuh+Im9wfX4RdD9
 iCEmDBs19+yjmYmJnwZ3E8JyQzctMffam0yf8a3u8XolYWhiWpX+Xd3QJ85XrBWbJNqPk6pJm/w
 E7v/likXJYf99QCysA53X0vsbN5qBV8HX6ZRY99ewT0HQjd0+H6zGXudEL2UQtgAhf0Xh/KX6aK
 D93+Rw==
X-Received: by 2002:a05:6a20:9191:b0:3da:421e:40f3 with SMTP id
 adf61e73a8af0-3de9e69ac1emr2778847637.17.1790815851221; 
 Wed, 30 Sep 2026 17:50:51 -0700 (PDT)
Received: from pc130107.ADVANTECH.CORP (59-124-202-175.hinet-ip.hinet.net.
 [59.124.202.175]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88818815025sm270995b3a.18.2026.09.30.17.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 17:50:50 -0700 (PDT)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH v2] drm/panel: ronbo-rb070d30: Ignore DCS errors in disable()
Date: Thu,  1 Oct 2026 08:49:40 +0800
Message-ID: <20261001004940.110776-1-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
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

If rb070d30_panel_disable() returns an error, drm_panel_disable() skips
clearing panel->enabled. unprepare() still powers the panel off, but the
next drm_panel_enable() sees the panel as already enabled and does
nothing, so the panel stays dark.

Always return 0 from disable(). A failed ENTER_SLEEP_MODE is still logged
by mipi_dsi_dcs_enter_sleep_mode_multi().

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---

Notes:
    Changes in v2:
    - Add a comment explaining why the error is ignored (Doug)
    
    This applies on top of:
    https://lore.kernel.org/all/20260929080143.559685-1-hungen3108@gmail.com/
    
    v1:
    https://lore.kernel.org/all/20260930013029.3241267-1-hungen3108@gmail.com/
    
    Compile-tested on arm64 with W=1; not tested on hardware.

 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
index ebe6352db..9adf97aba 100644
--- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
+++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
@@ -87,7 +87,13 @@ static int rb070d30_panel_disable(struct drm_panel *panel)
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
-	return dsi_ctx.accum_err;
+
+	/*
+	 * Returning an error would leave panel->enabled set, causing the
+	 * next enable to be skipped even after unprepare powers off the panel.
+	 * The helper above already logs any command failure.
+	 */
+	return 0;
 }
 
 /* Default timings */
-- 
2.43.0

