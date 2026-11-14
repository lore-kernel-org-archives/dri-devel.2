Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8C606A8AA
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8oTjNhs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17E310E6CD;
	Sat, 14 Nov 2026 03:04:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3552810E6CD;
 Sat, 14 Nov 2026 03:04:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1DBDC434EF;
 Sat, 14 Nov 2026 03:04:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794625445;
 b=oJ415dyJvaQJQ0oMtjGvshXU77mo2HPKPgMeha1SEubkdkpGylGIux4HsEOYlvZrbz8Q
 F/M0YEAepEQRYxqXaFBUYF/Zn7cy5upK/cLv9YKFmC+VDNLCZeCgfWrNZthYWh4YVkxsv
 vdksbyl4cuEdyTnmNm0keeBLQHzw8sV4LU9u3fNA+Massb5GNAEdf+1BoTGkaAthmkVC2
 32pFnDiBP3Ep8Jn72k9SeXpRYBIuejH0sSx27a0A7nRdO8t6hX93yuxqXfdUJcetfP+ue
 vUqYMW9fZI9zzY5DSWI1/I5bV/1F3AxKF1TFD87dGsebpaxuzX2FUopx+VAFxQXqGfw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794625445;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=QRQ6jhuuGbUMu36aQLZ2j3AICCOEDZJSvrMJ4XyeIEk=;
 b=NRGxGeiApzMyRXtlXoGubCQKkFghOdSGcUbsoBpVxcV81PCBv9M9bBbW7pgBunWKhFu1
 uxKdV7X6kUGVqG1wRP1g2akwIo5QEu3peN46rq2M5j686fVhLw8TK9q9pUpUbgDHZkLOn
 V1YPVv/HU2OA645QxjNJZwpjeD8Hdj1pDJBDpKXaXIMQ/ZRmy4qCSdNPNXs26Dve8ALrQ
 lL+tpwJnj4TFkgyTkblf0PluSJZZL2PajyUFyl7XGuBY6epXGfj3qXqKlkMv4DjvTPGev
 bEEEez+WeQ2eKq78uYhKZ/sdroHczRyYKrDg4fkURuyg7FcmzKuO4yGCq8Um61r4JJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 55D911F000C7;
 Sat, 14 Nov 2026 03:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794625444;
 bh=QRQ6jhuuGbUMu36aQLZ2j3AICCOEDZJSvrMJ4XyeIEk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=G8oTjNhsyPLarZgA+QHGKnGOY8TzKrFurRJk8/URdMU8DzOLM/BOLbNsJMou4h7jC
 uIolTegHa1McLIEIjynGcqibilPcxy1g18dH3jeYfFbDE/td2rtBVwVg3pCCVz9ii4
 BlCyqP3tZ0LIMaHcEJSyAUED9F9dnHeaeYmJjEUnCw3JvTtmxVdvTVn2qcVlvMdcTn
 hFURZUS+qe4hoxASjuTH5M81i/r7NmZWOQJlaTZJ+hd/6HmWZcfxfsZTlI3rw377/q
 9MexdG0rSr9KN1U1ER8VVo4/7iaus7RqiQgvfwM5epzdT0VJJVGF+NmI0ebxT7Z6GY
 Rv6AuX3y1BpEA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D177C49C59;
 Sat, 14 Nov 2026 03:04:02 +0000 (UTC)
From: Joshua Horne via B4 Relay <devnull+hornejd.etsu.edu@kernel.org>
Date: Fri, 13 Nov 2026 22:03:23 -0500
Subject: [PATCH 3/5] drm/amd/pm: show the smu8 overdrive sclk table
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-smu8-overdrive-v1-3-763f07bdfca9@etsu.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794625442; l=6141;
 i=hornejd@etsu.edu; s=20261109; h=from:subject:message-id;
 bh=jolYBmpiIvhINecVVNWDP81ZRRE4q6CH+InU4Wc4WYY=;
 b=Dta1yBLXAjTOSQf1jb9TZZew9rEdXBE5Khn5qqosSASdvxDQQcVPACWTgNVVbhzOMMUTy4C03
 J+RzHYq0tCEDgJ1VrgdtiHi+Rb+BrCCy8i1cP7m+IRxKM9CmdLL38E5
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joshua Horne <hornejd@etsu.edu>

Carrizo and Stoney upload up to eight graphics DPM levels to the SMU,
each with an engine clock, a VDDGFX voltage (GfxVid) and an NB voltage
(GnbVid) from the VBIOS dependency tables.

Prepare overdrive support for them in the pp_od_clk_voltage format of
smu7: keep the VBIOS levels and the user's edits in struct
phm_odn_clock_levels as smu7 does, and print the edits as OD_SCLK and
the allowed ranges as OD_RANGE. Only the levels that the SMU enables
(PPSMC_MSG_GetMaxSclkLevel) are used, as the VBIOS table can list
levels above the fused maximum of the part.

