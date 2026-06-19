Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415FBCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D49010F60B;
	Fri, 19 Jun 2026 13:58:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="avSY2NRI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4VgMAbAO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="avSY2NRI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4VgMAbAO";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675AA10F607
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:58:52 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CADE75A4D;
 Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0C9Ty1ymauyQEKaTwkxEF5klNpukpSVKNAMv8rLygOI=;
 b=avSY2NRIf0hT5h/ZzxgGajk1CxYYOLcONvMXUCAxdqGarRqJgCbYgpGNX9Gy8OPCUW4GbU
 RnIwwc902hMauHpETzLRxSAyEdELQMZ6DdBx++0uJyvFRMOTjlUXG/HSMVYCSOa6hZBOAP
 MCnEoJwD5O2NVDseapk4sSWk+sh3Sb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781877531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0C9Ty1ymauyQEKaTwkxEF5klNpukpSVKNAMv8rLygOI=;
 b=4VgMAbAOMWlUcYIB0W8tnoux3UsPLs8EF+unofJLviAe4l/WS2vm4DngkIp3VsxOfdVPUm
 CwIOd37BNc6qRvCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=avSY2NRI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4VgMAbAO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0C9Ty1ymauyQEKaTwkxEF5klNpukpSVKNAMv8rLygOI=;
 b=avSY2NRIf0hT5h/ZzxgGajk1CxYYOLcONvMXUCAxdqGarRqJgCbYgpGNX9Gy8OPCUW4GbU
 RnIwwc902hMauHpETzLRxSAyEdELQMZ6DdBx++0uJyvFRMOTjlUXG/HSMVYCSOa6hZBOAP
 MCnEoJwD5O2NVDseapk4sSWk+sh3Sb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781877531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0C9Ty1ymauyQEKaTwkxEF5klNpukpSVKNAMv8rLygOI=;
 b=4VgMAbAOMWlUcYIB0W8tnoux3UsPLs8EF+unofJLviAe4l/WS2vm4DngkIp3VsxOfdVPUm
 CwIOd37BNc6qRvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAF1A779A8;
 Fri, 19 Jun 2026 13:58:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9SF8LBpLNWpvfwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 19 Jun 2026 13:58:50 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/3] drm/sysfb: simpledrm: Various improvements
Date: Fri, 19 Jun 2026 15:56:33 +0200
Message-ID: <20260619135847.309664-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0CADE75A4D
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

Patches 1 and 2 improve validation of the values provided by the
device firmware.

Patch 3 improves support for panel rotation. There's a rotation
property in the DT panel node. Read the value and set the connector's
orientation property accordingly.

Thomas Zimmermann (3):
  drm/sysfb: simpledrm: Improve framebuffer-size validation
  drm/sysfb: simpledrm: Improve panel-size validation
  drm/sysfb: simpledrm: Read panel orientation from DT node

 drivers/gpu/drm/sysfb/simpledrm.c | 75 +++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 9 deletions(-)

-- 
2.54.0

