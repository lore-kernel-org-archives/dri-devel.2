Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12885CD6E55
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 00:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE0010EACA;
	Tue,  2 Jun 2026 00:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Ti2dzOHu";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Tue, 02 Jun 2026 00:50:29 UTC
Received: from mail-m10231.netease.com (mail-m10231.netease.com
 [154.81.10.231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E9810EAC7;
 Tue,  2 Jun 2026 00:50:29 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
 by smtp.qiye.163.com (Hmail) with ESMTP id 40a97ffdf;
 Tue, 2 Jun 2026 08:45:23 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, dev@lankhorst.se, bigeasy@linutronix.de,
 matthew.brost@intel.com, uma.shankar@intel.com,
 pierre-louis.bossart@linux.dev, jerome.anand@intel.com, tiwai@suse.de,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, runyu.xiao@seu.edu.cn
Subject: [PATCH v3] drm/i915/display: Fix intel_lpe_audio_irq_handler for
 PREEMPT-RT
Date: Tue,  2 Jun 2026 08:45:15 +0800
Message-Id: <20260602004515.1907422-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e85cad60c03a1kunm98872be714fe1a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSRlKVh8ZH0JISEIfHkkeTVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
 hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=Ti2dzOHuZ+eP9EKi43hV1XIsRxjizMtyRKkcgt1l3Nna6v4l2J3LM1fV6Wurhn13xyDm2i8FQY25rkmz6E0CVSzMtNVWqLlWP2VVqaZhOEd24Q/AqqQ02kZGA8YQtLmagg+L1edwNPYljRCAlFVvlrkIOFuD41fOJI6fcDyfSvc=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=2x4m2SDWFct7gym+P9m9x6fbIOlasM7XxWO3aU11vLY=;
 h=date:mime-version:subject:message-id:from;
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

From: Maarten Lankhorst <dev@lankhorst.se>

The LPE audio interrupt comes from the i915 interrupt handler. It
should be in irq disabled context.

With PREEMPT_RT enabled, the IRQ handler is threaded.
Because intel_lpe_audio_irq_handler() may be called in threaded IRQ context,
generic_handle_irq_safe API disables the interrupts before calling LPE's
interrupt top half handler.

This fixes braswell audio issues with RT enabled.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v3:
- Rebase the standalone patch on Maarten Lankhorst's original fix
- Keep Maarten Lankhorst as author per Sebastian's feedback
- Carry forward Maarten's Reviewed-by tags

 drivers/gpu/drm/i915/display/intel_lpe_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lpe_audio.c b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
index 42284e9928f2..ac1dfd592a9f 100644
--- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
@@ -263,7 +263,7 @@ void intel_lpe_audio_irq_handler(struct intel_display *display)
 	if (!HAS_LPE_AUDIO(display))
 		return;
 
-	ret = generic_handle_irq(display->audio.lpe.irq);
+	ret = generic_handle_irq_safe(display->audio.lpe.irq);
 	if (ret)
 		drm_err_ratelimited(display->drm,
 				    "error handling LPE audio irq: %d\n", ret);
-- 
2.34.1
