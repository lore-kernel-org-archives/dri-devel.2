Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB7606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ka5sAEOI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FDF10E416;
	Fri, 27 Nov 2026 00:06:58 +0000 (UTC)
Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C38410EAB7
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 00:06:53 +0000 (UTC)
Received: by mail-wr2-f8.google.com with SMTP id
 ffacd0b85a97d-48df4afd489so1894877f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795738011; x=1796342811; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JHqtsUs0ik0BieRJ8Sc/408xRW33ZRqGcrC9WKJdgzo=;
 b=ka5sAEOIFn1dxC0P56Qt7ALzTKZtPShFN0fP4q9MnWoviTcMOkGhDPD3SBqdWIgWs9
 xeXWOkXHqIjD5X8beAlRiXHRGnDupBl0d8kIZkqRDLjLAuj9psxIWi7P2KtBmzB2n4Sy
 xSSHbvtfdob/Tbj50EsCPPJotNKVaOhog9WCLiV4E31Vwm0BZMW3YEAKxO0A7T4F+ihg
 dIRIvUtvIESoCo+4d05BI48spWfDwi9VXn90gnLGvl37wIEVsaTLr0XoXggQSbK8TEd0
 1kw8SvvR80UQjz8X20V5of6+lqG/g74wznEGywLpaWNlMKQXOdJnEIcoFD44AWlqaTly
 1HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795738011; x=1796342811;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JHqtsUs0ik0BieRJ8Sc/408xRW33ZRqGcrC9WKJdgzo=;
 b=Ykex76iPMi3pUOCC8JaD6WrkagFNOE6MS+Rx4ksFrBRrT124WtAsjQV8iGyA8/jIK8
 j7PWXnzyBkdv0xwmSBBlJ9XksLyohHpj8Y5A+YFk5Ofdbuh27Iutnm7feCf03769mU7V
 lt+g8xriVdg0obiKpXYuCUKLBjAJXX+NcNkyXW14gjgllsrv10sOojYTi+Y6Bu6wyYnZ
 jpBqMTh6Z7qYiwyQJuC58Q/rrLg7nEX9mCTl/7bRWAf24sgFTSCVImLPIi+F9NiDFd/6
 PCjhjSprbc01tUpvcZq/zE8Eb1GclSer2Kk6NBfNjtY6r1wF/FLxuwlujbTZaJD6xtk5
 1g0w==
X-Forwarded-Encrypted: i=1;
 AL+hErEjGhw10czTXKQAWrAEWP/F/FsrLDeGjGE+10eQxj7135EnewC/sEJLpyrrkORfHKnj/bpsI1jJcjg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Ih98hJH3QqkbgEvKVky1jD63/dlT8ke7TTCyIN7gebRQXpaNm
 sLtxg+TxkG66d35LD5UkubvP9t0h5iwW4EOelF83/iwm5ElXdIw0sL/x
X-Gm-Gg: AZFdTZevTbytrJwxRY69nHUVqfey6A+gofFzJIMu5KyzHKgPWRQX4T6o8Zn0CGv/zn0
 hFu6MnZScI42j/xI+wAW1bx/sbJxLodO3kt++4rmAkiJBBIZDooAljtdAdDvjEkMcGqtLP7o5eQ
 p0KRmBe/0Z4HOb45MxwQ7Lnn5/YKL+Ee5mFt2IlBNLIY59hfEQGDsPal5f0VR3FV2X13RQbo13w
 1JZKJDJS3hVKiAzAK63pekfv8xHVn+cNHfbNaBBU5I2ga6Ly4FUFxMcCFgJpwTK8wjPGD5dpuRx
 xlBkUoE1i2eWLBF1x+HEbtM5V7YPjsNJzgvO2jMawv0XRAh2YarYK05zz7MfPu9ktCTGe9DFOx/
 X+90TsK/4/yh0EbNieliaEYbrWJb5QBquC6yXlUq/3oSWHreU/qtLtV7yK71uh8kaRS9gXAJ7e8
 yIg1wKCpTmbh/GmEvBei03f9M4ZMg+1Bo4Frfpyi0k4ebQG4KQh4tNOhSjqepP+f6VnqNyEHyYh
 zwbTjW5q+ZCbeK4JoYRoHvsgWK3+oa34Jio1/hz75JBkAYXZjvSTtg1Q6yRkYqni/jjfhM6N9Td
 MPT8gvNfaQG5mk0xExCad5dHfhHN7A7ROO+yOyNAADPSvTWbGK1oZJt9kw==
X-Received: by 2002:a05:6000:4381:b0:4a6:5a2a:f5a3 with SMTP id
 ffacd0b85a97d-4abaa9773abmr47659974f8f.3.1795738011470; 
 Thu, 26 Nov 2026 16:06:51 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61e8sm45145550f8f.11.2026.11.26.16.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 16:06:49 -0800 (PST)
Message-ID: <59629f46-5add-4fc8-aefc-c9e02b4d59d0@gmail.com>
Date: Fri, 27 Nov 2026 00:06:48 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v4 3/3] drm/amd/display: report synced displays to PowerPlay
 on DCE <= 10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On DCE 11.0 and 11.2, bw_calcs() computes all_displays_in_sync via
resource_are_streams_timing_synchronizable(), and
dce11_pplib_apply_display_requirements() copies it to
pp_display_cfg->all_displays_in_sync.

However, DCE 6, 8, and 10 (including iMac15,1 on DCE 8 and iMac17,1 on
DCE 10) use dce100_validate_bandwidth()—which does not call
bw_calcs()—and dce_pplib_apply_display_requirements() in
dce_clk_mgr.c, leaving pp_display_cfg->all_displays_in_sync unset
(false). Because PowerPlay is not informed that the streams have
synchronized vertical blanking intervals, SMU7 prevents MCLK switching
at idle or causes modeset underflows.

Set context->bw_ctx.bw.dce.all_displays_in_sync in
dce100_validate_bandwidth() using
resource_are_streams_timing_synchronizable() and copy it to
pp_display_cfg->all_displays_in_sync in
dce_pplib_apply_display_requirements(), matching the existing DCE 11
flow.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 3 +++
 .../drm/amd/display/dc/resource/dce100/dce100_resource.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index d891b3bfe2a1..1dd302ad19aa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -320,6 +320,9 @@ static void dce_pplib_apply_display_requirements(
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
 
+	pp_display_cfg->all_displays_in_sync =
+		context->bw_ctx.bw.dce.all_displays_in_sync;
+
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 97ea22af5d2b..0d25c2ddb661 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -888,6 +888,14 @@ enum dc_status dce100_validate_bandwidth(
 		/* TODO implement when needed but for now hardcode max value*/
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
+		context->bw_ctx.bw.dce.all_displays_in_sync = context->stream_count > 1;
+		for (i = 1; i < context->stream_count; i++) {
+			if (!resource_are_streams_timing_synchronizable(
+				    context->streams[0], context->streams[i])) {
+				context->bw_ctx.bw.dce.all_displays_in_sync = false;
+				break;
+			}
+		}
 	} else {
 		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
 		 * the DP clock, and shouldn't be turned off. Just select the display
@@ -900,6 +908,7 @@ enum dc_status dce100_validate_bandwidth(
 			context->bw_ctx.bw.dce.dispclk_khz = 0;
 
 		context->bw_ctx.bw.dce.yclk_khz = 0;
+		context->bw_ctx.bw.dce.all_displays_in_sync = false;
 	}
 
 	return DC_OK;
-- 
2.55.0
