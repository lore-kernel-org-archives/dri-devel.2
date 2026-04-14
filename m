Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA6DF531FA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD5910E57B;
	Tue, 14 Apr 2026 07:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ss9BqgwK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PqXQytfm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ss9BqgwK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PqXQytfm";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6096810E57B
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:05:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2942E6A977;
 Tue, 14 Apr 2026 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776150327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2+G3roNJIP/hPoDSB4jhw1TxjpAk1y79vtf0nVQrz8=;
 b=ss9BqgwK9tzQXu98lVUmsD/TU0B8Jq9nOkMgMmAiuDBUhfoWdqSlRmTcE6CGpe9Vzr0znC
 BE83cIrle2HTwnQic6girMd9v8iO5NpJEwBQ2Np3tm1RXxaPT9Jv2u3GrBM826EfPDT/ba
 4741suTma6TLOiKWU9mmPsVONsxPzEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776150327;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2+G3roNJIP/hPoDSB4jhw1TxjpAk1y79vtf0nVQrz8=;
 b=PqXQytfmrEdRiB8msCBeGm6kI34iA72c32FpXZpO4RLUpsYW36LSXRmBF6wy7Fns1LcFmF
 2vQGbrsxEWPqJtDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776150327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2+G3roNJIP/hPoDSB4jhw1TxjpAk1y79vtf0nVQrz8=;
 b=ss9BqgwK9tzQXu98lVUmsD/TU0B8Jq9nOkMgMmAiuDBUhfoWdqSlRmTcE6CGpe9Vzr0znC
 BE83cIrle2HTwnQic6girMd9v8iO5NpJEwBQ2Np3tm1RXxaPT9Jv2u3GrBM826EfPDT/ba
 4741suTma6TLOiKWU9mmPsVONsxPzEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776150327;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2+G3roNJIP/hPoDSB4jhw1TxjpAk1y79vtf0nVQrz8=;
 b=PqXQytfmrEdRiB8msCBeGm6kI34iA72c32FpXZpO4RLUpsYW36LSXRmBF6wy7Fns1LcFmF
 2vQGbrsxEWPqJtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6A9C4B2FF;
 Tue, 14 Apr 2026 07:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aJAgNzbn3WmIOgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 14 Apr 2026 07:05:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/4] drm/ast: Remove traces of DRM_FORMAT_RGB888 handling
Date: Tue, 14 Apr 2026 09:02:28 +0200
Message-ID: <20260414070522.33943-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414070522.33943-1-tzimmermann@suse.de>
References: <20260414070522.33943-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[];
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

There's some incomplete handling for DRM_FORMAT_RGB888 in the mode-
setting code. It was added by ast's original commit, which imported
the code from the user-space Xorg driver. But the hardware doesn't
support 24-bit pixel sizes. Hence remove the traces of RGB888 from
ast.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_mode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index c150b83aaca7..49585fd16267 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -155,7 +155,6 @@ static void ast_set_vbios_color_reg(struct ast_device *ast,
 	case 2:
 		color_index = HiCModeIndex;
 		break;
-	case 3:
 	case 4:
 		color_index = TrueCModeIndex;
 		break;
@@ -765,7 +764,6 @@ static int ast_crtc_helper_atomic_check(struct drm_crtc *crtc,
 	case DRM_FORMAT_RGB565:
 		ast_state->std_table = &vbios_stdtable[HiCModeIndex];
 		break;
-	case DRM_FORMAT_RGB888:
 	case DRM_FORMAT_XRGB8888:
 		ast_state->std_table = &vbios_stdtable[TrueCModeIndex];
 		break;
-- 
2.53.0

