Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79748606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959D210E795;
	Tue,  3 Nov 2026 06:55:49 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6853910E795;
 Tue,  3 Nov 2026 06:55:47 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowADH0JFxhelqyZE5AA--.4106S2;
 Tue, 03 Nov 2026 14:55:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] drm/i915/selftests: Put GuC test contexts on early failures
Date: Tue,  3 Nov 2026 06:55:54 +0000
Message-Id: <20261103065554.1073445-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADH0JFxhelqyZE5AA--.4106S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4fKF1rZFy8WF13XFyUAwb_yoW8uF45pa
 93Xa4YkFy5AF42q3W7Aa40qFy3K3W0vayxuw1kJw1kKw1UZasYqrySvayUJ34DCFZ7Wr1a
 yF9Igry7WFy2yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
 6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUog
 AwDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcAA2rpWmWOeAABsJ
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

intel_hang_guc() creates an intel_context before changing the heartbeat
interval and initializing the spinner. If either operation fails, it
jumps to err without dropping that context. intel_guc_fast_request()
also skips the context put when spinner initialization fails.

Release the context on these failure paths. The existing put after
igt_spinner_create_request() handles the later paths.

Fixes: 69142c0a5f9a ("drm/i915/guc: Add selftest for a hung GuC")
Fixes: 706785c19fe9 ("drm/i915/guc: Add a selftest for FAST_REQUEST errors")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c           | 1 +
 drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
index 63a75272924f..8ee4ccdb80cf 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
@@ -333,6 +333,7 @@ static int intel_guc_fast_request(void *arg)
 	ret = igt_spinner_init(&spin, engine->gt);
 	if (ret) {
 		gt_err(gt, "Failed to create spinner: %pe\n", ERR_PTR(ret));
+		intel_context_put(ce);
 		goto err_pm;
 	}
 	spinning = true;
diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
index 83801c992488..a7c48941ead7 100644
--- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
@@ -65,12 +65,14 @@ static int intel_hang_guc(void *arg)
 	ret = intel_engine_set_heartbeat(engine, BEAT_INTERVAL);
 	if (ret) {
 		gt_err(gt, "Failed to boost heartbeat interval: %pe\n", ERR_PTR(ret));
+		intel_context_put(ce);
 		goto err;
 	}
 
 	ret = igt_spinner_init(&spin, engine->gt);
 	if (ret) {
 		gt_err(gt, "Failed to create spinner: %pe\n", ERR_PTR(ret));
+		intel_context_put(ce);
 		goto err;
 	}
 
-- 
2.34.1

