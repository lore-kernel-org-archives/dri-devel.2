Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93298C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F021810F4A5;
	Thu,  2 Jul 2026 15:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="cD5JuBT2";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4993E10F4A5
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=hQsAfX1ZrVjd1qBgp6WovB6FVpvfR1qOWtzov+lIbew=; t=1783007443; x=1784217043; 
 b=cD5JuBT24PEO8wG+DQ2/d0UqqGHXETDxOAs1kcmukhdOQslKKCJk/iiZge+ok0GihNQKcYVWBsI
 V6LgF4zPC7fkR1bP3u9ohkx6m/Rn1UNAGP9I8for+8/EU+98z9asv6OKgKCh/YDyruRsfv8ERTLM5
 8KDQmKrtTPBOwVoGnaUGAXbZIYIs3m26L8QZv+8c4eTOW5rIx9gY8VZLpzHlIiTU7Ydvyix6f/JgN
 GMstWMP5fW+qG5zll8yu/EMT9MpnbCzfZ64Eb7zOZRYMrTjcsx4MyT/W7dR4yyFDuBThOdFhvrLnN
 Q8GiwdJJr8bIU/7HBa4LonaLswuB9KBhaBJQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 02 Jul 2026 17:50:35 +0200
Subject: [PATCH] fb: omap2: dsi: do not copy isr table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-fbomap-uaf-fix-v1-1-6417edf9d3e7@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAMuIRmoC/yXMywqAIBCF4VeJWTdgBiq9SrTQGmuCLmhFEL17V
 svvwPkviBSYIlTZBYEOjrzMCUWeQTvYuSfkLhmkkEpoIdG7ZbIr7taj5xMLpakz1jhfGkinNVC
 av2Dd/I67G6nd3grc9wOZSoJacgAAAA==
X-Change-ID: 20260702-fbomap-uaf-fix-167ed8a8bf38
To: Helge Deller <deller@gmx.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 sashiko-bot@kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=FqDrGw5R4E8czJm4KoZVWMrrolruAjzN3fbEGxsWOAg=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFluHRfitNy1PhSqCMQn6RslZk28PPfXAa6seF59y4T/0
 10/HI/sKGVhEONikBVTZPllreD2SeVZbvDUCHuYOaxMIEMYuDgFYCKTlzMydKi8CptQtoRljvn0
 4r/zs9d299ofSO93ipvf9bzNl7tkM8P/9Jc81ZbJ97jrXJkcq0o9HmqbL0pifRX10+pmTEjM1c1
 cAA==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

To te able to unregister stuff from isrs, the corresponding table was
copied.  Nobody seems to unregister stuff that way, so it does not help.
But there are stack-allocated objects passed to these isrs giving chances
of UAF of these objects if irqs are unregistered while they are handled,
so better do not copy that table.

Suggested-by: sashiko-bot@kernel.org
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Fix for drm variant fo driver:
https://lore.kernel.org/lkml/20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info/
---
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index 330d9fb7d2b0..d98db01fdd39 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -326,8 +326,6 @@ struct dsi_data {
 
 	spinlock_t irq_lock;
 	struct dsi_isr_tables isr_tables;
-	/* space for a copy used by the interrupt handler */
-	struct dsi_isr_tables isr_tables_copy;
 
 	int update_channel;
 #ifdef DSI_PERF_MEASURE
@@ -838,15 +836,10 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 		timer_delete(&dsi->te_timer);
 #endif
 
-	/* make a copy and unlock, so that isrs can unregister
-	 * themselves */
-	memcpy(&dsi->isr_tables_copy, &dsi->isr_tables,
-		sizeof(dsi->isr_tables));
 
+	dsi_handle_isrs(&dsi->isr_tables, irqstatus, vcstatus, ciostatus);
 	spin_unlock(&dsi->irq_lock);
 
-	dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
-
 	dsi_handle_irq_errors(dsidev, irqstatus, vcstatus, ciostatus);
 
 	dsi_collect_irq_stats(dsidev, irqstatus, vcstatus, ciostatus);

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-fbomap-uaf-fix-167ed8a8bf38

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

