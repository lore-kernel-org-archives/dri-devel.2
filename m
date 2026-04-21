Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18F8F327B5
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D6BE10E823;
	Tue, 21 Apr 2026 07:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="G+E0IoaR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o7m/TE0F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G+E0IoaR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o7m/TE0F";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8297E10E823
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:37:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A42895BCEE;
 Tue, 21 Apr 2026 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776757015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6v2d000VBFK38+rdl2qZKRPaBJ05/EoUtK46bREAgA=;
 b=G+E0IoaRHIHadzBHI8asI/BTFUa8dJBlFdpoaCWZnsOuuK2JFTI/rZ3RfBSzPhd7JNGjBQ
 JWzJcOLxRDZJXeQNvTQIYcfEGG5SNCHJDAoqx//BKx/zc1bVvr8yr6XWpLGvnBePTs7KUX
 HJi/1WHecuv1+T/Z54Nc6kQXr8laokE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776757015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6v2d000VBFK38+rdl2qZKRPaBJ05/EoUtK46bREAgA=;
 b=o7m/TE0FzL49Avo/dK+RfDqJrF1Rdn87zXfUeTOHQqhZxB8BYKmPTdEfN6M267FqSVss/P
 AfYLdD89xlpLtLAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776757015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6v2d000VBFK38+rdl2qZKRPaBJ05/EoUtK46bREAgA=;
 b=G+E0IoaRHIHadzBHI8asI/BTFUa8dJBlFdpoaCWZnsOuuK2JFTI/rZ3RfBSzPhd7JNGjBQ
 JWzJcOLxRDZJXeQNvTQIYcfEGG5SNCHJDAoqx//BKx/zc1bVvr8yr6XWpLGvnBePTs7KUX
 HJi/1WHecuv1+T/Z54Nc6kQXr8laokE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776757015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6v2d000VBFK38+rdl2qZKRPaBJ05/EoUtK46bREAgA=;
 b=o7m/TE0FzL49Avo/dK+RfDqJrF1Rdn87zXfUeTOHQqhZxB8BYKmPTdEfN6M267FqSVss/P
 AfYLdD89xlpLtLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A6E2593B0;
 Tue, 21 Apr 2026 07:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YCHKGBcp52lgMQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 07:36:55 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
 simona@ffwll.ch, jonathanh@nvidia.com
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/5] drm/tegra: Make tegra_fb_alloc() an internal interface
Date: Tue, 21 Apr 2026 09:29:09 +0200
Message-ID: <20260421073646.144712-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421073646.144712-1-tzimmermann@suse.de>
References: <20260421073646.144712-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TAGGED_RCPT(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,nvidia.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; TO_DN_SOME(0.00)[];
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

Fbdev framebuffer allocation now goes through the regular ioctl call
chain. This makes tegra_fb_alloc() an internal helper function. Declare
it as static.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tegra/drm.h | 5 -----
 drivers/gpu/drm/tegra/fb.c  | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index ae68b03d8483..bc720ae8d95e 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -184,11 +184,6 @@ struct tegra_bo *tegra_fb_get_plane(struct drm_framebuffer *framebuffer,
 bool tegra_fb_is_bottom_up(struct drm_framebuffer *framebuffer);
 int tegra_fb_get_tiling(struct drm_framebuffer *framebuffer,
 			struct tegra_bo_tiling *tiling);
-struct drm_framebuffer *tegra_fb_alloc(struct drm_device *drm,
-				       const struct drm_format_info *info,
-				       const struct drm_mode_fb_cmd2 *mode_cmd,
-				       struct tegra_bo **planes,
-				       unsigned int num_planes);
 struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 					struct drm_file *file,
 					const struct drm_format_info *info,
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index 1e4803d355dd..0a7cb9e462ff 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -102,6 +102,7 @@ static const struct drm_framebuffer_funcs tegra_fb_funcs = {
 	.create_handle = drm_gem_fb_create_handle,
 };
 
+static
 struct drm_framebuffer *tegra_fb_alloc(struct drm_device *drm,
 				       const struct drm_format_info *info,
 				       const struct drm_mode_fb_cmd2 *mode_cmd,
-- 
2.53.0

