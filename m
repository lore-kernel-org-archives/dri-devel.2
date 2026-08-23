Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E55C5DF98
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4EA10E3FA;
	Sun, 23 Aug 2026 11:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RsTKWWeM";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A7A10E02B
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:52:10 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso697405f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787485928; x=1788090728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OSPtUwy5dpHoeKHrqPLRAG3i1Kodm97L3d9KnmaS/Tw=;
 b=RsTKWWeM//pfGckTETlC2HbwYviV0rl/pLBcK6e30vyDGs3XpVHV0k5s6x9/fe84Sb
 gfCxeJuAZNTA5fujvWb8ZS0FDN+Q2bTILtJzQQ4UbqZHbR/GC9E269xPtLPkFkKO9A3w
 iWAP1YMNINC5odfiIfXmvF+h52mGCGIqGPrXhigfJB41mme70rLgyK7/n789jpNmpvb9
 /FVg2V6h9N7BVe0qVzQYbUkOefdotlPbsB2ECDC5SzFX0beFb+VzkFz/HrwHQQVeBBgv
 tb6HKb/P7seyX1xfGxDybPhce63BlpK3JiZuLpMLHD3R9xAYA6TxFbBtpP7RqFHG6A4t
 om3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787485928; x=1788090728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OSPtUwy5dpHoeKHrqPLRAG3i1Kodm97L3d9KnmaS/Tw=;
 b=qGiOskxbumvjqVIM49uzJ4UISQVT+KpyDblIN72g+Ka6HNbfmIEuJ24t+I5yO+NbPz
 B6Zmy+MRI40EFZ04od23IppmxQP9+LXPE07StiaHvX85KQ+g1g0eaGhsRb3ZCS8yKThl
 MLlOZlDSeBoxS3oLEC+SDvMSz+goIwc6b8h1ptVgqKac5LTRZMWbx2o3fwvrLk1FMIwi
 2rsmCAvB8FbQ9DBVFLVPqsnsnKFdWPu42bFeuUYiLnkNoJRIKv0/Z/wPEoDgSJhRDX+8
 DRrwfGoi6qktgnsbx1aEH75stay7M7M+UMI3EmP0SUXJW+hP1qhNFbnQbTk70zW+MrfU
 PrZQ==
X-Gm-Message-State: AFuF++mfXtDzJW6oteb01iRahp/lnays3EWzPFnRO8LNv5UpfixEtHFb
 Y0T2cM7bOJepGwzanQUhrNo3lS6F8LEkFtfrBMaCSDfs5SM5g99zf0JC
X-Gm-Gg: AR+sD13uLXbuyAY4KNP/Vn4GKIU0KnPFHlIANtd4YmlTUnth3W6rE+1pgKiYSIE4PmO
 LfY8EhyAuO2hA2JPFPIc5XEQ81ijXX3HCUGgLEGNH7GSUAUv4H1qZB4mgaZYCYLADST70PBw9TS
 HQ7LfmxEQr0ew8Z3O8v2NNeJf6QIs1Qxx52Lk5SwqNNaN22j4a15emldpw7E3qAjFHD6GBXZOlG
 JXLiG6/bmKsDkGzqE2UXjLeO2j41iMsn9h7nIBoJs5Oy+6CVB1a/OPI0U+vRW8Qrpx/vnkhEVzf
 RYDpNfxHXZU/Vv3GgqsOEeSIK6dCv3gnkOdP2TTfbTfFCqLcoM/bt4cBsk3ZGGC+CXg550EvBC1
 /lNpL/mp5Aom4WfPX9hULVTFda48/KisCb7MachBlSBOi2wq57dzBHJ8EIMg1FSj1wN0jrG+9dy
 Nrnb7h4mEIz5GzeSOxQT7wu1hr3LnCmE8YxqZ1ZUS9zoQBrRNOYdjk7uNOG3gIdcRZT/afiXUC7
 T0wu7pZN2CSZ1Pk4WEDM6fX747rOMaq
X-Received: by 2002:a5d:64c6:0:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-482c0b87e35mr22132720f8f.12.1787485927942; 
 Sun, 23 Aug 2026 04:52:07 -0700 (PDT)
