Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6560A6F5A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B5710E8DE;
	Wed, 25 Nov 2026 15:40:15 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A312910E2F7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:40:08 +0000 (UTC)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 25 Nov
 2026 18:40:06 +0300
Received: from localhost (10.0.253.153) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 25 Nov
 2026 18:40:06 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Sandy Huang
 <hjc@rock-chips.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, Alexandre Marquet <tb@a-marquet.fr>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, <linux-rockchip@lists.infradead.org>, 
 <linux-arm-kernel@lists.infradead.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2 0/3] drm: analogix_dp: Handle runtime resume failures
Date: Wed, 25 Nov 2026 18:39:44 +0300
Message-ID: <20261125153958.1349811-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series addresses the unchecked return from phy_power_on() in
analogix_dp_resume(). The driver currently continues controller
initialization and reports a successful resume even if PHY power-on
fails. Patch 3 checks platform power-on and PHY setup errors and returns
them after unwinding the resources acquired by the resume attempt.

Propagating these errors safely requires two preparatory fixes. The
bridge setup and AUX paths currently ignore runtime-resume failures and
may still access hardware after a failed resume. Patch 1 checks resume
in those paths and avoids retaining a PM usage reference when it fails.

On Rockchip, the platform power_on() callback leaves pclk enabled if
setting eDP mode fails. Patch 2 fixes this partial rollback, allowing
patch 3 to return a platform power-on error without invoking power_off()
after an unsuccessful power_on().

Patch 3 depends on patches 1 and 2 and on the Exynos pipe-clock conversion
posted by Alexandre Marquet [1] (used in the development of this series),
or Marek Szyprowski's alternative [2]. Both move the pipe clock to
encoder enable/disable and remove the platform power callbacks.
Neither Exynos patch is included in this three-patch series; only one
of the two alternatives is required.

Important note on pending work: patch 1 overlaps with the pending
analog-init cleanups [3][4] and may require include-block adjustments when
combined with [5][6]. The bridge-detect PM fix [7] is complementary to
this series. Also, patch 3 is built on Pengpeng Hou's earlier
proposal [8] and addresses the platform power-on and
unbalanced-clock-cleanup concern raised in its review [9].

AI assistance: Codex was used to analyse the error paths, help draft the
changes and commit messages, and prepare this cover letter.

[1] https://lore.kernel.org/all/20261027-drm-misc-next-manta-auxbus-v1-2-3a45c3cf531d@a-marquet.fr/
[2] https://lore.kernel.org/all/20261119223843.3694307-1-m.szyprowski@samsung.com/
[3] https://lore.kernel.org/all/20261120083302.3719465-1-m.szyprowski@samsung.com/
[4] https://lore.kernel.org/all/20261111094845.1673-1-laixiangwu@cmss.chinamobile.com/
[5] https://lore.kernel.org/all/20261113082305.541652-1-damon.ding@rock-chips.com/
[6] https://lore.kernel.org/all/20261111164243.77775-2-blum@kernel.org/
[7] https://lore.kernel.org/all/20261119103742.1161858-1-m.szyprowski@samsung.com/
[8] https://lore.kernel.org/all/20260828091334.5793-1-pengpeng@iscas.ac.cn/
[9] https://lore.kernel.org/all/20260828092624.9054B1F000E9@smtp.kernel.org/

v1 -> v2: Use a better Fixes: tag in patch 3. Also, use goto-based error
pathing instead in patch 2 to avoid repeating calls.

Nikita Zhandarovich (3):
  drm/bridge: analogix_dp: Check runtime resume before accessing
    hardware
  drm/rockchip: analogix_dp: Disable pclk if setting eDP mode fails
  drm/bridge: analogix_dp: Propagate errors from runtime resume

 .../drm/bridge/analogix/analogix_dp_core.c    | 36 +++++++++++++++----
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 11 ++++--
 2 files changed, 37 insertions(+), 10 deletions(-)

-- 
2.43.0

