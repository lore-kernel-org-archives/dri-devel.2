Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AF4F8FA6D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF2710EC7E;
	Tue, 21 Apr 2026 12:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="e/oEekfA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9GwQ2rBn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e/oEekfA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9GwQ2rBn";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6BB10EC73
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 12:57:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DEB595BCD2;
 Tue, 21 Apr 2026 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776776259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iH5kRLztgtCWlEtoeJ/2z/IYlNkSqYYUornD/uJQ4W8=;
 b=e/oEekfAulJ8j/h8ihn3KB8imuafhYKC89oS5ym4p4lzc4lFYh73bxu+AK4uDas5hqgk7N
 GHa96o76Dq7HZGbjJQ8xuAjIEHf4N9nADQoEebT1hYs0Ls+7TC+TAne7KmuHM90sfZHZjR
 G10g4uBk8Wv9FcX3UtguJffFD5GhI8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776776259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iH5kRLztgtCWlEtoeJ/2z/IYlNkSqYYUornD/uJQ4W8=;
 b=9GwQ2rBnimlmeIxrn7K/OxUkHVMKLpxnJtjHBnfc/Xj+ZRf6MnfxnzyjJkbb+ix0yudHct
 e3Lm2e1KKpP0ZmCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776776259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iH5kRLztgtCWlEtoeJ/2z/IYlNkSqYYUornD/uJQ4W8=;
 b=e/oEekfAulJ8j/h8ihn3KB8imuafhYKC89oS5ym4p4lzc4lFYh73bxu+AK4uDas5hqgk7N
 GHa96o76Dq7HZGbjJQ8xuAjIEHf4N9nADQoEebT1hYs0Ls+7TC+TAne7KmuHM90sfZHZjR
 G10g4uBk8Wv9FcX3UtguJffFD5GhI8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776776259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iH5kRLztgtCWlEtoeJ/2z/IYlNkSqYYUornD/uJQ4W8=;
 b=9GwQ2rBnimlmeIxrn7K/OxUkHVMKLpxnJtjHBnfc/Xj+ZRf6MnfxnzyjJkbb+ix0yudHct
 e3Lm2e1KKpP0ZmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A9AC593AF;
 Tue, 21 Apr 2026 12:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ShRpIEN052labwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 12:57:39 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/6] drm/msm: fbdev: Use client buffers
Date: Tue, 21 Apr 2026 14:51:13 +0200
Message-ID: <20260421125733.209568-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

A client buffer holds the DRM framebuffer for an in-kernel DRM
client. Until now, msm created an internal ad-hoc framebuffer for
its fbdev emulation, while by-passing the regular interfaces used by
user-space compositors.

Convert msm's fbdev emulation to use client buffers. Replacing the
existing code with a client buffer allows for stream-lining msm code
and later also the fbdev helpers. The new framebuffer will be registered
against the client's file and will support handles for GEM objects. It
is then just another framebuffer within the DRM ecosystem.

Patches 1 and 6 change visibility of msm_framebuffer_init() during the
refactoring. It is the easiest way to refactor the fbdev probe helper.

Patch 2 and 3 inline the fb allocation code into the fbdev-probe helper
and fix it up a bit.

From there patches 4 and 5 convert fbdev buffer allocation to common
DRM helpes and client buffers.

If all fbdev emulation helpers can be converted to client buffers, the
emulation's whole framebuffer handling could possibly be moved into
shared helpers.

Thomas Zimmermann (6):
  drm/msm: Do not declare msm_framebuffer_init() as static
  drm/msm: fbdev: Inline msm_alloc_stolen_fb()
  drm/msm: fbdev: Fix error reporting
  drm/msm: fbdev: Calculate buffer geometry with format helpers
  drm/msm: fbdev: Use a DRM client buffer
  drm/msm: Make msm_framebuffer_init() an internal interface again

 drivers/gpu/drm/msm/msm_drv.h   |  9 ---
 drivers/gpu/drm/msm/msm_fb.c    | 98 +++++++++------------------------
 drivers/gpu/drm/msm/msm_fbdev.c | 85 +++++++++++++++++++---------
 3 files changed, 85 insertions(+), 107 deletions(-)

-- 
2.53.0

