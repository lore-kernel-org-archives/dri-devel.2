Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCE9CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B3310E0DD;
	Fri, 29 May 2026 12:14:45 +0000 (UTC)
X-Greylist: delayed 309 seconds by postgrey-1.36 at gabe;
 Fri, 29 May 2026 12:14:43 UTC
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E0D10E0DD
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:14:43 +0000 (UTC)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 29 May
 2026 15:14:42 +0300
Received: from localhost (10.0.253.153) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 29 May
 2026 15:14:41 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Alex Deucher <alexander.deucher@amd.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/radeon: Fix OOB read in MC register table init
Date: Fri, 29 May 2026 15:14:34 +0300
Message-ID: <20260529121436.1633842-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.253.153]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
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

radeon_atom_init_mc_reg_table() copies the previous mc_data[] entry when
pre_reg_data requests DATA_EQU_PREV. However, the loop starts at i == 0,
so a malformed or unexpected table can make the first entry use
DATA_EQU_PREV and trigger an out-of-bounds read from mc_data[i - 1].

Emulate a fix for a similar issue in amdgpu_atombios_init_mc_reg_table,
see commit 51dfc0a4d609 ("drm/amdgpu: fix mc_data out-of-bounds read
warning"), by skipping DATA_EQU_PREV for the first entry.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: ae5b0abbb6f7 ("drm/radeon/kms: add atom helper functions for dpm (v3)")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. checkpatch warns that too many tabs were used but I can't do much
about surrounding code being already too deeply nested.

 drivers/gpu/drm/radeon/radeon_atombios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 3dd9724b331d..c6d229a4322f 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -4032,6 +4032,8 @@ int radeon_atom_init_mc_reg_table(struct radeon_device *rdev,
 										(u32)le32_to_cpu(*((u32 *)reg_data + j));
 									j++;
 								} else if ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
+									if (i == 0)
+										continue;
 									reg_table->mc_reg_table_entry[num_ranges].mc_data[i] =
 										reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
 								}
