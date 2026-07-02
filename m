Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0607FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5971510E283;
	Thu,  2 Jul 2026 15:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="QgaJerr9";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D0A810E283
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=QyHcD2maUl1+iR/NwYMaR7nRqr2+evGjUhRfjdA4Fcw=; t=1783006050; x=1784215650; 
 b=QgaJerr95mowJKJNP3kIb5hdXGR8q2hebtGsAHK+T+7BahkZZxf5hOmja+m9UIDIgv3mnczb5YX
 EE23ECYFC1lBohd/bC44iQqtFLT+te2zHdCqro82/4Ys16iJ2fqCLwrMoBXGgNQO8P2T4CEwk9VKj
 Xd7UVLiqRTXwUvVVaDUj/+oXR5/exsp2NqZ/A05MLaIX8YrrC8WizHnl0KIA3+w5pKo5ojAG1pDKk
 pqHvlqPqjPNK8L+iN4vx0kx2iqUXpaqmRkhrBAruq7vL3nfKZXbTXgm2V7Wx7hBQchpwhElRFTdAf
 E7QugZG1+wpUuABUbHvSatuRWYATJZcS0AWA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 02 Jul 2026 17:27:11 +0200
Subject: [PATCH v2] drm/omap: dsi: do not copy isr table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAE6DRmoC/2WNQQ6CMBBFr0JmbQ0tFIWV9zAsWjojo7GYFoiGc
 HcLLl2+5P33F4gYGCM02QIBZ448+ATqkEHXG39DwS4xqFxVeaVq4SKLyZA4SUuWCq0LS5DsV0D
 i9166tj+Ok71jN27zzeg5jkP47Fez3Lz/6iyFFEbjuS6pxNLJywOf3jg8sqcB2nVdv/1Qwp+zA
 AAA
X-Change-ID: 20260629-dsi-uaf-71bfbf3553bf
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Tomi Valkeinen <tomi.valkeinen@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=VlBhh5GT89LrG7d1fQdNbMdChy0IHhum+QNNLF2uL5g=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFluzRGzJrS+Ps2h91rtb/wtsZS4c2J3jjD0Psxu0dpty
 RPosLuvo5SFQYyLQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgIkImjP89+CNCLjn1muboqxo
 v3TCu6lfHhQu2GETfJfbUOuCPGPQGob/eXW2e8+HSsuujtNcmcZa9o69uvxq2pFewdtStw915c3
 kAQA=
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
Changes in v2:
- remove variable definition (Sashiko)
- Link to v1: https://patch.msgid.link/20260629-dsi-uaf-v1-1-a5e894f4e4d1@kemnade.info

To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 7 +------
 drivers/gpu/drm/omapdrm/dss/dsi.h | 2 --
 2 files changed, 1 insertion(+), 8 deletions(-)

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
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.h b/drivers/gpu/drm/omapdrm/dss/dsi.h
index 601707c0ecc4..2b25247ea893 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.h
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.h
@@ -379,8 +379,6 @@ struct dsi_data {
 
 	spinlock_t irq_lock;
 	struct dsi_isr_tables isr_tables;
-	/* space for a copy used by the interrupt handler */
-	struct dsi_isr_tables isr_tables_copy;
 
 	int update_vc;
 #ifdef DSI_PERF_MEASURE

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-dsi-uaf-71bfbf3553bf

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

