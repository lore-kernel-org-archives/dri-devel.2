Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jR2BHt/s;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IdgOQfXZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KqnMwaWo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U0IgUj3Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D20112497;
	Thu, 19 Nov 2026 14:21:34 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB4311248D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:21:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1D101F78D;
 Thu, 19 Nov 2026 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5nHBcblZLfmDaoamR9yM784n46xobwpFAZSeEMyPOqQ=;
 b=jR2BHt/sb6kNNpDM4lUuwU0qKD1Z9e4v3Uqz9D/zS+wvdL5JC0QUw2shbcJ6aiPM5R3McN
 CDxajRXYmjBI3I3aAXFdCk38qE4bm/ZwVcon6fwNhEKIR3ZVApLOvwsCBszhQIQ6vGePYO
 1wISGN16Rc1eflHaEjlIjAftBEYmXRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5nHBcblZLfmDaoamR9yM784n46xobwpFAZSeEMyPOqQ=;
 b=IdgOQfXZHGWXPl9soPjNTYJyCYUnAwqWr8YBKjulnFuufBb8DBNuGBwdNhX/DjgfaYzecQ
 vxli36CZoNDcCjAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KqnMwaWo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U0IgUj3Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5nHBcblZLfmDaoamR9yM784n46xobwpFAZSeEMyPOqQ=;
 b=KqnMwaWoa5jAjUhoJiiAmppsp+uZytTb7sXwhcvypBKE6hFbNEIpck6VAVB+zf/lj4HgdT
 HdV+HNdzCphAvb3qPPhTkCr9LDbpTiQbMLjVGFVlFbikdfDRwl8FUvzIGOfJ9WTQbUszkA
 NVV8u5S3UkUuMK524vo7yEKlTrYjCus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5nHBcblZLfmDaoamR9yM784n46xobwpFAZSeEMyPOqQ=;
 b=U0IgUj3Y7caa6xqgBgvyLOj+RXYUIqFIV8Y+bbR8JIWfsjxpGFk9/EsKGBoBmsjtxDxmVN
 gz5qxXNz9jEiliCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51EBA1342D;
 Thu, 19 Nov 2026 14:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RynyAeAF/2rJfgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 14:21:20 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/11] drm/udl: Rework URB allocation
Date: Thu, 19 Nov 2026 15:02:12 +0100
Message-ID: <20261119142114.152052-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-10.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[redhat.com,poorly.run,suse.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -10.51
X-Spam-Level: 
X-Rspamd-Queue-Id: C1D101F78D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Udl caches once-allocated URBs for later use. By default, it has a
fixed number of 20 URBs in flight at most. Depending on the USB, this
can either consume too much bandwidth or keep free bandwidth unused.

Replace the fixed-size cache with dynamic allocation of the URBs
required. Adapt page-flip rate according to the actually available
bandwidth on the USB.

Patches 1 to 6 clean up the code, fix a few minor issue and provide
a clean interface for allocating and freeing URBs.

Patch 7 switches the URB cache to managed release. As before, the
cache collects all outstanding URBs as part of the USB device removal.

Patches 8 to 11 implement dynamic allocation of URBs. The URB cache
tracks the number of URBs in flight and allocates new ones of the cache
has been exhausted. The udl driver now sends out as many URBs as
necessary for the current frame without limitting itself to 20 URBs
at a time. To avoid overloading the USB, udl waits in atomic_begin()
for the previous frame's URBs to complete. This adapts page-flip
rate to the bandwidth available on the USB.

Patch 11 contains a minor improvement of the cache locality.

Tested with superttuxkart and vkcube on weston.

Note that display output might not happen faster in any way. This
series only addresses one of many bottlenecks (e.g., message packing,
software rendering).

Thomas Zimmermann (11):
  drm/udl: Release URB in udl_put_urb()
  drm/udl: Do not use URB completion handler for error cleanup
  drm/udl: Store per-URB allocation length in struct urb_node
  drm/udl: Allocate bulk URBs in helper functions
  drm/udl: Free bulk URBs in helper functions
  drm/udl: Rework the error handling in udl_submit_urb()
  drm/udl: Managed cleanup of URB cache
  drm/udl: Track number of URBs in flight
  drm/udl: Synchronize pending URBs on each frame
  drm/udl: Allocate URBs on demand
  drm/udl: Implement URB cache as LIFO stack

 drivers/gpu/drm/udl/udl_drv.c      |   2 -
 drivers/gpu/drm/udl/udl_drv.h      |   8 +-
 drivers/gpu/drm/udl/udl_main.c     | 280 +++++++++++++++--------------
 drivers/gpu/drm/udl/udl_modeset.c  |  20 ++-
 drivers/gpu/drm/udl/udl_transfer.c |   2 +-
 5 files changed, 168 insertions(+), 144 deletions(-)


base-commit: 7d502136b31169f6b5575f7f89c3da60cdf7891d
-- 
2.56.0

