Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD939CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 04:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC08D10E645;
	Wed, 27 May 2026 04:09:13 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1C010E645
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 04:09:11 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.3])
 by APP-05 (Coremail) with SMTP id zQCowABHntFfbhZqLZmGEQ--.5022S2;
 Wed, 27 May 2026 12:09:03 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Kees Cook <kees@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm: i915: selftests: fix oa_config refcount leak in
 test_stream()
Date: Wed, 27 May 2026 04:08:35 +0000
Message-Id: <20260527040835.854065-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHntFfbhZqLZmGEQ--.5022S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyUWry7Gr1DKw15Zw13urg_yoW8Gr4kpa
 13Aa4YyrW5GF1ftayUGa4rKFy3Aas3GF48C3sFkwn3uw13AFy8tFsakFyfXF95ArZ3ZF17
 tFZ2kFWSgr1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
 4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
 nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-Originating-IP: [36.110.52.3]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREAA2oWPLmz8QAAsg
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

test_stream() calls i915_perf_get_oa_config() which takes a reference
on the returned oa_config. On the error path where stream allocation
fails, the function returns without calling i915_oa_config_put() on
the oa_config, leaking the reference.

Move the oa_config check after the props.engine check and add
i915_oa_config_put(oa_config) on the error path to properly release
the reference.

Fixes: 9677a9f3b1ad ("drm/i915/perf: Move gt-specific data from i915->perf to gt->perf")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/selftests/i915_perf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
index e9469e27f42a..a3e0afb0549e 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf.c
+++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
@@ -104,14 +104,16 @@ test_stream(struct i915_perf *perf)
 	struct i915_perf_stream *stream;
 	struct intel_gt *gt;
 
-	if (!props.engine)
-		return NULL;
-
 	gt = props.engine->gt;
 
 	if (!oa_config)
 		return NULL;
 
+	if (!props.engine) {
+		i915_oa_config_put(oa_config);
+		return NULL;
+	}
+
 	props.metrics_set = oa_config->id;
 
 	stream = kzalloc_obj(*stream);
-- 
2.34.1

