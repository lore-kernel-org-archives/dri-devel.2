Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F43ECD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B718112061;
	Fri, 29 May 2026 14:58:07 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57574112067;
 Fri, 29 May 2026 14:58:05 +0000 (UTC)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 29 May
 2026 17:58:03 +0300
Received: from localhost (10.0.253.153) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 29 May
 2026 17:58:02 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] drm/i915/edp: Check supported link rates DPCD read
Date: Fri, 29 May 2026 17:57:58 +0300
Message-ID: <20260529145759.1640646-1-n.zhandarovich@fintech.ru>
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
fails, the array contents are not valid and may result in bogus sink
link rates being used.

Use drm_dp_dpcd_read_data() and clear the sink rate array on failure,
so the existing parser falls back to the default sink rate handling.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 68f357cb7347 ("drm/i915/dp: generate and cache sink rate array for all DP, not just eDP 1.4")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v1 -> v2:
- Use drm_dp_dpcd_read_data() instead of drm_dp_dpcd_read().
- Avoid the goto by clearing sink_rates on read failure, as suggested by
  Jani Nikula.
- Adjust patch description.

 drivers/gpu/drm/i915/display/intel_dp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 6ef2a0043cda..5c3e816b0135 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4678,10 +4678,17 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 
 	if (intel_dp->edp_dpcd[0] >= DP_EDP_14) {
 		__le16 sink_rates[DP_MAX_SUPPORTED_RATES];
+		int ret;
 		int i;
 
-		drm_dp_dpcd_read(&intel_dp->aux, DP_SUPPORTED_LINK_RATES,
-				 sink_rates, sizeof(sink_rates));
+		ret = drm_dp_dpcd_read_data(&intel_dp->aux,
+					    DP_SUPPORTED_LINK_RATES,
+					    sink_rates, sizeof(sink_rates));
+		if (ret < 0) {
+			drm_dbg_kms(display->drm,
+				    "Unable to read eDP supported link rates, using default rates\n");
+			memset(sink_rates, 0, sizeof(sink_rates));
+		}
 
 		for (i = 0; i < ARRAY_SIZE(sink_rates); i++) {
 			int rate;
