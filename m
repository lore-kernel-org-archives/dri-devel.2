Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06099C55184
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061A410EC57;
	Wed,  5 Aug 2026 01:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QZkszQLY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0A010EC54;
 Wed,  5 Aug 2026 01:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEeWFHHLIufGSAJBLtHFMbh78jlW8kIIlKlX2DaMJJdKPEeUTHQo3dqLarXNJKFq939tdr37bCQ4iVfWowiXeeOTSRGkSTvN5BM/8DNFB5fHDnngboFW0RE+4yoKNvDydcDeTKTP8vzgHFHgT/UP9HVPx6/cwqN8mb4sOmGcZeZu8va++ZVnqKhrOPpK15ydEDk8VtqMQ3eU5l1yhWAi5xD2s8Imh36XhVWj3FgYG6BP5epX6c1CSwImugQOA0/sg47inifwfHEqiK4iDb3i8Nfi92vDtfrXdTtl4XY0iQAY+8RTCey9Mn0W8Whma9PupO38ya2T5C6pAI4LJ2j2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt3Fufm9mXBBk0vZcM0lt+6s3Qx/ZYcta9b9uxxOs5M=;
 b=N9MoO2azCvyy1glBSOMaaPpUttOI/qL14vRwp15pOnlJJSJJjJXGYJFuKF8sOYkLSbCiu/+KSWRCZJHw7F8HLbyP7g+IaHU740eXxpeWgo73SafwT6wnTZktDDdHeceZ4PipNzI8ycWkPZGyPj8A6RmZ1f8dM5sHIJm2pLpvZQ216934oI47C4gxbAazL0mU58wW9+S6KUkXDtC52+4BqC4GeozMafg3JNYGKYiDJ9fWWsF+dGsV+IcVev7SOwFU1Rc8EE7ByUqW/IV69IC52PKIa5FldH84oEr7hvoz020hTCC9gWIsg5Ic74WFFlTRNTCfbztnwigPN64W8Ise/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt3Fufm9mXBBk0vZcM0lt+6s3Qx/ZYcta9b9uxxOs5M=;
 b=QZkszQLYdxioI5wobkmT2sWTrAb10EYpEGIWKGtIBrZBOYOWqeyf8DiPJ+v33gLYn6JxYcJO86KmtCBSFD6+HmPKA/uzRKbks61yyzXBNxKAdplgAQ+BIUnl/UbJRYbWk+tfbH9sZT1ZhwAW2jaxUQORkX5743tjYgqW5VRNDbo=
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 01:24:07 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::a8) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 01:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 01:24:06 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 20:24:02 -0500
From: Honglei Huang <honghuan@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
CC: Ray Huang <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Tomasz Siemek
 <tomasz.siemek@amd.com>, Wayne Lin <wayne.lin@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH] drm/amd/display: avoid NULL hubp deref when filling mpcc_id
 on DCE
Date: Wed, 5 Aug 2026 09:23:50 +0800
Message-ID: <20260805012350.1458583-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d8c80d-1190-4607-7342-08def2903e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|11063799006|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: /rnZcyYHOCKeq/YKL1YDjrqX3AnlhVEZVKTeK5KqTrNOubjSPe/oQ0NFcNF4CjCO3Y2In5ltZv8ovE4e3kws47ewSCch2xeS15DrXk4PO3tdHk+BHXvbz6Nyzr1YEFDUjc+N9wEFyE0ITNmVgu/NaCo2k8zvdLqmdZYgS6zZwBq/Ot6d15mEuQf1V7Ap9CdD6GM1I/SjofHp9ltjfi4NSDUrur06/I9BJ541YaueGSUYokTWhFpTTIt/m9uJzguSiDhHfUuY313YsOqTrR/dNmdmLTMGWt3fpzOW7p7mdEK+4UYGLpAE8KGtkXJrlM0tYCKeKbYbwTf5FDSOe89t8WjjEJzfu5/Vt/wPVo0M+pnJHY1wbKZlyh/t2VZuh5jxelcHgAuRVjM5Bgvk7mFNmdkh/gU3d9ke7GU7giCf5t19+SlurPtHKISuzGoZ9TeoLXyBzLhVJVhlBCjbW9efpM8PINl6Ymd0HeEI2pV9Fpi0TFF96i7KgKDK+iLBN2h2NGcwL4Msri0XLUhbeOpIQpMXP6uMONXG9VaU/8ljLPrEr7MXSuANbPCMbZrSshqFUXQXXmw3dl4smHmkZfWS9FJ5cEspr7p3v2WvgAvS84FzORxH4j2F/uM1erJh8OCwr4jiN7FYKJG6Y90dmuCMSUY0Vr8gbHm6xdr21KlpzpISVaE7XFpNedxhpWL1lJAHD1/NYrlySL49O15sQWWr6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(11063799006)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O8/IfvI2XsyyjnB7fFnsQCmgETJZTLuSKs7V3S8Bct6j6eBO3ecBlKZrK7Ms0IJCHqGaIMyYy3WTPOBV1T4i8E3cqdFV6nde0+FTVNwkNWko9tS4NMzIchkUvHJ7EukSYIv2QN0NolB94+UTUaoytqiVqCXlGjn/jsklmA6W6eNkZ73QGmFBlY8+CSPycgeSVtAVYn/vTW+KvXe2KrJfwG7cmmIXLrPtfjg59Plk82KsZg2BpZNTUM5c0CD6raNGrK+hKyCMJULsWsjxiOplh93Z6Lkr3gWoy6XFvV8kw7Pzm6b/ApVsPhB5IbEpZeVCcfEe8VgFruYU2Rf1uSKeuw9aEAF+1LrzODuecqaF+7FUOCqXxIQ8X2UsdqPeONay4Rb3lEwG4xsZaeOp9U03vosnHx1ngQCjUPoKPNZdNAJLKoxKJXi6GyHWqApT+V7/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 01:24:06.7444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d8c80d-1190-4607-7342-08def2903e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
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

