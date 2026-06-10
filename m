Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAA3CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CECA310EE53;
	Thu, 11 Jun 2026 10:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="MBlILbA6";
	dkim-atps=neutral
Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BB310EB7A
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
 s=mail; t=1781113690;
 bh=aGIuEo52oGTAKHQCGB8qB3lP7UFewXmefo1KMtagL90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MBlILbA6hY41v6iCtb28Q56RxQTguhihsO0FeDaH5ys9uzNtwfslkaP3/vf5cdqLw
 r4Koi0ZJNpVlqD48IiM8VD4v+PIqkjpsPHqdmCmZUX5pj4TouRSagZSUXHOwLwYrgf
 E/SV+Fuj8qdqOStdSitvadH3+36I2Tw2/6EaGNxcBLoDrhILusVPt4pqqteJEAg7a7
 QIsAvwfWbv5+0uVrRUd645Bm8GQlxPxJx7uv2If3O18vmK7fyjbGXFdyOegfkQ2KCn
 RLnDUWQPn3LK8nyRuz3hzqcl0LVZWGTul2fuK0QWRgZVpucnp3twlrlwb5rnlkJwpk
 +8+wMhucLAc5Q==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
 by mail.sms-medipool.de (Postfix) with ESMTPS id D0A8811D48;
 Wed, 10 Jun 2026 19:48:09 +0200 (CEST)
Received: from NUC16-Linux.sb.golima.de ([95.88.98.111])
 by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
 Wed, 10 Jun 2026 19:48:08 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Imre Deak <imre.deak@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, alexander.kaplan@sms-medipool.de
Subject: [PATCH 1/2] drm/dp: Add quirk for Synaptics PCONs failing channel EQ
 at RBR
Date: Wed, 10 Jun 2026 19:48:06 +0200
Message-ID: <20260610174807.6231-2-alexander.kaplan@sms-medipool.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610174807.6231-1-alexander.kaplan@sms-medipool.de>
References: <20260610174807.6231-1-alexander.kaplan@sms-medipool.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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

Synaptics VMM7100 DP-to-HDMI 2.1 protocol converters with branch
firmware 7.1 (branch dev-ID "SYNAq", FW revision at DPCD 0x50a/0x50b)
deterministically fail 8b/10b channel equalization when link training
at the RBR link rate with 4 lanes.
Clock recovery succeeds, but during channel equalization the device
keeps toggling its requested voltage swing/pre-emphasis levels
without ever converging, until the 5 attempt limit is reached.
Only this link configuration fails.
RBR with 1 or 2 lanes and all higher link rates with 2 or 4 lanes
train reliably.
A second dongle based on the same VMM7100 chip (same HW-rev 1.0) but
with branch firmware 7.2 trains 4-lane RBR without issue, so this is
a firmware problem in the converter, fixed by newer firmware.
The failure was observed on PTL behind the board's non-transparent
LTTPR, with the source granting all swing/pre-emphasis requests.

Add a quirk entry for these devices, so that drivers can avoid the
RBR link rate for them.
The quirk matching can't distinguish firmware revisions, so devices
with fixed firmware are matched as well.
Avoiding RBR is free for these PCONs, since any mode that fits into
the RBR link bandwidth also fits into HBR, which they train reliably.

The quirk will be handled by the i915 driver in a follow-up change.

Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 3 +++
 include/drm/display/drm_dp_helper.h     | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 9c31e14cc413..a8737943ef11 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2558,6 +2558,9 @@ static const struct dpcd_quirk dpcd_quirk_list[] = {
 	{ OUI(0x90, 0xCC, 0x24), DEVICE_ID('S', 'Y', 'N', 'A', 0x53, 0x22), true, BIT(DP_DPCD_QUIRK_DSC_THROUGHPUT_BPP_LIMIT) },
 	{ OUI(0x90, 0xCC, 0x24), DEVICE_ID('S', 'Y', 'N', 'A', 0x53, 0x31), true, BIT(DP_DPCD_QUIRK_DSC_THROUGHPUT_BPP_LIMIT) },
 	{ OUI(0x90, 0xCC, 0x24), DEVICE_ID('S', 'Y', 'N', 'A', 0x53, 0x33), true, BIT(DP_DPCD_QUIRK_DSC_THROUGHPUT_BPP_LIMIT) },
+	/* Synaptics VMM7100 DP-to-HDMI 2.1 PCONs fail channel EQ at the RBR link rate */
+	{ OUI(0x90, 0xCC, 0x24), DEVICE_ID('S', 'Y', 'N', 'A', 'q', '\0'), true,
+	  BIT(DP_DPCD_QUIRK_NO_LINK_RATE_RBR) },
 };
 
 #undef OUI
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 8c2d77a032f0..324197894300 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -863,6 +863,14 @@ enum drm_dp_quirk {
 	 * specific DSC pixel throughput.
 	 */
 	DP_DPCD_QUIRK_DSC_THROUGHPUT_BPP_LIMIT,
+	/**
+	 * @DP_DPCD_QUIRK_NO_LINK_RATE_RBR:
+	 *
+	 * The device fails 8b/10b channel equalization at the RBR link
+	 * rate, but trains reliably at all higher link rates. Drivers
+	 * should avoid the RBR link rate for these devices.
+	 */
+	DP_DPCD_QUIRK_NO_LINK_RATE_RBR,
 };
 
 /**
-- 
2.54.0


