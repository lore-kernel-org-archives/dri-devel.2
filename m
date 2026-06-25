Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD99CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC1810EBD7;
	Thu, 25 Jun 2026 13:03:20 +0000 (UTC)
X-Greylist: delayed 4698 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jun 2026 13:03:19 UTC
Received: from 20.mo581.mail-out.ovh.net (20.mo581.mail-out.ovh.net
 [46.105.49.208])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA5110EBD7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:03:19 +0000 (UTC)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.110.0.173])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4gmH6M3XtXz5yYZ
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:44:59 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-xfpdk (unknown [10.111.182.62])
 by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D12D680EFF;
 Thu, 25 Jun 2026 11:44:58 +0000 (UTC)
Received: from etezian.org ([37.59.142.102])
 by ghost-submission-7d8d68f679-xfpdk with ESMTPSA
 id vF+/G7oUPWp1RSYAtJDhiQ
 (envelope-from <andi@etezian.org>); Thu, 25 Jun 2026 11:44:58 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R00415302d01-2a52-45cb-9a42-458e3b3c8a61,
 20FD450D999EB22A6E066B2D596748FFE04DB42B) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.82.31.9
From: Andi Shyti <andi.shyti@linux.intel.com>
To: dri-devel <dri-devel@lists.freedesktop.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] drm/i915/gt: Return bool values from a boolean helper
Date: Thu, 25 Jun 2026 13:44:42 +0200
Message-ID: <20260625114442.2912230-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 1493787704206267421
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGVaW+6PV9gVfPh92WHYd0KDcfoF5+9nwYDvlaBN3PWZTxNIEUaF2megbst3Y0VmJnlJPFzJmph4fZPnGmTcEfy2DhY9WJK3sgOl62ZKMQEgeCv9CVyjgDjYNSGPW6n5Ug02OFt7eKdfg7L02GfTe0xKZHHQ9quidsSyAKeQm94KnTwaZzQJc0E1V9KJEUD0TIfxX97Fri5cUlWpkAeGf/Zs14NTJBv3m5XH/F4cjF2BF2vCYkZS51o7S6Pu8LpFFoay2d7QoQeHCy4n3nav4Cf7UWwMZHr/8HfUew4b24jU/fgi/lvx457SLslKva5KMKH3o9YUSM4+HCWvwQeEUbXKp+Fy350xtd+ZdwUNKPZCniCDvqwd80xSJyYID12K2eSoKIx2EkoZIPRSnw37642WkeEPK2N6+RsRkLEPj95AOzj9/fPYw3irm8dUHcF/gkylFFHLtX86T2LccmaB96R7Vz3eww8p+Bzt35p4I0dboVHDpdtTnH4p6Ul62K/CBEDyPByp8GsRUr6JX2xCzia230IiQax9fjl7ayEn2PyF5PfpNi0NDBjVBsVB8LgjZ3rhAQ7esdVuK6y1o69pJJqJx0SlB5WqJvGf9XXEyZp8o7JaAlx+bPWNRTW0IzJPGWk4j2/iQoNVCIDo4d+g/qepBVHSvBlc2sIxOrw0WdLvA
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

intel_has_gpu_reset() returns logically correct values by
returning a function pointer when GPU reset is supported and
NULL otherwise. However, as a boolean helper, it is more
appropriate to return explicit true or false values.

Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index b2cf672564dd..a3f198646e1d 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -797,9 +797,9 @@ static int __intel_gt_reset(struct intel_gt *gt, intel_engine_mask_t engine_mask
 bool intel_has_gpu_reset(const struct intel_gt *gt)
 {
 	if (!gt->i915->params.reset)
-		return NULL;
+		return false;
 
-	return intel_get_gpu_reset(gt);
+	return !!intel_get_gpu_reset(gt);
 }
 
 bool intel_has_reset_engine(const struct intel_gt *gt)
-- 
2.53.0

