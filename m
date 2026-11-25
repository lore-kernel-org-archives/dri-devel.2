Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E2606A329
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Txso7YoT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7052310E069;
	Wed, 25 Nov 2026 12:38:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CA210E069
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:38:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 434EA60D50;
 Wed, 25 Nov 2026 12:38:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795610320;
 b=lbRpuhHQJidV2nq+KK6ubqxD1tnW+HhFVt4HVNA8H+6Ly6G6UCkyaEQlGJ2iLLPHjcCY
 ptVuqGgsDmei8on4C6cp0b8SUHdhSpV3xjazq04I/YlrDtN1xv/rd3E7XrYQn58eDgl+A
 peUKFQuvutQ/44glBtCLKyaY3C7B6LmUjeBfBzxziWP6xPwNRnVhqUFH46CW1Io5SmeCj
 HQdaKDsq38dhPvHptU2by/toZ7JeDrx7+ITURPp/HVes7xw6/ptdIifvtloJAb/P/0gm/
 kQpbRtnBicaRgj5D5ZQcHNjmw6PeI9BXQWZnCZZrFb3KnwANm6o5JfC6P/+pcYtSV1w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795610320;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=eRQOicpchPrZCt4YqUDAz2zN1yXBgPyxEnaRvrX014M=;
 b=Mhg+gsGoYXZoH7L7ErbsnUI+W2R1BPpnbhEVAuM3asef6GD61qwNZb74irxHOw6pTAn6
 1bJwkLvtPWsbfj66Kq+jJMa4pEn2Vu7XBZprFCGvPKDdadPUz7Sb9EI8ih7yyxq+rgC44
 rkZ9g0rzh5pHq8a75lk4CJp8YAQFPfjIIBNMKwIXMsmpcaBzXpivM/llvmGHbuglZ6Ind
 oOEa5TT66f5cORHAY+erkpAtMC9jEVjzFx3Al1+syaOUUaAdLxbc/ZiR7ep2jzayamFq3
 EeSTaytRMniJQBRzP3gu1L+arqMN+CWcJv+y7X3gQILqGUZn3K1XZ0gPQmDx6kssDhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A68F21F000E0;
 Wed, 25 Nov 2026 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795610320;
 bh=eRQOicpchPrZCt4YqUDAz2zN1yXBgPyxEnaRvrX014M=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Txso7YoTrqTV2+U7LXuU/5IT+YbJgO3b7CZ0QCMNYPfSizA+nfgSC+4KY/SwiRPNK
 iyWFxMGxlnUrJcsAgzEB/xkB7nqVZaJOqgpXvBKXpiMVKOuHy93K2AZgIi3ffQblcm
 sEPUnWiykqZfZX8TAbHmJTFtFRtTSufazY0JjTarBDtuXVNt/DiTvfZjZpG+XQHAcI
 Yz5hu1VYHEEEoq26XMxb+bvHALLoXl21uDfrRaGKI6RmxRxKgrHiILCNnpTqhf5ZJs
 L+rb19aZnDPEN9Jc6Il2UtVI+lCNx1fahfUMLxZxOHg3YeBZ2J3e+8yHlczOLrZsQH
 wb0c7kAaVjUyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 342144CEBB;
 Wed, 25 Nov 2026 12:38:36 +0000 (UTC)
From: Kylie C via B4 Relay <devnull+kyliepc.proton.me@kernel.org>
Date: Wed, 25 Nov 2026 07:38:29 -0500
Subject: [PATCH] drm/fbdev-client: Don't restore while fbcon isn't bound
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-fbdev-no-early-restore-v1-1-f81dc7acf3ad@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTtgQlPRq4iLpvmrI5LITFuU0
 rsbdfkt3lvJoAKjU7OSYhGTkivcrqHh1ucrWFI1+b3vnPOBx5iwcC6MXh9vVthUFJwOrg1tAOK
 xoxo/FaO8fuPz5W+b4x3D9L3Rtn0AljY7xHoAAAA=
X-Change-ID: 20261125-fbdev-no-early-restore-d714545eeb96
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kylie C <kyliepc@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795610315; l=1165;
 i=kyliepc@proton.me; s=20261022; h=from:subject:message-id;
 bh=2N+1pHpr6q4BPQmblStjA3/pJkTxrz1YV0M42dq9rME=;
 b=+w3aqPeBetmqfZ1x45FXHC4bGkF8NiQGgsL+Lm9O5wJAcxwluT9qHEz5JW1ulNKXSTl+D5pq+
 e/403IBKrbwC1BZx3Po3y0h8tKqko9wgniubf3B3Qs8lmp4u4/ShY3j
X-Developer-Key: i=kyliepc@proton.me; a=ed25519;
 pk=T/yRT5OdlaWnEmvYU6894i5NEH44SmsyRlMNTde5DDs=
X-Endpoint-Received: by B4 Relay for kyliepc@proton.me/20261022 with
 auth_id=1285
X-Original-From: Kylie C <kyliepc@proton.me>
Content-Transfer-Encoding: 7bit
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
Reply-To: kyliepc@proton.me
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kylie C <kyliepc@proton.me>

With deferred console takeover, fbcon hasn't bound to
that framebuffer yet, so there is no console to bring back. Restoring
it only replaces what the last DRM client left on screen, with an empty
framebuffer breaking flicker-free boot.

Only restore on lastclose once fbcon has bound to the framebuffer.

Signed-off-by: Kylie C <kyliepc@proton.me>
---
 drivers/gpu/drm/clients/drm_fbdev_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
index eec463d19943..7981d613e652 100644
--- a/drivers/gpu/drm/clients/drm_fbdev_client.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
@@ -50,6 +50,9 @@ static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
 	if (!fb_helper->info || !fb_helper->fb)
 		return 0;
 
+	if (!force && !fb_helper->info->fbcon_par)
+		return 0;
+
 	drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper, force);
 
 	return 0;

---
base-commit: a2853fd7f6217573dfb780809663683d5b9c5835
change-id: 20261125-fbdev-no-early-restore-d714545eeb96

Best regards,
--  
Kylie C <kyliepc@proton.me>


