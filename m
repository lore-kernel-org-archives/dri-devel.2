Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16365CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9678510F4E8;
	Fri, 15 May 2026 12:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="tMDhHC+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/PkUx1qH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tMDhHC+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/PkUx1qH";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 549E710F4E2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:09:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34F3D5EC2F;
 Fri, 15 May 2026 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778846961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQxpEXUNkwBwkxDkuuBRmg+eDo/hsdu5ZllOTWsjnNQ=;
 b=tMDhHC+Px+7xZudl9MIGD6453Uz+9h+yujT/CJU0S8G91N42SbXuNF9dt9ZimCrKU87FRc
 rZDAELJoDKNxgUX0myB567JxAhTtlEftGHcbdz/fSXBHiUtMG2CX/MKS5aJn4JQ8AbZRmX
 axE94ANuxdSPTBbXHJwHClch+xjXpJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778846961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQxpEXUNkwBwkxDkuuBRmg+eDo/hsdu5ZllOTWsjnNQ=;
 b=/PkUx1qHQohCyNBYWmgAwrPANSdmc+9pKHeul5qJXkcrQosaxzu0e/LnQ+C9cYTt21zZH3
 nJvskb6AmumpDVCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778846961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQxpEXUNkwBwkxDkuuBRmg+eDo/hsdu5ZllOTWsjnNQ=;
 b=tMDhHC+Px+7xZudl9MIGD6453Uz+9h+yujT/CJU0S8G91N42SbXuNF9dt9ZimCrKU87FRc
 rZDAELJoDKNxgUX0myB567JxAhTtlEftGHcbdz/fSXBHiUtMG2CX/MKS5aJn4JQ8AbZRmX
 axE94ANuxdSPTBbXHJwHClch+xjXpJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778846961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQxpEXUNkwBwkxDkuuBRmg+eDo/hsdu5ZllOTWsjnNQ=;
 b=/PkUx1qHQohCyNBYWmgAwrPANSdmc+9pKHeul5qJXkcrQosaxzu0e/LnQ+C9cYTt21zZH3
 nJvskb6AmumpDVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D30AA593A9;
 Fri, 15 May 2026 12:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qKhUMvAMB2rQFwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 15 May 2026 12:09:20 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch, airlied@gmail.com, mdaenzer@redhat.com,
 pekka.paalanen@collabora.com, jadahl@gmail.com, contact@emersion.fr,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/9] drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
Date: Fri, 15 May 2026 13:55:07 +0200
Message-ID: <20260515120916.333614-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515120916.333614-1-tzimmermann@suse.de>
References: <20260515120916.333614-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ffwll.ch:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL9d8yydhbkx9sasttcqzahbbr)];
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

Add DRM_VBLANK_FLAG_SIMULATED for CRTCs that do not have a hardware
vblank interrupt. Setting the flag tells DRM to not report vblank
capabilities from the WAIT_VBLANK ioctl.

DRM_IOCTL_WAIT_VBLANK queries timestamps from a vblank event or waits
for the next vblank event to occur. DRM clients use this functionality
to synchronize their output with the display's vblank phase. Hence this
is only supported for hardware implementations.

Software implementations are not synchronized to the display and merely
act as a rate limiter for page-flip events. The WAIT_VBLANK ioctl thus
should fail with an error.

Suggested-by: Simona Vetter <simona@ffwll.ch>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 3 +++
 include/drm/drm_vblank.h     | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 21ca91b4c014..92b699a4e8be 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1794,6 +1794,9 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 
 	vblank = drm_vblank_crtc(dev, pipe);
 
+	if (vblank->flags & DRM_VBLANK_FLAG_SIMULATED)
+		return -EOPNOTSUPP;
+
 	/* If the counter is currently enabled and accurate, short-circuit
 	 * queries to return the cached timestamp of the last vblank.
 	 */
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 39a201b83781..03fa7259b6ac 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -37,6 +37,11 @@ struct drm_device;
 struct drm_crtc;
 struct drm_vblank_work;
 
+/**
+ * DRM_VBLANK_FLAG_SIMULATED - vblank uses a software timer
+ */
+#define DRM_VBLANK_FLAG_SIMULATED	BIT(1)
+
 /**
  * struct drm_pending_vblank_event - pending vblank event tracking
  */
-- 
2.54.0

