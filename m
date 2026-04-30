Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EF2FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6075210E05C;
	Thu, 30 Apr 2026 00:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Yi4ayYVZ";
	dkim-atps=neutral
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com
 [74.125.82.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F8F10E05C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 00:17:00 +0000 (UTC)
Received: by mail-dy1-f228.google.com with SMTP id
 5a478bee46e88-2d9916deb14so716171eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508220; x=1778113020;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UtGG0+J5baeIZv8EWJzZTBcov7wDfRFwsq9RM/X1eEc=;
 b=HZpefbcasBt6Ytba9WArZxMkv6GtkZbIiMYP9U7599bxyCkn9jcYUTYVrDRaKgRzEp
 xhbj3qKaaTBZiE+8WKzz8GX+nmJwx353hbVxVmJCjGyMoa6mmxP1IIZ5aBX/amqKO9TF
 UmqoSC7Vn+9PjB/Igw+ruj8HIIdgGcxyiw1rEMRC4yqC8YoJY9vPHvdgA7C8FqcFfUSj
 GSjzZ38SwnZYdCpri79sOMk/IHRke+Oe3S3bh0PcYtwLCAr6grXaUBqkhdZUudJo3iHz
 8rdKZcE53Dsx6tSWWYJts1a3++C4EHA8u3OwVHDCfLLzn4wTPqHvAfCzR9js44jUT1Nf
 WvqQ==
X-Gm-Message-State: AOJu0YzvfP9n3tERSCaSCAf4b4QR7LD/4h29MZZK8hm5f13NuFU0NqBB
 KbLFUbgjxCzTtNyxpNyM7lfSI5ZY45H2TAIrarb3UgoripljI1uq7iFTAJ+xHj5lhk6IjoN/iDV
 sJLSPENT4QyzglT0X01M6XrGZH2min7UkaNYS57QvDxCnK8gwYb4DeCTX76/ZYeMBUdSiHt2i8o
 C8OnBvKHSDWz1eE9lm5yizEDHnfroJyjU2d+g3DknHQ7ex4Owc+3HOh6PtIEX1PNU+GYKvKkRH4
 S/XnApwK+hTxuFawjUjYUJ3jQoD
X-Gm-Gg: AeBDiesK4KCiO3AMlYN+Dt7EhQ3WAJzxngi2eTdI0UG10itp4hliCOnH1knQT0veeEC
 4rbMuoL7/Q4A5WGScxYptrb0oaBqi6euIQtC0jGiKFeM5xps3OATe9M1oGpgBxEHdkyMQQL+dHC
 1cFug7T7jRrPxXZzQV7i+9ooQAznoBSbkCf6at+wdZ6zu9cgDgh8oASi7ipSE3kIoy9Z3N1GUDA
 +xfbmhCAv4BjvzcHSAS7qbEsFeEOU8KO7gNL4Utvt0qPSNDTD+VZtFFKapgqr/6NTylURt49abG
 fz0V5BXTmYV9xWPU6synaMhWNt1Y7+1bFK/dztcHaT80MKg8Gccu2uNvQXSFxmTenTFsIaXsf9/
 nJYHYZLLGufVmzyXkH3b6iPIVzBvOsk+cYfQd3esB+3MUf3H4OqP7VFXFYLUaWrUnJ5dsfDQQws
 qK38FfYoonm0WEkNwYEDs4Nqet4B5Q+I5NUAt0Npzio2mYf6O0dGgWqhzIlUqcTmLA90r/XIH3H
 zo=
X-Received: by 2002:a05:7300:ed87:b0:2d8:7302:d21 with SMTP id
 5a478bee46e88-2ed3d8c4fb6mr216419eec.16.1777508219711; 
 Wed, 29 Apr 2026 17:16:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2ed1bf6922esm289939eec.6.2026.04.29.17.16.59
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Apr 2026 17:16:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2dd6fb4c867so1832233eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777508217; x=1778113017;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UtGG0+J5baeIZv8EWJzZTBcov7wDfRFwsq9RM/X1eEc=;
 b=Yi4ayYVZ9FiE5Dl2uFf4+6ynPl5QrRFjVzsxRxTzc2Menhjj5B4qmVKnldZEiu3w+1
 9gEtpxCheJe+WcIUyMrCTULKA0t1Z4BHiejsUNYd8vwnpJ1D4nRvwaObGSwzTtnmGQDo
 o92NIAY+MrXRXKTvMnXG/QE965pmzklItKaWc=
X-Received: by 2002:a05:693c:37cb:b0:2ed:e17:d50c with SMTP id
 5a478bee46e88-2ed3e974994mr219764eec.31.1777508217479; 
 Wed, 29 Apr 2026 17:16:57 -0700 (PDT)
X-Received: by 2002:a05:693c:37cb:b0:2ed:e17:d50c with SMTP id
 5a478bee46e88-2ed3e974994mr219751eec.31.1777508216846; 
 Wed, 29 Apr 2026 17:16:56 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0ce05bsm4173885eec.26.2026.04.29.17.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:16:56 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH 1/4] drm/vmwgfx: Add some checks to
 vmw_cursor_plane_atomic_update
Date: Wed, 29 Apr 2026 17:19:09 -0700
Message-ID: <20260430001913.482967-1-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

In cases where old_state may not be present we hit a null dereference.
Add a check to fix this and also do an early return if there is no
new_state or crtc since there is nothing to do in that case.
This fixes igt test kms_cursor_legacy@torture-bo.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index c46f17ba7236..88b7185a8371 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -744,9 +744,14 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 	struct vmw_bo *bo;
 	struct drm_plane_state *new_state =
 		drm_atomic_get_new_plane_state(state, plane);
+	if (!new_state)
+		return;
 	struct drm_plane_state *old_state =
 		drm_atomic_get_old_plane_state(state, plane);
-	struct drm_crtc *crtc = new_state->crtc ?: old_state->crtc;
+	struct drm_crtc *crtc = new_state->crtc ? new_state->crtc :
+		(old_state ? old_state->crtc : NULL);
+	if (!crtc)
+		return;
 	struct vmw_private *dev_priv = vmw_priv(plane->dev);
 	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
-- 
2.54.0

