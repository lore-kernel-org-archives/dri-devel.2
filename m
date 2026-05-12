Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FDBCD37BE
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 00:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308CB10E951;
	Tue, 12 May 2026 00:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="KHtmM2nf";
	dkim-atps=neutral
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com
 [209.85.160.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B12410E949
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 00:25:47 +0000 (UTC)
Received: by mail-qt1-f226.google.com with SMTP id
 d75a77b69052e-5102582e23eso36638291cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778545546; x=1779150346;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ykOtn1C1nWRL5CNNYcN5Mi6bYTEKpGpuY6KraMmjQL0=;
 b=pCaTHrCMptqo0VEs/ogbFybfVhWeYK5VWP7E8dkorTAQT1dYXj60RZxSQ/euo8GVd3
 LGMGPxxE+Re0+C5fP/2mproAWAdClWr9UZPr1sXAdl3mR1bMUwa8B+Raw1De1mII1phf
 d8CHPThjo+E6aSQlPVZYH49lSkWLQKOAVatx7qKsiwShO/UnHIB8RgmPqMwdWozgtvV2
 MfUK+VyHMNGzTooQTJQZ2CLKBh99//l3qUGR/9F2CtHdYxgiAWtTspwYnySK790ZwJjH
 RiEaP386L9HvGhxTOQhX7EzphTGkIoBFlTJxpUpUenKWr86jIgQJ5rNWl39CXtXtsb2a
 vaHQ==
X-Gm-Message-State: AOJu0Yx+il3GiGvFIXDygFxrvme2s5Wb74CBuUp5aLIb+hDQntBZvVy9
 +a9EPxD6yi4MC4PD5ogC6eBkJdS8sztZhHYJ1jF5DqS2eLNBD+rIFg77WgIQ5qQu17lMUT6mv+F
 gi/84H/TYLgInW6qdmP+nsKKGqvVUSwl5FT8V68yF3qFJTDgw0rk8zfd/TPxwN4R/LB1sHuAqHW
 TImFSrzdvwlMNR8Sshwvt4bk4HYNvBoTgd1Xlu70qruT8BCyS6B18lPFbNiA8CC8cEqDIxHAWvq
 6uMGjxkggiQd+0XNeEdlv6bGMlw
X-Gm-Gg: Acq92OFf50MOMoEdwmJZJc/49aZ/iiWJNqWvTucfa0uwqQKhgAmJTf4ubevNhhMEHkt
 umCr00Cxcku4+GH7FBi6UFNt3vo9c6ZU7WJZGzz2VnSvwGoGMhpahIFdlg5H+qnEN1MFwkHYnE5
 Gt0c1pzWc9+RYT5+0w0toRSbVWsPMcxl76XmtpV/x0RIWmGFxbx9VQvnrQIuAJy4x4pYmzBwExx
 27eMFPBXuYMfkQF2ZQa8ajbxqA4xWveh3GNgdRyedVr/QPTBeoJzy7jcJCFGUbYuTrJ8Lb4uSyj
 q4TPx+mQ72auetV7OcRNryggipWE92KPNw+d9PJyH1CfKhRUNM9LPSCzgVhblVPCXvyoyhqsd/B
 DZOYtAYmCBkqbju0Tjo/LL/4NxVpgHjz9hD/kjBMQEaXl1kApkndwNcQOiRFeYuWePn8/RlA4q9
 yaQRSXH/Aa3CjyBp/ySenbvIzyOpLx2vn41wQUw7HsBimmYWx+eI+PO7vgZ7FbKQ==
X-Received: by 2002:a05:622a:5c9:b0:50d:9b4a:e6f with SMTP id
 d75a77b69052e-514a0a1e0f9mr183568921cf.1.1778545545501; 
 Mon, 11 May 2026 17:25:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-5148e85aa7csm7174181cf.28.2026.05.11.17.25.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 May 2026 17:25:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-132d631edaaso10193229c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778545544; x=1779150344;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ykOtn1C1nWRL5CNNYcN5Mi6bYTEKpGpuY6KraMmjQL0=;
 b=KHtmM2nfYQi+dOSx7rpX7ClAq2ONdxqt7CLezckgdi+cQ4LH/+sBBHNIPe1qF00MZq
 W9ikp7ReoU+Av5mCuJQBIYS6QRZ0bh23yDAhf1E5MGWGcDWc9/y/8NuAyMorO0peajSJ
 Sno6XKbaE9UrXaw2V4P2CHGyrN06ICktKTQ1g=
X-Received: by 2002:a05:7022:439b:b0:128:bae0:e03c with SMTP id
 a92af1059eb24-132a82ddf53mr6720926c88.30.1778545544123; 
 Mon, 11 May 2026 17:25:44 -0700 (PDT)
X-Received: by 2002:a05:7022:439b:b0:128:bae0:e03c with SMTP id
 a92af1059eb24-132a82ddf53mr6720907c88.30.1778545543471; 
 Mon, 11 May 2026 17:25:43 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327821fd00sm20395488c88.8.2026.05.11.17.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 17:25:43 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v2 1/5] drm/vmwgfx: Add some checks to
 vmw_cursor_plane_atomic_update
Date: Mon, 11 May 2026 17:27:48 -0700
Message-ID: <20260512002752.2826685-2-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
References: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index c46f17ba7236..cb7c4d33c1b1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -742,11 +742,17 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 			       struct drm_atomic_state *state)
 {
 	struct vmw_bo *bo;
-	struct drm_plane_state *new_state =
-		drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_state =
-		drm_atomic_get_old_plane_state(state, plane);
-	struct drm_crtc *crtc = new_state->crtc ?: old_state->crtc;
+	struct drm_plane_state *new_state;
+	struct drm_plane_state *old_state;
+
+	new_state = drm_atomic_get_new_plane_state(state, plane);
+	if (!new_state)
+		return;
+	old_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_crtc *crtc = new_state->crtc ? new_state->crtc :
+		(old_state ? old_state->crtc : NULL);
+	if (!crtc)
+		return;
 	struct vmw_private *dev_priv = vmw_priv(plane->dev);
 	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
-- 
2.54.0

