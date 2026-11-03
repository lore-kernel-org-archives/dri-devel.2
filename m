Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F76606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36ED810E4A9;
	Tue,  3 Nov 2026 06:54:02 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66D2610E4A9;
 Tue,  3 Nov 2026 06:54:00 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAA3Q5QGhelqHI45AA--.3063S2;
 Tue, 03 Nov 2026 14:53:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: zhenyuw.linux@gmail.com,
	zhi.wang.linux@gmail.com
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/i915/gvt: Release GGTT MM if scratch page setup fails
Date: Tue,  3 Nov 2026 06:54:07 +0000
Message-Id: <20261103065407.1070225-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAA3Q5QGhelqHI45AA--.3063S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF43XF4fWr4DtFW5tw1rXrb_yoW8Ww13pF
 WUW345ArZ0y3W2q397Aa15uF1fCa1Sk34xGrykG34qvr1DAa1ftFsYyFWagFykurZ7Ca1S
 vr45try7uw129F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
 8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
 Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
 x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
 4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
 6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0JULo7NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMAA2rpWwqKAQABsU
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

intel_vgpu_init_gtt() creates the GGTT MM before allocating the scratch
page table tree. If scratch page allocation or DMA mapping fails,
create_scratch_page_tree() releases its own pages, but the GGTT MM and
its virtual GGTT and host GGTT buffers remain allocated. The caller
skips intel_vgpu_clean_gtt() when intel_vgpu_init_gtt() fails.

Drop the GGTT MM reference and clear its pointer before returning the
scratch page initialization error.

Fixes: 3b6411c2c205 ("drm/i915/gvt: implement scratch page table tree for shadow PPGTT")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 5056a5887b31..17d61548ec05 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -2403,6 +2403,7 @@ static int create_scratch_page_tree(struct intel_vgpu *vgpu)
 int intel_vgpu_init_gtt(struct intel_vgpu *vgpu)
 {
 	struct intel_vgpu_gtt *gtt = &vgpu->gtt;
+	int ret;
 
 	INIT_RADIX_TREE(&gtt->spt_tree, GFP_KERNEL);
 
@@ -2420,7 +2421,13 @@ int intel_vgpu_init_gtt(struct intel_vgpu *vgpu)
 
 	INIT_LIST_HEAD(&gtt->ggtt_mm->ggtt_mm.partial_pte_list);
 
-	return create_scratch_page_tree(vgpu);
+	ret = create_scratch_page_tree(vgpu);
+	if (ret) {
+		intel_vgpu_destroy_mm(gtt->ggtt_mm);
+		gtt->ggtt_mm = NULL;
+	}
+
+	return ret;
 }
 
 void intel_vgpu_destroy_all_ppgtt_mm(struct intel_vgpu *vgpu)
-- 
2.34.1

