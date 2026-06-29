Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CD1C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760A810EAE9;
	Tue, 30 Jun 2026 07:19:14 +0000 (UTC)
Received: from mail.ksb-soft.ru (mail.ksb-soft.ru [5.167.76.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639FB10E8B9;
 Mon, 29 Jun 2026 13:15:36 +0000 (UTC)
Received: from ksb-289.ksb.ksb-soft.ru (unknown [10.38.22.14])
 by mail.ksb-soft.ru (Postfix) with ESMTPA id 4gpmpS3Fzhz4LKBh;
 Mon, 29 Jun 2026 16:09:52 +0300 (MSK)
From: Markov Gleb <markov.gi@npc-ksb.ru>
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Gleb Markov <markov.gi@npc-ksb.ru>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Mikhail Titov <titov.ma@npc-ksb.ru>
Subject: [PATCH] drm/amd/powerplay: add NULL check for vega10_ps
Date: Mon, 29 Jun 2026 16:09:49 +0300
Message-ID: <20260629130951.763-1-markov.gi@npc-ksb.ru>
X-Mailer: git-send-email 2.52.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 197590 [Oct 29 2025]
X-KLMS-AntiSpam-Version: 6.1.1.11
X-KLMS-AntiSpam-Envelope-From: markov.gi@npc-ksb.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 72 0.3.72
 80ff96170b649fb7ebd1aa4cb544c36c109810bd, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean
X-KLMS-LinksScanning: Clean
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 10.0.0.7427,
 bases: 2025/10/29 20:57:00 #27800623
X-KLMS-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

From: Gleb Markov <markov.gi@npc-ksb.ru>

cast_phw_vega10_power_state() can return NULL and the return result must
be checked.

Add a NULL check to avoid NULL derederence.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f83a9991648b ("drm/amd/powerplay: add Vega10 powerplay support (v5)")
Co-developed-by: Mikhail Titov <titov.ma@npc-ksb.ru>
Signed-off-by: Mikhail Titov <titov.ma@npc-ksb.ru>
Signed-off-by: Gleb Markov <markov.gi@npc-ksb.ru>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index c8c9fb827bda..83e62ab9c7f4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3844,6 +3844,8 @@ static uint32_t vega10_dpm_get_sclk(struct pp_hwmgr *hwmgr, bool low)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	if (low)
 		return vega10_ps->performance_levels[0].gfx_clock;
@@ -3866,6 +3868,8 @@ static uint32_t vega10_dpm_get_mclk(struct pp_hwmgr *hwmgr, bool low)
 		return -EINVAL;
 
 	vega10_ps = cast_phw_vega10_power_state(&ps->hardware);
+	if (vega10_ps == NULL)
+		return -EINVAL;
 
 	if (low)
 		return vega10_ps->performance_levels[0].mem_clock;
-- 
2.43.0

