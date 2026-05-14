Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D73CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 22:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A246010F365;
	Thu, 14 May 2026 22:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="I3++2iTY";
	dkim-atps=neutral
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095C010E3AD
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:46:01 +0000 (UTC)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-c801912c903so4089565a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778798760; x=1779403560;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NFkor/7BR4k07o8lXTc1D6yTt/30c5FbZoDOoSls4Is=;
 b=f/GtJl5QqDaK31KiUDl7zimtNCWaiDEvlft3zKwwL6c4c0m1YC7JF5HsHFgK9hIkz2
 jfcs80/wfzRXTQQSKMX71Xc6/wDefLp9wQJAayQWcxpcaVD2Jue0ijEz8+KUGgx4dgSo
 Btv5uA0QfPr8jOrbvJQ0v2m1wCL0Olr6747FaO8m/LjYfLCl+p+y1ylOy847nRWPDUiI
 Jlf7T4Rt94OwieihshQx3wn/A7GjrYA+dIuubQ0rgCiO7RG+4S+GmQ991vb0YxYxabb7
 C3cXdM0Vj8RM4InEbkpcLo3qbcaJuJHf22D3zMPibxZe6soafbJ01uPYM9CXp/0UbomU
 yQIw==
X-Gm-Message-State: AOJu0Yx/lgGHiWDenxrBG3zajgB+1JFkdHdOSIxcQQI58sXES0g9bDeB
 qU7P6W10ow0zbcFdBkt7XcQ8MUtcsrJ0y7Pa4LNQMlpC/KsQ6sOqnvTTJGFImq0YoPEkcYE5wg1
 HbelnKqS0yBZ3FfaCrv3n5i8w3wBKZXPgvv0rJ4+hWF5E1uRPIJQXjPk82xMkPxhXnEymnQ3HLs
 YFK3TDMqjFBl2veb7pfDoBRe5ohBCOXr2byRkswcFOYkhw5AjxXFKUCskmJz9960W60RmNVGGES
 zN7ik/7fljNcCU0Ngfn6gQXgffb2aY=
X-Gm-Gg: Acq92OF9jaEVqIiUgZQtybAeNS/dXVJWWioq40m075zxeo5dWKN/AvT1u1N2Do+nAoF
 Pmp0BqjFolSE9L2x+G2qRCLLjSogaasqY1W7COT/LBwTuauRDcnx27o6wV20E9sRLrkB1O8Ega9
 WWOjiGz96/CBhPmYrUlRTexrg86LEQ+hfE0bDdRzLda1EC8OTBVSsahcqm+0+q2vAQhrhzgMVU8
 m3fhOp0bwQxahdNK0vGnlvr8rGMzwrCwphdYQK49OwkvQv54cPHMYlG1FJ/TvvfDYlI0YH1/3NA
 LNAZ0LpfSpNykbVHhYHGytjK2S/y5fVJsf2LYFRNx9RKzz9paCy6pm77nfPMtTQS+8SHn7lzLSC
 Q0r4hHgXQiZcfjDeD8ObgRFpnkX9VdAdqNyDcIa/E7TyszJlZOhhZ13jlEZ/E4lNQUWiUkIBKla
 RJcA2yeptWwg==
X-Received: by 2002:a17:902:8689:b0:2b2:5258:a23d with SMTP id
 d9443c01a7336-2bd7e7dcb05mr10249585ad.14.1778798760337; 
 Thu, 14 May 2026 15:46:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2bd5bd694bbsm3092695ad.2.2026.05.14.15.46.00
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 May 2026 15:46:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f5943ca81aso17689845eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778798758; x=1779403558;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NFkor/7BR4k07o8lXTc1D6yTt/30c5FbZoDOoSls4Is=;
 b=I3++2iTYX/aXyurTZvYJjbi2Be204aRDNejq2/D4j0t8ZDJiUHAeKDdQPyGbh9bhjO
 OOhdQlHXM9HI4zcjFnuZX1w9BUM2w0lNvwRhoiZvngJFdiwbxAlWYQtj/UYi4c1NLbx+
 /f/Iy2A2TT/6i942uQ4Oo2cak8GvJVVSEI0Rs=
X-Received: by 2002:a05:7022:1e11:b0:12d:ff1b:92f5 with SMTP id
 a92af1059eb24-1350484ce0emr551958c88.28.1778798758353; 
 Thu, 14 May 2026 15:45:58 -0700 (PDT)
X-Received: by 2002:a05:7022:1e11:b0:12d:ff1b:92f5 with SMTP id
 a92af1059eb24-1350484ce0emr551942c88.28.1778798757664; 
 Thu, 14 May 2026 15:45:57 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbdcf140sm6678737c88.5.2026.05.14.15.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 15:45:57 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v3 1/5] drm/vmwgfx: Add some checks to
 vmw_cursor_plane_atomic_update
Date: Thu, 14 May 2026 15:48:15 -0700
Message-ID: <20260514224819.3631763-2-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
References: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
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

