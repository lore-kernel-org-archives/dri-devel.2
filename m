Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A9606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=oJNrw0X/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3DAE10E9E4;
	Sun,  1 Nov 2026 11:58:12 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0B810E03C
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:57:03 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jHBdV2QjqzKp1j;
 Sat, 31 Oct 2026 22:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793483822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qfzGNiaYyEMORFtY8Ei8nisce4Apsfe/vB+EPdpQ9as=;
 b=oJNrw0X/3EPwm/RCRHmlI+8LXbSCRHtnE2dgRvG9xfZVAWvj8mWqDOMk4xIA+Ct2EQWNJo
 v+kojkhkPymYGzSKX/OOyylVmeLuebPHrikhvIt43UVjjWHKtns1wjIhmz9ivSSggxBg4l
 +XET4ZQPRZCgodhTOe8vWtNkKTnjC7H4nPGeEKCD3JmmjH/2bo0zk5HKw71+JCNKMDZLxy
 NrN9JyVEwhi/D22ZMvSNCrN57qA54ELPhstyI6Ln/5uCwn6Ay9uCkL2ylrQlf4gmFSlETw
 JlDkElprXz/auyw9LzzuCjtyouO67MhYv8YVc9vVw/8t/Lsu85ZroXaZ+fKdTw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/client: Clear stale cmdline modes before the 1024x768
 clone pass
Date: Sat, 31 Oct 2026 21:56:58 +0000
Message-ID: <20261031215700.1077873-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jHBdV2QjqzKp1j
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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

drm_client_target_cloned() first tries to clone with the mode each
connector got from the kernel's video= option, then falls back to
1024x768 on every connector. The fallback keeps the modes the first
pass left behind, so a connector that has a video= mode set and no
1024x768 mode can make it report a clone with modes that differ. On a
single-CRTC device one connector then gets no CRTC

Patch 1 frees those modes before the fallback. Patch 2 adds a KUnit
test that fails without it

Sashiko flagged this while reviewing my fbdev probe series [1]. I
haven't hit it on hardware: it needs a single-CRTC device with two
connected outputs and video= set on only some of them, and it only shows
on the fbdev console. The KUnit test reproduces it, but how often it
happens on real systems is unconfirmed

[1] https://lore.kernel.org/all/20261024165355.2782145-1-hugo@hsal.es/

Hugo Sales (2):
  drm/client: Clear cmdline modes before the 1024x768 clone pass
  drm/tests: client-modeset: Test cloning with video= on one connector

 drivers/gpu/drm/drm_client_modeset.c          |   2 +
 .../gpu/drm/tests/drm_client_modeset_test.c   | 109 +++++++++++++++++-
 2 files changed, 110 insertions(+), 1 deletion(-)


base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
-- 
2.56.0

