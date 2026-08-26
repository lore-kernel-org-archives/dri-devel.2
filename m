Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8990BC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 098C110EF67;
	Thu, 27 Aug 2026 09:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imm0nv1nhtv.is-a.dev header.i=@imm0nv1nhtv.is-a.dev header.b="Gmhr/96e";
	dkim-atps=neutral
Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD8510E10D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 20:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2602131731; d=imm0nv1nhtv.is-a.dev; t=1787777104;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=g06uOZVXmJELdMYnWTo6U5rOWHksszgpcnk9cEV3ZX0=;
 b=Gmhr/96eKSU180TupDguNw15Nr6oeONU3wOkfthjKFtO1/4AaBAv8HdC1hyEGP6yyXtwxH
 yf+4hhV4w8XM9LgZ2CZs1U3rKQz3E6ougNC53s5mKEwUMHa05l8Bdw9JE5OShlUcPltRfc
 XnKF/Zmzh8QW2UBpGKLETwSkcMm0L3dgUtaqHH8wrSHa8VnKFuha8P3+sEbBfC3oFfwyHx
 Qrq0VrmUmqZW2M8ctako4fH3t0pshisbKFhAHV9k3t4P71+VZWZzZnOHAi03asMDy6ubur
 Vb6hkW7Uoqo0ypaJO3FGjR+DWFeJkW//a7GZdjWW4aMf88f4yfa48Rz7e5efiQ==
From: "NepNep7601" <neptune@imm0nv1nhtv.is-a.dev>
Date: Thu, 27 Aug 2026 03:44:56 +0700
Message-Id: <20260826204457.4666-1-neptune@imm0nv1nhtv.is-a.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a8f504f+770e10+lists.freedesktop.org+neptune@imm0nv1nhtv.is-a.dev>
Subject: [PATCH v2 1/2] drm/amd/display: skip receiver power control without
 AUX
Received: from Neptune-PC.kiko-royal.ts.net ([58.186.164.158]) by
 smtp.larksuite.com with ESMTPS; Wed, 26 Aug 2026 20:45:02 +0000
In-Reply-To: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
Cc: "Rodrigo Siqueira" <siqueira@igalia.com>, 
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, 
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, 
 <linux-kernel@vger.kernel.org>, 
 "NepNep7601" <neptune@imm0nv1nhtv.is-a.dev>
References: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
X-Original-From: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
Content-Transfer-Encoding: 7bit
To: "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, 
 "Alex Deucher" <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset=UTF-8
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

Passive DP to TMDS dongles do not provide a DP receiver and use native
GPIO I2C rather than AUX. The normal link PHY and stream blanking paths
nevertheless try to write DP_SET_POWER, causing the DP helpers to retry
a transaction that cannot succeed 32 times before giving up.

Gate the receiver-power calls in dp_enable_link_phy(),
dp_disable_link_phy() and link_blank_dp_stream() on the post-detection
aux_mode state. Keep dpcd_write_rx_power_ctrl() unchanged because early
DP detection calls it before aux_mode is initialized, and active dongles
may require the receiver power-up before DPCD reads.

On an Oland GPU with a passive DP to HDMI to DVI chain, this reduced
boot-time "DP AUX transfer fail" messages from 32 to 0. The EDID
remained 256 bytes and the display continued to use its native
1600x900 mode.

Assisted-by: Claude:claude-opus-5
Assisted-by: Codex:gpt-5
Signed-off-by: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
---

Notes (amdgpu-followups-v2):
    v2:
    - Move the aux_mode check out of dpcd_write_rx_power_ctrl() so early
      detection can still power active dongles before reading DPCD.
    - Gate receiver-power writes at the normal PHY and stream-blanking call
      sites.
    - Retest the revised placement on the affected Oland system.
    
    v1: https://lore.kernel.org/r/20260826193602.6441-1-neptune@imm0nv1nhtv.is-a.dev

 drivers/gpu/drm/amd/display/dc/link/link_dpms.c        |  6 ++++--
 .../drm/amd/display/dc/link/protocols/link_dp_phy.c    | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 48b086d15ab0..81d63e1aab53 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -146,8 +146,10 @@ void link_blank_dp_stream(struct dc_link *link, bool hw_init)
 				}
 		}
 
-		if (((!dc->is_switch_in_progress_dest) && ((!link->wa_flags.dp_keep_receiver_powered) || hw_init)) &&
-			(link->type != dc_connection_none))
+		if (link->aux_mode &&
+		    !dc->is_switch_in_progress_dest &&
+		    (!link->wa_flags.dp_keep_receiver_powered || hw_init) &&
+		    link->type != dc_connection_none)
 			dpcd_write_rx_power_ctrl(link, false);
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 49521ac4b0e8..24f09bdcab51 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -65,7 +65,8 @@ void dp_enable_link_phy(
 	link->cur_link_settings = *link_settings;
 	link->dc->hwss.enable_dp_link_output(link, link_res, signal,
 			clock_source, link_settings);
-	dpcd_write_rx_power_ctrl(link, true);
+	if (link->aux_mode)
+		dpcd_write_rx_power_ctrl(link, true);
 }
 
 void dp_disable_link_phy(struct dc_link *link,
@@ -74,9 +75,10 @@ void dp_disable_link_phy(struct dc_link *link,
 {
 	struct dc  *dc = link->ctx->dc;
 
-	if (!link->wa_flags.dp_keep_receiver_powered &&
-			!link->skip_implict_edp_power_control &&
-			link->type != dc_connection_none)
+	if (link->aux_mode &&
+	    !link->wa_flags.dp_keep_receiver_powered &&
+	    !link->skip_implict_edp_power_control &&
+	    link->type != dc_connection_none)
 		dpcd_write_rx_power_ctrl(link, false);
 
 	dc->hwss.disable_link_output(link, link_res, signal);
-- 
2.47.3
