Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EB2FCD0DB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9C210E750;
	Wed, 18 Mar 2026 08:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k+Xqoybt";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2619610E362
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 20:38:32 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso55777875e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773779910; x=1774384710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tq+9vciNJQvrVg3r3vbNnrgNdZFTOiV9Ezi7YDsDMj8=;
 b=k+XqoybtB7OPjVOY/On5quQQ9vfeGWEOvyEXPuoipdif/3su100BcJlJy7mSt82fjN
 zwerI7pifaDASKHz1M0VblTcucBzjAcj+rDwS91D2VW1cF/vnYmcbwNJA1i3SzJhj5Gl
 pu2APAsRLc2FS8Z8UyT9snfxZiq/PQT4GYgdCYAazhy7rnKlO/ctmAhjNOnJALWCTmtm
 5bynZ4Se9FW7tK7BzDj1K7ei0DRiStaQyZgAkMoj2rsCVao5i9WC6HomlIxkiF45483y
 B1I6YBP0PFYoDQQLSP6v675OwUqylKWxshpwrV9bsrQkIeSwIdYfif2V8yIU9pPCmFUp
 eshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773779910; x=1774384710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tq+9vciNJQvrVg3r3vbNnrgNdZFTOiV9Ezi7YDsDMj8=;
 b=Ps/XRPe9jbr6nE6zbfJb//4qzLBHYpWclhgsbSq+WLQuLCH8ZVEZj94HNHf0z7CAH2
 LBCL/UxnAS8VX8Y5qaum0FYjNmU7ENoIHRT1yH7+GAuKDdM3uX+QmjAyMY/ViUrNj5aG
 osk1aem5i+Ze5MfyAtKDs3ETwVRRkkbJEclWAs6ep2jDQ39zbQ74S2A9y1+6aaqo/iUb
 eUuL5RqbBRaWXz9zS1cDRL4RBpJX82PKtSUqeIqYb3gcNtSvtg9oTtvZY8Kzy43stiB+
 eirfSsWMZMjYID2GVxXuFwqfHUu67lKNWacIWJiaktN6/6IIE5d7KnBHgpYH5zntqIrQ
 vyrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD7pqyR5w6pqoDNNW1T7nla28WvIHVKSmlR2xE4hcgOf15xFTO/yBo8shWv4WvlSh0KEurVAqgSlY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDtcVxyDRhNmWoTgSeizuLsTiNYjhgJry7hx81oA03/IYCGqfD
 KINxWPO7KS4qsWa0ZOEbEmHoGWika2rvvSD+lERVEaGjPlwEwGsble3T
X-Gm-Gg: ATEYQzzdAO/Q6P2AapjKlRojVyzAHYHkyLiskXcu/EVQWJa4GxFiD6QS1Ni0XniDAXA
 LGQ6TmS1qa34vFlsmMwGS1TRqGGfyap5HEVAIgkLwv9e9mTsGjJGgLXD3iyrSGYZxdFSFJJ3avJ
 u5fr+OaZ4qABAiDC/iXWG3KnCSwoiD+pvmV0XpDSvGpCBei8RCGjyxt4W2WQWvLAs0vrCIAjEX4
 tCXpE3c8sHtiO8WuHgF+y/400yVBDtB/Yd13sETAS4U6tNr1Zm2TLXdM+cnFUFCCiYuX8sOsjfp
 b4TcMxYmrrrhPkzy87+EERm8wvfiPUuHFn6ONg+ZA/zBremqfa5eISlffyzba8rJ1hzUWE3HsIp
 OuWRxGvEdBXObwST8tZq8beT8//ZGKGEjPUqsXoxG48hRnfLo7V0Z4qf3S2uOM/tl6vRebTqJRn
 6A315IEJ8N7D0gfGJi78ISbd9VOulF0YXuVVZ7b5KxTdhrQh64gr1TWEtHqiP7DLXq0ohaVy99b
 iPuCZgUcIC7pD9Bu9GgRMSUC6M1
X-Received: by 2002:a05:600c:4c24:b0:485:3a93:3a9e with SMTP id
 5b1f17b1804b1-486f4422015mr8515695e9.10.1773779910120; 
 Tue, 17 Mar 2026 13:38:30 -0700 (PDT)
