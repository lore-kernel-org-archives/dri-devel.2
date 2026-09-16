Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53799C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62CC610E8E9;
	Wed, 16 Sep 2026 17:29:19 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3ABD10E627;
 Wed, 16 Sep 2026 17:29:17 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowACXAj3o0apquZ9uCA--.22432S2;
 Thu, 17 Sep 2026 01:29:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: chris@chris-wilson.co.uk, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
 rodrigo.vivi@intel.com, simona@ffwll.ch, tursulin@ursulin.net,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Fix rq use-after-free in signal_irq_work()
Date: Wed, 16 Sep 2026 17:28:44 +0000
Message-Id: <20260916172844.2087895-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACXAj3o0apquZ9uCA--.22432S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xuFy8AFykury3trW5ZFb_yoW8Ww4Dpr
 43JFyYyrZ8ZFnFv3WrC3W8CF4fWa42yF1UWF98G3s3Jwn8tas3Ar9YvFyjqFyY9rs3Xw1q
 qryqqrW7WFWUZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
 WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
 xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
 I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
 6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F
 4UJbIYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIMA2qqpVhjkQAAsF
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

The final i915_request_put() can release the last reference to a
signaled request, freeing it synchronously (kmem_cache_free) before the
RCU iterator advances to read rq->signal_link.next. Grab the next
request up front, so the loop does not touch a request that may already
have been freed.

Fixes: c744d50363b7 ("drm/i915/gt: Split the breadcrumb spinlock between global and contexts")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index f840e98792cd..90bc32b526b8 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -213,7 +213,7 @@ static void signal_irq_work(struct irq_work *work)
 	for (ce = list_first_or_null_rcu(&b->signalers, typeof(*ce), signal_link);
 	     ce;
 	     ce = cn) {
-		struct i915_request *rq;
+		struct i915_request *rq, *rn;
 
 		/*
 		 * Grab the next signaler up front, as dropping the final
@@ -223,9 +223,16 @@ static void signal_irq_work(struct irq_work *work)
 		cn = list_next_or_null_rcu(&b->signalers, &ce->signal_link,
 					   typeof(*cn), signal_link);
 
-		list_for_each_entry_rcu(rq, &ce->signals, signal_link) {
+		for (rq = list_first_or_null_rcu(&ce->signals,
+						 typeof(*rq), signal_link);
+		     rq;
+		     rq = rn) {
 			bool release;
 
+			rn = list_next_or_null_rcu(&ce->signals,
+						   &rq->signal_link,
+						   typeof(*rn), signal_link);
+
 			if (!__i915_request_is_complete(rq))
 				break;
 
-- 
2.34.1

