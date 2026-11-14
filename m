Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8C606A887
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8WtbF5Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C5410E287;
	Sat, 14 Nov 2026 03:04:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199BC10E287;
 Sat, 14 Nov 2026 03:04:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE484405F2;
 Sat, 14 Nov 2026 03:04:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794625443;
 b=uFxuo+cJtVSQDiLfnwaZ0k2gLX8Xer4SOGmzlrB6w5W/emuBuPl60F3GJbBuBdWDYG2g
 hLcFjJ9uvC1Y4O/tJyIhI5eRJTAMR3KiwDmmtL0fkMPB8vKgTzf/qgmaGHBdmpua8V4Ai
 UB6qRKEvLdwwkUpPwWHujSBFeV5xCodm8/W7qzwojOekZZNlbYZi/f5e7XDxRaQN2LBYJ
 0PZtGjRs/MM6Dzyb0JWGrFfz8gASlwB+lijdWZ+fkj44Z8UD+Kb+eTcuFgo5mzT4dSu+J
 e62EfMaDjJIkVqkIN4SDVi5cYwB+s8f5E93fhcCQiD6pZSGFuCd6b7wHHDOSl6/ajnw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794625443;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=w9Dp/BExVuYBhie14zpKuAXc3M5SmXjuDTI3gzH/v2Q=;
 b=nywQYUdRLfA05Ykq78bj1/yfeSBnWLJrO8UcuhwFV9jE9dzvSktDdvy6lkznrAIYYoob
 jovuLEIEC+nnK6NpLAUCSCQ6ojk+9JW1kaULUU2wrcmmDlivfzyHPZZdiPL1M7ce+Xhsr
 ezgZRnMYfj2vEshtuxU1JObGJtfKR4Betv5jp6no6tGifAvrWtx6yfQGDpSkPsjDXEYVB
 87UiMkCFRTtQ6t2kxftGWUNbKwZYWbLi/LKUytGeSoOpAb2JHXMQsHyDns0v7wMtG+COw
 wjHzIVVLLPkduOriBqjMeNFzXZb+e7rFkG9QkzQD8T7doBCMbg3BwoNWNFRXDR/dysw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3E7441F000C6;
 Sat, 14 Nov 2026 03:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794625443;
 bh=w9Dp/BExVuYBhie14zpKuAXc3M5SmXjuDTI3gzH/v2Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=d8WtbF5Z701xaEolUVeAeUVqS047OelK9z1lzm8Ed6Vej12yN80PYPABT1Kf1+w2Q
 8NPCKyKy9k843aqgr8tSVgb8Yxh1TrkOJBDqBkl54dRBIXtNQ04Uvtp3/314LEYyrU
 MWxAjnFrO9/Ig3bpFu37iKCWWmACHAklCc9JnUqT9flz7kO+FosDAWKbiG3cxBtg8Z
 6qJB7hALib9c6bWuZBfDSWnVo6nJZ2OVxGKJQKlYXxcj8Qi1wLvpVMjF812XNB4Wgq
 0CzAqlCaWUyZWGBRKgOqp1jURSbHLajEDlUzy7+7CWgHIqaXdhbjaQsk8rvuQmLTMi
 bgrS1d8jYRNTA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BB6CB49C55;
 Sat, 14 Nov 2026 03:04:02 +0000 (UTC)
From: Joshua Horne via B4 Relay <devnull+hornejd.etsu.edu@kernel.org>
Date: Fri, 13 Nov 2026 22:03:22 -0500
Subject: [PATCH 2/5] drm/amd/pm: move smu8_populate_umdpstate_clocks() up
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-smu8-overdrive-v1-2-763f07bdfca9@etsu.edu>
References: <20261113-smu8-overdrive-v1-0-763f07bdfca9@etsu.edu>
In-Reply-To: <20261113-smu8-overdrive-v1-0-763f07bdfca9@etsu.edu>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>
Cc: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Joshua Horne <hornejd@etsu.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794625442; l=1905;
 i=hornejd@etsu.edu; s=20261109; h=from:subject:message-id;
 bh=icmV43/CUmi9JTSvBavBf9yqPU75EIUiWd54ROphH10=;
 b=7Di0r+wjCP88MGByT7D4MXRavnJh4bNqjOFbaUoSgaCDch4WZ/lYVHmpV4AlPtegHbAyqs9YC
 bFjztJvP1A2CPkaFkUKWJi1cFIqRBQpjFNqP7hHj9gGt1QGB25odhi1
X-Developer-Key: i=hornejd@etsu.edu; a=ed25519;
 pk=HNOtiwerBbrJhfhzLHLxj3GDsUH9udRXflqnaI8sQmQ=
X-Endpoint-Received: by B4 Relay for hornejd@etsu.edu/20261109 with
 auth_id=1469
X-Original-From: Joshua Horne <hornejd@etsu.edu>
Content-Transfer-Encoding: 7bit
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
Reply-To: hornejd@etsu.edu
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joshua Horne <hornejd@etsu.edu>

The overdrive support added next updates the UMD pstate clocks from a
new helper placed before smu8_set_power_state_tasks(). Move the function
above it, so that no forward declaration is needed.

No functional change.

Signed-off-by: Joshua Horne <hornejd@etsu.edu>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index f17894b5301f..77ab96bae4b0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -848,6 +848,18 @@ static int smu8_update_low_mem_pstate(struct pp_hwmgr *hwmgr, const void *input)
 	return 0;
 }
 
+static void smu8_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
+{
+	struct phm_clock_voltage_dependency_table *table =
+				hwmgr->dyn_state.vddc_dependency_on_sclk;
+
+	hwmgr->pstate_sclk = table->entries[0].clk / 100;
+	hwmgr->pstate_mclk = 0;
+
+	hwmgr->pstate_sclk_peak = table->entries[table->count - 1].clk / 100;
+	hwmgr->pstate_mclk_peak = 0;
+}
+
 static int smu8_set_power_state_tasks(struct pp_hwmgr *hwmgr, const void *input)
 {
 	int ret = 0;
@@ -988,18 +1000,6 @@ static void smu8_reset_acp_boot_level(struct pp_hwmgr *hwmgr)
 	data->acp_boot_level = 0xff;
 }
 
-static void smu8_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
-{
-	struct phm_clock_voltage_dependency_table *table =
-				hwmgr->dyn_state.vddc_dependency_on_sclk;
-
-	hwmgr->pstate_sclk = table->entries[0].clk / 100;
-	hwmgr->pstate_mclk = 0;
-
-	hwmgr->pstate_sclk_peak = table->entries[table->count - 1].clk / 100;
-	hwmgr->pstate_mclk_peak = 0;
-}
-
 static int smu8_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 {
 	smu8_program_voting_clients(hwmgr);

-- 
2.56.0


