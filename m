Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84806606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dphuidRG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B3810F929;
	Wed, 25 Nov 2026 01:05:59 +0000 (UTC)
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com
 [74.125.225.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFF410F934
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 01:05:54 +0000 (UTC)
Received: by mail-wr2-f11.google.com with SMTP id
 ffacd0b85a97d-4a4afca056bso1655868f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 17:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795568752; x=1796173552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JHqtsUs0ik0BieRJ8Sc/408xRW33ZRqGcrC9WKJdgzo=;
 b=dphuidRGSmJVlT2TD7T3CZtIIIyUBduT09CZNVJFakKp0re3h/3R+OBDRI5GTOLzPt
 6rWDtFdTG5JGskrRfFhdCRydlStChmHMkm+EFrwTuODyGtawi+xGOkhslpKGiCvKLMmK
 zxDfu/UehcUXerEztak9Yrfe2EekHaidGgpFZLtCIbT+4/j+/zPtAXgJ2dCWKDK0Af4p
 udDFombHCaKQxGa6WVNnr3j6NHU1xcMn3Q19uwOmm9SOUroZFd4Gi9QPS3FS/pC41BSn
 WqMCjixzf9IeLrcQeWcrucxtnakjliQ72d5uDiXsJ0M7y+FnS+0feoBMZGD/IhrZW/Ez
 6hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795568752; x=1796173552;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JHqtsUs0ik0BieRJ8Sc/408xRW33ZRqGcrC9WKJdgzo=;
 b=oLq+onBTBJCpPVTWc5XQWSGyM8c7ABWYE1NtGnoda1S3q3b+ORExY9Kf92BPfKY8J2
 q1QlL4BWYXia9REH6p0CMoEzr5xUaYP83Z+s0b0QsOIDZyFQ2t/O+lke9oKw7kgbqZtC
 CHO1QgY0t4mPYgh9p5GRx+aJwQze+M46l99yCjUuhFUTt24XZqEJV6vQLd3MFiMRhOy6
 LQ326pYvcPEiNcikYzGYRT2lXNvFps2RXpZoNEoNcY0wWiTHm+zfmZMWX3cfpOEr4Vsp
 IgyL683gCErSQFh0vVFDwTTgueMZFb+xjCtjpc7y67EiT73RPPbVDPhDnug/o3K/FqTb
 5aFA==
X-Forwarded-Encrypted: i=1;
 AL+hErFqRsJicLxpc+bqv3oVyxMxyYW2+tQHVKQ7M3FDVidsrTU+j/mCgo3DynPPueIExepKopnDSPXavgg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+FgaFTDq24vg3jIQie6QNV2ISCUAx5/Mt4ryHhMnSOeywkoG74
 zN9J5YW5yDHPozmP7spEQwkDEjA9aqaU5VpajUrp6GLwb5vC5M2jhcqP
X-Gm-Gg: AZFdTZezX2q4Fod4o+J1QXDb/HuU/qByaZnoJegtx8J72IUz+XF4GNg6OZBXuS/aBmL
 Zf/x9QKJ8YrHbylCuGiYl+hbzBwN7lnJZ6rh5v/PJzTbBzLGX/WAHDsijIfKkQygwUBrr+xBz3c
 69EpOkegNUXWTp1rlLb260H8wLaKl4jPnuOMj2reS3OK+/5RLe3yZXKMmu5/5bTgpa4m1opjHAQ
 eYay4iYYUCk5osiPl7VwVs4qUwMO0creE837R0la9/sEwhI65p6Hbr7ouoYPAG48CL5O1dDkzdy
 XYtOaW8ys+Zcm4tFe0OpOMep0cO2rlmhSVMYHKa6tgAT01YBjryL7McatdzoXsjbXOdW826xf6f
 uQy/LWJbpcc6Bv8065nYCDqHWzbCwmLdfxVVpF4liT9JQEONwqmsQowjaS9xYHkCPJLmYMctUVi
 EHqfBCPw3k1smSTg4OOwiOc7sm6MAy0YS+uZZe8Cu3rSsA/UAytLjV4UnHqnWjlZYLiIV/CxLdl
 LK3Bc9E0w/wAw1AY58qcWrwAZyBahZuoBj+EuGjRTLaKKQUTAVqYfwpOx4XPV5x7lJ8JAC1Qu09
 YSUA3seMbKOxrtBcThL7c6LuQEFw4kFqDPw9
X-Received: by 2002:a5d:5f93:0:b0:4a5:33ad:871a with SMTP id
 ffacd0b85a97d-4aba56f470cmr31260645f8f.0.1795568752468; 
 Tue, 24 Nov 2026 17:05:52 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2052c8sm31176947f8f.41.2026.11.24.17.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 17:05:50 -0800 (PST)
Message-ID: <80b65871-aa77-4800-9c0c-8586aaec5c80@gmail.com>
Date: Wed, 25 Nov 2026 01:05:48 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v3 3/3] drm/amd/display: report synced displays to PowerPlay
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
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
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
