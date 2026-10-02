Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5DFCA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D3B10E5A7;
	Fri,  2 Oct 2026 12:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="tc+mSZtF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2aIrGMzI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IAgq9ScD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ioc/k14u";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD8510E5A7
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:45:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30A7A21D63;
 Fri,  2 Oct 2026 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790945107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iV0g1V+SQVwheY8YK5/iGD2kfKY2xrRvXyiVMofniW4=;
 b=tc+mSZtFWn1sXROKi/w7iQ+ORI2g3GUC4w/UMs5qbCWzMWpQvRjYhcE7CumFz7GTN9kiLZ
 DV97RFlZ1x6X61dpPhtPK5NyTnZNz03fw18AzBp1quW2dqCML8Fk+i39NrMED/UwYAG7X8
 S+Fz8VK38EuEdPLYIfDzc4gcXzJisXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790945107;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iV0g1V+SQVwheY8YK5/iGD2kfKY2xrRvXyiVMofniW4=;
 b=2aIrGMzIZr8TW5hJjNPj26h99TJTfC0abXV1XPlXbJfYG5yranv7ET0qmie2u9fY16Pb/z
 1T0nf/eXvjcNLDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790945103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iV0g1V+SQVwheY8YK5/iGD2kfKY2xrRvXyiVMofniW4=;
 b=IAgq9ScDOvIDzLUasDLjmQsTHziMXmhBp8PvbFiMCBr8A9bFbX1Kd1afNSojzJt4nQ02ml
 hn4VFo68kzgUiBgMdKFFqQy1JhlHmJskDc6sIG/wJ060gYY+Sz8M5ouqnT6XmvLcAQCR0Y
 gA9/kym5+XYIC78Fk8DyIK2ZnMnRTWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790945103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iV0g1V+SQVwheY8YK5/iGD2kfKY2xrRvXyiVMofniW4=;
 b=Ioc/k14uvfN24WdpaAyS3NTzVe6/bak+Z4+JpA2AEBgc9WLrdQNs+Unxkb34KNYs0EM7eq
 Aw6NksGPEgsu10CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F1F513C96;
 Fri,  2 Oct 2026 12:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V/hJI0ynv2rNTwAAD6G6ig:T5
 (envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 12:45:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 4/7] drm/hisilicon/hibmc: Do not include
 <drm/drm_simple_kms_helper.h>
Date: Fri,  2 Oct 2026 14:41:54 +0200
Message-ID: <20261002124456.741011-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124456.741011-1-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.977];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[15]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

The hibmc driver does not require anything from the simple-kms
header. Do not include it.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c   | 1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 2e9403b8bf3c..7bf6befa0440 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -4,7 +4,6 @@
 #include <linux/io.h>
 
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_drv.h>
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index b9bd6d33fb0f..0b72509f7a69 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -17,7 +17,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
-- 
2.55.0

