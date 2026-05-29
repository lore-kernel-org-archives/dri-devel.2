Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC07BCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132D810FF1A;
	Fri, 29 May 2026 13:24:38 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8E110FF1A;
 Fri, 29 May 2026 13:24:37 +0000 (UTC)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 29 May
 2026 16:24:35 +0300
Received: from localhost (10.0.253.153) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 29 May
 2026 16:24:34 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Zhenyu Wang
 <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, "Tvrtko
 Ursulin" <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, <intel-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>
Subject: [PATCH] drm/i915/gvt: validate LRCA-derived guest context range
Date: Fri, 29 May 2026 16:24:27 +0300
Message-ID: <20260529132430.1636603-1-n.zhandarovich@fintech.ru>
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

The GVT execlist context handling code derives GGTT page addresses from
desc->lrca in several places:
 - intel_vgpu_create_workload()
 - populate_shadow_context()
 - update_guest_context()

These paths translate addresses based on desc->lrca + page_index, but do
not first verify that the referenced guest context range fits in 32-bit
GMA space.

If desc->lrca is close enough (0xFFFFE, for instance) to the top
encodable page value, the page addition can exceed the representable
32-bit GMA range before the value is shifted and truncated for address
translation.

Fix this by validating the full LRCA-derived context range once during
workload creation, based on the engine context size, and reject invalid
descriptors before any GPA translation is attempted.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 28c4c6ca7f79 ("drm/i915/gvt: vGPU workload submission")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/i915/gvt/scheduler.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 15fdd514ca83..b2c028396093 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -68,6 +68,37 @@ static void set_context_pdp_root_pointer(
 		ring_context->pdps[i].val = pdp[7 - i];
 }
 
+static unsigned long
+intel_vgpu_context_page_num(struct intel_vgpu *vgpu,
+			    const struct intel_engine_cs *engine)
+{
+	unsigned long context_page_num;
+
+	context_page_num = engine->context_size >> PAGE_SHIFT;
+
+	if (IS_BROADWELL(vgpu->gvt->gt->i915) && engine->id == RCS0)
+		context_page_num = 19;
+
+	return context_page_num;
+}
+
+static bool
+intel_vgpu_lrca_range_valid(struct intel_vgpu *vgpu,
+			    const struct intel_engine_cs *engine,
+			    u32 lrca)
+{
+	unsigned long context_page_num;
+	u32 max_lrca;
+
+	context_page_num = intel_vgpu_context_page_num(vgpu, engine);
+	if (!context_page_num)
+		return false;
+
+	max_lrca = (U32_MAX >> I915_GTT_PAGE_SHIFT) - (context_page_num - 1);
+
+	return lrca <= max_lrca;
+}
+
 static void update_shadow_pdps(struct intel_vgpu_workload *workload)
 {
 	struct execlist_ring_context *shadow_ring_context;
@@ -1646,6 +1677,12 @@ intel_vgpu_create_workload(struct intel_vgpu *vgpu,
 	u32 guest_head;
 	int ret;
 
+	if (!intel_vgpu_lrca_range_valid(vgpu, engine, desc->lrca)) {
+		gvt_vgpu_err("invalid guest context LRCA: 0x%x\n",
+			     desc->lrca);
+		return ERR_PTR(-EINVAL);
+	}
+
 	ring_context_gpa = intel_vgpu_gma_to_gpa(vgpu->gtt.ggtt_mm,
 			(u32)((desc->lrca + 1) << I915_GTT_PAGE_SHIFT));
 	if (ring_context_gpa == INTEL_GVT_INVALID_ADDR) {