Received: from rhel.homenet.telecomitalia.it
 (host-82-51-8-214.retail.telecomitalia.it. [82.51.8.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4bc96c6sm2813695e9.5.2026.03.17.13.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 13:38:29 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com,
 alexander.deucher@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 Adriano Vero <litaliano00.contact@gmail.com>
Subject: [PATCH v2] drm/amd/display: clean up typecasts and constants in
 dcn4_calcs
Date: Tue, 17 Mar 2026 21:36:13 +0100
Message-ID: <20260317203613.5783-1-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index ca5ac3c0d..b7fe4fc92 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -202,7 +202,7 @@ static unsigned int dml_round_to_multiple(unsigned int num, unsigned int multipl
 		return (num - remainder);
 }
 
-static unsigned int dml_get_num_active_pipes(int unsigned num_planes, const struct core_display_cfg_support_info *cfg_support_info)
+static unsigned int dml_get_num_active_pipes(unsigned int num_planes, const struct core_display_cfg_support_info *cfg_support_info)
 {
 	unsigned int num_active_pipes = 0;
 
@@ -546,9 +546,9 @@ static bool dml_is_vertical_rotation(enum dml2_rotation_angle Scan)
 	return is_vert;
 }
 
-static int unsigned dml_get_gfx_version(enum dml2_swizzle_mode sw_mode)
+static unsigned int dml_get_gfx_version(enum dml2_swizzle_mode sw_mode)
 {
-	int unsigned version = 0;
+	unsigned int version = 0;
 
 	if (sw_mode == dml2_sw_linear ||
 		sw_mode == dml2_sw_256b_2d ||
@@ -1761,7 +1761,7 @@ static unsigned int CalculateVMAndRowBytes(struct dml2_core_shared_calculate_vm_
 		*p->PixelPTEBytesPerRow = (unsigned int)((double)*p->dpte_row_width_ub / (double)*p->PixelPTEReqWidth * *p->PTERequestSize);
 
 		// VBA_DELTA, VBA doesn't have programming value for pte row height linear.
-		*p->dpte_row_height_linear = (unsigned int)1 << (unsigned int)math_floor2(math_log((float)(p->PTEBufferSizeInRequests * PixelPTEReqWidth_linear / p->Pitch), 2.0), 1);
+		*p->dpte_row_height_linear = 1U << (unsigned int)math_floor2(math_log((float)(p->PTEBufferSizeInRequests * PixelPTEReqWidth_linear / p->Pitch), 2.0), 1);
 		if (*p->dpte_row_height_linear > 128)
 			*p->dpte_row_height_linear = 128;
 
@@ -3377,7 +3377,7 @@ static void calculate_cursor_req_attributes(
 	DML_LOG_VERBOSE("DML::%s: cursor_bytes_per_line = %d\n", __func__, *cursor_bytes_per_line);
 	DML_LOG_VERBOSE("DML::%s: cursor_bytes_per_chunk = %d\n", __func__, *cursor_bytes_per_chunk);
 	DML_LOG_VERBOSE("DML::%s: cursor_bytes = %d\n", __func__, *cursor_bytes);
-	DML_LOG_VERBOSE("DML::%s: cursor_pitch = %d\n", __func__, cursor_bpp == 2 ? 256 : (unsigned int)1 << (unsigned int)math_ceil2(math_log((float)cursor_width, 2), 1));
+	DML_LOG_VERBOSE("DML::%s: cursor_pitch = %d\n", __func__, cursor_bpp == 2 ? 256 : 1U << (unsigned int)math_ceil2(math_log((float)cursor_width, 2), 1));
 #endif
 }
 
@@ -12205,15 +12205,15 @@ static void rq_dlg_get_wm_regs(const struct dml2_display_cfg *display_cfg, const
 {
 	double refclk_freq_in_mhz = (display_cfg->overrides.hw.dlg_ref_clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;
 
-	wm_regs->fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
-	wm_regs->sr_enter = (int unsigned)(mode_lib->mp.Watermark.StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
-	wm_regs->sr_exit = (int unsigned)(mode_lib->mp.Watermark.StutterExitWatermark * refclk_freq_in_mhz);
-	wm_regs->sr_enter_z8 = (int unsigned)(mode_lib->mp.Watermark.Z8StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
-	wm_regs->sr_exit_z8 = (int unsigned)(mode_lib->mp.Watermark.Z8StutterExitWatermark * refclk_freq_in_mhz);
-	wm_regs->temp_read_or_ppt = (int unsigned)(mode_lib->mp.Watermark.temp_read_or_ppt_watermark_us * refclk_freq_in_mhz);
-	wm_regs->uclk_pstate = (int unsigned)(mode_lib->mp.Watermark.DRAMClockChangeWatermark * refclk_freq_in_mhz);
-	wm_regs->urgent = (int unsigned)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
-	wm_regs->usr = (int unsigned)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
+	wm_regs->fclk_pstate = (unsigned int)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
+	wm_regs->sr_enter = (unsigned int)(mode_lib->mp.Watermark.StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
+	wm_regs->sr_exit = (unsigned int)(mode_lib->mp.Watermark.StutterExitWatermark * refclk_freq_in_mhz);
+	wm_regs->sr_enter_z8 = (unsigned int)(mode_lib->mp.Watermark.Z8StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
+	wm_regs->sr_exit_z8 = (unsigned int)(mode_lib->mp.Watermark.Z8StutterExitWatermark * refclk_freq_in_mhz);
+	wm_regs->temp_read_or_ppt = (unsigned int)(mode_lib->mp.Watermark.temp_read_or_ppt_watermark_us * refclk_freq_in_mhz);
+	wm_regs->uclk_pstate = (unsigned int)(mode_lib->mp.Watermark.DRAMClockChangeWatermark * refclk_freq_in_mhz);
+	wm_regs->urgent = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
+	wm_regs->usr = (unsigned int)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
 	wm_regs->refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.UrgentLatency * refclk_freq_in_mhz);
 	wm_regs->refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.MetaTripToMemory * refclk_freq_in_mhz);
 	wm_regs->frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
@@ -12670,7 +12670,7 @@ static void rq_dlg_get_dlg_reg(
 			disp_dlg_regs->refcyc_per_vm_req_flip = (unsigned int)(math_pow(2, 23) - 1);
 
 
-		DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (unsigned int)8);
+		DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < 8U);
 		DML_ASSERT(disp_dlg_regs->refcyc_x_after_scaler < (unsigned int)math_pow(2, 13));
 
 		if (disp_dlg_regs->dst_y_per_pte_row_nom_l >= (unsigned int)math_pow(2, 17)) {
@@ -13226,7 +13226,7 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 
 	out->informative.misc.cstate_max_cap_mode = dml_get_cstate_max_cap_mode(mode_lib);
 
-	out->min_clocks.dcn4x.dpprefclk_khz = (int unsigned)dml_get_global_dppclk_khz(mode_lib);
+	out->min_clocks.dcn4x.dpprefclk_khz = (unsigned int)dml_get_global_dppclk_khz(mode_lib);
 
 	out->informative.qos.max_active_fclk_change_latency_supported = dml_get_fclk_change_latency(mode_lib);
 
-- 
2.47.3