HUBP only exists on DCN. On ASICs that use DCE, such as Vega20, the display
pipe never owns a HUBP, so pipe_ctx->plane_res.hubp stays NULL.

The block sequence rework now fills mpcc_id inside the generic helpers in
dc_hw_sequencer.c by reading pipe_ctx->plane_res.hubp->inst. On a DCE ASIC
that read follows the NULL pointer and faults at offset 0x88, where the
inst field sits in struct hubp, and the box dies on the first modeset:

  BUG: kernel NULL pointer dereference, address: 0000000000000088
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP NOPTI
  CPU: 14 UID: 0 PID: 531 Comm: plymouthd Not tainted 7.1.0 #70
  RIP: 0010:hwss_set_output_transfer_func+0x69/0xc0 [amdgpu]
  Call Trace:
   dce110_program_front_end_for_pipe+0x4d7/0x5c0 [amdgpu]
   dce110_apply_ctx_for_surface+0xf1/0x270 [amdgpu]
   commit_planes_for_stream+0xba1/0x1c80 [amdgpu]
   update_planes_and_stream_v2+0x297/0x6f0 [amdgpu]
   dc_update_state_prepare+0x6f/0x1c0 [amdgpu]
   dc_update_state+0x41/0x60 [amdgpu]
   dc_update_planes_and_stream+0x43/0x70 [amdgpu]
   amdgpu_dm_atomic_commit_tail+0x1a6f/0x4120 [amdgpu]
   commit_tail+0xc5/0x1a0
   drm_atomic_helper_commit+0x137/0x160
   drm_atomic_commit+0xaf/0xf0
   drm_client_modeset_commit_atomic+0x1ec/0x230
   drm_client_modeset_commit_locked+0x5b/0x170
   drm_client_modeset_commit+0x27/0x50
   __drm_fb_helper_restore_fbdev_mode_unlocked+0xe8/0x110
   drm_fbdev_client_restore+0x12/0x20
   drm_client_dev_restore+0xbb/0x100

DCE never uses mpcc_id, so 0 is a fine value when there is no HUBP. Add a
small helper that returns the HUBP instance, or 0 when it is missing, and
use it for every mpcc_id assignment. DCN is unchanged since HUBP is always
there.

Fixes: f879f53407f0 ("drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_FUNC to drop pipe_ctx")
Fixes: 9403e15b2ab1 ("drm/amd/display: Refactor DPP_PROGRAM_GAMUT_REMAP to drop pipe_ctx param")
Cc: Tomasz Siemek <tomasz.siemek@amd.com>
Cc: Wayne Lin <wayne.lin@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 11411fa946..7676aa4485 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -729,6 +729,16 @@ void get_fams2_visual_confirm_color(
 	}
 }
 
