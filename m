Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70724C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB72510E8A5;
	Tue,  4 Aug 2026 07:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="t2V3saQI";
	dkim-atps=neutral
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418A510E8A4
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1785827925;
 bh=5OdXdwVkKMvJZy3PJIdUzTFPS2ew2EOKKVLqSbTuvnI=;
 h=From:To:Subject:Date:Message-Id;
 b=t2V3saQIbQc4ATi8Id2O9T8tGblRwTnRjiq234XlUXBkDwzVmFx0S69SsZdWfGRTo
 bG2eAKCh1zbbAbdt5qsmOe5ecczMwonNAQAoGsGydG4p7maChgeUId9snR3mV2Lx3v
 YpLz8Agiq6ieqmif4bDzglIxBAfXJ6oSq6EB5OuM=
X-QQ-mid: esmtpsz19t1785827286te761e50b
X-QQ-Originating-IP: jAGfl1lILVxOAP7hFzihW/Tj4azNJ1oZJNnSI76z3b4=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 04 Aug 2026 15:08:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16862773005327173646
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
Subject: [PATCH v6 3/7] drm/display: Add soft depend for
 aux-hpd-typec-dp-bridge module
Date: Tue,  4 Aug 2026 15:07:26 +0800
Message-Id: <20260804070730.68-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260804070730.68-1-kernel@airkyi.com>
References: <20260804070730.68-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OH2bKVRJtexUevX5rQbf4OkDLF7k1VFPl8oL/n2v1wYueGOUraNzcery
 EmLWsXkA6TNhMHHo6xBaGNAHWjsvyTJcmbnh0vLpiE+s+I4wuumvSsAiDezB3OOfM88OnxR
 8fSOVP1WFtxwU0MXf2cAhHJ5hVUgqVaXBNbCArborepzq9lUfh6oBfS/DVrYx6julg3FIbM
 QPoAq5KbL0C3c1J1cde2I08AKoFoCvL3d+XJQ6dSshmP35QSJAAr1aYJAT+Y0LtSQ98HZa0
 O3WQyukZZp+pEeRWbM86BvnpYWNNfvwUKCNgiT1Zj5lA/spxBpOrbSxXX3BQCr/ckQzcMwX
 M9hHRzKAUh+bhaEW+qRBBUyQjhgNbvtXJ4rcCj8hQVjr5qZUmOjwOewkrRj50pp+ig+KwAe
 K9eQyvIZheobeHC0Y9C2pIGEN36wr3haqa29RsDsgtgjnMwPGKPwL+KiQCQroGjrBMNgt4g
 9ADfPvWGIHLnV40fdafl5o9W6630V1uPu9dRF3SepqovTfnN6h8yrZkqWI3wCZkH1pEIdWu
 ipcWjIjHPnwxjwgf7mFSINMMiI5b507QSbNoljiPaJdcl1zDyZwoaQrb5/QyNA5Fv1b9ZqT
 3R/uecTDQHCYWIn5pRiL8Tsn8FA3DFndBi4ixS/bQFJM797FteXyhdjf9ToSLXKOfA27L1o
 Nn8obeMJ8ZJyniGw36e75ZSyzufcDccFk5AwJHCJLoUqqJoEWXKamVyynMxD8qhz4dEO0/2
 wnaB3iuC8guoKIP73uAk2T/sal7SQGs7Fs8qkIKPI0V8tjVqe2TMTryTfJ27+cHouXuxhjC
 t11MJcv4ini5YowP7BMXjk+yxQKrUrPsSRpNBkmP82G8LOcDsnni/GLxQMvYoaFB2aIBs/o
 DJpwsHCiTaaY90t14At1A0KkJ4xgGx96L9xvrfCWIHJjnGfir79XUc0Riu6TKRaNAXdFLIc
 Oj8qEwett21J0uyfWUhg4ddKp6FK28PczW3WBdq0B/4aMxSE06LOy0TiroSCiryGwOTRK+b
 8MMxpfWw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The aux-hpd-typec-dp-bridge module serves as a generic TypeC
DisplayPort HPD bridge and is not required by any other
module. Therefore, it will not be auto-loaded.

Given that the drm_display_helper module houses DisplayPort-related
helper code, add a MODULE_SOFTDEP() within it to suggest loading the
aux-hpd-typec-dp-bridge module beforehand.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

(no changes since v6)

---
 drivers/gpu/drm/display/drm_display_helper_mod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/display/drm_display_helper_mod.c b/drivers/gpu/drm/display/drm_display_helper_mod.c
index d8a6e6228773..f0152d6b0b2d 100644
--- a/drivers/gpu/drm/display/drm_display_helper_mod.c
+++ b/drivers/gpu/drm/display/drm_display_helper_mod.c
@@ -18,5 +18,6 @@ static void __exit drm_display_helper_module_exit(void)
 	drm_dp_aux_dev_exit();
 }
 
+MODULE_SOFTDEP("pre: aux-hpd-typec-dp-bridge");
 module_init(drm_display_helper_module_init);
 module_exit(drm_display_helper_module_exit);
-- 
2.53.0

