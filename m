Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938C7C61DD7
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7180610EF74;
	Thu, 27 Aug 2026 09:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imm0nv1nhtv.is-a.dev header.i=@imm0nv1nhtv.is-a.dev header.b="xXwDHC/l";
	dkim-atps=neutral
X-Greylist: delayed 8966 seconds by postgrey-1.36 at gabe;
 Wed, 26 Aug 2026 19:36:13 UTC
Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F86410EDBC
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 19:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2602131731; d=imm0nv1nhtv.is-a.dev; t=1787772967;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=6m6/nVTkN2G1SyFXrOvB2/4l1QVTjAhGUBW3iigpQ0U=;
 b=xXwDHC/lI9wUDcOickNtgmclJ9sSYiCmwHK5xU7einvu66U3SsrJOT+V9wC7pDVTeA7iBw
 1iRoThyg+mMzzg12uXM9UNdM6OyRxW8j9emLfaoZbBPjOGqRq2lxUOVZ/w9tKdSqfJsH3S
 NpgLykGftIq0WXNMYASmlQrFb7SbQMVFPt8YQXi510I+OkbRpAM24/MJ7/M6jqWWgpbmYh
 WYqLPb/BK0z07gCTlf6AYydlUwkB2wm/9JJ+8wrWvOkKljEUFgzCcg1gQ9cFjIMzqv3O8s
 AJWLLDGDuLYMTnJ2c7rSp4R49Enwp1JQJ4inmlKXZqBc2NUhAaKKW+st1iDVag==
Content-Type: text/plain; charset=UTF-8
To: "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, 
 "Alex Deucher" <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Rodrigo Siqueira" <siqueira@igalia.com>, 
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, 
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, 
 <linux-kernel@vger.kernel.org>, 
 "NepNep7601" <neptune@imm0nv1nhtv.is-a.dev>
Subject: [PATCH 1/2] drm/amd/display: skip receiver power control without AUX
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a8f4027+79189d+lists.freedesktop.org+neptune@imm0nv1nhtv.is-a.dev>
Content-Transfer-Encoding: 7bit
From: "NepNep7601" <neptune@imm0nv1nhtv.is-a.dev>
Date: Thu, 27 Aug 2026 02:36:01 +0700
X-Mailer: git-send-email 2.47.3
Received: from Neptune-PC.kiko-royal.ts.net ([58.186.164.158]) by
 smtp.larksuite.com with ESMTPS; Wed, 26 Aug 2026 19:36:06 +0000
References: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
X-Original-From: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
Message-Id: <20260826193602.6441-1-neptune@imm0nv1nhtv.is-a.dev>
In-Reply-To: <20260826170549.21985-1-neptune@imm0nv1nhtv.is-a.dev>
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
GPIO I2C rather than AUX. dpcd_write_rx_power_ctrl() nevertheless tries
to write DP_SET_POWER, causing the DP helpers to retry a transaction
that cannot succeed 32 times before giving up.

Skip receiver power control when the link is not using AUX mode.

On an Oland GPU with a passive DP to HDMI to DVI chain, this reduced
boot-time "DP AUX transfer fail" messages from 32 to 0. The EDID
remained 256 bytes and the display continued to use its native
1600x900 mode.

Assisted-by: Claude:claude-opus-5
Signed-off-by: NepNep7601 <neptune@imm0nv1nhtv.is-a.dev>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 49521ac4b0e8..7991531f6ef4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -50,6 +50,15 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on)
 	if (link->sync_lt_in_progress)
 		return;
 
+	/*
+	 * A passive DP to TMDS dongle presents no DP receiver, so there is
+	 * nothing to power up or down. The write can only fail, and the DP
+	 * helpers retry it 32 times before giving up, which adds tens of
+	 * milliseconds to link bring up.
+	 */
+	if (!link->aux_mode)
+		return;
+
 	core_link_write_dpcd(link, DP_SET_POWER, &state,
 						 sizeof(state));
 
-- 
2.47.3
