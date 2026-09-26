Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67FAC98338
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 13:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD8310E364;
	Sat, 26 Sep 2026 13:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SYRKvTz/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C2510E364
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 13:19:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A32943C02;
 Sat, 26 Sep 2026 13:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 459AEC2BCC7;
 Sat, 26 Sep 2026 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790428778;
 bh=Tu8/XjJPAf8frBzLxxmgtLeodZdofII8mNDvbAAqs2U=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=SYRKvTz/YZyO8qwNitkt2wsmQiBHkyuX6j2e/ixgBULuUWQq5X/DuCnlw4+xKhbYF
 /fuYN8bffE+wJunL74Iq9w6OxHkpInDP8di0oVhn61bqHwZJkRNlK0/ewLZwdfjdx0
 lT9kGDlMGZQ7EFm4xaJf447BpMvQ5/4It/esDV2taT4sMtv/l7UCnBai3pj7A1o9JF
 gIDSY6mrs6eHreM2ZHUdVDiVjCa6xMLiMZw+amPS2/h7ZzeA/bQYUGCVcH53ctiIK0
 gfCMHM38oxkL0nB0N/p6cR5Y5r2Fc5l0awi9tVMukhhlRO/XkC6NZNsjx8qLy254SR
 9sCjTLPvt57oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 21E07C98338;
 Sat, 26 Sep 2026 13:19:38 +0000 (UTC)
From: Adam Azuddin via B4 Relay <devnull+azuddinadam.gmail.com@kernel.org>
Date: Sat, 26 Sep 2026 21:18:11 +0800
Subject: [PATCH] drm/appletbdrm: Fix incorrect error message on encoder
 attach failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-fix-err-msg-appletbdrm-v1-1-bb578a7dbdda@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QrCMAyG4VsZOV6gy7DY3YrsYD9ZjbhZkinC6
 L1b9fCB73sPMFZhg646QPklJo+toKkrmK7DFhllLgZy5F0gj4u8kVVxtYhDSnfex1lX9O3ZnxY
 KLQUH5ZyUy/IXvvR/23O88bR/a5DzByRmf756AAAA
X-Change-ID: 20260926-fix-err-msg-appletbdrm-63865f293290
To: Aun-Ali Zaidi <admin@kodeit.net>, Aditya Garg <aditya.garg@linux.dev>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Atharva Tiwari <evepolonium@gmail.com>, Kerem Karabay <kekrby@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Adam Azuddin <azuddinadam@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790428776; l=1145;
 i=azuddinadam@gmail.com; s=20260926; h=from:subject:message-id;
 bh=7QDII02ehFVK+b+s6cXociss9QRFT9PtnypaxLiG1UI=;
 b=eehGGRf63XYAZCL1BZESAk49qgPoTAXmb+GEmbTUA3+r2sU32mtzxtvdtOw8Bp4nZ8e4aw9Lh
 EJyO9ShXV9OAfCArGh8/VXYVtMMqSX6zCNh/AkOEaHxs/PpkpnZ31gN
X-Developer-Key: i=azuddinadam@gmail.com; a=ed25519;
 pk=ncFYTl3bFc1mmBvcpoYe65cGkYmui+zk5C3ufOQqR9s=
X-Endpoint-Received: by B4 Relay for azuddinadam@gmail.com/20260926 with
 auth_id=1066
X-Original-From: Adam Azuddin <azuddinadam@gmail.com>
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
Reply-To: azuddinadam@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Adam Azuddin <azuddinadam@gmail.com>

drm_connector_attach_encoder() replaced an earlier call to
drm_simple_display_pipe_init() during review, but the error message
logged on failure was not updated to match and still refers to the
old call.

Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 Macs")
Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 drivers/gpu/drm/tiny/appletbdrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index 4297d9c1125e..91a51b513911 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -724,7 +724,7 @@ static int appletbdrm_setup_mode_config(struct appletbdrm_device *adev)
 	ret = drm_connector_attach_encoder(connector, encoder);
 
 	if (ret) {
-		drm_err(drm, "Failed to initialize simple display pipe\n");
+		drm_err(drm, "Failed to attach connector to encoder\n");
 		return ret;
 	}
 

---
base-commit: 98c7fc4219b93f953ee85c07fb6c8256046aba73
change-id: 20260926-fix-err-msg-appletbdrm-63865f293290

Best regards,
--  
Adam Azuddin <azuddinadam@gmail.com>


