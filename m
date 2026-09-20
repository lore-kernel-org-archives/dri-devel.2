Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B42C982CC
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 09:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BBAB10E174;
	Sun, 20 Sep 2026 09:18:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C3C10E174;
 Sun, 20 Sep 2026 09:18:20 +0000 (UTC)
X-UUID: 3685ee60b4d411f19a56ed5b684f684d-20260920
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:42612d84-1e3c-4e25-b768-c423ce21bcbc, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:7db8b62, CLOUDID:ecfdb6ef14b8cd681db867337ac55f37,
 BulkI
 D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
 5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3685ee60b4d411f19a56ed5b684f684d-20260920
X-User: yanglinlin@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yanglinlin@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 2144921555; Sun, 20 Sep 2026 17:18:16 +0800
From: Linlin Yang <yanglinlin@kylinos.cn>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, austin.zheng@amd.com,
 jun.lei@amd.com, sunpeng.li@amd.com, christian.koenig@amd.com,
 Linlin Yang <yanglinlin@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] drm/amd/display: fix __udivdi3 link error in UTM QoS model
Date: Sun, 20 Sep 2026 17:18:07 +0800
Message-Id: <20260920091807.667682-1-yanglinlin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

When building amdgpu for 32-bit x86 (CONFIG_X86_32), modpost fails
with:

  ERROR: modpost: drivers/gpu/drm/amd/amdgpu/amdgpu.ko: symbol
  '__udivdi3' undefined!

The UTM QoS helpers dchub_v2_get_sop_total_available_bandwidth_KBps()
and dchub_v2_is_qos_bandwidth_supported_by_sop() divide a 64-bit
bandwidth product by 100 using the native '/' operator. On 32-bit
targets GCC lowers this to a __udivdi3() libgcc call, which the
kernel does not link into modules.

Replace the raw divisions with div_u64(), the kernel's standard
64-bit division helper.

Fixes: 7f7d7ea1fa51 ("drm/amd/display: Add new sources for DCN6")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Linlin Yang <yanglinlin@kylinos.cn>
---
 .../bounding_boxes/utm_qos_model_dchub_v2.h   | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
index ebca5ddda284..39df427a9ee7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
@@ -3,6 +3,7 @@
 // Copyright 2025 Advanced Micro Devices, Inc.
 #ifndef UTM_QOS_MODEL_DCHUB_V2_H
 #define UTM_QOS_MODEL_DCHUB_V2_H
+#include <linux/math64.h>
 #include "utm_qos_model_types.h"
 
 struct utm_qos_model_dchub_memory_path_latency_v2 {
@@ -63,22 +64,22 @@ static inline void dchub_v2_get_sop_total_available_bandwidth_KBps(
 	uint64_t dram_available_bandwidth_KBps_urgent;
 	uint64_t fabric_available_bandwidth_KBps_urgent;
 
-	dram_available_bandwidth_KBps_nominal = (uint64_t) sop->uclk_khz
+	dram_available_bandwidth_KBps_nominal = div_u64((uint64_t)sop->uclk_khz
 			* socbb->dram_channel_count
 			* socbb->dram_channel_width_bytes
 			* socbb->dram_transactions_per_clock
-			* socbb->dram_derate_percent_nominal / 100;
-	dram_available_bandwidth_KBps_urgent = (uint64_t) sop->uclk_khz
+			* socbb->dram_derate_percent_nominal, 100);
+	dram_available_bandwidth_KBps_urgent = div_u64((uint64_t)sop->uclk_khz
 			* socbb->dram_channel_count
 			* socbb->dram_channel_width_bytes
 			* socbb->dram_transactions_per_clock
-			* socbb->dram_derate_percent_urgent / 100;
-	fabric_available_bandwidth_KBps_nominal = (uint64_t) sop->fclk_khz
+			* socbb->dram_derate_percent_urgent, 100);
+	fabric_available_bandwidth_KBps_nominal = div_u64((uint64_t)sop->fclk_khz
 			* socbb->fabric_datapath_to_dcn_data_return_bytes
-			* socbb->fabric_derate_percent_nominal / 100;
-	fabric_available_bandwidth_KBps_urgent = (uint64_t) sop->fclk_khz
+			* socbb->fabric_derate_percent_nominal, 100);
+	fabric_available_bandwidth_KBps_urgent = div_u64((uint64_t)sop->fclk_khz
 			* socbb->fabric_datapath_to_dcn_data_return_bytes
-			* socbb->fabric_derate_percent_urgent / 100;
+			* socbb->fabric_derate_percent_urgent, 100);
 
 	total_available_bandwidth->nominal_bandwidth_KBps =
 			dram_available_bandwidth_KBps_nominal < fabric_available_bandwidth_KBps_nominal ?
@@ -112,9 +113,11 @@ static inline bool dchub_v2_is_qos_bandwidth_supported_by_sop(
 	nominal_available_bandwidth_KBps = available_bandwidth.nominal_bandwidth_KBps;
 	urgent_available_bandwidth_KBps = available_bandwidth.urgent_bandwidth_KBps;
 
-	if ((nominal_available_bandwidth_KBps * nominal_utm_budget_percent / 100) < qos_bandwidth->nominal_bandwidth_KBps)
+	if (div_u64(nominal_available_bandwidth_KBps * nominal_utm_budget_percent, 100) <
+			qos_bandwidth->nominal_bandwidth_KBps)
 		return false;
-	else if ((urgent_available_bandwidth_KBps * urgent_utm_budget_percent / 100) < qos_bandwidth->urgent_bandwidth_KBps)
+	else if (div_u64(urgent_available_bandwidth_KBps * urgent_utm_budget_percent, 100) <
+			qos_bandwidth->urgent_bandwidth_KBps)
 		return false;
 	else
 		return true;
-- 
2.25.1

