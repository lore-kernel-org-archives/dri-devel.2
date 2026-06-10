Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7753FCD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD5810EE5F;
	Thu, 11 Jun 2026 10:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="CySPo9l5";
	dkim-atps=neutral
Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D27610EB4C
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
 s=mail; t=1781113690;
 bh=gOzhvpbT/BeuZVrk4+kVYh1RAaDh2itI5WjymjfcCsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CySPo9l53D1Or8sbX1EfGwjqFnQ9nnzpaktJjPu9sk6mngTnY814dJqsTXhQWx59G
 HvEeiiffGuUbVFPVap+m5ijl2cDRYnKYXeonHx8K154kYbjZOmOkouHu0v+wPxlHuJ
 sSNgIs09gStOZzaqa+AixGgc0Cb9P+Y/MU/PYQcma/c+giCRgj9VCNW+NgVQZoXEaR
 W0Ahq86jQMRoXiTLFdVY5Rkz/vTuxeyjD84PV8PLetGiNDpI3et7HXqUnhkESTJZty
 C4aGIHuPXRkzZKF7Zk5OCwYYnJt664iCr2rHRYYVHJf3vFlFUZG86P9NEIEmmOfCpq
 +oqq81TitQMPg==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
 by mail.sms-medipool.de (Postfix) with ESMTPS id CC39611B5C;
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
Subject: [PATCH 2/2] drm/i915/dp: Skip RBR for sinks with the NO_LINK_RATE_RBR
 quirk
Date: Wed, 10 Jun 2026 19:48:07 +0200
Message-ID: <20260610174807.6231-3-alexander.kaplan@sms-medipool.de>
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

Synaptics VMM7100 PCONs with branch firmware 7.1 deterministically
fail 8b/10b channel equalization at the 4-lane RBR link configuration
(see the preceding commit adding DP_DPCD_QUIRK_NO_LINK_RATE_RBR).

The link config computation optimizes for the minimum link rate, so
it picks exactly this failing configuration for low resolution modes.
E.g. a 1080p60 boot greeter computes to 4x162000.
The resulting link training failure makes the fallback logic reduce
the link parameters, and since the rate is already at its minimum,
the lane count is halved to 2.
The reduced intel_dp->link.max_lane_count then sticks: these PCONs
hold HPD high and never raise the long HPD that would re-sync the
link parameters via intel_dp_reset_link_params().
On the affected system the boot greeter thus permanently capped the
link at 2 lanes, limiting the subsequent 3840x2160@60 desktop mode to
6 bpc dithered output instead of the deep color modes the setup is
capable of with 4 lanes.

Skip RBR when computing the sink rates of a device with the
NO_LINK_RATE_RBR quirk, unless RBR is the only available rate.
Any mode that fits into the RBR link bandwidth also fits into HBR at
the same lane count, so no mode support is lost.
With the quirk applied the greeter trains 2x270000 and the 4k60
desktop mode 4x810000, verified on PTL (xe) with an affected PCON.

Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 85d3aa3b9894..dec68f07161e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -197,7 +197,8 @@ static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 	static const int dp_rates[] = {
 		162000, 270000, 540000, 810000
 	};
-	int i, max_rate;
+	int i, num_rates = 0;
+	int max_rate;
 	int max_lttpr_rate;
 
 	if (drm_dp_has_quirk(&intel_dp->desc, DP_DPCD_QUIRK_CAN_DO_MAX_LINK_RATE_3_24_GBPS)) {
@@ -221,7 +222,17 @@ static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 	for (i = 0; i < ARRAY_SIZE(dp_rates); i++) {
 		if (dp_rates[i] > max_rate)
 			break;
-		intel_dp->sink_rates[i] = dp_rates[i];
+
+		/*
+		 * The quirked devices fail channel equalization at RBR, but
+		 * train reliably at all higher rates. Skip RBR, unless it's
+		 * the only available rate.
+		 */
+		if (dp_rates[i] == 162000 && max_rate >= 270000 &&
+		    drm_dp_has_quirk(&intel_dp->desc, DP_DPCD_QUIRK_NO_LINK_RATE_RBR))
+			continue;
+
+		intel_dp->sink_rates[num_rates++] = dp_rates[i];
 	}
 
 	/*
@@ -252,14 +263,14 @@ static void intel_dp_set_dpcd_sink_rates(struct intel_dp *intel_dp)
 		}
 
 		if (uhbr_rates & DP_UHBR10)
-			intel_dp->sink_rates[i++] = 1000000;
+			intel_dp->sink_rates[num_rates++] = 1000000;
 		if (uhbr_rates & DP_UHBR13_5)
-			intel_dp->sink_rates[i++] = 1350000;
+			intel_dp->sink_rates[num_rates++] = 1350000;
 		if (uhbr_rates & DP_UHBR20)
-			intel_dp->sink_rates[i++] = 2000000;
+			intel_dp->sink_rates[num_rates++] = 2000000;
 	}
 
-	intel_dp->num_sink_rates = i;
+	intel_dp->num_sink_rates = num_rates;
 }
 
 static void intel_dp_set_sink_rates(struct intel_dp *intel_dp)
-- 
2.54.0


