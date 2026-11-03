Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB1606D801
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB5110F403;
	Tue,  3 Nov 2026 08:02:32 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C18910F40B;
 Tue,  3 Nov 2026 08:02:30 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAA3QpMUlelqojE6AA--.1416S2;
 Tue, 03 Nov 2026 16:02:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: tursulin@ursulin.net, umesh.nerlige.ramappa@intel.com,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/i915/perf: Unpin the context if reading its GuC ID fails
Date: Tue,  3 Nov 2026 08:02:37 +0000
Message-Id: <20261103080237.1126027-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAA3QpMUlelqojE6AA--.1416S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw15uF4UWFWrKF1xtF1UZFb_yoW8CrWrpr
 40k3WYyFW7XF1jya9Fya1qvF1aga1fJayxGr1vkwn3Zr43XFn0q3WSyrWFgryvkr40vryY
 vrsxta4xu34jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
 4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
 sGvfC2KfnxnUUI43ZEXa7VU8jQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQAA2rpWfXboAAAsK
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

oa_get_render_ctx_id() pins the context before obtaining its hardware ID.
With GuC submission, gen12_get_render_context_id() can fail while
allocating or accessing the scratch buffer used to read that ID. The
error is returned without releasing the context pin.

i915_oa_stream_init() immediately returns this error, and its caller
frees the stream without invoking the stream destroy callback. There is
therefore no later opportunity to release the pin.

Unpin and clear pinned_ctx before returning this error. Also clear the
pointer on the existing context-control-offset error path, so failed
initialization consistently leaves no pinned context in the stream.

Fixes: 682aa4373f15 ("drm/i915/perf: Fix OA filtering logic for GuC mode")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/i915_perf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 19b82427aa41..73040da7fd16 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -1541,6 +1541,7 @@ static int oa_get_render_ctx_id(struct i915_perf_stream *stream)
 		ret = set_oa_ctx_ctrl_offset(ce);
 		if (ret) {
 			intel_context_unpin(ce);
+			stream->pinned_ctx = NULL;
 			drm_err(&stream->perf->i915->drm,
 				"Enabling perf query failed for %s\n",
 				stream->engine->name);
@@ -1596,6 +1597,12 @@ static int oa_get_render_ctx_id(struct i915_perf_stream *stream)
 		MISSING_CASE(GRAPHICS_VER(ce->engine->i915));
 	}
 
+	if (ret) {
+		intel_context_unpin(ce);
+		stream->pinned_ctx = NULL;
+		return ret;
+	}
+
 	ce->tag = stream->specific_ctx_id;
 
 	drm_dbg(&stream->perf->i915->drm,
-- 
2.34.1