The engine clock may range from the lowest level up to the overdrive
limit of the VBIOS. Without a limit, the highest enabled level is used,
so only underclocking is possible, as smu7 and vega10 do since
commit 46defdd6fff7 ("drm/amd/pp: Allow underclocking when od table is
empty in vbios"). The voltage is limited to the range the VBIOS uses
for these levels and kept in mV as on smu7 and vega10, converted from
the VID with convert_to_vddc().

Overdrive stays disabled on these APUs until a later patch.

Signed-off-by: Joshua Horne <hornejd@etsu.edu>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 75 +++++++++++++++++++++-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h    |  7 ++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 77ab96bae4b0..93a7e7e176f3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1080,6 +1080,54 @@ static int smu8_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static void smu8_init_od_settings(struct pp_hwmgr *hwmgr)
+{
+	struct smu8_hwmgr *data = hwmgr->backend;
+	struct phm_clock_voltage_dependency_table *vddc_table =
+				hwmgr->dyn_state.vddc_dependency_on_sclk;
+	struct phm_clock_voltage_dependency_table *vdd_gfx_table =
+				hwmgr->dyn_state.vdd_gfx_dependency_on_sclk;
+	struct phm_odn_clock_levels *od = &data->od_default_sclk;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t i, mv;
+
+	if (!vddc_table || !vdd_gfx_table || !vddc_table->count ||
+	    vddc_table->count > ARRAY_SIZE(od->entries) ||
+	    vdd_gfx_table->count != vddc_table->count) {
+		dev_info(adev->dev,
+			 "OverDrive not supported by the sclk tables\n");
+		hwmgr->od_enabled = false;
+		return;
+	}
+
+	/*
+	 * Only expose the levels that the SMU enables: the VBIOS table can
+	 * list levels above the fused maximum of the part.
+	 */
+	od->num_of_pl = min(vddc_table->count, smu8_get_max_sclk_level(hwmgr));
+	data->od_min_vddc = U32_MAX;
+	data->od_max_vddc = 0;
+	for (i = 0; i < od->num_of_pl; i++) {
+		mv = convert_to_vddc((uint8_t)vdd_gfx_table->entries[i].v);
+		od->entries[i].clock = vddc_table->entries[i].clk;
+		od->entries[i].vddc = mv;
+		od->entries[i].enabled = true;
+		data->od_min_vddc = min(data->od_min_vddc, mv);
+		data->od_max_vddc = max(data->od_max_vddc, mv);
+	}
+
+	/*
+	 * Without an overdrive limit in the VBIOS only allow underclocking,
+	 * as smu7 and vega10 do. The voltages are limited to the range that
+	 * the VBIOS uses for these levels.
+	 */
+	if (!hwmgr->platform_descriptor.overdriveLimit.engineClock)
+		hwmgr->platform_descriptor.overdriveLimit.engineClock =
+			od->entries[od->num_of_pl - 1].clock;
+
+	data->od_edit_sclk = *od;
+}
+
 static int smu8_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
 	int result = 0;
@@ -1107,6 +1155,9 @@ static int smu8_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =  SMU8_MAX_HARDWARE_POWERLEVELS;
 
+	if (hwmgr->od_enabled)
+		smu8_init_od_settings(hwmgr);
+
 	return result;
 }
 
@@ -1510,7 +1561,8 @@ static int smu8_emit_clock_levels(struct pp_hwmgr *hwmgr,
 	struct smu8_hwmgr *data = hwmgr->backend;
 	struct phm_clock_voltage_dependency_table *sclk_table =
 			hwmgr->dyn_state.vddc_dependency_on_sclk;
-	uint32_t i, now;
+	const struct phm_odn_clock_levels *od = &data->od_edit_sclk;
+	uint32_t i, now, clk;
 	int size = *offset;
 
 	switch (type) {
@@ -1541,6 +1593,27 @@ static int smu8_emit_clock_levels(struct pp_hwmgr *hwmgr,
 				(SMU8_NUM_NBPMEMORYCLOCK - i == now) ? "*" :
 								       "");
 		break;
+	case OD_SCLK:
+		if (!hwmgr->od_enabled)
+			break;
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		for (i = 0; i < od->num_of_pl; i++)
+			size += sysfs_emit_at(buf, size, "%u: %10uMHz %10umV\n",
+					      i, od->entries[i].clock / 100,
+					      od->entries[i].vddc);
+		break;
+	case OD_RANGE:
+		if (!hwmgr->od_enabled)
+			break;
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		clk = data->od_default_sclk.entries[0].clock;
+		size += sysfs_emit_at(buf, size, "SCLK: %7uMHz", clk / 100);
+		clk = hwmgr->platform_descriptor.overdriveLimit.engineClock;
+		size += sysfs_emit_at(buf, size, " %10uMHz\n", clk / 100);
+		/* VDDC is the graphics (VDDGFX) rail of these APUs */
+		size += sysfs_emit_at(buf, size, "VDDC: %7umV %11umV\n",
+				      data->od_min_vddc, data->od_max_vddc);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h
index 05a06083e1b8..490fcc352a8f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h
@@ -25,6 +25,7 @@
 #define _SMU8_HWMGR_H_
 
 #include "cgs_common.h"
+#include "hardwaremanager.h"
 #include "ppatomctrl.h"
 
 #define SMU8_NUM_NBPSTATES               4
@@ -306,6 +307,12 @@ struct smu8_hwmgr {
 
 	uint32_t max_sclk_level;
 	uint32_t num_of_clk_entries;
+
+	/* overdrive: the VBIOS levels, the user's edits, the VDDGFX range */
+	struct phm_odn_clock_levels od_default_sclk;
+	struct phm_odn_clock_levels od_edit_sclk;
+	uint32_t od_min_vddc;		/* in mV */
+	uint32_t od_max_vddc;		/* in mV */
 };
 
 #endif /* _SMU8_HWMGR_H_ */

-- 
2.56.0


