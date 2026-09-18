Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4CBC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8875B10F2A0;
	Fri, 18 Sep 2026 10:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TRNJXa77";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249A910F2A2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:05:16 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48436686a40so70998f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789725914; x=1790330714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HE0w66JucLNZLzHyaLpT5/PcJD16pRz717b2QYdWvwk=;
 b=TRNJXa77LXH+z2+9N3wJBXPag79oCLAF6Ck01VjI1VYweGiCH4ygne2w9hah3Tqfke
 ex+Iq9K4eTqO4LA5ETt3ZsbY2QUsIHnLuak8X6v2XEx51wvKdBQUeeCKdN7u655EghjM
 RZ82CE7kIIiFGIZ4ZR9z2zNLtxaNNI1kf3gy1jjT0MDGCQNObAiCpuTRLBwfgm6VGSc8
 3fX8q8Iuh+BZ1Y1kBhH5kTpiEPO/OrOlI/VUnkILoNgYHPDgh/v4eYe2LtzmYQhmled4
 wD491T3Z6ERTnBpQQibx3SWX8DqbNYnos0KgKFtE3R4UBnbmbBu3blfbE5suB0ey+IHb
 xMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789725914; x=1790330714;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HE0w66JucLNZLzHyaLpT5/PcJD16pRz717b2QYdWvwk=;
 b=M1jVW86vBUMPUhYGnumWbXjB8CYeQ+vILuqTbwi+fuOgL6CurIrgCSCv55yRlDkF75
 uZmMVnUp3XA8LlBnNLTXC+5XE7vZc//qOQ2kw9wcDVmtZGTP+x+m2Gz+ggv11+Uz7P4N
 Lc3scWGjf7dKNdfqskZqpYJL+UjzAHTbOagc6vjAuZsnoT0aeuDHVixWHSld34OBmqGu
 JxP5Br/95HDlQfibywfN0lPp4sxrkPoVROxrChc/ZWiKWOHC+TQze+urLyXRC6JqHp3l
 WSc49yW/ree3/cLB06qw6N1DrM/+mHbPZRV2hiPKZU8ICARLbehnijcCigmoEnuDRyhf
 0LQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz40apPO/xgSvVU81uuBHgkEvM1ha0kkZyK9jPV/oyd/zq84K6Ih9UbT3/y3bN+5j4hE6rc6wgcbrs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kXkQMD7dsg52ZUZ+anXkbmk6HUNgSuc05XpVlVO501p+Y/QC3x
 t6bRXXsXHjNolSyIm+BDuNBI2qsKJ77pC0y4Z7DyRIgZ5lb3yhRyYjWu
X-Gm-Gg: AYBFou0e8++wAa97ll4A4yrarREnFN/3kHENCmzxX3R6rPyRgMvSubmvfuZPMKfFosE
 iIi2AnokQlcA4JDK/GQBBs6BeluYAA2/2c7ltki61I59CHF8rBdMqe0DVg2QAR+Dra9aFMx88tM
 fKsx+tqDfgX2ZPbE9qza5g71DifDs9E5MYTlr8K65sewN743sSITZwkH2bHZQmneKPFS82pObsm
 njlrG/ko7WEQRrYNahPOKqRKzShVMIxY2ncFco5So8B6Nyc0kkFrz3ZuSC8Mk8ZSY8Z2e+OmPfc
 w5Wj5IvgjiMqLDs/TmCVRinRiRS76HqYzR6GcCz/Ssfh0R13ECNmfbbPZJdy+R97rfPH5Vgwbtv
 Ts/mmVStOn/OPAjEww0ER4lkoBDkcF+aRuFcBBHxczptHEPbMMs0i8Kxn9mseGDxI1oAIjwU+Gp
 uQIUG/NfD0tUsHMPUy/W6c8+K0lzYmPbX1pt7LtC6x1zihR9gKJESjXHSCozCgOL03tWn5bZL/u
 LIEO+6vO4WCfX3JQ/FeRLqPjdJW1oygQiBMMFCFfrxprpnsMoIzQMmDYcH8l6031gAZ94RGQgDf
 VSE=
X-Received: by 2002:a05:600c:a00a:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49fc7b83237mr18820885e9.0.1789725914217; 
 Fri, 18 Sep 2026 03:05:14 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B829B006E521A2A508563A3.dsl.pool.telekom.hu.
 [2001:4c4e:1b82:9b00:6e52:1a2a:5085:63a3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc79bdc35sm42175125e9.0.2026.09.18.03.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:05:13 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Charlene Liu <Charlene.Liu@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Alex Hung <alex.hung@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lu Yao <yaolu@kylinos.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH] drm/amd/display: Fix audio DTO for HDMI YCbCr 4:2:0 on DCE
Date: Fri, 18 Sep 2026 12:04:43 +0200
Message-ID: <20260918100443.23694-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
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

On DCE 11.2, 11.22 and 12.x, audio runs at twice the sample rate while
an HDMI sink is in YCbCr 4:2:0. DTO0 is shared, so a DisplayPort
monitor on the same GPU is sped up as well.

get_pixel_clock_parameters() halves requested_pix_clk_100hz for 4:2:0.
The PHY PLL is programmed from that rate, but
dce112_program_pixel_clk_resync() sets PIXCLK_DOUBLE_RATE_ENABLE, so the
CRTC that feeds DTO0 keeps the full rate. build_audio_output() still
passes the halved rate on as the DTO0 module, which gives 48 MHz
instead of 24 MHz; its 4:2:0 branch is skipped on DCE, because the
requested clock is halved already.

