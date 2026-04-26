Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3684EFF885D
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 22:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1782010E229;
	Sun, 26 Apr 2026 22:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pxOFpbPH";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0506410E14E
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 19:19:13 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so6301250f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777231152; x=1777835952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zhjzk6+k9bpCPC8O+MN7tV3ddOFfrvXcuTes7z8vTpM=;
 b=pxOFpbPH1jut33I/dJ+EdE/A2hzNU+Hl+z+B+Wmkcuxma7CTGnEzBDxsAEt0xuQsIS
 4jRFoONLDIUcp8/Y2ywwcc8tAxwavIv/J+KKziRhMR4BOdIPMYrORbFTNWJhAvByahlY
 whJlV5b9s1XLRrIo5EW/7ZKDnZWR+M+Q8OU1Snr1xn8v84iYFg9ydLP8YsXqD9zumq1Z
 B4eft2Xu8Ea186z/NtR8T4/Www1g6lHdHAjS84Jl745eqk1nKMGAnYdxxDyXjF31w50L
 G2YwLm50pBnUIK3XtJNBKN1jg331Z5ZUYqeXE7HpIQ1JojUxe5JEwLqfcdMz3E6mYqpt
 vIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777231152; x=1777835952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zhjzk6+k9bpCPC8O+MN7tV3ddOFfrvXcuTes7z8vTpM=;
 b=If9qBRtNhMooYdhv8SIzBky05KXr+Jl0O+OPvGOMq2HCRJlPRPQ0S6I8zO7kQozquY
 lSPTSEVXVTuod3FBwBUZFuL/qC+u1TNJDgXfMvaH3/iwlcnPE9wtn5RJEfRzkrpuxcC/
 wefNb79/dRHgqKPF8GHxQr+uPbTI1f2t2kcVEBkMh4ZchMn1abfBa+SxCQX+Aa9ym3aT
 WCNNn+o1GQ3Aq65PoSRTRK+DP469FJR6cndEoH6CLhPJEnzTVd6x3yCp3kNzGN6a+C/v
 QtA7a4o70MBHwnJOe/Bs8R0k99qIk73cDRD12cPtSU+q8nIeQkhXvp82GbnWcLzA9rww
 zOOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ91VQaJYeg0KrZxwvFYOxzg0AU0wIQDsMv7qCkYpgSQY2wAy8W/UIiJFQ+84K+q3gar2FO3kv4smA0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrVFShdWDMTvdzhSPHr9W7f+JeCHSi6LjJwMKAzfYnqWyY4YSC
 9rlsTvEp+Wbkx3JWRH3c3sQVGVpjQOOE/B26kgajyPX9I2vZMCIi+nA2
X-Gm-Gg: AeBDiethSqo+JgWgnHXfxG2SrziAwqs5SZTP2CX+aP0Ib5PlbEEj/ZS6iA2iIVO7Gp6
 5Znq3NLlaEEqwzcro9bXIg1IKA7t857V325JotfzoBNfeye0I5OaU2wHPPyvQVDqMePuRVZzVHP
 CMCYQFennlbsFN5fgdSLalJWKh6wSkWoV9xLZo2qwLNOejU6OPVrnB7WPceKkjsRIqrAdtDn5HO
 Z557v8aeSzQun459SaEIq65OyVcu5oDEYuvtzbcldVs9DjoJhCgw2FphHBU4BSS19CWrddiBAMg
 ELpZwJOYp/FId6JjqkHZ36eDm15t7hJVl+D4kbTprsr7FFoQGOVf8LAULnRzJ3TPfcBQSKVnQfB
 GksRAkKPj2X2lmIzXuVd3fueftPhUYB+IiBWPLn2/9rQ//PTRWnBB4v+6i9JLxLA7yyTs0os5FF
 xR7i7PKHDvQext3ysacF+2RJgzaxs/0DQGu6wl7glwWVUCc9H4bLPvK0j/UmOHqxHD4m/v2b0k+
 IM8fXWl002Abp4SriQih2CJxul1bRhuUr2+paAxXp043NzZi4I=
X-Received: by 2002:a5d:5f84:0:b0:43d:7783:c684 with SMTP id
 ffacd0b85a97d-43fe3e1e092mr63569379f8f.43.1777231152150; 
 Sun, 26 Apr 2026 12:19:12 -0700 (PDT)
Received: from fedora.homenet.telecomitalia.it
 (host-82-60-237-185.retail.telecomitalia.it. [82.60.237.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a092sm39057567f8f.23.2026.04.26.12.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 12:19:11 -0700 (PDT)
From: Adriano Vero <adri.vero.dev@gmail.com>
To: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com
Cc: siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Adriano Vero <adri.vero.dev@gmail.com>
Subject: [PATCH] drm/amd/display: clarify average bandwidth comment in
 dcn4_calcs
Date: Sun, 26 Apr 2026 21:18:25 +0200
Message-ID: <20260426191825.9727-1-adri.vero.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 22:10:08 +0000
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

Replace a stale FIXME_DCN4 comment in calculate_avg_bandwidth_required()
that questioned whether cursor_bw and tdlut bandwidth should be included
in the average bandwidth calculation.

cursor_bw is already correctly included in all four accumulation
sites below the comment. tdlut bandwidth is intentionally absent
because tdlut data is fetched only during prefetch and blanking
intervals, not during active display, and therefore does not
contribute to active average bandwidth.

Also clarify the phantom pipe handling: phantom pipes are excluded
from sys_active average BW but included in svp_prefetch average BW,
which matches the existing code structure.

Signed-off-by: Adriano Vero <adri.vero.dev@gmail.com>
---
 .../dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c  | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index ca5ac3c0d..34a2a8326 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -2845,8 +2845,14 @@ static void calculate_avg_bandwidth_required(
 		dram_overhead_factor_p0 = dcc_dram_bw_nom_overhead_factor_p0[k] * mall_prefetch_dram_overhead_factor[k];
 		dram_overhead_factor_p1 = dcc_dram_bw_nom_overhead_factor_p1[k] * mall_prefetch_dram_overhead_factor[k];
 
-		// FIXME_DCN4, was missing cursor_bw in here, but do I actually need that and tdlut bw for average bandwidth calculation?
-		// active avg bw not include phantom, but svp_prefetch avg bw should include phantom pipes
+		/*
+		 * cursor_bw is included in the average bandwidth calculation below.
+		 * tdlut bandwidth is intentionally excluded: tdlut data is fetched
+		 * only during prefetch/blanking intervals and does not contribute
+		 * to active average bandwidth.
+		 * Phantom pipe contributions are excluded from sys_active but
+		 * included in svp_prefetch average bandwidth.
+		 */
 		if (!dml_is_phantom_pipe(&display_cfg->plane_descriptors[k])) {
 			avg_bandwidth_required[dml2_core_internal_soc_state_sys_active][dml2_core_internal_bw_sdp] += sdp_overhead_factor * (ReadBandwidthLuma[k] + ReadBandwidthChroma[k]) + cursor_bw[k];
 			avg_bandwidth_required[dml2_core_internal_soc_state_sys_active][dml2_core_internal_bw_dram] += dram_overhead_factor_p0 * ReadBandwidthLuma[k] + dram_overhead_factor_p1 * ReadBandwidthChroma[k] + cursor_bw[k];
-- 
2.53.0

