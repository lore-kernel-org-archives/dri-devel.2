Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7A0C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7574410EEF5;
	Thu, 27 Aug 2026 08:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RCRyAz5e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JEiiT4oZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gu/+rD0k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s0urtQio";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F148E10EEF5
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:29:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE0892127F;
 Thu, 27 Aug 2026 08:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787819366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/KWrS0Mo+JGkLPnTednSL2ivrpJ1plQWkre1r+mQl0=;
 b=RCRyAz5elyCVo0+Se1cSfE+UTCdPnL9RF+7DngSmn+4HVAfLSr7s5Uau7G5t9XyAuGyKSn
 cbEGoW1ABonggLXd9lyJlJ4k0ecDTMJ0XUL4sEqJTZ3/PL5a4G7CktukCkE8zLHmIElBS3
 rVWJ1rWf/yXD2cXdQlAotIHCo6DQLsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787819366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/KWrS0Mo+JGkLPnTednSL2ivrpJ1plQWkre1r+mQl0=;
 b=JEiiT4oZ+GZE/yG7SKo0mfdQbf9EU6OLS2Az2hSx3j0T0VXfpIxCn0uNE0CDJNU2Z/JzrD
 Z2HUjNmuisvBBUAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787819361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/KWrS0Mo+JGkLPnTednSL2ivrpJ1plQWkre1r+mQl0=;
 b=Gu/+rD0kFYD/Yb5MKB5Srol4/GEK07qZ3FbKaozWXwEu07+IKSCpNrwI2NOonyNT9NnYvq
 y8DHKPy0LX0WvwcEQ0pGY4KtG+J8Sd8HBEJN5MWwpcbDt3vRcQFD0TvSxSGv4vbxU/YqQl
 wvE1FznWBOxUWa7bFvkvfW0jJsNLMrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787819361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/KWrS0Mo+JGkLPnTednSL2ivrpJ1plQWkre1r+mQl0=;
 b=s0urtQio5DNKuQ/KqHSfG8/RuBTCma92vHuYjFpWfsfRGi5I1wjtVTt3vCPDRmykyX9rDi
 VyppdKxnFjK04zAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD1391352D;
 Thu, 27 Aug 2026 08:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GMYMKWH1j2p4PAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 27 Aug 2026 08:29:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: shiyongbang@huawei.com, kong.kongxinwei@hisilicon.com,
 tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] drm/hibmc: Return IRQ_NONE for unhandled interrupts
Date: Thu, 27 Aug 2026 10:23:44 +0200
Message-ID: <20260827082915.61176-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827082915.61176-1-tzimmermann@suse.de>
References: <20260827082915.61176-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Let the kernel know if hibmc did not handle an interrupt. Allows
the kernel to detect spurious interrupts and maintain diagnostics.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 4d85c89f3f88..602930964e93 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -49,9 +49,10 @@ static irqreturn_t hibmc_interrupt(int irq, void *arg)
 		writel(HIBMC_RAW_INTERRUPT_VBLANK(1),
 		       priv->mmio + HIBMC_RAW_INTERRUPT);
 		drm_handle_vblank(dev, 0);
+		return IRQ_HANDLED;
 	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
@@ -67,7 +68,7 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
 		return IRQ_WAKE_THREAD;
 	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
-- 
2.55.0

