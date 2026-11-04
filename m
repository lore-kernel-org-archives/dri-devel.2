Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0A606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4503110F97F;
	Wed,  4 Nov 2026 02:53:42 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA44010F97F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:53:39 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowABnVf8vnupqA+U+AA--.27602S2;
 Wed, 04 Nov 2026 10:53:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915/selftests: read the noop seqno before dropping the
 request
Date: Wed,  4 Nov 2026 02:53:44 +0000
Message-Id: <20261104025344.1527492-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABnVf8vnupqA+U+AA--.27602S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1xZw1fZFW3AFW3Xw4rGrg_yoW8AFW8pr
 4rJF4Y9rZxJrWIyayfJry0vF1Yka1SyFWfKrnrKw13urn8Xw48trnavw13WryUAFZ7XrW3
 tFZrKFZxWF9FyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
 AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
 6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
 v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
 McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
 kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAa
 w2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
 Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I
 0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUHubkDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgBA2rqZFjiRQABsX
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

perf_mi_noop() waits for the request it has just submitted, drops the
reference taken with i915_request_get() and only then reads
rq->hwsp_seqno[].

i915_request_wait() returns as soon as the fence is signaled, which
happens in i915_request_retire() before it puts the request's initial
reference.  If retirement has already run, the put in this loop is the
last one and i915_request_put() frees the request, so the seqno is read
from an object that the SLAB_TYPESAFE_BY_RCU slab cache can already have
handed out to another user.

Sample the seqno while the reference is still held.

Fixes: 3c7a44bbbfa7 ("drm/i915/selftests: Perform some basic cycle counting of MI ops")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
index 1846f1c7e77e..f894902f5509 100644
--- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
@@ -357,13 +357,19 @@ static int perf_mi_noop(void *arg)
 
 			if (i915_request_wait(rq, 0, HZ / 5) < 0)
 				err = -EIO;
+
+			/*
+			 * The request can be freed as soon as its last
+			 * reference is dropped, so read the seqno first.
+			 */
+			if (!err)
+				cycles[i] =
+					(rq->hwsp_seqno[4] - rq->hwsp_seqno[3]) -
+					(rq->hwsp_seqno[3] - rq->hwsp_seqno[2]);
+
 			i915_request_put(rq);
 			if (err)
 				break;
-
-			cycles[i] =
-				(rq->hwsp_seqno[4] - rq->hwsp_seqno[3]) -
-				(rq->hwsp_seqno[3] - rq->hwsp_seqno[2]);
 		}
 		i915_vma_put(nop);
 		i915_vma_put(base);
-- 
2.34.1

