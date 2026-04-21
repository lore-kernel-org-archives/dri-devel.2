Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C74F8FA6D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4441810EC97;
	Tue, 21 Apr 2026 12:57:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="osfXnAlq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ucDb/2sa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="osfXnAlq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ucDb/2sa";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D38B10EC98
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 12:57:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C7275BD6B;
 Tue, 21 Apr 2026 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776776261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S77ksX4WmkngeoY2UGla+vj75j/hAQc/8wcHa+T3Mz8=;
 b=osfXnAlqMORm4NSH+TczTg3w0evAjzx7ZXRB0DhC994246RdsKoFiv1Irug27nkvMmOSsJ
 7DqNFjI9n3UmksRYPfNxnLRhj5/5I21ZWuR+mg2twdQ/fzzjx5LpMFhJr+hrBk4cAOEGZT
 T4iJuW+ru8yCXJ3IXa3s9rZc+vaITOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776776261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S77ksX4WmkngeoY2UGla+vj75j/hAQc/8wcHa+T3Mz8=;
 b=ucDb/2sau0VXDgxn8T+4J9hJIUMYljdHLWZHVi7OrC3G1PTfw3wLNpds+UhRJx6+aBaJbw
 j005Xrjw99leIfDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776776261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S77ksX4WmkngeoY2UGla+vj75j/hAQc/8wcHa+T3Mz8=;
 b=osfXnAlqMORm4NSH+TczTg3w0evAjzx7ZXRB0DhC994246RdsKoFiv1Irug27nkvMmOSsJ
 7DqNFjI9n3UmksRYPfNxnLRhj5/5I21ZWuR+mg2twdQ/fzzjx5LpMFhJr+hrBk4cAOEGZT
 T4iJuW+ru8yCXJ3IXa3s9rZc+vaITOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776776261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S77ksX4WmkngeoY2UGla+vj75j/hAQc/8wcHa+T3Mz8=;
 b=ucDb/2sau0VXDgxn8T+4J9hJIUMYljdHLWZHVi7OrC3G1PTfw3wLNpds+UhRJx6+aBaJbw
 j005Xrjw99leIfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8DA8593B0;
 Tue, 21 Apr 2026 12:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WB7LJ0R052labwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 12:57:40 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/6] drm/msm: fbdev: Fix error reporting
Date: Tue, 21 Apr 2026 14:51:16 +0200
Message-ID: <20260421125733.209568-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421125733.209568-1-tzimmermann@suse.de>
References: <20260421125733.209568-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Replace deprecated error reporting in msm_fbdev_driver_fbdev_probe().
Use drm_warn() and drm_err() instead.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/msm/msm_fbdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index a507f1de0c5d..1eb0368a6d07 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -114,11 +114,11 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	DBG("allocating %d bytes for fb %d", size, dev->primary->index);
 	bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC | MSM_BO_STOLEN);
 	if (IS_ERR(bo)) {
-		dev_warn(dev->dev, "could not allocate stolen bo\n");
+		drm_warn(dev, "could not allocate stolen bo\n");
 		/* try regular bo: */
 		bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC);
 		if (IS_ERR(bo)) {
-			DRM_DEV_ERROR(dev->dev, "failed to allocate buffer object\n");
+			drm_err(dev, "failed to allocate buffer object\n");
 			return PTR_ERR(bo);
 		}
 	}
@@ -136,7 +136,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 						      mode_cmd.modifier[0]),
 				  &mode_cmd, &bo);
 	if (IS_ERR(fb)) {
-		DRM_DEV_ERROR(dev->dev, "failed to allocate fb\n");
+		drm_err(dev, "failed to allocate fb\n");
 		ret = PTR_ERR(fb);
 		goto err_drm_gem_object_put;
 	}
@@ -148,7 +148,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	 */
 	ret = msm_gem_get_and_pin_iova(bo, priv->kms->vm, &paddr);
 	if (ret) {
-		DRM_DEV_ERROR(dev->dev, "failed to get buffer obj iova: %d\n", ret);
+		drm_err(dev, "failed to get buffer obj iova: %d\n", ret);
 		goto err_drm_framebuffer_remove;
 	}
 
-- 
2.53.0

