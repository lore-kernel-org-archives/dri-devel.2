Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CE7C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CFDF10ED8E;
	Tue, 29 Sep 2026 08:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="M3Hz+FGH";
	dkim-atps=neutral
Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com
 [74.125.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF48F10E8EC
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:16:07 +0000 (UTC)
Received: by mail-dy2-f42.google.com with SMTP id
 5a478bee46e88-3428f70d7e7so2150655eec.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790651767; x=1791256567;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9ii7I0wGCyLeOvs236TbUzajnntIO2CSnGCaTsNpfSI=;
 b=M3Hz+FGHIC7hv7gKOCNKu57a1NnW2yJ2dIAi5eRYZOwxxWzaSj5JG6nfeKnTsNXgm5
 1lHY41r8tXpCBfFhxBwTNzVUYc5GlakKbmV5qAW0C81glUQDSJ/BIs4hOXJ/DlD2HtbQ
 JfH6Li4GETiOKKr4sZLBKdFuynxZS9U+3+UUycEYpf0nXH/YSmvezrAPlu5hiugc0k0B
 P03JeIytXs4FSnaeBLfthsCQeb2ZhuxhtfUVTvOGnwGcwf76taZKQxohprH7RMbS/Rxk
 eoTlJFPyTX3+rpft2wbNcI/WpRNQcyDI/OodP1tcG+x+Gv/j0fVvozlJnV6G/JBIP/5J
 htpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651767; x=1791256567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ii7I0wGCyLeOvs236TbUzajnntIO2CSnGCaTsNpfSI=;
 b=HCXbInWGQBo5gLAAHOC3X3YB2LSq2zwQ5v0Yv/ZgrsQWxWGwZuKGtv6sUV6JO4VDqY
 lXMGbBu1E2hjtJx+aL/RU3cMk+oaUBnIy2NInEjCzoRX5eMizjN50TZfFChsGEEYPNd9
 lH/C0OxS4VXg3AW9zSdr2sa9DYL5bb2xYZeR5i9joaxPYw80TO3On3doHkjVsCG5onpb
 /in4DOS0PgLRmDdf2XGn5+UEoHrZl6QNRiC21bZ6ZQBs+4RZrLB7md2mmnbDHDzaDv4d
 lr++XUD4QOWAheXnYoz6sz7uhUeOxlYqcpWX+8uH08PHZjwf1eu+QqnLG7xBZ4jAbJOP
 rsaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPcW6lw0vhsu7Iwa1DSYLVeYUF0y8e2ydpKeGLkggywt3G56RpTlQd8H0Bei/W9H+x4IVYf5T/r+U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLFSADO3pEyo9G1CuXLyECQlLYsLN1JMBiCDX41awkv77lnfd0M
 LQDWsgEeHIm0L6OhKt7739z01IyQ/r54bxQyH4xoI6WXdJbim8EqN+zmVrUEZ0XWDFI=
X-Gm-Gg: AYBFou1Hs9yWlGtScVxMNTeUlWzERmL+xhLRp5YuUiwxTdgEDRgHGv93Tzk9vI7aePp
 VymmgH7jl402h9axhzh5dRE4Rx0nssLfl0lGiYv/70Cgz2hJM2PNyRLZijaro7Uwx0H+JFUjbOq
 /RPL3TLEVOWQ6M1KItO4jGefzB6C5Ep0N+6bAJA+/qREjvw0F9XuJu/mwGSBl0eljQgqeogAizR
 x9EeG3r+2VA9+AndEOWP4gKZyJKfHwnoqdW4yJRRE7YtcFZxGBG0tzoMJ5qxU78XaQX8lLWvLeL
 edh8BjW2RsX1h2hhyYLpkepxTUL5lgjGLdaGXtpuZCRme9YRC4se+6rVRIprlWeZXowuuKDs/ro
 v8pf89xQ0ymhzLIWSYpz9zZMp0NkBGFeYj2K4tdFRC1pi5W5jyPIVbYmUix5I4c8L/og1H9gQ54
 /rrf2Qm/x3mLux6QSzT1JN4eDe1pqjhBz3KEp5iNZFTMsN9nvERCEGB5OljsxuSGdmSvmpMSXJS
 PtFfePFHcKdca1FnVzovEal7FI4sryyXnI7fqnG7pLFGNtDWYtKiwoJrcHq9WJwDyJjLfkYlnqH
 4Z7nKw==
X-Received: by 2002:a05:7301:7e04:b0:33b:c122:6bd4 with SMTP id
 5a478bee46e88-342701bed7amr10369531eec.6.1790651766957; 
 Mon, 28 Sep 2026 20:16:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-347323f5a7esm10711487eec.15.2026.09.28.20.16.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 20:16:06 -0700 (PDT)
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
Subject: [PATCH 6.6.y] drm/amd/display: Validate function returns
Date: Mon, 28 Sep 2026 23:16:01 -0400
Message-ID: <20260929031602.87583-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

[ Backport to 6.6.y: used the older dcn20 path and checked the applicable
  non-OK wait result; the surrounding D3-state case is absent. ]

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-46775. It checks four display-helper results
before their output is used.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-46775
Upstream: 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c               | 7 +++++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c        | 3 ++-
 .../drm/amd/display/dc/link/protocols/link_dp_training.c   | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 30a79dffbd37ab..b3f02f451535a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -144,7 +144,9 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 		if (status == DMUB_STATUS_QUEUE_FULL) {
 			/* Execute and wait for queue to become empty again. */
 			dmub_srv_cmd_execute(dmub);
-			dmub_srv_wait_for_idle(dmub, 100000);
+			status = dmub_srv_wait_for_idle(dmub, 100000);
+			if (status != DMUB_STATUS_OK)
+				return false;
 
 			/* Requeue the command. */
 			status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
@@ -405,7 +407,8 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	union dmub_rb_cmd cmd = { 0 };
 	unsigned int panel_inst = 0;
 
-	dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst);
+	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst))
+		return;
 
 	memset(&cmd, 0, sizeof(cmd));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index 6eebcb22e31739..2d87e85fdbac59 100644
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
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 08c2f117241407..539f57858dfec2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1683,8 +1683,8 @@ bool perform_link_training_with_retries(
 		if (status == LINK_TRAINING_ABORT) {
 			enum dc_connection_type type = dc_connection_none;
 
-			link_detect_connection_type(link, &type);
-			if (type == dc_connection_none) {
+			if (link_detect_connection_type(link, &type) &&
+			    type == dc_connection_none) {
 				DC_LOG_HW_LINK_TRAINING("%s: Aborting training because sink unplugged\n", __func__);
 				break;
 			}
-- 
2.39.5
