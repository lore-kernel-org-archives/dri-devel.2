Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E102ACA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8F810E33A;
	Thu,  1 Oct 2026 13:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="QWxlbl74";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ap8fwlFG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CCeMtSll";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bmsg7QoY";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2510110E33A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:37:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 77E9321A57;
 Thu,  1 Oct 2026 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790861865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IU1IGmz/Zs2YU5nNzdx+yfrU4S/GWs8tkSN0HFIgvQA=;
 b=QWxlbl74nZob55th1gnSBrQbb8CplZI3g5L9m4hR+ul77/GKK/at4fKca5XIUF6VBF6cY3
 ZvIosav1FS0FQ9iPiqQJD6r4jsL0WaveVm3+WW5kMHkEfIqAHXiSXl5uZBZtQ1725RGLLw
 7i9PuJbyCG7e+9GFIGCi/xClL8s9SSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790861865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IU1IGmz/Zs2YU5nNzdx+yfrU4S/GWs8tkSN0HFIgvQA=;
 b=Ap8fwlFGto4xSx0T60nOsxplZP/eSdEd0aOqsqroKxCE56r08efafICDd3W3VUSO/ILRcH
 MEjUFsViyHk6JZAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790861861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IU1IGmz/Zs2YU5nNzdx+yfrU4S/GWs8tkSN0HFIgvQA=;
 b=CCeMtSllTJMEbtnRGU2QklQ+QQhsF8KPR+WirgUABqpijGmk8fuPwwN4WhyK0D7HACjcVW
 1qyboegFeWkSsSfgL4C3dflgNAQlgx16Y6YE5Yd+Zj1uOfUUev07Dmov4VSxur11xfUnFg
 LIW10hNi5xSuaBLhTMmgOr5TrOF9wRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790861861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IU1IGmz/Zs2YU5nNzdx+yfrU4S/GWs8tkSN0HFIgvQA=;
 b=bmsg7QoYSihzmHoyL4bDCC2tON2waM7EwYJnOLk8iE1YFV6UcDMi6IbZqzIEG09Mshonvf
 PMzH9cdIxqSfYBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF302134B3;
 Thu,  1 Oct 2026 13:37:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ih09KyRivmrGOQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 01 Oct 2026 13:37:40 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, longli@microsoft.com,
 ssengar@linux.microsoft.com, andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] drm: Remove simple-display pipe
Date: Thu,  1 Oct 2026 15:35:36 +0200
Message-ID: <20261001133736.802604-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[15];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
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

There are no drivers using struct drm_simple_display_pipe left. Remove
the related helpers from DRM and clear any TODO items. Hyperv-drm needs
a minor fix to include some additonal headers.

Thomas Zimmermann (2):
  drm/hyperv: Add missing include statements
  drm/kms-helper: Remove struct drm_simple_display_pipe and helpers

 Documentation/gpu/todo.rst              |  17 --
 drivers/gpu/drm/drm_gem_atomic_helper.c |  92 -------
 drivers/gpu/drm/drm_simple_kms_helper.c | 328 ------------------------
 drivers/gpu/drm/hyperv/hyperv_drm.h     |   5 +
 drivers/staging/fbtft/TODO              |   6 +-
 include/drm/drm_gem_atomic_helper.h     |  28 --
 include/drm/drm_simple_kms_helper.h     |  56 +---
 7 files changed, 10 insertions(+), 522 deletions(-)


base-commit: 9ecc25f4cc83ac280099d6c39e044d911774018d
-- 
2.55.0