+/*
+ * Return the MPCC instance for a pipe. On DCN it matches the HUBP instance.
+ * DCE has no HUBP and ignores mpcc_id, so return 0 there instead of chasing a
+ * NULL pointer.
+ */
+static int hwss_pipe_mpcc_id(const struct pipe_ctx *pipe_ctx)
+{
+	return pipe_ctx->plane_res.hubp ? pipe_ctx->plane_res.hubp->inst : 0;
+}
+
 void hwss_build_fast_sequence(struct dc *dc,
 		struct dc_dmub_cmd *dc_dmub_cmd,
 		unsigned int dmub_cmd_count,
@@ -1073,7 +1083,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 					params->dpp = current_mpc_pipe->plane_res.dpp;
 					params->mpc = dc->res_pool->mpc;
 					params->xfm = current_mpc_pipe->plane_res.xfm;
-					params->mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+					params->mpcc_id = hwss_pipe_mpcc_id(current_mpc_pipe);
 					params->plane = current_mpc_pipe->plane_state;
 					params->stream = current_mpc_pipe->stream;
 					params->is_top_pipe = current_mpc_pipe->top_pipe == NULL;
@@ -1118,7 +1128,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 				otf_params->dpp = current_mpc_pipe->plane_res.dpp;
 				otf_params->xfm = current_mpc_pipe->plane_res.xfm;
 				otf_params->mpc = dc->res_pool->mpc;
-				otf_params->mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+				otf_params->mpcc_id = hwss_pipe_mpcc_id(current_mpc_pipe);
 				otf_params->is_top_pipe = resource_is_pipe_type(current_mpc_pipe, OPP_HEAD);
 				otf_params->stream = current_mpc_pipe->stream;
 				block_sequence[*num_steps].func = DPP_SET_OUTPUT_TRANSFER_FUNC;
@@ -1128,13 +1138,13 @@ void hwss_build_fast_sequence(struct dc *dc,
 				dc->hwss.update_visual_confirm_color) {
 				block_sequence[*num_steps].params.update_visual_confirm_params.dc = dc;
 				block_sequence[*num_steps].params.update_visual_confirm_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].params.update_visual_confirm_params.mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+				block_sequence[*num_steps].params.update_visual_confirm_params.mpcc_id = hwss_pipe_mpcc_id(current_mpc_pipe);
 				block_sequence[*num_steps].func = MPC_UPDATE_VISUAL_CONFIRM;
 				(*num_steps)++;
 			}
 			if (current_mpc_pipe->stream->update_flags.bits.out_csc) {
 				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpc = dc->res_pool->mpc;
-				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.mpcc_id = hwss_pipe_mpcc_id(current_mpc_pipe);
 				block_sequence[*num_steps].params.power_on_mpc_mem_pwr_params.power_on = true;
 				block_sequence[*num_steps].func = MPC_POWER_ON_MPC_MEM_PWR;
 				(*num_steps)++;
@@ -1837,7 +1847,7 @@ void hwss_add_dpp_program_gamut_remap(struct block_sequence_state *seq_state,
 		params->xfm = pipe_ctx->plane_res.xfm;
 		params->dpp = pipe_ctx->plane_res.dpp;
 		params->mpc = pipe_ctx->stream->ctx->dc->res_pool->mpc;
-		params->mpcc_id = pipe_ctx->plane_res.hubp->inst;
+		params->mpcc_id = hwss_pipe_mpcc_id(pipe_ctx);
 		params->plane = pipe_ctx->plane_state;
 		params->stream = pipe_ctx->stream;
 		params->is_top_pipe = pipe_ctx->top_pipe == NULL;
@@ -1883,7 +1893,7 @@ void hwss_add_dpp_set_output_transfer_func(struct block_sequence_state *seq_stat
 			.xfm = pipe_ctx->plane_res.xfm,
 			.dpp = pipe_ctx->plane_res.dpp,
 			.mpc = dc->res_pool->mpc,
-			.mpcc_id = pipe_ctx->plane_res.hubp->inst,
+			.mpcc_id = hwss_pipe_mpcc_id(pipe_ctx),
 			.is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD),
 			.stream = pipe_ctx->stream,
 		};
@@ -1900,7 +1910,7 @@ void hwss_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx)
 				.xfm = pipe_ctx->plane_res.xfm,
 				.dpp = pipe_ctx->plane_res.dpp,
 				.mpc = dc->res_pool->mpc,
-				.mpcc_id = pipe_ctx->plane_res.hubp->inst,
+				.mpcc_id = hwss_pipe_mpcc_id(pipe_ctx),
 				.is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD),
 				.stream = pipe_ctx->stream,
 			}
@@ -3840,7 +3850,7 @@ void hwss_program_gamut_remap(struct pipe_ctx *pipe_ctx)
 			.xfm = pipe_ctx->plane_res.xfm,
 			.dpp = pipe_ctx->plane_res.dpp,
 			.mpc = dc->res_pool->mpc,
-			.mpcc_id = pipe_ctx->plane_res.hubp->inst,
+			.mpcc_id = hwss_pipe_mpcc_id(pipe_ctx),
 			.stream = pipe_ctx->stream,
 			.plane = pipe_ctx->plane_state,
 			.is_top_pipe = pipe_ctx->top_pipe == NULL,
-- 
2.34.1