Received: from cachyos-x8664 ([2a01:e0a:899:6110:90de:8744:7ad5:471e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9bfd865sm4682738f8f.22.2026.08.23.04.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 04:52:06 -0700 (PDT)
From: Julien Le Bourg <julien.lebourg8@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Wayne Lin <Wayne.Lin@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Julien Le Bourg <julien.lebourg8@gmail.com>
Subject: [PATCH v2] drm/amd/display: Restore self-refresh fallback in DCN21
 bandwidth validation
Date: Sun, 23 Aug 2026 13:52:00 +0200
Message-ID: <20260823115200.12502-1-julien.lebourg8@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822091715.6692-1-julien.lebourg8@gmail.com>
References: <20260822091715.6692-1-julien.lebourg8@gmail.com>
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

[Why]
Commit b96150a70696 ("drm/amd/display: Should support p-state under
dcn21") calls dcn21_fast_validate_bw() with allow_self_refresh_only
false. The second dml_get_voltage_level() pass, which retries with
dm_allow_self_refresh when no p-state capable voltage level exists,
is therefore never taken.

That fallback is the only way some short-vblank eDP timings can
validate. The AUO 1920x1080@360 panel on the ASUS ROG Strix G733QSA
(Cezanne, DCN 2.1) runs at 800.01 MHz with vtotal 1111: 31 lines of
vblank, about 77 us, too short for a DRAM p-state. It now fails
dml_get_voltage_level(), dcn21_validate_bandwidth() returns
DC_NOT_SUPPORTED, and the driver keeps 1920x1080@60 only:

  [drm] Mode Validation Warning: Unknown Status failed validation.
  create_validate_stream_for_sink: Unhandled validation failure 24
  Rejected mode: "1920x1080": 360 800010 ... 1095 1111 (ERROR)

This is a regression versus v6.18, where 360 Hz was enumerated and
usable.

That commit dropped the fallback to work around a flip_done timeout
under MPO. atomic_check (DC_VALIDATE_MODE_ONLY) and commit_tail
(DC_VALIDATE_MODE_AND_PROGRAMMING) were observing different
soc.sr_exit_time_us / soc.sr_enter_plus_exit_time_us, so a configuration
could pass check and fail in commit_tail. Passing true again without
fixing that mismatch would bring the timeout back.

[How]
calculate_wm_set_for_vlevel() overlays three DML soc latencies with
each watermark range entry:

	dml->soc.dram_clock_change_latency_us = table_entry->pstate_latency_us;
	dml->soc.sr_exit_time_us = table_entry->sr_exit_time_us;
	dml->soc.sr_enter_plus_exit_time_us = table_entry->sr_enter_plus_exit_time_us;

and restores only dram_clock_change_latency_us. The stutter latencies
keep the last entry (WM set A) in context->bw_ctx.dml. Watermarks run
only for DC_VALIDATE_MODE_AND_PROGRAMMING, so the leak is written into
dc->current_state at commit_tail. atomic_check validates
dm_state->context with MODE_ONLY and never computes watermarks, so the
two copies of soc can disagree on the next full update, which copies
current_state and re-validates.

Snapshot both stutter latencies in dcn21_validate_bandwidth_fp() and
restore them after dcn21_calculate_wm() and
dcn20_calculate_dlg_params(). The DCN21 DLG path
(dml21_rq_dlg_get_dlg_reg()) still reads soc.sr_enter_plus_exit_time_us
while computing Lwait, so restoring afterwards keeps DLG reading the
same latencies as today; only the leak into dc->current_state goes
away.

With check and commit_tail now using the bounding-box latencies, pass
allow_self_refresh_only true again. Modes that can p-state still
succeed on the first pass; the fallback is taken only when no p-state
capable voltage level exists.

dcn301_fpu.c has the same helper and the same restore gap. Left alone;
I cannot test DCN 3.01.

Tested on ASUS ROG Strix G733QSA (Cezanne, DCN 2.1): 1920x1080@360 is
enumerated and in daily use on a kernel built with this change. The
original MPO flip_done timeout is not reproduced here; that path is
reasoned from the code.

Fixes: b96150a70696 ("drm/amd/display: Should support p-state under dcn21")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5628
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Julien Le Bourg <julien.lebourg8@gmail.com>
---
v2:
 - Fix the soc stutter-latency leak that b96150a70696 worked around,
   then restore the fallback. v1 only flipped the flag and would have
   reintroduced the MPO flip_done timeout. Reported by the Sashiko
   review bot on v1.

v1: https://lore.kernel.org/amd-gfx/20260822091715.6692-1-julien.lebourg8@gmail.com/

 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index e82f2d531211..3697a3139552 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2321,6 +2321,8 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
 				 enum dc_validate_mode validate_mode, display_e2e_pipe_params_st *pipes)
 {
 	bool out = false;
+	double sr_exit_time_us;
+	double sr_enter_plus_exit_time_us;
 
 	BW_VAL_TRACE_SETUP();
 
@@ -2336,7 +2338,8 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
 	/*Unsafe due to current pipe merge and split logic*/
 	ASSERT(context != dc->current_state);
 
-	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel, validate_mode, false);
+	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from,
+				     &vlevel, validate_mode, true);
 
 	if (pipe_cnt == 0)
 		goto validate_out;
@@ -2351,9 +2354,29 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
 		goto validate_out;
 	}
 
+	/*
+	 * calculate_wm_set_for_vlevel() overrides the DML soc stutter
+	 * latencies with the values of each watermark range entry, but only
+	 * restores dram_clock_change_latency_us. Snapshot the two stutter
+	 * latencies and put them back once the watermark and DLG parameters
+	 * have been computed, so the override cannot leak into
+	 * dc->current_state. A later atomic_check() duplicates that state,
+	 * and validating against mutated latencies is what makes
+	 * atomic_check() and atomic_commit_tail() disagree.
+	 *
+	 * Restoring after dcn20_calculate_dlg_params() keeps the DLG
+	 * computation reading the same latencies as before, so this only
+	 * removes the leak.
+	 */
+	sr_exit_time_us = context->bw_ctx.dml.soc.sr_exit_time_us;
+	sr_enter_plus_exit_time_us = context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us;
+
 	dcn21_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, validate_mode);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
+	context->bw_ctx.dml.soc.sr_exit_time_us = sr_exit_time_us;
+	context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
+
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
-- 
2.55.0

