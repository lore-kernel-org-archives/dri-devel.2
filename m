Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C544ACD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 22:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2244510F428;
	Thu, 21 May 2026 22:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="axJqb5tK";
	dkim-atps=neutral
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE4B10F422
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 22:35:03 +0000 (UTC)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2b9fcf7c91bso71750255ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779402903; x=1780007703;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZTGRhn0in/8d3GZnh1/366N/c2uQzs6YLBlEUo9ymc=;
 b=Wn3SFut5+bNLcU2oRYLTkCNzp6BFzF2s1GZRCktMdWUYioGkd86L4CHqUAZqPrvxVf
 cCD8n/zlmiSEH3bL9ZTL9nYmd2xBEjKe5KyxVSHcGbI0lwwEcIfymuttGwjcZlem/XW1
 ET3J/KaK3bPINlZRHG8UoykfxdjBwSU/7ujVCqI1slZPc1dZ8wj8AOrCpMkxm9YaHrA5
 cdJTK3fPpIfYSwwXqrxt+Ca52WWC1aREjp8a/PsCW1OomV2uRWBEGLKVLhWa63kr0jPe
 NPF038dwSPb3XKr9PkhSQGudyMHBRJ7FoUGwoxIBcUlc8eVLADTch0uD3QA6kGVOSK6Q
 ZjNw==
X-Gm-Message-State: AOJu0Yx6xZMhIBAURfbKpY2Eoz+7blaHMYp7EoGFuqLlfjOB2t/Sd6tx
 H9TLWHLhS33V+FVQ1H9/FZZe+sF5u+q0x4C3wtLLCBrww1iLGDhsjoyoRW+r+uUxoos9o+ha4dE
 EPCt4aEXVH0p1YN12x9EQq3ujniZe9nLwnNJMKL9LA0zl+Q8xFaZ0fel6P5vI8CMP29icKMRBQW
 2xE3knsb2xq9M/Gswoo4PeDs3dZ8Ijf9o0mgEGVxwnlB2QdEldJrmv0DBfJGRgoUvQA8PwBFw9i
 Xnxx+ePCLWZ3aecHrbT2AMF5M8y
X-Gm-Gg: Acq92OHUdsDEAGgXIYY2/cpUQclp/epQEPSNSSdvmdkTP6G6VzcdKLCJ9MefpAef//u
 oOf4tqhtvFxYL+SUpjDRvpQ+Ntg566dt/tKycWr1XV/MKNl7JXzVAKVC6TrmfLt8TLkMtfr7EVF
 k7BZP0G8j7jFyBf7Kn3Xvkai8yvvb6rotNGwQf4A3oxu+nUK7NPkxdJJVYR5Gd/AIW48KTTwO/x
 9OQ3E/OwB2ehpyFzgXGPZDi0eR+V5r3haQ+i2053ztOzKvXOuxxB/MAxg3Yap7r/KBvaBfKMuY7
 zOdvzT1IBZf/7p6adUKU7Sax4xetLU9YEeAMO5UMf7YncYes9pVcFZLkmPZs4W1NqBl8Fu9wcjB
 5lKOxG3rj3GshlhPlheMp9Tc0XTHVtWTVQ7Eu318IgqtzNsAg/jH7cP35TLoyun+qy1fE5/Tjri
 vthJqykEj0enouW42k1Dd3wgekvWstpg/7QfsBYnsYF5m1xRZlwJPhVdJ0IyDhqw==
X-Received: by 2002:a17:903:32ce:b0:2bd:eeb6:ff1b with SMTP id
 d9443c01a7336-2beb0390f7dmr9100205ad.4.1779402903274; 
 Thu, 21 May 2026 15:35:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2beb1170b13sm339475ad.51.2026.05.21.15.35.03
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2026 15:35:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516d58f74b0so3247101cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779402902; x=1780007702;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rZTGRhn0in/8d3GZnh1/366N/c2uQzs6YLBlEUo9ymc=;
 b=axJqb5tKrGGEQ2w+BgmkL0ARPF9kXm3h3czcCluAxRB5HMSFI+fs4Vej5sxOhAJwBT
 H9agShoSIVto7hNKumZbQrqtsH2Z3M0MEsg8sgmoWZ9VZLHpxjqCsbkxDJyk4bELy79g
 GjjPdPSw16tdzkQfMG5dUDvXpzhYGNNiihFnc=
X-Received: by 2002:a05:622a:4207:b0:516:c8d8:9a27 with SMTP id
 d75a77b69052e-516d429354emr22309181cf.8.1779402902308; 
 Thu, 21 May 2026 15:35:02 -0700 (PDT)
X-Received: by 2002:a05:622a:4207:b0:516:c8d8:9a27 with SMTP id
 d75a77b69052e-516d429354emr22308531cf.8.1779402901701; 
 Thu, 21 May 2026 15:35:01 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d6438582sm3351451cf.19.2026.05.21.15.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:35:01 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v4 1/4] drm/vmwgfx: Add some checks to
 vmw_cursor_plane_atomic_update
Date: Thu, 21 May 2026 15:37:53 -0700
Message-ID: <20260521223756.627311-2-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521223756.627311-1-maaz.mombasawala@broadcom.com>
References: <20260521223756.627311-1-maaz.mombasawala@broadcom.com>
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

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index b010fc7ca68e..583115c94800 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -742,11 +742,17 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 			       struct drm_atomic_commit *state)
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
+	struct drm_crtc *crtc =  new_state->crtc ? new_state->crtc :
+		(old_state ? old_state->crtc : NULL);
+	if (!crtc)
+		return;
 	struct vmw_private *dev_priv = vmw_priv(plane->dev);
 	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
-- 
2.54.0

