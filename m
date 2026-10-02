Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8625ECA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C79510E551;
	Sun,  4 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="YbrNijNw";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A83310F9FB
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 19:37:59 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1433e7b057fso124031c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790969878; x=1791574678;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EGgEtdhM8SzSotKxZXA7cTlPWzHiA22Nw8COOnRZiR4=;
 b=YbrNijNwfSR6sfus5TS9ZHAS/skpcmKrf1L0xFtrnxgf7PuGmHZqCUKTBPwYcFBhCA
 ieDICpdw5oLwr14rMyQoJey12qQ+IWF+loaJN4t79YZGnEZr783nHQzSuB8oePECD5K8
 V2QsJnOD3Gg49FNF87Vxu1r0SXdDUXROiPvDVjE0j3aCoOK0zHFP0UL0Hwha7YWOJvj3
 0by/nvgh0fHB0Mm/A+ifL+Vv0UZ7MUFQDBTqcCNhxpOVCbzn5hiyPUpG+c+1JgQ/eGzD
 9Z1/gUD8Q3WRaXEDQMx0nhHezy5xCWDO+8v0o+CZo3ammyCOkdgXDbPRfQS5G+NNDKz/
 Txtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790969878; x=1791574678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EGgEtdhM8SzSotKxZXA7cTlPWzHiA22Nw8COOnRZiR4=;
 b=mAov4CHXRCLyHjWQ+SQBpzOIk6+5NbSds5akkY++c2BwKJ9IqFjDP8Sszu/bsUPBa4
 uUtT9iCHi+l7sY4z9hOXWVmpZMygnwFO34X3V0pLr5thSq0/GFMMhsZjduOKr1TlfRPB
 yfzA1RFS4MpwFmgIGXDaE+eynJnfL/kk7yJvBb/slmKIUXjJqJuqbRNYeabJv7ZeN+jc
 dMcvEopyY+XZ0cGnyfA/JwGEGVnCxICv8cdLY2ZcQexulsRntmHqMHI2d+sA3qUXZZLa
 tTBVAYMMa8mzGhMNCHAJuGZ1syncRi8bfJvAYlCBxscdBW7LsOxy6Pia2j6vTHV1SvDk
 y0AA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy40AT3KLdZE5eFBZfoxaAvtSc0IqxOO2M+dJjORIK5K4hGddbrn+S2Ue4OLSpJs9d9VB8nUxcnmqU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nMNxh6W4dTPKAcc/vUloEcLkevTsQ9yzzWZJXsdJAAvsnnWq0Z
 2NQXWFB5mLOZO8gdVvbmTW14dRniTF/S8vOUZYXsXTZwsPg3kYm1Os1Vk/bnClC2aac=
X-Gm-Gg: AYBFou0GlDVnoUisCI68tpzRF3wrLs0gIjCCiPa7A9gKKlBAV326kr7k0DAJMTEoJ3M
 C7enoGzDZX47LGytt9gixiJTMU8/FpjCTRgrwSqNOe+8/AHpcCAveO4DHp+S10xXO0s0tOlRG7S
 jzwIN71VMxC8ycecCaZyB3z0rzbdif5ilHeo2vRksflFmHewpTw6OgEtZqODqlSocPT9xRRhQmy
 9hZA/G1FnTSW1IBk6xM79iwWMRh16Vx9cYFYQTKIzuOSBYEfut7cydclrtX9LodEkK6ehDZ9XQG
 tr4XB7hZDwdQqrlav9o7dmhxnbGUOUiec/z49w8X3GNwf+Up6vOuSWM1ABGdhPAvh9wNt1OCghA
 ZaTdyxP0/HCy/hNJuqAFCTmkyuqmO5235hVn4ECb/BKsBBlIHfFCk9CRkPbR1rd5OIMIsOM1quq
 oWN7pzJ7BB47OM0Dr/qcj6RtDFVxk3fW0cBV4AHXIOlkKEZ9/qNPrge7BDor6eIrCm4Ilw7P4tq
 bwVa72uwQMQ7d0Xfu8YeZbY+dAJXF9Io824tX/trNnDu+iflMEHnDffnvOoH9uLhZC3Dm3jmkiM
 8o5qEg==
X-Received: by 2002:a05:701b:4518:20b0:149:49c:233 with SMTP id
 a92af1059eb24-151c38af23amr469208c88.27.1790969878266; 
 Fri, 02 Oct 2026 12:37:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14fae9b3dfesm6642483c88.11.2026.10.02.12.37.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Oct 2026 12:37:57 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.1.y] drm/amd/display: Validate function returns
Date: Fri,  2 Oct 2026 15:37:52 -0400
Message-ID: <20261002193753.20239-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c ]

[WHAT & HOW]
Function return values must be checked before data can be used
in subsequent functions.

This fixes 4 CHECKED_RETURN issues reported by Coverity.

[ Backport to 6.1.y: adapted the visual-panel, watermark, and
  link-detection checks to their older locations. The upstream DMUB
  run-list/D3 path is absent; the older dc_dmub_srv_cmd_queue() already
  checks and logs idle-wait failures but, unlike upstream, still retries
  the queue once afterwards. No DMUB queue change is included. ]

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-46775. It carries the three return-value
checks that map to 6.1.y: visual-panel validation, p-state watermark
propagation, and sink-detection validation during link-training retries.

The upstream DMUB run-list/D3 path does not exist here. I left 6.1.y's
older dc_dmub_srv_cmd_queue() unchanged. It already checks and logs the
idle-wait result, but unlike upstream it still re-queues once after a
failed wait, and checks that re-queue's status.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-46775
Upstream: 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c    | 3 +--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c        | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 82b747c0ed693b..1d3d9a82c4637d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2808,8 +2808,7 @@ bool perform_link_training_with_retries(
 		if (status == LINK_TRAINING_ABORT) {
 			enum dc_connection_type type = dc_connection_none;
 
-			dc_link_detect_sink(link, &type);
-			if (type == dc_connection_none) {
+			if (dc_link_detect_sink(link, &type) && type == dc_connection_none) {
 				DC_LOG_HW_LINK_TRAINING("%s: Aborting training because sink unplugged\n", __func__);
 				break;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 31bb7e782c6b1d..35e8f22d30204b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -396,7 +396,8 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	enum dmub_status status;
 	unsigned int panel_inst = 0;
 
-	dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst);
+	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst))
+		return;
 
 	memset(&cmd, 0, sizeof(cmd));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index aacb1fb5c73eb5..d2eebe39a55e33 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -595,7 +595,8 @@ static bool hubbub2_program_watermarks(
 		hubbub1->base.ctx->dc->clk_mgr->clks.p_state_change_support == false)
 		safe_to_lower = true;
 
-	hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
+	if (hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
 
 	REG_SET(DCHUBBUB_ARB_SAT_LEVEL, 0,
 			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
-- 
2.39.5
