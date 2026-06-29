Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B678C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952A210E9B3;
	Mon, 29 Jun 2026 16:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="d04Xs5Z6";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C4B10E9B3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=MrEOJflkWL6bDcp2N6HiTHDNtu9564gyWWQwsDRUxhU=; t=1782752212; x=1783961812; 
 b=d04Xs5Z6fnotNfEnVGAp9ZyQuMtBFiVw4kIW9psns4bJU98S4+PMEIXETQcsv7awDt3xCMD7yzs
 CGHXJ/bkI7iLnX8sDCpGbADtlTZ5sRXabAHf38xLCTUlOhE3KspjdhdaIB5UfIlfk0QPlO14w5G9t
 BalGpOhohey4gp23LP5qHQcX4PvvUe8TBtW8JA6QpRssEkX68HK3TBAVGVsu7E4I7+5cW3aauihPL
 awpqAj9+0+zp3TpyJLYroR/wjhBAMrsML66rcvd59mymBvsEM6KdBBrSpzOvXtggxHil8FGTguwEi
 OCCEHtsqJ+ZU6w+Z+3l0YpXFANm9xNR6yy3Q==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Mon, 29 Jun 2026 18:56:45 +0200
Subject: [PATCH] drm/omap: dsi: do not copy isr table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-dsi-uaf-v1-1-a5e894f4e4d1@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAMyjQmoC/yXMQQ5AMBCF4avIrDWhUsJVxKJlhrFAOoikcXfF8
 kv+9wIIekaBJgng8WThdYnI0wT6yS4jKh6iQWe6zEpdq0FYHZZUlTtyVBhTOIJYbx6Jr++p7X7
 L4Wbs93cO9/0AgVMO4msAAAA=
X-Change-ID: 20260629-dsi-uaf-71bfbf3553bf
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=pCX3jFK6hDmFc8GpIO4jml7VMcLPjwukX3qOvHbSZJo=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFlOiy/YWabcqNf4+O7tRtlCHt087tsptoLilz7/q+nMe
 v5F5FtVRykLgxgXg6yYIssvawW3TyrPcoOnRtjDzGFlAhnCwMUpABOJV2b4K3xdxGfCl6CJ2/42
 TihNea7xbu3Wl1bMWZf+Huzk1pjsKMzI8Fp/5c+mVSvWtNZtZjohyyG8VaflgQL35DfCxa5Gelw
 OPAA=
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

Fixes: 4ae2ddddf44cd ("OMAP: DSS2: DSI: Add ISR support")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
If this gets backported, it should be re-checked that
no isr unregisters itself in older kernel versions`.
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 27fe7bca9e2c..70cfb779d6ae 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -455,15 +455,10 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
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
 	dsi_handle_irq_errors(dsi, irqstatus, vcstatus, ciostatus);
 
 	dsi_collect_irq_stats(dsi, irqstatus, vcstatus, ciostatus);

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-dsi-uaf-71bfbf3553bf

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