Program the DTO0 module with twice requested_pix_clk_100hz when the HDMI
stream's clock source doubles the pixel clock, tested through the mask
field that enables the doubling; only the DCE 11.2, 11.22 and 12.x
clock sources have it. ACR (N/CTS) and az_configure() use a separately
built audio_output and do not change.

Lu Yao's patch (Link) doubles both clocks, but only for POLARIS12, which
also moves ACR to the 594 MHz table entry.

Tested on an RX 580 (Polaris10) with a TV at 3840x2160@60 4:2:0 and a
monitor on DP: DP audio was audibly sped up before the patch; after it,
a 17.63 s clip played in 17.71 s on DP and 17.70 s on HDMI.
DCCG_AUDIO_DTO0_MODULE now reads 5940000, the CRTC frame counter gives
60.00 Hz on a 4400x2250 raster (594 MHz), HDMI ACR status reads N=5120,
CTS=247500, and DP audio M readback (996) is the same as with the TV at
3840x2160@30.

Fixes: 87b58768eccd ("drm/amd/display: audio bug fix part 1: Add missing audio ACR")
Link: https://lore.kernel.org/all/20251205074344.143063-1-yaolu@kylinos.cn/
Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---

Not tested: the other DCE 11.2/11.22/12.x parts (Polaris11/12, VEGAM,
Vega), and 4:2:0 with deep color, which this sink cannot take (300 MHz
TMDS limit). DCN is left alone on purpose: its OTG halves the horizontal
timing for 4:2:0 (optc1_is_two_pixels_per_container()), so the halved
module is right there.

The host is an arm64 board (RK3588) and the RX 580 sits in an M.2
slot as an external GPU (PCIe 8.0 GT/s x4), not an x86 desktop.
The kernel under test was 7.3-rc3 plus local patches, one of which
touches the same 4:2:0 path (a longer REG_WAIT in dce_opp.c, not
submitted). The patch as posted was built and checked with sparse on
drm-amdgpu-next and on amd-staging-drm-next (arm64, W=1 C=1, no new
warnings for this file), but no module built from those trees was
loaded on the card.

An LLM assistant helped me trace the clock path, do the arithmetic and
write the patch and this message; sparse and checkpatch were run on the
result. The numbers above are wall-clock times and register reads taken
on the board.

Possibly the same bug, although none of the reports mentions 4:2:0:
https://gitlab.freedesktop.org/drm/amd/-/issues/3088 (RX 590, 60 Hz
double speed, 30 Hz fine), and the closed #556, #1742 and #922.
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index bb46d72490259..45c64c473a8cc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -51,6 +51,7 @@
 #include "link_service.h"
 #include "dccg.h"
 #include "clock_source.h"
+#include "dce/dce_clock_source.h"
 #include "clk_mgr.h"
 #include "abm.h"
 #include "audio.h"
@@ -2519,6 +2520,38 @@ static void dce110_reset_hw_ctx_wrap(
 	}
 }
 
+/*
+ * Audio wall clock DTO0 is fed by the CRTC pixel clock, so its module must be
+ * the rate the CRTC really runs at.
+ *
+ * For HDMI YCbCr 4:2:0, get_pixel_clock_parameters() halves
+ * requested_pix_clk_100hz, the PHY PLL is programmed at that rate and
+ * dce112_program_pixel_clk_resync() sets PIXCLK_DOUBLE_RATE_ENABLE, so the
+ * CRTC runs at twice requested_pix_clk_100hz. Only the DCE 11.2/12.x clock
+ * sources have that field in their mask.
+ *
+ * The audio_output used for ACR (N/CTS) is built separately and keeps the
+ * TMDS rate.
+ */
+static void dce110_audio_dto_fixup_420(const struct pipe_ctx *pipe_ctx,
+				       struct audio_crtc_info *crtc_info)
+{
+	const struct dce110_clk_src *clk_src;
+
+	if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A ||
+	    !pipe_ctx->stream_res.pix_clk_params.flags.SUPPORT_YCBCR420 ||
+	    !pipe_ctx->clock_source ||
+	    pipe_ctx->clock_source->id == CLOCK_SOURCE_ID_DP_DTO)
+		return;
+
+	clk_src = TO_DCE110_CLK_SRC(pipe_ctx->clock_source);
+	if (!clk_src->cs_mask->PHYPLLA_PIXCLK_DOUBLE_RATE_ENABLE)
+		return;
+
+	crtc_info->calculated_pixel_clock_100Hz =
+		pipe_ctx->stream_res.pix_clk_params.requested_pix_clk_100hz * 2;
+}
+
 static void dce110_setup_audio_dto(
 		struct dc *dc,
 		struct dc_state *context)
@@ -2559,6 +2592,7 @@ static void dce110_setup_audio_dto(
 			struct audio_output audio_output;
 
 			build_audio_output(context, pipe_ctx, &audio_output);
+			dce110_audio_dto_fixup_420(pipe_ctx, &audio_output.crtc_info);
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
 				struct dtbclk_dto_params dto_params = {0};

base-commit: e0e9c2257911b291ef5345635a9e6dfef5b2b424
-- 
2.43.0

