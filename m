Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D8ACD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34FF10FE06;
	Fri, 29 May 2026 12:14:58 +0000 (UTC)
X-Greylist: delayed 324 seconds by postgrey-1.36 at gabe;
 Fri, 29 May 2026 12:14:58 UTC
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02EF410FE06;
 Fri, 29 May 2026 12:14:58 +0000 (UTC)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 29 May
 2026 15:09:30 +0300
Received: from localhost (10.0.253.153) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 29 May
 2026 15:09:30 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/i915/edp: Check supported link rates DPCD read
Date: Fri, 29 May 2026 15:09:18 +0300
Message-ID: <20260529120921.1633346-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.253.153]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
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

intel_edp_set_sink_rates() reads DP_SUPPORTED_LINK_RATES into a local
stack array and then parses the array unconditionally. If the read
fails or returns less data than requested, the array contents are not
valid and may result in bogus sink link rates being used.

Check that the full DPCD block was read before parsing it. If not, fall
back to the default sink rate handling.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 68f357cb7347 ("drm/i915/dp: generate and cache sink rate array for all DP, not just eDP 1.4")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 6ef2a0043cda..b6650a12ca54 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4678,10 +4678,16 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 
 	if (intel_dp->edp_dpcd[0] >= DP_EDP_14) {
 		__le16 sink_rates[DP_MAX_SUPPORTED_RATES];
+		ssize_t ret;
 		int i;
 
-		drm_dp_dpcd_read(&intel_dp->aux, DP_SUPPORTED_LINK_RATES,
-				 sink_rates, sizeof(sink_rates));
+		ret = drm_dp_dpcd_read(&intel_dp->aux, DP_SUPPORTED_LINK_RATES,
+				       sink_rates, sizeof(sink_rates));
+		if (ret != sizeof(sink_rates)) {
+			drm_dbg_kms(display->drm,
+				    "Unable to read eDP supported link rates, using default rates\n");
+			goto use_default_rates;
+		}
 
 		for (i = 0; i < ARRAY_SIZE(sink_rates); i++) {
 			int rate;
@@ -4715,6 +4721,7 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 	 * Use DP_LINK_RATE_SET if DP_SUPPORTED_LINK_RATES are available,
 	 * default to DP_MAX_LINK_RATE and DP_LINK_BW_SET otherwise.
 	 */
+use_default_rates:
 	if (intel_dp->num_sink_rates)
 		intel_dp->use_rate_select = true;
 	else
